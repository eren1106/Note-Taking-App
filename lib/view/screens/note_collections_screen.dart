import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/constants/mocks.dart';
import 'package:note_taking_app/constants/padding.dart';
import 'package:note_taking_app/constants/routes.dart';
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
    showBottomModal(context: context, child: const CreateCollectionModal());
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
    // context.go('/${ROUTES_NAME.noteCollections}/${ROUTES_NAME.notes}');
    context.goNamed(ROUTES_NAME.notes);
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

class CreateCollectionModal extends StatelessWidget {
  const CreateCollectionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Gap(
          y: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Cancel"),
            ),
            const Gap(x: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Create"),
            ),
          ],
        )
      ],
    );
  }
}
