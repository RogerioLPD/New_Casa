import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget iphone;
  final Widget ipad;
  final Widget macbook;
  final bool? forceIpadList;
  const ResponsiveLayout(
      {Key? key,
      required this.ipad,
      required this.iphone,
      required this.macbook,
      this.forceIpadList = false})
      : super(key: key);

  static int iphoneLimit = 600;
  static int ipadVerticalLimit = 800;
  static int ipadLimit = 1200;

  static bool isIphone(BuildContext context) =>
      MediaQuery.of(context).size.width < iphoneLimit;

  static bool isIpad(BuildContext context) =>
      MediaQuery.of(context).size.width < ipadLimit &&
      MediaQuery.of(context).size.width >= iphoneLimit;

  static bool isMacbook(BuildContext context) =>
      MediaQuery.of(context).size.width >= ipadLimit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < iphoneLimit) {
        return iphone;
      }
      if (constraints.maxWidth > iphoneLimit &&
          constraints.maxWidth < ipadVerticalLimit) {
        if(forceIpadList != null && forceIpadList == true){
          return ipad;
        }else{
          return iphone;
        }
      }

      if (constraints.maxWidth < ipadLimit) {
        return ipad;
      } else {
        return macbook;
      }
    });
  }
}
