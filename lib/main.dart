import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sate_management_bloc_cubit/controllers/product_cubit.dart';
import 'package:flutter_sate_management_bloc_cubit/core/widgets/custom_cached_network_image.dart';

import 'package:uuid/uuid.dart';

import 'models/product_model.dart';

var uuid = Uuid();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..callApi(),
      child: Scaffold(
        //backgroundColor: Colors.black.withValues(alpha: .3),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (BuildContext context, ProductState state) {
                  return switch (state) {
                    ProductLoading() => Center(child: CircularProgressIndicator()),
                    ProductLoaded() => Center(
                      child: GridView.builder(
                        itemCount: state.productList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: .6,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final ProductModel product = state.productList[index];
                          return ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      CustomCachedNetworkImage(imagePath: product.image),
                                      if(product.price < 100)Positioned(
                                        child: Container(
                                          color: Colors.red,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                            child: Text("20%",style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          ...List.generate(5, (index) {
                                            return Icon(
                                              index < product.rate.rate.round()
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Colors.amber,
                                              size: 20,
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "${product.price.toString()} \$",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size.fromHeight(30),
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  child: Text("Buy Now"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    ProductError() => Center(
                      child: Text(state.errorMessage, style: TextStyle(color: Colors.red)),
                    ),
                  };
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
