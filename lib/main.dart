import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white
  ));
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('it', 'IT')],
      path: 'assets/translations', // <-- change patch to your
      fallbackLocale: Locale('it', 'IT'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'agenda',
      theme: ThemeData(
        primaryColorLight: Colors.white,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);





  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;
  bool lastStatus = true;
  DateTime data = DateTime.now();
  String languageCode = ui.window.locale.languageCode;
  String date ;


  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (100 - kToolbarHeight);
  }

  @override
  void initState() {

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
   // initializeDateFormatting(languageCode);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
   date =  DateFormat('dd MMMM yyyy',languageCode ).format(data);
    return Scaffold(

      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context,isScrolled){
            return <Widget>[
              SliverAppBar(
                backgroundColor: isShrink ? Colors.white : Colors.grey[300],


              expandedHeight: 180,

              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                  title: Text(date),
                  background: Container(
                    decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))),
                  )


              ),
            )];
          },
        body: Container(
          decoration: BoxDecoration(color: Colors.grey[300]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
