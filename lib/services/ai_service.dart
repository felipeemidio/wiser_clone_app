import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wiser_clone_app/models/book.dart';

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
      return response == null ? "Summary not found." : response.choices.first.text.trim();
    } catch (e) {
      return "Summary not found.";
    }
  }
}
