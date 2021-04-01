import 'package:flutter_dialogflow/dialogflow_v2.dart';

class DialogFlowService {
  static Future<String> getBotResponse(String query) async {
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/credentials.json")
        .build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    return response.getMessage();
  }
}