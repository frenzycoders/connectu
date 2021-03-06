import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  bool isSearch = false;
  void handleSearchHeader() {
    if (isSearch)
      isSearch = false;
    else
      isSearch = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.pink.shade400,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                isSearch
                    ? Expanded(
                        child: Container(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search Chats',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Text(
                          'Archive Chats',
                          style: GoogleFonts.yrsa(
                            color: Colors.white,
                            letterSpacing: .5,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                !isSearch
                    ? Container(
                        padding: EdgeInsets.all(10),
                        child: IconButton(
                          onPressed: () {
                            handleSearchHeader();
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(10),
                        child: IconButton(
                          onPressed: () {
                            handleSearchHeader();
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          ),
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
