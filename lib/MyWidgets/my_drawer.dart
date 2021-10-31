import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_reels/AppCubit/app_cubit.dart';
import 'package:news_reels/AppCubit/states.dart';
import 'package:news_reels/Consts.dart';
import 'package:news_reels/MyWidgets/MyText.dart';
import 'package:news_reels/Screens/home_page.dart';

dynamic currentSelectedCountry;
dynamic currentSelectedCategory;

class MyDrawer extends StatelessWidget {
  final AppCubit appCubitHomePage;
  MyDrawer({Key? key , required this.appCubitHomePage}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    const K_hhSpace = SizedBox(width: 10.0,);

    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){

        },
        builder: (context, state){
          AppCubit appCubit = AppCubit.get(context);
          return BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0
            ),
            child: Container(
              width: 260,
              height: HomePage.deviceHeight,
              color: Colors.black.withOpacity(0.7),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 20.0,top: 50.0,end: 5.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(text: 'News reels', size: 20.0,color: K_whiteColor,),
                      K_vSpace,
                      //Categories
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: appCubit.categories.length,
                          itemBuilder: (context, index){
                            return TextButton(
                                style: ButtonStyle(
                                    backgroundColor: appCubit.categories[index].color,
                                    shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder())
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  appCubit.lastIndexCategories = appCubit.selectedIndexCategories;
                                  appCubit.selectedIndexCategories = index;
                                  appCubit.changeSideMenuButtonColorOnClickCategories(index);
                                  currentSelectedCategory = appCubit.categories[index].newsAPIElement;
                                  appCubitHomePage.getDataFromAPI(
                                      newsCategory: currentSelectedCategory,
                                      newsCountry: currentSelectedCountry
                                  );
                                  //Control the page and navigate to the first element with animation
                                  HomePage.pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.linear);

                                },
                                child: Row(
                                  children: [
                                    Icon(appCubit.categories[index].icon,color: K_whiteColor,size: 25.0,),
                                    K_hhSpace,
                                    MyText(text: appCubit.categories[index].name, size: 18.0 ,color: K_whiteColor,),
                                  ],
                                ),
                            );
                          }
                      ),
                      K_vSpace,
                      MyText(text: context.localeString('Countries'), size: 20.0,color: K_whiteColor,),
                      K_vSpace,
                      //Countries
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: appCubit.countries.length,
                          itemBuilder: (context, index){
                            return TextButton(
                              style: ButtonStyle(
                                  backgroundColor: appCubit.countries[index].color,
                                  shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder())
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                                appCubit.lastIndexCountries = appCubit.selectedIndexCountries;
                                appCubit.selectedIndexCountries = index;
                                appCubit.changeSideMenuButtonColorOnClickCountries(index);
                                currentSelectedCountry = appCubit.countries[index].newsAPIElement;
                                appCubitHomePage.getDataFromAPI(
                                    newsCountry: currentSelectedCountry,
                                    newsCategory: currentSelectedCategory
                                );
                                //Control the page and navigate to the first element with animation
                                HomePage.pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.linear);
                              },
                              child: Row(
                                children: [
                                  appCubit.countries[index].icon,
                                  K_hhSpace,
                                  MyText(text: appCubit.countries[index].name, size: 18.0 ,color: K_whiteColor,),
                                ],
                              ),
                            );
                          }
                      ),
                      //Languages
                      K_vSpace,
                      MyText(text: context.localeString('ChangeLanguage'), size: 20.0,color: K_whiteColor,),
                      K_vSpace,
                      TextButton(
                        onPressed: () {
                          if(context.currentLocale.toString() == 'ar'){
                            context.changeLocale('en');
                          }else{
                            context.changeLocale('ar');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyText(text: context.localeString('EN'), size: 16.0,color: K_whiteColor,),
                            const Icon(Icons.arrow_left_sharp,color: K_whiteColor,size: 25.0,),
                            const Icon(Icons.translate_rounded,color: K_whiteColor,size: 25.0,),
                            const Icon(Icons.arrow_right_sharp,color: K_whiteColor,size: 25.0,),
                            MyText(text: context.localeString('AR'), size: 16.0,color: K_whiteColor,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
