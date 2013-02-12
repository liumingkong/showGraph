package com.weibo.showData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.weibo.store.C3P0Pool;

public class PerfTemplateGet {

	public static ResultSet getPerfTemplate(){
		Connection conn = C3P0Pool.getConnection();
 		ResultSet rs = null;
		PreparedStatement ps = null;
		// get the data from database
		String sql = "select * from perftemplate";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(ps, conn);
		return rs;
	}
	
	public static void deleteRow(String id){
		Connection conn = C3P0Pool.getConnection();
		PreparedStatement ps = null;
		String sql = "delete from perftemplate where id = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setObject(1,id);
			ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(ps, conn);
	}
	
	public static ResultSet getPerfTagName(String tagserver){
		Connection conn = C3P0Pool.getConnection();
 		ResultSet rs = null;
		PreparedStatement ps = null;
		// get the data from database
		String sql = "select tagname from perftps where tagserver=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setObject(1,tagserver);
			rs = ps.executeQuery();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(ps, conn);
		return rs;
	}
	
	public static void insertPerfTagName(String graphname,String taglist){
		Connection conn = C3P0Pool.getConnection();
		PreparedStatement ps = null;
		String sql = "insert into perftemplate(graphname,taglist) value(?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setObject(1,graphname);
			ps.setObject(2,taglist);
			ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(ps, conn);
	}	
	public static void main(String args[]){
		
		//PerfTemplateGet.insertPerfTagName(graphname,type,taglist);
	}
}
