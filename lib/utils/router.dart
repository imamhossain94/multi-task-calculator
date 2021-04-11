import 'package:flutter/material.dart';
import 'package:multi_task_calculator/pages/general_calc_page/calculator.dart';
import 'package:multi_task_calculator/pages/home_page/home_page.dart';
import 'package:multi_task_calculator/pages/splash_page.dart';
import 'package:multi_task_calculator/pages/about_page.dart';
import 'package:multi_task_calculator/pages/feedback_page.dart';
import 'package:multi_task_calculator/pages/help_page.dart';
import 'package:multi_task_calculator/pages/update_check_page.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:page_transition/page_transition.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashPage:
      return PageTransition(child: SplashPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case homePage:
      return PageTransition(child: HomePage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case aboutPage:
      return PageTransition(child: AboutPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case feedbackPage:
      return PageTransition(child: FeedbackPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case helpPage:
      return PageTransition(child: HelpPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case updateCheckPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;

    //Calculators
    case generalCalcPage:
      return PageTransition(child: Calculator(), type: PageTransitionType.fade, settings: settings,);
      break;
    case currencyCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case unitCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case discountCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case tipCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case dateCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case fuelEfficiencyCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case fuelCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case healthCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case loanCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case salesTaxCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case savingCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;
    case unitPriceCalcPage:
      return PageTransition(child: UpdateCheckPage(), type: PageTransitionType.fade, settings: settings,);
      break;




    default:
      return null;
  }
}



