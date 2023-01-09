import 'package:flutter/material.dart';
import 'package:hubia_menu_app/shared/widgets/hubia_app_bar.dart';
import 'package:hubia_menu_app/shared/widgets/hubia_module.dart';

class HubiaPage extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool _transparent;
  final Color? backgroundColor;
  final bool _noAppBar;
  final bool _bottomBar;
  final int bottomBarIndex;

  const HubiaPage(
      {Key? key, required this.child, this.title, this.backgroundColor})
      : _transparent = false,
        _noAppBar = false,
        _bottomBar = false,
        bottomBarIndex = 0,
        super(key: key);

  const HubiaPage.transparent(
      {required this.child, Key? key, this.title, this.backgroundColor})
      : _transparent = true,
        _noAppBar = false,
        _bottomBar = false,
        bottomBarIndex = 0,
        super(key: key);

  const HubiaPage.noAppBar(
      {required this.child, Key? key, this.backgroundColor})
      : _transparent = false,
        _noAppBar = true,
        title = '',
        _bottomBar = false,
        bottomBarIndex = 0,
        super(key: key);

  const HubiaPage.bottomBar({
    required this.child,
    required this.bottomBarIndex,
    Key? key,
    this.backgroundColor,
  })  : _transparent = false,
        _noAppBar = true,
        title = '',
        _bottomBar = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: this.backgroundColor,
      appBar: _noAppBar
          ? null
          : HubiaAppBar(
              trasnparent: _transparent,
              title: this.title,
            ),
      extendBodyBehindAppBar: _transparent,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: child,
      ),
      bottomNavigationBar: _bottomBar
          ? BottomNavigationBar(
              items: [
                _bottomNavigationItem(
                    context: context,
                    // icon: 'assets/images/icons/home.png',
                    icon: Icons.home_outlined,
                    label: 'Home',
                    index: 0,
                    route: ''),
                // _bottomNavigationItem(
                //     context: context,
                //     // icon: 'assets/images/icons/fatura.png',
                //     icon: Icons.favorite_border,
                //     label: 'Favoritos',
                //     index: 1,
                //     route: ''),
                _bottomNavigationItem(
                    context: context,
                    // icon: 'assets/images/icons/bag.png',
                    icon: Icons.shopping_bag_outlined,
                    label: 'Carrinho',
                    index: 1,
                    route: ''),
                // _bottomNavigationItem(
                //     context: context,
                //     // icon: 'assets/images/icons/card.png',
                //     icon: Icons.notifications_none,
                //     label: 'Notificações',
                //     index: 3,
                //     route: ''),
                _bottomNavigationItem(
                    context: context,
                    // icon: 'assets/images/icons/star.png',
                    icon: Icons.perm_identity,
                    label: 'Meu Perfil',
                    index: 2,
                    route: '')
              ],
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              currentIndex: bottomBarIndex,
              showSelectedLabels: false,
              showUnselectedLabels: true,
            )
          : null,
    );
  }

  BottomNavigationBarItem _bottomNavigationItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required String route,
  }) {
    return BottomNavigationBarItem(
      icon: InkWell(
        onTap: () {
          print("route: " + '/area_logada/$route');
          pageTrack.clear();
          pageTrack.add('/home');

          Navigator.of(context, rootNavigator: true)
              .pushReplacementNamed('/home/$route');
        },
        child: Container(
          height: 50,
          padding: bottomBarIndex == index
              ? EdgeInsets.symmetric(horizontal: 16, vertical: 12)
              : EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: bottomBarIndex == index
                ? Theme.of(context).primaryColor.withOpacity(.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            // size: 24.0,
            semanticLabel: label,
          ),
          // child: ImageIcon(AssetImage(icon)),
        ),
      ),
      label: '',
      backgroundColor: Colors.white,
    );
  }
}
