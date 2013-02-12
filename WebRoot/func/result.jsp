<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.weibo.showData.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Enumeration enume = request.getParameterNames();
String graphname = request.getParameter("graphname");
String tagserver = request.getParameter("tagserver");
String taglist="";
while(enume.hasMoreElements()){
	String name=(String)enume.nextElement();
	if("graphname".equalsIgnoreCase(name)){
		continue;
	}
	if("tagserver".equalsIgnoreCase(name)){
		continue;
	}
	taglist = taglist+","+name;
}
if("".equalsIgnoreCase(taglist)){
	//PerfTemplateGet.insertPerfTagName(graphname,taglist);	
}else{
	taglist = taglist.substring(1,taglist.length());
	//PerfTemplateGet.insertPerfTagName(graphname,taglist);
}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>正在提交模板</title>
</head>
<body>
<form name=loading> 
　 	<p align=center> <font color="#0066ff" size="2">正在提交模板，请稍等</font>
	<font color="#0066ff" size="2" face="Arial">...</font>
　　	<input type="hidden" id="fid" name="fid" value="<%=tagserver %>">
	<input type=text name=chart size=46 
	style="font-family:Arial; font-weight:bolder; color:#0066ff; background-color:#fef4d9; padding:0px; border-style:none;"> 
　 　	<input type=text name=percent size=47 
	style="color:#0066ff; text-align:center; border-width:medium; border-style:none;"> 
　　	<script>　 
		var bar=0　 ;
		var line="||"　;
		var amount="||";　 
		count();
	function count(){　 
		bar=bar+2　 ;
		amount =amount + line　 ;
		document.loading.chart.value=amount　 ;
		document.loading.percent.value=bar+"%"　 ;
		if (bar<99){
			setTimeout("count()",30);
		}else{
			window.location = "/perfstat/perfadd.jsp?tagserver="+document.getElementById("fid").value;
		}　 
	}
</script> 
<p align="center">　
压测标志：<%=tagserver %>：模版名称：<%=graphname %>
</p> 
</form>
</body>
</html>