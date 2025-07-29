import 'package:cazuela_chapina_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:cazuela_chapina_app/features/auth/presentation/providers/providers.dart';
import 'package:cazuela_chapina_app/features/shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GeometricalBackground(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),

                const SizedBox(height: 200),

                Container(
                  height:
                      size.height - 260, // 80 los dos sizebox y 100 el ícono
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child: const _LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      print("Error Message ${next.errorMessage}");
      if (next.errorMessage.isEmpty) return;
      showSnackBar(context, next.errorMessage);
    });
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text('Ingresar', style: textStyles.titleLarge),
          const SizedBox(height: 30),

          CustomTextFormField(
            label: 'Usuario',
            keyboardType: TextInputType.emailAddress,
            onChanged:
                (value) => ref
                    .read(loginFormProvider.notifier)
                    .onUsernameChanged(value),
            errorMessage:
                loginForm.errorMessage == "no-error"
                    ? null
                    : loginForm.errorMessage,
          ),
          const SizedBox(height: 30),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged:
                (value) => ref
                    .read(loginFormProvider.notifier)
                    .onPasswordChanged(value),
            errorMessage:
                loginForm.errorMessage == "no-error"
                    ? null
                    : loginForm.errorMessage,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: loginForm.isPosting ? 'cargando...' : 'Ingresar',
              buttonColor: Colors.black,
              onPressed: () {
                loginForm.isPosting
                    ? null
                    : ref.read(loginFormProvider.notifier).onFormSubmit();
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes cuenta?'),
              TextButton(
                onPressed: () => context.push('/register'),
                child: const Text('Crea una aquí'),
              ),
            ],
          ),

          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
