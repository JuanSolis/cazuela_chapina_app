import 'package:cazuela_chapina_app/config/constants/environmet.dart';
import 'package:cazuela_chapina_app/features/auth/domain/domain.dart';
import 'package:cazuela_chapina_app/features/auth/infraestructure/infaestructure.dart';
import 'package:cazuela_chapina_app/features/auth/infraestructure/mappers/user_mapper.dart';
import 'package:dio/dio.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) async {
    throw UnimplementedError('checkAuthStatus not implemented');
  }

  @override
  Future<User> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/Usuarios/Login',
        data: {'nombreUsuario': username, 'password': password},
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (e) {
      throw WrongCredentialsError();
    }
  }

  @override
  Future<User> register(String username, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
