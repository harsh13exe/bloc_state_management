import 'package:bloc_management/features/cart/ui/cart.dart';
import 'package:bloc_management/features/home/bloc/home_bloc.dart';
import 'package:bloc_management/features/home/ui/product_tiles_widget.dart';
import 'package:bloc_management/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Grocery App',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: Colors.teal,

                actions: [
                  IconButton(
                    icon: Icon(Icons.favorite_outline),
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    color: Colors.white,
                  ),

                  IconButton(
                    icon: Icon(Icons.shopping_bag_outlined),
                    color: Colors.white,
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                    homeBloc: homeBloc,
                    productDataModel: successState.products[index],
                  );
                },
                itemCount: successState.products.length,
              ),
            );

          case HomeErrorState:
            return Scaffold(body: Center(child: Text('Error')));
          default:
            return SizedBox();
        }
      },
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cart()),
          );
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Wishlist()),
          );
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Item Wishlisted')));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Item Added to Cart')));
        }
      },
    );
  }
}
