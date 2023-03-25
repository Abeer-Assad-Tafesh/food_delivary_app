import 'package:food_delivary_app/data/repository/popular_food_repo.dart';
import 'package:get/get.dart';
import '../models/food_product_model.dart';

class PopularFoodControllers extends GetxController{

  final PopularFoodRepo popularFoodRepo;
  PopularFoodControllers({required this.popularFoodRepo});
  List<dynamic> _popularFoodList = [];

  // a simple method to return the list from ui, because the above one is private
  List<dynamic> get popularFoodList => _popularFoodList;

  Future<void> getPopularFoodList() async{
    // response is json
    Response response = await popularFoodRepo.getPopularFoodList();
    if(response.statusCode == 200){
      print('got products');
      _popularFoodList = [];
      // it takes a list of objects (food/products)
      // response.body is a json(map)
      // .products => is to access _products
      _popularFoodList.addAll(Product.fromJson(response.body).products);
      update(); // instead of setState(){}
    }else{

    }
  }
}