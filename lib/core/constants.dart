import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

abstract class AppConstants {
  static const String baseUrl = 'http://192.168.1.103:8000/api/';

  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String logout = 'auth/logout';
  static const String me = 'auth/me';

  static const String getAllProposedSystem = 'ProposedSystem/showAll';

  static const String showAllPrevJobs = 'PreviousJobs/showAll';
  static const String searchByTitlePrevJobs = 'PreviousJobs/searchByTitle';
  static const String showDetailesPrevJobs = 'PreviousJobs/show/';

  static const String showAllProducts = 'Products/showAll';
  static const String searchProductById = 'Products/search';
  static const String detailesProduct = 'Products/show';

  static const Color backgroundColor = Color.fromRGBO(24, 24, 32, 1);
  static const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  static const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  static const Color gradient3 = Color.fromRGBO(109, 71, 58, 1);
  static const Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  static const Color whiteColor = Colors.white;
  static Color blueColor = hexToColor('#044586');
  static HexColor orangeColor = HexColor('#f39709');
  static HexColor yellowColor = HexColor('#fee205');
  // static Color blueColorColor = colorFromHex(blueColor as String);
  static Color colorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static Color hexToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor =
          "FF" + hexColor; // 8-char with full opacity if only 6-char provided
    }
    return Color.fromRGBO(
      int.parse(hexColor.substring(2, 4), radix: 16),
      int.parse(hexColor.substring(4, 6), radix: 16),
      int.parse(hexColor.substring(6, 8), radix: 16),
      int.parse(hexColor.substring(0, 2), radix: 16) / 255.0,
    );
  }
}
