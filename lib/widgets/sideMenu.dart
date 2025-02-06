import 'package:dashborad/utils/responsive.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      key: key,
      mobile: _MobileSideMenu(),
      tablet: _DesktopSideMenu(),
      desktop: _DesktopSideMenu(),
    );
  }
}

class _DesktopSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.blue[700],
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                'assets/images/logo_white.png',
              ),
            ),
            DrawerListTitle(press: () {}, title: 'Configurações'),
          ],
        ),
      ),
    );
  }
}

class _MobileSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu, color: Colors.blue[700]),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}

class MobileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.blue[700],
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                'assets/images/logo_white.png',
              ),
            ),
            DrawerListTitle(press: () {}, title: 'Configurações'),
          ],
        ),
      ),
    );
  }
}

class DrawerListTitle extends StatefulWidget {
  const DrawerListTitle({
    Key? key,
    required this.press,
    required this.title,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  State<DrawerListTitle> createState() => _DrawerListTitleState();
}

class _DrawerListTitleState extends State<DrawerListTitle> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: widget.press,
          child: Container(
            color:
                isHovered ? Colors.black.withOpacity(0.6) : Colors.transparent,
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text(
                widget.title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
