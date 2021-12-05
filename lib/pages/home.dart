import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool enableEdit = false;
  TextEditingController controller = TextEditingController();

  void _onEditBtnTapped() {
    setState(() {
      enableEdit = !enableEdit;
    });
  }

  Widget _buildMarkdown(String content) {
    return Markdown(data: content);
  }

  Widget _buildTextField(String content) {
    controller.text = content;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: rootBundle.loadString('assets/home.md'),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Container(
              padding: EdgeInsets.all(16),
              child: enableEdit ? 
              _buildTextField(snapshot.data) : 
              _buildMarkdown(snapshot.data),
            );
          }else{
            return Center(
              child: Text("加载中..."),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onEditBtnTapped,
        tooltip: enableEdit ? "预览" : '编辑',
        child: enableEdit ? Icon(Icons.image) : Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
