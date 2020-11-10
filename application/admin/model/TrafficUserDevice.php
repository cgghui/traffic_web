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

    public static function Device_Network_CDN_Count_95($uuid, $st = '', $et = '')
    {
        $params = [
            'st' => $st,
            'et' => $et,
            'disk_uuid' => $uuid
        ];
        $resp = Http::post(static::$service_api_url . '/network_count_95_by_device', json_encode($params));
        $resp = json_decode($resp, true)['traffic'];
        $resp['Traffic'] = static::size_format($resp['Traffic']);
        return $resp;
    }

    public static function size_format($num)
    {
        $num = $num * 8;
        $p = 0;
        $format = 'b';
        if ($num > 0 && $num < 1024) {
            $p = 0;
            return number_format($num) . ' ' . $format;
        }
        if ($num >= 1024 && $num < pow(1024, 2)) {
            $p = 1;
            $format = 'Kbps';
        }
        if ($num >= pow(1024, 2) && $num < pow(1024, 3)) {
            $p = 2;
            $format = 'Mbps';
        }
        if ($num >= pow(1024, 3) && $num < pow(1024, 4)) {
            $p = 3;
            $format = 'Gbps';
        }
        if ($num >= pow(1024, 4) && $num < pow(1024, 5)) {
            $p = 3;
            $format = 'Tbps';
        }
        $num /= pow(1024, $p);
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

}
