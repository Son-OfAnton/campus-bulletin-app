import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Channels extends StatelessWidget {
  const Channels({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            'Channels',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          centerTitle: true,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.plus,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () {},
                  padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                ),
              ],
            ),
            searchBar(),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: () {}, child: const Text('All')),
                TextButton(onPressed: () {}, child: const Text('My Channels')),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return postCard();
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

Widget searchBar() {
  return Container(
    margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
    decoration: BoxDecoration(
      borderRadius:
          BorderRadius.circular(30.0), // Adjust the radius for pill shape
      color: Colors.grey[200],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 8),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              style: TextStyle(color: Colors.grey, fontSize: 18.0),
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
    ),
  );
}

Widget postCard() {
  return Card(
    child: Column(children: [
      const ListTile(
        leading: FaIcon(FontAwesomeIcons.person),
        title:
            Text('Channel Name', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Channel Description'),
        trailing: FaIcon(FontAwesomeIcons.circle),
        tileColor: Colors.white,
      ),
      Container(
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: const Row(
            children: [Text('Nov 24, 2023')],
          ),
        ),
      )
    ]),
  );
}
