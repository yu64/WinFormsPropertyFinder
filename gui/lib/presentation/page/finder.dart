import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gui/presentation/component/search_list.dart';
import 'package:searchable_listview/searchable_listview.dart';




class FinderPage extends StatefulWidget 
{

  const FinderPage({super.key});

  @override
  State<FinderPage> createState() => _State();
}


class _State extends State<FinderPage> 
{
  @override
  Widget build(BuildContext context) 
  {

    return Scaffold(
      body: new SearchList()
    );
  }

}