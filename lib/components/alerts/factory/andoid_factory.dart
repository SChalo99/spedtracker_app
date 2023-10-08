import 'package:spedtracker_app/components/alerts/factory/abstract_factory.dart';
import 'package:spedtracker_app/components/alerts/products/abstract_alert.dart';
import 'package:spedtracker_app/components/alerts/products/alert_android.dart';

class AndroidFactory implements AbstractFactory {
  @override
  AbstractAlert createAlert() {
    return AndroidAlert();
  }
}
