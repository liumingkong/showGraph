package com.weibo.showData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.weibo.store.C3P0Pool;

public class DataServlet {
	
	private String tagserver;
	private String type;
	
	public DataServlet(String tagserver,String type){
		this.tagserver = tagserver;
		this.type = type ;
	}
	// 因为数据的存储格式是完全相同的，所以我们可以采用标识统一方法
	// 包含的功能包括：jstat，cpupid，mempid（topload，topmem），iostat，tcpstat
	@SuppressWarnings("unchecked")
	public String DataGet(){
		Connection conn = C3P0Pool.getConnection();
		@SuppressWarnings("rawtypes")
		List list = new ArrayList();
 		ResultSet rs = null;
		PreparedStatement ps = null;
		// get the data from database
		String sql = "select data from "+type+" where tagserver = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setObject(1,tagserver);
			rs = ps.executeQuery();
			// get the result from database 
			
			while(rs.next()){				
				list.add(rs.getObject("data"));				
			}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(ps, conn);
		@SuppressWarnings("rawtypes")
		Iterator it = list.iterator();
		// 这个长度是平均长度预估出来的
		StringBuilder str = new StringBuilder(60000);
		str.append("[").append(it.next());
		while(it.hasNext()){
			str.append(",").append(it.next());
		}
		str.append("]");
		return str.toString();
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String tagserver = "05091423-180.149.138.89";
		DataServlet dataServlet = new DataServlet(tagserver,"tcpstat");
		System.out.println(dataServlet.DataGet());
	}
}
