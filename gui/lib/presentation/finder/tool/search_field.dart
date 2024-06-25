


import 'package:flutter/material.dart';

@immutable
class SearchField<F> extends StatelessWidget 
{

  final void Function(String)? onEdit;
  final VoidCallback? onClear;

  const SearchField({

    this.onEdit,
    this.onClear,
    super.key
  });
  


  @override
  Widget build(BuildContext context)
  {
    return TextField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: this.onEdit,
      onSubmitted: this.onEdit,

      

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: (
          this.onClear != null
          ?
          IconButton(
            icon: const Icon(
              Icons.clear,
              size: 32,
            ),
            onPressed: this.onClear,
          )
          :
          null
        ),
        
        hintText: 'hintText',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

}