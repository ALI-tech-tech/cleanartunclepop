// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multilines;
  final String name;
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.multilines,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextFormField(
                  controller: controller,
                  validator: (val) =>
                      val!.isEmpty ? "$name Can not be empty" : null,
                  decoration: InputDecoration(hintText:name),
                  minLines: multilines?6:1,
                  maxLines: multilines?6:1,
                ),
              ) ;
  }
}
