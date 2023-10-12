import 'package:spedtracker_app/services/user_service.dart';

class UserModel {
  String? idPersona;
  String nombre;
  String apellido;
  String dni;
  String edad;
  String genero;
  String email;
  String telefono;
  double? montoLimite;

  UserModel(
    this.nombre,
    this.apellido,
    this.dni,
    this.edad,
    this.email,
    this.genero,
    this.telefono, {
    this.idPersona,
    this.montoLimite,
  });

  Future<UserModel> visualizar(String token) async {
    UserModel user = await UserService().getUser(token);
    return user;
  }
}
