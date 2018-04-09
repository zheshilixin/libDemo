package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databasemanage.DatabaseManage;

public class BookLendServlet extends HttpServlet {
	
	public BookLendServlet(){
		super();
	}
	
	public void destroy() {
		super.destroy();
	}

	@Override
	protected void doPost(
			HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String bookcode = request.getParameter("bookcode");
		String readerid = request.getParameter("readerid");
		HttpSession session = request.getSession();
		session.setAttribute("readerud", readerid);
		int bookdays = ((Integer)session.getAttribute("bookdays")).intValue();
		DatabaseManage dm = new DatabaseManage();
		Connection con = dm.getConnection();
		int num = 0;
		int numu = 0;
		try {
			con.setAutoCommit(false);
			PreparedStatement pstmt = con.prepareStatement("insert into tb_booklend values(NULL,?,?,?,?,?,?,?)");
			pstmt.setString(1, bookcode);
			pstmt.setString(2, readerid);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			c.setTime(new java.util.Date());
			c.add(Calendar.DAY_OF_YEAR,bookdays);
			pstmt.setDate(3, java.sql.Date.valueOf(df.format(new java.util.Date())));
			pstmt.setDate(4, java.sql.Date.valueOf(df.format(c.getTime())));
			pstmt.setDate(5, null);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 0);
			num = pstmt.executeUpdate();
			pstmt = con.prepareStatement("update tb_bookinfo set status=? where bookcode=?");
			pstmt.setString(1, "否");
			pstmt.setString(2, bookcode);
			numu=pstmt.executeUpdate();
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
		if(num==1&&numu==1) {
			response.sendRedirect("../BookLendSuccess.jsp");
		}
		else {
			response.sendRedirect("../bookLendFailer.jsp");
		}
		dm.close();
	}
	
	public void init() throws ServletException{
		super.init();
	}
	
	

}
