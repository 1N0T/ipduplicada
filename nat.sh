#!/bin/sh

#=============================================================================
# 1N0T 27/03/2013
#-----------------------------------------------------------------------------
# Este script permite levantar una copia de una máquina 
# al mismo tiempo que la copia original y sin tener que reconfigurar la IP.
#
# Para que esto sea posible se tienen que cumplir una serie de requisitos:
#   * El servidor a duplicar tiene que tener una IP 10.1.1.nnn
#   * Se tiene que crear una interfase eth2:nnn en este servidor y se
#     le tiene que asignar la dirección 10.1.13.nnn
#   * La tarjeta de la copia se tiene que conectar a un switch sin conexió
#     directa a LAN.
#   * Tras ejecutar el script, se podrá acceder a la copia con la IP
#     10.1.13.nnn 
#=============================================================================


echo -n Aplicando Reglas de Firewall...
echo -n Escanenado IPs cofiguradas
echo
for IP in $(ifconfig |grep eth2:|cut -d':' -f2|cut -d ' ' -f1)
do
   echo 10.1.1.$IP
   route del -host 10.1.1.$IP
   route add -host 10.1.1.$IP dev eth1
done

## FLUSH de reglas
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

## Establecemos politica por defecto
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

for IP in $(ifconfig |grep eth2:|cut -d':' -f2|cut -d ' ' -f1)
do
   iptables -t nat -A PREROUTING -d 10.1.13.$IP -j DNAT --to-destination 10.1.1.$IP
done


# Ahora hacemos enmascaramiento de la red local
# y activamos el BIT DE FORWARDING (imprescindible!!!!!)
for IP in $(ifconfig |grep eth2:|cut -d':' -f2|cut -d ' ' -f1)
do
   iptables -t nat -A POSTROUTING -s 10.1.1.$IP -j SNAT --to-source 10.1.13.$IP
done

iptables -t nat -A POSTROUTING -o eth1 -j SNAT --to-source 10.1.1.213


# Con esto permitimos hacer forward de paquetes en el firewall, o sea
# que otras máquinas puedan salir a traves del firewall.
echo 1 > /proc/sys/net/ipv4/ip_forward
