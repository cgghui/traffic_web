<?php

namespace app\admin\model;

use think\Config;
use think\Db;
use think\Model;
use fast\Http;

class TrafficUserDevice extends Model
{

    // 表名
    /**
     * @var mixed|string
     */
    protected $name = 'traffic_user_devices';
    private static $service_api_url;

    protected static function init()
    {
        $cfg = Config::get('site');
        static::$service_api_url = $cfg['service_api_url'];
    }

    // GetIpAddress 查询API归属地
    public static function GetIpAddress($ip)
    {
        // 响应示例 {"ret":"ok","ip":"49.79.187.255","data":["中国","江苏","南通","","电信","226500","0513"]}
        $resp = Http::post('https://api.ip138.com/ipv4/?ip=' . $ip . '&datatype=json', [], [
            CURLOPT_HTTPHEADER => [
                'token:c1e2201706ec00eab718089b8435a138',
            ],
        ]);
        $resp = json_decode($resp, true);
        return ['addr' => $resp['data'][0] . $resp['data'][1] . $resp['data'][2] . $resp['data'][3], 'isp' => $resp['data'][4]];
    }

    public static function Device_Network_CDN_Count_95($uuid, $st = '', $et = '', $format = true)
    {
        $params = [
            'st' => $st,
            'et' => $et,
            'disk_uuid' => $uuid
        ];
        $resp = Http::post(static::$service_api_url . '/network_count_95_by_device', json_encode($params));
        $resp = json_decode($resp, true)['traffic'];
        if ($format) {
            $resp['Traffic'] = static::size_format($resp['Traffic']);
        }
        return $resp;
    }

    public static function size_format($num)
    {
        $unit = 1000;
        $num = $num * 8;
        $p = 0;
        $format = 'b';
        if ($num > 0 && $num < $unit) {
            $p = 0;
            return number_format($num) . ' ' . $format;
        }
        if ($num >= $unit && $num < pow($unit, 2)) {
            $p = 1;
            $format = 'Kbps';
        }
        if ($num >= pow($unit, 2) && $num < pow($unit, 3)) {
            $p = 2;
            $format = 'Mbps';
        }
        if ($num >= pow($unit, 3) && $num < pow($unit, 4)) {
            $p = 3;
            $format = 'Gbps';
        }
        if ($num >= pow($unit, 4) && $num < pow($unit, 5)) {
            $p = 3;
            $format = 'Tbps';
        }
        $num /= pow($unit, $p);
        return number_format($num, 2) . $format;
    }

    // ServiceConnectSSH 连接SSH
    public static function ServiceConnectSSH($row)
    {
        $params = [
            'type' => $row['ssh_connect_method'],
            'ip' => $row['ip'],
            'port' => $row['ssh_port'],
            'username' => $row['ssh_username'],
            'password' => $row['ssh_password'],
        ];
        $resp = http::post(static::$service_api_url . '/connect_ssh', json_encode($params));
        return json_decode($resp, true);
    }

    // ServiceGetOnlineDevices 获得在线设备列表
    public static function ServiceGetOnlineDevices()
    {
        $resp = http::get(static::$service_api_url . '/get_online_devices');
        return json_decode($resp, true);
    }

    // ServiceRefreshDeviceCache 刷新服务软件的缓存
    public static function ServiceRefreshDeviceCache()
    {
        http::get(static::$service_api_url . '/refresh_device_cache');
    }

    // ServiceConnectClose 断开客户端的连接
    public static function ServiceConnectClose($uuid)
    {
        $resp = http::get(static::$service_api_url . '/connect_close?disk_uuid=' . $uuid);
        $resp = json_decode($resp, true);
        return $resp['msg'] == 'successful' && $resp['close_num'] > 0;
    }

    public static function ServiceConnectCloseByApp($app_id)
    {
        $resp = http::get(static::$service_api_url . '/connect_close_by_app?app_id=' . $app_id);
        $resp = json_decode($resp, true);
        return $resp['msg'] == 'successful' && $resp['close_num'] > 0;
    }

    // ServiceGetOnlineDevice 断开客户端的连接
    public static function ServiceGetOnlineDevice($app_ids)
    {
        $resp = http::get(static::$service_api_url . '/get_online_devices');
        $resp = json_decode($resp, true);
        if (!$app_ids) {
            return $resp;
        }
        $ret = [];
        foreach ($resp as $i => $row) {
            if (in_array($row['app_id'], $app_ids)) {
                $ret[] = $row;
            }
        }
        return $ret;
    }

    // ServiceDeviceLog 网速日志
    public static function ServiceDeviceLog($uuid, $date, $time)
    {
        $resp = http::get(static::$service_api_url . '/get_client_logs?dev=' . $uuid . '&date=' . $date . '&form=upload&time=' . $time);
        $resp = json_decode($resp, true);
        if (!$resp['status']) {
            return false;
        }
        $resp = $resp['data'];
        foreach ($resp as $k => $data) {
            return $data;
        }
    }

    public static function ServiceAddIqiyiDevices($devs)
    {
        return http::get(static::$service_api_url . '/add_iqiyi_devices?devs=' . $devs);
    }

    public static function ServiceGetTaskLogs($name)
    {
        return http::get(static::$service_api_url . '/get_task_logs?name=' . $name);
    }

    public static function ServiceIqiyiCollect($devs)
    {
        return http::get(static::$service_api_url . '/iqiyi_collect?devs=' . $devs);
    }

    public static function ServiceIqiyiCollectAll()
    {
        return http::get(static::$service_api_url . '/iqiyi_collect_all');
    }

    public static function ServiceDailyNetworkCount($date, $src)
    {
        return http::get(static::$service_api_url . '/daily_network_count?date=' . $date . '&src=' . $src);
    }

    public static function ServiceDailyNetworkCount95($type, $date)
    {
        return http::get(static::$service_api_url . '/daily_network_count95?type=' . $type . '&date=' . $date);
    }

    public static function ServiceResetDeviceCount()
    {
        return http::get(static::$service_api_url . '/reset_device_count');
    }

    public static function ServiceBackupData($date, $del)
    {
        return http::get(static::$service_api_url . '/backup_data/' . $date . '/' . $del);
    }

    public static function ServiceRestore($date, $new_table, $device)
    {
        if ($device == '') {
            $device = 'xxx';
        }
        $device = bin2hex($device);
        return http::get(static::$service_api_url . '/restore/' . $date . '/' . $new_table . '/' . $device);
    }

    public static function up_time_stamp()
    {
        return strtotime('-1 month');
    }

    public static function month_day($time)
    {
        return date('Y-m-t', $time);
    }
}
