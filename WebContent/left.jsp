<%@page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@page import="com.sun.syndication.feed.synd.SyndFeed"%>
<%@page pageEncoding="gb2312" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.net.*" %>
<%@page import="org.jdom.*" %>
<%@page import="com.sun.syndication.io.*" %>
<%@page import="com.sun.syndication.feed.synd.*" %>
<%@page import="com.iphone.rssfeed.DaoImpl.*" %>
<%@page import="com.iphone.model.*" %>
<%@page import="com.iphone.rssfeed.Dao.*" %>
<%@page import="com.iphone.rssfeed.manager.*" %>
<%@page import="com.iphone.rssfeed.util.*" %>
<%@page import="org.springframework.web.context.WebApplicationContext" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta httdiv-equiv="refresh" content="20">
		<title>left</title>
		<script type="text/javascript">
			function autoAddRssNews()
			{
				<%  
					RssFeedNewsRefresh rss= new RssFeedNewsRefresh();				
				%>
			}
			function add(){
				//window.open("add_rss.jsp");
				window.location.href="add_rss.jsp";
			}
			
			function del(){
				var checkeds =new Array();
				checkeds= document.getElementsByName("check");
				var checkVal="";
				for(var i =0 ;i < checkeds.length; i++){
					if(checkeds[i].checked){
						checkVal +=checkeds[i].value+",";
					}	
				}
				//alert(checkVal);
				window.location.href="rssdeal.jsp?op=del&check="+checkVal;
			}
		</script>	
		<style type="text/css">
			body {
				background-image:url(image/eg_bg_03.gif);
				background-repeat: repeat;
				padding-left: 2em;
			}
			#add1 {
				background-color: #66CCFF;
				margin:0 auto; 
			}
			#del1 {
				background-color: #66CCFF;
			}
			
		</style>
					
</head>
	<body>
		<form id="submitForm" action="user/UserAction" method="get">
		<table align=left valign=top >
			<th>RSS源</th>
			<%		
			WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
			RssFeedService rfs = (RssFeedService)context.getBean("rssFeedService");
			List<RssFeed> list = rfs.findAll();
			RssFeedUtil rssFeedUtil= new RssFeedUtil();		
		%>
			<%if(list.size() == 0){ %>
			<tr>
				<td align="center">未添加源</td>
			</tr>
			<% }else { %>
			<%
				for(int i=0;i<list.size();i++)
				{
			%>
			<tr>
				<td><input type="checkbox" name="check" id="check" value="<%=list.get(i).getId() %>" ></td>
				<td>
					<a href="right.jsp?url=<%=list.get(i).getFeedUrl() %>"  target="right" ><%=list.get(i).getFeedName() %>
					</a>
				</td>
			</tr>
			<% } }%>
			
			<tr valign="bottom" height="10%">
				<td><input id="add1" type="button" width="50px" value="添加" onclick="add()" ></td>
				<td><input id="del1" type="button" width="50px" value="删除" onclick="del()" ></td>
			</tr>
		</table>
		</form>
		<s:debug></s:debug>
	</body>
</html> 