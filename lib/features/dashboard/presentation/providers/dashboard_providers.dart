import 'dart:developer';

import 'package:cazuela_chapina_app/features/dashboard/infraesctucture/datasource/dashboard_datasource_impl.dart';
import 'package:cazuela_chapina_app/features/shared/services/key_value_storage_service.dart';
import 'package:cazuela_chapina_app/features/shared/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProvider =
    StateNotifierProvider.autoDispose<DashboardNotifier, DashboardState>((ref) {
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
    reportePorSucursal();
    bebidaPreferidaPorHorario();
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

  Future<void> reportePorSucursal() async {
    final token = await keyValueStorage.getValue<String>("token");
    if (token == null) Exception('Error fetching reporte por sucursal');
    try {
      final content = await dashboardDataSource.reportePorSucurcal(token);
      state = state.copyWith(contentReportePorSucursal: content);
    } catch (e) {
      throw Exception('Error fetching reporte por sucursal');
    }
  }

  Future<void> bebidaPreferidaPorHorario() async {
    final token = await keyValueStorage.getValue<String>("token");
    if (token == null) Exception('Error fetching bebida preferida por horario');
    try {
      final content = await dashboardDataSource.bebidasPreferidasPorHorario(
        token,
      );
      state = state.copyWith(contentBebidasPreferidasPorHorario: content);
    } catch (e) {
      throw Exception('Error fetching bebida preferida por horario: $e');
    }
  }
}

class DashboardState {
  final List<dynamic> contentVentasPorDias;
  final List<dynamic> contentTamalesMasVendidos;
  final List<dynamic> contentReportePorSucursal;
  final List<dynamic> contentBebidasPreferidasPorHorario;

  DashboardState({
    this.contentVentasPorDias = const [],
    this.contentTamalesMasVendidos = const [],
    this.contentReportePorSucursal = const [],
    this.contentBebidasPreferidasPorHorario = const [],
  });

  DashboardState copyWith({
    contentVentasPorDias,
    contentTamalesMasVendidos,
    contentReportePorSucursal,
    contentBebidasPreferidasPorHorario,
  }) {
    return DashboardState(
      contentVentasPorDias: contentVentasPorDias ?? this.contentVentasPorDias,
      contentTamalesMasVendidos:
          contentTamalesMasVendidos ?? this.contentTamalesMasVendidos,
      contentReportePorSucursal:
          contentReportePorSucursal ?? this.contentReportePorSucursal,
      contentBebidasPreferidasPorHorario:
          contentBebidasPreferidasPorHorario ??
          this.contentBebidasPreferidasPorHorario,
    );
  }
}
