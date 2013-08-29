<%@page import="com.sun.syndication.feed.synd.SyndFeed"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="utf-8"%>
<%@page import="java.util.*" %>
<%@page import="java.*" %>
<%@page import="java.net.*" %>
<%@page import="org.jdom.*" %>
<%@page import="com.sun.syndication.io.*" %>
<%@page import="com.sun.syndication.feed.synd.*" %>
<%@page import="com.iphone.rssfeed.DaoImpl.*" %>
<%@page import="com.iphone.model.RssFeed" %>
<%@page import="com.iphone.model.FeedNews" %>
<%@page import="com.iphone.rssfeed.manager.*" %>
<%@page import="com.iphone.rssfeed.util.*" %>
<%@page import="org.springframework.web.context.WebApplicationContext" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<style type="text/css">
			body {
				background-image:url(image/eg_bg_03.gif);
				background-repeat: repeat;
				background-attachment: fixed;
				padding-left: 2em;
				text-align: center;
				text-decoration: line-through;
				font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
			}
			td {
 				 text-align:center;
 				 padding: 2px;
  			}
  			th {
  				color:#000000;
  			}
		</style>
		<script type="text/javascript">
			function change(val){
				var name = val;
				//alert(name);
				var id = document.getElementById(name);
				//alert(id.innerHTML.replace(/<.+?>/gim,''));
				if(id.innerHTML.toString().match("未读"))
				{
					//alert(name);
					id.innerHTML = "已读";
					window.location.href="rssdeal.jsp?op=read&id="+name;
				}
			}
		</script>
		<title>
			right
		</title>
		<!--  
		<meta http-equiv="refresh" content=10>
		-->
	</head>
	<%
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
		String str = null;
		try{
		 str = request.getParameter("url");
		}catch(Exception ex){
			ex.printStackTrace();
		}
		System.out.println(str);
		if(str == null){
			str = "http://rss.sina.com.cn/news/marquee/ddt.xml";
		}
		RssFeedService rfs = (RssFeedService)context.getBean("rssFeedService");
		//if(rfs.findByRssFeedUrl(str))
		RssFeed rss = (RssFeed)rfs.findByRssFeedUrl(str).get(0);
		//RssFeed rss = rfs.findAll().get(0);
		FeedNewsService fns = (FeedNewsService)context.getBean("feedNewsService");
		List feedNews = fns.getFeedNewsByFeedId(rss.getId());
		//fns.saveFeedNewsByRssFeed();
	%>
	<body>
		<form>
		<table cellpadding=3 width="700">
		<tr>
			<th>number</th>
			<th>title</th>
			<th>author</th>
			<th>time</th>
			<th>state</th>
			<th>favorite</th>
		</tr>
<% 
	for (int i=0; i< feedNews.size(); i++) {
		FeedNews feedNew = (FeedNews)feedNews.get(i);
%>
<tr>
	<td><%=feedNew.getId() %></td>
	<td><a href="<%=feedNew.getNewsUrl()%>" target="_blank" onclick="change(<%=feedNew.getId() %>)"><%=feedNew.getNewsTitle()%></a></td>
	<td><%=feedNew.getNewsAuthor() %></td>
	<td><%=feedNew.getNewsPublishedDate()%></td>
	<td id=<%=feedNew.getId() %> >
		<% if(feedNew.getReadOrNot().equals("已读")){ %>
		<font size="3" color="red"><%=feedNew.getReadOrNot() %></font>
		<% } else {%>
			<%=feedNew.getReadOrNot() %>
		<%} %>
	</td>
	<td><%=feedNew.getFavorite() %></td>
</tr>
<%}%>
	</table>
	</form>
	<s:debug></s:debug>
	</body>
</html>