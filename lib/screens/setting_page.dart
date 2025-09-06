import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class setting_page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",style: TextStyle(fontSize: 30,color:Colors.white),),
      ),
      body: Consumer<theme_provider>(builder: (ctx,provider, __){
        return SwitchListTile.adaptive(
            title: Text("Dark Mode"),
            subtitle: Text("Change theme mode here"),
            value: provider.getTheme(),
            onChanged: (value){
              provider.updateTheme(value: value);
            });
      })
    );
  }
}