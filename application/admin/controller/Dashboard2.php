<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use fast\Date;
use think\Config;
use think\db\exception\BindParamException;
use think\exception\PDOException;

/**
 * 控制台
 *
 * @icon fa fa-dashboard
 * @remark 用于展示当前系统中的统计数据、统计报表及重要实时数据
 */
class Dashboard2 extends Backend
{

    private $uid = 0;

    public function _initialize()
    {
        parent::_initialize();
        $this->uid = $this->auth->getUserInfo()['id'];
        $this->model = model('TrafficUserDevice');
    }

    /**
     * 查看
     */
    public function index()
    {
        if ($this->auth->isSuperAdmin()) {
            $in = ['online', 'wait_handshake'];
            $timestamp = $this->model->up_time_stamp();
            $u_st = date('Y-m-01', $timestamp);
            $u_et = date('Y-m-t', $timestamp);
            $c_st = date('Y-m-01');
            $c_et = date('Y-m-d', time() - 86400);
            $this->view->assign([
                'total_user' => model('Admin')->where(['status' => 'normal'])->count('id'),
                'total_device' => $this->model->count('id'),
                'total_device_online' => $this->model->where(['status_device' => ['in', $in]])->count('id'),
                'total_device_review' => $this->model->where(['status_review' => ['neq', 'pass']])->count('id'),
                'up_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $u_st . '", "' . $u_et . '", "iqiyi")')[0][0],
                'up_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $u_st . '", "' . $u_et . '", "iqiyi")')[0][0],
                'cur_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $c_st . '", "' . $c_et . '", "iqiyi")')[0][0],
                'cur_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $c_st . '", "' . $c_et . '", "iqiyi")')[0][0],
                'sys_up_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $u_st . '", "' . $u_et . '", "system_ware")')[0][0],
                'sys_up_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $u_st . '", "' . $u_et . '", "system_ware")')[0][0],
                'sys_cur_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $c_st . '", "' . $c_et . '", "system_ware")')[0][0],
                'sys_cur_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $c_st . '", "' . $c_et . '", "system_ware")')[0][0],
                'model' => $this->model,
            ]);
            return $this->view->fetch();
        }
    }

    public function count_dl()
    {
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams(null, null);
            $list = $this->model->table('fa_traffic_network_counts_dxlt')->where($where)->order($sort, $order)->paginate($limit);
            $result = array("total" => $list->total(), "rows" => $list->items());
            return json($result);
        }
    }

    public function count_yd()
    {
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams(null, null);
            $list = $this->model->table('fa_traffic_network_counts_yd')->where($where)->order($sort, $order)->paginate($limit);
            $result = array("total" => $list->total(), "rows" => $list->items());
            return json($result);
        }
    }

}
