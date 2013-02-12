<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.weibo.showData.*"%>
<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String tagserver =request.getParameter("tagserver");
		String graphname =request.getParameter("graphname");
		PerfDataServlet perfDataServlet = new PerfDataServlet(tagserver, graphname);
		String str = perfDataServlet.getResult();
		String taglist = perfDataServlet.getTaglist();		
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
        	
			var tagchar = <%=taglist%>;
			var tagArray = new Array;
        	tagArray = tagchar.split(",");
            
        	AmCharts.ready(function () {
                
                // SERIAL CHART
                chart = new AmCharts.AmSerialChart();
                chart.dataProvider = chartData;
                chart.pathToImages = "../amcharts/images/";
                chart.categoryField = "timestamp";
                chart.startDuration = 0.1;
                chart.startEffect=">";
                chart.zoomOutButton = {
                    backgroundColor: '#000000',
                    backgroundAlpha: 0.15
                };
                chart.balloon.color = "#000000";
				chart.addLabel("10%","20%","<%=graphname%>"+":"+"<%=tagserver%>","left",10,"#000000","0",true);
				
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
				var graph = new Array();
				
                for(j=0;j<tagArray.length;j++){            	               	
                	graph[j] = new AmCharts.AmGraph();
               	 	graph[j].title = tagArray[j];
                	graph[j].valueField = tagArray[j];
                	graph[j].bullet = "round";
                	graph[j].bulletBorderColor = "#FFFFFF";
                	graph[j].bulletBorderThickness = 2;
                	graph[j].lineThickness = 1;
                	graph[j].lineColor = randomColor();
                	graph[j].negativeLineColor = "#0352b5";
                	graph[j].hideBulletsCount = 50;
 					chart.addGraph(graph[j]);   
                	
                	// SCROLLBAR
                	var chartScrollbar = new AmCharts.ChartScrollbar();
               		chartScrollbar.graph = graph[j];
               		chartScrollbar.scrollbarHeight = 20;
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
                legend.fontsize = 1;
                legend.verticalGap = 2;
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
        <br><a href="/bigview/perftag.jsp?tagserver=<%=tagserver%>&graphname=<%=graphname%>" target="_blank">more</a>
        </small></div>
        </td>
        </tr>
        </table>
    </body>

</html>