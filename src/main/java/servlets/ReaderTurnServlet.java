package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databasemanage.DatabaseManage;

public class ReaderTurnServlet extends HttpServlet {
	public ReaderTurnServlet() {
		super();
	}
	public void destroy() {
		super.destroy();
	}
	@Override
	protected void doGet(
			HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String readerid = (String)session.getAttribute("readerid");
		String bookcode = (String)session.getAttribute("bookcode");
		DatabaseManage dm = new DatabaseManage();
		Connection con = dm.getConnection();
		ResultSet rs= null;
		String sql1 = "select * from tb_booklend where bookcode=? "
					+"and readerid=? and returndate is NULL";
		int num1 = 0;
		int num2 = 0;
		try {
			con.setAutoCommit(false);
			PreparedStatement pstmt = con.prepareStatement(sql1);
			pstmt.setString(1, bookcode);
			pstmt.setString(2, readerid);
			rs=pstmt.executeQuery();
			rs.next();
			java.sql.Date duedate = rs.getDate("duedate");
			String sql2 = "select * from tb_reader where readerid="+"\'"+readerid+"\'";
			if(con!=null) {
				rs=dm.executeQuery(sql2);
			}
			rs.next();
			String readertype = rs.getString(9);
			String sql3 = "select * from tb_readertype where readertype="+"\'"+readertype+"\'";
			if(con!=null) {
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
			BigDecimal total = dayfine.multiply(new BigDecimal(days));
			String sql4 = "update tb_booklend set returndate=?, overdueday=?, fine=? "
						+"where bookcode= "+bookcode+" and readerid= "+readerid+
						" and returndate is NULL";
			pstmt=con.prepareStatement(sql4);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			c.setTime(new java.util.Date());
			pstmt.setDate(1, java.sql.Date.valueOf(df.format(new java.util.Date())));
			pstmt.setInt(2,days);
			pstmt.setBigDecimal(3, total);
			if(duedate.before(new java.util.Date())) {
				num1 = pstmt.executeUpdate();
			}else {
				String sql5 = "update tb_booklend set return=? where bookcode= "+bookcode+
						" and readerid= "+readerid+" and returndate is NULL";
				pstmt = con.prepareStatement(sql5);
				df = new SimpleDateFormat("yyyy-MM-dd");
				c = Calendar.getInstance();
				c.setTime(new java.util.Date());
				pstmt.setDate(1, java.sql.Date.valueOf(df.format(new java.util.Date())));
				num1 = pstmt.executeUpdate();
			}
			pstmt = con.prepareStatement("update tb_bookinfo set status=? where bookcode=?");
			pstmt.setString(1, "YES");
			pstmt.setString(2, bookcode);
			num2 = pstmt.executeUpdate();
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				con.rollback();
				con.setAutoCommit(false);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		if(num1==1&&num2==1) {
			response.sendRedirect("../BookReturnSuccess.jsp");
		}else {
			response.sendRedirect("../BookReturnFalse.jsp");
		}
		dm.close();
	}
	public void init() throws ServletException{
		super.init();
	}

	
}













