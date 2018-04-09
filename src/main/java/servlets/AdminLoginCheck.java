package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import databasemanage.DatabaseManage;
import java.sql.*;



public class AdminLoginCheck extends HttpServlet{
	public AdminLoginCheck() {
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
		String adminname = request.getParameter("adminname");
		String password = request.getParameter("adminame");
		DatabaseManage dm = new DatabaseManage();
		Connection con = null;
		ResultSet rs = null;
		boolean result = false;
		con = dm.getConnection();
		String sql = "select * from tb_manager where manageid="+"\""+adminname+"\""+ 
					"and managepwd="+"\""+password+"\"";
		if (con!=null) {
			rs = dm.executeQuery(sql);
		}
		try {
			if (rs!=null) {
				result = rs.next();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(result) {
			response.sendRedirect("../AdminMain.jsp");
		}
		else {
			response.sendRedirect("../LoginFial.jsp");
		}
		dm.close();
		
	}
	public void init() throws ServletException {
		super.init();
	}
}














