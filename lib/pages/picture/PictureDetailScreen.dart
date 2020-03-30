import 'package:aispeak/api/ProductApi.dart';
import 'package:aispeak/appTheme.dart';
import 'package:aispeak/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:aispeak/fintnessAppTheme.dart';
import 'package:flutter/material.dart';

class PictureDetailScreen extends StatefulWidget {
  final String id;

  const PictureDetailScreen({this.id, Key key})
      : super(key: key);

  @override
  PictureDetailScreenState createState() => PictureDetailScreenState();
}

class PictureDetailScreenState extends State<PictureDetailScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  PageController controller=new PageController();
  AnimationController animationController;
  Animation<double> animation;
  ProductInfoData productInfoData;
  var scrollController = ScrollController();
  double topBarOpacity = 0.0;
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  List<Widget> _pages=List<Widget>();

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    loadData(widget.id);


    super.initState();
  }
  loadData(id) {
    ProductApi.getProduct(id).then((value) {
      setState(() {
        if (value.code == '200' && value.data != null) {
          productInfoData = value.data;

          var src = productInfoData.url.split(",");
          for (var i = 0; i < src.length; i++) {
            _pages.add(
              new ImageContent(
                controller: controller,
                url: src[i],
              ),
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return new Stack(
      children: <Widget>[
        //pageViw
        PageView.builder(
          physics: new AlwaysScrollableScrollPhysics(),
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index];
          },
          //条目个数
          itemCount: productInfoData.url.split(",").length,
        ),
        //圆点指示器
//        new Positioned(
//          bottom: 0.0,
//          left: 0.0,
//          right: 0.0,
//          child: new Container(
//             color: AppTheme.black,
//            padding: const EdgeInsets.all(10.0),
//            child: new Center(
//              child: new DotsIndicator(
//                  controller: _controller,
//                  itemCount: productInfoData.url.split(",").length,
//                  onPageSelected: (int page) {
//                    _controller.animateToPage(
//                      page,
//                      duration: _kDuration,
//                      curve: _kCurve,
//                    );
//                  }),
//            ),
//          ),
//        ),
      ],
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 2.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
//    double selectedness = Curves.easeOut.transform(
//      max(
//        0.0,
//        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
//      ),
//    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * 1;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            color:FintnessAppTheme.white,
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class ImageContent extends AnimatedWidget {
  ImageContent({
    this.controller,
    this.url,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final String url;

  Widget _builImage() {
    return new Container(
      color: AppTheme.black,
        child: new ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: new CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fitWidth,
              imageUrl: url,
              placeholder: (context, url) => new SizedBox(
                width: 24.0,
                height: 24.0,
                child: Image.asset("/assets/fitness_app/imageplaceholder.png")
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            )));
  }

  Widget build(BuildContext context) {
    return new Container(
      child: _builImage(),
    );
  }
}
