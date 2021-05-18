import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-'
    //       '1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C'
    //       '_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.'
    //       '022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-'
    //       'Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  var _showFavoriteOnly = false;

  List<Product> get item {
    if (_showFavoriteOnly) {
      return _items.where((productItem) => productItem.isFavorite).toList();
    }
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favoritesOnly {
    return _items.where((product) => product.isFavorite).toList();
  }

  void showFavoritesOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  Future<void> fetchAndSetProduct([bool filterById = false]) async {
    var url =
        'https://shop-app-5cc61-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url = 'https://shop-app-5cc61-default-rtdb.firebaseio.com/favoriteUser/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(
          Product(
            id: productId,
            title: productData['title'],
            imageUrl: productData['imageUrl'],
            description: productData['description'],
            isFavorite: favoriteData == null ? false : favoriteData[productId] ?? false,
            price: productData['price'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProducts(Product product) async {
    final url =
        'https://shop-app-5cc61-default-rtdb.firebaseio.com/products.json?auth=$authToken&orderBy="creatorId"&equalTo="$userId"';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'creatorId': userId,
        }),
      );
      final newProduct = Product(
        title: product.title,
        price: product.price,
        id: json.decode(response.body)['name'],
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProducts(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    final url =
        'https://shop-app-5cc61-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';

    if (productIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'imageUrl': newProduct.imageUrl,
            'description': newProduct.description,
            'price': newProduct.price,
          }));
      _items[productIndex] = newProduct;
    } else {
      print('....');
    }
    notifyListeners();
  }

  Future<void> deleteProducts(String id) async {
    final url =
        'https://shop-app-5cc61-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    notifyListeners();
    final response = await http.patch(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('could not delete products');
    }
    existingProduct = null;
  }
}
