import 'package:flutter/widgets.dart';

Widget showIcon(String icon) {
  return FadeInImage.assetNetwork(
    placeholder: 'assets/images/loading.gif',
    image: 'http://openweathermap.org/img/wn/$icon@2x.png',
    height: 100,
    width: 100,
  );
}
