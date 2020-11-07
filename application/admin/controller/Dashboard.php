<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use fast\Date;
use think\Config;

/**
 * 控制台
 *
 * @icon fa fa-dashboard
 * @remark 用于展示当前系统中的统计数据、统计报表及重要实时数据
 */
class Dashboard extends Backend
{

    private $uid = 0;

    public function _initialize()
    {
        parent::_initialize();
        $this->uid = $this->auth->getUserInfo()['id'];
    }

    /**
     * 查看
     */
    public function index()
    {
        $device = model('TrafficUserDevice');
        $in = ['online', 'wait_handshake'];
        if ($this->auth->isSuperAdmin()) {
            $r = $device->query('SELECT SUM(today_95) AS ts, SUM(month_95) AS mt, SUM(up_month_95) AS ut FROM fa_traffic_user_devices')[0];
            $this->view->assign([
                'total_user' => model('Admin')->where(['status' => 'normal'])->count('id'),
                'total_device' => $device->count('id'),
                'total_device_online' => $device->where(['status_device' => ['in', $in]])->count('id'),
                'total_device_review' => $device->where(['status_review' => ['neq', 'pass']])->count('id'),
                'count' => $r,
                'model' => $device,
            ]);
        } else {
            $r = $device->query('SELECT SUM(today_95) AS ts, SUM(month_95) AS mt, SUM(up_month_95) AS ut FROM fa_traffic_user_devices WHERE user_id = ' . $this->uid)[0];
            $this->view->assign([
                'total_user' => 1,
                'total_device' => $device->where(['user_id' => $this->uid])->count('id'),
                'total_device_online' => $device->where(['status_device' => ['in', $in],'user_id' => $this->uid])->count('id'),
                'total_device_review' => $device->where(['status_review' => ['neq', 'pass'],'user_id' => $this->uid])->count('id'),
                'count' => $r,
                'model' => $device,
            ]);
        }

        return $this->view->fetch();
    }

}
