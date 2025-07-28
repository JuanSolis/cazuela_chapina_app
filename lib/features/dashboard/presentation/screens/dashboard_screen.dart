import 'package:cazuela_chapina_app/features/shared/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        ],
      ),
      body: const _DashboardsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Realizar Compra'),
        icon: const Icon(Icons.shopping_cart_outlined),
        onPressed: () {},
      ),
    );
  }
}

class _DashboardsView extends StatelessWidget {
  const _DashboardsView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Dashboard aca!'));
  }
}
