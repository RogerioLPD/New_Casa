import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nucleo/components/blog.dart';
import 'package:nucleo/components/color.dart';
import 'package:nucleo/controllers/administrator_controller.dart';

import '../../routes.dart';

class CadastroPremio extends StatefulWidget {
  const CadastroPremio({Key? key}) : super(key: key);

  @override
  State<CadastroPremio> createState() => _CadastroPremioState();
}

class _CadastroPremioState extends State<CadastroPremio> {
  final AdministradorController _controller = AdministradorController();
  bool isActive = false;
  final _formKey = GlobalKey<FormState>();
  final _pointsController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<PlatformFile>? _paths;

  void pickFiles() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      log('Unsupported operation' + e.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: MenuBar1(),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .0,
                ),
                Image.asset(
                  'assets/images/Nucleo.png',
                  width: 460,
                  height: 240,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  child: const Text('UPLOAD FILE'),
                  onPressed: () async {
                    pickFiles();
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  inputFormatters: [
                    //LengthLimitingTextInputFormatter(20),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s,.; àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇßØøÅåÆæœ]')),
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Nome do premio',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.badge,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite o nome do premio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _pointsController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\s.]')),
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Quantidade de pontos',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.attach_money,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite a quantidade de pontos';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _descriptionController,
                  inputFormatters: [
                    //LengthLimitingTextInputFormatter(20),
                     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s,.; àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇßØøÅåÆæœ]')),
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Descrição do Premio',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.description,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite a descrição';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool cadastro = await _controller.createRearward(
                          points: _pointsController.text,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          bytes: _paths!.first.bytes,
                        );
                        if (cadastro) {
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Erro ao fazer cadastro')),
                          );
                        }
                      }
                    },
                    child: Text(
                      'REGISTRAR',
                      style: GoogleFonts.montserrat(
                          color: textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.homeadministrador),
                    child: Text(
                      'VOLTAR',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF3A3A3A),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
