import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gui/presentation/component/searchable_property_list.dart';




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
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          physics: const BouncingScrollPhysics(),
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad
          },
        ),
        child: const SearchablePropertyList(list: ["A", "AB", "ABC"])
      )
    );
  }

}