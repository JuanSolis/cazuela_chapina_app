import 'package:cazuela_chapina_app/features/auth/domain/domain.dart';
import 'package:cazuela_chapina_app/features/auth/infraestructure/infaestructure.dart';

class AuthRepositorieImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositorieImpl({AuthDatasource? datasource})
    : datasource = datasource ?? AuthDatasourceImpl();
  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String username, String password) {
    return datasource.login(username, password);
  }

  @override
  Future<User> register(String username, String password) {
    return datasource.login(username, password);
  }
}
