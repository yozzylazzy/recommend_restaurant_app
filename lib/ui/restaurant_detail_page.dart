import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import '../data/model/restaurant.dart';
import '../provider/database_provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late RestaurantProvider _restaurantProvider;

  @override
  void initState() {
    _restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _restaurantProvider.fetchDetailRestaurant(widget.restaurant.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.stateDetail == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.stateDetail == ResultState.hasData) {
            return detailRestaurant(context, state.detail?.restaurant);
          } else if (state.stateDetail == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }

  Widget detailRestaurant(BuildContext context, detailData) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return screenHeight >= 280 && screenWidth >= 280
        ? NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: screenHeight * 0.25,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(100),
                      ),
                      child: Hero(
                        tag: "img-${widget.restaurant.pictUrl}",
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/large/${widget.restaurant.pictUrl}',
                          fit: BoxFit.cover,
                          height: screenHeight * 0.5,
                        ),
                      ),
                    ),
                  ),
                  foregroundColor: Colors.brown,
                )
              ];
            },
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(widget.restaurant.name.toUpperCase(),
                            style: TextStyle(
                                fontSize: screenWidth * 0.07,
                                fontWeight: FontWeight.w900,
                                color: Colors.brown)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            Flexible(
                                child: Icon(
                              Icons.location_on_sharp,
                              color: Colors.red,
                              size: screenWidth * 0.05,
                            )),
                            const SizedBox(width: 3),
                            Expanded(
                                child: Text(widget.restaurant.city,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.04))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 3.0),
                        child: Row(
                          children: [
                            Flexible(
                                child: Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: screenWidth * 0.05,
                            )),
                            const SizedBox(width: 3),
                            Expanded(
                                child: Text(
                                    (widget.restaurant.rating).toString(),
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.04))),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text('DESCRIPTION',
                            style: TextStyle(
                              fontSize: screenWidth * 0.042,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.brown,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.restaurant.description,
                          style: TextStyle(
                            fontFamily: 'Silkscreen',
                            fontSize: screenWidth * 0.028,
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Categories: ${detailData?.categories.join(', ') ?? ''}",
                          style: TextStyle(
                            fontSize: screenWidth * 0.028,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'MENU',
                          style: TextStyle(
                            fontSize: screenWidth * 0.042,
                            fontWeight: FontWeight.w700,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Foods (${detailData?.menus?['foods']?.length ?? 0} items)',
                          style: TextStyle(
                            fontSize: screenWidth * 0.028,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      buildMenuItem(
                          detailData?.menus?['foods'], context, screenWidth),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Drinks (${detailData?.menus?['drinks']?.length ?? 0} items)',
                          style: TextStyle(
                            fontSize: screenWidth * 0.028,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      buildMenuItem(
                          detailData?.menus?['drinks'], context, screenWidth),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text('Reviews',
                            style: TextStyle(
                              fontSize: screenWidth * 0.042,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.brown,
                            )),
                      ),
                      buildReviewCard(detailData!.customerReviews ?? [],
                          context, screenWidth),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 15,
                  child: Consumer<DatabaseProvider>(
                    builder: (context, provider, child) {
                      return FutureBuilder<bool>(
                        future: provider.isFavorited(widget.restaurant.id),
                        builder: (context, snapshot) {
                          var isFavorited = snapshot.data ?? false;
                          return isFavorited
                              ? IconButton.filledTonal(
                                  icon: const Icon(Icons.favorite),
                                  color:
                                      Theme.of(context).colorScheme.error,
                                  onPressed: () => provider
                                      .removeFavorited(widget.restaurant.id),
                                )
                              : IconButton.filledTonal(
                                  icon: const Icon(Icons.favorite_border),
                                  color:
                                      Theme.of(context).colorScheme.error,
                                  onPressed: () =>
                                      provider.addFavorite(widget.restaurant),
                                );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: Text('Screen size to small to show content!'),
          );
  }

  Widget buildReviewCard(
      List<CustomerReview> reviews, BuildContext context, double screenWidth) {
    return SizedBox(
      height: screenWidth * 0.5,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 5),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: reviews.isNotEmpty
                  ? SizedBox(
                      width: screenWidth * 0.8,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                review.name,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '"${review.review}"',
                                maxLines: 3,
                                style: TextStyle(
                                  color: Theme.of(context).badgeTheme.textColor,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                review.date.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: screenWidth * 0.025,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text('No Reviews Here!'),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget buildMenuItem(item, BuildContext context, double screenWidth) {
    return SizedBox(
      height: screenWidth * 0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: item?.length ?? 0,
        itemBuilder: (context, index) {
          final beverage = item?[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: beverage != null
                ? SizedBox(
                    width: screenWidth * 0.3,
                    child: Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fastfood,
                              size: screenWidth * 0.1,
                              color: Theme.of(context).hintColor,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              beverage['name'] ?? '',
                              style: TextStyle(
                                fontSize: screenWidth * 0.025,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Text('No Food/Drinks Here!'),
                  ),
          );
        },
      ),
    );
  }
}
