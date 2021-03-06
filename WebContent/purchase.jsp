<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
		<meta charset="utf-8" />
        <title></title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="author" />
        <%@include file="header.jsp"%>
        <link rel="shortcut icon" href="favicon.ico" />
        <style>
        	.searchTime{
        		display:none;
        	}
        </style>
	</head>

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
        <div class="page-wrapper">
        
            <div class="page-header navbar navbar-fixed-top">
                <div class="page-header-inner ">
                    
                    <!-- BEGIN LOGO -->
                    <div class="page-logo">
                        <a href="index.jsp">
                        	<label class="logo-default">xxxx</label>
						</a>
                        <div class="menu-toggler sidebar-toggler">
                            <span></span>
                        </div>
                    </div>
                    <!-- END LOGO -->
                    
                    <!-- BEGIN TOP NAVIGATION MENU -->
                    <div class="top-menu">
                        <ul class="nav navbar-nav pull-right">
                        	<li>xxx</li>
                        </ul>
                    </div>
                    <!-- END TOP NAVIGATION MENU -->
                    
                </div>
            </div>
            
            <!-- BEGIN CONTAINER -->
            <div class="page-container">
                
                <!-- BEGIN SIDEBAR -->
                <div class="page-sidebar-wrapper">
                    <div class="page-sidebar navbar-collapse collapse">
                        
                        <!-- BEGIN SIDEBAR MENU -->
                        <ul class="page-sidebar-menu  page-header-fixed " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 20px">
                        	<template v-for="(menu, i) in menu_list">
                        		<li class="nav-item" :class="{start: i == 1, active: menu.href==now_href, open: menu.href==now_href}">
	                                <a :href="menu.href" class="nav-link nav-toggle">
	                                    <i :class="menu.span_icon"></i>
	                                    <span class="title" v-text="menu.title"></span>
	                                    <span class="selected"></span>
	                                    <span class="arrow"></span>
	                                </a>
	                                <ul v-if="menu.children" class="sub-menu" style="display: none;">
										<li v-for="child in menu.children">
											<a :href="child.href">
												<i :class="child.span_icon" ></i>((child.title))
											</a>
										</li>
									</ul>
	                            </li>
                        	</template>
                        </ul>
                        <!-- END SIDEBAR MENU -->
                        
                    </div>
                </div>
                <!-- END SIDEBAR -->
                
                <!-- BEGIN CONTENT -->
                <div class="page-content-wrapper">
                    <div class="page-content">

                        <!-- BEGIN PAGE BAR -->
                        <div class="page-bar">
                            <ul class="page-breadcrumb">
                                <li>
                                    <a href="index.jsp">Home</a>
                                    <i class="fa fa-angle-right"></i>
                                </li>
                                <li>
                                    <span>采购管理</span>
                                </li>
                            </ul>
                            <div class="page-toolbar">
                                <div id="dashboard-report-range" class="pull-right tooltips btn btn-sm" data-container="body" data-placement="bottom" data-original-title="Change dashboard date range">
                                    <i class="icon-calendar"></i>&nbsp;
                                    <span class="thin uppercase hidden-xs"></span>&nbsp;
                                    <i class="fa fa-angle-down"></i>
                                </div>
                            </div>
                        </div>
                        <!-- END PAGE BAR -->
                        
                        <!-- BEGIN PAGE TITLE-->
                        <h1 class="page-title"> PURCHASE
                            <small>采购单管理</small>
                        </h1>
                        
                        <!-- BEGIN PAGE MAIN-->
                        <div class="row">
                        	<div class="col-md-12">
                        	
                        		<!-- BEGIN TABLE-->
                        		<div class="portlet box green">
                        			<div class="portlet-title">
                        				<div class="caption">
                        					<i class="fa fa-globe"></i>采购单列表
                        				</div>
                        				<div class="tools">
                                            <span class="btn-refresh"><i class="fa fa-refresh"></i></span>
                                        </div>
                        			</div>
                        			<div class="portlet-body flip-scroll">
                        				<div class="row table-tool">
											<div class="col-md-12">
												<input type="search" placeholder="采购单号" class="form-control input-small input-inline" onchange="vue.purchaseID=this.value" onkeyup="if(event.keyCode==13){;init_table()}">
												<input type="text" id="purchase_time" placeholder="采购时间" class="form-control input-inline" style="width: 340px;"/>
												<input class="searchTime" id="startTime" />
												<input class="searchTime" id="endTime" />
												<button type="button" class="btn btn-success btn-search"><i class="fa fa-search"></i>&nbsp;&nbsp;搜索</button>
												<button type="button" class="btn btn-danger btn-add"><i class="fa fa-plus"></i>&nbsp;&nbsp;新增</button>
												<button type="button" class="btn blue btn-export"><i class="fa fa-sign-in"></i>&nbsp;&nbsp;导出</button>
											</div>
										</div>
                        				<table class="table table-bordered table-striped dataTable table-condensed flip-content" id="table">
                        					<thead class="flip-content">
                        						<tr>
                        							<th text-align="center"></th>
                        							<th>采购单号</th>
													<th>采购时间</th>
													<th>采购总额</th>
													<th>状态</th>
													<th>操作</th>
												</tr>
                        					</thead>
                        					<tbody>
                        						<template v-for="purchase in data">
	                        						<tr :key="purchase.id">
	                        							<td style="vertical-align: inherit;text-align: center;">
	                        								<span class="row-detail row-detail-close"></span>
	                        							</td>
	                        							<td v-text="purchase[0].id"></td>
														<td v-text="purchase[0].time"></td>
														<td>￥((purchase[0].total_price))</td>
														<td>
															<span v-if="purchase[0].status == 2">废弃</span>
														</td>
														<td>
															<button v-if="purchase[0].status==1" class="btn btn-sm red btn-outline filter-submit margin-bottom" @click="deleted(purchase[0].id)"><i class="fa fa-times"></i>&nbsp;&nbsp;废弃</button>
														</td>
													</tr>
													<tr style="display: none;">
														<td colspan="6">
															<table class="table table-striped table-hover">
																<thead>
																	<tr>
																		<th width="60"></th>
																		<td>商品名称</td>
																		<td>数量</td>
																		<td>采购单价</td>
																		<td>总价格</td>
																	</tr>
																</thead>
																<tbody>
																	<tr v-for="item in purchase">
																		<td></td>
																		<td>((item.milk_name))</td>
																		<td>((item.quantity))件</td>
																		<td>￥((item.price))</td>
																		<td>￥((item.total_amount))</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
												</template>
                        					</tbody>
                        				</table>
                        				<div class="bottom-tool row">
											<wear-paginate></wear-paginate>
										</div>
                        			</div>
                        		</div>
                        		<!-- END TABLE-->
                        		
                        	</div>
                        </div>
                        
                        <!-- END PAGE MAIN-->
                        
                        
                    </div>
                </div>
                <!-- END CONTENT -->
                
            </div>
            <!-- END CONTAINER -->
            
            <!-- BEGIN FOOTER -->
            <div class="page-footer"></div>
            <!-- END FOOTER -->
            
        </div>
		<!-- BEGIN Layer -->
		<div id="layer-export" style="display:none">
			<div class="col-mid-6">
				<form class="layer-form" data-parsley-validate onsubmit="return false">
					<table>
						<tr>
							<td width="70">采购时间</td>
							<td><input name="export_time" id="export_time"/><span class="red"> *</span></td>
						</tr>
					</table>
					<input style="display:none" id="exportStartTime"/>
					<input style="display:none" id="exportEndTime"/>
					<div class="layer-button">
						<input type="button" class="btn btn-danger btn-submit btn-export-sure" value="确定"/>
					<button type="button" class="btn grey-cascade btn-cancle" >取消</button>
					</div>
				</form>
			</div>
		</div>
		<!-- END Layer -->
        <script src="static/js/common.js" type="text/javascript"></script>
        <script src="static/js/paginate_tool.js" type="text/javascript"></script>
        <script>
        var vue = new Vue({
			delimiters:['((', '))'],
			el:'#table',
			data:{
				purchaseID: '',
				data: []
			},
			methods:{
				deleted: function(id){
					$.ajax({
						type:"post",
						url:"purchase/updatePurchaseOff.action",
						data:{"purchaseID": id},
						success:function(data){
							data = eval("("+data+")");
							layer.msg(data.message);
							if(data.succ){
								init_table();
							}
						}
					})
				},
			}
		})
	
		
		$(function(){
			init_table();
			$('.btn-add').on('click', function(){
				location.href="addPurchase.jsp";
			});
			
			$(".btn-cancle").on('click', function(){
				layer.closeAll();
				edit_vue.edit_data = null;
			})
			
			$('.btn-search').on('click', function(){
				init_table();
			})
			
			$('.btn-refresh').on('click', function(){
				init_table();
			})
			
			$("#purchase_time").on("keydown", function(event){
				if(event.keyCode == 8){
					$("#purchase_time").val("");
					$("#startTime").val('');
					$("#endTime").val("");
				}
				else{
					layer.msg("无法输入，请选择日期");
					return false;
				}
			})
			
			$("tbody").on('click', ".row-detail", function(){
				if(this.className.indexOf("row-detail-close") > 0){
					this.className = "row-detail row-detail-open";
					$(this).parents("tr").next("tr").show(500);
				}
				else if(this.className.indexOf("row-detail-open") > 0){
					this.className = "row-detail row-detail-close";
					$(this).parents("tr").next("tr").hide(500);
				}
			});
			
			/*导出*/
			$(".btn-export").click(function(){
				layer.open({
					type: '1',
					skin: 'layui-layer-molv',
					title: '导出',
					area: ['362px', '200px'],
					content: $('#layer-export')
				})
			});
			
			$(".btn-export-sure").on("click",function(){
				var startTime = $("#exportStartTime").val();
				var endTime = $("#exportEndTime").val();
				$.ajax({
					type: 'post',
					url: 'report/exportExcel.action',
					data:{
						'startTime': startTime,
						'endTime': endTime,
						'type': 1
					},
					beforeSend:function(){
						layer.load(1, {
							shade: [0.1, '#fff']
						});
					},
					error: function(){
						layer.closeAll("loading");
					},
					success:function(data){
						layer.closeAll("loading");
						data = eval("("+data+")");
						layer.msg(data.message);
					}
				})
			});
			

			$("#purchase_time").daterangepicker({
                showDropdowns: true,
				autoUpdateInput: false,
				showWeekNumbers: false,
				linkedCalendars: false,
				drops: "down",
				"locale": {
                    format: 'YYYY-MM-DD',
                    applyLabel: "应用",
                    cancelLabel: "取消",
                    daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ], 
                    monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',  
                                   '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                }
			},
            function(start, end, label){
				if(!this.startDate)
                	$("#purchase_time").val('');
				else{
					$("#purchase_time").val(this.startDate.format(this.locale.format) + " 至 " + this.endDate.format("YYYY-MM-DD"));
					$("#startTime").val(this.startDate.format(this.locale.format));
					$("#endTime").val(this.endDate.format("YYYY-MM-DD"));
				}
            });
			
			$("#purchase_time").on('apply.daterangepicker', function(ev, picker) {
				$("#purchase_time").val(picker.startDate.format('YYYY-MM-DD') + " 至 " + picker.endDate.format("YYYY-MM-DD"));
				$("#startTime").val(picker.startDate.format('YYYY-MM-DD'));
				$("#endTime").val(picker.endDate.format("YYYY-MM-DD"));
            });
			
			
			$("#export_time").daterangepicker({
                showDropdowns: true,
				autoUpdateInput: false,
				showWeekNumbers: false,
				linkedCalendars: false,
				drops: "down",
				"locale": {
                    format: 'YYYY-MM-DD',
                    applyLabel: "应用",
                    cancelLabel: "取消",
                    daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ], 
                    monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',  
                                   '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                }
			},
            function(start, end, label){
				if(!this.startDate)
                	$("#export_time").val('');
				else{
					$("#export_time").val(this.startDate.format(this.locale.format) + " 至 " + this.endDate.format("YYYY-MM-DD"));
					$("#exportStartTime").val(this.startDate.format(this.locale.format));
					$("#exportEndTime").val(this.endDate.format("YYYY-MM-DD"));
				}
            });
			
			$("#export_time").on('apply.daterangepicker', function(ev, picker) {
				$("#export_time").val(picker.startDate.format('YYYY-MM-DD') + " 至 " + picker.endDate.format("YYYY-MM-DD"));
				$("#exportStartTime").val(picker.startDate.format('YYYY-MM-DD'));
				$("#exportEndTime").val(picker.endDate.format("YYYY-MM-DD"));
            });
		});
        
		function init_add_layer(){
			$("#number").val("");
			$("#milk_name").val("");
			$("#purchase_price").val("");
			$("#selling_price").val("");
		}        
		
		function init_table(rows, page){
			if(typeof(rows) == 'undefined')
				rows = 10;
			if(typeof(page) == 'undefined')
				page = 1;
			var startTime = $("#startTime").val();
			var endTime = $("#endTime").val();
			$.ajax({
				type:'get',
				url:'purchase/getPurchaseByConditon.action',
				data:{
					rows: rows,
					page: page,
					purchaseID: vue.purchaseID,
					startTime: startTime,
					endTime: endTime
				},
				success:function(data){
					data = eval("("+data+")");
					pager = eval("("+data.pager+")");
					//一共生成多少页
					paginate_tool.init("init_table", pager, []);
					
					vue.data = data.datas;
					layer.closeAll('loading');
				},
				beforeSend:function(){
					layer.load(1, {
						shade: [0.1, '#fff']
					});
				},
				error: function(){
					layer.closeAll("loading");
				}
				
			})
		}
        </script>
    </body>

</html>