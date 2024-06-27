import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap,});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Products',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Sales',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: 'Transactions',
        ),
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.white,
      onTap: widget.onTap,
    );
  }
}

class SlideTransitionPageRoute extends PageRouteBuilder {
  final Widget page;

  SlideTransitionPageRoute({required this.page}): super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}