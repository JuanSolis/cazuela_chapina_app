import 'dart:developer';

import 'package:cazuela_chapina_app/features/combos/infraestructure/datasource/combos_datasource_impl.dart';
import 'package:cazuela_chapina_app/features/shared/services/key_value_storage_service.dart';
import 'package:cazuela_chapina_app/features/shared/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final combosProvider = StateNotifierProvider<CombosNotifier, CombosState>((
  ref,
) {
  final combosDatasourceImpl = CombosDatasourceImpl();
  final keyValueStorage = KeyValueStorageServiceImpl();
  return CombosNotifier(
    combosDatasourceImpl: combosDatasourceImpl,
    keyValueStorage: keyValueStorage,
  );
});

class CombosNotifier extends StateNotifier<CombosState> {
  final CombosDatasourceImpl combosDatasourceImpl;
  final KeyValueStorageService keyValueStorage;
  CombosNotifier({
    required this.combosDatasourceImpl,
    required this.keyValueStorage,
  }) : super(CombosState()) {
    obtenerCombos();
  }

  Future<void> obtenerCombos() async {
    final token = await keyValueStorage.getValue<String>("token");
    if (token == null) Exception('Error fetching obteniendo token');
    try {
      final content = await combosDatasourceImpl.obtenerCombos(token);
      state = state.copyWith(contentObtenerCombos: content);
    } catch (e) {
      Exception('Error fetching combos');
    }
  }

  Future<void> obtenerCombo(dynamic combo) async {
    state = state.copyWith(comboSeleccinado: List<dynamic>.from([combo]));
  }

  Future<void> realizarVenta() async {
    final token = await keyValueStorage.getValue<String>("token");
    if (token == null) Exception('Error fetching compra Combo');
    try {
      if (!state.comboSeleccinado.isEmpty) {
        if (!state.comprandoCombo) {
          state = state.copyWith(comprandoCombo: true);
          final contentVenta = await combosDatasourceImpl.realizarVenta(
            token,
            state.comboSeleccinado[0],
          );
        }
      }
    } catch (e) {
      Exception('Error fetching realizar compra');
    } finally {
      state = state.copyWith(comprandoCombo: false);
    }
  }
}

class CombosState {
  final List<dynamic> contentObtenerCombos;
  final List<dynamic> comboSeleccinado;
  final bool comprandoCombo;

  CombosState({
    this.contentObtenerCombos = const [],
    this.comboSeleccinado = const [],
    this.comprandoCombo = false,
  });

  CombosState copyWith({
    contentObtenerCombos,
    comboSeleccinado,
    comprandoCombo,
  }) {
    return CombosState(
      contentObtenerCombos: contentObtenerCombos ?? this.contentObtenerCombos,
      comboSeleccinado: comboSeleccinado ?? this.comboSeleccinado,
      comprandoCombo: comprandoCombo ?? this.comprandoCombo,
    );
  }
}
