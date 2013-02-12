package com.weibo.store;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import com.mchange.v2.c3p0.ComboPooledDataSource;

// because the c3p0 can kill the unused connection and statement automatically

public class C3P0Pool {

	// because the dataSource and connection of the database is different
	// we don't need to create more dataSource
	// dataSource is the factory of the database's connections.
	// so we just need one dataSource in a application is enough.
	// we suggest to set the dataSource to static 
	private static ComboPooledDataSource ds = new ComboPooledDataSource();
	
	private static String url = "jdbc:mysql://180.149.138.88:3306/monitor?"+
	"useUnicode=true&amp;characterEncoding=UTF-8&amp;autoReconnect=true";
	private static String user = "im";
	private static String password = "im";
	private static String driver = "com.mysql.jdbc.Driver";
	private static int maxPoolSize = 5;
	private static int minPoolSize = 2;
	private static int initialPoolSize = 3;
	private static int maxMaxStatements = 10;

	static{		
		try {
			// set the driver of the dataSource's database
			ds.setDriverClass(driver);
			// set the driver of the database
			ds.setJdbcUrl(url);
			// set the user of the database
			ds.setUser(user);
			// set the password of the database
			ds.setPassword(password);
			// set the max connection of the database
			ds.setMaxPoolSize(maxPoolSize);
			// set the min connection of the database 
			ds.setMinPoolSize(minPoolSize);
			// set the initial connector of the database
			ds.setInitialPoolSize(initialPoolSize);
			// set the max statement cache of the database
			ds.setMaxStatements(maxMaxStatements);
			
		} catch (PropertyVetoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection(){		
		Connection conn = null;	
		// this code block is order to 
		while(conn == null){
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		return conn;
	}	
	
	// we had said the c0p3 will close the connection automatically
	// why do we still need to close the connection ?
	// because to close connection in the c0p3 means release the connection
	// but will not release the physical connection  
	// just return the connection to the pool of the connection 	
	
	// note:I think we need to take the initiative to recycle the recourse
	// such as ResultSet and Statement
	public static void free(ResultSet rs,Statement st,Connection conn){
		if(rs!=null)
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		if(st!=null)
			try {
				st.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		if(conn!=null)
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	public static void free(PreparedStatement ps,Connection conn){
		if(ps!=null)
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		if(conn!=null)
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	public static void free(ResultSet rs,PreparedStatement ps,Connection conn){
		if(rs!=null)
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		if(ps!=null)
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		if(conn!=null)
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
}
