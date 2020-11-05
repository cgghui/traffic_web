define(['jquery', 'bootstrap', 'backend', 'table', 'form', 'layer'], function ($, undefined, Backend, Table, Form) {


    var Controller = {

        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'device/app/index',
                    add_url: 'device/app/add',
                    edit_url: 'device/app/edit',
                    del_url: 'device/app/del',
                    multi_url: 'device/app/multi',
                    table: 'device',
                }
            });

            var table = $("#table");

            Table.api.formatter.status = function (value, row, index) {
                var custom = {
                    pass: 'success',
                    rejected: 'danger',
                    waiting: 'info',
                    online: 'success',
                    offline: 'gray',
                    abnormal: 'danger',
                    lock: 'danger'
                };
                if (typeof this.custom !== 'undefined') {
                    custom = $.extend(custom, this.custom);
                }
                this.custom = custom;
                this.icon = 'fa fa-circle';
                return Table.api.formatter.normal.call(this, value, row, index);
            }

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: "app id", sortable: true},
                        {field: 'secret_key', title: 'secret key', operate: false},
                        {field: 'user_id', title: '归属账户', operate: false},
                        {field: 'disabled', title: '是否可用', operate: false,formatter:function (val) {
                            if (val === 'N') {
                                return '<i class="fa fa-toggle-on" style="color: green;font-size: 138%;"></i>';
                            }
                            return '<i class="fa fa-toggle-off" style="color: red;font-size: 138%;"></i>';
                        }},
                        {field: 'online_device_max', title: '可接入设备数', operate: false,formatter:function (val) {
                                return val + "台";
                            }},
                        {field: 'created_at', title: '创建时间', operate: false},
                        {
                            field: 'operate',
                            title: '操作',
                            table: table,
                            buttons: [{
                                text: '',
                                name: 'detail',
                                icon: 'fa fa-list',
                                classname: 'btn btn-info btn-xs btn-detail btn-dialog',
                                extend: ' data-toggle="tooltip" title="详细"',
                                url: 'device/device/detail'
                            }],
                            events: Table.api.events.operate,
                            formatter: Table.api.formatter.operate
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            EditOrAddPublic();
            Controller.api.bindevent();
        },
        edit: function () {
            EditOrAddPublic();
            $("#ssh_check").on("click", function () {
                const btn = $(this);
                btn.attr("disabled", "disabled")
                layer.open({
                    content: "<div id='ssh_check_msg'>正在连接服务器，请稍后...</div>",
                    success: function (o) {
                        var msg = o.find('#ssh_check_msg');
                        $.get('device/device/connect_ssh?id=' + btn.attr("device_id"), function (resp) {
                            if (resp.code === 1) {
                                msg.html('<div style="color:green">SSH连接成功</div>');
                            } else {
                                msg.html('<div style="color:red">SSH' + resp.msg + '</div>');
                            }
                            $.get('device/device/is_online?uuid=' + btn.attr("device_disk_uuid"), function (resp) {
                                btn.removeAttr("disabled")
                                if (resp.code === 1) {
                                    msg.html(msg.html() + '<div style="color:green">设备在线</div>');
                                } else {
                                    msg.html(msg.html() + '<div style="color:red">设备离线</div>');
                                }
                            }, 'json')
                        }, 'json')
                    }
                });
            });
            $("#connect_close").on("click", function () {
                const btn = $(this);
                btn.attr("disabled", "disabled");
                layer.confirm("<div style='color: red'>确定要断开客户断的连接吗？</div><div id='ssh_check_msg'></div>", function (idx, o) {
                    var msg = o.find('#ssh_check_msg');
                    $.get('device/device/connect_close?id=' + btn.attr("device_id"), function (resp) {
                        btn.removeAttr("disabled")
                        if (resp.code === 1) {
                            msg.html('<i style="color:green">提示：断线成功</i>');
                        } else {
                            msg.html('<i style="color:red">提示：断线失败</i>');
                        }
                    }, 'json');
                })
            });
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});