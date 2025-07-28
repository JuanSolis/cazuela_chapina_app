import 'dart:developer';

import 'package:cazuela_chapina_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:cazuela_chapina_app/features/shared/providers/menu_provider.dart';
import 'package:cazuela_chapina_app/features/shared/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  ConsumerState<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends ConsumerState<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    final menuData = ref.watch(menuProvider);

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: menuData.navDrawerIndex,
      onDestinationSelected: (value) {
        ref.watch(menuProvider.notifier).onDestinationSelected(value);
        if (value == 0) {
          // Navegar al dashboard
          context.go('/');
        } else if (value == 1) {
          // Navegar a los combos
          context.go('/combos');
        }

        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
          child: Text('Saludos', style: textStyles.titleMedium),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
          child: Text('Admin', style: textStyles.titleSmall),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.show_chart_outlined),
          label: Text('Dashboard'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.storefront_outlined),
          label: Text('Combos'),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Otras opciones'),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout(null);
            },
            text: 'Cerrar sesión',
          ),
        ),
      ],
    );
  }
}
