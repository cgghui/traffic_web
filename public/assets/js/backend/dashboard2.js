define(['jquery', 'bootstrap', 'backend', 'addtabs', 'table', 'echarts', 'echarts-theme', 'template'], function ($, undefined, Backend, Datatable, Table, Echarts, undefined, Template) {

    function change(bytes) {
        bytes = bytes * 8;
        if (bytes === 0) return '0 bps';
        let k = 1000, i, sizes;
        sizes = ['bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps', 'Pbps', 'Ebps', 'Zbps', 'Ybps'];
        i = Math.floor(Math.log(bytes) / Math.log(k));
        return (bytes / Math.pow(k, i)).toFixed(2) + ' ' + sizes[i];
    }

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
                        {
                            field: '', title: '运营商', operate: false, formatter: function (val) {
                                return '电信&联通';
                            }
                        },
                        {field: 'id', title: 'id', sortable: true},
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
                        {
                            field: '', title: '运营商', operate: false, formatter: function (val) {
                                return '移动';
                            }
                        },
                        {field: 'id', title: 'id', sortable: true},
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
        }
    };

    return Controller;
});
