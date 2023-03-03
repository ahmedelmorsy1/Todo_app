import 'package:flutter/material.dart';

//todo:28
class CustomFormField extends StatelessWidget {
  String? returnedtext , title;
   Icon? icon;
   void Function()? onTap;
   TextEditingController? controller = TextEditingController();
   TextInputType? type ;
   bool? enabled;

   CustomFormField({this.title , this.returnedtext, this.icon,
    this.onTap ,this.controller ,this.type =TextInputType.text ,this.enabled =true });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        icon: Icon(Icons.title),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return returnedtext;
        }
        return null;
      },
      onTap: onTap,
    );
  }
}
