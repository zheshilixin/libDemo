<%@ page contentType="text/html; charset=utf-8"%>
<html>
	<head>
		<meta name='viewport' content='width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;'>
		<title>管理员登陆页面</title>
	</head>
	<body>
		<h1 align="center">图书管理系统</h1>
		
			<img src="../../../images/secs.jpg" width="1000" height="500"/>
			<form id="adminlogin" name="adminlogin" method="post"
				action="servlet/AdminLoginCheck">
				<table>
					<tr>
						<td>管理员名称:</td>
						<td>
							<input name="adminname" type="text" title="管理员名称"/>
						</td>
					</tr>
					<tr>
						<td>管理员密码:</td>
						<td>
							<input name="password" type="password" title="管理员密码"/>
						</td>
					</tr>
					<tr>
						<td></td>
						<td align="right">
							<input type="submit" value="登陆"/>
						</td>
					</tr>
				</table>
			</form>
		
	</body>

</html>