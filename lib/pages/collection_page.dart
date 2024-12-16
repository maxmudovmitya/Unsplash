import 'package:flutter/material.dart';
import 'package:ngdemo14/pages/photos_page.dart';

import '../models/collection_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {

  bool isLoading = false;
  List<Collection> items = [];

  _callPhotosPage(Collection collection){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context){
      return PhotosPage(
      collection: collection,
      );
    }));
  }


  apiCollectionList() async{

    setState(() {
      isLoading = true;
    });

    var response = await Network.GET(Network.API_COLLECTIONS, Network.paramsCollections(1));
    List<Collection> collection = Network.parseCollections(response!);
    LogService.i(collection.length.toString());


    setState(() {
      items = collection;
      isLoading = false;
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCollectionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ListView.builder(
            itemCount:  items.length,
            itemBuilder: (context, index){
              return _itemOfCollection(items[index]);
            }
          ),
          isLoading ? Center(child: CircularProgressIndicator(),): SizedBox.shrink(),
        ],
      ),
    );
  }
  Widget _itemOfCollection(Collection collection) {
    return GestureDetector(
      onTap: () {
        _callPhotosPage(collection);
      },
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Image.network(collection.coverPhoto.urls.small!, fit: BoxFit.cover, height: 300, width: double.infinity,)
          ],
        ),
      ),
    );
  }
}
