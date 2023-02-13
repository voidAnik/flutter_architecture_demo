import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/Photos.dart';
import 'package:mvvm/repository/home_repository.dart';

import '../locator.dart';
import '../utils/messenger.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepo = getIt<HomeRepository>();

  ApiResponse<List<Photos>> _photoList = ApiResponse.loading();

  get photoList => _photoList;
  setPhotoList(ApiResponse<List<Photos>> response) {
    _photoList = response;
    notifyListeners();
  }

  Future<void> fetchPhotos(BuildContext context) async {
    setPhotoList(ApiResponse.loading());
    debugPrint("fetch photo called");

    _homeRepo.getPhotos_d().then((value) {
      debugPrint(value.toString());
      setPhotoList(ApiResponse.completed(value));
      debugPrint("fetch photo complete");
    }).onError((error, stackTrace) {
      debugPrint("error $error");
      Messenger.flushBarError(error.toString(), context);
      setPhotoList(ApiResponse.error(error.toString()));
    });
  }
}
