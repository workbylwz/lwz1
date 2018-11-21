#/bin/bash
cd /root/lwz1
java -XX:+UseConcMarkSweepGC -cp target/sparrow-1.0-SNAPSHOT.jar edu.berkeley.sparrow.daemon.SparrowDaemon -c sparrow.conf &
sleep 3
java -cp target/sparrow-1.0-SNAPSHOT.jar edu.berkeley.sparrow.examples.SimpleBackend &
sleep 3
ip=`ifconfig eth0 | grep 172.17.0 | sed 's/:/ /g' | sed 's/\./ /g' | awk '{print $6}'`
if [ 2 -eq $ip ]; then
	sleep 60
	java -cp target/sparrow-1.0-SNAPSHOT.jar edu.berkeley.sparrow.examples.SimpleFrontend &
fi 
sleep 900
cd ~
tar czvf sparrow_log$ip.tar.gz /root/lwz1/
sshpass -p lwz920923 scp sparrow_log$ip.tar.gz lwz@59.66.72.14:~/Log
