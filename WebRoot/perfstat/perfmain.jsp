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
		String perftag = "/perfstat/perftag.jsp?tagserver=";
		String perfurl;
		String graphname;
		String taglist;		
		// get the data from database
		String sql = "select * from perftemplate";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>perf4J信息：<%=tagserver %></title>    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	

	<script language="javascript">	    
		function addTemplate(tagserver){
			window.open("perfstat/perfadd.jsp?tagserver="+tagserver,"Add New Template",null);
		}
	
		function removeRow(trName){ 
   			var index=document.getElementById(trName).rowIndex; 
   			var xmlhttp = new XMLHttpRequest();
   			// t1指的是table的名字
   			if(confirm("Delete it?")){
	   			document.getElementById("t1").deleteRow(index); 	   			
	   			xmlhttp.open("POST","func/delete.jsp?id="+trName,true);
	   			xmlhttp.send();
				return true;				
   			}else{
   				return false;
   			} 
		}
	
        function addHtml(r)
        {        	
   			var tab = document.getElementById("tb") ;
   			var colsNum = tab.rows.item(0).cells.length ;
            var row = document.getElementById("tb");          
        	var rownum ;
            var num = document.getElementById("tb").rows.length;
            rownum = num - 1;
            row.insertRow(rownum);
            var i=0;
            for(;i<colsNum-1;i++)
            {
                row.rows[rownum].insertCell(i);
                row.rows[rownum].cells[i].innerHTML="<iframe src='"+r+"' width=100% height='400px' frameborder=0></iframe>";
            }
            	row.rows[rownum].insertCell(i);
            	row.rows[rownum].cells[i].innerHTML="<br><br><input type='button' value='-' onclick='deleterow("+rownum+")'/>" +
            	"<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>";
       	}
        
        function deleterow(rnum)
        {
            var num = document.getElementById("tb").rows.length;
            if(rnum != num)
            {
                var aa = num - rnum ;
                if(aa == 1)
                {
                //防止删除最后一行
                    rnum = rnum - 1;                    
                }
                var tbody = document.getElementById("tb");
                tbody.deleteRow(rnum);
            }
        }
        
		//--初始化变量--
		// from alixixi.com
		var rT=true;//允许图像过渡
		var bT=true;//允许图像淡入淡出
		var tw=450;//提示框宽度
		var endaction=false;//结束动画
		var ns4 = document.layers;
		var ns6 = document.getElementById && !document.all;
		var ie4 = document.all;
		offsetX = 0;
		offsetY = 20;
		var toolTipSTYLE="";
		function initToolTips()
		{
		  if(ns4||ns6||ie4)
		  {
		    if(ns4) toolTipSTYLE = document.toolTipLayer;
		    else if(ns6) toolTipSTYLE = document.getElementById("toolTipLayer").style;
		    else if(ie4) toolTipSTYLE = document.all.toolTipLayer.style;
		    if(ns4) document.captureEvents(Event.MOUSEMOVE);
		    else
		    {
		      toolTipSTYLE.visibility = "visible";
		      toolTipSTYLE.display = "none";
		    }
		    document.onmousemove = moveToMouseLoc;
		  }
		}
		function toolTip(msg, fg, bg)
		{
		  if(toolTip.arguments.length < 1) // hide
		  {
		    if(ns4) 
		    {
		    toolTipSTYLE.visibility = "hidden";
		    }
		    else 
		    {
		      //--图象过渡，淡出处理--
		      if (!endaction) {toolTipSTYLE.display = "none";}
		      if (rT) document.all("msg1").filters[1].Apply();
		      if (bT) document.all("msg1").filters[2].Apply();
		      document.all("msg1").filters[0].opacity=0;
		      if (rT) document.all("msg1").filters[1].Play();
		      if (bT) document.all("msg1").filters[2].Play();
		      if (rT){ 
		      if (document.all("msg1").filters[1].status==1 || document.all("msg1").filters[1].status==0){  
		      toolTipSTYLE.display = "none";}
		      }
		      if (bT){
		      if (document.all("msg1").filters[2].status==1 || document.all("msg1").filters[2].status==0){  
		      toolTipSTYLE.display = "none";}
		      }
		      if (!rT && !bT) toolTipSTYLE.display = "none";
		      //----------------------
		    }
		  }
		  else // show
		  {		
			
			msg = msg.replace(/,/g,"<br/>"); 
			
			
			
		    if(!fg) fg = "#FFFFFF";
		    if(!bg) bg = "#000000";
		    var content =
		    '<table id="msg1" name="msg1" border="0" cellspacing="0" cellpadding="1" bgcolor="' + fg + '" class="trans_msg"><td>' +
		    '<table border="0" cellspacing="0" cellpadding="3" bgcolor="' + bg + 
		    '"><td width=' + tw + '><font face="Arial" color="' + fg +
		    '" size="3">' + msg +
		    '</font></td></table></td></table>';
		    if(ns4)
		    {
		      toolTipSTYLE.document.write(content);
		      toolTipSTYLE.document.close();
		      toolTipSTYLE.visibility = "visible";
		    }
		    if(ns6)
		    {
		      document.getElementById("toolTipLayer").innerHTML = content;
		      toolTipSTYLE.display='block'
		    }
		    if(ie4)
		    {
		      document.all("toolTipLayer").innerHTML=content;
		      toolTipSTYLE.display='block'
		      //--图象过渡，淡入处理--
		      var cssopaction=document.all("msg1").filters[0].opacity
		      document.all("msg1").filters[0].opacity=0;
		      if (rT) document.all("msg1").filters[1].Apply();
		      if (bT) document.all("msg1").filters[2].Apply();
		      document.all("msg1").filters[0].opacity=cssopaction;
		      if (rT) document.all("msg1").filters[1].Play();
		      if (bT) document.all("msg1").filters[2].Play();
		      //----------------------
		    }
		  }
		}
		function moveToMouseLoc(e)
		{
		  if(ns4||ns6)
		  {
		    x = e.pageX;
		    y = e.pageY;
		  }
		  else
		  {
		    x = event.x + document.body.scrollLeft;
		    y = event.y + document.body.scrollTop;
		  }
		  toolTipSTYLE.left = x + offsetX;
		  toolTipSTYLE.top = y + offsetY;
		  return true;
		}
    </script>
    <style  type="text/css">
