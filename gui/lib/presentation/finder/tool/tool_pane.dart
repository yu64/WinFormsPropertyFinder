import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/presentation/finder/tool/advanced_search.dart';
import 'package:gui/presentation/finder/tool/search_field.dart';
import 'package:gui/presentation/finder/tool/toolbar.dart';

class ToolPane extends ConsumerWidget
{
  const ToolPane({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    

    return Column(
      children: [
        
        //ツールバー
        const Toolbar(),

        //検索欄
        SearchField(

        ),

        const AdvancedSearch()
        
      ],
    );
  }
}