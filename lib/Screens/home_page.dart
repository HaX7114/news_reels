import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/src/extensions.dart';
import 'package:news_reels/Consts.dart';
import 'package:news_reels/AppCubit/app_cubit.dart';
import 'package:news_reels/AppCubit/states.dart';
import 'package:news_reels/MyWidgets/MyText.dart';
import 'package:news_reels/MyWidgets/my_drawer.dart';
import 'package:news_reels/Screens/search_page.dart';
import 'package:news_reels/Shared/article_view.dart';
import 'package:news_reels/Shared/functions.dart';
import 'package:news_reels/main.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  //To be able to use in all screens  make them static
  static double? deviceHeight;
  static double? deviceWidth;
  static PageController pageController = PageController();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => AppCubit()..getDataFromAPI(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){

        },
        builder: (context, states){
          AppCubit appCubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              drawer: MyDrawer(appCubitHomePage: appCubit,),
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                title: MyText(text: 'News reels', size: 18.0,color: K_whiteColor,fontWeight: FontWeight.w400,),
                centerTitle: true,
                elevation: 0.0,
                backgroundColor: Colors.black38,
                leading: IconButton(
                  onPressed: ()async{
                    scaffoldKey.currentState!.openDrawer();
                  },
                  icon: const Icon(
                      CupertinoIcons.bars
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10.0),
                    child: IconButton(
                        onPressed: (){
                          navigateToPage(context, SearchPage());
                        },
                        icon: const Icon(
                          CupertinoIcons.search,
                        ),
                    )
                  )
                ],
              ),
              body: ConditionalBuilder(
                condition: states is! ErrorWhileGetNewsDataState,
                fallback: (context) => RefreshIndicator(
                  backgroundColor: K_blackColor,
                  onRefresh: (){
                    return appCubit.getDataFromAPI(newsCategory: currentSelectedCategory,newsCountry: currentSelectedCountry);
                  },
                  //we put the single scrollview to be able to refresh the page
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Center(
                      child: SizedBox(
                        height: HomePage.deviceHeight!,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              CupertinoIcons.wifi_exclamationmark,
                              color: Colors.white30,
                              size: 60.0,
                            ),
                            K_vSpace,
                            MyText(size: 18.0,text: context.localeString('CheckInternetConnection'),color: K_whiteColor,fontWeight: FontWeight.w400,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                builder: (context) => ArticleView(appCubit: appCubit, pageController: pageController,isInSearchPage: false,)
              )
            ),
          );
        },
      ),
    );
  }
}
