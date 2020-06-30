#!/bin/bash
cat << EOF > groups.html
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

echo '</ul>' >> groups.html
echo '</li>' >> groups.html
 


cat /etc/group | tr ":" " " | cut -d " " -f1,3  > group_rep.txt

echo "<br/>"  >> groups.html
cat << EOF >> groups.html
<pre>
<h1 align="center" > Group Information</h1>
<table id="example">
<thead>
<tr>
<th>Group name</th>
<th>GID</th>
</tr>
</thead>
<tbody>
EOF
while read line;
do 
    echo \<tr\> >> groups.html
    for item in $line;
 do 
        echo \<td\>$item\<\/td\> >> groups.html
    done 
    echo \<\/tr\> >> groups.html
done < group_rep.txt

echo '</tbody>' >> groups.html
echo '</table>' >> groups.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>' >> groups.html
echo '<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>' >> groups.html
echo '<script>' >> groups.html
echo '$(function(){' >> groups.html
echo '$("#example").dataTable();' >> groups.html
echo '})' >> groups.html
echo '</script>' >> groups.html
echo '<br/>' >> groups.html
echo '<br/>' >> groups.html



echo '</script>' >> groups.html
echo '</pre>' >> groups.html
echo '<br/>' >> groups.html
echo '<br/>' >> groups.html
echo '<br/>' >> groups.html





echo '</body>' >> groups.html
echo '</html>' >> groups.html

#rm -f  group_rep.txt basicinfo.sh anstohtml.sh  packages.txt
