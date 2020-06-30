#!/bin/bash
echo "Username:&`whoami`"
echo "MAC:&"$(c=`cat /sys/class/net/*/address`;if [ "$c" != '' ];then for i in `cat /sys/class/net/*/address`; do echo "$i " | tr "\n" "  "; done; echo  ""; else echo "No MAC address found"; fi)
echo "Kernel-version:&`uname -r`"
echo "Memory:&`free -m | grep Mem | tr -s " " |cut -d " " -f2`MB"  
echo "Swap:&`free -m | grep Swap | tr -s " " |cut -d " " -f2`MB"  
echo -e "Storage-devices:&`lsblk | tail -n +2 | cut -d ' ' -f1 | grep -v [0-9] | tr '\n' '\t'` "
echo -e "Hostname:&"`hostname`
echo -e "uptime:&"`uptime | awk '{print $3,$4}' | sed 's/,//'`
echo -e "Version:&"`cat /sys/class/dmi/id/product_version`
echo -e "Machine Type:&"`vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi`
echo -e "Operating System:&"`cat /etc/redhat-release`
echo -e "Architecture:&"`uname -p`
echo -e "Processor Name:&"`awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'`
echo -e "Active User:&"$(c=`users`;if [ "$c" != '' ];then for i in `users`; do echo "$i " | tr "\n" "  "; done; echo  ""; else echo "No active users"; fi)
echo -e "System Main IP:&"`hostname -I`
echo "Memory Usage:&`free -m | grep Mem | tr -s " " |cut -d " " -f3`MB"
echo "Swap Usage:&`free -m | grep Swap | tr -s " " |cut -d " " -f3`MB"
echo -e "CPU Usage:&"`cat /proc/stat | awk '/cpu/{printf("%.2f%\n"), ($2+$4)*100/($2+$4+$5)}' |  awk '{print $0}' | head -1`
vserver=$(lscpu | grep Hypervisor | wc -l)
if [ $vserver -gt 0 ]
then
echo "$(hostname) is:&VM"
else
cat /sys/class/fc_host/host?/port_name
fi



echo "LM License file location is:&"$(lm=`echo $LM_LICENSE_FILE`;if [ "$lm" != '' ];then for i in `echo $LM_LICENSE_FILE`; do echo "$i " | tr "\n" "  "; done; echo  ""; else echo "No enviornment variable found"; fi)



echo "Oracle home directory is:&"$(orcl=`echo $ORACLE_HOME`;if [ "$orcl" != '' ];then for i in `echo $ORACLE_HOME`; do echo "$i " | tr "\n" "  "; done; echo  ""; else echo "No enviornment variable found"; fi)


echo "OS Conf Directory is:&"$(os=`echo $OW_CONF_DIR`;if [ "$os" != '' ];then for i in `echo $OW_CONF_DIR`; do echo "$i " | tr "\n" "  "; done; echo  ""; else echo "No enviornment variable found"; fi)

echo "TNS Admin is:&"$(tns=`echo $TNS_ADMIN`;if [ "$tns" != '' ];then for i in `echo $TNS_ADMIN`; do echo "$i " | tr "\n" "  "; done; echo  ""; else echo "No enviornment variable found"; fi)

echo "LGC EDM Remote OS Authent is:&"$(lgc=`echo $LGC_EDM_REMOTE_OS_AUTHENT`;if [ "$lgc" != '' ];then for i in `echo $LGC_EDM_REMOTE_OS_AUTHENT`; do echo "$i " | tr "\n" "  "; done; echo  ""; else echo "No enviornment variable found"; fi)



cat /etc/sysctl.conf | grep -v ^#|tr "=" "&"
echo "Selinux Status:&`getenforce`"
cat /etc/redhat-release 2> /dev/null | grep 6 &>/dev/null
if [ $? -eq 0 ];then
chkconfig 2> /dev/null| grep rh | grep -o 3:on &> /dev/null; if [ $? -eq 0 ];then echo "IP table status:& Enabled";else echo "IP table status:& Disabled";fi
else
systemctl is-enabled firewalld  &>/dev/null; if [ $? -eq 0 ];then echo "Firewall status:&Enabled";else echo "Firewall status:&Disabled";fi
fi
/Landmark/LAM/bin/lmstat  -c /Landmark/LAM/license.dat &>/dev/null
if [ $? -eq 0 ];then
echo "License Status:&License Server is up"
else
echo "License Status:&License Server is down"
fi
