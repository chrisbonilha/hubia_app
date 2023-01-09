import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubia_menu_app/api/models/category.dart';
import 'package:hubia_menu_app/api/models/dish.dart';
import 'package:hubia_menu_app/api/models/restaurant.dart';

import 'package:hubia_menu_app/app/modules/home/bloc/bloc.dart';
import 'package:hubia_menu_app/app/utils/validators/address_validator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hubia_menu_app/shared/theme/hubia_theme.dart';
import 'package:hubia_menu_app/shared/widgets/components/hubia_dropdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePage> {
  late final HomeBloc homeBloc;

  //aux
  int selectedIndex = -1;
  String? _dropdownValue;
  final _cidadeController = TextEditingController();
  List<String> _stateList = [];
  final Box box = Hive.box("endereco");

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadingStates());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is StateLoaded) {
          _stateList = state.stateList;
          _dropdownValue = state.stateList.first;
          context.read<HomeBloc>().add(HomeInfosLoading(
              stateList: state.stateList,
              onFinish: () {
                _showMyDialogEstado();
              }));
        }

        if (state is Loading) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is Loaded) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Let\'s eat\nQuality food',
                        style: TextStyle(
                            color: navyBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24)),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    // height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.search, color: navyBlue, size: 28.0),
                        SizedBox(width: 11),
                        Text('Search food...',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 20)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        itemCount: state.categorys.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (() {
                              setState(() {
                                if (selectedIndex == index) {
                                  selectedIndex = -1;
                                } else {
                                  selectedIndex = index;
                                }
                              });
                            }),
                            child: Container(
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? yellow
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(state.categorys[index].name!,
                                      style: TextStyle(
                                          color: navyBlue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12))),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: state.restaurants
                          .map(
                            (e) => _restaurantCard(
                              restaurant: e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 24),
                  //   width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.height,
                  //   child: GridView.count(
                  //     crossAxisCount: 2,
                  //     children: state.dishes
                  //         .map(
                  //           (e) => _dishCard(
                  //             dish: e,
                  //           ),
                  //         )
                  //         .toList(),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }
        return Text('No state');
      },
    );
  }

  Future<void> _showMyDialogEstado() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Por favor, escolha o seu estado'),
          content: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              HubiaDropdown(
                value: this._dropdownValue,
                options: this._stateList,
                onChange: (String? newValue) =>
                    setState(() => this._dropdownValue = newValue),
              ),
            ]),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                box.put("uf", _dropdownValue);
                Navigator.of(context).pop();
                _showMyDialogCidade();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogCidade() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Por favor, escolha a sua cidade'),
          content: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Cidade',
                ),
                controller: _cidadeController,
                validator: AddressValidator.validateCidade,
              ),
            ]),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                box.put("cidade", _cidadeController.text);
                Navigator.of(context).pop();
                context.read<HomeBloc>().add(HomeInfosLoaded(
                    uf: _dropdownValue!, cidade: _cidadeController.text));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _categoryCard({
    required Category category,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: yellow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
            alignment: Alignment.center,
            child: Text(category.name!,
                style: TextStyle(
                    color: navyBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 12))),
      ),
      // ]),
    );

    // return GestureDetector(
    //   onTap: () {},
    //   child: Stack(children: <Widget>[
    //     Container(
    //       margin: EdgeInsets.symmetric(vertical: 12),
    //       padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    //       height: 80,
    //       decoration: BoxDecoration(
    //         border: Border.all(color: Colors.grey, width: 1),
    //         image: DecorationImage(
    //           image: AssetImage(categoria.image!),
    //           fit: BoxFit.cover,
    //         ),
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ),
    //     Container(
    //       margin: EdgeInsets.symmetric(vertical: 12),
    //       padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    //       height: 80,
    //       width: MediaQuery.of(context).size.width,
    //       decoration: BoxDecoration(
    //         color: Colors.grey.withOpacity(0.7),
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: Align(
    //           alignment: Alignment.bottomLeft, child: Text(categoria.nome!)),
    //     ),
    //   ]),
    // );
  }

  Widget _restaurantCard({
    required Restaurant restaurant,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/menu", arguments: restaurant);
      },
      child: Container(
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
                  restaurant.name!,
                  style: TextStyle(
                      color: navyBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
              ),
            ]),
      ),
    );
  }
}
