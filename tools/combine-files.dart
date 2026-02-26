import 'dart:io';

void main() {
  print('🔄 Combining Flutter project files...');

  final projectRoot = Directory.current.path;
  final outputFile = '$projectRoot/tools/riverpod_combined.txt';

  // Extensions we care about
  final allowedExtensions = [
    '.dart',
    '.yaml',
    '.yml',
    '.json',
    '.arb',
    '.md',
    '.example'
  ];

  // Folders to skip (platform-specific, builds, etc.)
  final excludedFolders = [
    '.dart_tool',
    'build',
    'android',
    'ios',
    'windows',
    'linux',
    'macos',
    'web',
    '.idea',
    '.git',
    'test',
    'tests',
    '__tests__'
  ];

  // Files to skip
  final excludedFiles = [
    '.DS_Store',
    'pubspec.lock',
    '.flutter-plugins',
    '.flutter-plugins-dependencies',
    '.metadata',
    '.packages'
  ];

  // Always include these core files
  final alwaysIncludeFiles = [
    'pubspec.yaml',
    'README.md',
    '.env.example',
    'analysis_options.yaml',
    '.gitignore'
  ];

  // Collect files
  final files = <Map<String, String>>[];
  void collectFiles(Directory dir, String relativeBase) {
    for (final entity in dir.listSync()) {
      final relative = entity.path.substring(relativeBase.length + 1);

      if (entity is Directory) {
        if (excludedFolders.any((f) => relative.startsWith(f))) continue;
        collectFiles(entity, relativeBase);
        continue;
      }

      if (entity is File) {
        if (excludedFiles.contains(entity.uri.pathSegments.last)) continue;

        final ext =
            entity.path.substring(entity.path.lastIndexOf('.')).toLowerCase();
        final filename = entity.uri.pathSegments.last;

        if (allowedExtensions.contains(ext) ||
            alwaysIncludeFiles.contains(filename)) {
          files.add({'path': entity.path, 'relative': relative});
        }
      }
    }
  }

  collectFiles(Directory(projectRoot), projectRoot);

  // Sort files
  files.sort((a, b) => a['relative']!.compareTo(b['relative']!));

  // Generate folder tree
  String generateTree(String dirPath, String prefix) {
    var tree = '';
    final entities = Directory(dirPath).listSync()
      ..sort((a, b) => a.path.compareTo(b.path));

    for (var i = 0; i < entities.length; i++) {
      final entity = entities[i];
      final relative = entity.path.substring(projectRoot.length + 1);
      if (excludedFolders.any((f) => relative.startsWith(f))) continue;

      final isLast = i == entities.length - 1;
      final connector = isLast ? '└── ' : '├── ';
      tree += '$prefix$connector${entity.uri.pathSegments.last}\n';

      if (entity is Directory) {
        tree += generateTree(entity.path, prefix + (isLast ? '    ' : '│   '));
      }
    }
    return tree;
  }

  // Detect type
  String detectType(String filepath) {
    final lower = filepath.toLowerCase();
    if (lower.contains('/lib/features/')) return 'Feature Module';
    if (lower.contains('/lib/core/')) return 'Core Layer';
    if (lower.contains('/lib/data/')) return 'Data Layer';
    if (lower.contains('/lib/domain/')) return 'Domain Layer';
    if (lower == 'pubspec.yaml') return 'Dependencies & Config';
    if (lower.endsWith('.arb')) return 'Localization';
    if (lower.endsWith('.md')) return 'Documentation';
    return 'Dart Source File';
  }

  // Build output content
  var content = '''
# M1 Mobile Flutter Boilerplate – Full Code Export
Generated: ${DateTime.now().toIso8601String()}

=========================================
📂 PROJECT STRUCTURE
=========================================

${generateTree(projectRoot, '')}

=========================================
📦 SOURCE FILES
=========================================

''';

  for (final file in files) {
    final fileContent = File(file['path']!).readAsStringSync();
    final sizeKB = (fileContent.length / 1024).toStringAsFixed(2);
    final type = detectType(file['relative']!);

    content += '''
============================================================
FILE: ${file['relative']}
TYPE: $type
SIZE: $sizeKB KB
============================================================

${fileContent.trim()}

============================================================


''';
  }

  File(outputFile).writeAsStringSync(content);
  print('✅ Done! Output saved to: $outputFile');
}

// Run: dart tools/combine-files.dart
