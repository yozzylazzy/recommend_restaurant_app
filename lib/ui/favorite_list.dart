import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widgets/orientation_widget.dart';
import '../utils/result_state.dart';
import '../widgets/card_restaurant.dart';

class FavoriteList extends StatelessWidget {
  static const String favoriteTitle = 'Favorites';

  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrientationWidget(
      portraitWidget: buildPortrait,
      landscapeWidget: buildLandscape,
    ));
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
                  'assets/image/favorite_banner.jpeg',
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
                              'Favorites',
                              style: TextStyle(
                                  fontSize: height <= 700 ? height * 0.03 : 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              'Favorited restaurant by you!',
                              style: TextStyle(
                                  fontSize: height <= 700 ? height * 0.02 : 12,
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
                      'assets/image/favorite_banner.jpg',
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
                            'Favorites',
                            style: TextStyle(
                                fontSize: width >= 400
                                    ? height * 0.025
                                    : width * 0.045,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Text(
                            'Favorited restaurant by you!',
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

  Widget _buildList(BuildContext context, width, height) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == ResultState.hasData) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                return CardRestaurant(restaurant: provider.favorites[index]);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width <= 600 ? 2 : 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                mainAxisExtent: width <= 600 ? width * 0.55 : width * 0.4,
              ),
            ),
          );
        } else {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        }
      },
    );
  }
}
