


import 'package:flutter/material.dart';

@immutable
class SearchField<F> extends StatelessWidget 
{

  final void Function(String)? onEdit;
  final VoidCallback? onClickDetil;

  const SearchField({

    this.onEdit,
    this.onClickDetil,
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
          this.onClickDetil != null
          ?
          IconButton(
            icon: const Icon(
              Icons.details,
              size: 32,
            ),
            onPressed: this.onClickDetil,
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