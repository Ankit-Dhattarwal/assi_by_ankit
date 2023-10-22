import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Model/shopping_model.dart';

class DetailsScreen extends StatelessWidget {
  final ShoppingModels item;

  final format = DateFormat('MMMM dd, yyyy');

  DetailsScreen(this.item);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final  height = MediaQuery.sizeOf(context).height * 1;

    return  Scaffold(
      appBar: AppBar(
        title: Text('Details' , style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Container(
            height: height * .45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40),
              ),
              child: CachedNetworkImage(
                imageUrl: item.images?.isNotEmpty == true ? item.images![0] : '',
                fit: BoxFit.cover,
                placeholder: (context, ulr) => Center(child: CircularProgressIndicator(),),
              ),
            ),
          ),
          Container(
            height: height * .9,
            margin: EdgeInsets.only(top: height * .4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40),
              ),
            ),
            child: ListView(
              children: [
                Text(item.title.toString(), style: GoogleFonts.poppins(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: height * .01),
                Row(
                  children: [
                    Expanded(
                      child: Text(format.format(DateTime.parse(item.creationAt.toString())), style: GoogleFonts.poppins(fontSize: 20, color: Colors.blueAccent, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text('\$${item.price.toString()}', style: GoogleFonts.poppins(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(item.description.toString(), style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
                ),
                SizedBox( height: height * 0.02,),
                Container(
                  child: Text('Available Here', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                SizedBox( height: height * 0.01,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1), // Adjust the border style as needed
                          ),
                          child: CachedNetworkImage(
                            imageUrl: item.images?.isNotEmpty == true ? item.images![0] : '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1), // Adjust the border style as needed
                          ),
                          child: CachedNetworkImage(
                            imageUrl: item.images?.isNotEmpty == true ? item.images![1] : '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1), // Adjust the border style as needed
                          ),
                          child: CachedNetworkImage(
                            imageUrl: item.images?.isNotEmpty == true ? item.images![2] : '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                   height: height * 0.05,
                    width:  width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black87,
                      ),
                      child: Text(
                        'Buy now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
