import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/users_provider.dart';

class Sidebar extends StatelessWidget {
  Sidebar({Key? key}) : super(key: key);
  final UsersProvider usersProvider = UsersProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: usersProvider.getUserName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra el indicador de carga mientras se obtiene la información del usuario
          return const Drawer(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          // Muestra el Drawer con la información del usuario una vez que está disponible
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 61, 61, 61),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 30.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          snapshot.data!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Inicio'),
                  onTap: () => _onItemTapped(0),
                ),
                // Agrega más ListTile aquí para más botones en el Sidebar
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () => _onItemTapped(1),
                ),
              ],
            ),
          );
        } else {
          // Muestra un Drawer vacío si hay un error al obtener la información del usuario
          return const Drawer();
        }
      },
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed('/home');
        break;
      case 1:
        usersProvider.logout();
        break;
      // Agrega más casos aquí para más botones en el Sidebar
    }
  }
}
