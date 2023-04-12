import 'package:food_delivary_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class PopularProductControllers extends GetxController{

  final PopularProductRepo popularFoodRepo;
  PopularProductControllers({required this.popularFoodRepo});
  List<dynamic> _popularProductList = [];

  // a simple method to return the list from ui, because the above one is private
  List<dynamic> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async{
    // response is json
    Response response = await popularFoodRepo.getPopularProductList();
    if(response.statusCode == 200){
      print('got products');
      _popularProductList = [];
      // it takes a list of objects (food/products)
      // response.body is a json(map)
      // .products => is to access _products
      _popularProductList.addAll(Product.fromJson(response.body).products);
      update(); // instead of setState(){}
    }else{

    }
  }
}