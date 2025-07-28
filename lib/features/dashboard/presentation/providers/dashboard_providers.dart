import 'dart:developer';

import 'package:cazuela_chapina_app/features/dashboard/infraesctucture/datasource/dashboard_datasource_impl.dart';
import 'package:cazuela_chapina_app/features/dashboard/presentation/screens/dashboards/tamales_mas_vendidos_chart.dart';
import 'package:cazuela_chapina_app/features/shared/services/key_value_storage_service.dart';
import 'package:cazuela_chapina_app/features/shared/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
      final dashboardDataSource = DashboardDatasourceImpl();
      final keyValueStorage = KeyValueStorageServiceImpl();
      return DashboardNotifier(
        dashboardDataSource: dashboardDataSource,
        keyValueStorage: keyValueStorage,
      );
    });

class DashboardNotifier extends StateNotifier<DashboardState> {
  final DashboardDatasourceImpl dashboardDataSource;
  final KeyValueStorageService keyValueStorage;
  DashboardNotifier({
    required this.dashboardDataSource,
    required this.keyValueStorage,
  }) : super(DashboardState()) {
    ventasDiarias();
    tamalesMasVendidos();
  }

  Future<void> tamalesMasVendidos() async {
    final token = await keyValueStorage.getValue<String>("token");
    if (token == null) Exception('Error fetching tamales mas vendidos');
    try {
      final content = await dashboardDataSource.tamalesMasVendidos(token);
      state = state.copyWith(contentTamalesMasVendidos: content);
    } catch (e) {
      Exception('Error fetching tamales mas vendidos');
    }
  }

  Future<void> ventasDiarias() async {
    final token = await keyValueStorage.getValue<String>("token");
    if (token == null) Exception('Error fetching ventas diarias');
    try {
      final content = await dashboardDataSource.ventasDiarias(token);
      state = state.copyWith(contentVentasPorDias: content);
    } catch (e) {
      throw Exception('Error fetching ventas diarias: $e');
    }
  }
}

class DashboardState {
  final List<dynamic> contentVentasPorDias;
  final List<dynamic> contentTamalesMasVendidos;

  DashboardState({
    this.contentVentasPorDias = const [],
    this.contentTamalesMasVendidos = const [],
  });

  DashboardState copyWith({contentVentasPorDias, contentTamalesMasVendidos}) {
    return DashboardState(
      contentVentasPorDias: contentVentasPorDias ?? this.contentVentasPorDias,
      contentTamalesMasVendidos:
          contentTamalesMasVendidos ?? this.contentTamalesMasVendidos,
    );
  }
}
