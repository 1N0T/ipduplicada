![logo](https://raw.github.com/1N0T/images/master/global/1N0T.png)
#Duplicar servidore manteniendo la misma IP.
Si tienes experiencia con la virtualización, seguramente estarás encantado/a (me permitiréis que en los susesivo utilize sólo el masculino genérico) con la facilidad que podemos clonar un entorno para realizar pruebas si riesgo alguno.

Pero muchas veces me he enconcontrado con la necesidad de poder conectar mi estación de trabajo simultáneamente al servidor original y al servidor clonado (sin realizar ningún cambio  de configuración en este último). Claro que como todos sabéis, esto no es posible ya que aparecería un conflicto de IP.

Si reflexionamos un poco, nos daremos cuenta de que este supuesto conflicto de direcciones se produce continuamente en internet y que, gracias a la magia del **NAT**, no representa ningún problema.

El objetivo es simple, tengo una LAN donde se encuentran tanto mis servidores como mis clientes.
