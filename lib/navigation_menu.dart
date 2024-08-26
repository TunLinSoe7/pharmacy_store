import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pharmacy_store/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>NavigationProvider(),
      child: Consumer<NavigationProvider>(
        builder: (_,provider,__)=>Scaffold(
          bottomNavigationBar: NavigationBar(
            elevation: 0,
            selectedIndex: provider.selectedIndex,
            onDestinationSelected: (value){
              provider.toggleIndex(value);
            },
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label:'Home'),
              NavigationDestination(icon: Icon(Iconsax.shop), label:'Store'),
              NavigationDestination(icon: Icon(Iconsax.heart), label:'WhistList'),
              NavigationDestination(icon: Icon(Iconsax.user), label:'Home'),
            ],
          ),
          body: IndexedStack(
            index: provider.selectedIndex,
            children: provider.screens,
          ),
        ),
      ),
    );
  }
}
