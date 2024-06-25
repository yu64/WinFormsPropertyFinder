import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gui/presentation/finder/tool/advanced_search.dart';
import 'package:gui/presentation/finder/tool/search_field.dart';

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
        ButtonBar(
          children: [
            TextButton.icon(
              label: Text("更新"), 
              icon: Icon(Icons.autorenew),
              onPressed: () => {}
            )
          ],
        ),

        //検索欄
        const SearchField(
          
        ),

        const AdvancedSearch()
        
      ],
    );
  }
}