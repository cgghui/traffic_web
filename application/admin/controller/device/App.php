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
    protected $ModelDevice = null;
    private $uid = 0;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('TrafficUserApp');
        $this->ModelDevice = model('TrafficUserDevice');
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
                $params['created_at'] = $t;
                $params['updated_at'] = $t;
                model('TrafficUserApp')->save($params);
                $this->success();
            }
            $this->error();
        }
        $this->user_list_html();
        return $this->view->fetch();
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
                $r = $this->model->allowField(true)->isUpdate(true, ['id' => $row['id']])->save(['deleted_at' => Db::raw('NOW()')]);
                if ($r) {
                    $result = $this->ModelDevice->ServiceConnectCloseByApp($row['id']);
                    if (!$result) {
                        $ret[$row['id']] = 'successful but close connect failed';
                    } else {
                        $ret[$row['id']] = 'successful';
                    }
                } else {
                    $ret[$row['id']] = 'failure';
                }
            }
            $this->success("ok", null, $ret);
        }
        $this->error(__('Parameter %s can not be empty', 'ids'));
    }

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