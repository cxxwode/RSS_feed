<%@page import="javax.xml.ws.Dispatch"%>
<%@ page language="java" contentType="text/html; charset=GB2312" pageEncoding="GB2312"%>
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
<%
	WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
	RssFeedService rfs = (RssFeedService)context.getBean("rssFeedService");
	FeedNewsService fns = (FeedNewsService)context.getBean("feedNewsService");
	
	String operator = request.getParameter("op");
	System.out.println(operator);
	if(operator.equalsIgnoreCase("add")){
		String url=request.getParameter("url");
		//String urlname=request.getParameter("urlname");
		RssFeed rssFeed = new RssFeed();
		RssFeedUtil rssFeedUtil= new RssFeedUtil();	
		rssFeed.setFeedName(rssFeedUtil.getFeed(url).getTitle().trim());
		rssFeed.setFeedUrl(url);
		rfs.add(rssFeed);
		response.sendRedirect("left.jsp");
	}else if(operator.equalsIgnoreCase("del")){
		String[] values = request.getParameter("check").split(",");
		for(int i=0;i<values.length;i++)
		{
		  	 out.println(values[i]);
		  	 int feedId = Integer.parseInt(values[i]);
		  	 fns.deleteFeedNewsByFeedId(feedId);
		  	 rfs.deleteByRssFeedId(feedId);
		}
		response.sendRedirect("left.jsp");
	}else if(operator.equalsIgnoreCase("read")){
		String id = request.getParameter("id");
		System.out.println(id);
		FeedNews feedNews = (FeedNews)fns.getFeedNewsById(Integer.valueOf(id)).get(0);
		if(feedNews.getReadOrNot().equals("未读")){
			feedNews.setReadOrNot("已读");
			fns.updateFeedNews(feedNews);
		}
		response.sendRedirect("right.jsp");
	}
	
%>

</body>
</html>