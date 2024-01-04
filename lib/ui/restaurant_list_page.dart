import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/search_screen.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/widgets/orientation_widget.dart';
import '../data/model/restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final TextEditingController _search = TextEditingController();
  List<Restaurant> allRestaurants = [];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationWidget(
      portraitWidget: buildPortrait,
      landscapeWidget: buildLandscape,
    );
  }

  Widget buildLandscape(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: height >= 225
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
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                                  fontSize: height <= 700 ? height * 0.03 : 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              'Recommendation restaurant for you!',
                              style: TextStyle(
                                  fontSize: height <= 700 ? height * 0.02 : 12,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: _searchRestaurant(
                      context,
                      width,
                      height,
                    )),
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
    );
  }

  Widget buildPortrait(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: width >= 280
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/image/home_banner.jpg',
                      height: height * 0.2,
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
                          left: 20, right: 20, top: height * 0.125),
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
                _searchRestaurant(
                  context,
                  width,
                  height,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Divider(),
                ),
                Expanded(
                    child: Container(
                        constraints:
                            const BoxConstraints(maxHeight: double.infinity),
                        child: _buildList(context, width, height))),
              ],
            )
          : const Center(child: Text('Screen To Small!')),
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

  Widget _searchRestaurant(
    BuildContext context,
    width,
    height,
  ) {
    return Container(
        width: width,
        height: height * 0.07,
        margin: const EdgeInsets.only(right: 25.0, left: 25.0, top: 10),
        child: SearchBar(
          hintText: 'Restaurant/Menu Name....',
          textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: height * 0.015, color: Colors.white70)),
          backgroundColor: MaterialStateProperty.all(
            const Color.fromRGBO(139, 69, 19, 75),
          ),
          controller: _search,
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          leading: Icon(
            Icons.search,
            size: height * 0.04,
            color: Colors.white60,
          ),
          onSubmitted: (value) {
            if (value.isEmpty || value.trim().isEmpty) {
              _showEmptySearchDialog(context);
            } else {
              Navigator.pushNamed(context, SearchScreen.routeName,
                  arguments: value);
            }
          },
        ));
  }

  void _showEmptySearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Empty Search'),
          content:
              const Text('Please enter a valid restaurant name to search.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildList(BuildContext context, width, height) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.stateList == ResultState.loading) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        } else if (state.stateList == ResultState.hasData) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width <= 600 ? 2 : 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                mainAxisExtent: width <= 600 ? width * 0.55 : width * 0.4,
              ),
            ),
          );
        } else if (state.stateList == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.stateList == ResultState.error) {
          return Center(
            child: Text(state.message.toString()),
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
}
