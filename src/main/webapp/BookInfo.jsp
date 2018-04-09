<%@page contentType="text/html;charset=utf-8"%>
<%@page import="databasemanage.DatabaseManage"%>
<%@page import="java.sql.*"%>
<html>
    <head>
        <meta name='viewport' content='width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;'>
        <title>图书馆藏信息管理</title>
    </head>
    <body>
        <h1 align="center">图书馆藏信息管理</h1>
        
            <%
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            DatabaseManage dm = new DatabaseManage();
            Connection con = null;
            ResultSet rs = null;
            con = dm.getConnection();
            String sql = "select tb_bookinfo.bookcode,tb_bookinfo.isbn,tb_book.bookname, "
                        +"tb_book.bookauthor,tb_book.bookpublisher,tb_book.publishdate, "
                        +"tb_book.status from tb_book,tb_bookinfo where tb_book.isbn=tb_bookinfo.isbn";
            if(con!=null) {
                rs=dm.executeQuery(sql);
            }
            try{
                if(rs!=null&&rs.next()){
                    out.println("<table width=100% border=1 cellspacing=0>");
                    out.println("<tr>");
                    out.println("<th>图书条形码</th>");
                    out.println("<th>图书国际标准书号</th>");
                    out.println("<th>图书名称</th>");
                    out.println("<th>作者</th>");
                    out.println("<th>出版社</th>");
                    out.println("<th>出版日期</th>");
                    out.println("<th>图书是否可借</th>");
                    out.println("</tr>");
                    rs.beforeFirst();
                    while(rs.next()){
                        out.println("<tr>");
                        out.println("<td>"+rs.getString("bookcode")+"</td>");
                        out.println("<td>"+rs.getString("isbn")+"</td>");
                        out.println("<td>"+rs.getString("bookname")+"</td>");
                        out.println("<td>"+rs.getString("bookauthor")+"</td>");
                        out.println("<td>"+rs.getString("bookpublisher")+"</td>");
                        out.println("<td>"+rs.getDate("publishdate")+"</td>");
                        out.println("<td>"+rs.getString("status")+"</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                }
            }
            catch(Exception e) {
                e.printStackTrace();
            }
            dm.close();
            %>
            <br><br>
            <a href="BookInfoAdd.jsp">添加图书馆藏信息</a>
            <a href="AdminMain.jsp">返回</a>
        
    </body>
</html>