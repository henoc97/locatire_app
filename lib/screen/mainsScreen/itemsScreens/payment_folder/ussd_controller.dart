import 'package:sim_data/sim_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

class USSDController {
  static Future<int?> getSubscriptionId({required int mnc}) async {
    SimData simData = await SimDataPlugin.getSimData();
    if (simData.cards.length < 2) {
      print("i return -3");
      return -3;
    } else {
      int? sus0;
      int? sus1;
      SimCard sim0 = simData.cards[0];
      SimCard sim1 = simData.cards[1];

      if (sim0.subscriptionId == 0) {
        sus0 = sim0.subscriptionId + 1;
      }else{
        sus0 = sim0.subscriptionId;
      }

      if (sim1.subscriptionId == 0) {
        sus1 = sim1.subscriptionId + 1;
      }else{
        sus1 = sim1.subscriptionId;
      }

      if (sim0.mnc == mnc) {
        return sus0;
      } else if (sim1.mnc == mnc) {
        return sus1;
      } else {
        return -3;
      }
    }
  }

  static Future<void> makeMyRequest({
    required String code,
    required int mnc,
    /*required BuildContext context*/
  }) async {
    try {
      await Permission.phone.request();
      if (!await Permission.phone.isGranted) {
        throw Exception("permission missing");
      }

      try {
        int? suscriptionId = await getSubscriptionId(mnc: mnc);

        if (suscriptionId != null) {
          try {
            if (suscriptionId == -3) {
              await UssdAdvanced.sendUssd(code: code);
              //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No subscription found')));
            } else {
              await UssdAdvanced.sendUssd(
                  code: code, subscriptionId: suscriptionId);
            }
          } catch (e) {
            print(e);
          }
        } else {
          print("suscriptionId null");
        }
      } catch (e) {
        print(e);
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<int> getSimMNC(String cardName) async {
    try {
      SimData simData = await SimDataPlugin.getSimData();
      SimCard? simSelected;

      if (simData.cards.isNotEmpty) {
        for (var element in simData.cards) {
          if (element.displayName == cardName) {
            simSelected = element;
          }
        }

        int mnc = simSelected!.mnc;
        print("mnc : $mnc");
        return mnc;
        
      } else {
        int mnc = -10;
        return mnc;
      }
    } catch (e) {
    throw("Une erreur s'est produite lors de la récupération des informations de la carte SIM : $e");
    }
  }

  static Future<void> getSimName() async {
    SimData simData = await SimDataPlugin.getSimData();
    for (var element in simData.cards) {
      print(element.displayName);
      print("object");
    }
    
  }
}
