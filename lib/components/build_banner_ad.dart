import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:multi_task_calculator/services/shared_pref_services.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';


class BuildBannerAd extends StatefulWidget {
  @override
  _BuildBannerAdState createState() => _BuildBannerAdState();
}

class _BuildBannerAdState extends State<BuildBannerAd> {
  BannerAd _bannerAd;
  bool purchaseStatus;

  @override
  void initState() {
    purchaseStatus = getAppPurchasedStatus();
    if(!purchaseStatus){
      initBannerAds();
    }
    super.initState();
  }

  @override
  void dispose() {
    if(!purchaseStatus){
      _bannerAd?.dispose();
      _bannerAd = null;
    }
    super.dispose();
  }

  void initBannerAds() {
    _bannerAd = BannerAd(
      adUnitId: id_banner,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    _bannerAd?.load();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);

    AdWidget adWidget;
    if(!purchaseStatus){
      adWidget = AdWidget(ad: _bannerAd);
    }

    return !purchaseStatus?Container(
      alignment: Alignment.center,
      child: adWidget,
      width: _bannerAd.size.width.toDouble(),
      height: _bannerAd.size.height.toDouble(),
      color: Colors.transparent,
    ):SizedBox();
  }
}
