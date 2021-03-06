<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.weibo.showData.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String tagserver =request.getParameter("tagserver");
	String str = new DataServlet(tagserver,"mempid").DataGet();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title><%=tagserver%></title>
        <link rel="stylesheet" href="style.css" type="text/css">
        <script src="../amcharts/amcharts.js" type="text/javascript"></script>        
        <script type="text/javascript">
			var chart;
            var chartData = <%=str%>;
            var chartCursor;

            AmCharts.ready(function () {                

                // SERIAL CHART
                chart = new AmCharts.AmSerialChart();
                chart.dataProvider = chartData;
                chart.pathToImages = "../amcharts/images/";
                chart.categoryField = "timestamp";
                chart.startDuration = 0.5;
                chart.zoomOutButton = {
                    backgroundColor: '#000000',
                    backgroundAlpha: 0.15
                };
                chart.balloon.color = "#000000";
				chart.addLabel("10%","20%","TopLoad:"+"<%=tagserver%>","left",10,"#000000","0",true);

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

                // GRAPH
                var graph = new AmCharts.AmGraph();
                graph.title = "loadAverage1";
                graph.valueField = "loadAverage1";
                graph.bullet = "round";
                graph.bulletBorderColor = "#FFFFFF";
                graph.bulletBorderThickness = 1;
                graph.lineThickness = 1;
                graph.lineColor = randomColor();
                graph.negativeLineColor = "#0352b5";
                graph.hideBulletsCount = 50; // this makes the chart to hide bullets when there are more than 50 series in selection
                chart.addGraph(graph);



				// GRAPH

                var graph1 = new AmCharts.AmGraph();
                graph1.title = "loadAverage5";
                graph1.valueField = "loadAverage5";
                graph1.bullet = "round";
                graph1.bulletBorderColor = "#FFFFF0";
                graph1.bulletBorderThickness = 1;
                graph1.lineThickness = 1;
                graph1.lineColor = randomColor();
                graph1.negativeLineColor = "#ff0000";
                graph1.hideBulletsCount = 3; // this makes the chart to hide bullets when there are more than 50 series in selection
                chart.addGraph(graph1);

                // GRAPH
                var graph2 = new AmCharts.AmGraph();
                graph2.title = "loadAverage15";
                graph2.valueField = "loadAverage15";
                graph2.bullet = "round";
                graph2.bulletBorderColor = "#FFFFF0";
                graph2.bulletBorderThickness = 1;
                graph2.lineThickness = 1;
                graph2.lineColor = randomColor();
                graph2.negativeLineColor = "#ff0000";
                graph2.hideBulletsCount = 50; // this makes the chart to hide bullets when there are more than 50 series in selection
                chart.addGraph(graph2);


                // CURSOR
                chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorPosition = "mouse";
                chart.addChartCursor(chartCursor);

                // SCROLLBAR
                var chartScrollbar = new AmCharts.ChartScrollbar();
                chartScrollbar.graph = graph;
                chartScrollbar.scrollbarHeight = 20;
                chartScrollbar.color = "#FFFFFF";
                chartScrollbar.autoGridCount = true;
                chart.addChartScrollbar(chartScrollbar);
                
                // LEGEND
                var legend = new AmCharts.AmLegend();
                legend.markerType = "square";
                legend.fontsize = 1;
                legend.verticalGap = 5;
                legend.markerSize = 8;
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
		</script>
    </head>
    
    <body>    	
    		<table width=100%>
    		<tr>
			<td style="width:98%; height:350px;"><div id="chartdiv" style="width:100%; height: 350px;"></div></td>
			<td valign="top"><div>
			<small>
			<a href="/bigview/topload.jsp?tagserver=<%=tagserver%>" target="_blank">more</a>
			</small>
			</div> 
			</td>
			</tr>
			</table>
    </body>

</html>