<%@page contentType="text/html;charset=utf-8"%>
<%@page import="databasemanage.DatabaseManage"%>
<%@page import="java.sql.*"%>
<%@ page import="java.math.*"%>
<%@page import="java.util.*"%>
<html>
    <head>
        <meta name='viewport' content='width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;'>
        <title>图书归还处理</title>
    </head>
    <body>
        <h1 align="center">图书归还处理</h1>
        <p align="center">
            <%
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            DatabaseManage dm = new DatabaseManage();
            request.getSession();
            String bookcode = request.getParameter("bookcode");
            session.setAttribute("bookcode",bookcode);
            String readerid = (String)session.getAttribute("readerid");
            String sql1 = "select * from tb_booklend where "
                        +"bookcode=? and readerid=? and returndate is NULL";
            Connection con = null;
            ResultSet rs = null;
            con = dm.getConnection();
            try{
                PreparedStatement pstmt = con.prepareStatement(sql1);
                pstmt.setString(1,bookcode);
                pstmt.setString(2,readerid);
                rs = pstmt.executeQuery();
                rs.next();
                java.sql.Date duedate = rs.getDate("duedate");
                String sql2 = "select * from tb_readerid="+"\'"+readerid+"\'";
                if(con!=null) {
                    rs=dm.executeQuery(sql2);
                }
                rs.next();
                String readertype = rs.getString(9);
                String sql3 = "select * from tb_readertype where readertype="+"\'"+readertype+"\'";
                if(con!=null){
                    rs=dm.executeQuery(sql3);
                }
                rs.next();
                BigDecimal dayfine = rs.getBigDecimal(4);
                Calendar cal = Calendar.getInstance();
                long time1 = cal.getTimeInMillis();
                cal.setTime(duedate);
                long time2 = cal.getTimeInMillis();
                long between_days = (time1-time2)/(1000*3600*24);
                int days = (int)between_days;
                if(duedate.before(new java.util.Date())){
                    out.println("图书已超期");
                    out.println("超期天数: "+days);
                    out.println("罚款金额: "+dayfine.multiply(new BigDecimal(days)));
                }
            }catch(Exception e){
                e.printStackTrace();
            }
            dm.close();
            %>
            <br><br>
            <a href="servlet/ReaderTurnServlet">还书</a>
        </p>
    </body>

</html>