import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/constants/utils.dart';

import 'package:flutter/material.dart';

import 'package:siento_shop/models/product.dart';
import 'package:siento_shop/components/widgets/loader.dart';
import 'package:siento_shop/pages/admin/services/admin_services.dart';
import 'package:siento_shop/pages/account/widgets/single_product.dart';
import 'package:siento_shop/pages/admin/screens/add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products = [];
  final AdminServices adminServices = AdminServices();

  //goto add product screen
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  //fetch all products
  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  //ISSUE : we want to show loader when products == null, but when the admin has not added any products we are showing
  //"Add some products to sell"
  //ensure loader also works when the producs are actually added
  //right now  it looks like the Loader is not shown because the list is empty and the text is shown
  //check whats the issue
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return products == null
        ? const Loader()
        : Scaffold(
            appBar: GlobalVariables.getAdminAppBar(
              context: context,
              title: "Posts Screen",
            ),
            body: products == null || products!.isEmpty
                //if no products are added by admin to sell
                ? SpinKitFadingCube(
                    color: Theme.of(context).colorScheme.primary,
                    size: 50.0,
                  )
                //  products!.isEmpty
                //  const Center(
                //     child: Text("Add some products to sell",
                //         style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.w500,
                //         ),
                //         textAlign: TextAlign.center),
                //   )
                : GridView.builder(
                    padding: EdgeInsets.all(mq.width * .025),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: mq.width * .025, crossAxisCount: 2),
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      final productData = products![index];

                      return Column(
                        children: [
                          SizedBox(
                            height: 140,
                            child: SingleProduct(
                              image: productData.images[0],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  productData.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),

                              // delete item
                              IconButton(
                                onPressed: () {
                                  adminServices.deleteProduct(
                                      context: context,
                                      product: productData,
                                      onSuccess: () {
                                        showSnackBar(
                                            context: context,
                                            text: "Item deleted succesfully");
                                      });
                                },
                                icon: const Icon(Icons.delete_outline),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(right: mq.width * .0125),
              child: FloatingActionButton(
                // foregroundColor: Colors.deepPurple,
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  // side: BorderSide(color: Colors.black, width: 1),
                ),
                onPressed: navigateToAddProduct,
                tooltip: "Add a product",
                child: const Icon(Icons.add),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
          );
  }
}
