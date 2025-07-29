import 'dart:developer';

import 'package:cazuela_chapina_app/features/combos/presentation/providers/combos_provider.dart';
import 'package:cazuela_chapina_app/features/shared/widgets/custom_filled_button.dart';
import 'package:cazuela_chapina_app/features/shared/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ComprarComboScreen extends ConsumerStatefulWidget {
  final String comboId;
  const ComprarComboScreen({required this.comboId, super.key});

  @override
  ConsumerState<ComprarComboScreen> createState() => _CombosScreenState();
}

class _CombosScreenState extends ConsumerState<ComprarComboScreen> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Combo'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        ],
      ),
      body: const _CombosView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Realizar Compra'),
        icon: const Icon(Icons.shopping_cart_outlined),
        onPressed: () {},
      ),
    );
  }
}

class _CombosView extends ConsumerStatefulWidget {
  const _CombosView();

  @override
  ConsumerState<_CombosView> createState() => _CombosViewState();
}

class _CombosViewState extends ConsumerState<_CombosView> {
  @override
  void initState() {
    super.initState();
    ref.read(combosProvider.notifier).obtenerCombos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final contentState = ref.watch(combosProvider);
    final contentStateData = contentState.comboSeleccinado;
    //Image Hero with degration effect to transparent in the bottom, the image is the hero banner of the page
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              child: Image.asset(
                'assets/images/image-placeholder.jpg', // Replace with your image path
                height: 300,
                width: screenSize.width * 0.90,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Center(
            child: Container(
              height: screenSize.height * 0.60,
              width: screenSize.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(35)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreen[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        contentStateData.isNotEmpty
                            ? "Evento ${contentStateData[0]["tipo"]}"
                            : "Combo",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${contentStateData.isNotEmpty ? contentStateData[0]["nombre"] : "Combo"}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                contentStateData.isNotEmpty
                                    ? "valido hasta: ${contentStateData[0]["disponibleHasta"].toString().split("T")[0]}"
                                    : "0",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.lightGreen[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                contentStateData.isNotEmpty
                                    ? "Q${contentStateData[0]["precio"]}"
                                    : "0",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '${contentStateData.isNotEmpty ? contentStateData[0]["descripcion"] : "Descripción del combo"}',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: SizedBox(
                        width: screenSize.width * 0.80,
                        height: 60,
                        child: FilledButton(
                          onPressed: () async {
                            if (!contentState.comprandoCombo) {
                              await ref
                                  .watch(combosProvider.notifier)
                                  .realizarVenta();

                              context.pop();
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                contentState.comprandoCombo
                                    ? "Comprando..."
                                    : "Comprar Combo",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
