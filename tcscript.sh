#!/bin/bash

echo "deleting all previous rules"
tc qdisc del dev eno1 root

# https://netbeez.net/blog/how-to-use-the-linux-traffic-control/

#In order to limit the egress bandwidth we can use the following command:

#tc qdisc add dev eth0 root tbf rate 1mbit burst 32kbit latency 400ms

#tbf: use the token buffer filter to manipulate traffic rates
#rate: sustained maximum rate
#burst: maximum allowed burst
#latency: packets with higher latency get dropped

tc qdisc add dev eno1 root tbf rate 10mbit burst 1mbit latency 400ms

#tc qdisc del dev eno1 root

echo "dumping rules"
tc qdisc show  dev eno1
