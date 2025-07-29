import 'package:cazuela_chapina_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormState {
  final bool isPosting;
  final bool isValid;
  final String? errorMessage;
  final String? username;
  final String? password;

  const LoginFormState({
    this.isValid = false,
    this.isPosting = false,
    this.errorMessage,
    this.username = "",
    this.password = "",
  });

  LoginFormState copyWith({
    bool? isPosting,
    String? errorMessage,
    String? password,
    String? username,
    bool? isValid,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    errorMessage: errorMessage ?? this.errorMessage,
    password: password ?? this.password,
    username: username ?? this.username,
    isValid: isValid ?? this.isValid,
  );
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;
  LoginFormNotifier({required this.loginUserCallback})
    : super(const LoginFormState());

  void onUsernameChanged(String value) {
    final newUsername = value.trim();
    state = state.copyWith(
      username: newUsername,
      isValid: newUsername.isNotEmpty,
    );
  }

  void onPasswordChanged(String value) {
    final newPassword = value.trim();
    state = state.copyWith(
      password: newPassword,
      isValid: newPassword.isNotEmpty,
    );
  }

  void onFormSubmit() async {
    if (state.isValid && state.isPosting == false) {
      state = state.copyWith(isPosting: true, errorMessage: "no-error");
      await loginUserCallback(state.username!, state.password!);
      state = state.copyWith(isPosting: false, errorMessage: "no-error");
    } else {
      state = state.copyWith(
        errorMessage: "Por favor, complete todos los campos.",
      );
    }
  }
}

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
      final loginUserCallback = ref.watch(authProvider.notifier).login;
      return LoginFormNotifier(loginUserCallback: loginUserCallback);
    });
