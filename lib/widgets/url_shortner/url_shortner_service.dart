import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../auth/secrets.dart' as config;

getShortUrlCuttly({String longUrl = ""}) async {
  if (longUrl != "") {
    var url =
        "https://cutt.ly/api/api.php?key=${config.APIKeys.cuttlyApiKey}&short=$longUrl";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  } else {
    return {};
  }
}
