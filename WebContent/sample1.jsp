<%@page contentType="text/html; charset=gb2312" language="java"  errorPage="" %>
<%@page import="com.sun.syndication.feed.synd.SyndFeed"%>
<%@page pageEncoding="utf-8"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.net.*" %>
<%@page import="org.jdom.*" %>
<%@page import="com.sun.syndication.io.*" %>
<%@page import="com.sun.syndication.feed.synd.*" %>
<%@page import="com.iphone.rssfeed.DaoImpl.*" %>
<%@page import="com.iphone.model.*" %>
<%@page import="com.iphone.rssfeed.manager.*" %>
<%@page import="org.springframework.web.context.WebApplicationContext" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>

<head>
    <title>员工信息</title>                
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
     	<meta http-equiv="description" content="this is my page">
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
        <link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.2.custom.css" />
		<link rel="stylesheet" href="css/ui.jqgrid.css" type="text/css"></link>
		<script type="text/javascript" src="js/js/grid.locale-cn.js"></script>
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/jquery.jqGrid.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui-1.7.3.custom.min.js"></script>
		<script type="text/javascript">
			$(function(){   
				    $("#gridTable").jqGrid({   
				        url:'employeeView.action',   
				        datatype: 'json',   
				        height: 350,   
				        colNames:['员工编号 ',' 姓名 ', '性别 ', '出生日期 ','部门 ','备注 '],
					   	colModel:[
					   		{name:'eid',index:'eid',width:80},
					   		{name:'ename',index:'ename asc, invdate', width:80},
					   		{name:'esex', index:'esex', width:80},
					   		{name:'birthday',    index:'birthday',width:120,  align:"right"},		
					   		{name:'department',  index:'department', width:120,  align:"right"},		
					   		{name:'eremark',   index:'eremark', width:150, sortable:false}		
					   	],
				        sortname:'id',   
				        //sortorder:'asc',   
				        viewrecords:true, 
				        pgtext:'第{0}页 共{1}页',
				        recordtext:'第 {0} - {1}条记录 ',  
				        rowNum:10,   
				        rowList:[10,20,30],   
				        jsonReader: {   
				            root:"dataRows",        // 数据行（默认为：rows）   
				            page: "pages",    // 当前页   
				            total: "totals",  // 总页数   
				            records: "records",  // 总记录数   
				            repeatitems : false     // 设置成false，在后台设置值的时候，可以乱序。且并非每个值都得设   
				        }, 
				        prmNames : {
							search : "search",
							rows:"pageModel.rows",
							page:"pageModel.page",
							//sort:"page.orderBy",
							//order:"page.order"
							}, 
				        pager:"#gridPager",  
				        caption: "员工信息 "
				});  

// 配置对话框  
			    $("#consoleDlg").dialog({  
			        autoOpen: false,      
			        modal: true,    // 设置对话框为模态（modal）对话框  
			        resizable: true,      
			        width: 480,  
			        buttons: {  // 为对话框添加按钮  
			            "取消": function() {$("#consoleDlg").dialog("close")},  
			            "添加": addEmployee,  
			            "保存": updateEmployee,  
			            "删除": deleteEmployee  
			        }  
			    });  

});
		  var openDialog4Adding = function() {  
				    var consoleDlg = $("#consoleDlg");  
				    var dialogButtonPanel = consoleDlg.siblings(".ui-dialog-buttonpane");  
				    consoleDlg.find("input").removeAttr("disabled").val("");  
				    dialogButtonPanel.find("button:not(:contains('取消'))").hide();  
				    dialogButtonPanel.find("button:contains('添加')").show();  
				    consoleDlg.dialog("option", "title", "添加员工信息 ").dialog("open");  
				};  
				var openDialog4Updating = function() {  
				    var consoleDlg = $("#consoleDlg");  
				    var dialogButtonPanel = consoleDlg.siblings(".ui-dialog-buttonpane");  
				      
				    consoleDlg.find("input").removeAttr("disabled");  
				    dialogButtonPanel.find("button:not(:contains('取消'))").hide();  
				    dialogButtonPanel.find("button:contains('保存')").show();  
				    consoleDlg.dialog("option", "title", "修改员工信息");  
				      
				    loadSelectedRowData();  
				}  
				var openDialog4Deleting = function() {  
				    var consoleDlg = $("#consoleDlg");  
				    var dialogButtonPanel = consoleDlg.siblings(".ui-dialog-buttonpane");  
				      
				    consoleDlg.find("input").attr("disabled", true);  
				    dialogButtonPanel.find("button:not(:contains('取消'))").hide();  
				    dialogButtonPanel.find("button:contains('删除')").show();  
				    consoleDlg.dialog("option", "title", "删除员工");  
				      
				    loadSelectedRowData();  
				}  
					    	  
	    	     var loadSelectedRowData = function() {
						var selectedRowId = $("#gridTable").jqGrid("getGridParam", "selrow");
						if (!selectedRowId) {
							hiAlert("请先选择需要编辑的行!");
							return false;
						} else {
							var params = {
								"employee.eid" : selectedRowId
							};
							// 从Server读取对应ID的JSON数据
							$.ajax( {
								url : "employee_find.action",
								data : params,
								dataType : "json",
								cache : false,
								error : function(textStatus, errorThrown) {
									hiAlert("系统ajax交互错误: " + textStatus);
								},
								success : function(data, textStatus) {
									// 如果读取结果成功，则将信息载入到对话框中					
								  var rowData = data.person;  
				    	    	  var consoleDlg = $("#consoleDlg");  
				    	    	  
				    	    	  consoleDlg.find("#selectId").val(rowData.id);  
							      consoleDlg.find("#ename").val(rowData.ename);  
							      consoleDlg.find("#esex").val(rowData.esex);  
							      consoleDlg.find("#birthday").val(rowData.birthday);  
							      consoleDlg.find("#department").val(rowData.department);  
							      consoleDlg.find("#eremark").val(rowData.eremark);  
								// 根据新载入的数据将表格中的对应数据行一并更新一下
								 var  dataRow = {  
			    	    	                 id : data.employee.eid,   // 从Server端得到系统分配的id  
						                     ename :ename,  
						                     esex : esex,
						                     birthday: birthday,
						                     department: department,
						                     eremark:eremark 
		    	    	                 };
					
								$("#gridTable").jqGrid("setRowData", data.employee.eid, dataRow);
					
								// 打开对话框
								consoleDlg.dialog("open");
							}
							});
					
						}
					}; 	      	  
	    	  //数据更新 
	    	   function updateEmployee() { 
		    	    	     var consoleDlg = $("#consoleDlg");      
		    	    	       
			                 var eid = $.trim(consoleDlg.find("#selectId").val());  
						     var eanme = $.trim(consoleDlg.find("#eanme").val());  
						     var esex = $.trim(consoleDlg.find("#esex").val());  
						     var birthday = $.trim(consoleDlg.find("#birthday").val()); 
						     var department = $.trim(consoleDlg.find("#department").val()); 
						     var eremark = $.trim(consoleDlg.find("#eremark").val());    
		    	    	     var params = {  
				    	    	     "employee.eid" : eid,
							         "employee.ename" : ename,  
							         "employee.esex" : esex,
							         "employee.birthday" : birthday,  
							         "employee.department" : department,
							         "employee.eremark" : eremark   
		    	    	     };  
		    	    	     var actionUrl = "employee_update.action";  
		    	    	     $.ajax( {  
		    	    	         url : actionUrl,  
		    	    	         data : params,  
		    	    	         dataType : "json",  
		    	    	         cache : false,  
		    	    	         error : function(textStatus, errorThrown) {  
		    	    	             alert("系统ajax交互错误: " + textStatus);  
		    	    	         },  
		    	    	         success : function(data, textStatus) {  
		    	    	             if (data.ajaxResult == "success") {  
		    	    	                 var dataRow = {  
			    	    	                 id : data.employee.eid,   // 从Server端得到系统分配的id  
						                     ename :ename,  
						                     esex : esex,
						                     birthday: birthday,
						                     department: department,
						                     eremark:eremark 
		    	    	                 };  
		    	    	                 alert("联系人信息更新成功!");  
		    	    	                 consoleDlg.dialog("close");  
		    	    	                 $("#gridTable").jqGrid("setRowData", data.employee.eid, dataRow);  
		    	    	             } else {  
		    	    	                 alert("修改操作失败!");  
		    	    	             }  
		    	    	         }  
		    	    	     });  
			    	    };
			    	
			var addEmployee = function() {  
			    var consoleDlg = $("#consoleDlg");  
			          
			    var eanme = $.trim(consoleDlg.find("#eanme").val());  
				var esex = $.trim(consoleDlg.find("#esex").val());  
				var birthday = $.trim(consoleDlg.find("#birthday").val()); 
				var department = $.trim(consoleDlg.find("#department").val()); 
				var eremark = $.trim(consoleDlg.find("#eremark").val());  
			      
			    var params = {  
			        "employee.ename" : ename,  
					"employee.esex" : esex,
					"employee.birthday" : birthday,  
					"employee.department" : department,
					"employee.eremark" : eremark   
			    };  
			      
			     var actionUrl = "employee_add.action";
			      
			    $.ajax( {  
			        url : actionUrl,  
			        data : params,  
			        dataType : "json",  
			        cache : false,  
			        error : function(textStatus, errorThrown) {  
			            alert("系统ajax交互错误: " + textStatus);  
			        },  
			        success : function(data, textStatus) {  
			            if(data.ajaxResult == "success") {  
			                var dataRow = {  
			                   id : data.employee.eid,   // 从Server端得到系统分配的id  
						                     ename :ename,  
						                     esex : esex,
						                     birthday: birthday,
						                     department: department,
						                     eremark:eremark 
			                };  
			                  
			                var srcrowid = $("#gridTable").jqGrid("getGridParam", "selrow");  
			                  
			                if(srcrowid) {  
			                    $("#gridTable").jqGrid("addRowData", data.employee.eid, dataRow, "before", srcrowid);
			                      
			                } else {  
			                    $("#gridTable").jqGrid("addRowData", data.employee.eid, dataRow, "first");  
			                }  
			                consoleDlg.dialog("close");  
			                  
			                alert("联系人添加操作成功!");  
			                  
			            } else {  
			                alert("添加操作失败!");  
			            }  
			        }  
			    });  
			};  

