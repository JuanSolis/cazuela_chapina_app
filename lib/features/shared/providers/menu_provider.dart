import 'package:cazuela_chapina_app/features/dashboard/infraesctucture/datasource/dashboard_datasource_impl.dart';
import 'package:cazuela_chapina_app/features/dashboard/presentation/screens/dashboards/tamales_mas_vendidos_chart.dart';
import 'package:cazuela_chapina_app/features/shared/services/key_value_storage_service.dart';
import 'package:cazuela_chapina_app/features/shared/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cazuela_chapina_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuState {
  final int navDrawerIndex;

  const MenuState({required this.navDrawerIndex});

  MenuState copyWith({int? navDrawerIndex}) =>
      MenuState(navDrawerIndex: navDrawerIndex ?? this.navDrawerIndex);
}

class MenuNotifier extends StateNotifier<MenuState> {
  MenuNotifier() : super(const MenuState(navDrawerIndex: 0));

  void onDestinationSelected(int value) {
    state = state.copyWith(navDrawerIndex: value);
  }
}

final menuProvider = StateNotifierProvider<MenuNotifier, MenuState>((ref) {
  return MenuNotifier();
});
