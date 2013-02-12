java -classpath WebRoot/:./WebRoot/WEB-INF/classes/:`find . -name "*.jar" -exec echo -n {}: \;` com.weibo.start.StartHandler &
