package com.iu.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnector {
	
	public static Connection getConnect() throws Exception{
		Connection con = null;
		String user = "user03";
		String password = "user03";
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String driver = "oracle.jdbc.driver.OracleDriver";
		//2.메모리에 로딩
		Class.forName(driver);
		
		//3.Connection 맺기
		con = DriverManager.getConnection(url, user, password);
		return con;
	}
	
	public static void disConnect(ResultSet rs , PreparedStatement st , Connection con) {
		try {
			rs.close();
			st.close();
			con.close();
		} catch (Exception e) {
			
		}
		
	}
	
	public static void disConnect(PreparedStatement st , Connection con) {
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			
		}
		
	}
}
