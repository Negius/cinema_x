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
      //  appBar: AppBar(
      //   title: const Text('Flutter WebView example'),
      //   // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      //   actions: <Widget>[
      //     NavigationControls(_controller.future),
      //     SampleMenu(_controller.future),
      //   ],
      // ),
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
            if (request.url.startsWith('http://172.16.80.120/CheckOut/VNPayResult?')) {
              setState(() {
                print("Checking out");
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
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            //bat url va xu ly
            if (url.contains("CheckOut/")) {
              setState(() {
                print("Checking out");
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
