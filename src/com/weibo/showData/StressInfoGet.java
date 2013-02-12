package com.weibo.showData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.weibo.store.C3P0Pool;

public class StressInfoGet {

	public static ResultSet getStressInfo(){
		Connection conn = C3P0Pool.getConnection();
 		ResultSet rs = null;
		PreparedStatement ps = null;
		// get the data from database
		String sql = "select * from stressinfo";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(ps, conn);
		return rs;
	}
	
	public static String getTopPidList(String tagserver){
		Connection conn = C3P0Pool.getConnection();
 		ResultSet rs = null;
 		String data = null;
		PreparedStatement ps = null;
		// get the data from database
		String sql = "select toppidlist from stressinfo where tagserver = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setObject(1, tagserver);
			rs = ps.executeQuery();
			// get the result from database 
			while(rs.next()){
				data = (String) rs.getObject("toppidlist");		
			}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(ps, conn);
		return data;
	}
}
