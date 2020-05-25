#!/bin/sh

### BEGIN INIT INFO
# Provides:          nat
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Ativa o compartilhamento de Internet via NAT
# Description:       Ativa o compartilhamento de Internet via NAT
### END INIT INFO

# As configurações abaixo são para VMware Player (ens33 e ens34)
# Para outro hypervisor, use o comando abaixo para identificar as interfaces
#	ip address show

PATH="/bin:/sbin:/usr/bin:/usr/sbin"

case "$1" in
	start)
		echo "Iniciando serviço NAT..."
		echo 1 > /proc/sys/net/ipv4/ip_forward
		iptables -t nat -F
        iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE
		;;
	stop)
		echo "Parando o serviço NAT..."
		echo 0 > /proc/sys/net/ipv4/ip_forward
		iptables -t nat -F
		;;
	restart)
		echo "Reiniciando o serviço NAT..."
		$0 stop
		$0 start
		;;
	*)
		echo "Operação inválida. Use 'nat [start | stop | restart]'..."
		;;
esac
# End of script
