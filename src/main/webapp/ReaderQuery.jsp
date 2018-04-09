<%@page contentType="text/html;charset=utf-8"%>
<%
    response.setCharacterEncoding("utf-8");
    request.setCharacterEncoding("utf-8");
%>
<html>
    <head>
        <meta name='viewport' content='width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;'>
        <title>读者图书查询页面</title>
    </head>
    <body>
        <h1 align="center">图书查询</h1>
        <p>
            <form id="bookquery" name="bookquery" method="POST" action="BookQuery.jsp">
                <table>
                    <tr>
                        <td>图书名称: </td>
                        <td>
                            <input name="bookname" type="text" title="图书名称"/>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="right">
                            <input type="submit" value="查询"/>
                        </td>
                    </tr>
                </table>
            </form>
        </p>
    </body>
</html>
