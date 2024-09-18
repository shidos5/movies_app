
// import 'package:flutter/material.dart';
// import 'package:movies_assingment/main.dart';
// import 'package:movies_assingment/pages/browes_screen.dart';
// import 'package:movies_assingment/pages/home.dart';
// import 'package:movies_assingment/pages/serch_page.dart';
// import 'package:movies_assingment/pages/watch_list_screen.dart';

// // ignore: unused_element
// class _MyAppState extends State<MyApp> {
//   int _selectedIndex = 0;

//   static  List<Widget> _pages = <Widget>[
//     HomeScreen(),
//     SearchScreen(),
//     BrowseScreen(),
//     WatchlistScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: _pages[_selectedIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.search),
//               label: 'Search',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.video_library),
//               label: 'Browse',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.watch_later),
//               label: 'Watchlist',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.amber[800],
//           unselectedItemColor: Colors.grey,
//           onTap: _onItemTapped,
//           backgroundColor: Colors.black,
//           type: BottomNavigationBarType.fixed,
//         ),
//       ),
//     );
//   }
// }