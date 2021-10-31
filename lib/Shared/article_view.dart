import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/src/extensions.dart';
import 'package:news_reels/AppCubit/app_cubit.dart';
import 'package:news_reels/Consts.dart';
import 'package:news_reels/MyWidgets/MyText.dart';
import 'package:news_reels/MyWidgets/article_container.dart';
import 'package:news_reels/MyWidgets/my_drawer.dart';
import 'package:news_reels/Screens/search_page.dart';

class ArticleView extends StatelessWidget {
  final AppCubit appCubit;
  final pageController;
  final bool isInSearchPage;
  const ArticleView({Key? key,required this.appCubit,required this.pageController,required this.isInSearchPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: appCubit.articles.isNotEmpty ,
      fallback: (context) => Center(
        child: isInSearchPage? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.search_circle_fill,
              color: Colors.white30,
              size: 70.0,
            ),
            K_vSpace,
            MyText(size: 16.0,text: context.localeString('SearchRes'),color: K_whiteColor,fontWeight: FontWeight.w400,),
          ],
        ) : const CircularProgressIndicator()
      ),
      builder: (context) => RefreshIndicator(
        backgroundColor: K_blackColor,
        onRefresh: (){
          if(!isInSearchPage){
            return appCubit.getDataFromAPI(newsCategory: currentSelectedCategory,newsCountry: currentSelectedCountry);
          }
          else{
            return appCubit.getSearchDataFromAPI(SearchPage.textController.text);
          }
        },
        child: PageView.builder(
          controller: pageController,
          itemCount: appCubit.articles.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index){
            return ArticleContainer(
              imageURL: appCubit.articles[index].imageURL,
              articleURL: appCubit.articles[index].articleURL,
              title: appCubit.articles[index].title,
              body: appCubit.articles[index].body,
              webSiteName: appCubit.articles[index].webSiteName,
            );
          },
        ),
      ),
    );
  }
}
