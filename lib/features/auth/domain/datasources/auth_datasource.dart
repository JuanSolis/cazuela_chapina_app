import 'package:cazuela_chapina_app/features/auth/domain/entities/user.dart';

abstract class AuthDatasource {
  Future<User> login(String username, String password);
  Future<User> register(String username, String password);
  Future<User> checkAuthStatus(String token);
}
