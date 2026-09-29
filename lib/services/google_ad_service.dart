import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/constant.dart';
import 'shared_pref_services.dart';

/// Owns the AdMob SDK lifecycle and the interstitial queue.
///
/// Debug builds automatically use Google's official *test* ad units so you
/// never risk an AdMob policy strike while developing.
abstract final class GoogleAdService {
  static InterstitialAd? _interstitial;
  static int _loadAttempts = 0;
  static bool _initialised = false;

  static const int maxFailedLoadAttempts = 3;

  /// The AdMob *app* id, for reference / diagnostics.
  static String get appId => kDebugMode ? testAdApp : idMobAppId;

  /// Banner ad unit to use. Debug builds use Google's test unit.
  static String get bannerId => kDebugMode ? testAdBanner : idMobBanner;

  /// Interstitial ad unit to use. Debug builds use Google's test unit.
  static String get interstitialId =>
      kDebugMode ? testInterstitial : idMobInterstitial;

  /// Must be awaited before the first ad request.
  static Future<void> init() async {
    if (_initialised) return;
    await MobileAds.instance.initialize();
    _initialised = true;
    unawaited(createInterstitialAd());
  }

  /// Pre-loads the next interstitial, retrying up to
  /// [maxFailedLoadAttempts] times on failure.
  static Future<void> createInterstitialAd() async {
    if (!_initialised) return;

    await InterstitialAd.load(
      adUnitId: interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitial = ad;
          _loadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitial = null;
          if (_loadAttempts++ < maxFailedLoadAttempts) {
            unawaited(createInterstitialAd());
          }
        },
      ),
    );
  }

  /// Shows an interstitial if one is ready and the tap counter says it's due.
  ///
  /// Returns `true` when an ad was actually shown. Never throws: every failure
  /// path (SDK not initialised, no ad loaded, failed to show) simply returns
  /// `false` and lets navigation continue.
  static Future<bool> showIfDue() async {
    if (!_initialised) return false;
    if (!await SharedPrefService.shouldShowInterstitial()) return false;

    final InterstitialAd? ad = _interstitial;
    if (ad == null) return false;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd dismissed) {
        dismissed.dispose();
        _interstitial = null;
        unawaited(createInterstitialAd());
      },
      onAdFailedToShowFullScreenContent: (
        InterstitialAd failed,
        AdError error,
      ) {
        failed.dispose();
        _interstitial = null;
        unawaited(createInterstitialAd());
      },
    );

    try {
      await ad.show();
    } catch (_) {
      ad.dispose();
      _interstitial = null;
      return false;
    }
    _interstitial = null;
    return true;
  }

  static void dispose() {
    _interstitial?.dispose();
    _interstitial = null;
  }
}

/// Shows an interstitial if one is due.
///
/// Every calculator awaits this before navigating, so the call sites read
/// `await showInterstitialAd();`. Returns `true` when an ad was shown.
Future<bool> showInterstitialAd() => GoogleAdService.showIfDue();
