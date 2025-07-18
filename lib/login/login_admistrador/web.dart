import 'dart:developer';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleo/components/color.dart';
import 'package:nucleo/controllers/administrator_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../routes.dart';

class CadastroEspecificador extends StatefulWidget {
  const CadastroEspecificador({Key? key}) : super(key: key);

  @override
  State<CadastroEspecificador> createState() => _CadastroEspecificadorState();
}

class _CadastroEspecificadorState extends State<CadastroEspecificador> {
  final AdministradorController _controller = AdministradorController();
  bool isActive = false;
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _senhaCController = TextEditingController();
  bool visivelSenha = true;
  bool visivelCSenha = true;
  List<PlatformFile>? _paths;
  /*Uint8List? _selectedBytes;
  PlatformFile? _imageFile;*/

  var regexTextAnNumber = FilteringTextInputFormatter.allow(RegExp(
      r'[a-zA-Z0-9 àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇßØøÅåÆæœ]'));
  var regexTextOnly = FilteringTextInputFormatter.allow(RegExp(
      r'[a-zA-Z àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇßØøÅåÆæœ]'));
  var regexNumberOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  void pickFiles() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;

      /*if (_paths != null) {
      File file = File(_imageFile!.path!);
      _selectedBytes = await file.readAsBytes();*/

      // Exibir a Toast Message após o carregamento da imagem
      Fluttertoast.showToast(
        msg: "IMAGEM CARREGADA COM SUCESSO",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } on PlatformException catch (e) {
      log('Unsupported operation$e');
    } catch (e) {
      log(e.toString());
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void verSenha() {
    setState(() {
      visivelSenha = !visivelSenha;
    });
  }

  void verCSenha() {
    setState(() {
      visivelCSenha = !visivelCSenha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'assets/images/Logo.png',
                  width: 460,
                  height: 240,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  child: const Text('Inserir foto'),
                  onPressed: () async {
                    pickFiles();
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _nomeController,
                  inputFormatters: [
                    //LengthLimitingTextInputFormatter(20),
                    regexTextAnNumber
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Nome ou Razão Social',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.person_outlined,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu nome';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfOuCnpjFormatter()
                  ],
                  autofocus: false,
                  controller: _cpfController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Cpf Cnpj não pode estar vazio";
                    } else if (value.length < 11) {
                      return "Cpf Cnpj deve ter pelo menos 11 dígitos";
                    } else if (!CPFValidator.isValid(value) &&
                        !CNPJValidator.isValid(value)) {
                      return "Cpf Cnpj inválido";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "CPF/CNPJ",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Color(0xFF3A3A3A),
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Digite seu e-mail',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu e-mail';
                    } else if (!RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                        .hasMatch(value)) {
                      return 'Digite um e-mail válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: visivelSenha,
                  controller: _senhaController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Digite sua senha',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(visivelSenha
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        verSenha();
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite sua senha';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: visivelCSenha,
                  controller: _senhaCController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Confirme sua senha',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(visivelCSenha
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        verCSenha();
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirme sua senha';
                    } else if (value != _senhaController.text) {
                      return 'Suas senhas não conferem';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool cpfCnpjExists = await _controller
                            .checkIfCpfCnpjExists(_cpfController.text.trim());

                        if (cpfCnpjExists) {
                          showToast("CPF/CNPJ já cadastrado no sistema");
                        } else {
                          bool cadastro = await _controller.createSpecified(
                            name: _nomeController.text,
                            cpf: _cpfController.text.trim(),
                            email: _emailController.text,
                            password: _senhaController.text,
                            //bytes: _selectedBytes,
                            bytes: _paths!.first.bytes,
                          );
                          if (cadastro) {
                            // ignore: use_build_context_synchronously
                            showToast(
                                "PARABÉNS CADASTRO CONCLUÍDO COM SUCESSO!");
                            Navigator.pushNamedAndRemoveUntil(context,
                                Routes.loginespecificador, (route) => false);
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Erro ao fazer cadastro')),
                            );
                          }
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
                  height: 60,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.loginespecificador),
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
