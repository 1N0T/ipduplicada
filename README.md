![logo](https://raw.github.com/1N0T/images/master/global/1N0T.png)
#Duplicar servidores manteniendo la misma IP.
Los entornos virtuales nos permite duplicar servidores con mucha facilidad, lo que nos posibilita realizra actualizaciones 
arrancandolos en una LAN separada, y comprobar si todo sigue funcionando correctamente después de las mismas.

El problema aparece cuando queremos conectar un mismo cliente al servidor original y a su clon. Todos sabemos que esto no
es posible ya que aparecería un conflicto de IP.
La solución es conectar cada servidor en una LAN separada y que la LAN donde se inicia el clon se conecte a al LAN principal
mediante un equipo que realize NAT.

El script presupone que nuestro servidor principal tiene una IP del tipo 10.1.1.nnn. El clon mantiene la misma IP pero 
el equipo que hace NAT, publicará una IP 10.1.13.nnn.

En el equipo NAT crearemos un alias eth2:nnn con la IP 10.1.13.nnn para cada servidor que queramos duplicar.

Después de ejecutar el script, el cliente podrá conectarse tanto a la 10.1.1.nnn como a la 10.1.13.nnn. Naturalmente, 
deberemos configurar el enrrutameinto adecuado, y la VLAN si las usamos, para que haya visibilidad de las 10.1.13.nnn.

![esquema](https://raw.github.com/1N0T/images/master/ipduplicada/nat.png)
