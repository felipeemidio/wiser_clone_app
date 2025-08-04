import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/services/api_service.dart';

class AiService {
  static OpenAI? _openAi;
  static Future<void> initialize() async {
    _openAi = OpenAI.instance.build(
      token: dotenv.env['OPEN_API_KEY'],
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true,
    );
  }

  static Future<String> getBookDescription(Book book) async {
    try {
      final request = CompleteText(
        prompt: 'Tell me a brief description about the book ${book.name} by ${book.author}.',
        model: Gpt3TurboInstruct(),
        maxTokens: 200,
      );

      final response = await _openAi!.onCompletion(request: request);
      if (response == null) {
        return "Summary not found.";
      }

      final description = response.choices.first.text.trim();

      await ApiService().editBook(book.copyWith(description: description));
      return description;
    } catch (e) {
      return "Summary not found.";
    }
  }
}
