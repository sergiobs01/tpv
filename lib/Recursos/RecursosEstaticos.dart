import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tpv/Actividades/LoginScreen.dart';
import 'package:tpv/Clases/Articulo.dart';
import 'package:tpv/InternalDB/DBHelper.dart';
import 'package:tpv/Recursos/ManejadorEstatico.dart';

import '../Clases/Mesa.dart';
import '../Clases/Usuario.dart';

class RecursosEstaticos {
  static String logoNormal = 'assets/logo.jpg';
  static bool isPCPlatform;
  static const appName = 'Baratie TPV';
  static String ajustesLabel = 'Ajustes';
  static String clientesLabel = 'Clientes';
  static String articuloLabel = 'Articulos';
  static String descuentoLabel = 'Descuentos';
  static String listapedidos = 'Pedido de ';
  static String seleccion = 'Selección de mesa';
  static String mesasLabel = 'Mesas';
  static String filtradoLabel = 'Escriba para filtrar';
  static const wsUrl = 'http://wstpv.azurewebsites.net/api/';
  //static const wsUrl = 'https://localhost:44339/api/';
  static Usuario usuario;
  static const opciones = {
    0: 'Caja',
    1: 'Almacen',
    2: 'Clientes',
    3: 'Descuentos',
    4: 'Mesas',
    5: 'Ajustes',
  };
  static var opcionesDisponiblesPC = {0, 1, 2, 3, 4, 5};
  static var opcionesDisponiblesMovil = {0, 2, 5};
  static DBHelper Database;
  static Socket socket;
  static ServerSocket socketServer;
  static bool conectado = false;
  static List<String> ip = [];
  static Map<int, Mesa> pedidos = {};
  static final alertDialogLoading = AlertDialog(
    content: Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text('Cargando...')),
        ],
      ),
    ),
  );
  static final List<Socket> clientes = [];
  // TEXTOS DE AYUDA
  // Caja
  static const caja1Ayuda = 'Esta ventana carga las mesas disponibles en la base de datos.\n\n'
      'Si anteriormente después de cargar la aplicación de PC ha añadido mesas a la base de datos será necesario reiniciar la aplicación, debido a que los cambios no se quedarán registrados hasta entonces.\n\n'
      'En dispositivos móviles hará una petición al PC para que le devuelva las mesas disponibles.';
  static const caja2Ayuda = 'Esta ventana muestra los pedidos actuales que están pendientes de pago.\n\n'
      'En la versión de PC; en la izquierda (recuadro amarillo) cargará una lista con los articulos (si hubiese disponibles) y su total, en la derecha (recuadro gris) cargara los articulos (si hubiese en la base de datos) y sus respectivas fotos (cargadas por URL) y por ultimo abajo de los articulos unos botones para dar la orden como pagada.\n\n'
      'En la versión móvil; arriba (recuadro amarillo) cargará una lista con los articulos (si hubiese disponibles) y su total, abajo (recuadro gris) cargara los articulos (si hubiese en la base de datos) y sus respectivas fotos (cargadas por URL) y ya por ultimo un botón abajo para enviar el pedido al ordenador principal.';
  static const caja3Ayuda = 'Esta pantalla cargará al darle desde uno de los botones en la versión de ordenador, sirve para dar como finalizado el pago.\n\n'
      'Habría que seleccionar un cliente, acto seguido haría una comprobación buscando si el cliente dispone de descuentos, en caso afirmativo mostrará una alerta preguntando si desea usarlos, en cualquier caso cargaría la siguiente ventana con los detalles del pago.\n\n'
      'Al seleccionar un cliente automáticamente se registra el pedido como pagado en la base de datos.';
  static const caja4Ayuda = 'Esta es la última pantalla de la sección de Caja, esta contiene los datos del pedido (artículos, precio y cantidad), indicará los descuentos, la forma de pago y el precio total con los descuentos.\n\n'
      'Dispone de un botón el cual hará volver al menú principal.';
  // Almacen
  static const almacen1Ayuda = 'En esta ventana se puede observar un botón de refrescar en la barra de arriba (recarga los artículos), un cajón para introducir texto arriba (este filtrará por cualquier campo de los articulos, haciendo mas facil la busqueda de este), varios recuadros que indican el campo (al hacer clic en ellos ordenará de mayor a menor y viceversa por ese campo en específico), una lista con todos los artículos (al hacer clic en alguno de ellos nos llevará a una ventana a parte para poder editarlo o eliminarlo) y por último un botón con el símbolo de “+” el cual sirve para añadir un nuevo artículo.';
  static const almacen2Ayuda = 'Esta pantalla muestra los campos rellenables de artículo, podemos editarlos o añadir nuevos dando clic en ellos.\n\n'
      'En la esquina derecha inferior podemos apreciar un botón, el cual es un “+” (al dar clic se añadirá el artículo con los campos rellenos) cuando viene para añadir un artículo y un “:” (al dar clic se despliega dos botones, uno de papelera; el cual borra, y uno de guardar; el cual actualiza el artículo en la base de datos) cuando viene para editar un artículo.';
  // Clientes
  static const cliente1Ayuda = 'En esta ventana se puede observar un botón de refrescar en la barra de arriba (recarga los clientes), un cajón para introducir texto arriba (este filtrará por cualquier campo de los clientes, haciendo más fácil la búsqueda de este), varios recuadros que indican el campo (al hacer clic en ellos ordenará de mayor a menor y viceversa por ese campo en específico), una lista con todos los clientes (al hacer clic en alguno de ellos nos llevará a una ventana a parte para poder editarlo o eliminarlo) y por último un botón con el símbolo de “+” el cual sirve para añadir un nuevo cliente.';
  static const cliente2Ayuda = 'Esta pantalla muestra los campos rellenables del cliente, podemos editarlos o añadir nuevos dando clic en ellos.\n\n'
      'En la esquina derecha inferior podemos apreciar un botón, el cual es un “+” (al dar clic se añadirá el cliente con los campos rellenos) cuando viene para añadir un cliente y un “:” (al dar clic se despliega dos botones, uno de papelera; el cual borra, y uno de guardar; el cual actualiza el cliente en la base de datos) cuando viene para editar un cliente.';
  // Descuentos
  static const descuentos1Ayuda = 'En esta ventana se puede observar un botón de refrescar en la barra de arriba (recarga los descuentos), un cajón para introducir texto arriba (este filtrará por cualquier campo de los descuentos, haciendo más fácil la búsqueda de este), varios recuadros que indican el campo (al hacer clic en ellos ordenará de mayor a menor y viceversa por ese campo en específico), una lista con todos los descuentos (al hacer clic en alguno de ellos nos llevará a una ventana a parte para poder editarlo o eliminarlo) y por último un botón con el símbolo de “+” el cual sirve para añadir un nuevo descuento.';
  static const descuentos2Ayuda = 'Esta pantalla es llamada desde la pantalla descuentos, sirve para seleccionar el cliente al que desea hacerle el descuento, dispone de los mismos filtros que la ventana de clientes y un botón de refrescar.\n\n'
      'Al hacer clic en un cliente este te lleva a la pantalla de creación de descuento.';
  static const descuentos3Ayuda = 'Esta pantalla muestra el campo rellenable de descuento (la cantidad), podemos editarlo o añadir uno nuevo dando clic en el.\n\n'
      'En la esquina derecha inferior podemos apreciar un botón, el cual es un “+” (al dar clic se añadirá el descuento con la cantidad seleccionada) cuando viene para añadir un descuento y un “:” (al dar clic se despliega dos botones, uno de papelera; el cual borra, y uno de guardar; el cual actualiza el descuento en la base de datos) cuando viene para editar un descuento.';
  // Mesas
  static const mesas1Ayuda = 'En esta ventana se puede observar un botón de refrescar en la barra de arriba (recarga las mesas), un cajón para introducir texto arriba (este filtrará por cualquier campo de las mesas, haciendo mas facil la busqueda de esta), varios recuadros que indican el campo (al hacer clic en ellos ordenará de mayor a menor y viceversa por ese campo en específico), una lista con todas las mesas (al hacer clic en alguna de ellas nos llevará a una ventana a parte para poder editarla o eliminarla) y por último un botón con el símbolo de “+” el cual sirve para añadir una nueva mesa.';
  static const mesas2Ayuda = 'Esta pantalla muestra los campos rellenables de mesa, podemos editarlos o añadir nuevos dando clic en ellos.\n\n'
      'En la esquina derecha inferior podemos apreciar un botón, el cual es un “+” (al dar clic se añadirá la mesa con los campos rellenos) cuando viene para añadir una mesa y un “:” (al dar clic se despliega dos botones, uno de papelera; el cual borra, y uno de guardar; el cual actualiza la mesa en la base de datos) cuando viene para editar una mesa.';
  // Ajustes
  static const ajustesAyuda = 'Esta pantalla tiene 3 apartados.\n\n'
      'Apartado de cambiar nombre del empleado, se encarga de cambiar el nombre del empleado en la base de datos.\n\n'
      'Apartado de cambiar la contraseña, cambia la contraseña del usuario en caso de que desee cambiarla.\n\n'
      'El último apartado cambia en función de si estamos trabajando en PC o dispositivo móvil, en caso de PC muestra las IP’s de nuestro ordenador (las cuales son necesarias para conectar nuestro dispositivo móvil al PC) y en caso de ser dispositivo móvil tiene una caja la cual espera recibir la IP del PC para hacer la conexión con él.';
}
