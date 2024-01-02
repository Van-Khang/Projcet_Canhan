import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projcet_canhan/constants/constants.dart';
import 'package:projcet_canhan/models/category_model/category_model.dart';
import 'package:projcet_canhan/models/product_models/product_models.dart';

class FirebaseFirestoreHelper{
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<CategoryModel>> getCategories () async {
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
      .map((e) => CategoryModel.fromJson(e.data()))
      .toList();

    return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

    Future<List<ProductModel>> getBestProducts () async {
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = querySnapshot.docs
      .map((e) => ProductModel.fromJson(e.data()))
      .toList();

    return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
}