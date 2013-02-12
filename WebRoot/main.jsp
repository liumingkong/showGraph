<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="com.weibo.store.C3P0Pool"%>
<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		Connection conn = C3P0Pool.getConnection();
 		ResultSet rs = null;
		PreparedStatement ps = null;
		boolean bjstat=false;
		boolean btoppidcpu=false;
		boolean btoppidmem=false;
		boolean btopload=false;
		boolean biostat=false;
		boolean btcpstat=false;
		boolean bperfstat=false;
		boolean bcachesize=false;
		
		String flagshow = "disabled";
		String jstat = "/stat/jstat.jsp?tagserver=";
		String toppidcpu = "/toppid/toppidcpu.jsp?tagserver=";
		String toppidmem = "/toppid/toppidmem.jsp?tagserver=";
		String topload = "/toppid/topload.jsp?tagserver=";
		String iostat = "/stat/iostat.jsp?tagserver=";
		String tcpstat = "/stat/tcpstat.jsp?tagserver=";
		String perfstat = "/perfstat/perfmain.jsp?tagserver=";
		String cachesize = "/debug/cachesize.jsp?tagserver=";
		String tips;
		
		String jstaturl;
		String toppidcpuurl;
		String toppidmemurl;
		String toploadurl;
		String iostaturl;
		String tcpstaturl;
		String perfstaturl;
		String debugstaturl;
		String jidcacheurl;
		String stringcacheurl;
		String cachesizeurl;
		
		// get the data from database
		String sql = "select * from stressinfo";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>压测信息beta.v0.4</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <style  type="text/css">
