import 'package:aispeak/api/ProductApi.dart';
import 'package:aispeak/models/product_model.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import '../../fintnessAppTheme.dart';

class VideoScreen extends StatefulWidget {
  final String id;

  const VideoScreen({Key key, this.id}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with TickerProviderStateMixin {
  final infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  ProductInfoData productInfoData;
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    loadData(widget.id);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  loadData(id) {
    ProductApi.getProduct(id).then((value) {
      setState(() {
        if (value.code == '200' && value.data != null) {
          productInfoData = value.data;
          print("URL:" + productInfoData.url);
          player.setDataSource(productInfoData.url, autoPlay: true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          productInfoData.title,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
            Container(
              color: Colors.transparent,
              child: AspectRatio(
                  aspectRatio:1.5,

                  child: FijkView(
                    fit:FijkFit.fitWidth,
                    color: Colors.transparent,
                    player: player,

                  )),
            ),
//            Positioned(
//              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
//              bottom: 0,
//              left: 0,
//              right: 0,
//              child: Container(
//                decoration: BoxDecoration(
//                  color: FintnessAppTheme.nearlyWhite,
//                  borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(32.0),
//                      topRight: Radius.circular(32.0)),
//                  boxShadow: <BoxShadow>[
//                    BoxShadow(
//                        color: FintnessAppTheme.grey.withOpacity(0.2),
//                        offset: Offset(1.1, 1.1),
//                        blurRadius: 10.0),
//                  ],
//                ),
//              ),
//            ),
//              Positioned(
//                top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
//                right: 35,
//                child: new ScaleTransition(
//                  alignment: Alignment.center,
//                  scale: new CurvedAnimation(
//                      parent: animationController, curve: Curves.fastOutSlowIn),
//                  child: Card(
//                    color: FintnessAppTheme.nearlyBlue,
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(50.0)),
//                    elevation: 10.0,
//                    child: Container(
//                      width: 60,
//                      height: 60,
//                      child: Center(
//                        child: Icon(
//                          Icons.favorite,
//                          color: FintnessAppTheme.nearlyWhite,
//                          size: 30,
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//              Padding(
//                padding:
//                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//                child: SizedBox(
////                width: AppBar().preferredSize.height,
////                height: AppBar().preferredSize.height,
//                  child: Material(
//                    color: Colors.transparent,
//                    child: InkWell(
////                    borderRadius: new BorderRadius.circular(
////                        AppBar().preferredSize.height),
//                      child: Icon(
//                        Icons.arrow_back_ios,
//                        color: FintnessAppTheme.nearlyBlack,
//                      ),
//                      onTap: () {
//                        Navigator.pop(context);
//                      },
//                    ),
//                  ),
//                ),
//              )
        ],
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: FintnessAppTheme.nearlyWhite,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: FintnessAppTheme.grey.withOpacity(0.2),
                offset: Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: FintnessAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: FintnessAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