//数据删除
			      var deleteEmployee = function() {  
					    var consoleDlg = $("#consoleDlg");  
					      
					    var pId = $.trim(consoleDlg.find("#selectId").val());  
					    var params = {  
					        "employee.eid" : pId  
					    };  
					    var actionUrl = "employee_delete.action";  
					    $.ajax({  
					        url : actionUrl,  
					        data : params,  
					        dataType : "json",  
					        cache : false,  
					        error : function(textStatus, errorThrown) {  
					            alert("系统ajax交互错误: " + textStatus);  
					        },  
					        success : function(data, textStatus) {  
					            if (data.ajaxResult == "success") {  
					                $("#gridTable").jqGrid("delRowData", pId);  
					                consoleDlg.dialog("close");  
					                alert("联系人删除成功!");  
					            } else {  
					                alert("删除操作失败!");  
					            }  
					        }  
					    });  
					};  
		</script>
	 
  </head>
  <body> 
  
    <table id="gridTable"></table>  
    <div id="gridPager">
           
     </div>
     <div>
        <button class="right-button02" onclick="openDialog4Adding()">添加</button> 
		<button class="right-button02" onclick="openDialog4Updating()">修改</button> 
	 	<button class="right-button02" onclick="openDialog4Deleting()">删除</button>
     
     </div>
     <div id="consoleDlg">
			<div id="formContainer">
				<form id="consoleForm">
				    <input type="hidden" id="selectId" />
					<table class="formTable">
						<tr>
							<th>
								姓名：
							</th>
							<td>
								<input type="text" class="textField" id="ename"
									name="ename" />
							</td>
						</tr>
						<tr>
							<th id="thusergender">
								性  别：
							</th>
							<td>
								<input type="text" class="textField" id="esex"
									name="esex" />
							</td>
						</tr>
						<tr>
							<th>
								出生日期：
							</th>
							<td>
								<input type="text" class="textField" id="birthday"
									name="birthday" />
							</td>
						</tr>
						<tr>
							<th>
								部门：
							</th>
							<td>
								<input type="text" class="textField" id="department"
									name="department" />
							</td>
						</tr>
						<tr>
							<th>
								备注：
							</th>
							<td>
								<input type="text" class="textField" id="eremark"
									name="eremark" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>                    
  </body>
</html>