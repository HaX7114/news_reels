import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_reels/AppCubit/states.dart';
import 'package:news_reels/Shared/drawer.dart';
import 'package:news_reels/article.dart';
import 'package:news_reels/main.dart';
import 'package:news_reels/news_api.dart';

//For News categories
List backColors = [
  MaterialStateProperty.all<Color>(Colors.white30),
  MaterialStateProperty.all<Color>(Colors.transparent),
  MaterialStateProperty.all<Color>(Colors.transparent),
  MaterialStateProperty.all<Color>(Colors.transparent),
  MaterialStateProperty.all<Color>(Colors.transparent),
  MaterialStateProperty.all<Color>(Colors.transparent),
];


//For countries
List backColorsCountries = [
  MaterialStateProperty.all<Color>(Colors.white30),
  MaterialStateProperty.all<Color>(Colors.transparent),
  MaterialStateProperty.all<Color>(Colors.transparent),
];

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  dynamic defaultBackgroundColor = MaterialStateProperty.all<Color>(Colors.transparent);
  dynamic backgroundColor = MaterialStateProperty.all<Color>(Colors.white30);
  int selectedIndexCategories = 0;//saves the current index value of the selected index in categories
  int lastIndexCategories = 0; //saves the last index value of last selected index in categories
  int selectedIndexCountries = 0;//saves the current index value of the selected index in countries
  int lastIndexCountries = 0; //saves the last index value of last selected index in countries


  List<DrawerObjects> categories = [
    DrawerObjects(name: mainContext!.localeString('Business'), icon: Icons.business_center,color: backColors[0],newsAPIElement: NewsAPI.business),
    DrawerObjects(name: mainContext!.localeString('Entertainment'), icon: CupertinoIcons.gamecontroller_fill,color: backColors[1],newsAPIElement: NewsAPI.entertainment),
    DrawerObjects(name: mainContext!.localeString('Health'), icon: CupertinoIcons.heart_circle_fill,color: backColors[2],newsAPIElement: NewsAPI.health),
    DrawerObjects(name: mainContext!.localeString('Science'), icon: Icons.science_rounded,color: backColors[3],newsAPIElement: NewsAPI.science),
    DrawerObjects(name: mainContext!.localeString('Sports'), icon: Icons.sports,color: backColors[4],newsAPIElement: NewsAPI.sports),
    DrawerObjects(name: mainContext!.localeString('Technology'), icon: Icons.wifi_tethering,color: backColors[5],newsAPIElement: NewsAPI.technology),
  ];

  List<DrawerObjects> countries = [
    DrawerObjects(name: mainContext!.localeString('Egypt'), icon: Image.asset('icons/flags/png/eg.png', package: 'country_icons',height: 25,),color: backColorsCountries[0],newsAPIElement: NewsAPI.egypt),
    DrawerObjects(name: mainContext!.localeString('USA'), icon: Image.asset('icons/flags/png/us.png', package: 'country_icons',height: 18,),color: backColorsCountries[1],newsAPIElement: NewsAPI.usa),
    DrawerObjects(name: mainContext!.localeString('UK'), icon: Image.asset('icons/flags/png/gb.png', package: 'country_icons',height: 18,),color: backColorsCountries[2],newsAPIElement: NewsAPI.uk),
  ];

  changeSideMenuButtonColorOnClickCategories(index)
  {
    if(selectedIndexCategories == index)
      {
        categories[selectedIndexCategories].color = backgroundColor;
        categories[lastIndexCategories].color = defaultBackgroundColor;
        backColors.clear();
        for(int i = 0; i < 6 ; i++)
          {
            if(i == selectedIndexCategories) {
              backColors.add(backgroundColor);
            } else {
              backColors.add(defaultBackgroundColor);
            }
          }
        emit(ColorChangedState());

      }
  }

  changeSideMenuButtonColorOnClickCountries(index)
  {
    if(selectedIndexCountries == index)
    {
      countries[selectedIndexCountries].color = backgroundColor;
      countries[lastIndexCountries].color = defaultBackgroundColor;
      backColorsCountries.clear();
      for(int i = 0; i < 3 ; i++)
      {
        if(i == selectedIndexCountries) {
          backColorsCountries.add(backgroundColor);
        } else {
          backColorsCountries.add(defaultBackgroundColor);
        }
      }
      emit(ColorChangedState());

    }
  }

  //News API

  List<Article> articles = [];//Saves the articles
  Response? response;

  Future<void> getDataFromAPI({newsCategory,newsCountry}) async
  {
    response = await NewsAPI.dio!.get(
        NewsAPI.method,
        queryParameters: {
          'country' : newsCountry?? NewsAPI.egypt,
          'category' : newsCategory?? NewsAPI.business,
          'apiKey' : NewsAPI.apiKey,
        }
    ).catchError((error){
      print(error);
      emit(ErrorWhileGetNewsDataState());
    });
    //Adding data to articles list
    _addToArticlesList();
    //Then update the screen
    emit(GetNewsDataState());

  }

  Future<void> getSearchDataFromAPI(searchKeyWord) async
  {
    response = await NewsAPI.dio!.get(
        NewsAPI.method,
        queryParameters: {
          'q' : searchKeyWord,
          'sortBy' : 'publishedAt',
          'apiKey' : NewsAPI.apiKey
        }
    ).catchError((error){
      print(error);
      emit(ErrorWhileGetNewsDataState());
    });
    //Adding data to articles list
    _addToArticlesList();
    //Then update the screen
    emit(GetSearchNewsDataState());

  }

  void _addToArticlesList()
  {
    //Clear the list to avoid duplicating
    articles.clear();
    for(int i = 0; i < response!.data['articles'].length ; i++)
    {
      //Check that the data is not null
      if(response!.data['articles'][i]['urlToImage'] != null && response!.data['articles'][i]['url'] != null
          &&response!.data['articles'][i]['title'] != null && response!.data['articles'][i]['description'] != null
          &&response!.data['articles'][i]['author'] != null
      )
      {
        articles.add(
          Article(
              imageURL: response!.data['articles'][i]['urlToImage'],
              articleURL: response!.data['articles'][i]['url'],
              title: response!.data['articles'][i]['title'],
              body: response!.data['articles'][i]['description'],
              webSiteName:  response!.data['articles'][i]['author']
          ),
        );
      }
    }
  }

  //Change app language

  bool isChangedToAr = false;

  changeAppLanguage()
  {
    isChangedToAr = !isChangedToAr;
    emit(ChangeLanguageState());
  }



}

