import 'package:cazuela_chapina_app/config/constants/environmet.dart';
import 'package:cazuela_chapina_app/features/auth/infraestructure/infaestructure.dart';
import 'package:dio/dio.dart';

class CombosDatasourceImpl {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future<List<dynamic>> obtenerCombos(token) async {
    try {
      final response = await dio.get(
        '/Combos',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.data;
    } catch (e) {
      throw WrongCredentialsError();
    }
  }

  Future<List<dynamic>> realizarVenta(token, combo) async {
    try {
      final response = await dio.post(
        '/ventas',
        data: {
          'horario': "Mañana",
          'tipo': "Combo",
          "precio": combo["precio"],
          "sucursalID": 1,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final responseVenta = response.data;

      final responseVentaCombo = await dio.post(
        '/VentasCombo',
        data: {
          "precio": combo["precio"],
          "comboID": combo["comboID"],
          "ventaID": responseVenta["ventaID"],
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final resultVentaCombo = responseVentaCombo.data;
      return resultVentaCombo;
    } catch (e) {
      throw WrongCredentialsError();
    }
  }
}
