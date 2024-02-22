// import 'package:flutter/material.dart';
//
// class SearchBox extends StatefulWidget {
//   final Function(String) onSearch;
//   final VoidCallback onClear;
//
//   SearchBox({required this.onSearch, required this.onClear});
//
//   @override
//   _SearchBoxState createState() => _SearchBoxState();
// }
//
// class _SearchBoxState extends State<SearchBox> {
//   late TextEditingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         elevation: 5,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _controller,
//                   decoration: InputDecoration(
//                     hintText: 'Search for movies...',
//                     border: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                   ),
//                   onChanged: widget.onSearch,
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.clear),
//                 onPressed: () {
//                   _controller.clear();
//                   widget.onClear();
//                 },
//                 // Only show the clear button when there's text in the search box
//                 icon: _controller.text.isEmpty ? null : Icon(Icons.clear),
//               ),
//               IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {
//                   widget.onSearch(_controller.text);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
