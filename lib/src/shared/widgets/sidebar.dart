import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/users_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidebar extends StatelessWidget {
  Sidebar({super.key});
  final UsersProvider usersProvider = UsersProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: usersProvider.getUserName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Drawer(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 66, 80, 63),
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
                FutureBuilder<bool>(
                  future: _isEmployee(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(); // Placeholder while loading
                    } else if (snapshot.hasData && snapshot.data!) {
                      return ListTile(
                        leading: const Icon(Icons.school),
                        title: const Text('Cursos'),
                        onTap: () => _onItemTapped(1),
                      );
                    } else {
                      return Container(); // Return empty container if not employee
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () => _onItemTapped(2),
                ),
              ],
            ),
          );
        } else {
          return const Drawer();
        }
      },
    );
  }

  Future<bool> _isEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? modelName = prefs.getString('model_name');
    return modelName == 'hr.employee';
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed('/home');
        break;
      case 1:
        Get.toNamed('/courses');
        break;
      case 2:
        usersProvider.logout();
        break;
    }
  }
}
