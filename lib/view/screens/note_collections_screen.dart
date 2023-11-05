import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/mocks.dart';
import 'package:note_taking_app/constants/padding.dart';
import 'package:note_taking_app/model/note_collection.dart';
import 'package:note_taking_app/utils/utils.dart';
import 'package:note_taking_app/view/screens/notes_screen.dart';
import 'package:note_taking_app/view/widgets/circle.dart';
import 'package:note_taking_app/view/widgets/gap.dart';
import 'package:note_taking_app/view/widgets/screen_wrapper.dart';

class NoteCollectionsScreen extends StatefulWidget {
  const NoteCollectionsScreen({Key? key}) : super(key: key);

  @override
  State<NoteCollectionsScreen> createState() => _NoteCollectionsScreenState();
}

class _NoteCollectionsScreenState extends State<NoteCollectionsScreen> {
  void showCreateCollectionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes the modal full height
      backgroundColor: const Color.fromRGBO(255, 0, 0, 0),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height *
            0.6, // Set the height to 60% of the screen's height
        child: const CreateCollectionModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: "Note Collections",
      floatingAction: showCreateCollectionModal,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of items per row
        ),
        itemCount: mockNoteCollections.length,
        itemBuilder: (context, index) {
          NoteCollection collection = mockNoteCollections[index];
          return NoteCollectionCard(collection: collection);
        },
      ),
    );
  }
}

class NoteCollectionCard extends StatelessWidget {
  final NoteCollection collection;

  const NoteCollectionCard({
    super.key,
    required this.collection,
  });

  void handleTapCollectionCard(BuildContext context) {
    navigatorPush(context, NotesScreen(title: collection.title));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleTapCollectionCard(context);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    collection.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Circle(
                    size: 24,
                    child: Text(
                      collection.noteIdList.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(y: 20),
              Text(collection.description ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateCollectionModal extends StatefulWidget {
  const CreateCollectionModal({super.key});

  @override
  _CreateCollectionModalState createState() => _CreateCollectionModalState();
}

class _CreateCollectionModalState extends State<CreateCollectionModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: KPadding.a24,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30), // Add rounded corners to the top
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Create a New Collection",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const TextField(
            decoration: InputDecoration(
              label: Text("Title"),
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              label: Text("Description"),
            ),
          ),
          const Gap(y: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: (){},
                child: const Text("Cancel"),
              ),
              const Gap(x: 16),
              ElevatedButton(
                onPressed: (){},
                child: const Text("Create"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
