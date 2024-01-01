import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/model/restaurant.dart';
import '../provider/database_provider.dart';
import '../ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRestaurantItem(context, restaurant);
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    final double width = MediaQuery.of(context).size.width;

    return Stack(children: [
      GestureDetector(
        child: Card(
          color: Theme.of(context).cardColor,
          clipBehavior: Clip.hardEdge,
          elevation: 5.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: width <= 600 ? width * 0.32 : width * 0.22,
                child: Hero(
                  tag: 'img-${restaurant.pictUrl}',
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictUrl}',
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, error, _) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  restaurant.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.clip,
                  ),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.5),
                child: Wrap(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: width * 0.035,
                    ),
                    Text(
                      restaurant.city,
                      style: TextStyle(
                        fontSize: width * 0.025,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: width >= 600 ? width * 0.03 : width * 0.04,
                    ),
                    Text(
                      (restaurant.rating).toString(),
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontSize: width >= 600 ? width * 0.025 : width * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant);
        },
      ),
      Positioned(
        right: 2.5,
        top: 2.5,
        child: Consumer<DatabaseProvider>(
          builder: (context, provider, child) {
            return FutureBuilder<bool>(
              future: provider.isFavorited(restaurant.id),
              builder: (context, snapshot) {
                var isFavorited = snapshot.data ?? false;
                return isFavorited
                    ? IconButton(
                        iconSize: width * 0.08,
                        icon: const Icon(Icons.favorite),
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () =>
                            provider.removeFavorited(restaurant.id),
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () => provider.addFavorite(restaurant),
                      );
              },
            );
          },
        ),
      ),
    ]);
  }
}
