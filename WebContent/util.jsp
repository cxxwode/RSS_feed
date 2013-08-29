<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>特殊操作</title>
		<script type='text/javascript' src='/RSS_feed/dwr/interface/RssFeedService.js'></script>
		<script type='text/javascript' src='/RSS_feed/dwr/engine.js'></script>
		<script type="text/javascript">
			/**
			 * 重置节目包附件缓存库状态
			 */
			function DealState() {
				ProgPackageServiceImpl.initDealState(document.getElementById("progPackageName").value, function(result) {
					//alert(result);
					document.getElementById("initResult").innerHTML = result;
				});			
			}
			
			/**
			 * 重置主文件迁移中状态
			 */
			function MigrationState() {
				ProgPackageServiceImpl.initMigrationState(document.getElementById("progPackageName").value, function(result) {
					//alert("11111111");
					document.getElementById("initResult").innerHTML = result;
				});
			}
			
			function test(){
				RssFeedService.test(document.getElementById("rssFeedName").value, function(result) {
					alert("testResult");
					document.getElementById("testResult").innerHTML = result;
				});
			}
			
			function addRssFeed(){
				var rssFeed;
				var url = document.getElementById("rssFeedUrl").value
				alert(url);
				rssFeed = { feedName:"user",feedUrl:url };
				RssFeedService.add(rssFeed);
			}
		</script>

	</head>
	<body>
		<div id="progPackage">
			重置节目包使用状态: <br/><input type="text" id="progPackageName">
			<input type="button" value="重置节目包附件缓存库状态" onclick="DealState();" />
			<input type="button" value="重置主文件迁移中状态" onclick="MigrationState();" />
			<label id="initResult" style="color:red"></label>
		</div>
		<div id="rssFeed">
		测试:</br><input type="text" id="rssFeedName">
		添加:</br><input type="text" id="rssFeedUrl">
		<input type="button" value="RssFeed测试" onclick="addRssFeed();" />
		<label id="testResult" style="color:red"></label>
		</div>
		<br />
		<br />
	</body>
</html>