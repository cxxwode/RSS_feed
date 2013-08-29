<html xmlns="http://www.w3.org/1999/xhtml" lang="zh_CN">
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>RssFeed3</title>
		<link rel="stylesheet" type="text/css" media="screen" href="css/jquery-ui-1.8.22.custom.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="css/ui.jqgrid.css" />
<!-- 		<link rel="stylesheet" type="text/css" media="screen" href="css/ui.multiselect.css" /> -->
<!-- 		<link rel="stylesheet" type="text/css" media="screen" href="css/jquery.ui.datepicker.css" /> -->
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
<!-- 		<script src="js/jquery.contextmenu.js" type="text/javascript"></script> -->
</head>
<body>
<table id="jsonmap"></table>
<div id="pjmap"></div>
</body>

<script type="text/javascript">
		$(document).ready(function(){
			jQuery("#jsonmap").jqGrid({        
			   	url:'jqGridServlet',
				datatype: "json",
			   	colNames:['Inv No','Date', 'Client', 'Amount','Tax','Total','Notes'],
			   	colModel:[
			   		{name:'id',index:'id', width:55},
			   		{name:'invdate',index:'invdate', width:90, jsonmap:"invdate"},
			   		{name:'name',index:'name asc, invdate', width:100},
			   		{name:'amount',index:'amount', width:80, align:"right"},
			   		{name:'tax',index:'tax', width:80, align:"right"},		
			   		{name:'total',index:'total', width:80,align:"right"},		
			   		{name:'note',index:'note', width:150, sortable:false}		
			   	],
			   	rowNum:10,
			   	rowList:[10,20,30],
			   	pager: '#pjmap',
			   	sortname: 'id',
			    viewrecords: true,
			    sortorder: "desc",
				jsonReader: {
					repeatitems : false,
					id: "0"
				},
				caption: "JSON Mapping",
				height: '100%'
			});
			jQuery("#jsonmap").jqGrid('navGrid','#pjmap',{edit:false,add:false,del:false});
		});
	</script>
</html>