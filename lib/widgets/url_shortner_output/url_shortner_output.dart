import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../constants/constants_strings.dart' as constants;
import '../../models/short_url_output_model.dart';

class UrlShortnerOutput extends StatefulWidget {
  /*
    Route Name: URL Shortner Output
  */
  static const routeName = "/urlOutput";

  const UrlShortnerOutput({Key? key}) : super(key: key);

  @override
  State<UrlShortnerOutput> createState() => _UrlShortnerOutputState();
}

class _UrlShortnerOutputState extends State<UrlShortnerOutput> {
  handleCopyToClipboard(String url) {
    Clipboard.setData(ClipboardData(text: url)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          margin: EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
          content: Text(
            constants.UrlShortnerConstants.copyToastText,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UrlShortnerOutputModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: ListTile(
                onTap: (() => handleCopyToClipboard(args.shortUrl)),
                title: Text(
                  args.shortUrl,
                ),
                trailing: const Icon(
                  Icons.copy_outlined,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              elevation: 0,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).canvasColor,
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                  ),
                ),
                child: const Text(
                  constants.UrlShortnerConstants.generateAnotherLink,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
