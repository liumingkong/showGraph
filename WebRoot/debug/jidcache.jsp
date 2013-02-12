<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.weibo.showData.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String tagserver =request.getParameter("tagserver");
	String str = new DataServlet(tagserver,"iostat").DataGet();	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>amCharts examples</title>
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
                chart.startDuration = 0.2;
                chart.zoomOutButton = {
                    backgroundColor: '#000000',
                    backgroundAlpha: 0.15
                };
                chart.balloon.color = "#000000";
				chart.addLabel("10%","20%","IoStat:"+"<%=tagserver%>","left",10,"#000000","0",true);
				
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
                graph.title = "%user";
                graph.valueField = "%user";
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
                graph1.title = "%nice";
                graph1.valueField = "%nice";
                graph1.bullet = "round";
                graph1.bulletBorderColor = "#FFFFF0";
                graph1.bulletBorderThickness = 1;
                graph1.lineThickness = 1;
                graph1.lineColor = randomColor();
                graph1.negativeLineColor = "#ff0000";
                graph1.hidden = true;
                graph1.hideBulletsCount = 3; // this makes the chart to hide bullets when there are more than 50 series in selection
                chart.addGraph(graph1);
                
                // GRAPH
                var graph2 = new AmCharts.AmGraph();
                graph2.title = "%sys";
                graph2.valueField = "%sys";
                graph2.bullet = "round";
                graph2.bulletBorderColor = "#FFFFF0";
                graph2.bulletBorderThickness = 1;
                graph2.lineThickness = 1;
                graph2.lineColor = randomColor();
                graph2.negativeLineColor = "#ff0000";
                graph2.hideBulletsCount = 50; // this makes the chart to hide bullets when there are more than 50 series in selection
                chart.addGraph(graph2);
                
                // GRAPH
                var graph3 = new AmCharts.AmGraph();
                graph3.title = "%iowait";
                graph3.valueField = "%iowait";
                graph3.bullet = "round";
                graph3.bulletBorderColor = "#FFFFF0";
                graph3.bulletBorderThickness = 1;
                graph3.lineThickness = 1;
                graph3.lineColor = randomColor();
                graph3.negativeLineColor = "#ff0000";
                graph3.hideBulletsCount = 50; // this makes the chart to hide bullets when there are more than 50 series in selection
                chart.addGraph(graph3);
 
                /*
                var graph4 = new AmCharts.AmGraph();
                graph4.title = "%steal";
                graph4.valueField = "%steal";
                graph4.bullet = "round";
                graph4.bulletBorderColor = "#FFFFF0";
                graph4.bulletBorderThickness = 1;
                graph4.lineThickness = 1;
                graph4.lineColor = randomColor();
                graph4.hidden = true;
                graph4.negativeLineColor = "#ff0000";
                graph4.hideBulletsCount = 50; // this makes the chart to hide bullets when there are more than 50 series in selection
                chart.addGraph(graph4);
                */
                
                var graph5 = new AmCharts.AmGraph();
                graph5.title = "%idle";
                graph5.valueField = "%idle";
                graph5.bullet = "round";
                graph5.bulletBorderColor = "#FFFFF0";
                graph5.bulletBorderThickness = 1;
                graph5.lineThickness = 1;
                graph5.lineColor = randomColor();
                //graph5.hidden = true;
                graph5.negativeLineColor = "#ff0000";
                graph5.hideBulletsCount = 50; // this makes the chart to hide bullets when there are more than 50 series in selection
                chart.addGraph(graph5);
                
                var graph6 = new AmCharts.AmGraph();
                graph6.title = "rrqms";
                graph6.valueField = "rrqms";
                graph6.bullet = "round";
                graph6.bulletBorderColor = "#FFFFF0";
                graph6.bulletBorderThickness = 1;
                graph6.lineThickness = 1;
                graph6.lineColor = randomColor();
                graph6.hidden = true;
                graph6.negativeLineColor = "#ff0000";
                graph6.hideBulletsCount = 50; 
                chart.addGraph(graph6);
                
                var graph7 = new AmCharts.AmGraph();
                graph7.title = "wrqms";
                graph7.valueField = "wrqms";
                graph7.bullet = "round";
                graph7.bulletBorderColor = "#FFFFF0";
                graph7.bulletBorderThickness = 1;
                graph7.lineThickness = 1;
                graph7.lineColor = randomColor();
                graph7.hidden = true;
                graph7.negativeLineColor = "#ff0000";
                graph7.hideBulletsCount = 50; 
                chart.addGraph(graph7);
                
                var graph8 = new AmCharts.AmGraph();
                graph8.title = "rs";
                graph8.valueField = "rs";
                graph8.bullet = "round";
                graph8.bulletBorderColor = "#FFFFF0";
                graph8.bulletBorderThickness = 1;
                graph8.lineThickness = 1;
                graph8.lineColor = randomColor();
                graph8.hidden = true;
                graph6.negativeLineColor = "#ff0000";
                graph8.hideBulletsCount = 50; 
                chart.addGraph(graph8);
                
                var graph9 = new AmCharts.AmGraph();
                graph9.title = "ws";
                graph9.valueField = "ws";
                graph9.bullet = "round";
                graph9.bulletBorderColor = "#FFFFF0";
                graph9.bulletBorderThickness = 1;
                graph9.lineThickness = 1;
                graph9.lineColor = randomColor();
                graph9.hidden = true;
                graph9.negativeLineColor = "#ff0000";
                graph9.hideBulletsCount = 50; 
                chart.addGraph(graph9);
                
                var graph10 = new AmCharts.AmGraph();
                graph10.title = "rMBs";
                graph10.valueField = "rMBs";
                graph10.bullet = "round";
                graph10.bulletBorderColor = "#FFFFF0";
                graph10.bulletBorderThickness = 1;
                graph10.lineThickness = 1;
                graph10.lineColor = randomColor();
                graph10.hidden = true;
                graph10.negativeLineColor = "#ff0000";
                graph10.hideBulletsCount = 50; 
                chart.addGraph(graph10);
                
                var graph11 = new AmCharts.AmGraph();
                graph11.title = "wMBs";
                graph11.valueField = "wMBs";
                graph11.bullet = "round";
                graph11.bulletBorderColor = "#FFFFF0";
                graph11.bulletBorderThickness = 1;
                graph11.lineThickness = 1;
                graph11.lineColor = randomColor();
                graph11.hidden = true;
                graph11.negativeLineColor = "#ff0000";
                graph11.hideBulletsCount = 50; 
                chart.addGraph(graph11);
                
                var graph12 = new AmCharts.AmGraph();
                graph12.title = "avgrq-sz";
                graph12.valueField = "avgrq-sz";
                graph12.bullet = "round";
                graph12.bulletBorderColor = "#FFFFF0";
                graph12.bulletBorderThickness = 1;
                graph12.lineThickness = 1;
                graph12.lineColor = randomColor();
                graph12.hidden = true;
                graph12.negativeLineColor = "#ff0000";
                graph12.hideBulletsCount = 50; 
                chart.addGraph(graph12);
                
                var graph13 = new AmCharts.AmGraph();
                graph13.title = "avgqu-sz";
                graph13.valueField = "avgqu-sz";
                graph13.bullet = "round";
                graph13.bulletBorderColor = "#FFFFF0";
                graph13.bulletBorderThickness = 1;
                graph13.lineThickness = 1;
                graph13.lineColor = randomColor();
                graph13.hidden = true;
                graph13.negativeLineColor = "#ff0000";
                graph13.hideBulletsCount = 50; 
                chart.addGraph(graph13);
                
                var graph14 = new AmCharts.AmGraph();
                graph14.title = "await";
                graph14.valueField = "await";
                graph14.bullet = "round";
                graph14.bulletBorderColor = "#FFFFF0";
                graph14.bulletBorderThickness = 1;
                graph14.lineThickness = 1;
                graph14.lineColor = randomColor();
                graph14.hidden = true;
                graph14.negativeLineColor = "#ff0000";
                graph14.hideBulletsCount = 50; 
                chart.addGraph(graph14);
                
                var graph15 = new AmCharts.AmGraph();
                graph15.title = "svctm";
                graph15.valueField = "svctm";
                graph15.bullet = "round";
                graph15.bulletBorderColor = "#FFFFF0";
                graph15.bulletBorderThickness = 1;
                graph15.lineThickness = 1;
                graph15.lineColor = randomColor();
                graph15.hidden = true;
                graph15.negativeLineColor = "#ff0000";
                graph15.hideBulletsCount = 50; 
                chart.addGraph(graph15);
                
                var graph16 = new AmCharts.AmGraph();
                graph16.title = "util";
                graph16.valueField = "util";
                graph16.bullet = "round";
                graph16.bulletBorderColor = "#FFFFF0";
                graph16.bulletBorderThickness = 1;
                graph16.lineThickness = 1;
                graph16.lineColor = randomColor();
                graph16.negativeLineColor = "#ff0000";
                graph16.hideBulletsCount = 50; 
                chart.addGraph(graph16);
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
                chart.zoomToIndexes(0, chartData.length);
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
    	<table style="width:100%">
    	<tr><td style="width:98%;height: 350px;">
        	<div id="chartdiv" style="width:100%; height: 350px;"></div>
        </td>
        <td valign="top"><div>
        <small>
        <br>
        <br><a href="/bigview/iostat.jsp?tagserver=<%=tagserver%>" target="_blank">more</a>
        </small></div>
        </td>        
        <tr>
        </table>
    </body>

</html>