<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use fast\Date;
use think\Config;
use think\Db;
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
            $c_et = date('Y-m-t', time() - 86400);
            $this->view->assign([
                'total_user' => model('Admin')->where(['status' => 'normal'])->count('id'),
                'total_device' => $this->model->count('id'),
                'total_device_online' => $this->model->where(['status_device' => ['in', $in]])->count('id'),
                'total_device_review' => $this->model->where(['status_review' => ['neq', 'pass']])->count('id'),
                'up_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $u_st . '", "' . $u_et . '", "iqiyi", 0)')[0][0],
                'up_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $u_st . '", "' . $u_et . '", "iqiyi", 0)')[0][0],
                'cur_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $c_st . '", "' . $c_et . '", "iqiyi", 0)')[0][0],
                'cur_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $c_st . '", "' . $c_et . '", "iqiyi", 0)')[0][0],
                'sys_up_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $u_st . '", "' . $u_et . '", "system_ware", 0)')[0][0],
                'sys_up_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $u_st . '", "' . $u_et . '", "system_ware", 0)')[0][0],
                'sys_cur_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $c_st . '", "' . $c_et . '", "system_ware", 0)')[0][0],
                'sys_cur_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $c_st . '", "' . $c_et . '", "system_ware", 0)')[0][0],
                'model' => $this->model,
            ]);
        } else {
            $in = ['online', 'wait_handshake'];
            $timestamp = $this->model->up_time_stamp();
            $u_st = date('Y-m-01', $timestamp);
            $u_et = date('Y-m-t', $timestamp);
            $c_st = date('Y-m-01');
            $c_et = date('Y-m-t', time() - 86400);
            $this->view->assign([
                'total_user' => 1,
                'total_device' => $this->model->where(['user_id' => $this->uid])->count('id'),
                'total_device_online' => $this->model->where(['status_device' => ['in', $in], 'user_id' => $this->uid])->count('id'),
                'total_device_review' => $this->model->where(['status_review' => ['neq', 'pass'], 'user_id' => $this->uid])->count('id'),
                'up_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $u_st . '", "' . $u_et . '", "iqiyi", ' . $this->uid . ')')[0][0],
                'up_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $u_st . '", "' . $u_et . '", "iqiyi", ' . $this->uid . ')')[0][0],
                'cur_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $c_st . '", "' . $c_et . '", "iqiyi", ' . $this->uid . ')')[0][0],
                'cur_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $c_st . '", "' . $c_et . '", "iqiyi", ' . $this->uid . ')')[0][0],
                'sys_up_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $u_st . '", "' . $u_et . '", "system_ware", ' . $this->uid . ')')[0][0],
                'sys_up_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $u_st . '", "' . $u_et . '", "system_ware", ' . $this->uid . ')')[0][0],
                'sys_cur_countDL' => $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $c_st . '", "' . $c_et . '", "system_ware", ' . $this->uid . ')')[0][0],
                'sys_cur_countYD' => $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $c_st . '", "' . $c_et . '", "system_ware", ' . $this->uid . ')')[0][0],
                'model' => $this->model,
            ]);
        }

        return $this->view->fetch();
    }

    public function count_dl()
    {
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            $table = 'fa_traffic_network_counts_dxlt';
            $where = [];
            if ($this->auth->isSuperAdmin()) {
                $table .= '_user';
                $where[] = ['user_id', 'EQ', $this->uid];
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams(null, null, $where);
            $list = $this->model->table($table)->where($where)->order($sort, $order)->paginate($limit);
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
            $table = 'fa_traffic_network_counts_yd';
            $where = [];
            if ($this->auth->isSuperAdmin()) {
                $table .= '_user';
                $where[] = ['user_id', 'EQ', $this->uid];
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams(null, null, $where);
            $list = $this->model->table($table)->where($where)->order($sort, $order)->paginate($limit);
            $result = array("total" => $list->total(), "rows" => $list->items());
            return json($result);
        }
    }

    public function get_chart_speed_data($src, $st, $et)
    {
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
        if ($this->auth->isSuperAdmin()) {
            $rows = $this->model->query('SELECT `year_month`, max(count_y_u) AS speed FROM `fa_traffic_network_counts_dxlt` WHERE `source` = "' . $src . '" AND `year_month` BETWEEN "' . $st . '" AND "' . $et . '" GROUP BY `year_month`');
        } else {
            $rows = $this->model->query('SELECT `year_month`, max(count_y_u) AS speed FROM `fa_traffic_network_counts_dxlt_user` WHERE `user_id` = ' . $this->uid . ' AND `source` = "' . $src . '" AND `year_month` BETWEEN "' . $st . '" AND "' . $et . '" GROUP BY `year_month`');
        }
        if (!$rows) {
            return '{"status": false, "code": 102, "msg": "无数据列表"}';
        }
        $rets = ['status' => true, 'code' => 0];
        foreach ($rows as $k => $row) {
            $rets['ret']['xAxis'][] = explode('-', $row['year_month'], 2)[1];
            $rets['ret']['data'][0][] = $row['speed'];
        }
        if ($this->auth->isSuperAdmin()) {
            $rows = $this->model->query('SELECT `year_month`, max(count_y_u) AS speed FROM `fa_traffic_network_counts_yd` WHERE `source` = "' . $src . '" AND `year_month` BETWEEN "' . $st . '" AND "' . $et . '" GROUP BY `year_month`');
        } else {
            $rows = $this->model->query('SELECT `year_month`, max(count_y_u) AS speed FROM `fa_traffic_network_counts_yd_user` WHERE `user_id` = ' . $this->uid . ' AND `source` = "' . $src . '" AND `year_month` BETWEEN "' . $st . '" AND "' . $et . '" GROUP BY `year_month`');
        }
        if (!$rows) {
            return '{"status": false, "code": 102, "msg": "无数据列表"}';
        }
        foreach ($rows as $k => $row) {
            $rets['ret']['data'][1][] = $row['speed'];
        }
        if ($this->auth->isSuperAdmin()) {
            $rows = $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $st . '", "' . $et . '", "' . $src . '", 0)');
        } else {
            $rows = $this->model->query('CALL NETWORK_ALL_COUNT_95("dx", "' . $st . '", "' . $et . '", "' . $src . '", ' . $this->uid . ')');
        }
        if ($rows) {
            $row = $rows[0][0];
            if ($row['get_id'] > 0) {
                $dt = explode(" ", $row['log_datetime'], 2)[0];
                $dt = explode("-", $dt, 2)[1];
                $rets['ret']['posi'][0]['date'] = $dt;
                $rets['ret']['posi'][0]['speed'] = $row['speed'];
            } else {
                $rets['ret']['posi'][0]['date'] = "-";
                $rets['ret']['posi'][0]['speed'] = 0;
            }
        }
        if ($this->auth->isSuperAdmin()) {
            $rows = $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $st . '", "' . $et . '", "' . $src . '", 0)');
        } else {
            $rows = $this->model->query('CALL NETWORK_ALL_COUNT_95("yd", "' . $st . '", "' . $et . '", "' . $src . '", ' . $this->uid . ')');
        }
        if ($rows) {
            $row = $rows[0][0];
            if ($row['get_id'] > 0) {
                $dt = explode(" ", $row['log_datetime'], 2)[0];
                $dt = explode("-", $dt, 2)[1];
                $rets['ret']['posi'][1]['date'] = $dt;
                $rets['ret']['posi'][1]['speed'] = $row['speed'];
            } else {
                $rets['ret']['posi'][1]['date'] = "-";
                $rets['ret']['posi'][1]['speed'] = 0;
            }
        }
        $rets['ret']['date'] = $st . ' ~ ' . $et;
        echo json_encode($rets);
    }

    public function get_chart_speed_date_detail($src, $st)
    {
        if ($st == '') {
            $st = date('Y-m');
        } else {
            $st = strtotime(date("Y") . "-" . $st);
            if ($st == 0) {
                return '{"status": false, "code": 102, "msg": "时间格式不正确"}';
            }
            $st = date("Y-m-d", $st);
        }
        if ($this->auth->isSuperAdmin()) {
            $rows = $this->model->query('SELECT count_y_u, log_upload_time FROM `fa_traffic_network_counts_dxlt` WHERE `source` = "' . $src . '" AND `year_month` = "' . $st . '" ORDER BY log_upload_time ASC');
        } else {
            $rows = $this->model->query('SELECT count_y_u, log_upload_time FROM `fa_traffic_network_counts_dxlt_user` WHERE `user_id` = ' . $this->uid . ' AND `source` = "' . $src . '" AND `year_month` = "' . $st . '" GROUP BY log_upload_time ASC');
        }
        if (!$rows) {
            return '{"status": false, "code": 102, "msg": "无数据列表"}';
        }
        $rets = ['status' => true, 'code' => 0];
        foreach ($rows as $k => $row) {
            $t = explode(":", explode(" ", $row['log_upload_time'], 2)[1], 3);
            $rets['ret']['xAxis'][] = $t[0] . ":" . $t[1];
            $rets['ret']['data'][0][] = $row['count_y_u'];
        }
        if ($this->auth->isSuperAdmin()) {
            $rows = $this->model->query('SELECT count_y_u, log_upload_time FROM `fa_traffic_network_counts_yd` WHERE `source` = "' . $src . '" AND `year_month` = "' . $st . '" ORDER BY log_upload_time ASC');
        } else {
            $rows = $this->model->query('SELECT count_y_u, log_upload_time FROM `fa_traffic_network_counts_yd_user` WHERE `user_id` = ' . $this->uid . ' AND `source` = "' . $src . '" AND `year_month` = "' . $st . '" GROUP BY log_upload_time ASC');
        }
        if (!$rows) {
            return '{"status": false, "code": 102, "msg": "无数据列表"}';
        }
        foreach ($rows as $k => $row) {
            $rets['ret']['data'][1][] = $row['count_y_u'];
        }
        if ($this->auth->isSuperAdmin()) {
            $rows = $this->model->query('SELECT count_y_u, log_upload_time FROM `fa_traffic_network_counts_dxlt` WHERE `source` = "' . $src . '" AND `year_month` = "' . $st . '" ORDER BY count_y_u DESC LIMIT 14, 1');
        } else {
            $rows = $this->model->query('SELECT count_y_u, log_upload_time FROM `fa_traffic_network_counts_dxlt_user` WHERE `user_id` = ' . $this->uid . ' AND `source` = "' . $src . '" AND `year_month` = "' . $st . '" ORDER BY count_y_u DESC LIMIT 14, 1');
        }
        if ($rows) {
            $row = $rows[0];
            if ($row['log_upload_time']) {
                $t = explode(":", explode(" ", $row['log_upload_time'], 2)[1], 3);
                $rets['ret']['posi'][0]['date'] = $t[0] . ":" . $t[1];
                $rets['ret']['posi'][0]['speed'] = $row['count_y_u'];
            } else {
                $rets['ret']['posi'][0]['date'] = ":";
                $rets['ret']['posi'][0]['speed'] = 0;
            }
        }
        if ($this->auth->isSuperAdmin()) {
            $rows = $this->model->query('SELECT count_y_u, log_upload_time FROM `fa_traffic_network_counts_yd` WHERE `source` = "' . $src . '" AND `year_month` = "' . $st . '" ORDER BY count_y_u DESC LIMIT 14, 1');
        } else {
            $rows = $this->model->query('SELECT count_y_u, log_upload_time FROM `fa_traffic_network_counts_yd_user` WHERE `user_id` = ' . $this->uid . ' AND `source` = "' . $src . '" AND `year_month` = "' . $st . '" ORDER BY count_y_u DESC LIMIT 14, 1');
        }        if ($rows) {
            $row = $rows[0];
            if ($row['log_upload_time']) {
                $t = explode(":", explode(" ", $row['log_upload_time'], 2)[1], 3);
                $rets['ret']['posi'][1]['date'] = $t[0] . ":" . $t[1];
                $rets['ret']['posi'][1]['speed'] = $row['count_y_u'];
            } else {
                $rets['ret']['posi'][1]['date'] = ":";
                $rets['ret']['posi'][1]['speed'] = 0;
            }
        }
        $rets['ret']['date'] = $st;
        echo json_encode($rets);
    }

    public function add_iqiyi_devices($devs)
    {
        echo $this->model->ServiceAddIqiyiDevices($devs);
    }

    public function get_task_logs($name)
    {
        echo $this->model->ServiceGetTaskLogs($name);
    }

    public function iqiyi_collect($devs)
    {
        echo $this->model->ServiceIqiyiCollect($devs);
    }

    public function iqiyi_collect_all()
    {
        echo $this->model->ServiceIqiyiCollectAll();
    }

    public function daily_network_count($date, $src)
    {
        echo $this->model->ServiceDailyNetworkCount($date, $src);
    }

    public function daily_network_count95($type, $date)
    {
        echo $this->model->ServiceDailyNetworkCount95($type, $date);
    }

    public function reset_device_count()
    {
        echo $this->model->ServiceResetDeviceCount();
    }
}
