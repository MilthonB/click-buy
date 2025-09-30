

import 'package:flutter/material.dart';

class SecctionTitleShared extends StatelessWidget {
  final String nameSection;
  final String? seeMore;
  const SecctionTitleShared({super.key, required this.nameSection, this.seeMore});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            Text(nameSection, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Spacer(),
            if(seeMore != null) // Aqui tienes que hacear un tap
              Text('$seeMore >', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}