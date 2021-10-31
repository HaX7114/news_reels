import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_reels/Consts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:news_reels/MyWidgets/MyText.dart';

class ArticleWebView extends StatelessWidget {
  final String url;
  final String webSiteName;

  ArticleWebView({Key? key,required this.url,required this.webSiteName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: MyText(text: webSiteName.length < 15 ? webSiteName : 'News reels', size: 18.0,color: K_whiteColor,fontWeight: FontWeight.w400,),
       centerTitle: true,
       elevation: 0.0,
       backgroundColor: Colors.black38,
       leading: IconButton(
         onPressed: (){
           Navigator.pop(context);
         },
         icon: const Icon(
             CupertinoIcons.back
         ),
       ),
     ),
     body:  WebView(
       initialUrl: url,
     ),
   );
  }
}
