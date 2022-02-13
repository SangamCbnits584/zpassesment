
class CountriesModel {
  CountriesModel({
      Data? data,}){
    _data = data;
}

  CountriesModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}


class Data {
  Data({
      List<Countries>? countries,}){
    _countries = countries;
}

  Data.fromJson(dynamic json) {
    if (json['countries'] != null) {
      _countries = [];
      json['countries'].forEach((v) {
        _countries?.add(Countries.fromJson(v));
      });
    }
  }
  List<Countries>? _countries;


  set countries(List<Countries>? value) {
    _countries = value;
  }

  List<Countries>? get countries => _countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_countries != null) {
      map['countries'] = _countries?.map((v) => v.toJson()).toList();
      _countries!.sort((a, b){
        return a.name!.trim().toLowerCase().compareTo(b.name!.trim().toLowerCase());
      });
    }
    return map;
  }

}

class Countries {
  Countries({
      String? name, 
      String? code, 
      List<Languages>? languages,}){
    _name = name;
    _code = code;
    _languages = languages;
}

  Countries.fromJson(dynamic json) {
    _name = json['name'];
    _code = json['code'];
    if (json['languages'] != null) {
      _languages = [];
      json['languages'].forEach((v) {
        _languages?.add(Languages.fromJson(v));
      });
    }
  }
  String? _name;
  String? _code;
  List<Languages>? _languages;

  String? get name => _name;
  String? get code => _code;
  List<Languages>? get languages => _languages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['code'] = _code;
    if (_languages != null) {
      map['languages'] = _languages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Languages {
  Languages({
      String? code, 
      String? name,}){
    _code = code;
    _name = name;
}

  Languages.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
  }
  String? _code;
  String? _name;

  String? get code => _code;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    return map;
  }

}