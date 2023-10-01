import 'dart:convert';

import 'package:allen/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAISercice {
  final List<Map<String, String>> messages = [];

  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer $openAIApikey',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content":
                    "Does this message want to generate an AI image art or anything ?$prompt. Simply answer with yes or no"
              }
            ],
          }));

      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["choices"][0]['message ']['content'];
        content = content.trim();

        switch (content) {
          case 'yes':
          case 'Yes':
          case "Yes.":
          case "yes.":
            final res = await dallEAPI(prompt);
            return res;
          default:
            final res = await chatGPTAPI(prompt);
            return res;
        }
      }
      return "AI internal error occured";
    } catch (e) {
      print('Error: $e');
      final errorMessage = e.toString();
      if (errorMessage.contains('insufficient_quota')) {
        return "You have exceeded your API usage limit. Please upgrade your plan or try again later.";
      } else {
        return "An error occurred while processing your request.";
      }
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer $openAIApikey',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": messages,
          }));

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["choices"][0]['message']['content'];

        content = content.trim();

        messages.add({'role': 'assistant', 'content': prompt});
        return content;
      }
      return "AI internal error occured";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
          Uri.parse("https://api.openai.com/v1/images/generations"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer $openAIApikey',
          },
          body: jsonEncode({
            'prompt': prompt,
            'n': 1,
          }));

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();

        messages.add({
          'role': 'assistant',
          'content': imageUrl,
        });
        return imageUrl;
      }
      return "AI internal error occured";
    } catch (e) {
      return e.toString();
    }
  }
}
