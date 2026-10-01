abstract final class AppBidi {
  static const String firstStrongIsolate = '\u2068';
  static const String popDirectionalIsolate = '\u2069';

  static String isolate(String text) => '$firstStrongIsolate$text$popDirectionalIsolate';
}
