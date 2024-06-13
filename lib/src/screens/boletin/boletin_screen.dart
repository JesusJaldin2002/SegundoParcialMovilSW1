// screens/boletin_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/boletin/boletin_controller.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/boletin/boletin_detail_screen.dart';

class BoletinScreen extends StatelessWidget {
  final int id;
  final BoletinController controller;

  BoletinScreen({super.key, required this.id})
      : controller = Get.put(BoletinController(userId: id));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 70, 40),
        title: const Text(
          'Boletines',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.boletines.isEmpty) {
          return const Center(child: Text('No hay boletines disponibles'));
        } else {
          return ListView.builder(
            itemCount: controller.boletines.length,
            itemBuilder: (context, index) {
              var boletin = controller.boletines[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 3,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    'Curso: ${boletin.cursoName}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Bimestre: ${boletin.nroBimestre}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Fecha: ${boletin.fecha?.toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Nota Total: ${boletin.notaTotal}',
                        style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {
                    Get.to(() => BoletinDetailScreen(boletinId: boletin.boletinId!));
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
