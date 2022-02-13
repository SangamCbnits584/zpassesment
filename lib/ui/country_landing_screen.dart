import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpassesment/controller/get_controller.dart';
import 'package:zpassesment/model/countries_model.dart';
import 'package:zpassesment/services/enum.dart';
import 'package:zpassesment/ui/search_country_by_code_screen.dart';

class CountryLandingScreen extends StatefulWidget {
  const CountryLandingScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CountryLandingScreenState createState() => _CountryLandingScreenState();
}

class _CountryLandingScreenState extends State<CountryLandingScreen> {
  final controller = Get.put(CountryController());
  CountriesModel? _filterCountries;
  bool enableFilter  =  false;
  String _languageName = "";
  @override
  void initState() {
    controller.getCountries(context);
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchCountryNameByCode()));
            },
            icon: const Icon(Icons.search),
          ),
          Obx((){
           return  controller.isFilterEnable.value ?IconButton(
                onPressed: () {
                  controller.filterListCountry.clear();
                  controller.filterToggle();
              _filterCountries = null;
              // countryProvider.refreshScreen();
            },
            icon:  const Icon(Icons.close),
            ):IconButton(
              onPressed: () {
                controller.filterListCountry.clear();
                controller.filterToggle();
                showFilterSheet();
              },
              icon:const Icon(Icons.filter_alt_outlined),
            );
          }),
        ],
      ),
      body:Column(
        children: [
          if (_filterCountries != null)
            Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text('${_filterCountries!.data!.countries!.length} is filter')),
          Expanded(
            child: Obx(() {
                return controller.countriesApiStatus.value == ApiState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : !controller.isFilterEnable.value
                        ? _buildList(controller.countries.value)
                        : _buildFilterList(controller.filterListCountry);
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(Data countriesModel) {
    return  ListView.builder(
        itemCount: countriesModel.countries!.length,
        itemBuilder: (context, index) {
          final countryName = countriesModel.countries![index].name!;
          final countryLanguage = countriesModel.countries![index].languages!;
          return Card(
            child: ListTile(
              title: Text(countryName),
              subtitle: countryLanguage.isNotEmpty
                  ? Text(countryLanguage[0].name!)
                  : const Text(""),
            ),
          );
        });
  }

  Widget _buildFilterList(List<Countries>? countries) {
        return countries != null ? ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final countryName = countries[index].name!;
              return ListTile(
                title: Text(countryName),
                subtitle: _languageName.isNotEmpty
                    ? Text(_languageName)
                    : const Text("No Countries"),
              );
            }):const Center(child:  Text("No Countries"));
  }

  showFilterSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(() {
              return ListView.builder(
                 padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: controller.language.length,
                  itemBuilder: (context, index) {
                    final name =  controller.language[index].name!;
                    return InkWell(child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(controller.language[index].name!),
                      ),
                    ),onTap: (){
                      _languageName  = name;
                       controller.filterCountry(name);
                      Navigator.of(context).pop();
                    },);
                  });
            }
            ),
          ),
        ],
      ),
    );
  }


}
