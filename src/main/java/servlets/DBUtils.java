package servlets;



import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import org.apache.commons.dbcp.BasicDataSource;

/*
 * 连接池版本的数据库连接管理工具类
 * 适合于并发场�?
 */

public class DBUtils {
	private static String driver;
	private static String url;
	private static String username;
	private static String password;
	private static int initSize;
	private static int maxActive;
	private static BasicDataSource ds;
	
	static {
		ds = new  BasicDataSource();
		Properties cfg = new Properties();
		try {
			InputStream in = DBUtils.class.getClassLoader()
					.getResourceAsStream("db.properties");
			cfg.load(in);
			//初始化参�?
			driver = cfg.getProperty("jdbc.driver");
			url = cfg.getProperty("jdbc.url");
			username = cfg.getProperty("jdbc.username");
			password = cfg.getProperty("jdbc.password");
			initSize = Integer.parseInt(cfg.getProperty("initSize"));
			maxActive = Integer.parseInt(cfg.getProperty("maxActive"));
			in.close();
			//初始化连接池
			ds.setDriverClassName(driver);
			ds.setUrl(url);
			ds.setUsername(username);
			ds.setPassword(password);
			ds.setInitialSize(initSize);
			ds.setMaxActive(maxActive);
		}catch(Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	public static Connection getConnection() {
		try {
			//getConnection()从连接池获取重用的连�?,如果连接池满�?,则等�?
			//如果有连接归�?,则获取重用的连接
			Connection conn = ds.getConnection();
			return conn;
		}catch(Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	public static void close(Connection conn) {
		if (conn!=null) {
			try {
				//将用过的连接归还到连接池
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void rollback(Connection conn) {
		if(conn!=null) {
			//出现异常回滚
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}
}

