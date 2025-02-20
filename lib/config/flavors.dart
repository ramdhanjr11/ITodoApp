enum Flavor {
  sit,
  uat,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.sit:
        return 'ITodo SIT';
      case Flavor.uat:
        return 'ITodo UAT';
      case Flavor.prod:
        return 'ITodo';
      default:
        return 'title';
    }
  }
}
