<%@page contentType="text/html;charset=utf-8"%>
<%@page import="databasemanage.DatabaseManage"%>
<%@page import="java.sql.*"%>
<html>
    <head>
        <meta name='viewport' content='width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;'>
        <title>图书基本信息管理</title>
    </head>
    <body>
        <h1 align="center">图书基本信息管理</h1>
       
            <%
                request.setCharacterEncoding("utf-8");
                response.setCharacterEncoding("utf-8");
                DatabaseManage dm = new DatabaseManage();
                Connection con = null;
                ResultSet rs = null;
                con = dm.getConnection();
                String sql = "select * from tb_book";
                if(con!=null){
                    rs = dm.executeQuery(sql);
                }
                try{
                    if(rs!=null&&rs.next()) {
                        out.println("<table width=100% border=1 cellspacing=0>");
                        out.println("<tr>");
                        out.println("<th>图书国际标准书号</th>");
                        out.println("<th>图书名称</th>");
                        out.println("<th>作者</th>");
                        out.println("<th>译者</th>");
                        out.println("<th>出版社</th>");
                        out.println("<th>出版日期</th>");
                        out.println("<th>页数</th>");
                        out.println("<th>定价</th>");
                        out.println("</tr>");
                        rs.beforeFirst();
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>"+rs.getString("isbn")+"</td>");
                            out.println("<td>"+rs.getString("bookname")+"</td>");
                            out.println("<td>"+rs.getString("bookauthor")+"</td>");
                            out.println("<td>"+rs.getString("booktranslator")+"</td>");
                            out.println("<td>"+rs.getString("bookpublisher")+"</td>");
                            out.println("<td>"+rs.getString("publishdate")+"</td>");
                            out.println("<td>"+rs.getInt("bookpage")+"</td>");
                            out.println("<td>"+rs.getBigDecimal("bookprice")+"</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    }
                }
                catch(Exception e) {
                    e.printStackTrace();
                }
            %>
            <br><br>
            <a href="BookAdd.jsp">添加图书基本信息</a>
            <a href="AdminMain.jsp">返回</a>
       
    </body>
</html>