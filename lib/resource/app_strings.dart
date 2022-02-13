class AppStrings {
  static String appName = "Zp Assesment";
}

class GQuery {
  static const String getCountriesQuery = '''
    query {
      countries {
        name
        languages {
          code
          name
        }
      }
    }
  ''';

  static const String getCountryLanguageQuery = '''
    query Query {
      languages {
        name
        code
      }
    }
  ''';

  static String countryByCode(String code) {
    return '''
    query Query {
  country(code: "$code") {
    name
  }
}
  ''';
  }
}
