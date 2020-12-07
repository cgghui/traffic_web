define(['fast', 'template', 'moment'], function (Fast, Template, Moment) {
    var Backend = {
        api: {
            sidebar: function (params) {
                colorArr = ['red', 'green', 'yellow', 'blue', 'teal', 'orange', 'purple'];
                $colorNums = colorArr.length;
                badgeList = {};
                $.each(params, function (k, v) {
                    $url = Fast.api.fixurl(k);

                    if ($.isArray(v)) {
                        $nums = typeof v[0] !== 'undefined' ? v[0] : 0;
                        $color = typeof v[1] !== 'undefined' ? v[1] : colorArr[(!isNaN($nums) ? $nums : $nums.length) % $colorNums];
                        $class = typeof v[2] !== 'undefined' ? v[2] : 'label';
                    } else {
                        $nums = v;
                        $color = colorArr[(!isNaN($nums) ? $nums : $nums.length) % $colorNums];
                        $class = 'label';
                    }
                    //必须nums大于0才显示
                    badgeList[$url] = $nums > 0 ? '<small class="' + $class + ' pull-right bg-' + $color + '">' + $nums + '</small>' : '';
                });
                $.each(badgeList, function (k, v) {
                    var anchor = top.window.$("li a[addtabs][url='" + k + "']");
                    if (anchor) {
                        top.window.$(".pull-right-container", anchor).html(v);
                        top.window.$(".nav-addtabs li a[node-id='" + anchor.attr("addtabs") + "'] .pull-right-container").html(v);
                    }
                });
            },
            addtabs: function (url, title, icon) {
                var dom = "a[url='{url}']"
                var leftlink = top.window.$(dom.replace(/\{url\}/, url));
                if (leftlink.size() > 0) {
                    leftlink.trigger("click");
                } else {
                    url = Fast.api.fixurl(url);
                    leftlink = top.window.$(dom.replace(/\{url\}/, url));
                    if (leftlink.size() > 0) {
                        var event = leftlink.parent().hasClass("active") ? "dblclick" : "click";
                        leftlink.trigger(event);
                    } else {
                        var baseurl = url.substr(0, url.indexOf("?") > -1 ? url.indexOf("?") : url.length);
                        leftlink = top.window.$(dom.replace(/\{url\}/, baseurl));
                        //能找到相对地址
                        if (leftlink.size() > 0) {
                            icon = typeof icon !== 'undefined' ? icon : leftlink.find("i").attr("class");
                            title = typeof title !== 'undefined' ? title : leftlink.find("span:first").text();
                            leftlink.trigger("fa.event.toggleitem");
                        }
                        var navnode = top.window.$(".nav-tabs ul li a[node-url='" + url + "']");
                        if (navnode.size() > 0) {
                            navnode.trigger("click");
                        } else {
                            //追加新的tab
                            var id = Math.floor(new Date().valueOf() * Math.random());
                            icon = typeof icon !== 'undefined' ? icon : 'fa fa-circle-o';
                            title = typeof title !== 'undefined' ? title : '';
                            top.window.$("<a />").append('<i class="' + icon + '"></i> <span>' + title + '</span>').prop("href", url).attr({
                                url: url,
                                addtabs: id
                            }).addClass("hide").appendTo(top.window.document.body).trigger("click");
                        }
                    }
                }
            },
            closetabs: function (url) {
                if (typeof url === 'undefined') {
                    top.window.$("ul.nav-addtabs li.active .close-tab").trigger("click");
                } else {
                    var dom = "a[url='{url}']"
                    var navlink = top.window.$(dom.replace(/\{url\}/, url));
                    if (navlink.size() === 0) {
                        url = Fast.api.fixurl(url);
                        navlink = top.window.$(dom.replace(/\{url\}/, url));
                        if (navlink.size() === 0) {
                        } else {
                            var baseurl = url.substr(0, url.indexOf("?") > -1 ? url.indexOf("?") : url.length);
                            navlink = top.window.$(dom.replace(/\{url\}/, baseurl));
                            //能找到相对地址
                            if (navlink.size() === 0) {
                                navlink = top.window.$(".nav-tabs ul li a[node-url='" + url + "']");
                            }
                        }
                    }
                    if (navlink.size() > 0 && navlink.attr('addtabs')) {
                        top.window.$("ul.nav-addtabs li#tab_" + navlink.attr('addtabs') + " .close-tab").trigger("click");
                    }
                }
            },
            replaceids: function (elem, url) {
                //如果有需要替换ids的
                if (url.indexOf("{ids}") > -1) {
                    var ids = 0;
                    var tableId = $(elem).data("table-id");
                    if (tableId && $("#" + tableId).size() > 0 && $("#" + tableId).data("bootstrap.table")) {
                        var Table = require("table");
                        ids = Table.api.selectedids($("#" + tableId)).join(",");
                    }
                    url = url.replace(/\{ids\}/g, ids);
                }
                return url;
            },
            refreshmenu: function () {
                top.window.$(".sidebar-menu").trigger("refresh");
            },
            gettablecolumnbutton: function (options) {
                if (typeof options.tableId !== 'undefined' && typeof options.fieldIndex !== 'undefined' && typeof options.buttonIndex !== 'undefined') {
                    var tableOptions = $("#" + options.tableId).bootstrapTable('getOptions');
                    if (tableOptions) {
                        var columnObj = null;
                        $.each(tableOptions.columns, function (i, columns) {
                            $.each(columns, function (j, column) {
                                if (typeof column.fieldIndex !== 'undefined' && column.fieldIndex === options.fieldIndex) {
                                    columnObj = column;
                                    return false;
                                }
                            });
                            if (columnObj) {
                                return false;
                            }
                        });
                        if (columnObj) {
                            return columnObj['buttons'][options.buttonIndex];
                        }
                    }
                }
                return null;
            },
        },
        init: function () {
            //公共代码
            //添加ios-fix兼容iOS下的iframe
            if (/iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream) {
                $("html").addClass("ios-fix");
            }
            //配置Toastr的参数
            Toastr.options.positionClass = Config.controllername === 'index' ? "toast-top-right-index" : "toast-top-right";
            //点击包含.btn-dialog的元素时弹出dialog
            $(document).on('click', '.btn-dialog,.dialogit', function (e) {
                var that = this;
                var options = $.extend({}, $(that).data() || {});
                var url = Backend.api.replaceids(that, $(that).data("url") || $(that).attr('href'));
                var title = $(that).attr("title") || $(that).data("title") || $(that).data('original-title');
                var button = Backend.api.gettablecolumnbutton(options);
                if (button && typeof button.callback === 'function') {
                    options.callback = button.callback;
                }
                if (typeof options.confirm !== 'undefined') {
                    Layer.confirm(options.confirm, function (index) {
                        Backend.api.open(url, title, options);
                        Layer.close(index);
                    });
                } else {
                    window[$(that).data("window") || 'self'].Backend.api.open(url, title, options);
                }
                return false;
            });
            //点击包含.btn-addtabs的元素时新增选项卡
            $(document).on('click', '.btn-addtabs,.addtabsit', function (e) {
                var that = this;
                var options = $.extend({}, $(that).data() || {});
                var url = Backend.api.replaceids(that, $(that).data("url") || $(that).attr('href'));
                var title = $(that).attr("title") || $(that).data("title") || $(that).data('original-title');
                var icon = $(that).attr("icon") || $(that).data("icon");
                if (typeof options.confirm !== 'undefined') {
                    Layer.confirm(options.confirm, function (index) {
                        Backend.api.addtabs(url, title, icon);
                        Layer.close(index);
                    });
                } else {
                    Backend.api.addtabs(url, title, icon);
                }
                return false;
            });
            //点击包含.btn-ajax的元素时发送Ajax请求
            $(document).on('click', '.btn-ajax,.ajaxit', function (e) {
                var that = this;
                var options = $.extend({}, $(that).data() || {});
                if (typeof options.url === 'undefined' && $(that).attr("href")) {
                    options.url = $(that).attr("href");
                }
                options.url = Backend.api.replaceids(this, options.url);
                var success = typeof options.success === 'function' ? options.success : null;
                var error = typeof options.error === 'function' ? options.error : null;
                delete options.success;
                delete options.error;
                var button = Backend.api.gettablecolumnbutton(options);
                if (button) {
                    if (typeof button.success === 'function') {
                        success = button.success;
                    }
                    if (typeof button.error === 'function') {
                        error = button.error;
                    }
                }
                //如果未设备成功的回调,设定了自动刷新的情况下自动进行刷新
                if (!success && typeof options.tableId !== 'undefined' && typeof options.refresh !== 'undefined' && options.refresh) {
                    success = function () {
                        $("#" + options.tableId).bootstrapTable('refresh');
                    }
                }
                if (typeof options.confirm !== 'undefined') {
                    Layer.confirm(options.confirm, function (index) {
                        Backend.api.ajax(options, success, error);
                        Layer.close(index);
                    });
                } else {
                    Backend.api.ajax(options, success, error);
                }
                return false;
            });
            $(document).on('click', '.btn-click,.clickit', function (e) {
                var that = this;
                var options = $.extend({}, $(that).data() || {});
                var row = {};
                if (typeof options.tableId !== 'undefined') {
                    var index = parseInt(options.rowIndex);
                    var data = $("#" + options.tableId).bootstrapTable('getData');
                    row = typeof data[index] !== 'undefined' ? data[index] : {};
                }
                var button = Backend.api.gettablecolumnbutton(options);
                var click = typeof button.click === 'function' ? button.click : $.noop;

                if (typeof options.confirm !== 'undefined') {
                    Layer.confirm(options.confirm, function (index) {
                        click.apply(that, [options, row, button]);
                        Layer.close(index);
                    });
                } else {
                    click.apply(that, [options, row, button]);
                }
                return false;
            });
            //修复含有fixed-footer类的body边距
            if ($(".fixed-footer").size() > 0) {
                $(document.body).css("padding-bottom", $(".fixed-footer").outerHeight());
            }
            //修复不在iframe时layer-footer隐藏的问题
            if ($(".layer-footer").size() > 0 && self === top) {
                $(".layer-footer").show();
            }
            //tooltip和popover
            if (!('ontouchstart' in document.documentElement)) {
                $('body').tooltip({selector: '[data-toggle="tooltip"]'});
            }
            $('body').popover({selector: '[data-toggle="popover"]'});
            //
            const KVal = ["电信", "联通", "移动", "dx", "lt", "yd"];
            let LayerBox, log, i, log_html, CurrentTask;
            $("#bolt_manager").on("click", function () {
                layer.open({
                    type: 1,
                    title: "快捷操作",
                    content: $("#bolt_manager_btn").html(),
                    area: ['50%', '70%'],
                    success: function (o, i) {
                        o.find(".btn-manager").on("click", function () {
                            const id_name = "#" + $(this).attr("id") + "_box";
                            o.find("#html_box").html($(id_name).html());
                            CurrentTask = $(this).attr("task_name");
                            get_task_log(o, $(this).attr("task_name"), o.find("#html_box").find(".run_task_btn:eq(0)"));
                        });
                        o.find(".btn-manager:eq(0)").trigger("click");
                        LayerBox = o;
                    }
                });
            });
            $("body")
                .on("click", "#run_add_batch", function () {
                    let btn = $(this);
                    let ele = btn.parent();
                    let textVal = ele.find("#add_batch_val").val(), isOK, i;
                    if (textVal === "") {
                        layer.alert(`请键入`);
                        return;
                    }
                    isOK = true;
                    textVal = textVal.split("\n");
                    for (i = 0; i < textVal.length; i++) {
                        let kv = textVal[i].split(","), j, ok
                        if (kv.length !== 2) {
                            layer.alert(`"${textVal[i]}" 格式错误`);
                            isOK = false;
                            return;
                        }
                        if (kv[0] === "") {
                            layer.alert(`"${textVal[i]}" 设备编号不可为空`);
                            isOK = false;
                            return;
                        }
                        ok = true;
                        for (j = 0; j < KVal.length; j++) {
                            if (kv[1] === KVal[j]) {
                                ok = true;
                                break;
                            }
                            ok = false;
                        }
                        if (!ok) {
                            layer.alert(`"${textVal[i]}" 运营商设置不正确`);
                            isOK = false;
                            return;
                        }
                    }
                    if (!isOK) {
                        return;
                    }
                    textVal = textVal.join("|");
                    $.get(`Dashboard2/add_iqiyi_devices?devs=${textVal}`, function (resp) {
                        LayerBox.find("#html_box_message").html("");
                        if (resp.status) {
                            LayerBox.find("#html_box_message").html("<p style='color:green'>任务添加成功</p>");
                        } else {
                            LayerBox.find("#html_box_message").html(`<p style='color:green'>任务添加失败，${resp.msg}</p>`);
                        }
                        setTimeout(function () {
                            get_task_log(LayerBox, "add_iqiyi_devices", btn);
                        }, 1000);
                    }, "json");
                })
                .on("click", "#run_iqiyi_collect", function () {
                    let btn = $(this);
                    let ele = btn.parent();
                    let textVal = ele.find("#iqiyi_collect_val").val(), isOK, i;
                    if (textVal === "") {
                        layer.alert(`请键入`);
                        return;
                    }
                    textVal = textVal.split("\n");
                    textVal = textVal.join(",");
                    $.get(`Dashboard2/iqiyi_collect?devs=${textVal}`, function (resp) {
                        LayerBox.find("#html_box_message").html("");
                        if (resp.status) {
                            LayerBox.find("#html_box_message").html("<p style='color:green'>任务添加成功</p>");
                        } else {
                            LayerBox.find("#html_box_message").html(`<p style='color:green'>任务添加失败，${resp.msg}</p>`);
                        }
                        setTimeout(function () {
                            get_task_log(LayerBox, "iqiyi_collect", btn);
                        }, 1000);
                    }, "json");
                })
                .on("click", "#run_iqiyi_collect_all", function () {
                    let btn = $(this);
                    $.get(`Dashboard2/iqiyi_collect_all`, function (resp) {
                        LayerBox.find("#html_box_message").html("");
                        if (resp.status) {
                            LayerBox.find("#html_box_message").html("<p style='color:green'>任务添加成功</p>");
                        } else {
                            LayerBox.find("#html_box_message").html(`<p style='color:green'>任务添加失败，${resp.msg}</p>`);
                        }
                        setTimeout(function () {
                            get_task_log(LayerBox, "iqiyi_collect_all", btn);
                        }, 1000);
                    }, "json");
                })
                .on("click", "#run_daily_network_count", function () {
                    let btn = $(this);
                    let ele = btn.parent().parent();
                    let year_month = ele.find("#dnc_year_month").val(),
                        data_src = ele.find("#dnc_data_src").val();
                    if (year_month === "") {
                        layer.alert(`请键入日期`);
                        return;
                    }
                    if (data_src === "") {
                        layer.alert(`请键入数据源`);
                        return;
                    }
                    if (data_src !== "iqiyi" && data_src !== "system_ware") {
                        layer.alert(`数据源，仅可以设置为：iqiyi和system_ware`);
                        return;
                    }
                    $.get(`Dashboard2/daily_network_count?date=` + year_month + `&src=` + data_src, function (resp) {
                        LayerBox.find("#html_box_message").html("");
                        if (resp.status) {
                            LayerBox.find("#html_box_message").html("<p style='color:green'>任务添加成功</p>");
                        } else {
                            LayerBox.find("#html_box_message").html(`<p style='color:green'>任务添加失败，${resp.msg}</p>`);
                        }
                        setTimeout(function () {
                            get_task_log(LayerBox, "daily_network_count", btn);
                        }, 1000);
                    }, "json");
                })
                .on("click", "#run_daily_network_count95", function () {
                    let btn = $(this);
                    let ele = btn.parent().parent();
                    let year_month = ele.find("#dnc95_year_month").val(),
                        data_type = ele.find("#dnc95_type").val();
                    if (year_month === "") {
                        layer.alert(`请键入日期`);
                        return;
                    }
                    if (data_type === "") {
                        layer.alert(`请键入类型 m或d`);
                        return;
                    }
                    if (data_type !== "m" && data_type !== "d") {
                        layer.alert(`类型，仅可以设置为：m和d`);
                        return;
                    }
                    $.get(`Dashboard2/daily_network_count95?type=` + data_type + `&date=` + year_month, function (resp) {
                        LayerBox.find("#html_box_message").html("");
                        if (resp.status) {
                            LayerBox.find("#html_box_message").html("<p style='color:green'>任务添加成功</p>");
                        } else {
                            LayerBox.find("#html_box_message").html(`<p style='color:green'>任务添加失败，${resp.msg}</p>`);
                        }
                        setTimeout(function () {
                            get_task_log(LayerBox, "daily_network_count95", btn);
                        }, 1000);
                    }, "json");
                })
                .on("click", "#run_reset_device_count", function () {
                    let btn = $(this);
                    $.get(`Dashboard2/reset_device_count`, function (resp) {
                        LayerBox.find("#html_box_message").html("");
                        if (resp.status) {
                            LayerBox.find("#html_box_message").html("<p style='color:green'>任务添加成功</p>");
                        } else {
                            LayerBox.find("#html_box_message").html(`<p style='color:green'>任务添加失败，${resp.msg}</p>`);
                        }
                        setTimeout(function () {
                            get_task_log(LayerBox, "reset_device_count", btn);
                        }, 1000);
                    }, "json");
                })
                .on("click", "#run_backup_data", function () {
                    let btn = $(this), del, ele;
                    ele = $(this).parents("#html_box");
                    if (ele.find("#history_del").prop("checked")) {
                        del = "on";
                    } else {
                        del = "off";
                    }
                    $.get(`Dashboard2/backup_data?date=` + ele.find("#backup_date").val() + `&del=` + del, function (resp) {
                        LayerBox.find("#html_box_message").html("");
                        if (resp.status) {
                            LayerBox.find("#html_box_message").html("<p style='color:green'>任务添加成功</p>");
                        } else {
                            LayerBox.find("#html_box_message").html(`<p style='color:green'>任务添加失败，${resp.msg}</p>`);
                        }
                        setTimeout(function () {
                            get_task_log(LayerBox, "backup_data", btn);
                        }, 1000);
                    }, "json");
                })
                .on("click", "#run_restore", function () {
                    let btn = $(this), new_table, ele;
                    ele = $(this).parents("#html_box");
                    new_table = ele.find("#new_table").prop("checked") ? "on" : "off";
                    $.get(`Dashboard2/restore_db?date=` + ele.find("#restore_date").val() + `&new_table=` + new_table + `&device=` + url_encode(ele.find("#restore_device").val()), function (resp) {
                        LayerBox.find("#html_box_message").html("");
                        if (resp.status) {
                            LayerBox.find("#html_box_message").html("<p style='color:green'>任务添加成功</p>");
                        } else {
                            LayerBox.find("#html_box_message").html(`<p style='color:green'>任务添加失败，${resp.msg}</p>`);
                        }
                        setTimeout(function () {
                            get_task_log(LayerBox, "restore", btn);
                        }, 1000);
                    }, "json");
                });

            function url_encode(clearString) {
                var output = '';
                var x = 0;

                clearString = utf16to8(clearString.toString());
                var regex = /(^[a-zA-Z0-9-_.]*)/;

                while (x < clearString.length) {
                    var match = regex.exec(clearString.substr(x));
                    if (match != null && match.length > 1 && match[1] != '') {
                        output += match[1];
                        x += match[1].length;
                    } else {
                        if (clearString[x] == ' ')
                            output += '+';
                        else {
                            var charCode = clearString.charCodeAt(x);
                            var hexVal = charCode.toString(16);
                            output += '%' + (hexVal.length < 2 ? '0' : '') + hexVal.toUpperCase();
                        }
                        x++;
                    }
                }

                function utf16to8(str) {
                    var out, i, len, c;

                    out = "";
                    len = str.length;
                    for (i = 0; i < len; i++) {
                        c = str.charCodeAt(i);
                        if ((c >= 0x0001) && (c <= 0x007F)) {
                            out += str.charAt(i);
                        } else if (c > 0x07FF) {
                            out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
                            out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F));
                            out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
                        } else {
                            out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F));
                            out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
                        }
                    }
                    return out;
                }

                return output;
            }

            function get_task_log(box, task_name, btn) {
                if (task_name === "iqiyi_collect_all" || task_name === "reset_device_count" || task_name === "backup_data" || task_name === "restore") {
                    box.find("#html_box_message").css("height", "400px");
                } else if (task_name === "iqiyi_collect") {
                    box.find("#html_box_message").css("height", "190px");
                } else if (task_name === "add_iqiyi_devices") {
                    box.find("#html_box_message").css("height", "168px");
                } else if (task_name === "daily_network_count95" || task_name === "daily_network_count") {
                    box.find("#html_box_message").css("height", "382px");
                } else {
                    box.find("#html_box_message").css("height", "150px");
                }
                if (CurrentTask !== task_name) {
                    return;
                }
                $.get(`Dashboard2/get_task_logs?name=${task_name}`, function (resp) {
                    if (!resp.status) {
                        box.find("#html_box_message").prepend("<p style='color:red'>读取执行记录失败.</p>");
                        return;
                    }
                    if (resp.result == null) {
                        btn.removeClass("btn-disabled disabled");
                        box.find("#html_box_message").html("");
                        return;
                    }
                    log = resp.result.reverse();
                    log_html = ""
                    if (resp.running) {
                        btn.addClass("btn-disabled disabled");
                        log_html = "<p style='color:green'>任务正在执行中...</p>"
                    } else {
                        btn.removeClass("btn-disabled disabled");
                        log_html = "<p style='color:orangered'>任务已执行完毕</p>"
                    }
                    for (i = 0; i < log.length; i++) {
                        log_html += `<p>${log[i]}</p>`
                    }
                    box.find("#html_box_message").html(log_html);
                    if (!resp.running) {
                        return;
                    }
                    setTimeout(function () {
                        get_task_log(box, task_name, btn);
                    }, 1000)
                }, "json");
            }
        }
    };
    Backend.api = $.extend(Fast.api, Backend.api);
    //将Template渲染至全局,以便于在子框架中调用
    window.Template = Template;
    //将Moment渲染至全局,以便于在子框架中调用
    window.Moment = Moment;
    //将Backend渲染至全局,以便于在子框架中调用
    window.Backend = Backend;

    Backend.init();
    return Backend;
});