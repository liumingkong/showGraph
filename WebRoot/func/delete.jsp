<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.weibo.showData.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String id = request.getParameter("id");
	PerfTemplateGet.deleteRow(id);
%>