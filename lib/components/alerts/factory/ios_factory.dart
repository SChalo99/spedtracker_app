import 'package:spedtracker_app/components/alerts/factory/abstract_factory.dart';
import 'package:spedtracker_app/components/alerts/products/abstract_alert.dart';
import 'package:spedtracker_app/components/alerts/products/alert_ios.dart';

class IOSFactory implements AbstractFactory {
  @override
  AbstractAlert createAlert() {
    return IOSAlert();
  }
}

