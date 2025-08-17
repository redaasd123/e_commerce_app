import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/feature/home/domain/entity/image_entity.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageProductCubit extends Cubit<List<ImageEntity>> {
  ImageProductCubit() : super([]);

  Future<void> addImage(String url, num price) async {
    final hasInternet = await _checkInternet();
    if (!hasInternet) {
      // هنا هترجع تحكم الرسالة من ال UI
      return;
    }
    emit([...state, ImageEntity(imageUrl: url, price: price)]);
  }

  Future<void> removeImageByUrl(String url) async {
    final hasInternet = await _checkInternet();
    if (!hasInternet) {
      // هنا برضو هترجع تحكم الرسالة من ال UI
      return;
    }
    final updatedList = state.where((img) => img.imageUrl != url).toList();
    emit(updatedList);
  }

  Future<bool> _checkInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

