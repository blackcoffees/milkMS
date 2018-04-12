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
        <style type="text/css">
        	.searchDateInput{
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
                        	<label class="logo-default" style="font-size:25px;margin-top:7px;color:white;font-family:'仿宋'">超市管理系统</label>
						</a>
                        <div class="menu-toggler sidebar-toggler">
                            <span></span>
                        </div>
                    </div>
                    <!-- END LOGO -->
                    
                    <!-- BEGIN TOP NAVIGATION MENU -->
                    <div class="page-logo" style="float:right;">
                        <a href="settle.jsp">
                        	<i class="icon-login"></i>
                        	<label class="logo-default">进入收银</label>
						</a>
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
                        		<li class="nav-item" :class="{start: i == 1, active: menu.href=='javascript:void(0)', open: menu.href=='javascript:void(0)'}">
	                                <a :href="menu.href" class="nav-link nav-toggle">
	                                    <i :class="menu.span_icon"></i>
	                                    <span class="title" v-text="menu.title"></span>
	                                    <span class="selected"></span>
	                                    <span class="arrow" :class="{open: menu.href=='javascript:void(0)'}"></span>
	                                </a>
	                                <ul v-if="menu.children" class="sub-menu" style="display: block;">
										<li v-for="child in menu.children"  :class="child.href==now_href ? 'nav-sub-menu-hover': ''">
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
                                    <span>报表中心</span>
                                    <i class="fa fa-angle-right"></i>
                                </li>
                                <li>
                                    <span>采购报表</span>
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
                        <h1 class="page-title"> REPORT
                            <small>报表中心</small>
                        </h1>
                        
                        <!-- BEGIN PAGE MAIN-->
                        <div class="row">
                        	<div class="col-md-12">
                        		 <!-- BEGIN SEARCH -->
								<div class="note note-info">
									<input type="text" placeholder="商品名称/商品编号" class="form-control input-inline" id="milkName" style="width:150px;" />
									<input type="text" placeholder="采购时间" class="form-control input-inline" id="purchaseTime" style="width:300px" />
									<button type="button" class="btn btn-success btn-search"><i class="fa fa-search"></i>&nbsp;&nbsp;搜索</button>
									<input id="startTime" class="searchDateInput"/>
									<input id="endTime" class="searchDateInput" />
									<p>
										NOTE: 采购时间默认为当月
									</p>
								</div>
								<!-- END SEARCH-->
								
								<!-- BEGIN Summary-->
								<div class="row">
									<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
										<div class="dashboard-stat blue-madison">
											<div class="visual">
												<i class="fa fa-comments"></i>
											</div>
											<div class="details">
												<div class="number" id="totalPurchaseOrderNumber">
													 
												</div>
												<div class="desc">
													 采购单数
												</div>
											</div>
											<a class="more" href="javascript:void(0)">
											View more <i class="m-icon-swapright m-icon-white"></i>
											</a>
										</div>
									</div>
									
									<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
										<div class="dashboard-stat red-intense">
											<div class="visual">
												<i class="fa fa-bar-chart-o"></i>
											</div>
											<div class="details">
												<div class="number" id="totalPurchaseNumber">
												</div>
												<div class="desc">
													 采购总数量
												</div>
											</div>
											<a class="more" href="javascript:void(0)">
											View more <i class="m-icon-swapright m-icon-white"></i>
											</a>
										</div>
									</div>
									
									<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
										<div class="dashboard-stat green-haze">
											<div class="visual">
												<i class="fa fa-shopping-cart"></i>
											</div>
											<div class="details">
												<div class="number" id="totalPurchasePrice">
												</div>
												<div class="desc">
													 采购总金额
												</div>
											</div>
											<a class="more" href="javascript:void(0)">
											View more <i class="m-icon-swapright m-icon-white"></i>
											</a>
										</div>
									</div>
									
									<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
										<div class="dashboard-stat purple-plum">
											<div class="visual">
												<i class="fa fa-globe"></i>
											</div>
											<div class="details">
												<div class="number" id="firstThreeGoods" style="font-size:28px;">
												</div>
												<div class="desc">
													 采购前三商品
												</div>
											</div>
											<a class="more" href="javascript:void(0)">
											View more <i class="m-icon-swapright m-icon-white"></i>
											</a>
										</div>
									</div>
								</div>
                        		<!-- END Summary-->
                        		
                        		<!-- BEGIN TABLE-->
                        		<div class="portlet box green">
                        			<div class="portlet-title">
                        				<div class="caption">
                        					<i class="fa fa-globe"></i>库存列表
                        				</div>
                        				<div class="tools">
                                            <span class="btn-refresh"><i class="fa fa-refresh"></i></span>
                                        </div>
                        			</div>
                        			<div class="portlet-body flip-scroll">
                        				<table class="table table-bordered table-striped dataTable table-condensed flip-content" id="table">
                        					<thead class="flip-content">
                        						<tr>
                        							<th text-align="center"></th>
                        							<th>商品编号</th>
													<th>商品名称</th>
													<th>采购总数量</th>
													<th>采购总金额</th>
												</tr>
                        					</thead>
                        					<tbody>
                        						<template v-for="(purchase, $index) in data">
	                        						<tr :key="purchase.id">
	                        							<td style="vertical-align: inherit;text-align: center;">
	                        								<span class="row-detail row-detail-close"></span>
	                        							</td>
	                        							<td v-text="purchase[0].code"></td>
														<td v-text="purchase[0].milk_name"></td>
														<td>((purchase[0].totalPurchaseQuantity))件</td>
														<td>￥((purchase[0].totalPurchasePrice))</td>
													</tr>
													<tr style="display: none;">
														<td colspan="6">
															<table class="table table-striped table-hover">
																<thead>
																	<tr>
																		<td>采购单号</td>
																		<td>采购时间</td>
																		<td>数量</td>
																		<td>采购单价</td>
																		<td>总价格</td>
																	</tr>
																</thead>
																<tbody>
																	<tr v-for="item in purchase">
																		<td>((item.id))</td>
																		<td>((item.time))</td>
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
                        		
                        		<!-- BEGIN CHART-->
                        		<div class="lineChart row">
                        			<div id="lineChart" style="min-width:400px;height:400px"></div>
                        		</div>
                        		
                        		<div class="pieChart row">
                        			<div id="pieChart" style="min-width:400px;height:400px"></div>
                        		</div>
                        		<!-- END CHART-->
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
		
		<!-- BEGIN LAYER -->
		<!-- END LAYER -->
		
        <script src="static/js/common.js" type="text/javascript"></script>
        <script src="static/js/paginate_tool.js" type="text/javascript"></script>
        <script>
        var vue = new Vue({
			delimiters:['((', '))'],
			el:'#table',
			data:{
				data: []
			}
		})
        
        /*折线图*/
        var lineChartVar = null;
		var lineChart = {
		    chart: {
		    	renderTo: 'lineChart',
		        type: 'line'
		    },
		    title: {
		        text: '采购单走势图'
		    },
		    xAxis: {
		        categories: []
		    },
		    yAxis: {
		        title: {
		            text: '价格（￥）'
		        }
		    },
		    plotOptions: {
		        line: {
		            dataLabels: {
		                enabled: false          // 开启数据标签
		            },
		            enableMouseTracking: true // 关闭鼠标跟踪，对应的提示框、点击事件会失效
		        }
		    },
		    series: []
		}
		
		var pieChartVar = null;
		$("#pieChart").highcharts({
			chart: {
	        	renderTo: 'pieChart',
	            plotBackgroundColor: null,
	            plotBorderWidth: null,
	            plotShadow: false
	        },
	        title: {
	            text: '各商品采购占比'
	        },
	        tooltip: {
	            headerFormat: '{series.name}<br>',
	            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                dataLabels: {
	                    enabled: true,
	                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
	                    style: {
	                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
	                    }
	                }
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: '商品采购占比',
	            data: null
	        }]
	    });
		
		$(function(){
			init_table();
			
			$('.btn-search').on('click', function(){
				vue.milkName = $("#search").val();
				init_table();
			})
			
			$('.btn-refresh').on('click', function(){
				init_table();
			})
			
			/*表格收缩展开*/
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
			
			/*商品编号回车*/
			$("#milkName").keydown(function(event){
				if(event.keyCode == 13){
					init_table();
				}
			})
		})
		
        
		function init_table(rows, page){
			if(typeof(rows) == 'undefined')
				rows = 10;
			if(typeof(page) == 'undefined')
				page = 1;

			$.ajax({
				type:'get',
				url:'report/getPurchaseReport.action',
				data:{
					rows: rows,
					page: page,
					milkInfo: $("#milkName").val(),
					startTime: $("#startTime").val(),
					endTime: $("#endTime").val()
				},
				success:function(data){
					layer.closeAll('loading');
					data = eval("("+data+")");
					if(!data.succ){
						layer.msg(data.message);
					}
					else{
						//分页
						paginate_tool.init("init_table", data.pager, []);
						
						vue.data = data.tableDatas;
						$("#totalPurchaseOrderNumber").html(data.summaryPurchaseOrderCount);
						$("#totalPurchaseNumber").html(data.summaryPurchaseMilkNumber+" 件");
						$("#totalPurchasePrice").html("￥" + data.summaryPurchaseMilkPrice);
						$("#firstThreeGoods").html(data.summaryFirstThreeMilkName);
						
						/*折线图数据*/
						lineChart.xAxis.categories = data.lineXData;
						data.lineYData = data.lineYData.replace(/\"/g, "");
						lineChart.series = eval(data.lineYData);
						lineChartVar = new Highcharts.Chart(lineChart);
						
						/*饼状图数据*/
						var pieDataArray = new Array();
						
						for(i in data.pieData){
							var value = [data.pieData[i].milk_name, parseFloat(data.pieData[i].total_price)];
							pieDataArray.push(value);
						}
						pieChartVar = $("#pieChart").highcharts();
						pieChartVar.series[0].setData(pieDataArray);
					}
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
		
		$("#purchaseTime").daterangepicker({
			opens: 'right',
			alwaysShowCalendars: true,
            showDropdowns: true,
			autoUpdateInput: false,
			showWeekNumbers: false,
			linkedCalendars: false,
			drops: "down",
			locale: {
                format: 'YYYY-MM-DD',
                applyLabel: "应用",
                cancelLabel: "取消",
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ], 
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',  
                               '七月', '八月', '九月', '十月', '十一月', '十二月' ],
				customRangeLabel : '自定义', 
            },
            ranges: {
            	"本周": [moment().days(1), moment().add(7-moment().days(), 'days')],
            	"上周": [moment().subtract(7+(moment().days()-1), "days"), moment().days(0)],
            	"本月": [moment().startOf("month"), moment().endOf("month")],
            	"上月": [moment().subtract(1, "month").startOf("month"), moment().subtract(1, "month").endOf("month")],
            	"本季度": [moment().quarter(moment().quarter()).startOf("quarter"), moment().quarter(moment().quarter()).endOf("quarter")],
            	"上季度": [moment().quarter(moment().quarter()-1).startOf("quarter"), moment().quarter(moment().quarter()-1).endOf("quarter")]
            }
		},
        function(start, end, label){
			if(!this.startDate)
            	$("#purchaseTime").val('');
			else{
				$("#purchaseTime").val(this.startDate.format(this.locale.format) + " 至 " + this.endDate.format("YYYY-MM-DD"));
				$("#startTime").val(this.startDate.format(this.locale.format));
				$("#endTime").val(this.endDate.format(this.locale.formate));
			}
        });
		
		$("#purchaseTime").on('apply.daterangepicker', function(ev, picker) {
			$("#purchase_time").val(picker.startDate.format('YYYY-MM-DD') + " 至 " + picker.endDate.format("YYYY-MM-DD"));
			$("#startTime").val(picker.startDate.format('YYYY-MM-DD'));
			$("#endTime").val(picker.endDate.format("YYYY-MM-DD"));
        });
        </script>
    </body>

</html>