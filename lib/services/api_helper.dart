import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zpassesment/model/countries_model.dart';
import 'package:zpassesment/resource/app_strings.dart';
import 'package:zpassesment/resource/message_dialog.dart';

class ApiHelper {
  final HttpLink httpLink = HttpLink(
    'https://countries.trevorblades.com/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () => "",
  );
  late Link link;
  late GraphQLClient client;
  Countries? countries;

  ApiHelper() {
    link = authLink.concat(httpLink);
    client = GraphQLClient(link: link, cache: GraphQLCache());
  }

  Future<String> getCountries(BuildContext context) async {

    try{
      final QueryResult result = await client.query(
        QueryOptions(
          document: gql(GQuery.getCountriesQuery),
        ),
      );

      return json.encode(result.data);
    }catch(e){
     showMessageDialog(context, "$e");
     return "";
    }

  }

  Future<String> getLanguages(BuildContext context) async {
    try{
      final QueryResult result = await client.query(
        QueryOptions(
          document: gql(GQuery.getCountryLanguageQuery),
        ),
      );
      return json.encode(result.data!['languages']);
    }catch(e){
      showMessageDialog(context, "$e");
      return "";
    }


  }

  Future<String> getCountryByCode({required BuildContext context, required String code}) async {
    try{
      String query  =  GQuery.countryByCode(code.trim().toUpperCase());
      final QueryResult result = await client.query(
        QueryOptions(
          document: gql(query),
        ),
      );
      if (result.hasException) {
        showMessageDialog(context, "Country Code doesn't exists");
        return "";
      }

      return json.encode(result.data);
    }catch(e){
      showMessageDialog(context, "$e");
      return "";
    }


  }
}
