// import 'package:flutter/material.dart';
// import 'package:private_upload/auth/privateprovider.dart';
// import 'package:provider/provider.dart';

// class Home extends StatefulWidget {
//   const Home({required this.title, super.key});

//   final String title;

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Future<void> upload() async {
//     PrivateProvider state =
//         Provider.of<PrivateProvider>(context, listen: false);
//     await state.checklogin();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         centerTitle: true,
//         actions: [
//           ElevatedButton(
//             onPressed: upload,
//             style: ElevatedButton.styleFrom(elevation: 0),
//             child: const Icon(Icons.add),
//           )
//         ],
//       ),
//       body: Consumer<PrivateProvider>(
//         builder: (context, state, child) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                     ),
//                     padding:
//                         const EdgeInsets.only(top: 16, left: 16, right: 16),
//                     itemBuilder: (BuildContext context, int index) {
//                       return Column(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(image: NetworkImage(state.docmodel![index].url!)),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                     // itemCount: state.docmodel!.length,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       state.displayfile();
//                     },
//                     child: const Text("Retrieve"))
//               ],
//             ),
//           );
//         },
//       )
//       // body: Consumer<PrivateProvider>(builder: (context, state, child) {
//       //   return Text(state.user!.name ?? '');
//       // },),
//       );
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:private_upload/auth/privateprovider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key, required this.title});
  late String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
    Future<void> upload() async {
    PrivateProvider state =
        Provider.of<PrivateProvider>(context, listen: false);
    await state.checklogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        actions: [
                Align(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<PrivateProvider>(
              builder: (context, state, child) {
                if (state.isLoggedin == false) return Container();
                return Text("Welcome, ${state.user?.name ?? ''}");
              },
            )),
      ),
          ElevatedButton(
            onPressed: upload,
            style: ElevatedButton.styleFrom(elevation: 0),
            child: const Icon(Icons.add),
          )
        ],
        ),
        body: Consumer<PrivateProvider>(
          builder: (context, state, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.docmodel != null)
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            state.docmodel![index].url!)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: state.docmodel!.length,
                      ),
                    ),
                ],
              ),
            );
          },
        ));
  }
}