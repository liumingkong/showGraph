package com.weibo.start;

import org.mortbay.jetty.Connector;
import org.mortbay.jetty.Server;
import org.mortbay.jetty.bio.SocketConnector;
import org.mortbay.jetty.webapp.WebAppContext;

public class StartHandler {
    public static void main(String[] args) throws Exception {
        Server server = new Server();
        Connector connector = new SocketConnector();
        connector.setPort(8080);
        server.setConnectors(new Connector[] { connector });        
        WebAppContext webapp = new WebAppContext();
        webapp.setContextPath("/");      
        webapp.setResourceBase("WebRoot");
        server.setHandler(webapp);
        server.start();
        server.join();
    }
}
