import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc_app/cubit/notes_cubit.dart';
import 'package:notes_bloc_app/screens/notes_page.dart';

void main() {
  testWidgets('Add and delete a note', (WidgetTester tester) async {
    // Wrap NotesPage with BlocProvider
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => NotesCubit(),
          child: const NotesPage(),
        ),
      ),
    );

    // Verify no notes initially
    expect(find.text('No notes yet'), findsOneWidget);

    // Enter a note
    await tester.enterText(find.byType(TextField), 'Test Note');
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Verify the note appears
    expect(find.text('Test Note'), findsOneWidget);
    expect(find.text('No notes yet'), findsNothing);

    // Delete the note
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Verify the note is deleted
    expect(find.text('Test Note'), findsNothing);
    expect(find.text('No notes yet'), findsOneWidget);
  });
}
