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
class Device extends Backend
{

    protected $model = null;
    protected $model_log = null;
    private $uid = 0;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('TrafficUserDevice');
        $this->model_log = model('TrafficUserDeviceLog');
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
                $params['source'] = 'system_ware';
                $params['ip_address'] = $data['addr'];
                $params['isp'] = $data['isp'];
                $params['status_review'] = 'waiting';
                $params['status_device'] = 'wait_handshake';
                $params['up_month_average'] = 0;
                $params['created_at'] = $t;
                $params['updated_at'] = $t;
                model('TrafficUserDevice')->save($params);
                $this->model->ServiceRefreshDeviceCache();
                $this->success();
            }
            $this->error();
        }
        $this->user_list_html();
        return $this->view->fetch();
    }

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
            $in = ['abnormal', 'lock', 'collect_fail'];
            $data = $this->model_log->where(['device_id' => $row['id'], 'status' => ['in', $in]])->order('report_datetime DESC')->find();
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
                $this->model->ServiceRefreshDeviceCache();
                $this->success();
            }
            $this->error();
        }
        $this->view->assign("row", $row);
        $this->user_list_html($row['user_id']);
        return $this->view->fetch();
    }

    public function get_up_traffic_average($uuid, $isp)
    {
        $ispT = [
            '电信' => 'fa_traffic_network_counts_95_dxlt',
            '移动' => 'fa_traffic_network_counts_95_yd',
            '联通' => 'fa_traffic_network_counts_95_dxlt',
        ];
        if (isset($ispT[$isp]) == false) {
            $this->error('不支持该运营商');
        }
        $timestamp = $this->model->up_time_stamp();
        $ym = date('Y-m', $timestamp);
        $st = $ym . '-01';
        $et = $ym . '-' . date('t', $timestamp);
        $r = $this->model->query('SELECT ROUND(AVG(speed_byte)) AS cnt FROM `' . $ispT[$isp] . '` WHERE `device_disk_uuid` = "' . $uuid . '" AND `year_month` BETWEEN "' . $st . '" AND "' . $et . '"')[0]['cnt'];
        echo json_encode(['total' => intval($r)]);
    }

    public function connect_ssh($id)
    {
        if ($this->auth->isSuperAdmin()) {
            $row = $this->model->get(['id' => $id]);
        } else {
            $row = $this->model->get(['id' => $id, 'user_id' => $this->uid]);
        }
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $result = $this->model->ServiceConnectSSH($row);
        if ($result['msg'] != 'successful') {
            $this->error($result['msg']);
        }
        $this->success();
    }

    public function is_online($uuid)
    {
        if ($this->auth->isSuperAdmin()) {
            $row = $this->model->get(['disk_uuid' => $uuid]);
        } else {
            $row = $this->model->get(['disk_uuid' => $uuid, 'user_id' => $this->uid]);
        }
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $result = $this->model->ServiceGetOnlineDevices();
        $isOnline = false;
        foreach ($result as $online) {
            if ($online['client_disk_uuid'] == $row['disk_uuid']) {
                $row->allowField(true)->isUpdate(true)->save(['status_device' => 'online']);
                $isOnline = true;
                break;
            }
        }
        if ($isOnline) {
            $this->success();
        } else {
            $this->error();
        }
    }

    public function connect_close($id)
    {
        if ($this->auth->isSuperAdmin()) {
            $row = $this->model->get(['id' => $id]);
        } else {
            $row = $this->model->get(['id' => $id, 'user_id' => $this->uid]);
        }
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $result = $this->model->ServiceConnectClose($row['disk_uuid']);
        if ($result) {
            $this->success();
        } else {
            $this->error();
        }
    }

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
            $this->model->ServiceRefreshDeviceCache();
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
            $in = ['abnormal', 'lock', 'collect_fail'];
            $data = $this->model_log->where(['device_id' => $row['id'], 'status' => ['in', $in]])->order('report_datetime DESC')->find();
            if ($data) {
                $row['status_note'] = $data['message'];
            }
        }
        $this->view->assign('row', $row->toArray());
        $this->view->assign('user', model('Admin')->get(['id' => $row['user_id']])->toArray());
        return $this->view->fetch();
    }

    public function chart_info($ids)
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
            $in = ['abnormal', 'lock', 'collect_fail'];
            $data = $this->model_log->where(['device_id' => $row['id'], 'status' => ['in', $in]])->order('report_datetime DESC')->find();
            if ($data) {
                $row['status_note'] = $data['message'];
            }
        }
        $this->view->assign('row', $row->toArray());
        $this->view->assign('user', model('Admin')->get(['id' => $row['user_id']])->toArray());
        return $this->view->fetch();
    }

    public function get_chart_speed_data($uuid, $isp, $st, $et)
    {
        $isp = trim($isp);
        if (in_array($isp, ['dx', 'lt', 'yd']) != true) {
            return '{"status": false, "code": 100, "msg": "运营商只能为：dx、lt、yd"}';
        }
        $where['disk_uuid'] = ['EQ', $uuid];
        $where['deleted_at'] = ['EXP', Db::raw('IS NULL')];
        if ($this->auth->isSuperAdmin() == false) {
            $where['user_id'] = ['EQ', $this->uid];
        }
        $dev = $this->model->where($where)->find();
        if (!$dev) {
            return '{"status": false, "code": 101, "msg": "设备不存在或无权访问"}';
        }
        if ($st == '' || $et == '') {
            $st = date('Y-m') . '-01';
            $et = date('Y-m-d', time() - 86400);
        } else {
            $st = strtotime($st);
            $et = strtotime($et);
            if ($st == 0 || $et == 0) {
                return '{"status": false, "code": 102, "msg": "时间格式不正确"}';
            }
            if ($st > $et) {
                return '{"status": false, "code": 103, "msg": "开始时间不可大于结束时间"}';
            }
            $st = date("Y-m-d", $st);
            $et = date("Y-m-d", $et);
        }
        $tn = 'fa_traffic_network_counts_95_';
        if ($isp == 'dx' || $isp == 'lt') {
            $tn .= 'dxlt';
        } else {
            $tn .= 'yd';
        }
        $rows = $this->model->query('SELECT `year_month`,speed_byte FROM `' . $tn . '` WHERE device_disk_uuid = "' . $uuid . '" AND `year_month` BETWEEN "' . $st . '" AND "' . $et . '" ORDER BY `year_month` ASC');
        if (!$rows) {
            return '{"status": false, "code": 102, "msg": "无数据列表"}';
        }
        $rets = ['status' => true, 'code' => 0];
        foreach ($rows as $k => $row) {
            $rets['ret']['xAxis'][] = explode("-", $row['year_month'], 2)[1];
            $rets['ret']['data'][0][] = $row['speed_byte'];
            $cnt = $this->model->query('SELECT count_y_u AS cnt FROM `fa_traffic_network_logs` WHERE device_disk_uuid = "' . $uuid . '" AND `log_date` = "' . $row['year_month'] . '" ORDER BY count_y_u DESC LIMIT 1');
            if ($cnt) {
                $rets['ret']['data'][1][] = (int)$cnt[0]['cnt'];
            } else {
                $rets['ret']['data'][1][] = 0;
            }
        }
        $rows = $this->model->query('CALL NETWORK_CDN_COUNT_95("' . $uuid . '", "' . $st . '", "' . $et . '")');
        $rets['ret']['posi']['date'] = "-";
        $rets['ret']['posi']['speed'] = 0;
        if ($rows) {
            $row = $rows[0][0];
            if ($row['total'] > 0) {
                $rets['ret']['posi']['date'] = explode("-", $row['posi_date'], 2)[1];
                $rets['ret']['posi']['speed'] = $row['traffic'];
            }
        }
        echo json_encode($rets);
    }

    public function get_chart_speed_date_detail($uuid, $st)
    {
        $where['disk_uuid'] = ['EQ', $uuid];
        $where['deleted_at'] = ['EXP', Db::raw('IS NULL')];
        if ($this->auth->isSuperAdmin() == false) {
            $where['user_id'] = ['EQ', $this->uid];
        }
        $dev = $this->model->where($where)->find();
        if (!$dev) {
            return '{"status": false, "code": 101, "msg": "设备不存在或无权访问"}';
        }
        if ($st == '') {
            $st = date('Y-m-d');
        } else {
            $st = strtotime(date("Y") . "-" . $st);
            if ($st == 0) {
                return '{"status": false, "code": 102, "msg": "时间格式不正确"}';
            }
            $st = date("Y-m-d", $st);
        }
        $rows = $this->model->query('SELECT count_y_u, log_upload_time FROM `fa_traffic_network_logs` WHERE device_disk_uuid = "' . $uuid . '" AND log_date = "' . $st . '" AND log_upload_time IS NOT NULL ORDER BY log_upload_time ASC');
        if (!$rows) {
            return '{"status": false, "code": 102, "msg": "无数据列表"}';
        }
        $rets = ['status' => true, 'code' => 0];
        foreach ($rows as $k => $row) {
            $t = explode(":", explode(" ", $row['log_upload_time'], 2)[1], 3);
            $rets['ret']['xAxis'][] = $t[0] . ":" . $t[1];
            $rets['ret']['data'][] = $row['count_y_u'];
        }
        $rows = $this->model->query('SELECT count_y_u, log_upload_time FROM `fa_traffic_network_logs` WHERE device_disk_uuid = "' . $uuid . '" AND log_date = "' . $st . '" ORDER BY count_y_u DESC LIMIT 14, 1');
        $rets['ret']['posi']['date'] = ":";
        $rets['ret']['posi']['speed'] = 0;
        if ($rows) {
            $row = $rows[0];
            if ($row['log_upload_time']) {
                $t = explode(":", explode(" ", $row['log_upload_time'], 2)[1], 3);
                $rets['ret']['posi']['date'] = $t[0] . ":" . $t[1];
                $rets['ret']['posi']['speed'] = $row['count_y_u'];
            }
        }
        echo json_encode($rets);
    }

    public function get_device_log($uuid, $date)
    {
        if ($this->auth->isSuperAdmin() == false) {
            $row = $this->model->get(['disk_uuid' => $uuid, 'user_id' => $this->uid]);
        } else {
            $row = $this->model->get(['disk_uuid' => $uuid]);
        }
        if (!$row) {
            echo '[]';
            return;
        }
        $result = [];
        $where = [
            'device_id' => $row['id'],
        ];
        if ($date == 'cur') {
            if ($_GET['st'] && $_GET['et']) {
                $date_f = $_GET['st'];
                $date_l = $_GET['et'];
            } else {
                $date_f = date('Y-m-01');
                $date_l = date('Y-m-d', strtotime($date_f . ' +1 month -1 day'));
            }
            $where['report_date'] = ['between', $date_f . ',' . $date_l];
        } else {
            $where['report_date'] = $date;
        }
        $fields = 'id,client_ip,status,message,report_datetime';
        foreach ($this->model_log->where($where)->order('report_datetime ASC')->column($fields) as $id => $row) {
            unset($row['id']);
            $result[] = $row;
        }
        echo json_encode($result);
    }

    public function get_device_pack_log($dev, $date, $time)
    {
        echo json_encode($this->model->ServiceDeviceLog($dev, $date, $time));
    }

    public function get_traffic_count($uuid, $date)
    {
        if ($this->auth->isSuperAdmin() == false) {
            $row = $this->model->get(['disk_uuid' => $uuid, 'user_id' => $this->uid]);
            if (!$row) {
                echo '{"Total":0,"Posi":0,"Traffic":"","Bad":99999}';
                return;
            }
        }
        if ($date == 'cur') {
            if ($_GET['st'] && $_GET['et']) {
                echo json_encode($this->model->Device_Network_CDN_Count_95($uuid, $_GET['st'], $_GET['et']));
            } else {
                $date = date('Y-m-d', strtotime(date('Y-m-01') . ' +1 month -1 day'));
                echo json_encode($this->model->Device_Network_CDN_Count_95($uuid, '', $date));
            }
        } else {
            echo json_encode($this->model->Device_Network_CDN_Count_95($uuid, $date, ''));
        }
    }

    /**
     * 获取设备 当天、当月、上月的95带宽速度
     * @param $uuid
     */
    public function get_traffic_device_count($uuid)
    {
        if ($this->auth->isSuperAdmin() == false) {
            $row = $this->model->get(['disk_uuid' => $uuid, 'user_id' => $this->uid]);
            if (!$row) {
                echo '{"Total":0,"Posi":0,"Traffic":"","Bad":99999}';
                return;
            }
        }
        $result = ['today' => [], 'month' => [], 'up_month' => []];
        $result['today'] = $this->model->Device_Network_CDN_Count_95($uuid, date('Y-m-d'), '');
        $result['month'] = $this->model->Device_Network_CDN_Count_95($uuid, '', date('Y-m-d'));
        $begin_time = date('Y-m-01', strtotime('-1 month'));
        $end_time = date("Y-m-d", strtotime(-date('d') . 'day'));
        $result['up_month'] = $this->model->Device_Network_CDN_Count_95($uuid, $begin_time, $end_time);
        echo json_encode($result);
    }

    /**
     * 获取取点数据
     * @param $uuid
     * @param $date
     */
    public function get_device_dot_log($uuid, $date)
    {
        if ($this->auth->isSuperAdmin() == false) {
            $row = $this->model->get(['disk_uuid' => $uuid, 'user_id' => $this->uid]);
            if (!$row) {
                echo '{"Total":0,"Posi":0,"Traffic":"","Bad":99999}';
                return;
            }
        }
        $m = model('TrafficNetworkLog');
        $w = ['device_disk_uuid' => $uuid, 'log_date' => $date];
        $f = 'id, count_y_d, count_y_u, log_upload_time';
        $result = [];
        foreach ($m->where($w)->order('log_upload_time ASC')->column($f) as $id => $row) {
            unset($row['id']);
            $result[] = $row;
        }
        echo json_encode($result);
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