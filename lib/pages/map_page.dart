import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import '../service/config_tool.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  AMapController _mapController;

  void onMapCreated(AMapController controller) {
    this.setState(() {
      _mapController = controller;
      // 获取审图号
      getApprovalNumber();
    });
  }

  // 获取审图号
  void getApprovalNumber() async {
    //普通地图审图号
    String mapContentApprovalNumber =
        await _mapController?.getMapContentApprovalNumber();
    //卫星地图审图号
    String satelliteImageApprovalNumber =
        await _mapController?.getSatelliteImageApprovalNumber();
  }

  @override
  Widget build(BuildContext context) {
    //使用默认属性创建一个地图
    final AMapWidget map = AMapWidget(
        onMapCreated: onMapCreated,
        compassEnabled: true, //指南针
        trafficEnabled: true, //路况
        myLocationStyleOptions: MyLocationStyleOptions(true));
    return Scaffold(
        appBar: AppBar(
            backgroundColor: RhColors.colorAppBar,
            brightness: Brightness.dark,
            title: Text(
              '店铺地址',
              style: TextStyle(
                  color: RhColors.colorWhite, fontSize: RhFontSize.fontSize18),
            )),
        body: map);
  }
}
