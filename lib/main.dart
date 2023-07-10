import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nucleo/cadastro.dart';
import 'package:nucleo/login/login_admistrador/cadastro_premio.dart';
import 'package:nucleo/login/login_admistrador/home_administrador.dart';
import 'package:nucleo/login/login_especificador/home_espeficador.dart';
import 'package:nucleo/login/login_especificador/profile_especificador.dart';
import 'package:nucleo/login/login_especificador/releases_especificador.dart';
import 'package:nucleo/login/login_especificador/teste.dart';
import 'package:nucleo/login/login_empresas/checagem_empresas.dart';
import 'package:nucleo/login/login_admistrador/login_administrador.dart';
import 'package:nucleo/login/login_empresas/lancamentos.dart';
import 'package:nucleo/login/login_empresas/login_empresas.dart';
import 'package:nucleo/login/login_admistrador/register_empresas.dart';
import 'package:nucleo/login/login_admistrador/cadastro_especificador.dart';
import 'package:nucleo/login/login_especificador/login_especificador.dart';
import 'package:nucleo/pages/newlogin.dart';

import 'package:nucleo/pages/pages.dart';
import 'package:nucleo/pages/patner/partner_enterprises.dart';
import 'package:nucleo/pages/premios/premios.dart';
import 'package:nucleo/pages/splash_screen.dart';
import 'package:nucleo/responsive.dart';
import 'package:nucleo/routes.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale("pt", "BR")],
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.grey,
        primaryColor: Colors.white,
      ),
      builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      initialRoute:  kIsWeb ? Routes.home : Routes.splashscreen,
      onGenerateRoute: (RouteSettings settings) {
        return Routes.fadeThrough(settings, (context) {
          switch (settings.name) {
            case Routes.home:
              return const ListPage();
            case Routes.post:
              return const PostPage();
            case Routes.style:
              return const TypographyPage();
            case Routes.loginview:
              return const LoginView();
            case Routes.splashscreen:
              return const SplashScreen();
            case Routes.loginespecificador:
              return const LoginEspecificador();
            case Routes.homeespecificador:
              return HomeEspecificador();
            case Routes.loginadministrador:
              return const LoginAdministrador();
            case Routes.registerempresas:
              return const RegisterEmpresas();
            case Routes.checagempage:
              return const ChecagemPage();
            case Routes.homeempresas:
              return const HomeEmpresas();
            case Routes.cadastroespecificador:
              return const CadastroEspecificador();
            case Routes.cadastropremio:
              return CadastroPremio();
            case Routes.homeadministrador:
              return const HomeAdministrador();
            case Routes.extrato:
              return ReleasesEspecificador();
            case Routes.profile:
              return ProfileEspecificador();
              case Routes.newlogin:
              return const LoginHome();
               case Routes.company:
              return const EmpresaCadastroScreen();

            case Routes.premios:
              return RewardsPage();
            case Routes.empresas:
              return PartnerEnterprises();

            case Routes.menuside:
              return const MenuSide();
            case Routes.lancamentos:
              return const HomeEmpresas();

            default:
              return const SizedBox.shrink();
          }
        });
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
