import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/todo_bloc.dart';
import 'bloc/todo_event.dart';
import 'repositories/todo_repository.dart';
import 'screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =&gt; TodoRepository(),
      child: BlocProvider(
        create: (context) =&gt; TodoBloc(
          repository: context.read<todorepository>(),
        )..add(LoadTodos()),
        child: MaterialApp(
          title: 'Todo BLoC App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const TodoListScreen(),
        ),
      ),
    );
  }
}