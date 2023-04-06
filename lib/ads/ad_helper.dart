import 'dart:io';

class AdHelper {
//ca-app-pub-5946802346170399~8142618201
//ios
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5946802346170399/1109433857';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5946802346170399/2061808477';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5946802346170399/1243550822";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5946802346170399/2303096026";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5946802346170399/8108342079";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5946802346170399/9831104392";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get appOpenId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5946802346170399/4629876467";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5946802346170399/6980707638";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}