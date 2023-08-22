import 'package:build/build.dart';
import 'package:glob/glob.dart';

/// the ExportsBuilder will create the file to
/// export all dart files
// class ExportsBuilder implements Builder {
//   @override
//   Map<String, List<String>> get buildExtensions {
//     return {
//       r'$lib$': ['.library.g.dart'],
//     };
//   }

//   static String packageName = 'export';

//   @override
//   Future<void> build(BuildStep buildStep) async {
//     final exports = buildStep.findAssets(Glob('**/*.exports'));

//     final libs = <String, List<String>>{};

//     await for (final exportLibrary in exports) {
//       final url = exportLibrary.changeExtension('.dart').uri.toString();
//       final urlSplitted = url.split('/');
//       final libType = urlSplitted[2] == 'feature'
//           ? _LibType.feature
//           : urlSplitted[2] == 'core'
//               ? _LibType.core
//               : throw Exception('Unknown LibType');
//       final libName =
//           libType == _LibType.feature ? urlSplitted[3] : urlSplitted[2];

//       print(libType.toString() + '\n' + libName + '\n' + url);

//       if (url.substring(0, 5) != 'asset') {
//         if (url != 'package:$packageName/$packageName.dart') {
//           if (libs[libName] == null) libs[libName] = [];
//           libs[libName]?.add("export '$url';");
//         }
//       }
//     }

//     libs.forEach((key, value) async {
//       if (value.isNotEmpty) {
//         await buildStep.writeAsString(
//           AssetId(buildStep.inputId.package, 'lib/$key.library.g.dart'),
//           value.join('\n'),
//         );
//       }
//     });
//   }
// }

// enum _LibType { core, feature }

class ExportsBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions {
    return {
      r'$lib$': ['export.dart'],
    };
  }

  static String packageName = 'export';
  @override
  Future<void> build(BuildStep buildStep) async {
    final exports = buildStep.findAssets(Glob('**/*.exports'));

    final expList = <String>[];
    final content = [
      '// run this to reset your file:  dart run build_runner build',
      '// or use flutter:               flutter packages pub run build_runner build',
      '// remenber to format this file, you can use: dart format',
      '// publish your package hint: dart pub publish --dry-run',
      '// if you want to update your packages on power: dart pub upgrade --major-versions',
    ];
    await for (final exportLibrary in exports) {
      final exportUri = exportLibrary.changeExtension('.dart').uri;
      if (exportUri.toString().substring(0, 5) != 'asset') {
        if (exportUri.toString() != 'package:$packageName/$packageName.dart') {
          final expStr = "export '$exportUri';";
          expList.add(expStr);

          // if (content[2] == "") {
          //   packageName = expStr.split("/")[0].split(":")[1];
          //   content[2] = "// " + packageName;
          // }
        }
      }
    }

    content.addAll(expList);
    if (content.isNotEmpty) {
      await buildStep.writeAsString(
        AssetId(buildStep.inputId.package, 'lib/export.dart'),
        content.join('\n'),
      );
    }
  }
}
