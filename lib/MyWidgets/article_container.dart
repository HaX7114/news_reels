import 'package:flutter/material.dart';
import 'package:flutter_locales/src/extensions.dart';
import 'package:news_reels/Consts.dart';
import 'package:news_reels/MyWidgets/MyButton.dart';
import 'package:news_reels/MyWidgets/MyText.dart';
import 'package:news_reels/Screens/article_web_view.dart';
import 'package:news_reels/Screens/home_page.dart';

class ArticleContainer extends StatelessWidget {
  final String imageURL;
  final String articleURL;
  final String webSiteName;
  final String title;
  final String body;

  const ArticleContainer({Key? key,required this.imageURL,required this.articleURL,required this.title,required this.body,required this.webSiteName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeInImage(
            placeholder: const AssetImage('assets/images/black.jpg'),
            image: NetworkImage(imageURL),
            fit: BoxFit.cover,
            height: HomePage.deviceHeight! * 0.7,
            width: HomePage.deviceWidth,
            fadeInCurve: Curves.easeInCubic,
            imageErrorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Center(
                child: MyText(
                  text: context.localeString('CouldNotLoadImg'),
                  fontWeight: FontWeight.w400,
                  color: K_whiteColor,
                  size: 18.0,
                ),
              );
            }
        ),
        Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black,Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.4,0.9]
                )
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Container(),flex: 2,),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 5.0),
                    child: MyText(
                      size: 20.0,
                      color: K_whiteColor,
                      text: title,
                    ),
                  ),
                  K_vSpace,
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 5.0),
                    child: MyText(
                      size: 18.0,
                      color: Colors.grey,
                      showEllipsis: true,
                      fontWeight: FontWeight.w400,
                      text: body,
                    ),
                  ),
                  K_vSpace,
                  MyButton(
                    text: context.localeString('ReadMore'),
                    fillColor: Colors.white.withOpacity(0.2),
                    textColor: K_whiteColor,
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ArticleWebView(url: articleURL,webSiteName: webSiteName,);
                              },
                          )
                      );
                    },
                  )
                ],
              ),
            )
        ),
      ],
    );
  }
}
