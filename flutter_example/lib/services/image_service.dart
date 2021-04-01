import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ImageService {
  static Future<Uint8List> getImage() async {
    final response = await http.get(
      Uri.encodeFull("https://thispersondoesnotexist.com/image"),
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load Image');
    }
  }
}
