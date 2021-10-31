import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_reels/AppCubit/bloc_observer.dart';
import 'package:news_reels/AppCubit/states.dart';
import 'package:news_reels/Consts.dart';
import 'package:news_reels/Screens/home_page.dart';
import 'package:news_reels/news_api.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  List<String> localeNames = ['en','ar'];//Get json files

  await Locales.init(localeNames);
  NewsAPI.initializeAPI();
  Bloc.observer = MyBlocObserver();//To observe bloc states
  runApp(const MyApp());
}

BuildContext? mainContext;//Used to get the context for local context.localeString('welcome'); functions used in AppCubit

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        title: 'News Reels',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: K_blackColor,
            primarySwatch: Colors.blueGrey,
            appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarBrightness: Brightness.light
                )
            )
        ),
        home: HomePage()
      ),
    );
  }
}