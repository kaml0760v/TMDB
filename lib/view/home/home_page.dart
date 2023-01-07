import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';
import 'package:tmdp_getx_mvc/controllers/configration_controller.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UtitlityController _utilityController;
  late ConfigurationController _configurationController;

  @override
  void initState() {
    _utilityController = Get.find<UtitlityController>();
    _configurationController = Get.put(ConfigurationController(),permanent: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _utilityController.openExitDialog();
        return Future.value(false);
      },
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: _utilityController.navIndex,
            children: _utilityController.pages,
          ),
        ),
        bottomNavigationBar: getBottomNavBar(context),
      ),
    );
  }

  Widget getBottomNavBar(BuildContext ctx) {
    TextStyle? unselectedLabelStyle = Theme.of(ctx).textTheme.caption?.copyWith(
        color: AppTheme.white.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        fontSize: 12);

    TextStyle? selectedLabelStyle = Theme.of(ctx).textTheme.caption?.copyWith(
        color: AppTheme.white, fontWeight: FontWeight.w500, fontSize: 12);

    return Obx(
      () => BottomNavigationBar(
        currentIndex: _utilityController.navIndex,
        onTap: _utilityController.setNavIndex,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        backgroundColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.white.withOpacity(0.5),
        selectedItemColor: AppTheme.white,
        unselectedLabelStyle: unselectedLabelStyle,
        selectedLabelStyle: selectedLabelStyle,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.watch_later), label: "Watchlist"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
