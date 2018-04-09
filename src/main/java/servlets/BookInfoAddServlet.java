 package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import databasemanage.DatabaseManage;

public class BookInfoAddServlet extends HttpServlet {
	
	public BookInfoAddServlet() {
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
		String isbn = request.getParameter("isbn");
		String status = request.getParameter("status");
		DatabaseManage dm = new DatabaseManage();
		Connection con = dm.getConnection();
		int num = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement("insert into tb_bookinfo values(?,?,?)");
			pstmt.setString(1, bookcode);
			pstmt.setString(2, isbn);
			pstmt.setString(3, status);
			num = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(num == 0) {
			response.sendRedirect("../BookInfoAddFailer.jsp");
		}
		else {
			response.sendRedirect("../BookInfoAddSuccess.jsp");
		}
		dm.close();
	}
	
	public void init() throws ServletException {
		super.init();
	}
	
	
}
