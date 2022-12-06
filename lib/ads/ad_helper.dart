import 'dart:io';

class AdHelper{
  static String get bannerAdUnitId{
    if(Platform.isAndroid){
      return "ca-app-pub-4902959322142372/5271088147";
    }else if(Platform.isIOS){
      return "ca-app-pub-4902959322142372/6253831477";
    }
    else{
      throw UnsupportedError("unsupported Platform");
    }
  }
  
  static String get bannerAdUnitId2{
    if(Platform.isAndroid){
      return "ca-app-pub-4902959322142372/5174955037";
    }else if(Platform.isIOS){
      return "ca-app-pub-4902959322142372/4112073239";
    }
    else{
      throw UnsupportedError("unsupported Platform");
    }
  }

}