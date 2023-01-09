import 'package:flutter/material.dart';
import 'package:hubia_menu_app/api/models/dish.dart';
import 'package:hubia_menu_app/api/models/restaurant.dart';
import 'package:hubia_menu_app/app/modules/home/pages/item_detail_page.dart';
import 'package:hubia_menu_app/shared/theme/hubia_theme.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Restaurant restaurant;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      restaurant = (ModalRoute.of(context)!.settings.arguments! as Restaurant);
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //imagem do restaurante
          Container(
            color: Colors.black,
            height: 100,
            width: MediaQuery.of(context).size.width,
          ),
          _body(),
          Column(
            children: restaurant.sections!
                .map(
                  (e) => _sectionCard(
                    section: e,
                  ),
                )
                .toList(),
          )
          // Container(
          //   // padding: EdgeInsets.symmetric(horizontal: 24),
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   child: GridView.count(
          //     crossAxisCount: 2,
          //     children: restaurant.sections!
          //         .map(
          //           (e) => _sectionCard(
          //             section: e,
          //           ),
          //         )
          //         .toList(),
          //   ),
          // ),
        ],
      ),
    );
  }

  _body() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name!,
              style: TextStyle(
                  color: navyBlue, fontWeight: FontWeight.bold, fontSize: 24)),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required RestaurantSection section,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(section.title!,
              style: TextStyle(
                  color: navyBlue, fontWeight: FontWeight.w500, fontSize: 20)),
        ),
        Container(
          // padding: EdgeInsets.symmetric(horizontal: 24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
            crossAxisCount: 2,
            children: section.items!
                .map(
                  (d) => _dishCard(
                    dish: d,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _dishCard({
    required Dish dish,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                dish.title!,
                style: TextStyle(
                    color: navyBlue, fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                dish.valueFormatted!,
                style: TextStyle(
                    color: navyBlue, fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed("/item_detail", arguments: dish);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Text(
                  'Add to Cart',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: navyBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 12),
                ),
              ),
            ),
          ]),
    );
  }
}
