// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/Providers/auth_provider.dart';
import 'package:frontend/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isToggledProvider = StateNotifierProvider<ToggleController, bool>(
  (ref) => ToggleController(),
);

class ToggleController extends StateNotifier<bool> {
  ToggleController() : super(true); // Initial state is true

  void toggle() {
    state = !state;
  }
}

final isSubscribedSelectedProvider = StateProvider<bool>((ref) => true);

class Channels extends ConsumerWidget {
  const Channels({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    File? imageFile = ref.watch(imageFileProvider);
    ImageFileNotifier imageFileNotifier = ref.watch(imageFileProvider.notifier);

    StateController<bool> isSubscribedSelectedContoller =
        ref.watch(isSubscribedSelectedProvider.notifier);
    bool isSubscribeSelected = isSubscribedSelectedContoller.state;

    final isToggled = ref.watch(isToggledProvider);

    TextEditingController channelNameController = TextEditingController();
    TextEditingController channelDescriptionController =
        TextEditingController();

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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Create Channel'),
                            content: SingleChildScrollView(
                              padding: EdgeInsets.all(0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15.0),
                                    child: TextButton(
                                      onPressed: () async {
                                        await imageFileNotifier
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
                                  imageFileNotifier.clearImage();
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
                                  imageFileNotifier.clearImage();
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
            searchBar(),
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
                    child: const Text('Subscribed')),
                TextButton(
                    onPressed: () {
                      if (isToggled) {
                        ref.read(isToggledProvider.notifier).toggle();
                      }
                      debugPrint(
                          '>> isSubscribedSelected: $isSubscribeSelected');
                    },
                    child: const Text('My Channels')),
              ],
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FutureBuilder(
                      future: isToggled
                          ? getSubscribedChannels()
                          : getMyChannels(),
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

                                return postCard(
                                    channel['name'], channel['description']);
                              });
                        }
                      })),
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

Widget postCard(String channelName, String channelDescription) {
  return Card(
    child: Column(children: [
      ListTile(
        leading: FaIcon(FontAwesomeIcons.person),
        title: Text(channelName, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(channelDescription),
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
