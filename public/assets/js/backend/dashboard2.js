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

            EChartCur(Echarts, "", "").on("click", function (obj) {
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
                                    },

                                    {
                                        data: resp.ret.data[1],
                                    }
                                ]
                            });
                        }, "json");
                    }
                })
            })
            EChartSys(Echarts, "", "").on("click", function (obj) {
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
                                    },

                                    {
                                        data: resp.ret.data[1],
                                    }
                                ]
                            });
                        }, "json");
                    }
                })
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
        $.get("Dashboard2/get_chart_speed_data?src=iqiyi&st=" + st + "&et=" + et, function (resp) {
            EChartCur.hideLoading();
            if (!resp.status) {
                $('#EChartCur').hide();
                return;
            }
            EChartCur.setOption({
                title: {text: '汇总拆线图【爱奇艺】', subtext: resp.ret.date},
                xAxis: {
                    data: resp.ret.xAxis
                },
                series: [
                    {
                        data: resp.ret.data[0]
                    },
                    {
                        data: resp.ret.data[1]
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
        $.get("Dashboard2/get_chart_speed_data?src=system_ware&st=" + st + "&et=" + et, function (resp) {
            EChartSys.hideLoading();
            if (!resp.status) {
                return;
            }
            EChartSys.setOption({
                title: {text: '汇总拆线图【系统】', subtext: resp.ret.date},
                xAxis: {
                    data: resp.ret.xAxis
                },
                series: [
                    {
                        data: resp.ret.data[0]
                    },
                    {
                        data: resp.ret.data[1]
                    }
                ]
            });
        }, "json");
        return EChartSys;
    }

    return Controller;
});
