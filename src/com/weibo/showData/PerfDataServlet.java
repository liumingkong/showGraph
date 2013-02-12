package com.weibo.showData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.weibo.store.C3P0Pool;

public class PerfDataServlet {
	
	private String tagserver;
	private String graphname;
	// 对于这张图graphname，tagname的数组
	private String tagName[];	
	private String taglist;
	// 结果的列数，等同于tagname的数目+1
	private int cacheResultColum;
	// 结果的行数，等同于时间线的数目 timelist.length()
	private int cacheResultRow;	
	// 列内容包括，时间线，tagname1的信息，tagname2的信息，tagname3的信息.....
	// 列数为 tagName + 1 = cacheResultColum,行数为时间线的数目cacheResultRow
	private String cacheResult[][];

	public PerfDataServlet(String tagserver,String graphname){
		this.tagserver = tagserver;
		this.graphname = graphname;
	}
	
	// 获取tagname的列表
	private void perfTagNameList(){
		Connection conn = C3P0Pool.getConnection();
 		ResultSet rs = null;
		PreparedStatement ps = null;
		String sql = "select taglist from perftemplate where graphname = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setObject(1,graphname);
			rs = ps.executeQuery();
			if(rs.next()){
				taglist = (String)rs.getObject("taglist");
				taglist = taglist.replace(".","_");
				tagName = taglist.split(",");			
			}		
			rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(ps, conn);
		cacheResultColum = tagName.length+1;
	}
	
	// 获取时间线,并缓存到cacheResult数组中的第一列
	private void perfTimeList(){
		Connection conn = C3P0Pool.getConnection();
 		ResultSet rs = null;
		PreparedStatement ps = null;
		String sql = "select data from perftimelist where tagserver = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setObject(1,tagserver);
			rs = ps.executeQuery();
			rs.last();
			cacheResultRow = rs.getRow();
			// 获取列数，即结果集的数目
			cacheResult = new String[cacheResultRow][cacheResultColum];
			rs.beforeFirst();
			int i = 0;
			while(rs.next()){
				cacheResult[i++][0] = rs.getString("data");
			}
			rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(ps, conn);
	}
	
	private void cacheResultPerfStat(){
		
		String sp[];
		Connection conn = C3P0Pool.getConnection();
 		ResultSet rs = null;
		PreparedStatement ps = null;
		String spStat[] = null;
		for(int i=0;i<tagName.length;i++){
			sp = tagName[i].split("-");
			String tableName = "perf"+sp[1].toLowerCase();
			String tagname = sp[0];
			String sql = "select data from "+tableName+" where tagserver = ? and tagname =?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setObject(1,tagserver);
				ps.setObject(2,tagname);
				rs = ps.executeQuery();
				if(rs.next()){
					spStat = rs.getString("data").split(",");
					for(int j = 0 ;j<cacheResultRow;j++){
						cacheResult[j][i+1] = spStat[j];
					}
				}else{
					for(int j = 0 ;j<cacheResultRow;j++){
						cacheResult[j][i+1] = "0.0";
					}
				}				
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		C3P0Pool.free(ps, conn);		
	}
	
	private String culResultStr(){
		StringBuilder result = new StringBuilder(50000).append("[");
		for(int i =0;i<cacheResultRow;i++){
			result.append("{timestamp:").append("\"").append(cacheResult[i][0]).append("\"");
			for(int j =0;j<tagName.length;j++){
				result.append(",").append("\"").append(tagName[j]).append("\"").append(":").append(cacheResult[i][j+1]);
			}
			result.append("},");			
		}
		String str = result.toString().substring(0,result.length()-1)+"]";
		return str;		
	}
		
	public String getResult(){		
		this.perfTagNameList();
		this.perfTimeList();
		this.cacheResultPerfStat();
		String result = this.culResultStr();
		return result;
	}
	/**
	 * @return the taglist
	 */
	public String getTaglist() {
		return "\""+taglist+"\"";
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String tagserver = "05241106-180.149.138.89";
		String graphname = "presence.update.Mean";
		PerfDataServlet perfDataServlet = new PerfDataServlet(tagserver, graphname);
		System.out.println(perfDataServlet.getResult());		
	}

}
