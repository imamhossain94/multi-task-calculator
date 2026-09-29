import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/google_ad_service.dart';
import '../services/shared_pref_services.dart';
import '../utils/screen_config.dart';
/// Bottom banner ad, wrapped in a rounded container so it does not look like a
/// raw platform view glued to the edge of the screen.
class BuildBannerAd extends StatefulWidget {
  const BuildBannerAd({super.key});

  @override
  State<BuildBannerAd> createState() => _BuildBannerAdState();
}

class _BuildBannerAdState extends State<BuildBannerAd> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _suppressed = false;
  bool _didFail = false;

  @override
  void initState() {
    super.initState();
    _suppressed = SharedPrefService.isAdFree;
    if (!_suppressed) _load();
  }

  void _load() {
    final BannerAd ad = BannerAd(
      adUnitId: GoogleAdService.bannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          if (!mounted) return;
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          if (!mounted) return;
          setState(() => _didFail = true);
        },
      ),
    );
    _bannerAd = ad;
    ad.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig.init(context);

    // Reserve no space at all when the ad cannot render, so pages never end up
    // with a mysterious 50px gap.
    if (_suppressed || _didFail || !_isLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 4, 10, 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: SizedBox(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      ),
    );
  }
}
