import 'package:cazuela_chapina_app/features/dashboard/presentation/screens/dashboards/reportes_slider.dart';
import 'package:cazuela_chapina_app/features/dashboard/presentation/screens/dashboards/sucursal_chart.dart';
import 'package:cazuela_chapina_app/features/dashboard/presentation/screens/dashboards/tamales_mas_vendidos_chart.dart';
import 'package:cazuela_chapina_app/features/dashboard/presentation/screens/dashboards/ventas_diarias_chart.dart';
import 'package:cazuela_chapina_app/features/shared/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        onPressed: () {
          context.go("/combos");
        },
      ),
    );
  }
}

class _DashboardsView extends StatelessWidget {
  const _DashboardsView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // or Axis.vertical
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SucursalChartScreen(),
          SizedBox(height: 10),
          ReportesSlider(),
          SizedBox(height: 20),

          const Text(
            'Ventas Diarias',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22),
          ),
          const Text(
            'Total de Ventas, Fecha de Venta, Total Ingreso',
            style: TextStyle(fontSize: 14),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // or Axis.vertical
            child: SizedBox(
              // Or directly your chart widget
              width:
                  700.0, // Example: set a larger width than screen for horizontal scroll
              child: LineChartSample2(),
            ),
          ),
          const Text(
            'Tamales mas vendidos',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22),
          ),
          SizedBox(height: 10),
          TamalesMasVendidosChart(),
        ],
      ),
    );
  }
}
