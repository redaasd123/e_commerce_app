import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/feature/home/domain/entity/image_entity.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageProductCubit extends Cubit<List<ImageEntity>> {
  ImageProductCubit() : super([]);

  void addImage(String url, num price) {
    emit([...state, ImageEntity(imageUrl: url, price: price)]);
  }

  void removeImageByUrl(String url) {
    final updatedList = state.where((img) => img.imageUrl != url).toList();
    emit(updatedList);
  }
}
