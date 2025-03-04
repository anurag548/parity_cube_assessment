import 'dart:io';

String fixture(String fileName) =>
    File('test/src/fixture/$fileName').readAsStringSync();
