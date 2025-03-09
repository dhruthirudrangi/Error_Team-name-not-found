import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class ChatbotService {
  final String apiKey =
      "AIzaSyAqeptPMdi-UjbaLi13QQCoi7gx5RKpa6w"; // Replace with your actual API key
  final String model = "gemini-pro";
  final String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent";

  // Function to get chatbot response
  Future<String> getResponse(String userMessage) async {
    try {
      final Map<String, dynamic> requestBody = {
        "prompt": {
          "text":
              "As a supportive counselor for domestic violence victims, provide a compassionate, detailed, and encouraging response to this message. Focus on empowerment, safety, and practical next steps. Message: $userMessage",
        },
      };

      final response = await http.post(
        Uri.parse("$apiUrl?key=$apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content'] ??
            "I'm here to help. You are not alone.";
      } else {
        return _getFallbackResponse();
      }
    } catch (e) {
      return _getFallbackResponse();
    }
  }

  // Fallback responses for error handling
  String _getFallbackResponse() {
    List<String> supportiveResponses = [
      "I'm so sorry that you're going through this. You don’t deserve to be hurt, and you're not alone. Please reach out to someone you trust or a local support service. If you're in immediate danger, please call emergency services or a domestic violence helpline in your area. Your safety is the most important thing.",
    ];
    return supportiveResponses[Random().nextInt(supportiveResponses.length)];
  }
}
