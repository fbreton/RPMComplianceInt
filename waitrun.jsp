<html>
<head>
<title>Runing remediation</title>
</head>
<script>

var images = ['eng0.jpg','eng1.jpg','eng2.jpg'];

function init()
{
 setInterval("update();", 1000);
 document.myform.submit();
}

var sec = 0;
var index = 0;

function update()
{
 index = index+1;
 index = index%3;
 sec = sec+1;
 document.getElementById('prog').src = images[index];
 document.getElementById('sec').innerHTML = sec+'s';
}
</script>
<body onload="javascript:init();">
<h1 align="center">Remediation of compliance drifts<p>
<img id="prog" src="eng0.jpg" align="middle">
<p>
<h1 align="center" id="sec" >0s</h1>
<form name="myform" action="runscript.jsp" method="POST">
</form>
