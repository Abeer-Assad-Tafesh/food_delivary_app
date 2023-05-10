import 'package:food_delivary_app/models/cart_model.dart';
import 'package:food_delivary_app/models/product_model.dart';
import 'package:get/get.dart';
import '../data/repository/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  static CartController get to => Get.find();
  List<CartModel> storedCartItems = [];

  // when press Add to cart btn
  void addItemToCart(ProductModel product, int quantity) {
    //if product exists => update it
    if (_items.containsKey(product.id)) {
      int _totalQuantity = 0;
      _items.update(product.id!, (value) {
        _totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product);
      });
      if (_totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      //if product not exists => create it
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          // print('add item id' + product.id.toString() + ' quantity $quantity');
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product);
        });
      } else {
        Get.snackbar('Note', 'You should at least add an item to cart',
            duration: const Duration(seconds: 2));
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  //cart icon work
  int get totalCartItems {
    var totalCartProducts = 0;
    _items.forEach((key, value) {
      totalCartProducts += value.quantity!;
    });
    return totalCartProducts;
  }

  // cart page
  List<CartModel> get getItems {
    // (e) is key and value (int, CartModel) and we need just the objects
    return _items.entries.map((e) => e.value).toList();
  }

  double get totalCartPrice{
    double total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  // below get and set methods is for local stored cart items in cart page
  List<CartModel> getCart(){
    setCart = cartRepo.getCartList();
    return storedCartItems;
  }

  set setCart(List<CartModel> items){
    storedCartItems = items;
    for(int i =0; i<storedCartItems.length; i++){
      _items.putIfAbsent(storedCartItems[i].product!.id!,
              () => storedCartItems[i]);
    }
  }

  void addItemsToHistory(){
    print('============== items added to history ================');
    cartRepo.addToCartHistoryList();
    clear();
  }

  List<CartModel> getHistoryCartItems(){
    return cartRepo.getCartHistoryList();
  }

  void clear(){
    _items = {};
    update();
  }

  // these products comes from (one more) button in cart history page
  // to render them in cart page
  set setItems(Map<int, CartModel> items){
    _items = {};
    _items = items;
  }

  // store the (one more) products locally
  void addOneMoreProductsToCart(){
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory(){
    cartRepo.removeHistoryCart();
    update();
  }
}
