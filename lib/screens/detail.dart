import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String url;
  const DetailScreen({Key key, this.url}) : super(key: key);

  Widget _bodyImage(BuildContext context) {
    return Container(
      child: new Row(
        children: <Widget>[
          new Image.network(
            url,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ), 
      ),
      body: _bodyImage(context)
    );
  }
}
