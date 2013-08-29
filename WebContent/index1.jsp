<%@page import="com.sun.syndication.feed.synd.SyndFeed"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="utf-8"%>
<%@page import="java.util.*"%>
<%@page import="java.*"%>
<%@page import="javax.servlet.*"  %>
<%@page import="java.net.*"%>
<%@page import="org.jdom.*"%>
<%@page import="com.sun.syndication.io.*"%>
<%@page import="com.sun.syndication.feed.synd.*"%>

<html>

<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8">

<title>sina news</title>
<script type="text/javascript">
	function fun() {

		alert("---   ");
<%System.out.println("i+1");%>
	window.location.reload();
	}
</script>

</head>

<body>
	<%! String str = "未读"; %>
	<%
	java.util.Properties systemsettings = System.getProperties();
	systemsettings.put("http.proxyhost", "mywebcache.com");
	systemsettings.put("http.proxyport", "8080");
	System.setProperties(systemsettings);
 
	String urlstr = "http://rss.sina.com.cn/news/marquee/ddt.xml";
	URLConnection feedurl = new URL(urlstr).openConnection();
	feedurl.setRequestProperty("user-agent", "mozilla/4.0 (compatible; msie 5.0; windows nt; digext)");
	SyndFeedInput input = new SyndFeedInput();
	SyndFeed feed = input.build(new XmlReader(feedurl));
%>
	<form name=f1 align="center">
		<table border=1 cellpadding=3 width="900">
			<tr>
				<th onclick="fun()">
					<div>
						<table>
							<tr>
								<td valign="top">RSS源</td>
							</tr>
							<tr>
								<td><a href="<%=feed.getLink() %>"><%=feed.getTitle()%></a>
								</td>
							</tr>
						</table>
					</div>
				</th>

				<th>
					<div align="center">
						<!--  	<h1><%=feed.getTitle()%></h1>  -->
						<table border=1 cellpadding=3 width="700">
							<tr>
								<th>number</th>
								<th>title</th>
								<th>author</th>
								<th>time</th>
								<th>state</th>
								<th>store</th>
							</tr>
							<%
								List list = feed.getEntries();
								for (int i = 0; i < list.size(); i++) {
									SyndEntry entry = (SyndEntry) list.get(i);
							%>

							<tr>
								<td><%=i + 1%></td>
								<td><a href="<%=entry.getLink()%>" name="a" onclick=fun()><%=entry.getTitle()%></a>
								</td>
								<td><%=entry.getAuthor()%></td>
								<td><%=entry.getPublishedDate()%></td>
								<td><input type="text" name="text" readOnly="readonly"
									defaultValue="rss" value="<%=str %>"></td>
								<td>未收藏</td>
							</tr>
							<%}%>

						</table>
					</div>
				</th>
			</tr>
		</table>
	</form>
	<br>
</body>

</html>
