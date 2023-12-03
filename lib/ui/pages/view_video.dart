import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewVideoPage extends HookWidget {
  const ViewVideoPage({Key? key, required this.videoUrl}) : super(key: key);

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    final webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(videoUrl));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: WebViewWidget(controller: webviewController),
    );
  }
}
