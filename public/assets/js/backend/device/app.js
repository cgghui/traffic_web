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

            const table = $("#table");

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
                        {
                            field: 'user_id', title: '归属账户', operate: false, formatter: function (val) {
                                return '<a href="javascript:">' + val + '</a>';
                            }
                        },
                        {
                            field: 'disabled', title: '是否可用', operate: false, formatter: function (val, row, idx) {
                                return "<a href='javascript:;' class='btn-change' data-index='" + idx + "' data-id='"
                                    + row.id + "' data-params='" + this.field + "=" + (val === 'N' ? 'Y' : 'N') + "'><i class='fa fa-toggle-on text-success " + (val === 'N' ? '' : 'fa-flip-horizontal text-gray') + " fa-2x'></i></a>";
                            }
                        },
                        {
                            field: 'online_device_max', title: '可接入设备数', operate: false, formatter: function (val) {
                                return val + "台";
                            }
                        },
                        {field: 'created_at', title: '创建时间', operate: false},
                        {
                            field: 'operate',
                            title: '操作',
                            table: table,
                            events: Table.api.events.operate,
                            formatter: Table.api.formatter.operate
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);

            table.on("load-success.bs.table", function (e, data) {
                const rows = data.rows;
                let user_ids = [], ids = [], i;
                for (i = 0; i < rows.length; i++) {
                    user_ids.push(rows[i].user_id);
                    ids.push(rows[i].id);
                }
                $.get("device/app/get_username?user_ids=" + user_ids.join(","), function (resp) {
                    $.each(resp, function (id, name) {
                        for (i = 0; i < rows.length; i++) {
                            if (parseInt(id) === rows[i].user_id) {
                                $("#table").bootstrapTable('updateRow', {
                                    index: i,
                                    replace: true,
                                    row: {
                                        user_id: name,
                                    }
                                });
                            }
                        }
                    })
                }, "json");
                $.get("device/app/get_online_device?ids=" + ids.join(","), function () {

                }, "json");
            })
        },
        // add: function () {
        //     EditOrAddPublic();
        //     Controller.api.bindevent();
        // },
        // edit: function () {
        //     EditOrAddPublic();
        //     $("#ssh_check").on("click", function () {
        //         const btn = $(this);
        //         btn.attr("disabled", "disabled")
        //         layer.open({
        //             content: "<div id='ssh_check_msg'>正在连接服务器，请稍后...</div>",
        //             success: function (o) {
        //                 var msg = o.find('#ssh_check_msg');
        //                 $.get('device/device/connect_ssh?id=' + btn.attr("device_id"), function (resp) {
        //                     if (resp.code === 1) {
        //                         msg.html('<div style="color:green">SSH连接成功</div>');
        //                     } else {
        //                         msg.html('<div style="color:red">SSH' + resp.msg + '</div>');
        //                     }
        //                     $.get('device/device/is_online?uuid=' + btn.attr("device_disk_uuid"), function (resp) {
        //                         btn.removeAttr("disabled")
        //                         if (resp.code === 1) {
        //                             msg.html(msg.html() + '<div style="color:green">设备在线</div>');
        //                         } else {
        //                             msg.html(msg.html() + '<div style="color:red">设备离线</div>');
        //                         }
        //                     }, 'json')
        //                 }, 'json')
        //             }
        //         });
        //     });
        //     $("#connect_close").on("click", function () {
        //         const btn = $(this);
        //         btn.attr("disabled", "disabled");
        //         layer.confirm("<div style='color: red'>确定要断开客户断的连接吗？</div><div id='ssh_check_msg'></div>", function (idx, o) {
        //             var msg = o.find('#ssh_check_msg');
        //             $.get('device/device/connect_close?id=' + btn.attr("device_id"), function (resp) {
        //                 btn.removeAttr("disabled")
        //                 if (resp.code === 1) {
        //                     msg.html('<i style="color:green">提示：断线成功</i>');
        //                 } else {
        //                     msg.html('<i style="color:red">提示：断线失败</i>');
        //                 }
        //             }, 'json');
        //         })
        //     });
        //     Controller.api.bindevent();
        // },
        // api: {
        //     bindevent: function () {
        //         Form.api.bindevent($("form[role=form]"));
        //     }
        // }
    };
    return Controller;
});