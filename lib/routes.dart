import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String home = "/";
  static const String post = "post";
  static const String empresashome = "empresashome";
  static const String style = "style";
  static const String administrador = "administrador";
  static const String especificador = "especificador";
  static const String especificadorup = "especificadorup";
  static const String empresas = "empresas";
  static const String loginview = "loginview";
  static const String splashscreen = "splashscreen";
  static const String loginespecificador = "loginespecificador";
  static const String loginadministrador = "loginadministrador";
  static const String registerempresas = "registerempresas";
  static const String checagempage = "checagempage";
  static const String homeempresas = "homeempresas ";
  static const String homeespecificador = "homeespecificador";
  static const String cadastro = "cadastro";
  static const String cadastroespecificador = "cadastroespecificador";
  static const String cadastropremio = "cadastropremio";
  static const String homeadministrador = "homeadministrador";
  static const String premios = "premios";
  static const String table = "table";
  static const String extrato = "extrato";
  static const String profile = "perfil";
  static const String menuside = "menuside";
  static const String lancamentos = "lancamentos";
   static const String newlogin = "newlogin";
   static const String company = "company";
   static const String updateespecificador = "updateespecificador";
   
  

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}
