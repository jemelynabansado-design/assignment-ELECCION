import 'package:hydrated_bloc/hydrated_bloc.dart';

class NotesCubit extends HydratedCubit<List<String>> {
  NotesCubit() : super([]);

  // Add a new note
  void addNote(String note) {
    emit([...state, note]);
  }

  // Remove a note by index
  void deleteNote(int index) {
    final newState = List<String>.from(state)..removeAt(index);
    emit(newState);
  }

  @override
  List<String>? fromJson(Map<String, dynamic> json) {
    final notes = json['notes'] as List<dynamic>?;
    return notes?.map((e) => e as String).toList() ?? [];
  }

  @override
  Map<String, dynamic>? toJson(List<String> state) {
    return {'notes': state};
  }
}

