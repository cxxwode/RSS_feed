<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>RssFeed4</title>
		<link rel="stylesheet" type="text/css" media="screen" href="css/jquery-ui-1.8.22.custom.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="css/ui.jqgrid.css" />
 		<link rel="stylesheet" type="text/css" media="screen" href="css/ui.multiselect.css" /> 
 		<link rel="stylesheet" type="text/css" media="screen" href="css/jquery.ui.datepicker.css" /> 
		<script type='text/javascript' src='/RSS_feed/dwr/interface/FeedNewsService.js'></script>
  		<script type='text/javascript' src='/RSS_feed/dwr/engine.js'></script>
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
 		<script src="js/jquery.contextmenu.js" type="text/javascript"></script> 
		
<script type="text/javascript">
	$(document).ready(function() {
    jQuery("#rssGrid").jqGrid({
    	url:'RssFeedServlet',
        datatype: "json",
        mtype: 'post',
        height: "auto",
        colNames:['id', '名称', 'Url'],
	   	colModel:[
			{name:'id',index:'id',hidden:true,width:150,editable: false,jsonmap:'id'},
	   		{name:'feedName',index:'feedName', height:50, width:150,editable: true,jsonmap:'feedName'},
	   		{name:'feedUrl',index:'feedUrl',hidden:true, width:300, editable: true,jsonmap:'feedUrl'},
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#rssGridPaper',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "desc",
		jsonReader: {
			repeatitems : false,
		},
	   	loadComplete: function(data) {
	   		alert(data);
	   	},
	   	loadError:function(xhr, status, error) {
	   		//alert(xhr);
	   		//alert(status);
	   		alert(error);
	   	},
		caption: "rssGrid",
        autowidth: true,
        onSelectRow: function(rowid) {
        	var treedata = $("#rssGrid").jqGrid('getRowData',rowid);
        	alert(treedata.id);
        	var d = treedata.id;
        	//jQuery("#feedNewsGrid").jqGrid('clearGridData');
        	jQuery("#feedNewsGrid").GridUnload();
			bindData(treedata.id);
        },
	});
	
	function bindData(d) {
		//jQuery("#feedNewsGrid").jqGrid('clearGridData');
		alert(d + "binddata");
		jQuery("#feedNewsGrid").jqGrid({
			url:'feedNewsServlet',
	        datatype: "json",
	        mtype: 'post',
	        postData:{feedId:d},
	        height: "100%",
	        //autoheight:true,
	        colNames:['id','标题', 'newsUrl', '作者', '更新时间'],
		   	colModel:[
				{name:'id',index:'id',height:50,width:300,hidden:true,editable: false},
				{name:'newsTitle',index:'newsTitle',width:300,editable: false,link:'newsUrl'},
				{name:'newsUrl',index:'newsUrl',width:300,hidden:true,editable: false},
		   		{name:'newsAuthor',index:'newsAuthor', width:80,editable: true},
		   		{name:'newsPublishedDate',index:'newsPublishedDate', width:80, editable: true, jsonmap:'newsPublishedDate',formatter:"date"},
		   	],
		   	sortname:'id',
		   	pgtext:'第{0}页 共{1}页',
	        recordtext:'第 {0} - {1}条记录 ',  
	        rowNum:10,   
	        rowList:[10,20,30], 
	        viewrecords:true,
	        recordpos: 'left',
	        sortorder: "desc",
			jsonReader: {
				repeatitems : false,
			},
			complete:function(){
				
			},
	        pager:'#feedNewsGridPaper',
			caption: 'feedNewsGrid',
	        autowidth: true,
	        onSelectRow: function(rowid2) {
	        	var feedNews = $("#feedNewsGrid").jqGrid('getRowData',rowid2);
	        	window.open(feedNews.newsUrl);
			}
		}).trigger('reloadGrid');

	}
	
	 jQuery("#feedNewsGrid").jqGrid({
	        //height: "768",
	        //url:'feedNewsServlet',
 			//datatype: "json",
			//mtype: 'post',
 			//postData:{feedId:d},
	        autoheight:true,
	        colNames:['id','标题', 'newsUrl', '作者', '更新时间'],
		   	colModel:[
				{name:'id',index:'id',width:300,hidden:true,editable: false},
				{name:'newsTitle',index:'newsTitle',width:300,editable: false},
				{name:'newsUrl',index:'newsUrl',width:300,hidden:true,editable: false},
		   		{name:'newsAuthor',index:'newsAuthor', width:80,editable: true},
		   		{name:'newsPublishedDate',index:'newsPublishedDate', width:80, editable: true,jsonmap:'newsPublishedDate', formatter:"date"},
		   	],
		   	sortname:'id',
		   	pgtext:'第{0}页 共{1}页',
	        recordtext:'第 {0} - {1}条记录 ',  
	        rowNum:10,   
	        rowList:[10,20,30], 
	        viewrecords:true,
	        recordpos: 'left',
	        sortorder: "desc",
			jsonReader: {
				repeatitems : false,
			},
	        pager:'#feedNewsGridPaper',
			caption: 'feedNewsGrid',
	        autowidth: true,
	        onSelectRow: function(rowid2) {
	        	var feedNews = $("#feedNewsGrid").jqGrid('getRowData',rowid2);
	        	window.open(feedNews.newsUrl);
			}
		});

	jQuery("#feedNewsGrid").jqGrid('navGrid','#feedNewsGridPaper',{edit:false,add:false,del:false});
	jQuery("#rssGrid").jqGrid('navGrid','#rssGridPaper',{edit:false,add:false,del:false});
});
</script>

	</head>
	<body style="font-size: 10px;padding: 0;">
		<div style="width:15%; float:left">
			<table id="rssGrid"></table>
			<div id="rssGridPaper"></div>
		</div>
		<div style="width:85%; float:left">
			<table id="feedNewsGrid"></table>
			<div id="feedNewsGridPaper"></div>
		</div>
	</body>
</html>