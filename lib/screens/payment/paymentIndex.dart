import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/screens/payment/paymentCheckout.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentIndexPage extends StatefulWidget {
  PaymentIndexPage({@required this.url}) : super();
  final String url;
  @override
  _PaymentIndexPageState createState() => _PaymentIndexPageState();
}

class _PaymentIndexPageState extends State<PaymentIndexPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  // String url = widget.url;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          // ignore: prefer_collection_literals
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(PaymentUrl.vnpayResult)) {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentCheckoutPage(
                              url: request.url,
                            )));
                // this.deactivate();
              });
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            //bat url va xu ly
            if (url.contains("CheckOut/")) {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentCheckoutPage(
                              url: url,
                            )));
                // this.deactivate();
              });
            }
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                final String url = await controller.data.currentUrl();
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Favorited $url')),
                );
              },
              child: const Icon(Icons.favorite),
            );
          }
          return Container();
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
