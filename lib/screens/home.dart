import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:test_unsplash/screens/detail.dart';
import 'package:test_unsplash/services/strings.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List data;
  String _search = "cat";

  @override
  void initState() {
    super.initState();
    this._loadData();
  }

  Future<String> _loadData() async {
    try {
      var response = await http.get(Strings.fullUrl(_search));

      setState(() {
        var converted = json.decode(response.body);
        data = converted['results'];
      });
    } catch (e) {}
    return 'success';
  }

  Icon searchIcon = Icon(Icons.search);
  Widget navText = Text("Unsplash Test");

  String _imageUrl(int index) {
    return data[index]['urls']['small'];
  }

  _navigationPush(int index) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => DetailScreen(url: _imageUrl(index)))
    );
  }

  Widget _searchIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (this.searchIcon.icon == Icons.search) {
            this.searchIcon = Icon(Icons.cancel);
            this.navText = TextField(
              autofocus: true,
              onChanged: (text) {
                setState(() {
                  _search = text;
                });
                _loadData();
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.white,
                )
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            );
          } else {
            this.searchIcon = Icon(Icons.search);
            this.navText = Text("Unsplash Test");
          }
        });
      },
      icon: searchIcon,
    );
  }

  Widget _textCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _listRow(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            _navigationPush(index);
          },
          child: Image.network(
            _imageUrl(index),
            width: 100,
          ),
        ),
        Container(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _textCell("Author: ${data[index]['user']['name']}"),
                _textCell("Title: ${data[index]['alt_description']}")
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: _listRow(index),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: navText,
        actions: <Widget>[_searchIcon()],
      ),
      body: _listView()
    );
  }
}
