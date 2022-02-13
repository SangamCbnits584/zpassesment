
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zpassesment/controller/get_controller.dart';

class SearchCountryNameByCode extends StatefulWidget {
  const SearchCountryNameByCode({Key? key}) : super(key: key);

  @override
  _SearchCountryNameByCodeState createState() => _SearchCountryNameByCodeState();
}

class _SearchCountryNameByCodeState extends State<SearchCountryNameByCode> {
  final getController  =  Get.find<CountryController>();
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search By Country Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter Country Code',
              ),
              onChanged: (text) async{
                if(text.isNotEmpty && text.length >1){
                  await getController.searchCountryByCode(text, context);
                }

              },
            ),
           const SizedBox(height: 10,),
            InkWell(
              onTap: () async{
                if(controller.text.isNotEmpty && controller.text.length >1){
                  await getController.searchCountryByCode(controller.text, context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue
                ),
                height: MediaQuery.of(context).size.height*0.06,
                width: MediaQuery.of(context).size.width*0.3,
                child:const Center(child: Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)) ,
              ),
            ),
            Obx((){
              return getController.country.value.name != null?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${getController.country.value.name}",style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ):const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
