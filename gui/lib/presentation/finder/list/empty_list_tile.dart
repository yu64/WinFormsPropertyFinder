


import 'package:flutter/material.dart';

@immutable
class EmptyListTile extends StatelessWidget 
{


  const EmptyListTile({
    super.key
  });


  @override
  Widget build(BuildContext context)
  {
    return const ListTile(

      title: Text("検索結果はありません"),
    );
  }

}