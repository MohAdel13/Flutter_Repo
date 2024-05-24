import 'package:e_commerce/core/style/colors.dart';
import 'package:e_commerce/features/onboarding/methods/onboarding_submit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/page_view_model.dart';
import '../widgets/onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();

  List<PageViewModel> pages = [
    PageViewModel(
      image: Image.asset("assets/images/onboarding1.png"),
      body: "Discover a world of convenience and endless choices  Get ready to experience the best of online shopping right at your fingertips ",
      title: "Shop From your favorite store"
    ),

    PageViewModel(
        image: Image.asset("assets/images/onboarding2.png"),
        body: "Discover a world of convenience and endless choices  Get ready to experience the best of online shopping right at your fingertips ",
        title: "Get IT Delivered"
    ),

    PageViewModel(
        image: Image.asset("assets/images/onboarding3.png"),
        body: "Discover a world of convenience and endless choices  Get ready to experience the best of online shopping right at your fingertips ",
        title: "Flexible payment"
    ),
  ];

  bool lastPage = false;

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mainColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: mainColor,
          statusBarIconBrightness: Brightness.light
        ),
        actions: [
          TextButton(
            onPressed: (){
              submit(context);
            },
            child: const Text('SKIP', style: TextStyle(color: Colors.white),)
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          color: mainColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80.0,),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(90.0))
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: PageView.builder(
                            itemBuilder: (BuildContext context, int index) => OnBoardingItem(pages[index]),
                            itemCount: pages.length,
                            physics: const BouncingScrollPhysics(),
                            controller: pageController,
                            
                            onPageChanged: (int index){
                              if(index < pages.length - 1){
                                setState((){
                                  lastPage = false;
                                });
                              }
                              else
                              {
                                setState((){
                                  lastPage = true;
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            SmoothPageIndicator(
                              controller: pageController,
                              count: pages.length,
                              effect: ScrollingDotsEffect(
                                  dotHeight: 10.0,
                                  dotWidth: 10.0,
                                  dotColor: Colors.grey,
                                  activeDotColor: mainColor
                              ),
                            ),
                            const Spacer(),
                            FloatingActionButton(
                              onPressed: (){
                                if(lastPage){
                                  submit(context);
                                }
                                else{
                                  pageController.animateToPage(
                                    pageController.page!.toInt() + 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              backgroundColor: mainColor,
                              child: const Icon(Icons.arrow_forward_ios, color: Colors.white,),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 20.0,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

