import 'package:flutter/material.dart';
import 'package:ttn_app01/src/pages/home_page.dart';
import 'package:ttn_app01/src/services/ttn_service.dart';
import 'package:ttn_app01/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new TtnService())
      ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: miTema,
        title: 'Material App',
        home: HomePage()
      ),
    );
  }
}