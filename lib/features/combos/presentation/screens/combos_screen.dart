import 'dart:developer';

import 'package:cazuela_chapina_app/features/combos/presentation/providers/combos_provider.dart';
import 'package:cazuela_chapina_app/features/shared/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CombosScreen extends ConsumerStatefulWidget {
  const CombosScreen({super.key});

  @override
  ConsumerState<CombosScreen> createState() => _CombosScreenState();
}

class _CombosScreenState extends ConsumerState<CombosScreen> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Combos'),
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
    final contentStateNotifier = ref.watch(combosProvider.notifier);
    final contentState = ref.watch(combosProvider);
    final contentStateData = contentState.contentObtenerCombos;
    //Image Hero with degration effect to transparent in the bottom, the image is the hero banner of the page
    return Column(
      children: [
        Center(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter, // Start fading from the top
                end: Alignment.bottomCenter, // End fading at the bottom
                colors: [
                  Colors.black, // Opaque at the top
                  Colors.white10, // Fully transparent at the bottom
                ],
                stops: [0.1, 1.0], // Control where the gradient starts and ends
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn, // Blends the gradient as an alpha mask
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(35)),

              child: Image.asset(
                'assets/images/branding/1_logo_principal.png', // Replace with your image path
                height: 300,
                width: screenSize.width * 0.90,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Row(
              children: [
                Icon(Icons.filter_list, size: 20, color: Colors.black),
                SizedBox(width: 5),
                Text(
                  'Filtrar Combos',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.height_outlined, size: 20, color: Colors.black),
                SizedBox(width: 5),
                Text(
                  'Filtrar Combos',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
              ],
            ),
            const Row(
              children: [Icon(Icons.list, size: 20, color: Colors.black)],
            ),
          ],
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 10.0, // Spacing between columns
            mainAxisSpacing: 10.0, // Spacing between rows
            childAspectRatio: 0.90, //
            padding: const EdgeInsets.all(5.0), // Padding around the grid
            children:
                contentStateData.map((elemet) {
                  return SizedBox(
                    height: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        contentStateNotifier.obtenerCombo(elemet);
                        context.push('/combos/${elemet["comboId"]}');
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 4.0, // Shadow depth of the card

                        child: Padding(
                          padding: const EdgeInsets.all(
                            10.0,
                          ), // Padding inside the card
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    'assets/images/image-placeholder.jpg', // Replace with your image path
                                    height: 100,
                                    width: screenSize.width * 0.40,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${elemet["nombre"]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${elemet["descripcion"]}',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen[100],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Q ${elemet["precio"]}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue[100],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Combo ${elemet["tipo"]}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
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
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
