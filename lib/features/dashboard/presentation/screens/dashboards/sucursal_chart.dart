import 'package:cazuela_chapina_app/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SucursalChartScreen extends ConsumerStatefulWidget {
  const SucursalChartScreen({super.key});

  @override
  ConsumerState<SucursalChartScreen> createState() => _SucursalChartState();
}

class _SucursalChartState extends ConsumerState<SucursalChartScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(dashboardProvider.notifier).reportePorSucursal();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentState = ref.watch(dashboardProvider);
    final contentStateData = contentState.contentReportePorSucursal;
    // Agrega un contenedor con un carrusel horizontal de cards.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: screenWidth * 0.95, // Ajusta el ancho según tus necesidades
          height: 135, // Ajusta la altura según tus necesidades
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(8.0),
            child: SizedBox(
              // Agrega un row con un icono y un texto.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${contentStateData.length > 0 ? contentStateData[0]["sucursal"] : "Sucursal"}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: const Icon(
                          Icons.storefront_outlined,
                          size: 30,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),

                      Flexible(
                        child: Text(
                          "Total Ventas:",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "Q${contentStateData.length > 0 ? contentStateData[0]["totalVentas"] : "0"}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Total Ingresos:",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "Q${contentStateData.length > 0 ? contentStateData[0]["totalIngresos"] : "0"}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
