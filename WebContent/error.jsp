<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<script type="text/javascript">
		function fun1()
		{
			alert("error");
			//window.location.href = "welcome.jsp";
			window.location.href = "UserAction?username=daniel&userpass=abcde";
		}
	</script>
</head>

<body>
    <font color="red" size="5">�û����������</font>
    <input type="button"  value="ȡ ��" onclick="fun1()">
  </body>
</html>
