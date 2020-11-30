define(['jquery', 'bootstrap', 'backend', 'addtabs', 'table', 'echarts', 'echarts-theme', 'echarts', 'echarts-theme', 'template'], function ($, undefined, Backend, Datatable, Table, Echarts, undefined, Template) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url1: 'Dashboard2/count_dl',
                    index_url2: 'Dashboard2/count_yd',
                }
            });

            const table1 = $("#table1");
            const table2 = $("#table2");

            table1.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url1,
                pk: 'id',
                sortName: 'log_upload_time',
                sortOrder: 'ASC',
                showToggle: false,
                showColumnsSearch: false,
                columns: [
                    [
                        {field: 'id', title: 'id', sortable: true},
                        {
                            field: '', title: '运营商', operate: false, formatter: function (val) {
                                return '电信&联通';
                            }
                        },
                        {field: 'source', title: '源', sortable: true},
                        {field: 'log_upload_time', title: '日期时间', sortable: true, operate: 'LIKE'},
                        {
                            field: 'count_y_u',
                            title: '上传速度',
                            sortable: true,
                            operate: false,
                            formatter: function (val) {
                                return change(val);
                            }
                        }
                    ]
                ]
            });

            table2.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url2,
                pk: 'id',
                sortName: 'log_upload_time',
                sortOrder: 'ASC',
                showToggle: false,
                showColumnsSearch: false,
                columns: [
                    [

                        {field: 'id', title: 'id', sortable: true},
                        {
                            field: '', title: '运营商', operate: false, formatter: function (val) {
                                return '移动';
                            }
                        },
                        {field: 'source', title: '源', sortable: true},
                        {field: 'log_upload_time', title: '日期时间', sortable: true, operate: 'LIKE'},
                        {
                            field: 'count_y_u',
                            title: '上传速度',
                            sortable: true,
                            operate: false,
                            formatter: function (val) {
                                return change(val);
                            }
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table1);
            Table.api.bindevent(table2);
            table1.on("load-success.bs.table", function (e, data) {
                $(".search").hide();
            });
            table2.on("load-success.bs.table", function (e, data) {
                $(".search").hide();
            });

            const cur_date_s = $("#st").val();
            const cur_date_e = $("#et").val();

            EChartCur(Echarts, cur_date_s, cur_date_e).on("click", function (obj) {
                if (obj.name === "平均值" || obj.name === "" || obj.name === "最大值" || obj.name === "最小值") {
                    return;
                }
                let isp = "yd";
                if (obj.seriesName === "电信&联通") {
                    isp = "dxlt";
                }
                layer.open({
                    type: 1,
                    title: false,
                    content: `<div id="EChart_day" class="btn-refresh" style="height:400px;width:100%;padding:10px;"></div>`,
                    area: ['80%', '50%'],
                    success: function (o, i) {
                        let chart = Echarts.init(document.getElementById('EChart_day'), "walden");
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
                            legend: {
                                data: ["电信&联通", "移动"],
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
                                    name: "电信&联通",
                                    type: 'line',
                                    symbol: 'emptyCircle',
                                    symbolSize: 8,
                                    smooth: true,
                                    areaStyle: {
                                        normal: {
                                            color: "#78c8eb4a"
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
                                },
                                {
                                    name: "移动",
                                    type: 'line',
                                    symbol: 'emptyCircle',
                                    symbolSize: 8,
                                    smooth: true,
                                    areaStyle: {
                                        normal: {
                                            color: "#6fddce4a"
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
                        $.get("Dashboard2/get_chart_speed_date_detail?src=iqiyi&st=" + obj.name, function (resp) {
                            chart.hideLoading();
                            if (!resp.status) {
                                layer.alert("加载数据失败！");
                                return;
                            }
                            chart.setOption({
                                title: {text: '', subtext: resp.ret.date},
                                xAxis: {
                                    data: resp.ret.xAxis
                                },
                                series: [
                                    {
                                        data: resp.ret.data[0],
                                        markPoint: {
                                            data: [
                                                {type: 'max', name: '最大值'},
                                                {type: 'min', name: '最小值'},
                                                {
                                                    coord: [resp.ret.posi[0].date, resp.ret.posi[0].speed],
                                                    label: {
                                                        color: "#ff0000",
                                                        formatter: function (obj) {
                                                            return "日95 " + change(obj.data.coord[1], "")
                                                        }
                                                    },
                                                },
                                            ],
                                        }
                                    },

                                    {
                                        data: resp.ret.data[1],
                                        markPoint: {
                                            data: [
                                                {type: 'max', name: '最大值'},
                                                {type: 'min', name: '最小值'},
                                                {
                                                    coord: [resp.ret.posi[1].date, resp.ret.posi[1].speed],
                                                    label: {
                                                        color: "#ff0000",
                                                        formatter: function (obj) {
                                                            return "日95 " + change(obj.data.coord[1], "")
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
                })
            })
            EChartSys(Echarts, cur_date_s, cur_date_e).on("click", function (obj) {
                if (obj.name === "平均值" || obj.name === "" || obj.name === "最大值" || obj.name === "最小值") {
                    return;
                }
                let isp = "yd";
                if (obj.seriesName === "电信&联通") {
                    isp = "dxlt";
                }
                layer.open({
                    type: 1,
                    title: false,
                    content: `<div id="EChart_day" class="btn-refresh" style="height:400px;width:100%;padding:10px;"></div>`,
                    area: ['80%', '50%'],
                    success: function (o, i) {
                        let chart = Echarts.init(document.getElementById('EChart_day'), "walden");
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
                            legend: {
                                data: ["电信&联通", "移动"],
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
                                    name: "电信&联通",
                                    type: 'line',
                                    symbol: 'emptyCircle',
                                    symbolSize: 8,
                                    smooth: true,
                                    areaStyle: {
                                        normal: {
                                            color: "#78c8eb4a"
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
                                },
                                {
                                    name: "移动",
                                    type: 'line',
                                    symbol: 'emptyCircle',
                                    symbolSize: 8,
                                    smooth: true,
                                    areaStyle: {
                                        normal: {
                                            color: "#6fddce4a"
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
                        $.get("Dashboard2/get_chart_speed_date_detail?src=system_ware&st=" + obj.name, function (resp) {
                            chart.hideLoading();
                            if (!resp.status) {
                                layer.alert("加载数据失败！");
                                return;
                            }
                            chart.setOption({
                                title: {text: '', subtext: resp.ret.date},
                                xAxis: {
                                    data: resp.ret.xAxis
                                },
                                series: [
                                    {
                                        data: resp.ret.data[0],
                                        markPoint: {
                                            data: [
                                                {type: 'max', name: '最大值'},
                                                {type: 'min', name: '最小值'},
                                                {
                                                    coord: [resp.ret.posi[0].date, resp.ret.posi[0].speed],
                                                    label: {
                                                        color: "#ff0000",
                                                        formatter: function (obj) {
                                                            return "日95 " + change(obj.data.coord[1], "")
                                                        }
                                                    },
                                                },
                                            ],
                                        }
                                    },

                                    {
                                        data: resp.ret.data[1],
                                        markPoint: {
                                            data: [
                                                {type: 'max', name: '最大值'},
                                                {type: 'min', name: '最小值'},
                                                {
                                                    coord: [resp.ret.posi[1].date, resp.ret.posi[1].speed],
                                                    label: {
                                                        color: "#ff0000",
                                                        formatter: function (obj) {
                                                            return "日95 " + change(obj.data.coord[1], "")
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
                })
            })

            $("#search_r").on("click", function () {
                let st = $("#st").val();
                let et = $("#et").val();
                EChartCur(Echarts, st, et);
                EChartSys(Echarts, st, et);
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
                EChartCur(Echarts, st, et);
                EChartSys(Echarts, st, et);
            });
            $("#search_cur").on("click", function () {
                EChartCur(Echarts, cur_date_s, cur_date_e);
                EChartSys(Echarts, cur_date_s, cur_date_e);
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
                EChartCur(Echarts, st, et);
                EChartSys(Echarts, st, et);
            })
        }
    };

    function change(bytes, add) {
        bytes = bytes * 8;
        if (bytes === 0) return '0 bps';
        let k = 1000, i, sizes;
        sizes = ['b', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb', 'Eb', 'Zb', 'Yb'];
        i = Math.floor(Math.log(bytes) / Math.log(k));
        return (bytes / Math.pow(k, i)).toFixed(2) + ' ' + sizes[i] + (typeof (add) !== "undefined" ? add : "ps");
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

    function EChartCur(chart_obj, st, et) {
        let EChartCur = chart_obj.init(document.getElementById('EChartCur'), "walden");
        EChartCur.setOption({
            title: {text: '汇总拆线图【爱奇艺】', subtext: ''},
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
            legend: {
                data: ["电信&联通", "移动"],
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
                    name: "电信&联通",
                    type: 'line',
                    symbol: 'emptyCircle',
                    symbolSize: 8,
                    smooth: true,
                    areaStyle: {
                        normal: {
                            color: "#78c8eb4a"
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
                },
                {
                    name: "移动",
                    type: 'line',
                    symbol: 'emptyCircle',
                    symbolSize: 8,
                    smooth: true,
                    areaStyle: {
                        normal: {
                            color: "#6fddce4a"
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
        EChartCur.showLoading();
        $.get("Dashboard2/get_chart_speed_data?src=iqiyi&st=" + st + "&et=" + et + "&user_id=" + $("select[name=user_id] option:selected").val(), function (resp) {
            EChartCur.hideLoading();
            if (!resp.status) {
                return;
            }
            $("#st").val(st);
            $("#et").val(et);
            EChartCur.setOption({
                title: {text: '汇总拆线图【爱奇艺】', subtext: resp.ret.date},
                xAxis: {
                    data: resp.ret.xAxis
                },
                series: [
                    {
                        data: resp.ret.data[0],
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'},
                                {
                                    coord: [resp.ret.posi[0].date, resp.ret.posi[0].speed],
                                    label: {
                                        color: "#ff0000",
                                        formatter: function (obj) {
                                            return "95点 " + change(obj.data.coord[1], "")
                                        }
                                    },
                                },
                            ],
                        }
                    },
                    {
                        data: resp.ret.data[1],
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'},
                                {
                                    coord: [resp.ret.posi[1].date, resp.ret.posi[1].speed],
                                    label: {
                                        color: "#ff0000",
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
        return EChartCur
    }

    function EChartSys(chart_obj, st, et) {
        let EChartSys = Echarts.init(document.getElementById('EChartSys'), "walden");
        EChartSys.setOption({
            title: {text: '汇总拆线图【系统】', subtext: ''},
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
            legend: {
                data: ["电信&联通", "移动"],
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
                    name: "电信&联通",
                    type: 'line',
                    symbol: 'emptyCircle',
                    symbolSize: 8,
                    smooth: true,
                    areaStyle: {
                        normal: {
                            color: "#78c8eb4a"
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
                },
                {
                    name: "移动",
                    type: 'line',
                    symbol: 'emptyCircle',
                    symbolSize: 8,
                    smooth: true,
                    areaStyle: {
                        normal: {
                            color: "#6fddce4a"
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
        EChartSys.showLoading();
        $.get("Dashboard2/get_chart_speed_data?src=system_ware&st=" + st + "&et=" + et + "&user_id=" + $("select[name=user_id] option:selected").val(), function (resp) {
            EChartSys.hideLoading();
            if (!resp.status) {
                return;
            }
            $("#st").val(st);
            $("#et").val(et);
            EChartSys.setOption({
                title: {text: '汇总拆线图【系统】', subtext: resp.ret.date},
                xAxis: {
                    data: resp.ret.xAxis
                },
                series: [
                    {
                        data: resp.ret.data[0],
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'},
                                {
                                    coord: [resp.ret.posi[0].date, resp.ret.posi[0].speed],
                                    label: {
                                        color: "#ff0000",
                                        formatter: function (obj) {
                                            return "95点 " + change(obj.data.coord[1], "")
                                        }
                                    },
                                },
                            ],
                        }
                    },
                    {
                        data: resp.ret.data[1],
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'},
                                {
                                    coord: [resp.ret.posi[0].date, resp.ret.posi[0].speed],
                                    label: {
                                        color: "#ff0000",
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
        return EChartSys;
    }

    return Controller;
});
