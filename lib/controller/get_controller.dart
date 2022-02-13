import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpassesment/model/countries_model.dart';
import 'package:zpassesment/resorce/message_dialog.dart';
import 'package:zpassesment/services/api_helper.dart';
import 'package:zpassesment/services/enum.dart';


class CountryController extends GetxController{
  final  ApiHelper _apiHelper  =  ApiHelper();
  late Rx<ApiState> countriesApiStatus  = ApiState.loading.obs;
  final Rx<Data> countries = Data().obs;
  final Rx<Countries> country = Countries().obs;
  final RxBool isFilterEnable  =  false.obs;
  late  RxList<Countries> filterListCountry  = <Countries>[].obs;
  final RxList<Languages> language  =  <Languages>[].obs;


  getCountries(BuildContext context ) async{
    try{
      var response  = await _apiHelper.getCountries(context);
      Data _countriesModel  = Data.fromJson(jsonDecode(response));
      countries.value  = _countriesModel;
      getLanguage(context);
      countriesApiStatus.value  =  ApiState.success;
    }catch(e){
      countriesApiStatus.value  =  ApiState.error;
      printError(info: "$e");
    }

  }

  getLanguage(BuildContext context ) async{
    for (var element in countries.value.countries!) {
      language.addAll(element.languages!);
    }
  }

  Future<void> searchCountryByCode(String code,BuildContext context) async{
    try{
      var result = await _apiHelper.getCountryByCode(context: context, code: code);
      if(result.isNotEmpty  ){
        var json = jsonDecode(result);
        if(json['country'] != null){
          country.value  =   Countries.fromJson(json['country']);
        }else{
          showMessageDialog(context, "Country not found");
        }
      }
    }catch(e){
       showMessageDialog(context, "$e");
    }
  }

  void filterCountry(languageName) {
    filterListCountry.clear();
    List<Countries> _tempCountries  = [];
    _tempCountries.addAll(countries.value.countries!);
    for (var element in _tempCountries) {
      for (var e in element.languages!) {
        if(e.name! == languageName){
          filterListCountry.add(element);
        }
      }
    }
  }


  filterToggle(){
    isFilterEnable.value  =  !isFilterEnable.value;
  }


}
