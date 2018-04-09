<%@page contentType="text/html;charset=utf-8"%>
<%@page import="databasemanage.DatabaseManage"%>
<%@page import="java.sql.*"%>
<html>
    <head>
        <meta name='viewport' content='width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;'>
        <title>读者信息</title>
    </head>
    <body>
        <h1 align="center">读者信息</h1>
        
            <%
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            String readerid = request.getParameter("readerid");
            DatabaseManage dm = new DatabaseManage();
            Connection con = null;
            ResultSet rs = null;
            con = dm.getConnection();
            String readertype = null;
            int bookamount = 0;
            int bookdays = 0;
            String sql = "select * from tb_reader where readerid="+"\'"+readerid+"\'";
            if(con!=null) {
                rs = dm.executeQuery(sql);
            }
            try{
                if(rs!=null&&rs.next()) {
                    out.println("读者基本信息: "+"<br>");
                    out.println("<table width=100% border=1 cellspacing=0>");
                    out.println("<tr>");
                    out.println("<th>读者姓名</th>");
                    out.println("<th>读者性别</th>");
                    out.println("<th>读者联系方式</th>");
                    out.println("<th>读者办证日期</th>");
                    out.println("<th>借书证注销日期</th>");
                    out.println("<th>读者类型</th>");
                    out.println("</tr>");
                    rs.beforeFirst();
                    while(rs.next()) {
                        out.println("<tr>");
                        out.println("<td>"+rs.getString("readername")+"</td>");
                        out.println("<td>"+rs.getString("readergender")+"</td>");
                        out.println("<td>"+rs.getString("readerunit")+"</td>");
                        out.println("<td>"+rs.getString("readertel")+"</td>");
                        out.println("<td>"+rs.getDate("readerstart")+"</td>");
                        out.println("<td>"+rs.getDate("readerend")+"</td>");
                        out.println("<td>"+(readertype=(rs.getString("readertype")))+"</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                }
            }
            catch(Exception e) {
                e.printStackTrace();
            }
            sql = "select from tb_readertype where readertype+"+"\'"+readertype+"\'";
            if(con!=null){
                rs=dm.executeQuery(sql);
            }
            try{
                if(rs!=null&&rs.next()){
                    out.println("读者基本信息: "+"<br>");
                    out.println("<table width=100% border=1 cellspacing=0>");
                    out.println("<tr>");
                    out.println("<th>读者类型</th>");
                    out.println("<th>借书数量</th>");
                    out.println("<th>借书天数</th>");
                    out.println("<th>超期每日罚款金额</th>");
                    out.println("</tr>");
                    rs.beforeFirst();
                    while(rs.next()){
                        out.println("<tr>");
                        out.println("<td>"+rs.getString("readertype")+"</td>");
                        out.println("<td>"+(bookamount=(rs.getInt("bookamount")))+"</td>");
                        out.println("<td>"+(bookdays=(rs.getInt("bookdays")))+"</td>");
                        out.println("<td>"+rs.getBigDecimal("dayfine")+"</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                }
            }
            catch(Exception e) {
                e.printStackTrace();
            }
            request.getSession(true);
            session.setAttribute("bookdays",new Integer(bookdays));
            sql = "select * from tb_booklend where readerid="+"\'"+readerid+"\'"+"and returndate is NULL";
            int count = 0;
            int finecount = 0;
            if (con!=null) {
                rs=dm.executeQuery(sql);
            }
            try{
                if(rs!=null&&rs.next()){
                    out.println("<br>");
                    out.println("读者当前借阅信息: "+"<br>");
                    out.println("<table width=100% border=1 cellspacing=0>");
                    out.println("<tr>");
                    out.println("<th>图书条形码</th>");
                    out.println("<th>借书日期</th>");
                    out.println("<th>应还日期</th>");
                    out.println("</tr>");  
                    rs.beforeFirst();
                    while(rs.next()) {
                        out.println("<tr>");
                        out.println("<td>"+rs.getString("bookcode")+"</td>");
                        out.println("<td>"+rs.getDate("borrowdate")+"</td>");
                        out.println("<td>"+rs.getDate("duedate")+"</td>");
                        if(rs.getDate("dudate").before(new java.util.Date())){
                            finecount++;
                        }
                        out.println("</tr>");
                        count++;
                    }
                    out.println("</table>");
                }
            }
            catch(Exception e) {
                e.printStackTrace();
            }
            dm.close();
            out.println("<br>");
            out.println("读者当前借阅"+count+"本");
            out.println("<br>");
            out.println("读者当前超期"+finecount+"本");
            if(count==bookamount)
                out.println("已达最大借阅数");
            if(finecount!=0)
                out.println("有超期图书");
            out.println("<br><br>");
            if(count<bookamount && finecount==0)
                out.println("<a href=ReaderBorrowFinal.jsp>读者借阅图书</a>");
            %>
        
    </body>
</html>