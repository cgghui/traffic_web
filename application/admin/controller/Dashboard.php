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
        $seventtime = Date::unixtime('day', -7);
        $paylist = $createlist = [];
        for ($i = 0; $i < 7; $i++) {
            $day = date("Y-m-d", $seventtime + ($i * 86400));
            $createlist[$day] = mt_rand(20, 200);
            $paylist[$day] = mt_rand(1, mt_rand(1, $createlist[$day]));
        }
        $hooks = config('addons.hooks');
        $uploadmode = isset($hooks['upload_config_init']) && $hooks['upload_config_init'] ? implode(',', $hooks['upload_config_init']) : 'local';
        $addonComposerCfg = ROOT_PATH . '/vendor/karsonzhang/fastadmin-addons/composer.json';
        Config::parse($addonComposerCfg, "json", "composer");
        $config = Config::get("composer");
        $addonVersion = isset($config['version']) ? $config['version'] : __('Unknown');
        $device = model('TrafficUserDevice');
        $in = ['online', 'wait_handshake'];
        if ($this->auth->isSuperAdmin()) {
            $this->view->assign([
                'total_user' => model('Admin')->where(['status' => 'normal'])->count('id'),
                'total_device' => $device->count('id'),
                'total_device_online' => $device->where(['status_device' => ['in', $in]])->count('id'),
                'total_device_review' => $device->where(['status_review' => ['neq', 'pass']])->count('id'),
                'totalorder' => 32143,
                'totalorderamount' => 174800,
                'todayuserlogin' => 321,
                'todayusersignup' => 430,
                'todayorder' => 2324,
                'unsettleorder' => 132,
                'sevendnu' => '80%',
                'sevendau' => '32%',
                'paylist' => $paylist,
                'createlist' => $createlist,
                'addonversion' => $addonVersion,
                'uploadmode' => $uploadmode
            ]);
        } else {
            $this->view->assign([
                'total_user' => 1,
                'total_device' => $device->where(['user_id' => $this->uid])->count('id'),
                'total_device_online' => $device->where(['status_device' => ['in', $in],'user_id' => $this->uid])->count('id'),
                'total_device_review' => $device->where(['status_review' => ['neq', 'pass'],'user_id' => $this->uid])->count('id'),
                'totalorderamount' => 174800,
                'todayuserlogin' => 321,
                'todayusersignup' => 430,
                'todayorder' => 2324,
                'unsettleorder' => 132,
                'sevendnu' => '80%',
                'sevendau' => '32%',
                'paylist' => $paylist,
                'createlist' => $createlist,
                'addonversion' => $addonVersion,
                'uploadmode' => $uploadmode
            ]);
        }


        return $this->view->fetch();
    }

}
