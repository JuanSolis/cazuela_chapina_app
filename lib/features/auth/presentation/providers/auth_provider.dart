import 'package:cazuela_chapina_app/features/auth/domain/domain.dart';
import 'package:cazuela_chapina_app/features/auth/infraestructure/infaestructure.dart';
import 'package:cazuela_chapina_app/features/shared/services/key_value_storage_service.dart';
import 'package:cazuela_chapina_app/features/shared/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositorieImpl();
  final keyValueStorage = KeyValueStorageServiceImpl();
  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorage: keyValueStorage,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorage;
  AuthNotifier({required this.authRepository, required this.keyValueStorage})
    : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> login(String username, String password) async {
    try {
      final user = await authRepository.login(username, password);
      if (user.token.isNotEmpty) {
        _setLoggedUser(user);
      } else {
        throw WrongCredentialsError("Credenciales incorrectas");
      }
    } on WrongCredentialsError catch (e) {
      logout(e.message);
    } catch (e) {
      logout(null);
    }
  }

  Future<void> register(String username, String password) async {
    try {
      final user = await authRepository.register(username, password);
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> checkAuthStatus() async {
    final token = await keyValueStorage.getValue<String>("token");
    if (token == null) logout(null);
    try {
      final user = await authRepository.checkAuthStatus(token ?? "");
      _setLoggedUser(user);
    } catch (e) {
      logout(null);
    }
  }

  void _setLoggedUser(User user) async {
    await keyValueStorage.setKeyValue("token", user.token);
    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: user,
      errorMessage: "",
    );
  }

  Future<void> logout(String? messageError) async {
    await keyValueStorage.removeKey("token");
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
      errorMessage: messageError ?? messageError,
    );
  }
}

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String errorMessage;
  AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage = "",
  });

  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
