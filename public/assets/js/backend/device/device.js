define(['jquery', 'bootstrap', 'backend', 'table', 'form', 'layer'], function ($, undefined, Backend, Table, Form) {

    function EditOrAddPublic() {
        $('input[name="row[ssh_connect_method]"]').on("change", function () {
            $(".connect_type_tip").addClass("hide");
            $("#connect_type_" + $(this).val() + "_tip").removeClass("hide");
        });
        $('input[name="row[status_review]"]').on("change", function () {
            const box = $("#rejected_reason_box");
            box.addClass("hide");
            if ($(this).val() === "rejected") {
                box.removeClass("hide");
            }
        });
        $('input[name="row[status_device]"]').on("change", function () {
            const box = $("#status_note_box");
            box.addClass("hide");
            if ($(this).val() === "abnormal" || $(this).val() === "lock") {
                box.removeClass("hide");
            }
        });
    }

    const status_tip = {
        'collect_fail': '<span style="color: red">采集错误</span>',
        'connected': '<span style="color: green">连接成功</span>',
        'disconnect': '<span style="color: orangered">连接断开</span>',
        'unknown': '<span style="color: red">未定义</span>',
        'rejected': '<span style="color: red">审核驳回</span>',
        'write_error': '<span style="color: red">发送数据失败</span>',
        'read_error': '<span style="color: red">读取数据失败</span>',
        'abnormal': '<span style="color: red">异常</span>',
        'lock': '<span style="color: red">锁定</span>',
    };

    function change(bytes) {
        bytes = bytes * 8;
        if (bytes === 0) return '0 bps';
        let k = 1024, i, sizes;
        sizes = ['bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps', 'Pbps', 'Ebps', 'Zbps', 'Ybps'];
        i = Math.floor(Math.log(bytes) / Math.log(k));
        return (bytes / Math.pow(k, i)).toFixed(2) + ' ' + sizes[i];
    }

    function loadData(ele) {
        let i;
        let last_day;
        const mutex = $(".mutex");
        const ele_date = ele.attr("cur_date");
        const ele_uuid = ele.attr("uuid");
        const cur = new Date();
        let month = cur.getMonth() + 1, preI;
        if (month < 10) {
            month = '0' + month;
        }
        if (ele_date === cur.getFullYear() + '-' + month) {
            last_day = new Date(cur.getFullYear(), cur.getMonth() + 1, 0).getDate();
            i = cur.getDate();
        } else {
            const time = new Date(ele_date + "-01 00:00:00");
            last_day = new Date(time.getFullYear(), time.getMonth() + 1, 0).getDate();
            i = last_day;
        }
        if (i < 10) {
            preI = "0" + i;
        } else {
            preI = i
        }
        mutex.addClass("lock").removeClass("unlock");
        $("#show_month").html(ele_date.split("-")[1] + "月");
        ele.find("tbody").html(`<tr uuid="" style="display: none;"><td></td><td></td><td></td><td></td><td></td><td></td></tr>`);
        const e = $(`<tr><td>月计</td><td></td><td></td><td></td><td></td><td><a href="javascript:;" class="tr_show">查看</a></td></tr>`);
        e.attr("last", last_day);
        e.attr("uuid", ele_uuid);
        e.attr("start_date", ele_date + "-01");
        e.attr("end_date", ele_date + "-" + preI);
        e.insertAfter("#trafficTable > tbody tr:last");
        for (; i > 0; i--) {
            let h = i;
            if (i < 10) {
                h = "0" + i;
            }
            const e = $(`<tr><td>${h}号</td><td></td><td><a href="javascript:;" class="do_show">0次</a></td><td></td><td></td><td><a href="javascript:;" class="tr_show">查看</a></td></tr>`)
            e.attr("date", ele_date + "-" + h);
            e.attr("uuid", ele_uuid);
            e.insertAfter("#trafficTable > tbody tr:last");
        }
        EachTrFunc($("#trafficTable tbody"), 0, mutex)
        $(".tr_show").click(function () {
            const tr = $(this).parents("tr");
            let dateStr = tr.attr("date"), url, st, et;
            if (!dateStr) {
                st = tr.attr("start_date");
                et = tr.attr("end_date");
                url = 'device/device/get_device_log?uuid=' + tr.attr('uuid') + '&date=cur&st=' + st + '&et=' + et;
            } else {
                url = 'device/device/get_device_log?uuid=' + tr.attr('uuid') + '&date=' + dateStr;
            }
            layer.open({
                type: 1,
                title: false,
                content: `<table class="table"><thead><tr><th>时间</th><th>动作</th><th>消息</th></tr></thead><tbody id="data_box"></tbody></table>`,
                area: ['90%', '90%'],
                success: function (o, i) {
                    $.get(url, function (resp) {
                        $("#data_box").html(`<tr><td colspan="3" style="color: red;text-align: center">暂无数据</td></tr>`);
                        var i = 0, log;
                        for (; i < resp.length; i++) {
                            log = resp[i]
                            let s = status_tip[log.status]
                            $(`<tr><td>${log.report_datetime}</td><td>${s}</td><td>${log.message}</td></tr>`).insertAfter("#data_box tr:last");
                        }
                        if (resp.length > 0) {
                            $("#data_box tr:first").remove()
                        }
                    }, 'json')
                }
            })
        });
        $(".do_show").click(function () {
            const tr = $(this).parents("tr");
            layer.open({
                type: 1,
                title: false,
                content: `<table class="table"><thead><tr><th>记数</th><th>上行速度</th><th>下行速度</th><th>时间</th></tr></thead><tbody id="data_box_2"></tbody></table>`,
                area: ['90%', '90%'],
                success: function (o, i) {
                    $.get('device/device/get_device_dot_log?uuid=' + tr.attr('uuid') + '&date=' + tr.attr("date"), function (resp) {
                        $("#data_box_2").html(`<tr><td colspan="3" style="color: red;text-align: center">暂无数据</td></tr>`);
                        var i = 0, log;
                        for (; i < resp.length; i++) {
                            log = resp[i];
                            if (!log.log_upload_time) {
                                log.log_upload_time = '补点';
                            }
                            $(`<tr><td>${i + 1}</td><td>${change(log.count_y_u)}</td><td>${change(log.count_y_d)}</td><td>${log.log_upload_time}</td></tr>`).insertAfter("#data_box_2 tr:last");
                        }
                        if (resp.length > 0) {
                            $("#data_box_2 tr:first").remove();
                        }
                    }, 'json')
                }
            })
        });
    }

    function EachTrFunc(ele, i, mutex) {
        if (i > ele.find("tr").length) {
            mutex.addClass("unlock").removeClass("lock");
            return
        }
        const tr = ele.find("tr:eq(" + i + ")");
        let url;
        let dateStr = tr.attr("date"), st, et;
        if (tr.attr("uuid") === "") {
            EachTrFunc(ele, i + 1, mutex);
            return;
        }
        if (!dateStr) {
            st = tr.attr("start_date");
            et = tr.attr("end_date");
            url = 'device/device/get_traffic_count?uuid=' + tr.attr('uuid') + '&date=cur&st=' + st + '&et=' + et;
        } else {
            url = 'device/device/get_traffic_count?uuid=' + tr.attr('uuid') + '&date=' + dateStr;
        }
        $.get(url, function (resp) {
            tr.find("td:eq(1)").html(resp.Traffic);
            if (tr.attr("last") === undefined) {
                tr.find("td:eq(2) .do_show").html(`${resp.Total}次`);
            } else {
                tr.find("td:eq(2)").html(`${resp.Total}次`);
            }
            tr.find("td:eq(3)").html(resp.Idle + "次");
            tr.find("td:eq(4)").html(resp.Spet + "次");
            EachTrFunc(ele, i + 1, mutex);
        }, 'json');
    }

    /**
     * 获取上一个月
     *
     * @date 格式为yyyy-mm-dd的日期，如：2014-01
     */
    function getPreMonth(date) {
        const arr = date.split('-');
        const year = arr[0]; //获取当前日期的年份
        const month = arr[1]; //获取当前日期的月份
        let days = new Date(year, month, 0);
        let year2 = year;
        let month2 = parseInt(month) - 1;
        if (month2 === 0) {
            year2 = parseInt(year2) - 1;
            month2 = 12;
        }
        if (month2 < 10) {
            month2 = '0' + month2;
        }
        return year2 + '-' + month2;
    }

    /**
     * 获取下一个月
     *
     * @date 格式为yyyy-mm-dd的日期，如：2014-01
     */
    function getNextMonth(date) {
        const arr = date.split('-');
        const year = arr[0];
        const month = arr[1];
        let year2 = year;
        let month2 = parseInt(month) + 1;
        if (month2 === 13) {
            year2 = parseInt(year2) + 1;
            month2 = 1;
        }
        if (month2 < 10) {
            month2 = '0' + month2;
        }
        return year2 + '-' + month2;
    }

    const Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'device/device/index',
                    add_url: 'device/device/add',
                    edit_url: 'device/device/edit',
                    del_url: 'device/device/del',
                    multi_url: 'device/device/multi',
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
                        {field: 'id', title: __('Id'), sortable: true, operate: false},
                        {field: 'disk_uuid', title: '设备编号', operate: 'LIKE'},
                        {field: 'ip', title: '设备IP', operate: 'LIKE'},
                        {field: 'ip_address', title: '所在地', operate: 'LIKE'},
                        {field: 'isp', title: '运营商', operate: 'LIKE'},
                        {
                            field: 'today_95',
                            title: '今日速度',
                            operate: false,
                            sortable: true,
                            formatter: function (val) {
                                return change(val);
                            }
                        },
                        {
                            field: 'month_95', title: '本月速度', tip: "不计当日", operate: false, sortable: true,
                            formatter: function (val) {
                                return change(val);
                            }
                        },
                        {
                            field: 'up_month_95', title: '上月速度', operate: false, sortable: true,
                            formatter: function (val) {
                                return change(val);
                            }
                        },
                        {field: 'up_month_average', title: '上月均速', operate: false},
                        {
                            field: 'status_review',
                            title: '审核',
                            formatter: Table.api.formatter.status,
                            operate: false,
                            searchList: {waiting: "待审", rejected: "失败", pass: "成功"}
                        },
                        {
                            field: 'status_device',
                            title: '状态',
                            formatter: Table.api.formatter.status,
                            operate: false,
                            searchList: {wait_handshake: "就绪", online: "在线", offline: "离线", abnormal: "异常", lock: "锁定"}
                        },
                        {
                            field: 'updated_at',
                            title: '更新时间',
                            operate: false
                        },
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
            function load_device_95(t, i, data) {
                if (typeof data[i] === "undefined") {
                    return;
                }
                const now = new Date();
                const cur = new Date(now.getFullYear(), now.getMonth(), 0).getDate();
                $.get("device/device/get_up_traffic_average?uuid=" + data[i]["disk_uuid"], function (resp) {
                    $("#table").bootstrapTable('updateRow', {
                        index: i,
                        replace: true,
                        row: {
                            up_month_average: change((resp.total / cur).toFixed(0))
                        }
                    });
                    load_device_95(t, i + 1, data);
                }, "json");
            }

            table.on("load-success.bs.table", function (e, data) {
                load_device_95(table, 0, data.rows)
            })
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
        detail: function () {
            var source = $(".field_source");
            source.find("span[set=" + source.attr("val") + "]").css({"color": "#0000ff"});
            const ele = $("#trafficTable");
            loadData(ele);
            $("#up_month").on("click", function () {
                if ($(this).hasClass("lock")) {
                    return
                }
                ele.attr("cur_date", getPreMonth(ele.attr("cur_date")));
                loadData(ele);
            });
            $("#down_month").on("click", function () {
                if ($(this).hasClass("lock")) {
                    return
                }
                ele.attr("cur_date", getNextMonth(ele.attr("cur_date")));
                loadData(ele);
            });
            $("#cur_month").on("click", function () {
                if ($(this).hasClass("lock")) {
                    return
                }
                const cur = new Date();
                let month = cur.getMonth() + 1;
                if (month < 10) {
                    month = '0' + month;
                }
                ele.attr("cur_date", cur.getFullYear() + "-" + month);
                loadData(ele);
            });
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});