<!--
.trans_msg{filter:alpha(opacity=1000,enabled=1) revealTrans(duration=.2,transition=1) blendtrans(duration=.2);}
.buttom { padding:1px 10px; font-size:12px; border:1px #1E7ACE solid; background:#D0F0FF; }

-->
</style>
  </head>
  
  <body>
<div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
<script>initToolTips()</script>

<form id="form1" name="form1" method="post" action="">
<table width="100%" height="100%" border="0" align="center" id="test" cellpadding="0px" cellspacing="0px">
	<tr>
		<td align="left" valign="top">
		<table border = "1" frame="void"  rules="rows" width=100% id="t1">
			<tr>
				<td align="left" width="12%">
				<td align="left" width="12%">
				<td align="left" rowspan="1"><%=tagserver%>
				<button class="buttom" type="button" name="perftagsubmit"
				style="width:120px;height:20px;border-style:groove;border-width:1px;
				font-size:8pt;word-spacing=5em;"
				onclick=addTemplate("<%=tagserver%>")>Add</button></td>
			</tr>
		<% while(rs.next()){ 
			graphname = rs.getString("graphname");
			taglist = rs.getString("taglist");
		%>
		<tr onmouseover="this.style.backgroundColor='#6699ff'" onmouseout="this.style.backgroundColor='#ffffff'" 
		id="<%=rs.getInt("id") %>">
				
		<td align="left" width="12%">
		<% 
			perfurl = perftag + tagserver + "&graphname="+graphname;
		%>
		<button class="buttom" type="button" name="perftagsubmit"
		style="width:120px;height:20px;border-style:groove;border-width:1px;
		font-size:8pt;word-spacing=5em;" 
		onclick=addHtml("<%=perfurl%>") >show</button>		
		</td>
		
		<td align="left" width="12%">
		<button class="buttom" type="button" name="perftagsubmit"
		style="width:120px;height:20px;border-style:groove;border-width:1px;
		font-size:8pt;word-spacing=5em;" 
		onclick=removeRow("<%=rs.getInt("id") %>") >delete</button>	
		</td>
		<td align="left" onMouseOver="toolTip('<%=taglist %>')" onMouseOut="toolTip()"><%=graphname %></td>	
		</tr>
		<% }%>		
		</table>
			<%} catch (SQLException e) {
				e.printStackTrace();
			}
			C3P0Pool.free(ps, conn);
		%>
      </td>
      <td>
      	<input type='button' readonly="readonly" value="-"/>
      </td>
    </tr>
	<tbody id="tb">
    <tr>
    <td width =100% height=900px></td>
    <td></td>
    </tr>
    </tbody>
</table>
</form>    
  </body>
</html>
