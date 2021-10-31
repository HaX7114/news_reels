import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/src/extensions.dart';
import 'package:news_reels/AppCubit/app_cubit.dart';
import 'package:news_reels/AppCubit/states.dart';
import 'package:news_reels/Consts.dart';
import 'package:news_reels/MyWidgets/MyText.dart';
import 'package:news_reels/MyWidgets/my_text_field.dart';
import 'package:news_reels/Shared/article_view.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  PageController pageController = PageController();

  static TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){

        },
        builder: (context, state){
          AppCubit appCubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0.0,
                title: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: MyTextField(
                    onChange: (value){
                      appCubit.getSearchDataFromAPI(textController.text);
                      pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.linear);
                    },
                    hintText: context.localeString('SearchForNews'),
                    hintTextColor: Colors.white38,
                    borderColor: Colors.transparent,
                    validatorText: context.localeString('Validator'),
                    textController: textController,
                    prifixIcon: CupertinoIcons.search,
                  ),
                ),
                backgroundColor: Colors.black38,
                leading: IconButton(
                  onPressed: ()async{
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                      CupertinoIcons.back
                  ),
                ),
              ),
              body: ArticleView(appCubit: appCubit, pageController: pageController,isInSearchPage: true,)
            ),
          );
        },
      ),
    );
  }
}
