package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databasemanage.DatabaseManage;

public class ReaderLoginCheck extends HttpServlet {
	public ReaderLoginCheck() {
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
		String readername = request.getParameter("readername");
		HttpSession session = request.getSession(true);
		String password = request.getParameter("password");
		DatabaseManage dm = new DatabaseManage();
		Connection con = null;
		ResultSet rs = null;
		boolean result = false;
		con = dm.getConnection();
		String sql = "select * from tb_reader where readerid="+"\'"+readername+"\'"+"and readerpwd="+"\'"+password+"\'";
		if(con!=null) {
			rs=dm.executeQuery(sql);
		}
		try {
			if(rs!=null) {
				result = rs.next();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result) {
			response.sendRedirect("../ReaderMain.jsp");
			session.setAttribute("readerid", readername);
			session.setAttribute("password", password);
		}else {
			response.sendRedirect("../ReaderLoginFail.jsp");
		}
		dm.close();
	}
	public void init() throws ServletException{
		super.init();
	}

}
