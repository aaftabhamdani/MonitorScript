#!/bin/bash
cat << EOF > dashboard.html
<html>
<head>
<script src="https://unpkg.com/tlx/browser/tlx.js"></script>
<script src="https://unpkg.com/tlx-chart/browser/tlx-chart.js"></script>
<style>
table {
  table-layout: fixed ;
  width: 100% ;
}
td {
  width: 25% ;
  border: 2px;
}
</style>
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

echo '</ul>' >> dashboard.html
echo '</li>' >> dashboard.html
 

env | ./anstohtml.sh  >> dashboard.html
iostat |grep -v ^$ | tail -n +5 > packages.txt
mpstat | tail -n +4 | tr -s " " |cut -d " " -f1-8 > process.txt
df -Pkh | tail -n  +2 | tr -s " " |cut -d " " -f1 > part1.txt
df -Pkh | tail -n  +2 | tr -s " " |cut -d " " -f2,3 > part2.txt
paste part1.txt part2.txt > input.txt
df -Pkh | tail -n +2|tr -s " " | cut -d" " -f1,5 | tr "%" " " > pie.txt


cat << EOF >> dashboard.html
<pre>
<h1 align="center" > Mount point Information</h1>
<table id="example">
<thead>
<tr>
<th>File System</th>
<th>Sized</th>
<th>Available</th>
</tr>
</thead>
<tbody>
EOF
while read line;
do 
    echo \<tr\> >> dashboard.html
    for item in $line;
 do 
        echo \<td\>$item\<\/td\> >> dashboard.html
    done 
    echo \<\/tr\> >> dashboard.html
done < input.txt

echo '</tbody>' >> dashboard.html
echo '</table>' >> dashboard.html
echo '</pre>' >> dashboard.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>' >> dashboard.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>' >> dashboard.html
echo '<script>' >> dashboard.html
echo '$(function(){' >> dashboard.html
echo '$("#example").dataTable();' >> dashboard.html
echo '})' >> dashboard.html
echo '</script>' >> dashboard.html
cat << EOF >> dashboard.html
<br/>
<pre>
<h1 align="center" > Disk Performance</h1>
<table id="example1">
<thead>
<tr>
<th>Device</th>
<th>TPS</th>
<th>KB read/sec</th>
<th>KB written/sec</th>
<th>KB read</th>
<th>KB written</th>
</tr>
</thead>
<tbody>
EOF
while read line;
do
    echo \<tr\> >> dashboard.html
    for item in $line;
 do
        echo \<td\>$item\<\/td\> >> dashboard.html
    done
    echo \<\/tr\> >> dashboard.html
done < packages.txt

echo '</tbody>' >> dashboard.html
echo '</table>' >> dashboard.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>' >> dashboard.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>' >> dashboard.html
echo '<script>' >> dashboard.html
echo '$(function(){' >> dashboard.html
echo '$("#example1").dataTable();' >> dashboard.html
echo '})' >> dashboard.html
echo '</script>' >> dashboard.html













#echo '</script>' >> dashboard.html
echo '</pre>' >> dashboard.html
cat << EOF >> dashboard.html
<pre>
<h1 align="center" > CPU performance</h1>
<table id="example2">
<thead>
<tr>
<th>TIME</th>
<th>AM/PM</th>
<th>CPU</th>
<th>%USR</th>
<th>%NICE</th>
<th>%SYS</th>
<th>%IOWAIT</th>
<th>%IRQ</th>
</tr>
</thead>
<tbody>
EOF
while read line;
do
    echo \<tr\> >> dashboard.html
    for item in $line;
 do
        echo \<td\>$item\<\/td\> >> dashboard.html
    done
    echo \<\/tr\> >> dashboard.html
done < process.txt

echo '</tbody>' >> dashboard.html
echo '</table>' >> dashboard.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>' >> dashboard.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>' >> dashboard.html
echo '<script>' >> dashboard.html
echo '$(function(){' >> dashboard.html
echo '$("#example2").dataTable();' >> dashboard.html
echo '})' >> dashboard.html
echo '</script>' >> dashboard.html
echo '</pre>' >> dashboard.html




echo '<table>' >> dashboard.html
echo '<tr>' >> dashboard.html
while read dsk;
do
DISK=$(echo $dsk | cut -d " " -f1)
USED=$(echo $dsk | cut -d " " -f2)
FREE=`expr 100 - $USED`

echo '<td>' >> dashboard.html
echo '<h2 align="center";> Device '"$DISK" '</h2>' >> dashboard.html
echo '<tlx-chart chart-type="PieChart"' >> dashboard.html
echo 'chart-columns="${[Element,Percentage]}"' >> dashboard.html
echo 'chart-data="${[' >> dashboard.html
echo  "['Used'," $USED'],' >> dashboard.html
echo  "['Free'," $FREE']]}"' >> dashboard.html
echo '</tlx-chart>' >> dashboard.html
echo '</td>' >> dashboard.html
done < pie.txt
echo '</tr>' >> dashboard.html
echo '</table>' >> dashboard.html




echo '</body>' >> dashboard.html
echo '</html>' >> dashboard.html


rm -f  process.txt  anstohtml.sh input.txt inputp.txt packages.txt basicinfo.sh group_rep.txt host.txt user_rep.txt part1.txt part2.txt pie.txt
