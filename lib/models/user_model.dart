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
  double? montoLimite;
  String? fcm;

  UserModel.empty();

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
  /*2
  Future<UserModel> visualizar(String token) async {
    UserModel user = await UserService().getUser(token);
    return user;
  }
  2*/
}

