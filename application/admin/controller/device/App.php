<?php

namespace app\admin\controller\device;

use app\admin\model\TrafficUserDevice;
use app\admin\model\Admin;
use app\common\controller\Backend;
use think\Db;

/**
 * 设备管理
 *
 */
class App extends Backend
{

    protected $model = null;
    private $uid = 0;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('TrafficUserApp');
        $this->uid = $this->auth->getUserInfo()['id'];
    }

    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            $where = [];
            if ($this->auth->isSuperAdmin() == false) {
                $where[] = ['user_id', 'EQ', $this->uid];
            }
            $where[] = ['deleted_at', 'EXP', 'IS NULL'];
            list($where, $sort, $order, $offset, $limit) = $this->buildparams(null, null, $where);
            $list = $this->model->where($where)->order($sort, $order)->paginate($limit);
            $result = array("total" => $list->total(), "rows" => $list->items());
            return json($result);
        }
        return $this->view->fetch();
    }

    public function get_username($user_ids) {
        $m = model('Admin');
        if ($this->auth->isSuperAdmin()) {
            $r = $m->where(['id' => ['IN', explode(',', $user_ids)]])->column('id,username');
        } else {
            $r = $m->where(['id' => $this->uid])->column('id,username');
        }
        echo json_encode($r);
    }

    public function get_online_device($ids) {
        print_r(model('TrafficUserDevice')->ServiceGetOnlineDevice(explode(',', $ids)));
    }

    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $this->token();
            $params = $this->request->post("row/a");
            if ($params) {
                if ($this->auth->isSuperAdmin()) {
                    if (!$params['user_id']) {
                        $this->error('请选取要绑定的会员');
                    }
                } else {
                    $params['user_id'] = $this->uid;
                }
                $t = date('Y-m-d H:i:s');
                $data = TrafficUserDevice::GetIpAddress($params['ip']);
                $params['ip_address'] = $data['addr'];
                $params['isp'] = $data['isp'];
                $params['disk_uuid'] = '';
                $params['status_review'] = 'waiting';
                $params['status_device'] = 'wait_handshake';
                $params['created_at'] = $t;
                $params['updated_at'] = $t;
                model('TrafficUserDevice')->save($params);
                $this->success();
            }
            $this->error();
        }
        $this->user_list_html();
        return $this->view->fetch();
    }

    /**
     * 编辑
     */
    public function edit($ids = null)
    {
        if ($this->auth->isSuperAdmin()) {
            $row = $this->model->get(['id' => $ids]);
        } else {
            $row = $this->model->get(['id' => $ids, 'user_id' => $this->uid]);
        }
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $row['rejected_reason'] = '';
        if ($row['status_review'] == 'rejected') {
            $data = $this->model_log->where(['device_id' => $row['id'], 'status' => 'rejected'])->order('report_datetime DESC')->find();
            if ($data) {
                $row['rejected_reason'] = $data['message'];
            }
        }
        $row['status_note'] = '';
        if ($row['status_device'] == 'abnormal' || $row['status_device'] == 'lock') {
            $data = $this->model_log->where(['device_id' => $row['id'], 'status' => ['abnormal', 'lock']])->order('report_datetime DESC')->find();
            if ($data) {
                $row['status_note'] = $data['message'];
            }
        }
        if ($this->request->isPost()) {
            $this->token();
            $params = $this->request->post('row/a');
            if ($params) {
                foreach ($params as $f => $v) {
                    if ($row[$f] == $v) {
                        unset($params[$f]);
                        continue;
                    }
                    if ($f == 'disk_uuid' || $f == 'created_at' || $f == 'updated_at') {
                        unset($params[$f]);
                        continue;
                    }
                }
                // 非管理员不可设置设备所属账号
                if (isset($params['user_id']) && $params['user_id'] && $this->auth->isSuperAdmin() == false) {
                    unset($params['user_id']);
                }
                if (isset($params['ip']) && $params['ip']) {
                    $data = TrafficUserDevice::GetIpAddress($params['ip']);
                    $params['ip_address'] = $data['addr'];
                    $params['isp'] = $data['isp'];
                }
                Db::startTrans();
                if ($this->auth->isSuperAdmin()) {
                    if (isset($params['status_review']) && $params['status_review']) {
                        if ($params['status_review'] == 'rejected') {
                            $reason = $this->request->post('rejected_reason');
                            if (!$reason) {
                                $this->error('请输入驳回原因');
                            }
                            $r = $this->model_log->save([
                                'user_id' => $this->uid,
                                'device_id' => $row['id'],
                                'status' => 'rejected',
                                'message' => $reason,
                                'report_date' => Db::raw('NOW()'),
                                'report_datetime' => Db::raw('NOW()')
                            ]);
                            if (!$r) {
                                Db::rollback();
                                $this->error('驳回记录添加失败');
                            }
                        }
                    }
                    if (isset($params['status_device']) && $params['status_device']) {
                        if ($params['status_device'] == 'abnormal' || $params['status_device'] == 'lock') {
                            $note = $this->request->post('status_note');
                            if (!$note) {
                                $this->error('请输入状态备注');
                            }
                            $r = $this->model_log->save([
                                'user_id' => $this->uid,
                                'device_id' => $row['id'],
                                'status' => $params['status_device'],
                                'message' => $note,
                                'report_date' => ['exp', 'NOW()'],
                                'report_datetime' => ['exp', 'NOW()']
                            ]);
                            if (!$r) {
                                Db::rollback();
                                $this->error('状态备注添加失败');
                            }
                        }
                    }
                }
                if ($params) {
                    if ($this->auth->isSuperAdmin() == false) {
                        $p = ['ip', 'ssh_port', 'ssh_username', 'ssh_password', 'ssh_connect_method'];
                        foreach ($params as $k => $v) {
                            if (in_array($k, $p) == true) {
                                $params['status_review'] = 'waiting';
                                break;
                            }
                        }
                    }
                    $params['updated_at'] = Db::raw('NOW()');
                    $r = $this->model->allowField(true)->isUpdate(true, ['id' => $row['id']])->save($params);
                    if (!$r) {
                        Db::rollback();
                        $this->error('设备数据更新失败');
                    }
                }
                Db::commit();
                $this->success();
            }
            $this->error();
        }
        $this->view->assign("row", $row);
        $this->user_list_html($row['user_id']);
        return $this->view->fetch();
    }

    /**
     * 删除
     */
    public function del($ids = '')
    {
        if (!$this->request->isPost()) {
            $this->error(__("Invalid parameters"));
        }
        $ids = $ids ? $ids : $this->request->post('ids');
        if ($ids) {
            $ret = [];
            $list = (array)$this->model->where('id', 'in', $ids)->select();
            foreach ($list as $row) {
                if ($this->auth->isSuperAdmin() != true) {
                    if ($row['user_id'] != $this->uid) {
                        $ret[$row['id']] = 'no permission';
                        continue;
                    }
                }
                if ($row['status_device'] == 'online') {
                    $result = $this->model->ServiceConnectClose($row['disk_uuid']);
                    if (!$result) {
                        $ret[$row['id']] = 'close connection failed';
                        continue;
                    }
                }
                $r = $this->model->allowField(true)->isUpdate(true, ['id' => $row['id']])->save(['deleted_at' => Db::raw('NOW()')]);
                if ($r) {
                    $ret[$row['id']] = 'successful';
                } else {
                    $ret[$row['id']] = 'failure';
                }
            }
            $this->success("ok", null, $ret);
        }
        $this->error(__('Parameter %s can not be empty', 'ids'));
    }

    public function detail($ids)
    {
        if ($this->auth->isSuperAdmin()) {
            $row = $this->model->get(['id' => $ids]);
        } else {
            $row = $this->model->get(['id' => $ids, 'user_id' => $this->uid]);
        }
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $row['rejected_reason'] = '';
        if ($row['status_review'] == 'rejected') {
            $data = $this->model_log->where(['device_id' => $row['id'], 'status' => 'rejected'])->order('report_datetime DESC')->find();
            if ($data) {
                $row['rejected_reason'] = $data['message'];
            }
        }
        $row['status_note'] = '';
        if ($row['status_device'] == 'abnormal' || $row['status_device'] == 'lock') {
            $data = $this->model_log->where(['device_id' => $row['id'], 'status' => ['abnormal', 'lock']])->order('report_datetime DESC')->find();
            if ($data) {
                $row['status_note'] = $data['message'];
            }
        }
        $this->view->assign('row', $row->toArray());
        $this->view->assign('traffic', $this->model->NetworkCountByUUID($row['disk_uuid']));
        $this->view->assign('user', model('Admin')->get(['id' => $row['user_id']])->toArray());
        return $this->view->fetch();
    }

    /**
     * 前端用户列表
     */
    private function user_list_html($selected_ids = 0)
    {
        $column = ['-- 请选择 --'];
        foreach ((new Admin)->column('id, username, mobile') as $i => $r) {
            $column[$i] = $r['username'];
            if ($r['mobile']) {
                $column[$i] .= ' (' . $r['mobile'] . ')';
            }
        }
        $this->view->assign('userList', build_select('row[user_id]', $column, [$selected_ids], ['class' => 'form-control selectpicker']));
    }

}