<!--
.trans_msg{filter:alpha(opacity=1000,enabled=1) revealTrans(duration=.2,transition=1) blendtrans(duration=.2);}
.buttom { padding:1px 10px; font-size:12px; border:1px #1E7ACE solid; background:#D0F0FF; }
-->
</style>
	 <link rel="stylesheet" type="text/css" href="style.css" />
	    <script language="javascript">	    
	    
        function addHtml(r)
        {
        	
        	// 根据对象名获取js对象
   			var tab = document.getElementById("tb") ;
        	// 获取列数
   			var colsNum = tab.rows.item(0).cells.length ;
        	// 获取行对象
            var row = document.getElementById("tb");
            
        	var rownum ;
			//获得当前得行数
            var num = document.getElementById("tb").rows.length;
            //使添加得新行在表格底部
            rownum = num - 1;
            row.insertRow(rownum);
            var i=0;
            for(;i<colsNum-1;i++)
            {
                //最大值
                row.rows[rownum].insertCell(i);
                row.rows[rownum].cells[i].innerHTML="<iframe src='"+r+"' width=100% height='400px' frameborder=0></iframe>";
                }
            	row.rows[rownum].insertCell(i);
            	row.rows[rownum].cells[i].innerHTML="<br><br><input type='button' value='-' onclick='deleterow("+rownum+")'/>" +
            	"<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>";
       }
        
        function openHtml(r){        	
        	window.open(r,null,null);
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
  </head>
  
  <body>
  <div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
<script>initToolTips()</script>
<form id="form1" name="form1" method="post" action="">
<div class="buttons">
<table width="100%" height="100%" border="0" align="center" id="test" cellpadding="0px" cellspacing="0px">


    <tr>
      <td align="left" valign="top">

	<table border = "1" frame="void"  rules="rows" width=100%>
		<tr>
		<th>tagserver</th>
		<th>jstat</th>
		<th>top5Cpu</th>
		<th>topMem</th>
		<th>topLoad</th>
		<th>iostat</th>
		<th>tcpstat</th>
		<th>perfstat</th>
		<th>cachesize</th>
		</tr>
		<%	String tag;
			String server;
			String tagserver;
		%>
		<% while(rs.next()){ %>
		<tr onmouseover="this.style.backgroundColor='#6699ff'" onmouseout="this.style.backgroundColor='#ffffff'">
		<% tagserver = rs.getString("tagserver");
		   tips = rs.getString("tips");
		   bjstat=rs.getBoolean("jstat");
		   btoppidcpu=rs.getBoolean("toppidcpu");
		   btoppidmem=rs.getBoolean("toppidmem");
		   btopload=rs.getBoolean("topload");
		   biostat=rs.getBoolean("iostat");
		   btcpstat=rs.getBoolean("tcpstat");
		   bperfstat=rs.getBoolean("perfstat");
		   bcachesize=rs.getBoolean("cachesize");
		%>
		
		<td align="left" onMouseOver="toolTip('<%=tips %>')" onMouseOut="toolTip()">
		<a href="<%=rs.getString("info")%>"><%=tagserver%></a></td>		
		<td align="center">
		<% jstaturl = jstat + tagserver; 
		flagshow = "disabled";
		if(bjstat){
			flagshow = " ";
	   	}
		%>
		<button class="positive" type="button" name="jstatsubmit" <%=flagshow%>  
		style="width:100px;height:20px;border-style:groove;border-width:1px;
		font-size:8pt;word-spacing=5em;"
		 onclick=addHtml("<%=jstaturl%>")>
		<% if(bjstat){%>
		<img src="/images/apply2.png" alt=""/>
		<%} %>
		</button>
		</td>
		<td align="center">
		<% toppidcpuurl = toppidcpu + tagserver;
		flagshow = "disabled";
		if(btoppidcpu){
			flagshow = " ";
   		}
		%>
		<button class="positive" type="button" name="toppidcpusubmit" <%=flagshow%> 
		style="width:100px;height:20px;border-style:groove;border-width:1px;
		font-size:8pt;word-spacing=5em;" 
		onclick=addHtml("<%=toppidcpuurl%>") >
		<% if(btoppidcpu){%>
		<img src="/images/apply2.png" alt=""/>
		<%} %>
		</button>
		</td>
		<td align="center">
		<% toppidmemurl = toppidmem + tagserver; 
		flagshow = "disabled";
		if(btoppidmem){
			flagshow = " ";
		}
		%>
		<button class="positive" type="button" name="toppidmemsubmit" <%=flagshow%> 
		style="width:100px;height:20px;border-style:groove;border-width:1px;
		font-size:8pt;word-spacing=5em;" 
		onclick=addHtml("<%=toppidmemurl%>") >
		<% if(btoppidmem){%>
		<img src="/images/apply2.png" alt=""/>
		<%} %>
		</td>
		<td align="center">
		<% toploadurl = topload + tagserver; 
		flagshow = "disabled";
		if(btopload){
			flagshow = " ";
		}
		%>
		<button class="positive" type="button" name="toploadsubmit" <%=flagshow%> 
		style="width:100px;height:20px;border-style:groove;border-width:1px;
		font-size:8pt;word-spacing=5em;" 
		onclick=addHtml("<%=toploadurl%>") >
		<% if(btopload){%>
		<img src="/images/apply2.png" alt=""/>
		<%} %>		
		</button>
		</td>
		<td align="center">
		<% iostaturl = iostat + tagserver; 
		flagshow = "disabled";
		if(biostat){
			flagshow = " ";
		}
		%>		
		<button class="positive" type="button" name="toppidmemsubmit" <%=flagshow%> 
		style="width:100px;height:20px;border-style:groove;border-width:1px;
		font-size:8pt;word-spacing=5em;"
		onclick=addHtml("<%=iostaturl%>") >
		<% if(biostat){%>
		<img src="/images/apply2.png" alt=""/>
		<%} %>
		</button>
		</td>
		<td align="center">
		<% tcpstaturl = tcpstat + tagserver; 
		flagshow = "disabled";
		if(btcpstat){
			flagshow = " ";
		}
		%>
		<button class="positive" type="button" name="toppidmemsubmit" <%=flagshow%>  
		style="width:100px;height:20px;border-style:groove;border-width:1px;
		font-size:8pt;word-spacing=5em;" 
		onclick=addHtml("<%=tcpstaturl%>") >
		<% if(btcpstat){%>
		<img src="/images/apply2.png" alt=""/>
		<%} %>
		</button>
		</td>		
		<td align="center">
		<% perfstaturl = perfstat + tagserver; 
		flagshow = "disabled";
		if(bperfstat){
			flagshow = " ";
		}
		%>
		<button class="positive" type="button" name="perfstatsubmit" <%=flagshow%>  
		style="width:100px;height:20px;border-style:groove;border-width:1px;
		font-size:8pt;word-spacing=5em;" 
		onclick=openHtml("<%=perfstaturl%>") >		
		<% if(bperfstat){%>
		<img src="/images/apply2.png" alt=""/>
		<%} %>
		</button>
		</td>

		
		<td align="center">
		<% cachesizeurl = cachesize + tagserver; 
		flagshow = "disabled";
		if(bcachesize){
			flagshow = " ";
		}
		%>
		<button class="positive" type="button" name="perfstatsubmit" <%=flagshow%>  
		style="width:100px;height:20px;border-style:groove;border-width:1px;
		font-size:8pt;word-spacing=5em;" 
		onclick=addHtml("<%=cachesizeurl%>") >		
		<% if(bcachesize){%>
		<img src="/images/apply2.png" alt=""/>
		<%} %>
		</button></td>
		<% }%>		
		</table>
			<%} catch (SQLException e) {
				e.printStackTrace();
			}
		C3P0Pool.free(rs,ps, conn);
		%>

      </td>
      <td>
      <input type='button' class="positive" readonly="readonly" value="-"/>
      </td>
    </tr>
	<tbody id="tb">
    <tr>
    <td width =100% height=900px></td>
    <td></td>
    </tr>
    </tbody>
</table>
</div>
</form>    
</div>
  </body>
</html>
