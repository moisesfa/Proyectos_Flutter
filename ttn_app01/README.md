# ttn_app01

Un nuevo proyecto Flutter.

## Empezando con Flutter

Este proyecto es un punto de partida para una aplicación Flutter.

Algunos recursos para comenzar si este es su primer proyecto Flutter:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

Para obtener ayuda para comenzar a usar Flutter, vea nuestro
[online documentation](https://flutter.dev/docs), que ofrece tutoriales,
ejemplos, orientación sobre desarrollo móvil y una referencia API completa.

## Descripción de la aplicación 

La aplicación está pensada para leer los datos almacenados en el swagger de la plataforma The Things Network.

<p style="text-align:center">
<img src="https://raw.githubusercontent.com/moisesfa/Proyectos_Flutter/master/img/ttnapp01/swagger.png">
</p>

Se trata de realizar peticiones http, primero para buscar los dispositivos de la aplicación TTN y después para leer los datos almacenados del dispositivo seleccionado.

![postman1](https://raw.githubusercontent.com/moisesfa/Proyectos_Flutter/master/img/ttnapp01/postman1.png)

![postman2](https://raw.githubusercontent.com/moisesfa/Proyectos_Flutter/master/img/ttnapp01/postman2.png)

Para adaptar el código a su aplicación TTN deben editarse estas líneas en el archivo ttn_service.dart:

```

final String ACCESS_KEYS = 'key -TU ACCESS KEYS-';

final url = 'https://TU APLICATION ID.data.thethingsnetwork.org/api/v2/devices';

final url = 'https://TU APLICATION ID.data.thethingsnetwork.org/api/v2/query/$device';

```

Teniendo en cuenta los datos que nos devuelve la petición, el resultado del ejemplo ha quedado de esta manera. 

![code1](https://raw.githubusercontent.com/moisesfa/Proyectos_Flutter/master/img/ttnapp01/code1.png)

![code2](https://raw.githubusercontent.com/moisesfa/Proyectos_Flutter/master/img/ttnapp01/code2.png)

![code3](https://raw.githubusercontent.com/moisesfa/Proyectos_Flutter/master/img/ttnapp01/code3.png)


Nota: Si los datos que se reciben en la petición son diferentes es necesario hacer varias modificaciones para que todo funcione. 

Espero que sea de utilidad para alguien más. 
Saludos. 




