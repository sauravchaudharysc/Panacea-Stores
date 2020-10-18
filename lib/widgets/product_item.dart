import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  //
  // ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context , listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: GridTile(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },

            child: Image.network(
              product.imageUrl,
              fit: BoxFit.scaleDown,

            ),
          ),
        ),
        header: GridTileBar(
          leading: IconButton(

            icon: Icon(
              product.isFavorite?Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).hintColor,
            alignment: Alignment.topLeft,
            onPressed: () {
              product.toggleFavoriteStatus();
            },
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added item to cart!',
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
              );
              },
          ),
        ),
      ),
    );
  }
}

