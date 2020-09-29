part of 'main.dart';

class WebViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;
  int startTime = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WebView"),
          backgroundColor: Colors.blue,
        ),
        body: Stack(children: <Widget>[
          WebView(
            onWebViewCreated: (_) {
              setState(() {
                startTime = DateTime.now().millisecondsSinceEpoch;
              });
            },
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl:
                'https://medium.com/til-kotlin/how-kotlins-delegated-properties-and-lazy-initialization-work-552cbad8be60',
            onPageFinished: (_) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Text(
                    "It took " +
                        (DateTime.now().millisecondsSinceEpoch - startTime)
                            .toString() +
                        " milliseconds",
                    style: TextStyle(fontSize: 30, color: Colors.red),
                    key: Key("WebsiteText"),
                  ),
                )
        ]));
  }
}
