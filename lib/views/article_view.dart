import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String model;
  const ArticleView({Key? key, required this.model}) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late WebViewController? _controller;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller!.canGoBack()) {
          _controller!.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E2F41),
          elevation: 0.0,
          title: const Text(
            'NewsYack',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                if (await _controller!.canGoBack()) {
                  _controller!.goBack();
                }
              },
              icon: const Icon(Icons.arrow_back),
            ),
            IconButton(
              onPressed: () async {
                if (await _controller!.canGoForward()) {
                  _controller!.goForward();
                }
              },
              icon: const Icon(
                Icons.arrow_forward,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.model,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
              onPageFinished: (String url) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

// class ArticleView extends StatefulWidget {
//   final dynamic model;
//   const ArticleView({super.key, required this.model});
//
//   @override
//   State<ArticleView> createState() => _ArticleViewState();
// }
//
// class _ArticleViewState extends State<ArticleView> {
//   bool isLoading = true;
//   @override
//   Widget build(BuildContext context) {
//     final controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(
//         Uri.parse(widget.model),
//       );
//     return WillPopScope(
//       onWillPop: () async {
//         if (await controller.canGoBack()) {
//           controller.goBack();
//           return false;
//         } else {
//           return true;
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF2E2F41),
//           elevation: 0.0,
//           title: const Text(
//             'NewsYack',
//             style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () async {
//                 if (await controller.canGoBack()) {
//                   controller.goBack();
//                 }
//               },
//               icon: const Icon(Icons.arrow_left),
//             ),
//             IconButton(
//               onPressed: () async {
//                 if (await controller.canGoForward()) {
//                   controller.goForward();
//                 }
//               },
//               icon: const Icon(
//                 Icons.arrow_right,
//               ),
//             ),
//           ],
//         ),
//         body: WebViewWidget(
//           controller: controller,
//         ),
//       ),
//     );
//   }
// }
