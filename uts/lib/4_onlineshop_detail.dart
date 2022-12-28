import 'package:flutter/material.dart';
import 'package:uts/1_onlineshop_model.dart';

class OnlineshopDetail extends StatelessWidget {
  final Onlineshop? onlineshop;

  OnlineshopDetail(this.onlineshop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Merek : ${onlineshop!.merek}'),
            Text('Spesifikasi : ${onlineshop!.spesifikasi}'),
            Text('Harga : ${onlineshop!.harga}'),
          ],
        ),
      ),
    );
  }
}
