import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/boletin/boletin_controller.dart';
import 'package:segundo_parcial_movil_sw1/src/models/boletin.dart';

class BoletinDetailScreen extends StatelessWidget {
  final int boletinId;
  const BoletinDetailScreen({super.key, required this.boletinId});

  @override
  Widget build(BuildContext context) {
    final BoletinController controller = Get.find();
    final Boletin? boletin = controller.getBoletinById(boletinId);

    if (boletin == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 45, 70, 40),
          title: const Text(
            'Detalles del Boletín',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: const Center(
          child: Text('Boletín no encontrado'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 70, 40),
        title: const Text(
          'Detalles del Boletín',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Curso: ${boletin.cursoName}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Bimestre: ${boletin.nroBimestre}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Fecha: ${boletin.fecha?.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Nota Total: ${boletin.notaTotal}',
              style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Notas:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.black),
            Expanded(
              child: ListView.builder(
                itemCount: boletin.notas?.length ?? 0,
                itemBuilder: (context, index) {
                  var nota = boletin.notas![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 45, 70, 40),
                        child: Text(
                          nota.materiaName![0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        '${nota.materiaName}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Nota: ${nota.nota}', style: const TextStyle(fontSize: 16)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}