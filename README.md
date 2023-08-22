[![pub package](https://img.shields.io/pub/v/auto_exporter.svg)](https://pub.dev/packages/auto_exporter)

# Auto Exporter

A Dart package that allows you to auto export types globally.

## How to use it ?

first: add those to `pubspec.yaml` 
```
dev_dependencies:
  auto_exporter: ^1.4.3
  build_runner: ^2.3.0
  build_test: ^2.1.5
```

second run:
```
 dart run build_runner build  # Dart SDK
 flutter pub run build_runner build  # Flutter SDK
 flutter packages pub run build_runner build # try this on error
```

wait a minute... and you get the export file.

remove your export file and change the `export.dart` to your name.

#### on the last

rename you export.dart to your project name

remember to run this:`dart format .`!

#### hint

`dart pub publish --dry-run` to up your package to pub.dev