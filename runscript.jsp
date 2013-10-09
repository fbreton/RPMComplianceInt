<html>
<body>
<%@page import="java.io.*"%>
<%
Runtime r=Runtime.getRuntime();
Process p=null;
String s=null;
String cmd="/opt/bmc/BRLM/server/webapps/ROOT/automation/remediate.sh";
try{
p=r.exec(cmd);
InputStreamReader isr=new InputStreamReader(p.getInputStream());
BufferedReader br=new BufferedReader(isr);
String line=null;
while((line = br.readLine()) != null){
out.println(line);
}
p.waitFor();
}
catch(Exception e){
out.println(e);
}
%>
<h1 align="center">Compliance drifts are remediated<p>
<img src="done.jpg" align="middle">
<p>
<h1 align="center">You can now resolve your request</h1>
<p>
<p align="center">
<a href="javascript:window.open('','_self').close()"><img src="button.close_window.gif" align="middle"></a></p>
</body>
</html>