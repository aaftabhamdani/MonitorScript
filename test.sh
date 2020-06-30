#!/bin/bash
cat << EOF > index1.html
<html>
<head>


<link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
<style>
ul {
list-style-type: none;
margin: 0;
padding: 0;
overflow: hidden;
background-color: #333;
}
li {
float: left;
}
li a {
display: block;
color: white;
text-align: center;
padding: 14px 16px;
text-decoration: none;
}
li a:hover {
background-color: #111;
}





* {
  box-sizing: border-box;
}

/* Create two equal columns that floats next to each other */
.column {
  float: left;
  width: 50%;
  padding: 5px;
  height: 110px; /* Should be removed. Only for demonstration */
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}





</style>
</head>
<body>




<div class="row">
  <div class="column" style="background-color:#ffff;">
 <marquee>   <h1>CloudOps Deployment Checklist Report</h1></marquee>
  </div>
  <div class="column" style="background-color:#ffff;">
<img src="bg.png" alt="Logo" height="100px" align="right" >
  </div>
</div>




<ul>
<li><a class="active" href="index1.html">Summary</a></li>
<li><a href="dashboard.html">Dashboard</a></li>
<li><a href="groups.html">Groups</a></li>
<li><a href="users.html">Users</a></li>
<li><a href="../index.html">List of Servers</a></li>
EOF

echo '</ul>' >> index1.html
echo '</li>' >> index1.html
 

./basicinfo.sh | column -s "&" -t | ./anstohtml.sh >> index1.html
netstat -ant | tail -n +3 > inputp.txt




rpm -qa --last | tr -s " " |cut -d" " -f2- |tr " " "-" > package2.txt
rpm -qa > package1.txt 
paste package1.txt package2.txt  | column -t > packages.txt



ps -ef | tail -n +2 |tr -s " " | cut -d " " -f2,8 > process.txt 

echo "<br/>"  >> index1.html
echo "<br/>"  >> index1.html
cat << EOF >> index1.html
<pre>
<h1 align="center" > Network statistics</h1>
<table id="example">
<thead>
<tr>
<th>Proto</th>
<th>Receive-Q</th>
<th>Send-Q</th>
<th>Local Address</th>
<th>Foreign Address</th>
<th>State</th>
</tr>
</thead>
<tbody>
EOF
while read line;
do 
    echo \<tr\> >> index1.html
    for item in $line;
 do 
        echo \<td\>$item\<\/td\> >> index1.html
    done 
    echo \<\/tr\> >> index1.html
done < inputp.txt

echo '</tbody>' >> index1.html
echo '</table>' >> index1.html
echo '</pre>' >> index1.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>' >> index1.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>' >> index1.html
echo '<script>' >> index1.html
echo '$(function(){' >> index1.html
echo '$("#example").dataTable();' >> index1.html
echo '})' >> index1.html
echo '</script>' >> index1.html
echo '<br/>' >> index1.html
cat << EOF >> index1.html
<pre>
<h1 align="center" > List of Installed Packages</h1>
<table id="example1">
<thead>
<tr>
<th>Packages Installed</th>
<th>Date and Time</th>
</tr>
</thead>
<tbody>
EOF
while read line;
do
    echo \<tr\> >> index1.html
    for item in $line;
 do
        echo \<td\>$item\<\/td\> >> index1.html
    done
    echo \<\/tr\> >> index1.html
done < packages.txt

echo '</tbody>' >> index1.html
echo '</table>' >> index1.html
echo '</pre>' >> index1.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>' >> index1.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>' >> index1.html
echo '<script>' >> index1.html
echo '$(function(){' >> index1.html
echo '$("#example1").dataTable();' >> index1.html
echo '})' >> index1.html
echo '</script>' >> index1.html













echo '</script>' >> index1.html
echo '<br/>' >> index1.html
cat << EOF >> index1.html
<pre>
<h1 align="center" > Process Status</h1>
<table id="example2">
<thead>
<tr>
<th>UID</th>
<th>PROCESS</th>
</tr>
</thead>
<tbody>
EOF
while read line;
do
    echo \<tr\> >> index1.html
    for item in $line;
 do
        echo \<td\>$item\<\/td\> >> index1.html
    done
    echo \<\/tr\> >> index1.html
done < process.txt

echo '</tbody>' >> index1.html
echo '</table>' >> index1.html
echo '</pre>' >> index1.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>' >> index1.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>' >> index1.html
echo '<script>' >> index1.html
echo '$(function(){' >> index1.html
echo '$("#example2").dataTable();' >> index1.html
echo '})' >> index1.html
echo '</script>' >> index1.html




echo '</body>' >> index1.html
echo '</html>' >> index1.html

rm -f   package1.txt package2.txt
