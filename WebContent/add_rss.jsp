<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*" errorPage="" %>
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
<html>
<%
	WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
	RssFeedService rfs = (RssFeedService)context.getBean("rssFeedService");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>���RSSԴ</title>

<script language="javascript">
function check(myForm){
	if(myForm.url.value==""){
		alert("������RSSƵ����ַ��");myForm.url.focus();return false;
	}
	//var Expression=/^http:\/\/.*[:\d*][\/].*[\/]\w*[\.].+$/;
	var Expression=/^http:\/\/.*[:\d*][\/].*[\/]\w*[\.].+$|http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w-.\/?%&=]*)?$/;
	var objExp=new RegExp(Expression);
	if(objExp.test(form1.url.value)==false){
		alert("�������RSSƵ����ַ����ȷ��");return false;
	}

}
function autoAddURL(){
	var rssUrl=window.clipboardData.getData('Text');
	//var Expression=/http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w-.\/?%&=]*)?/; 
	var Expression=/^http:\/\/.*[:\d*][\/].*[\/]\w*[\.].+$|http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w-.\/?%&=]*)?$/;
	var objExp=new RegExp(Expression);
	if(objExp.test(rssUrl)==true){		//����������е����ݷ���URL��ַ��׼�����������е�������ӵ�RSSƵ����ַ�ı�����
		form1.url.value=rssUrl;
	}
}
</script>
</head>

<body onLoad="autoAddURL()">

<form name="form1" method="post" action="rssdeal.jsp">
<table width="100%" height="168" border="0" cellpadding="0" cellspacing="0">

	<tr><input type="hidden" name="op" value="add"></input></tr>
	<tr>
      <td>RSS����:<input name="urlname" id="urlname" type="text" size="48"></td>
    </tr>
   	<tr>
      <td>RssURL:<input name="url" id="url" type="text" size="48"></td>
    <tr>
      <td width="10%"><input name="flag" type="checkbox" class="noborder" value="flag" checked>
		��֤Ƶ����ַ����Ч��</td>
	</tr>
	<tr>
     <td><input type="submit" class="btn_grey" value="ȷ��" ></td>
    </tr>
</table>
</form>
</body>
</html>