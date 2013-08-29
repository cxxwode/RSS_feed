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

<%		
		WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
		//RssFeedService rfs = new RssFeedService();
		//System.out.println(rfs.findAll().size()+"");
		FeedNewsService fns = (FeedNewsService)ctx.getBean("feedNewsService");
		fns.test();

	%>
<html>
	<head>
		<title>
			RssFeed
		</title>
				
	</head>
	<body>
		测试界面
	</body>
</html> 