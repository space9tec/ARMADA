import 'package:flutter/material.dart';
import '../view/screens/screens.dart';

class ROUTE {
  static Route onGenerateRouth(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    print(settings);

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case Login.routeName:
        return Login.route();
      case SignUp.routeName:
        return SignUp.route();
      case Verify.routeName:
        return Verify.route();
      case ForgetPassword.routeName:
        return ForgetPassword.route();
      case NewPassword.routeName:
        return NewPassword.route();
      case MainScreen.routeName:
        return MainScreen.route();
      case ItemPage.routeName:
        return ItemPage.route();
      case VerifyFarm.routeName:
        return VerifyFarm.route();
      case FarmScreen.routeName:
        return FarmScreen.route();
      case VerifyServiceProvider.routeName:
        return VerifyServiceProvider.route();
      case AddFarm.routeName:
        return AddFarm.route();
      case DisplayNotification.routeName:
        return DisplayNotification.route();
      case FarmerProfile.routeName:
        return FarmerProfile.route();
      case EditFarmerProfile.routeName:
        return EditFarmerProfile.route();
      case UploadFarm.routeName:
        return UploadFarm.route();
      case SearchScreen.routeName:
        return SearchScreen.route();
      case ServiceProviderProfile.routeName:
        return ServiceProviderProfile.route();
      case AddMachine.routeName:
        return AddMachine.route();
      case MachineScreen.routeName:
        return MachineScreen.route();
      case ContractPage.routeName:
        return ContractPage.route();
      case ContractDetailPage.routeName:
        return ContractDetailPage.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text('Error')),
      ),
    );
  }
}
