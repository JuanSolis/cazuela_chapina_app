import 'package:cazuela_chapina_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterProviderNotifier = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;

  AuthStatus _authState = AuthStatus.unknown;

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      _authState = state.status;
      notifyListeners();
    });
  }

  AuthStatus get authStatus => _authState;

  set authState(AuthStatus value) {
    _authState = value;
    notifyListeners();
  }
}
