<%@page contentType="text/html;charset=utf-8"%>
<html>
    <head>
        <meta name='viewport' content='width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;'>
        <title>读者登陆页面</title>
    </head>
    <body>
        <h1 align="center">图书管理系统</h1>
        
            <img alt="umi" src="../../../images/secs.jpg" width="600" height="200"/>
            <form id="readerlogin" name="readerlogin" method="POST" action="servlet/ReaderLoginCheck">
                <table>
                    <tr>
                        <td>用户名称</td>
                        <td>
                            <input name="readername" type="text" title="用户名称"/>
                        </td>
                    </tr>
                    <tr>
                            <td>密码:</td>
                            <td>
                                <input name="password" type="text" title="密码"/>
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