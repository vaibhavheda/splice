import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:splice/widgets/url_shortner/url_shortner_service.dart';

import 'package:http/http.dart' as http;
import '../../auth/secrets.dart' as config;
import '../../constants/constants_strings.dart' as constants;

/*
  This Widget is for the Main screen where we will add the screen to add url
  then a button to shorten the URL.
 */
class URLShortnerScreen extends StatefulWidget {
  const URLShortnerScreen({Key? key}) : super(key: key);

  @override
  State<URLShortnerScreen> createState() => _URLShortnerScreenState();
}

class _URLShortnerScreenState extends State<URLShortnerScreen> {
  /*
  Controller for the input field
  */
  final TextEditingController _urlInputController = TextEditingController();
  late String shortUrl;
  @override
  void initState() {
    // TODO: implement initState
    shortUrl = "";
    _urlInputController.addListener(() {
      // Remove the prefix of https://
      final String newText = _urlInputController.text.replaceFirst(
          RegExp(constants.UrlShortnerConstants.urlInputLablePrefix), "");
      // save the new value
      _urlInputController.value = _urlInputController.value.copyWith(
        text: newText,
        selection: TextSelection(
            baseOffset: newText.length, extentOffset: newText.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _urlInputController.dispose();
    super.dispose();
  }

  _shortenURL() async {
    try {
      String longUrl = _urlInputController.text;
      var url =
          "https://cutt.ly/api/api.php?key=${config.APIKeys.cuttlyApiKey}&short=$longUrl";
      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      if (json['url']['shortLink'] != null) {
        setState(() {
          shortUrl = json['url']['shortLink'];
          _urlInputController.clear();
        });
        debugPrint(json['url']['shortLink']);
      }
      // if (json.url.status == 7)
      // setState(() {
      //   shortUrl:

      // });
    } catch (err) {
      debugPrint("Error: Fetching Short link failure ,${err}");
    }
  }

  handleClick() {
    if (_urlInputController.text != "") _shortenURL();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _shortenURL(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixText:
                      constants.UrlShortnerConstants.urlInputLablePrefix,
                  border: UnderlineInputBorder(),
                  labelText: constants.UrlShortnerConstants.urlInputLabelText,
                ),
                controller: _urlInputController,
              ),
            ),
            TextButton(
              onPressed: handleClick,
              child:
                  const Text(constants.UrlShortnerConstants.generateUrlButton),
            ),
            Text(shortUrl)
          ],
        );
      },
    );
  }
}
