import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/create_notice/create_notice_controller.dart';
import 'package:intl/intl.dart'; // Importa la biblioteca intl

class CreateNoticeScreen extends StatelessWidget {
  final int id;

  CreateNoticeScreen({super.key, required this.id});

  final CreateNoticeController controller = Get.put(CreateNoticeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Noticia',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 45, 70, 40), // Color similar al de la imagen
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo-white.png', // Asegúrate de que la ruta de la imagen sea correcta
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Crear Nueva Noticia',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E3B55),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: controller.titleController,
                    label: 'Título',
                    icon: Icons.title,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un título';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildExpandableTextField(
                    controller: controller.descriptionController,
                    label: 'Descripción',
                    icon: Icons.description,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una descripción';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildDateField(
                    context: context,
                    controller: controller.fechaInicioController,
                    label: 'Fecha de Inicio',
                    icon: Icons.date_range,
                  ),
                  const SizedBox(height: 20),
                  _buildDateField(
                    context: context,
                    controller: controller.fechaFinController,
                    label: 'Fecha de Fin',
                    icon: Icons.date_range,
                  ),
                  const SizedBox(height: 40),
                  Obx(() {
                    return controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : Center(
                            child: ElevatedButton(
                              onPressed: () => controller.createNotice(id),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 45, 70, 40),
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Crear Noticia',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 45, 70, 40), // Color principal
              onPrimary: Colors.white, // Color del texto sobre el color principal
              surface: Color.fromARGB(255, 255, 255, 255), // Fondo de la superficie del DatePicker
              onSurface: Colors.black, // Color del texto sobre la superficie
            ),
            dialogBackgroundColor: Colors.white, // Color del fondo del diálogo
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF2E3B55)),
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: const TextStyle(color: Color(0xFF2E3B55)),
      ),
      validator: validator,
    );
  }

  Widget _buildExpandableTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: null, // Permite que el campo se expanda verticalmente
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF2E3B55)),
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: const TextStyle(color: Color(0xFF2E3B55)),
      ),
      validator: validator,
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF2E3B55)),
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: const TextStyle(color: Color(0xFF2E3B55)),
      ),
      onTap: () => _selectDate(context, controller),
    );
  }
}
