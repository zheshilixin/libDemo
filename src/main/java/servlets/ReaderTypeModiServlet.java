package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import databasemanage.DatabaseManage;

public class ReaderTypeModiServlet extends HttpServlet{
	public ReaderTypeModiServlet() {
		super();
	}
	public void destroy() {
		super.destroy();
	}
	
	
	@Override
	protected void doPost(
			HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		String readertype = request.getParameter("readertype");
		int bookamount = Integer.parseInt(request.getParameter("bookamout"));
		int bookdays = Integer.parseInt(request.getParameter("boodays"));
		BigDecimal dayfine = new BigDecimal(request.getParameter("dayfine"));
		DatabaseManage dm = new DatabaseManage();
		Connection con = dm.getConnection();
		int num = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement("update tb_readertype set bookamount=?,bookdays=?,dayfine=?where readertype=?");
			pstmt.setInt(1, bookamount);
			pstmt.setInt(2, bookdays);
			pstmt.setBigDecimal(3, dayfine);
			pstmt.setString(4, readertype);
			num = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(num==0) {
			response.sendRedirect("../ReaderTypeModiFailer.jsp");
		}
		else {
			response.sendRedirect("../ReaderTypeModiSuccess.jsp");
		}
		dm.close();
	}
	
	public void init() throws ServletException {
		super.init();
	}
	

}
