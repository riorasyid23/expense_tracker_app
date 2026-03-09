import 'package:flutter/material.dart';

class NavbarItem{
  final String title;
  final IconData icon;
  final String route;

  NavbarItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class NavbarItemList {
  static List<NavbarItem> items = [
    NavbarItem(title: "Home", icon: Icons.home, route: "/"),
    NavbarItem(title: "History", icon: Icons.history, route: "/history"),
    NavbarItem(title: "Overview", icon: Icons.analytics, route: "/overview"),
  ];
}

class CustomBottomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final String pageRoute;

  const CustomBottomNavbar({
    super.key,
    this.pageTitle = "Home",
    required this.pageRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF172533),
        border: Border(top: BorderSide(
          color: Colors.white,
          width: 0.2
        ))
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: NavbarItemList.items.map((item) {
            bool isActive = item.route == pageRoute;
            return InkWell(
              onTap: () {
                if(item.route != pageRoute){
                  Navigator.pushReplacementNamed(context, item.route);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, color: isActive ? Colors.blue : Colors.blueGrey, size: 16),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 10,
                      color: isActive ? Colors.blue : Colors.blueGrey,
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(70);
}