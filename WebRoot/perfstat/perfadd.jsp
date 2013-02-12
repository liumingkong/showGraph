<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.weibo.store.C3P0Pool"%>
<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String tagserver =request.getParameter("tagserver");
		Connection conn = C3P0Pool.getConnection();
 		ResultSet rs = null;
		PreparedStatement ps = null;
		String graphname;
		String type;
		String tagname;
		String taglist;
		String tpsname;
		String meanname;
		String maxname;
		String minname;
		String stddevname;

		String sql = "select tagname from perftps where tagserver=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setObject(1,tagserver);
			rs = ps.executeQuery();
%>
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>perf4J信息</title>    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script language="javascript">
        function move(me)
        {
          	if(me.className == "" || me.className == "unchosen"){
          		
          		 me.className = "chosen";
          		
          	}else{
          		me.className = "unchosen";
          	}
        }

        function jimmy(){
			var j = document.getElementById("graphname");
			if(j.value=="")
			{
				alert("模版名称不能为空!");
				j.value="";
				j.focus();
				return false;
			}
			return true;
		}
    </script>

    <style type="text/css">
<!--
body { font-family: Arial, Helvetica, sans-serif; font-size:14px; color:#000000; background:#fff; text-align:center; }
.chosen{background-color:#000000 ;color:#FFFFFF;}
.unchosen{background-color:#FFFFFF ;color:#000000;}
* { margin:0; padding:0; }
a { color:#1E7ACE; text-decoration:none; }
a:hover { color:#000; text-decoration:underline; }
h3 { font-size:14px; font-weight:bold; }
pre, p { color:#1E7ACE; margin:4px; }
input, select, textarea { padding:1px; margin:2px; font-size:11px; }
.buttom { padding:1px 10px; font-size:12px; border:1px #1E7ACE solid; background:#D0F0FF; }
#formwrapper { width:1000px; margin:15px auto; padding:20px; text-align:left; border:1px #1E7ACE solid; }
fieldset { padding:10px; margin-top:5px; border:1px solid #1E7ACE; background:#fff; }
fieldset legend { color:#1E7ACE; font-weight:bold; padding:3px 20px 3px 20px; border:1px solid #1E7ACE; background:#fff; }
fieldset label { float:center; width:120px; text-align:right; padding:2px; margin:1px; }
fieldset div { clear:left; margin-bottom:2px; }
.enter { text-align:center; }
.clear { clear:both; }
-->
</style>

</head>
<body>
<div id="formwrapper">
  <h3 align="center">新增模板</h3>
  <br>
  <form action="func/result.jsp" method="post" name="apLogin" id="">
    <fieldset>
      <legend>基本信息</legend>
      <div>
        <label for="Name">压测标识</label>
        <input type="text" size="25" readonly maxlength="50" value="<%=tagserver %>"/>
        <label for="graphname">模版名称</label>
        <input type="text" name="graphname" id="graphname" size="25" maxlength="30" />
        <br/>
      </div>
    </fieldset>
	<br/>
    <fieldset>
     <legend>标识信息</legend>
     <table border="0px" frame="void" cellpadding="0px" cellspacing="0px">
        <% while(rs.next()){ 
			tagname = rs.getString("tagname");
			tpsname = tagname + "-"+ "TPS";
			meanname = tagname + "-"+ "Mean";
			maxname = tagname + "-"+ "Max";
			minname = tagname + "-"+ "Min";
			stddevname = tagname + "-"+ "StdDev";
		%>
		               
    <tr onmouseover="this.style.backgroundColor='yellow'" 
    onmouseout="this.style.background='white'">    
        <div> 
   		<td>
        <input type="checkbox" name="<%=tpsname%>" id="<%=tpsname%>" value="<%=tpsname%>" 
        style="border: 0px;display:none"/>
        <label for="<%=tpsname%>" onclick=move(this)>TPS</label> 
         
         <input type="checkbox" name="<%=meanname%>" id="<%=meanname%>" value="<%=meanname%>" 
        style="border: 0px;display:none"/>
        <label for="<%=meanname%>" onclick=move(this)>Mean</label>
        
         <input type="checkbox" name="<%=maxname%>" id="<%=maxname%>" value="<%=maxname%>" 
        style="border: 0px;display:none"/>
        <label for="<%=maxname%>" onclick=move(this)>Max</label>
        
         <input type="checkbox" name="<%=minname%>" id="<%=minname%>" value="<%=minname%>" 
        style="border: 0px;display:none"/>
        <label for="<%=minname%>" onclick=move(this)>Min</label>
        
         <input type="checkbox" name="<%=stddevname%>" id="<%=stddevname%>" value="<%=stddevname%>" 
        style="border: 0px;display:none"/>
        <label for="<%=stddevname%>" onclick=move(this)>Std</label>

        <label for="<%=tagname%>"><%=tagname%></label>
    </td>
        </div>
     </tr>  

        <% }%>               
           </table>
        <%
			} catch (SQLException e) {
				e.printStackTrace();
			}
			C3P0Pool.free(ps, conn);
		%>
    </fieldset>
    <br/>
          <div class="enter">
          <input type="hidden" name="tagserver" value="<%=tagserver %>">
        <input type="submit" class="buttom" value="提交" onClick="return jimmy();"/>
      </div>
  </form>
</div>
</body>
</html>