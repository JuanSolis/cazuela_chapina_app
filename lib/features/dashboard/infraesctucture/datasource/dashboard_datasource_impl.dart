import 'package:cazuela_chapina_app/config/constants/environmet.dart';
import 'package:cazuela_chapina_app/features/auth/infraestructure/infaestructure.dart';
import 'package:cazuela_chapina_app/features/dashboard/presentation/screens/dashboards/tamales_mas_vendidos_chart.dart';
import 'package:dio/dio.dart';

class DashboardDatasourceImpl {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future<List<dynamic>> ventasDiarias(token) async {
    try {
      final response = await dio.get(
        '/Dashboard/VentasDiarias',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.data;
    } catch (e) {
      throw WrongCredentialsError();
    }
  }

  Future<List<dynamic>> tamalesMasVendidos(token) async {
    try {
      final response = await dio.get(
        '/Dashboard/TamalesMasVendidos',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.data;
    } catch (e) {
      throw WrongCredentialsError();
    }
  }
}
