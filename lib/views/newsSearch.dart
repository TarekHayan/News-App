import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'newsSearchPadge.dart';
import '../widgets/network_error.dart';

class Newssearch extends StatelessWidget {
  const Newssearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('News Search', style: TextStyle(color: Color(0xffe1ff49))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        child: TextField(
          onSubmitted: (value) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return OfflineBuilder(
                    connectivityBuilder:
                        (
                          BuildContext context,
                          List<ConnectivityResult> connectivity,
                          Widget child,
                        ) {
                          final bool connected = !connectivity.contains(
                            ConnectivityResult.none,
                          );
                          return connected
                              ? Newssearchpadge(valu: value)
                              : NetworkError();
                        },
                    child: Container(),
                  );
                },
              ),
            );
          },

          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            suffix: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.search, color: Color(0xffcbff56)),
            ),
            labelText: 'Search For What?',
            labelStyle: TextStyle(color: Colors.white),
            hintText: 'Enter Here',
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffcbff56)),
            ),
          ),
        ),
      ),
    );
  }
}
