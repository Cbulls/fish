import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget with PreferredSizeWidget {
  const Searchbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // The search area here
        title: Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.black),
                    onPressed: () {
                      // 검색어 지우기
                      setState(() {
                        searchController.text = '';
                      });
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_box_outlined,
                color: Colors.black,
              ))
        ],
      ),
    ));
  }
}
