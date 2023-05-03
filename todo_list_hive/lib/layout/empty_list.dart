import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: const [
            Image(image: AssetImage('assets/images/logo_trans.png')),
            SizedBox(
              height: 50,
            ),
            Text(
              'Nothing to do...',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
