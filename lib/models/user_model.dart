import 'package:spedtracker_app/services/user_service.dart';

class UserModel {
  String? idUsuario;
  late String nombre;
  late String apellido;
  late String dni;
  late String edad;
  late String genero;
  late String email;
  late String telefono;
  late double montoLimite = 0.0;
  String? fcm;

  UserModel.empty();

  UserModel(
    this.nombre,
    this.apellido,
    this.dni,
    this.edad,
    this.email,
    this.genero,
    this.telefono,
    this.montoLimite, {
    this.idUsuario,
    this.fcm,
  });

  Future<UserModel> visualizar(String token) async {
    UserModel user = await UserService().getUser(token);
    return user;
  }
}
