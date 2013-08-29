<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>RssFeed</title>
		<link rel="stylesheet" type="text/css" media="screen" href="css/jquery-ui-1.8.22.custom.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="css/ui.jqgrid.css" />
<!-- 		<link rel="stylesheet" type="text/css" media="screen" href="css/ui.multiselect.css" /> -->
<!-- 		<link rel="stylesheet" type="text/css" media="screen" href="css/jquery.ui.datepicker.css" /> -->
		
		<script type='text/javascript' src='/RSS_feed/dwr/interface/RssFeedService.js'></script>
		<script type='text/javascript' src='/RSS_feed/dwr/engine.js'></script>
		<script src="js/jquery-1.7.2.js" type="text/javascript"></script>
		<script src="js/jquery-ui-1.8.22.custom.js" type="text/javascript"></script>
		<script src="js/jquery-ui-i18n.js" type="text/javascript"></script>
		<script src="js/jquery.ui.datepicker-zh-CN.js" type="text/javascript"></script>
		<script src="js/grid.locale-cn.js" type="text/javascript"></script>
		<script src="js/ui.multiselect.js" type="text/javascript"></script>
		<script src="js/jquery.jqGrid.src.js" type="text/javascript"></script>
		<script src="js/jquery.tablednd.js" type="text/javascript"></script>
<!-- 		<script src="js/jquery.contextmenu.js" type="text/javascript"></script> -->
		
		<script type="text/javascript">
			var beforeRowData = null;
			$(document).ready(function() {
				$("#rssGrid").jqGrid({        
					caption: "RssFeed",
					datatype: function() {
						RssFeedService.findAll(function(data) {
							$("#rssGrid").jqGrid('clearGridData');
							for(var i in data)
								$("#rssGrid").jqGrid('addRowData', i+1, data[i]);
		 				});
					},
					treeGrid: true,
					autowidth: true,
					height: '80%',
				   	rownumbers: true,
					rowNum:100, 
					pager: '#rssGridPaper', 
					sortname: 'feedName', 
					viewrecords: true, 
					sortorder: "desc", 
//					inlineNav: '#rssGridPaper',
					toolbar: [true,"top"],
					editurl: "clientArray",
				   	colNames:['Id', '名称', 'Url'],
				   	colModel:[
						{name:'Id',index:'Id',hidden:true,width:150,editable: false},
				   		{name:'feedName',index:'feedName', width:150,editable: true},
				   		{name:'feedUrl',index:'feedUrl',hidden:true, width:300, editable: true},
				   	]
				});
				
				$("#rssGrid").jqGrid('navGrid', "#rssGridPaper", {edit:false,add:false,del:false,search:false});
// 				$("#rssGrid").jqGrid('navGrid','#rssGridPaper',
// 						{add:false,edit:false,del:false}, //options
// 						{height:280,reloadAfterSubmit:false}, // edit options
// 						{height:280,reloadAfterSubmit:false}, // add options
// 						{reloadAfterSubmit:false}, // del options
// 						{} // search options
// 				);
				$("#rssGrid").jqGrid("navButtonAdd", "#rssGridPaper", {
					id: "add",
					caption:"",
					title: "添加新记录",
					buttonicon : "ui-icon-plus",
					onClickButton: function() {
						$("#rssGrid").jqGrid('addRow', {});
						$("#add").addClass('ui-state-disabled');
						$("#edit").addClass('ui-state-disabled');
						$("#save").removeClass('ui-state-disabled');
						$("#cancel").removeClass('ui-state-disabled');
					}
				}).jqGrid("navButtonAdd", "#rssGridPaper", {
					id: "edit",
					caption:"",
					title: "编辑所选记录",
					buttonicon : "ui-icon-pencil",
					onClickButton: function() {
						var selrow = $("#rssGrid").jqGrid('getGridParam','selrow');
						if(selrow) {
							beforeRowData = $("#rssGrid").jqGrid("getRowData", selrow);
							$("#rssGrid").jqGrid('editRow', selrow, {keys: false});
							$("#add").addClass('ui-state-disabled');
							$("#edit").addClass('ui-state-disabled');
							$("#save").removeClass('ui-state-disabled');
							$("#cancel").removeClass('ui-state-disabled');
						} else {
							$.jgrid.viewModal("#alertmod",{gbox:"#gbox_edit",jqm:true});
							$("#jqg_alrt").focus();							
						}
					}
				}).jqGrid("navButtonAdd", "#rssGridPaper", {
					id: "save",
					caption:"",
					title: "保存所选编辑记录",
					buttonicon : "ui-icon-disk",
					onClickButton: function() {
						var selrow = $("#rssGrid").jqGrid('getGridParam','selrow');
						if(selrow) {
							$("#rssGrid").jqGrid('saveRow', selrow, {aftersavefunc:function() {
								var rowData = $("#rssGrid").jqGrid("getRowData", selrow);
								var rssfeed ;
								rssfeed = {feedName:rowData.feedName, feedUrl:rowData.feedUrl};
								RssFeedService.add(rssfeed);
								// alert(beforeRowData);
								// alert(beforeRowData.name + " = " + rowData.name + " ->" + typeof beforeRowData);
								//if(null === beforeRowData 
								//		|| beforeRowData.name === rowData.name) {
								//	Config.updateConfig(rowData.name, rowData.value, rowData.comment, function() {
								//		$("#rssGrid").trigger("reloadGrid");
								//		alert("添加修改配置成功!");
								//	});
								//} else {
								//	alert("配置项名称不能修改!");
								//	$("#rssGrid").trigger("reloadGrid");
								//}
							}});
							$("#save").addClass('ui-state-disabled');
							$("#cancel").addClass('ui-state-disabled');
							$("#add").removeClass('ui-state-disabled');
							$("#edit").removeClass('ui-state-disabled');
						} else {
							$.jgrid.viewModal("#alertmod",{gbox:"#gbox_save",jqm:true});
							$("#jqg_alrt").focus();							
						}
					}
				}).jqGrid("navButtonAdd", "#rssGridPaper", {
					id: "cancel",
					caption:"",
					title: "取消保存编辑记录",
					buttonicon : "ui-icon-cancel",
					onClickButton: function() {
						var selrow = $("#rssGrid").jqGrid('getGridParam','selrow');
						if(selrow) {
							$("#rssGrid").jqGrid('restoreRow', selrow, {});
							$("#save").addClass('ui-state-disabled');
							$("#cancel").addClass('ui-state-disabled');
							$("#add").removeClass('ui-state-disabled');
							$("#edit").removeClass('ui-state-disabled');
						} else {
							$.jgrid.viewModal("#alertmod",{gbox:"#gbox_cancel",jqm:true});
							$("#jqg_alrt").focus();							
						}
					}
				});
				$("#save").addClass('ui-state-disabled');
				$("#cancel").addClass('ui-state-disabled');
			});
		</script>

	</head>
	<body style="font-size: 10px;padding: 0;">
		<div style="width:20%;">
			<table id="rssGrid"></table>
			<div id="rssGridPaper"></div>
		</div>
		<div style="width:80%;">
			<table id="feedNewsGrid"></table>
		</div>
	</body>
</html>