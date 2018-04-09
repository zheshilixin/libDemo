<%@page contentType="text/html;charset=utf-8"%>
<%@page import="databasemanage.DatabaseManage"%>
<%@page import="java.sql.*"%>
<html>
    <head>
        <meta name='viewport' content='width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;'>
        <title>读者类型参数修改</title>
    </head>
    <body>
        <h1 align="center">读者类型参数修改</h1>
        <%
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            String readertype=request.getParameter("readertype");
            DatabaseManage dm = new DatabaseManage();
            Connection con = null;
            ResultSet rs = null;
            con = dm.getConnection();
            String sql = "select * from tb_readertype where readertype='"+readertype+"'";
            if (con!=null) {
                rs=dm.executeQuery(sql);
                rs.absolute(1);
            }
        %>
        
            <form id="readertypemodify" name="readertypemodify" method="post" 
                action="servlet/ReaderTypeModiServlet">
                <table>
                    <tr>
                            <td align=right>读者类型</td>
                            <td>
                                <input name="readertype" type="text" value=<%=rs.getString(1)%>readonly>
                            </td>
                        </tr>
                    <tr>
                        <td align=right>借书数量:</td>
                        <td>
                            <input name="bookadmount" type="text" value=<%=rs.getInt(2)%>>
                        </td>
                    </tr>
                    <tr>
                        <td align=right>借书天数</td>
                        <td>
                            <input name="bookdays" type="text" value=<%=rs.getInt(3)%>>
                        </td>
                    </tr>
                    <tr>
                        <td align=right>超期还书时每日罚款金额:</td>
                        <td>
                            <input name="dayfine" type="text" value=<%=rs.getBigDecimal(4)%>>
                        </td>
                    </tr>
                    <tr>
                        <td align=right></td>
                        <td>
                            <input type="submit" value="修改"/>
                        </td>
                    </tr>
                </table>
            </form>
        
        <%
            dm.close();
        %>
    </body>
</html>