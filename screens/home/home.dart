import 'package:flutter/material.dart';
import 'package:projcet_canhan/constants/routes.dart';
import 'package:projcet_canhan/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:projcet_canhan/models/category_model/category_model.dart';
import 'package:projcet_canhan/models/product_models/product_models.dart';
import 'package:projcet_canhan/screens/product_details/product_details.dart';
import 'package:projcet_canhan/widgets/top_titles/top_titles.dart';


class Home extends StatefulWidget {
  const Home({super.key}); 

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList()async{
   setState(() {
     isLoading = true;
   });
   categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
   productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
   productModelList.shuffle();
   setState(() {
     isLoading = false;
   });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
      ?Center(child: Container(
         height:100,
         width: 100,
         alignment: Alignment.center,
         child: CircularProgressIndicator(),
       ),
      ) 
      : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopTitlles(subtitle: "", title: "E Commerce"),
              TextFormField(
                decoration: const InputDecoration(hintText: "Search..."),
                ),
                 const SizedBox(
                  height: 24.0,
                 ),
                 const Text(
                  "Phân Loại",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
                ],
              ),
            ),
            categoriesList.isEmpty
            ? Center(
              child: Text("Categories is empty"),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoriesList
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),           
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(e.image),
                      ),
                    ),
                  ),
                )
                .toList(),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Padding(
              padding: EdgeInsets.only(top:12.0, left:12.0),
              child: Text(
                "Sản Phẩm Tốt",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            productModelList.isEmpty
            ? Center(
              child: Text("Best Product is empty"),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                primary: false,
                itemCount: productModelList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.9,
                  crossAxisCount: 2), 
                itemBuilder: (ctx, index){
                  ProductModel singleProduct = productModelList[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Image.network(
                          singleProduct.image, 
                         height: 60,
                         width: 60,),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          singleProduct.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Price: \$${singleProduct.price}"),
                        const SizedBox(
                          height: 6.0,
                        ),
                        SizedBox(
                          height: 45,
                          width: 140,
                          child: OutlinedButton(
                            onPressed: (){
                              Routes.instance.push(
                                widget: ProductDetails(
                                  singleProduct:
                                  singleProduct), 
                              context: context);
                            },
                            child: const Text(
                              "Buy",
                           ),
                         ),
                        ),
                    ],
                    ),
                  );
                }),
            ),
            const SizedBox(height: 12.0,),
          ],
        ),
      ),
    );
  }
}
