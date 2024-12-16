import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ngdemo14/models/photo_model.dart';
import 'package:ngdemo14/pages/details_page.dart';

import '../models/search_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  bool isLoading = false;
  List<Photo> items = [];

  _callDetailsPage(Photo photo) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailsPage(photo: photo);

        }));
  }




  apiSearchPhotos() async{

    setState(() {
      isLoading = true;
    });

    var response = await Network.GET(Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos("Unsplash", 1));
    SearchPhotosRes searchPhotosRes = Network.parseSearchPhotos(response!);
    LogService.i(searchPhotosRes.results.length.toString());

    setState(() {
      items.addAll(searchPhotosRes.results);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    apiSearchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:  Stack(
        children: [
          MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: items.length,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            itemBuilder: (context, index){
              return _itemOfPhoto(items[index], index);
            }
          ),
          isLoading ? Center(child: CircularProgressIndicator())
                     : SizedBox.shrink(),
        ],
      ),
    );
  }
  Widget _itemOfPhoto(Photo photo, int index){
    return GestureDetector(
      onTap: () {
        _callDetailsPage(photo);
      },
      child: Container(
        height: (index % 5 + 5) * 50.0,
        child: Image.network(photo.urls.small!, fit: BoxFit.cover,),
      ),
    );

  }
}
