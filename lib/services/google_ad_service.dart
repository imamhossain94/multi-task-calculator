// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:multi_task_calculator/services/shared_pref_services.dart';
//
// class GoogleAdService {
//
//   static InterstitialAd interstitialAd;
//   static bool interstitialReady = false;
//
//   static RewardedAd rewardedAd;
//   static bool rewardedReady = false;
//
//
//   void initInterstitialAd() async {
//     if(!getAppPurchasedStatus()){
//       MobileAds.instance.initialize().then((InitializationStatus status) {
//         MobileAds.instance
//             .updateRequestConfiguration(RequestConfiguration(
//             tagForChildDirectedTreatment:
//             TagForChildDirectedTreatment.unspecified))
//             .then((void value) {
//           createInterstitialAd();
//         });
//       });
//     }
//   }
//
//   void initRewardedAd() async {
//     if(!getAppPurchasedStatus()){
//       MobileAds.instance.initialize().then((InitializationStatus status) {
//         MobileAds.instance
//             .updateRequestConfiguration(RequestConfiguration(
//             tagForChildDirectedTreatment:
//             TagForChildDirectedTreatment.unspecified))
//             .then((void value) {
//           createRewardedAd();
//         });
//       });
//     }
//   }
//
//   void createInterstitialAd() {
//     interstitialAd ??= InterstitialAd(
//       adUnitId: InterstitialAd.testAdUnitId,
//       request: AdRequest(),
//       listener: AdListener(
//         onAdLoaded: (Ad ad) {
//           print('${ad.runtimeType} loaded.');
//           interstitialReady = true;
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('${ad.runtimeType} failed to load: $error.');
//           ad.dispose();
//           interstitialAd = null;
//           createInterstitialAd();
//         },
//         onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
//         onAdClosed: (Ad ad) {
//           print('${ad.runtimeType} closed.');
//           ad.dispose();
//           createInterstitialAd();
//         },
//         onApplicationExit: (Ad ad) =>
//             print('${ad.runtimeType} onApplicationExit.'),
//       ),
//     )..load();
//   }
//
//   void createRewardedAd() {
//     rewardedAd ??= RewardedAd(
//       adUnitId: RewardedAd.testAdUnitId,
//       request: AdRequest(),
//       listener: AdListener(
//           onAdLoaded: (Ad ad) {
//             print('${ad.runtimeType} loaded.');
//             rewardedReady = true;
//
//           },
//           onAdFailedToLoad: (Ad ad, LoadAdError error) {
//             print('${ad.runtimeType} failed to load: $error');
//             ad.dispose();
//             rewardedAd = null;
//             createRewardedAd();
//           },
//           onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
//           onAdClosed: (Ad ad) {
//             print('${ad.runtimeType} closed.');
//             ad.dispose();
//             createRewardedAd();
//           },
//           onApplicationExit: (Ad ad) =>
//               print('${ad.runtimeType} onApplicationExit.'),
//           onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
//
//             setAdFreeTime(DateTime.now().toString());
//             setAppPurchasedStatus(true);
//
//             print(
//               '$RewardedAd with reward $RewardItem(${reward.amount}, ${reward.type})',
//             );
//           }),
//     )..load();
//   }
//
// }
//
//
// Future<bool> showInterstitialAd() async{
//   if(!getAppPurchasedStatus()){
//     if (!GoogleAdService.interstitialReady) return false;
//     GoogleAdService.interstitialAd.show();
//     GoogleAdService.interstitialReady = false;
//     GoogleAdService.interstitialAd = null;
//     GoogleAdService.interstitialAd?.dispose();
//     return true;
//   }else{
//     return false;
//   }
// }
//
// Future<bool> showRewardedAd() async{
//   if(!getAppPurchasedStatus()){
//     if (!GoogleAdService.rewardedReady) return false;
//     GoogleAdService.rewardedAd.show();
//     GoogleAdService.rewardedReady = false;
//     GoogleAdService.rewardedAd = null;
//     GoogleAdService.rewardedAd?.dispose();
//     return true;
//   }else{
//     return false;
//   }
// }