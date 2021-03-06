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
                                    <span>商品管理</span>
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
                        <h1 class="page-title"> GOODS
                            <small>商品管理</small>
                        </h1>
                        
                        <!-- BEGIN PAGE MAIN-->
                        <div class="row">
                        	<div class="col-md-12">
                        	
                        		<!-- BEGIN TABLE-->
                        		<div class="portlet box green">
                        			<div class="portlet-title">
                        				<div class="caption">
                        					<i class="fa fa-globe"></i>商品列表
                        				</div>
                        				<div class="tools">
                                            <span class="btn-refresh"><i class="fa fa-refresh"></i></span>
                                        </div>
                        			</div>
                        			<div class="portlet-body flip-scroll">
                        				<div class="row table-tool">
											<div class="col-md-12">
												<input type="search" placeholder="商品名称 /商品编号" class="form-control input-small input-inline" style="width:165px!important" onchange="vue.milkName=this.value" onkeyup="if(event.keyCode==13){vue.milkName=this.value;init_table()}">
												<button type="button" class="btn btn-success btn-search"><i class="fa fa-search"></i>&nbsp;&nbsp;搜索</button>
												<button type="button" class="btn btn-danger btn-add"><i class="fa fa-plus"></i>&nbsp;&nbsp;新增</button>
											</div>
										</div>
                        				<table class="table table-bordered table-striped table-condensed flip-content" id="table">
                        					<thead class="flip-content">
                        						<tr>
													<th>商品编号</th>
													<th>商品名称</th>
													<th>规格</th>
													<th>进货价</th>
													<th>销售价</th>
													<th>操作</th>
												</tr>
                        					</thead>
                        					<tbody>
                        						<tr v-for="(item, index) in data" :key="item.id">
													<td v-text="item.code"></td>
													<td v-text="item.milk_name"></td>
													<td v-text="item.specifications"></td>
													<td>￥((item.purchase_price))</td>
													<td>￥((item.selling_price))</td>
													<td>
														<button class="btn btn-sm green btn-outline filter-submit margin-bottom" @click="edit(item)"><i class="fa fa-edit"></i>&nbsp;&nbsp;编辑</button>
														<button class="btn btn-sm red btn-outline filter-submit margin-bottom" @click="deleted(item.code)"><i class="fa fa-times"></i>&nbsp;&nbsp;删除</button>
													</td>
												</tr>
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
		<div id="layer-window" style="display:none">
			<div class="col-mid-6">
				<form class="layer-form" data-parsley-validate onsubmit="return false">
					<table>
						<template v-if="edit_data != null">
							<tr>
								<td width="70">商品编号</td>
								<td><input name="code" id="code" v-model="edit_data.code" data-validat="false" readonly /><span class="red"> *</span></td>
							</tr>
							<tr>
								<td width="70">商品名称</td>
								<td><input name="milk_name" id="milk_name" v-model="edit_data.milk_name" data-validat="true" readonly/><span class="red"> *</span></td>
							</tr>
							<tr>
								<td width="70">规格</td>
								<td><input name="specifications" id="specifications" value="件" readonly data-validat="true"/><span class="red"> *</span></td>
							</tr>
							<tr>
								<td width="70">进货价</td>
								<td><input name="purchase_price" id="purchase_price" :value="edit_data.purchase_price" @blur="check_price" @keyup="check_price_format" data-validat="false"/> 元<span class="red"> *</span></td>
							</tr>
							<tr>
								<td width="70">销售价</td>
								<td><input name="selling_price" id="selling_price" :value="edit_data.selling_price" @blur="check_price" @keyup="check_price_format" data-validat="false"/> 元<span class="red"> *</span></td>
							</tr>
						</template>
						<template v-else>
							<tr>
								<td width="70">商品编号</td>
								<td>
									<input name="code" type="number" id="code" data-parsley-type="integer" data-parsley-required="true" data-parsley-length="[4,4]"
										data-parsley-error-message="商品编号只能是4位数字" data-parsley-required-message="商品编号必须填写" data-parsley-trigger="change" />
									<span class="red"> *</span>
								</td>
							</tr>
							<tr>
								<td width="70">商品名称</td>
								<td>
									<input name="milk_name" id="milk_name" data-parsley-required="true"
										data-parsley-required-message="商品名称必填" data-parsley-trigger="change"/>
									<span class="red"> *</span>
								</td>
							</tr>
							<tr>
								<td width="70">规格</td>
								<td>
									<select name="specifications" id="specifications" data-parsley-required="true" data-parsley-required-message="规格必填">
										<option></option>
										<option>件</option>
										<option>提</option>
										<option>个</option>
									</select>
									<span class="red"> *</span>
								</td>
							</tr>
							<tr>
								<td width="70">进货价</td>
								<td>
									<input name="purchase_price" id="purchase_price" @blur="check_price" @keyup="check_price_format" data-parsley-required="true"
										data-parsley-required-message="进货价必填"/> 元
									<span class="red"> *</span>
								</td>
							</tr>
							<tr>
								<td width="70">销售价</td>
								<td>
									<input name="selling_price" id="selling_price" @blur="check_price" @keyup="check_price_format" data-parsley-required="true"
										data-parsley-required-message="销售价必填"/> 元
									<span class="red"> *</span>
								</td>
							</tr>
						</template>
					</table>
					<div class="layer-button">
						<button type="submit" class="btn btn-danger btn-submit" @click="current"><i class="fa fa-check"></i>&nbsp;&nbsp;确定</button>
						<button type="button" class="btn grey-cascade btn-cancle"><i class="fa fa-times"></i>&nbsp;&nbsp;取消</button>
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
				milkName: '',
				data: []
			},
			methods:{
				edit: function(milk){
					edit_vue.edit_data = milk;
					layer.open({
						type: '1',
						skin: 'layui-layer-molv',
						title: '编辑商品',
						area: ['362px', '368px'],
						content: $('#layer-window')
					})
				},
				deleted: function(code){
					$.ajax({
						type:"post",
						url:"milk/deleteMilk.action",
						data:{"code": code},
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
	
		var edit_vue = new Vue({
			delimiters:['((', '))'],
			el:'#layer-window',
			data:{
				edit_data: null
			},
			methods:{
				check_price_format:function(event){
					var obj = event.target;
				    obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的  
				    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$","."); 
				    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数  
				    if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额 
				        obj.value= parseFloat(obj.value);
				    } 
				},
				check_price:function(event){
					var obj = event.target;
					if(obj.value > 20000){
						layer.tips('金额不能超过20000且只能保留两位小数', obj);
						$(obj).css('color', 'red');
						$(obj).attr('data-validat', 'false');
					}
					else{
						$(obj).css('color', 'black');
						$(obj).attr('data-validat', 'true');
					}
				},
				current:function(){
					var once = false;
					if(this.edit_data != null){
						$("form").parsley().on("form:success", function(){
							if(!once){
								$.ajax({
									type:'post',
									data:$('.layer-form').serialize(),
									url: 'milk/editMilk.action',
									success:function(data){
										data = eval("("+data+")");
										layer.msg(data.message);
										if(data.succ){
											layer.closeAll("page");
											init_table();
										}
										return false;
									}
								});
							}
							once = true;							
						});
					}
					else{
						$("form").parsley().on("form:success", function(){
							if(!once){
								$.ajax({
									type:'post',
									url:'milk/addMilk.action',
									data:$('.layer-form').serialize(),
									success:function(data){
										data = eval("("+data+")");
										layer.msg(data.message);
										if(data.succ){
											layer.closeAll("page");
											init_table();
										}
										return false;
									}
								});
							}
							once = true;
						});
					}
				}
			}
		})
		$(function(){
			init_table();
			$('.btn-add').on('click', function(){
				edit_vue.edit_data = null;
				
				layer.open({
					type: '1',
					skin: 'layui-layer-molv',
					title: '新增商品',
					area: ['362px', '368px'],
					content: $('#layer-window')
				})
			})
			
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
		})
		
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
			$.ajax({
				type:'post',
				url:'milk/getMilkByCondition.action',
				data:{
					rows: rows,
					page: page,
					milkInfo: vue.milkName
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