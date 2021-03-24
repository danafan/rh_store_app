import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoView extends StatefulWidget {
    Map arguments;
    PhotoView({this.arguments});
    @override
    _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
    List images=[];
    int index=0;
    String heroTag;
    PageController controller;
    int currentIndex=0;

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        images = widget.arguments['images'];
        currentIndex=widget.arguments['index'];
        heroTag=widget.arguments['heroTag'];
        controller=PageController(initialPage: widget.arguments['index']);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Stack(
                children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Container(
                            child: PhotoViewGallery.builder(
                                scrollPhysics: const BouncingScrollPhysics(),
                                builder: (BuildContext context, int index) {
                                    return PhotoViewGalleryPageOptions(
                                        imageProvider: NetworkImage(this.images[index]),
                                        heroAttributes: this.heroTag.isNotEmpty?PhotoViewHeroAttributes(tag: this.heroTag):null,
                                        
                                    );
                                },
                                itemCount: this.images.length,
                                loadingChild: Container(),
                                backgroundDecoration: null,
                                pageController: this.controller,
                                enableRotation: true,
                                onPageChanged: (index){
                                    setState(() {
                                        currentIndex=index;
                                    });
                                },
                            )
                        ),
                    ),
                    Positioned(//图片index显示
                        top: MediaQuery.of(context).padding.top+15,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text("${currentIndex+1}/${this.images.length}",style: TextStyle(color: Colors.white,fontSize: 16)),
                        ),
                    ),
                    Positioned(//右上角关闭按钮
                        right: 10,
                        top: MediaQuery.of(context).padding.top,
                        child: IconButton(
                            icon: Icon(Icons.close,size: 30,color: Colors.white,),
                            onPressed: (){
                                Navigator.of(context).pop();
                            },
                        ),
                    ),
                ],
            ),
        );
    }
}
