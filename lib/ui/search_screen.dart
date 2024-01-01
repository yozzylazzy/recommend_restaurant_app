import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/modal_dialog.dart';
import 'package:restaurant_app/widgets/orientation_widget.dart';
import '../data/model/restaurant.dart';
import '../provider/restaurant_provider.dart';
import '../utils/result_state.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({Key? key, required this.query}) : super(key: key);

  static const String routeName = '/restaurant_search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late RestaurantProvider _restaurantProvider;

  @override
  void initState() {
    _restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _restaurantProvider.fetchSearchRestaurant(widget.query);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationWidget(
      landscapeWidget: buildLandscape,
      portraitWidget: buildPortrait,
    );
  }

  Widget buildLandscape(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: height >= 220
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/image/home_banner.jpg',
                    width: width,
                    height: height * 0.5,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          width: width,
                          height: height * 0.15,
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          padding: EdgeInsets.only(
                              left: width / 30, right: width / 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.ltr,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Restaurant',
                                style: TextStyle(
                                    fontSize:
                                        height <= 700 ? height * 0.03 : 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              Text(
                                'Recommendation restaurant for you!',
                                style: TextStyle(
                                    fontSize:
                                        height <= 700 ? height * 0.02 : 12,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Container(
                          constraints:
                              const BoxConstraints(maxHeight: double.infinity),
                          child: _buildList(context, width, height))),
                ],
              )
            : const Center(child: Text('Screen to small!')),
      ),
    );
  }

  Widget buildPortrait(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: width >= 280
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/image/search_banner.jpg',
                        height: height * 0.25,
                        width: width,
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        width: width,
                        height: height >= 400 ? height * 0.13 : height * 0.15,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: height * 0.18),
                        padding: EdgeInsets.only(
                            left: width / 30, right: width / 30, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Restaurant',
                              style: TextStyle(
                                  fontSize: width >= 400
                                      ? height * 0.025
                                      : width * 0.045,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              'Recommendation restaurant for you!',
                              style: TextStyle(
                                  fontSize: width >= 400
                                      ? height * 0.015
                                      : width * 0.03,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Giving Result of ${widget.query}...',
                            style: TextStyle(
                                fontSize: width >= 400
                                    ? height * 0.015
                                    : width * 0.03)),
                        const Divider(),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          constraints:
                              const BoxConstraints(maxHeight: double.infinity),
                          child: _buildList(context, width, height))),
                ],
              )
            : const Center(child: Text('Screen To Small!')),
      ),
    );
  }

  Widget notFoundText(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(),
      ),
    );
  }

  Widget _buildList(BuildContext context, width, height) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.stateSearch == ResultState.loading) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        } else if (state.stateSearch == ResultState.hasData) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: state.search.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.search.restaurants[index];
                return _buildRestaurantItem(context, restaurant);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width <= 600 ? 2 : 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                mainAxisExtent: width <= 600 ? width * 0.55 : width * 0.4,
              ),
            ),
          );
        } else if (state.stateSearch == ResultState.noData) {
          return const ModalDialog();
        } else if (state.stateSearch == ResultState.error) {
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
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        elevation: 5.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: width <= 600 ? width * 0.32 : width * 0.22,
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictUrl}',
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, _) => const Center(
                  child: Icon(Icons.error),
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
                    color: Colors.grey,
                    size: width * 0.035,
                  ),
                  Text(
                    restaurant.city,
                    style: TextStyle(
                      color: Colors.grey,
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
                    color: Colors.grey,
                    size: width >= 600 ? width * 0.03 : width * 0.04,
                  ),
                  Text(
                    (restaurant.rating).toString(),
                    style: TextStyle(
                      color: Colors.grey,
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
    );
  }
}
