import 'dart:developer';


import 'package:brasil_fields/brasil_fields.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nucleo/components/color.dart';
import 'package:nucleo/components/components.dart';
import 'package:nucleo/controllers/administrator_controller.dart';

import '../../routes.dart';

class RegisterEmpresas extends StatefulWidget {
  const RegisterEmpresas({Key? key}) : super(key: key);

  @override
  State<RegisterEmpresas> createState() => _RegisterEmpresasState();
}

class _RegisterEmpresasState extends State<RegisterEmpresas> {
  final AdministradorController _controller = AdministradorController();
  bool isActive = false;
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _seguimentoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _celularController = TextEditingController();
  final _emailController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _senhaController = TextEditingController();
  final _senhaCController = TextEditingController();
  bool visivelSenha = true;
  bool visivelCSenha = true;
  List<PlatformFile>? _paths;

  var regexTextAnNumber = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇßØøÅåÆæœ]'));
  var regexTextOnly = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇßØøÅåÆæœ]'));
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
    } on PlatformException catch (e) {
      log('Unsupported operation$e');
    } catch (e) {
      log(e.toString());
    }
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
                  child: const Text('Inserir Logo'),
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
                        return ("Cpf Cnpj não pode estar vazio");
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
                        ))),
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
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _seguimentoController,
                  inputFormatters: [
                    //LengthLimitingTextInputFormatter(20),
                    regexTextAnNumber
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Seguimento',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.segment,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu Segmento';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _telefoneController,
                  inputFormatters: [
                    //LengthLimitingTextInputFormatter(20),
                    regexNumberOnly
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Telefone',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.phone,
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
                  keyboardType: TextInputType.text,
                  controller: _celularController,
                  inputFormatters: [
                    //LengthLimitingTextInputFormatter(20),
                    regexNumberOnly
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Celular',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.phone_android,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu Celular';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _enderecoController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(120),
                          regexTextAnNumber
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Endereço',
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: Icon(
                            Icons.place,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite seu Endereço';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _numeroController,
                        inputFormatters: [
                          //LengthLimitingTextInputFormatter(20),
                          regexNumberOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Numero',
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: Icon(
                            Icons.place,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite seu Endereço';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _bairroController,
                        inputFormatters: [
                          //LengthLimitingTextInputFormatter(20),
                          regexTextAnNumber
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Bairro',
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: Icon(
                            Icons.place,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite seu Bairro';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _cidadeController,
                        inputFormatters: [
                          //LengthLimitingTextInputFormatter(20),
                          regexTextAnNumber
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Cidade',
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: Icon(
                            Icons.place,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite seu Cidade';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _estadoController,
                        inputFormatters: [
                          //LengthLimitingTextInputFormatter(20),
                          regexTextAnNumber
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Estado',
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: Icon(
                            Icons.place,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite seu estado';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
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
                        bool cadastro = await _controller.createEnterprise(
                          name: _nomeController.text,
                          cpf: _cpfController.text.trim(),
                          seguimento: _seguimentoController.text,
                          telefone: _telefoneController.text,
                          celular: _celularController.text,
                          email: _emailController.text,
                          endereco: _enderecoController.text,
                          numero: _numeroController.text,
                          bairro: _bairroController.text,
                          cidade: _cidadeController.text,
                          password: _senhaController.text,
                          estado: _estadoController.text,
                          bytes: _paths!.first.bytes,
                        );
                        print("CADASTRO ${cadastro}");
                        if (cadastro) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamedAndRemoveUntil(context, Routes.registerempresas, (route) => false);
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
                  height: 60,
                ),
                // RichText(
                //   text: TextSpan(children: [
                //     TextSpan(
                //       text: "Já tem uma conta? Faça o Login ",
                //       recognizer: TapGestureRecognizer()
                //         ..onTap = () =>
                //             Navigator.pushNamed(context, Routes.loginview),
                //       style: GoogleFonts.montserrat(
                //           color: textPrimary,
                //           fontWeight: FontWeight.w700,
                //           fontSize: 13),
                //     ),
                //   ]),
                // ),
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
