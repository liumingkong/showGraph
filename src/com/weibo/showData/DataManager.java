package com.weibo.showData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.weibo.store.C3P0Pool;

public class DataManager {

	private String tagserver;
	private static String tableName[]={"cachesize","cpupid","iostat","jidstatistics",
		"jstat","mempid","perfmax","perfmin","perfmean","perfstddev","perftimelist",
		"perftps","stressinfo","tcpstat"};
	
	public DataManager(String tagserver){
		this.tagserver = tagserver;
	}
	
	public void deleteData(){
		for(int i=0;i<tableName.length;i++){
			this.deleteRecord(tableName[i]);
		}
	}
	
	
	public void deleteRecord(String tableName){
		
		Connection conn = C3P0Pool.getConnection();		
		PreparedStatement ps = null;
		String sql = "delete from "+tableName+" where tagserver = ?";
		try {
				ps = conn.prepareStatement(sql);
				ps.setObject(1,tagserver);
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(ps, conn);
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		String tagserver = "05241106-180.149.138.90" ;
		//String tagserver = "05232200-123.126.54.33" ;
		DataManager dm = new DataManager(tagserver);
		dm.deleteData();
	}

}
