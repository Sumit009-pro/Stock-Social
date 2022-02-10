import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/models/about_model.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/post_model.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:html/dom.dart' as dom;


class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> with SingleTickerProviderStateMixin {
  bool process = true;
  Content? content;
  // FollowingModel following
  late AnimationController _controller;
  Animation? gradientPosition;
  var htmlData;

  @override
  void initState() {
    // TODO: implement initState
    fetchTerms();
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);
    gradientPosition = Tween<double>(  begin: -3, end: 10,
    ).animate(  CurvedAnimation( parent: _controller, curve: Curves.linear  ),
    )..addListener(() { if(process) setState(() { }); });
    _controller.repeat();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  void fetchTerms() async {
    final response = await API.terms({
      'pageName':'terms'
    });
    print(response.toString());
    if (response["STATUSCODE"] == 200) {
      var rest = response["response_data"]['content'] ;

      setState(() {

        // content =
        //     rest['content'] as Content;
        print("SSSSSSSSSSSSSSSS : 200 ${rest['content']}");

        htmlData = rest['content'];
        process = false;
      });
    } else {
      setState(() {
        process = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(response["message"]))));
    }
  } //func







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Color(0XFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: (30 / 24),
            fontFamily: "Roboto",
          ),
        ),
        elevation: 0,
        actions: [
          new Stack(
            children: <Widget>[
              new IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Color(0XFFE5E5E5),
                  ),
                  onPressed: () {}),
              new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Color(0XFFFE99AC),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          new IconButton(
              icon: Icon(
                Icons.mail,
                color: Color(0XFFE5E5E5),
                size: 22,
              ),
              onPressed: () {}),
        ],
      ),
      body: process
          ?
      Center(child: CircularProgressIndicator())
          :
      // Text(''),

      SafeArea(

        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Html(
              data: htmlData,
              // tagsList: Html.tags..addAll(["bird", "flutter"]),
              // style: {
              //   "table": Style(
              //     // backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
              //   ),
              //   "tr": Style(
              //     border: Border(bottom: BorderSide(color: Colors.grey)),
              //   ),
              //   "th": Style(
              //     padding: EdgeInsets.all(6),
              //     backgroundColor: Colors.grey,
              //   ),
              //   "td": Style(
              //     padding: EdgeInsets.all(6),
              //     alignment: Alignment.topLeft,
              //   ),
              //   'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
              // },
              // customRender: {
              //   "table": (context, child) {
              //     return SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child:
              //       (context.tree as TableLayoutElement).toWidget(context),
              //     );
              //   },
              //   "bird": (RenderContext context, Widget child) {
              //     return TextSpan(text: "🐦");
              //   },
              //   "flutter": (RenderContext context, Widget child) {
              //     return FlutterLogo(
              //       style: (context.tree.element!.attributes['horizontal'] != null)
              //           ? FlutterLogoStyle.horizontal
              //           : FlutterLogoStyle.markOnly,
              //       textColor: context.style.color!,
              //       size: context.style.fontSize!.size! * 5,
              //     );
              //   },
              // },
              // customImageRenders: {
              //   networkSourceMatcher(domains: ["flutter.dev"]):
              //       (context, attributes, element) {
              //     return FlutterLogo(size: 36);
              //   },
              //   networkSourceMatcher(domains: ["mydomain.com"]):
              //   networkImageRender(
              //     headers: {"Custom-Header": "some-value"},
              //     altWidget: (alt) => Text(alt ?? ""),
              //     loadingWidget: () => Text("Loading..."),
              //   ),
              //   // On relative paths starting with /wiki, prefix with a base url
              //       (attr, _) =>
              //   attr["src"] != null && attr["src"]!.startsWith("/wiki"):
              //   networkImageRender(
              //       mapUrl: (url) => "https://upload.wikimedia.org" + url!),
              //   // Custom placeholder image for broken links
              //   networkSourceMatcher():
              //   networkImageRender(altWidget: (_) => FlutterLogo()),
              // },
              onLinkTap: (url, _, __, ___) {
                print("Opening $url...");
              },
              onImageTap: (src, _, __, ___) {
                print(src);
              },
              onImageError: (exception, stackTrace) {
                print(exception);
              },
              onCssParseError: (css, messages) {
                print("css that errored: $css");
                print("error messages:");
                messages.forEach((element) {
                  print(element);
                });
              },
            ),
          ),
        ),
      ),
    );
    // );
  }
}
