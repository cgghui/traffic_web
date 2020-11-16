define(['jquery', 'bootstrap', 'backend', 'table', 'form', 'layer'], function ($, undefined, Backend, Table, Form) {
    /**
     * 生成密码字符串
     * 33~47：!~/
     * 48~57：0~9
     * 58~64：:~@
     * 65~90：A~Z
     * 91~96：[~`
     * 97~122：a~z
     * 123~127：{~
     * @param length 长度
     * @param hasNum 是否包含数字 1-包含 0-不包含
     * @param hasChar 是否包含字母 1-包含 0-不包含
     * @param hasSymbol 是否包含其他符号 1-包含 0-不包含
     * @param caseSense 是否大小写敏感 1-敏感 0-不敏感
     * @param lowerCase 是否只需要小写，只有当hasChar为0且caseSense为1时起作用 1-全部小写 0-全部大写
     */
    function genEnCode(length, hasNum, hasChar, hasSymbol, caseSense, lowerCase) {
        var m = "";
        if (hasNum == "0" && hasChar == "0" && hasSymbol == "0") return m;
        for (var i = length; i >= 0; i--) {
            var num = Math.floor((Math.random() * 94) + 33);
            if (
                (
                    (hasNum == "0") && ((num >= 48) && (num <= 57))
                ) || (
                    (hasChar == "0") && ((
                        (num >= 65) && (num <= 90)
                    ) || (
                        (num >= 97) && (num <= 122)
                    ))
                ) || (
                    (hasSymbol == "0") && ((
                        (num >= 33) && (num <= 47)
                    ) || (
                        (num >= 58) && (num <= 64)
                    ) || (
                        (num >= 91) && (num <= 96)
                    ) || (
                        (num >= 123) && (num <= 127)
                    ))
                )
            ) {
                i++;
                continue;
            }
            m += String.fromCharCode(num);
        }
        if(caseSense == "0"){
            m = (lowerCase == "0")?m.toUpperCase():m.toLowerCase();
        }
        return m;
    }

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
                // $.get("device/app/get_online_device?ids=" + ids.join(","), function () {
                //
                // }, "json");
            })
        },
        add: function () {
            $("#create_pwd").on("click", function () {
                $("#secret_key").val(genEnCode(32,1,1,0,0,0))
            })
        },
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