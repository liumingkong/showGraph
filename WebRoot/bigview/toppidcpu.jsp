<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.weibo.showData.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String limitValue=request.getParameter("user");
	String tagserver =request.getParameter("tagserver");
	String str = new DataServlet(tagserver,"cpupid").DataGet();		
	String[] topstr = StressInfoGet.getTopPidList(tagserver).split(";");		
	String pidstr = "\""+topstr[0]+"\"";
	String cpustr = "\""+topstr[1]+"\"";		
	if(limitValue == null){
		limitValue = "30";
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>TopPidCpu:<%=tagserver%></title>
        <link rel="stylesheet" href="style.css" type="text/css">
        <script src="../amcharts/amcharts.js" type="text/javascript"></script>        
        <script type="text/javascript">
		var chart;
		var chartData = <%=str%>;
		var chartCursor;
		
		// pid info
		var pidchar = <%=pidstr%>;
		var pidArray = new Array;
        pidArray = pidchar.split(":");
        
        // cpu infor
		var cpuchar = <%=cpustr%>;
		var cpuArray = new Array;
        cpuArray = cpuchar.split(":");
		AmCharts.ready(function () {
                
                // SERIAL CHART
                chart = new AmCharts.AmSerialChart();
                // 图片的数据
                chart.dataProvider = chartData;
                // 缩略图的拖动柄的图片
                chart.pathToImages = "../amcharts/images/";
                // 横轴的数据来源
                chart.categoryField = "timestamp";
                // 动画的持续时间，单位：秒
                chart.startDuration = 0.5;
                // 动画的效果：默认:"elastic"，">","<","bounce"
                chart.startEffect = ">";
				chart.addLabel("10%","20%","TopPidCpu:"+"<%=tagserver%>","left",15,"#000000","0",true);
				// 信息的长镜头  
                chart.zoomOutButton = {
                    backgroundColor: '#000000',
                    backgroundAlpha: 0.15
                };
                // 背景图像的效果，会呈现出3D效果
                //chart.angle = 60;
                //chart.depth3D = 60;
                
                // 图表的气球颜色
                chart.balloon.color = "#000000";
				// 图表的框体颜色,默认为0，不显示
				chart.borderAlpha = 0;
				// 图标的版本
				chart.version = "1.0"; 
				
                // listen for "dataUpdated" event (fired when chart is rendered) and call zoomChart method when it happens
                chart.addListener("dataUpdated", zoomChart);

                // AXES
                // category
                var categoryAxis = chart.categoryAxis;
                categoryAxis.dashLength = 1;
                categoryAxis.gridAlpha = 0.15;
                categoryAxis.axisColor = "#DADADA";
				
                // value                
                var valueAxis = new AmCharts.ValueAxis();
                valueAxis.axisAlpha = 0.2;
                valueAxis.dashLength = 1;
                chart.addValueAxis(valueAxis);
				
				
				var limit = <%=limitValue%>;
                // GRAPH
                // 描述，生成图像数组
				var graph = new Array();
				// 根据pid的数目生成图像
                for(j=0;j<pidArray.length;j++){
                	// 如果小于指定阈值就不生成图像
                	if(cpuArray[j]<= limit){
                		continue;
                	}                	               	
                	graph[j] = new AmCharts.AmGraph();
                	// 图像的标题
               	 	graph[j].title = pidArray[j];
               	 	// 图像的值域
                	graph[j].valueField = pidArray[j];
                	// 图像气泡的类型 "none","round","buddle"
                	graph[j].bullet = "round";
                	// 图像的气泡的边界颜色
                	graph[j].bulletBorderColor = "#FFFFFF";
                	// 图像的气泡的边界厚度
                	graph[j].bulletBorderThickness = 2;
                	
                	// 图像的线宽度
                	graph[j].lineThickness = 1;
                	graph[j].lineColor = randomColor();
                	graph[j].negativeLineColor = "#0352b5";
                	graph[j].hideBulletsCount = 50;
 					chart.addGraph(graph[j]);   
                	
                	// SCROLLBAR
                	var chartScrollbar = new AmCharts.ChartScrollbar();
               		chartScrollbar.graph = graph[j];
               		chartScrollbar.scrollbarHeight = 40;
                	chartScrollbar.color = "#FFFFFF";
                	chartScrollbar.autoGridCount = true;
                	chart.addChartScrollbar(chartScrollbar);          	
                }
                
                
                // CURSOR
                chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorPosition = "mouse";
                chart.addChartCursor(chartCursor);

                // LEGEND
                var legend = new AmCharts.AmLegend();
                legend.markerType = "square";
                legend.fontsize = 15;
                legend.verticalGap = 5;
                legend.markerSize = 15;
                chart.addLegend(legend);
                
                // WRITE
                chart.write("chartdiv");
            });

            // this method is called when chart is first inited as we listen for "dataUpdated" event
            function zoomChart() {
                // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
                chart.zoomToIndexes(0, chartData.length) 
            } 
            
            function randomColor(){
            	var r = Math.floor(Math.random() * 200).toString(16);
				var g = Math.floor(Math.random() * 170).toString(16);
				var b = Math.floor(Math.random() * 200).toString(16);
				r = r.length == 1 ? "0" + r : r;
				g = g.length == 1 ? "0" + g : g;
				b = b.length == 1 ? "0" + b : b;
				return "#" + r + g + b;
            }
            // 控制只允许输入数字
            function onlyNum() 
			{ 
				if(!(event.keyCode==46)&&!(event.keyCode==8)&&!(event.keyCode==37)&&!(event.keyCode==39)) 
				if(!((event.keyCode>=48&&event.keyCode<=57)||(event.keyCode>=96&&event.keyCode<=105))) 
				event.returnValue=false; 
			} 
		</script>
    </head>    
    <body>    	
    		<table width=100%>    		
			<tr>
			<td align="center">
			<form name="input" action="toppidcpu.jsp" method="get">
			Server Infomation：<%=tagserver%>--TopPidCpu
			<input type="hidden" name="tagserver" value=<%=tagserver%> />
			Threshold:
			<input type="text" border="1" size="1" name="user" value=<%=limitValue%> onkeydown="onlyNum();"/>
			<input type="submit" value="submit"/>
			</form> 
			</td>
			</tr>
    		</table>
			<div id="chartdiv" style="width:100%; height:700px;"></div>
    </body>

</html>