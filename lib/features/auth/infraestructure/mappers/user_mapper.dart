import 'package:cazuela_chapina_app/features/auth/domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) {
    return User(
      id: json['usuario']["usuarioId"] ?? 0,
      username: json['usuario']['nombreUsuario'] ?? "usuario",
      token: json['token'] ?? "",
      name: json['usuario']['nombre'] ?? "",
      role: json['usuario']['role'] ?? "",
    );
  }
}
