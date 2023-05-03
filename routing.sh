#!/bin/bash

# Get the list of interface names
interfaces=$(ip -o link show | awk -F': ' '{print $2}')

# Loop through each interface and get its IP address
for i in $interfaces
do
    ip=$(ip -o -4 addr show dev $i | awk '{split($4,a,"/"); print a[1]}')
    echo "Interface $i IP address: $ip"
done


# Get the list of interface names
interfaces=$(ip -o link show | awk -F': ' '{print $2}')

# Loop through each interface and get its IP address
for i in $interfaces
do
    # Get the IP address of the interface using the `ip` command
    ip=$(ip -o -4 addr show dev $i | awk '{split($4,a,"/"); print a[1]}')

    # Check if the IP address matches the 192.168.10.* pattern
    if [[ $ip == 192.168.10.* ]]; then
        #wirte the mgmt interface name on variable called m_interface
        m_interface=$i
        echo "Interface $i has IP address in the 192.168.10.* range:$ip"
        echo "$m_interface"
fi
done

#echo "sudo ip route add 192.168.40.0/0 via 192.168.10.1 dev $m_interface"

for i in $interfaces
do

 # Get the IP address of the interface using the `ip` command
    ip=$(ip -o -4 addr show dev $i | awk '{split($4,a,"/"); print a[1]}')

    # Check if the IP address matches the 192.168.20.* pattern
    if [[ $ip == 192.168.20.* ]]; then
        #wirte the netroute1 interface name on variable called netroute_1
        netroute_1=$i
        echo "Interface $i has IP address in the 192.168.20.* range:$ip"
        echo "$netroute_1"
fi
done
for i in $interfaces
do

 # Get the IP address of the interface using the `ip` command
    ip=$(ip -o -4 addr show dev $i | awk '{split($4,a,"/"); print a[1]}')

    # Check if the IP address matches the 192.168.30.* pattern
    if [[ $ip == 192.168.30.* ]]; then
        #wirte the netroute_2 interface name on variable called netroute_2
        netroute_2=$i
        echo "Interface $i has IP address in the 192.168.30.* range:$ip"
        echo "$netroute_2"
fi
done
for i in $interfaces
do

 # Get the IP address of the interface using the `ip` command
    ip=$(ip -o -4 addr show dev $i | awk '{split($4,a,"/"); print a[1]}')

    # Check if the IP address matches the 192.168.40.* pattern
    if [[ $ip == 192.168.40.* ]]; then
        #wirte the route_to_main_proxy  interface name on variable called route_to_main_proxy
        route_to_main_proxy=$i
        echo "Interface $i has IP address in the 192.168.40.* range:$ip"
        echo "$route_to_main_proxy "
fi
done

if [ -z "$route_to_main_proxy" ]; then
  echo "You are a client"
sudo ip route replace default via 192.168.20.1
sudo ip route append default via 192.168.30.1
else
  echo "you are a Proxy"
sudo ip route replace default via 192.168.50.1
#echo $netroute_1
#echo $netroute_2
#echo $route_to_main_proxy
sudo ip route add 192.168.20.0/24 via 192.168.40.1 dev $route_to_main_proxy
sudo ip route add 192.168.30.0/24 via 192.168.40.1 dev $route_to_main_proxy
fi



