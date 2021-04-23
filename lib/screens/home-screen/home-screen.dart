import 'package:flutter/material.dart';
import 'package:flutter_bolierplate_example/providers/providers.dart';
import 'package:flutter_bolierplate_example/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(
      BuildContext context, T Function<T>(ProviderBase<Object, T>) watch) {
    final model = watch(homeRepository);
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello world'),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Hello world: ${model.title}'),
              Input(
                keyboardType: TextInputType.text,
                labelText: 'title',
                onChanged: model.setTitle,
              )
            ],
          ),
        ));
  }
}
