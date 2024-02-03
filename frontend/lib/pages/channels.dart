// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/Providers/auth_provider.dart';
import 'package:frontend/components/Button.dart';
import 'package:frontend/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

final isToggledProvider = StateNotifierProvider<ToggleController, bool>(
  (ref) => ToggleController(),
);

Color? primaryColor;

class ToggleController extends StateNotifier<bool> {
  ToggleController() : super(true); // Initial state is true

  void toggle() {
    state = !state;
  }
}

final isSubscribedSelectedProvider = StateProvider<bool>((ref) => true);

class Channels extends ConsumerWidget {
  Channels({super.key});
  TextEditingController channelNameController = TextEditingController();
  TextEditingController channelDescriptionController = TextEditingController();
  TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    primaryColor = Theme.of(context).colorScheme.primary;
    File? imageFile = ref.watch(channelImageProvider);
    ChannelImageNotifier channelImageNotifier =
        ref.watch(channelImageProvider.notifier);

    StateController<bool> isSubscribedSelectedContoller =
        ref.watch(isSubscribedSelectedProvider.notifier);
    bool isSubscribeSelected = isSubscribedSelectedContoller.state;
    List<dynamic> searchResults = [];

    final isToggled = ref.watch(isToggledProvider);

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
                  onPressed: () {
                    // Create channel
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Create Channel',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: SingleChildScrollView(
                              padding: EdgeInsets.all(0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15.0),
                                    child: TextButton(
                                      onPressed: () async {
                                        await channelImageNotifier
                                            .pickImage(ImageSource.gallery);
                                      },
                                      child: Text('Pick a profile image'),
                                    ),
                                  ),
                                  if (imageFile != null)
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(imageFile),
                                    ),
                                  Form(
                                      child: Column(
                                    children: [
                                      TextFormField(
                                        controller: channelNameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Channel Name',
                                        ),
                                      ),
                                      TextFormField(
                                        controller:
                                            channelDescriptionController,
                                        decoration: const InputDecoration(
                                          labelText: 'Channel Description',
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  channelImageNotifier.clearImage();
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  createChannel(
                                      channelNameController.text,
                                      channelDescriptionController.text,
                                      imageFile!);
                                  channelImageNotifier.clearImage();
                                  Navigator.pop(context);
                                },
                                child: const Text('Create'),
                              ),
                            ],
                          );
                        });
                  },
                  padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                ),
              ],
            ),
            // searchBar(),
            // SearchBar
            Container(
              margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    30.0), // Adjust the radius for pill shape
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchBarController,
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          debugPrint(
                              'Search Query: ${searchBarController.text}');
                          // searchChannels(searchBarController.text);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    'Search Results',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                  content: FutureBuilder(
                                      future: searchChannels(
                                          searchBarController.text),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          Future.delayed(Duration.zero, () {
                                            MotionToast.error(
                                              title: Text("Error"),
                                              description: Text(
                                                  'Unable to load channels'),
                                            ).show(context);
                                          });
                                          return Container();
                                        } else if (!snapshot.hasData) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.sentiment_dissatisfied,
                                                  size: 100.0,
                                                  color: Colors.grey),
                                              Text('No channels found',
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.grey)),
                                            ],
                                          );
                                        } else {
                                          return Column(
                                            children: [
                                              searchResult(
                                                  snapshot.data['id'],
                                                  snapshot.data['name'],
                                                  snapshot.data['logo'])
                                            ],
                                          );
                                        }
                                      }),
                                );
                              });
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    if (!isToggled) {
                      ref.read(isToggledProvider.notifier).toggle();
                    }
                    debugPrint('isSubscribedSelected: $isSubscribeSelected');
                  },
                  child: Text(
                    'Subscribed',
                    style: TextStyle(
                      fontWeight:
                          isToggled ? FontWeight.bold : FontWeight.normal,
                      color: isToggled
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      if (isToggled) {
                        ref.read(isToggledProvider.notifier).toggle();
                      }
                      debugPrint(
                          '>> isSubscribedSelected: $isSubscribeSelected');
                    },
                    child: Text(
                      'My Channels',
                      style: TextStyle(
                          fontWeight:
                              isToggled ? FontWeight.normal : FontWeight.bold,
                          color: isToggled
                              ? Colors.grey
                              : Theme.of(context).colorScheme.primary),
                    )),
              ],
            ),

            // Subscribed and My Channels list
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FutureBuilder(
                      future:
                          isToggled ? getSubscribedChannels() : getMyChannels(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          Future.delayed(Duration.zero, () {
                            MotionToast.error(
                              title: Text("Error"),
                              description: Text('Unable to load channels'),
                            ).show(context);
                          });
                          return Container();
                        } else if (snapshot.data!.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.sentiment_dissatisfied,
                                  size: 100.0, color: Colors.grey),
                              Text('No channels found',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.grey)),
                            ],
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> channel =
                                    snapshot.data![index];

                                return postCard(channel['name'],
                                    channel['description'], channel['logo']);
                              });
                        }
                      })),
            ),
          ],
        ));
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
            Expanded(
              child: TextField(
                controller: searchBarController,
                style: TextStyle(color: Colors.grey, fontSize: 18.0),
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget postCard(
      String channelName, String channelDescription, String logoStr) {
    return Card(
      child: Column(children: [
        ListTile(
          // leading: FaIcon(FontAwesomeIcons.person),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: MemoryImage(base64Decode(logoStr)),
          ),
          title: Text(channelName,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
          subtitle: Text(
            channelDescription,
            style: TextStyle(color: primaryColor),
          ),
          tileColor: Colors.white,
        ),
      ]),
    );
  }
}

Widget searchResult(channelId, channelName, String logoStr) {
  return Card(
    child: Column(children: [
      ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: MemoryImage(base64Decode(logoStr)),
        ),
        title: Text(channelName, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(primaryColor),
          ),
          onPressed: () {
            subscribeToChannel(channelId);
          },
          child: const Text('Subscribe'),
        ),
        tileColor: Colors.white,
      ),
    ]),
  );
}
