import 'package:flutter/material.dart';
import 'package:hubia_menu_app/api/models/dish.dart';
import 'package:hubia_menu_app/shared/theme/hubia_theme.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({Key? key}) : super(key: key);

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late Dish dish;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      dish = (ModalRoute.of(context)!.settings.arguments! as Dish);
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dish.title!,
                style: TextStyle(
                    color: navyBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            const SizedBox(height: 8),
            Text(dish.description!,
                style: TextStyle(
                    color: navyBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 18)),
            const SizedBox(height: 8),
            Text(dish.valueFormatted!,
                style: TextStyle(
                    color: grey, fontWeight: FontWeight.w500, fontSize: 16)),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dish.oneChoiceOptions!
                  .map(
                    (d) => _fillOutOneChoiceOptions(
                      option: d,
                    ),
                  )
                  .toList(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dish.multipleChoiceOptions!
                  .map(
                    (d) => _fillOutMultipleChoiceOptions(
                      option: d,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fillOutOneChoiceOptions({required DishOption option}) {
    // option.indexSelected = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: grey.withOpacity(0.3),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(option.title!),
              Text("0 de 1"),
            ],
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView.builder(
            itemCount: option.options!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${option.options![index].title}'),
                tileColor: option.indexSelected == index ? Colors.blue : null,
                onTap: () {
                  setState(() {
                    option.indexSelected = index;
                  });
                },
              );
            },
          ),
        ),

        // FUNCIONA MAS TEM FUNCAO APENAS DE LISTAGEM
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: option.options!
        //       .map(
        //         (d) => _singleOptions(
        //           option: d,
        //         ),
        //       )
        //       .toList(),
        // ),
      ],
    );
  }

  Widget _singleOptions({required DishOption option}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  Container(
        //   height: 1,
        //   color: Colors.black.withOpacity(0.2),
        //   width: MediaQuery.of(context).size.width,
        // ),
        Text(option.title!),
        Text(option.valueFormatted),
        Container(
          height: 1,
          color: Colors.black.withOpacity(0.2),
          width: MediaQuery.of(context).size.width,
        )
      ],
    );
  }

  // Widget _singleOptions({required List<DishOption> options}) {
  // return Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     //  Container(
  //     //   height: 1,
  //     //   color: Colors.black.withOpacity(0.2),
  //     //   width: MediaQuery.of(context).size.width,
  //     // ),
  //     Text(option.title!),
  //     Text(option.valueFormatted),
  //     Container(
  //       height: 1,
  //       color: Colors.black.withOpacity(0.2),
  //       width: MediaQuery.of(context).size.width,
  //     )
  //   ],
  // );
  // }

  Widget _fillOutMultipleChoiceOptions({required DishOption option}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: grey.withOpacity(0.3),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(option.title!),
              Text("0 de 1"),
            ],
          ),
        ),
        SizedBox(height: 8),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: option.options!
        //       .map(
        //         (d) => _singleOptions(
        //           option: d,
        //         ),
        //       )
        //       .toList(),
        // ),
      ],
    );
  }
}
