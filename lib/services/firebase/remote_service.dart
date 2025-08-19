import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RMConfigService {
  static final RMConfigService inst = RMConfigService._internal();
  RMConfigService._internal();

  final remoteConfig = FirebaseRemoteConfig.instance;
  bool isSetup = false;

  Future<void> setup() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.fetchAndActivate();
    isSetup = true;
    // checkForUpdate();
  }

  void checkForUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    final latestVersion = RMConfigService.inst.androidVersion;
    final forceUpdate = RMConfigService.inst.forceUpdate;
    final updateUrl = RMConfigService.inst.updateUrlAndroid;

    if (isNewerVersion(currentVersion, latestVersion)) {
      // DialogHelper.showUpdateDialog(forceUpdate, latestVersion, updateUrl);
    }
  }

  bool isNewerVersion(String current, String latest) {
    List<int> c = current.split('.').map(int.parse).toList();
    List<int> l = latest.split('.').map(int.parse).toList();
    for (int i = 0; i < l.length; i++) {
      if (i >= c.length || l[i] > c[i]) return true;
      if (l[i] < c[i]) return false;
    }
    return false;
  }

  String get androidVersion => remoteConfig.getString('android_version');
  bool get forceUpdate => remoteConfig.getBool('force_update');
  String get updateUrlAndroid => remoteConfig.getString('update_url_android');
  int get adFrequency => remoteConfig.getInt('adFrequency');
}
