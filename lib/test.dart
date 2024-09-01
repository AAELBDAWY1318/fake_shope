import 'dart:developer';

import 'package:fake_shope_app/data/data_source/remote_data/products_repository.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: TextButton(
            child: const Text("TEST"),
            onPressed: () async {
              String res = await ProductsRepository().deteteFromFav(id: 187265);
              log(res);
            },
          ),
        ),
      ),
    );
  }
}
