import 'package:spedtracker_app/services/user_service.dart';

class UserModel {
  String? idUsuario;
  String nombre;
  String apellido;
  String dni;
  String edad;
  String genero;
  String email;
  String telefono;
  double? montoLimite;
  String? fcm;

  UserModel(
    this.nombre,
    this.apellido,
    this.dni,
    this.edad,
    this.email,
    this.genero,
    this.telefono, {
    this.idUsuario,
    this.montoLimite,
    this.fcm,
  });

  Future<UserModel> visualizar(String token) async {
    UserModel user = await UserService().getUser(token);
    return user;
  }
}
