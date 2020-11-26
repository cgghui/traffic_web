define(['jquery', 'bootstrap', 'backend', 'table', 'echarts', 'echarts-theme', 'form', 'layer', 'bootstrap-datetimepicker'], function ($, undefined, Backend, Table, Echarts, Form) {

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

    function change(bytes, add) {
        bytes = bytes * 8;
        if (bytes === 0) return '0 bps';
        let k = 1000, i, sizes;
        sizes = ['b', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb', 'Eb', 'Zb', 'Yb'];
        i = Math.floor(Math.log(bytes) / Math.log(k));
        return (bytes / Math.pow(k, i)).toFixed(2) + ' ' + sizes[i] + (typeof(add) !== "undefined" ? add : "ps");
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
                content: `<table class="table"><thead><tr><th>记数</th><th>上行速度</th><th>下行速度</th><th>时间</th><th>日志</th></tr></thead><tbody id="data_box_2"></tbody></table>`,
                area: ['90%', '90%'],
                success: function (o, i) {
                    $.get('device/device/get_device_dot_log?uuid=' + tr.attr('uuid') + '&date=' + tr.attr("date"), function (resp) {
                        $("#data_box_2").html(`<tr><td colspan="5" style="color: red;text-align: center">暂无数据</td></tr>`);
                        var i = 0, log;
                        for (; i < resp.length; i++) {
                            log = resp[i];
                            let tm;
                            if (!log.log_upload_time) {
                                log.log_upload_time = '补点';
                                tm = ["", ""];
                            } else {
                                tm = log.log_upload_time.split(" ")[1].split(":");
                            }
                            $(`<tr><td>${i + 1}</td><td>${change(log.count_y_u)}</td><td>${change(log.count_y_d)}</td><td>${log.log_upload_time}</td><td><a href="javascript:" class="show_log">查看</a></td></tr>`)
                                .attr("query", "dev=" + tr.attr('uuid') + "&date=" + tr.attr('date') + "&time=" + tm[0] + ":" + tm[1])
                                .insertAfter("#data_box_2 tr:last");
                        }
                        if (resp.length > 0) {
                            $("#data_box_2 tr:first").remove();
                        }
                        $(".show_log").on("click", function () {
                            const tr = $(this).parents("tr");
                            const ix = layer.open({
                                type: 1,
                                title: false,
                                content: `<table class="table"><thead><tr><th>记数</th><th>本机地址</th><th>目标地址</th><th>计入速率</th><th>未计速率</th></tr></thead><tbody id="data_box_3" style="font-size: 90%;"></tbody></table>`,
                                area: ['90%', '90%'],
                                success: function (o, i) {
                                    $.get('device/device/get_device_pack_log?' + tr.attr("query"), function (resp) {
                                        $("#data_box_3").html(`<tr><td colspan="5" style="color: red;text-align: center">暂无数据</td></tr>`);
                                        if (!resp) {
                                            const x2 = layer.alert("无数据加载！", function () {
                                                layer.close(x2);
                                                layer.close(ix);
                                            });
                                            return;
                                        }
                                        var i = 0, log;
                                        for (; i < resp.data.length; i++) {
                                            log = resp.data[i].split(" ");
                                            $(`<tr><td>${i + 1}</td><td>${log[1]}</td><td>${log[0]}</td><td>${change(log[2])}</td><td>${change(log[3])}</td></tr>`).insertAfter("#data_box_3 tr:last");
                                        }
                                        if (resp.data.length > 0) {
                                            $("#data_box_3 tr:first").remove();
                                        }
                                    }, 'json')
                                }
                            });
                        })
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

    // 获取上一个月
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

    // 获取下一个月
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

    function LoadDataByChart(uuid, isp, st, et, chart) {
        chart.showLoading();
        $.get("device/device/get_chart_speed_data?uuid=" + uuid + "&isp=" + isp + "&st=" + st + "&et=" + et, function (resp) {
            chart.hideLoading();
            if (!resp.status) {
                layer.alert("加载数据失败！");
                return;
            }
            $("#st").val(st);
            $("#et").val(et);
            chart.setOption({
                xAxis: {
                    data: resp.ret.xAxis
                },
                series: [
                    {
                        name: '最高网速',
                        data: resp.ret.data[1]
                    },
                    {
                        name: '折点网速',
                        data: resp.ret.data[0],
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'},
                                {
                                    coord: [resp.ret.posi.date, resp.ret.posi.speed],
                                    label: {
                                        formatter: function (obj) {
                                            return "95点 " + change(obj.data.coord[1], "")
                                        }
                                    },
                                },
                            ],
                        }
                    }
                ]
            });
        }, "json");
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
                        {
                            field: 'up_month_average', title: '上月均速', operate: false, sortable: true,
                            formatter: function (val) {
                                return change(val);
                            }
                        },
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
                            buttons: [
                                {
                                    text: '',
                                    name: 'detail',
                                    icon: 'fa fa-bar-chart',
                                    classname: 'btn btn-info btn-xs btn-detail btn-dialog',
                                    extend: ' data-toggle="tooltip" title="图表"',
                                    url: 'device/device/chart_info'
                                },
                                {
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
            table.on("load-success.bs.table", function (e, data) {
                $(".search").hide();
            });
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
                                msg.html('<div style="color:green">SSH: 连接成功</div>');
                            } else {
                                msg.html('<div style="color:red">SSH: ' + resp.msg + '</div>');
                            }
                            $.get('device/device/is_online?uuid=' + btn.attr("device_disk_uuid"), function (resp) {
                                btn.removeAttr("disabled")
                                if (resp.code === 1) {
                                    msg.html(msg.html() + '<div style="color:green">设备: 在线</div>');
                                } else {
                                    msg.html(msg.html() + '<div style="color:red">设备: 离线</div>');
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
        chart_info: function () {
            const cur_date_s = $("#st").val();
            const cur_date_e = $("#et").val();
            const options = {
                format: 'YYYY-MM-DD',
                icons: {
                    time: 'fa fa-clock-o',
                    date: 'fa fa-calendar',
                    up: 'fa fa-chevron-up',
                    down: 'fa fa-chevron-down',
                    previous: 'fa fa-chevron-left',
                    next: 'fa fa-chevron-right',
                    today: 'fa fa-history',
                    clear: 'fa fa-trash',
                    close: 'fa fa-remove'
                },
                showTodayButton: true,
                showClose: true
            };
            $('.datetime_picker').datetimepicker(options);
            // 基于准备好的dom，初始化echarts实例
            let chart = Echarts.init(document.getElementById('EChart'));
            chart.setOption({
                title: {text: '', subtext: ''},
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        animation: false,
                        label: {
                            backgroundColor: '#ccc',
                            borderColor: '#aaa',
                            borderWidth: 1,
                            shadowBlur: 0,
                            shadowOffsetX: 0,
                            shadowOffsetY: 0,
                            color: '#222',
                            formatter: function (obj) {
                                if (obj.axisDimension === "y") {
                                    return (obj.value * 8 / 1024 / 1024 / 1024).toFixed(2) + "Gb";
                                }
                                return obj.value;
                            }
                        }
                    },
                    formatter: function (item) {
                        if (item[1]) {
                            return "<p>" + item[0].axisValue + "</p>" +
                                "<p><i class='fa fa-genderless' style='color:" + item[0].color + "'></i> " + item[0].seriesName + " " + change(item[0].data, "") + "</p>" +
                                "<p><i class='fa fa-genderless' style='color:" + item[1].color + "'></i> " + item[1].seriesName + " " + change(item[1].data, "") + "</p>";
                        } else {
                            return "<p>" + item[0].axisValue + "</p>" +
                                "<p><i class='fa fa-genderless' style='color:" + item[0].color + "'></i> " + item[0].seriesName + " " + change(item[0].data, "") + "</p>";
                        }
                    }
                },
                dataZoom: [{}, {
                    type: 'inside'
                }],
                legend: {
                    data: ["最高网速", "折点网速"],
                },
                toolbox: {
                    show: false,
                    feature: {
                        magicType: {show: true, type: ['stack', 'tiled']},
                        saveAsImage: {show: true}
                    }
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: []
                },
                yAxis: {
                    type: 'value',
                    axisLabel: {
                        formatter: function (val) {
                            return (val * 8 / 1024 / 1024 / 1024).toFixed(2) + "Gb";
                        }
                    }
                },
                series: [
                    {
                        name: '最高网速',
                        type: 'line',
                        symbol: 'emptyCircle',
                        symbolSize: 3.5,
                        smooth: true,
                        areaStyle: {
                            normal: {
                                color: "#d4716e4a"
                            }
                        },
                        lineStyle: {
                            normal: {
                                width: 1.5,
                            }
                        },
                        data: []
                    },
                    {
                        name: '折点网速',
                        type: 'line',
                        symbol: 'emptyCircle',
                        symbolSize: 3.5,
                        smooth: true,
                        areaStyle: {
                            normal: {
                                color: "#61525c4a"
                            }
                        },
                        lineStyle: {
                            normal: {width: 1.5}
                        },
                        markLine: {
                            data: [
                                {type: 'average', name: '平均值'}
                            ],
                            label: {
                                formatter: function (obj) {
                                    return change(obj.value, "");
                                }
                            }
                        },
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'}
                            ],
                            label: {
                                formatter: function (obj) {
                                    return change(obj.value, "");
                                }
                            },
                        },
                        data: []
                    }
                ]
            });
            let ispZh = {
                "电信": "dx",
                "移动": "yd",
                "联通": "lt",
            }[$("#isp").val()];
            const uuid = $("#device_uuid").val();
            LoadDataByChart(uuid, ispZh, $("#st").val(), $("#et").val(), chart);
            $("#search_r").on("click", function () {
                LoadDataByChart(uuid, ispZh, $("#st").val(), $("#et").val(), chart);
            });
            $("#search_up").on("click", function () {
                let ss = $("#st").val().split("-"), st, et, day, sx;
                st = getPreMonth(ss[0] + "-" + ss[1]) + "-01";
                sx = st.split("-")
                day = new Date(parseInt(sx[0]), parseInt(sx[1]), 0).getDate();
                if (day <= 9) {
                    day = "0" + day
                }
                et = getPreMonth(ss[0] + "-" + ss[1]) + "-" + day;
                LoadDataByChart(uuid, ispZh, st, et, chart);
            });
            $("#search_cur").on("click", function () {
                LoadDataByChart(uuid, ispZh, cur_date_s, cur_date_e, chart);
            });
            $("#search_next").on("click", function () {
                let ss = $("#st").val().split("-"), st, et, day, sx;
                st = getNextMonth(ss[0] + "-" + ss[1]) + "-01";
                sx = st.split("-")
                day = new Date(parseInt(sx[0]), parseInt(sx[1]), 0).getDate();
                if (day <= 9) {
                    day = "0" + day
                }
                et = getNextMonth(ss[0] + "-" + ss[1]) + "-" + day;
                LoadDataByChart(uuid, ispZh, st, et, chart);
            })
            chart.on("click", function (obj) {
                if (obj.name === "平均值" || obj.name === "" || obj.name === "最大值" || obj.name === "最小值") {
                    return;
                }
                layer.open({
                    type: 1,
                    title: false,
                    content: `<div id="EChart_day" class="btn-refresh" style="height:400px;width:100%;"></div>`,
                    area: ['95%', '80%'],
                    success: function (o, i) {
                        let chart = Echarts.init(document.getElementById('EChart_day'));
                        chart.setOption({
                            title: {text: '', subtext: ''},
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'cross',
                                    animation: false,
                                    label: {
                                        backgroundColor: '#ccc',
                                        borderColor: '#aaa',
                                        borderWidth: 1,
                                        shadowBlur: 0,
                                        shadowOffsetX: 0,
                                        shadowOffsetY: 0,
                                        color: '#222',
                                        formatter: function (obj) {
                                            if (obj.axisDimension === "y") {
                                                return (obj.value * 8 / 1024 / 1024 / 1024).toFixed(2) + "Gb";
                                            }
                                            return obj.value;
                                        }
                                    }
                                },
                                formatter: function (item) {
                                    return item[0].axisValue + " " + change(item[0].data, "");
                                }
                            },
                            dataZoom: [{}, {
                                type: 'inside'
                            }],
                            toolbox: {
                                show: false,
                                feature: {
                                    magicType: {show: true, type: ['stack', 'tiled']},
                                    saveAsImage: {show: true}
                                }
                            },
                            xAxis: {
                                type: 'category',
                                boundaryGap: false,
                                data: []
                            },
                            yAxis: {
                                type: 'value',
                                axisLabel: {
                                    formatter: function (val) {
                                        return (val * 8 / 1024 / 1024 / 1024).toFixed(2) + "Gb";
                                    }
                                }
                            },
                            series: [
                                {
                                    type: 'line',
                                    symbol: 'emptyCircle',
                                    symbolSize: 3.5,
                                    smooth: true,
                                    areaStyle: {
                                        normal: {
                                            color: "#d4716e4a"
                                        }
                                    },
                                    lineStyle: {
                                        normal: {
                                            width: 1.5,
                                        }
                                    },
                                    markLine: {
                                        data: [
                                            {type: 'average', name: '平均值'}
                                        ],
                                        label: {
                                            formatter: function (obj) {
                                                return change(obj.value, "");
                                            }
                                        }
                                    },
                                    markPoint: {
                                        data: [
                                            {type: 'max', name: '最大值'},
                                            {type: 'min', name: '最小值'}
                                        ],
                                        label: {
                                            formatter: function (obj) {
                                                return change(obj.value, "");
                                            }
                                        },
                                    },
                                    data: []
                                }
                            ]
                        });
                        chart.showLoading();
                        $.get("device/device/get_chart_speed_date_detail?uuid=" + uuid + "&st=" + obj.name, function (resp) {
                            chart.hideLoading();
                            if (!resp.status) {
                                layer.alert("加载数据失败！");
                                return;
                            }
                            chart.setOption({
                                xAxis: {
                                    data: resp.ret.xAxis
                                },
                                series: [
                                    {
                                        data: resp.ret.data,
                                        markPoint: {
                                            data: [
                                                {type: 'max', name: '最大值'},
                                                {type: 'min', name: '最小值'},
                                                {
                                                    coord: [resp.ret.posi.date, resp.ret.posi.speed],
                                                    label: {
                                                        formatter: function (obj) {
                                                            return "95点 " + change(obj.data.coord[1], "")
                                                        }
                                                    },
                                                },
                                            ],
                                        },
                                    }
                                ]
                            });
                        }, "json");
                    }
                })
            })
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});