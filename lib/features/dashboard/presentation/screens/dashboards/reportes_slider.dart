import 'package:cazuela_chapina_app/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportesSlider extends ConsumerStatefulWidget {
  const ReportesSlider({super.key});

  @override
  ConsumerState<ReportesSlider> createState() => _ReportesSliderState();
}

class _ReportesSliderState extends ConsumerState<ReportesSlider> {
  @override
  void initState() {
    super.initState();
    ref.read(dashboardProvider.notifier).bebidaPreferidaPorHorario();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentState = ref.watch(dashboardProvider);
    final contentStateData = contentState.contentBebidasPreferidasPorHorario;

    List<Widget> result =
        contentStateData.map((item) {
          return Stack(
            children: [
              Container(
                width: 200, // Set a fixed width for each card
                child: Card(
                  color:
                      item["horario"] == "Mañana"
                          ? Colors.yellowAccent[100]
                          : item["horario"] == "Tarde"
                          ? Colors.orange[100]
                          : Colors.blueGrey[100],
                  elevation: 3,
                  margin: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200, // Set a fixed width for each card
                    height: 100, // Set a fixed height for each card
                    child: Column(
                      children: [
                        Text(
                          '${item["bebida"]}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Franja de horario',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '${item["horario"]}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                right: 15,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: const Icon(
                    Icons.show_chart_sharp,
                    size: 30,
                    color: Colors.green,
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 15,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    '${item["totalVendidos"]} ventas',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        }).toList();

    return Column(
      children: [
        const Text(
          'Bebidas Preferida Por Horario',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection:
              Axis.horizontal, // Set scroll direction to horizontal
          child: Row(children: result),
        ),
      ],
    );
  }
}
