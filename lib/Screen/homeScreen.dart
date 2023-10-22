import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:news_app/Screen/screen_part/scrollbar.dart';

import '../Model/shopping_model.dart';
import '../respository/shopping_res.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {Books, IPhone, Gorra, Azul, Gatos, nuevo}

class _HomeScreenState extends State<HomeScreen> {

  FilterList ? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');

  String categoryName = 'products';


  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.sizeOf(context).width * 1;
    final  height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
          },
          icon: Image.asset('images/new_img/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text('Shopping', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue:  selectedMenu,
              icon: Icon(Icons.menu_rounded, color: Colors.black,),
              onSelected: (FilterList item){
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>> [
              ]
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.grey[200],
              ),
              child: TextField(
                decoration: InputDecoration(
               //   labelText: 'Search',
                  hintText: 'Search for products...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: fetchShoppingData(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  }
                  else{
                    return Column(
                      children: [
                        ScrollBar(),
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: shop.length,
                              itemBuilder: (context, index){
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => DetailsScreen(shop[index]),
                                        ));
                                      },
                                      child: Container(
                                        height: height * 0.6,
                                        width: width * .9,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: height * .02,
                                          vertical: height * .02
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: shop[index].images![0],
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Container(
                                              child: spinkit2,
                                            ),
                                            errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red,),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          alignment: Alignment.bottomCenter,
                                          height: height * .20,
                                          width: width *  .8,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.7,
                                                  child: Text(
                                                    shop[index].title ?? 'No Titlle',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 20, fontWeight: FontWeight.w700,
                                                      color: Colors.blueAccent,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                SizedBox(
                                                  width: width * 0.7,
                                                  child: Text(
                                                    shop[index].description ?? 'No Description',                                              maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 17, fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                SizedBox(
                                                  width: width * 0.7,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        shop[index].category?.name ?? 'No Category',
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.poppins(
                                                          color: Colors.black87,
                                                          fontSize: 17, fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '\$${shop[index].price.toString()}',
                                                        //format.format(DateTime.parse(shop[index].creationAt.toString())),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.poppins(
                                                          color: Colors.black87,
                                                          fontSize: 20, fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                          ),
                        ),
                      ],
                    );
                  }
                }
            ),
          ),
          ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  size: 50,
  color: Colors.blue,
);