## Dart Prodata Util

Package auxiliar para o desenvolvimento de projetos no Flutter.

## Como usar

Adicione a linha abaixo no pubspec.yaml.

```yaml
dart_prodata_util:
  git:
    url: https://github.com/prodata-informatica-caratinga/dart_prodata_util.git
    ref: main
```

Depois adicione a navigatorKey no seu MaterialApp.

```dart
import 'package:dart_prodata_util/dart_prodata_util.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      key: Config.navigatorKey, // Adicione essa linha
    );
  }
}
```

Por fim sobrescrevaa função didChangeDependencies na sua Splash Screen e chame a função initConfig.

``` dart
@override
void didChangeDependencies() {
  Config.initConfig(context);
  super.didChangeDependencies();
}
```