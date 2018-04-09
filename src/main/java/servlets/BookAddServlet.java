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

public class BookAddServlet extends HttpServlet {
	public BookAddServlet() {
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
		String isbn = request.getParameter("isbn");
		String bookname = request.getParameter("bookname");
		String bookauthor = request.getParameter("bookauthor");
		String booktanslator = request.getParameter("booktranslator");
		String bookpublisher = request.getParameter("bookpublisher");
		String publishdate = request.getParameter("publishdate");
		int bookpage = Integer.parseInt(request.getParameter("bookpage"));
		BigDecimal bookprice = new BigDecimal(request.getParameter("bookprice"));
		DatabaseManage dm = new DatabaseManage();
		Connection con = dm.getConnection();
		int num = 0;
		try {
			 PreparedStatement pstmt = con.prepareStatement("insert into tb_book values(?,?,?,?,?,?,?,?)");
			 pstmt.setString(1, isbn);
			 pstmt.setString(2, bookname);
			 pstmt.setString(3, bookauthor);
			 pstmt.setString(4, booktanslator);
			 pstmt.setString(5, bookpublisher);
			 pstmt.setDate(6, java.sql.Date.valueOf(publishdate));
			 pstmt.setInt(7, bookpage);
			 pstmt.setBigDecimal(8, bookprice);
			 num = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(num==0) {
			response.sendRedirect("../BookAddFailer.jsp");
		}
		else {
			response.sendRedirect("../BookAddSuccess.jsp");
		}
		dm.close();
	}
	public void init() throws ServletException {
		super.init();
	}
	

}
