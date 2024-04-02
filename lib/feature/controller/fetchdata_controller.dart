

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_booking_app/feature/repository/fetchdata_repository.dart';

import '../../model/restuarant_model.dart';

final fetchDataControllerProvider = StateNotifierProvider<FetchDataController,bool>((ref)  {
  return FetchDataController(repository: ref.read(fetchDataRepositoryProvider));
});

final fetchDataStreamProvider = FutureProvider.autoDispose<Restaurants>((ref)  {
  return ref.watch(fetchDataControllerProvider.notifier).fetchRestaurants();
});

class FetchDataController extends StateNotifier<bool>{
  FetchDataRepository _repository;
  FetchDataController({required FetchDataRepository repository}):_repository=repository,super(false);

  Future <Restaurants> fetchRestaurants() async {
    return _repository.fetchRestaurants();
    }

}