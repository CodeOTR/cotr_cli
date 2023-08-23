import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';

class CreateNewView extends Command {
  @override
  String get description => 'Create a new ViewModel and ViewModelBuilder.';

  @override
  String get name => 'view';

  @override
  ArgParser get argParser {
    return ArgParser()..addOption('name', abbr: 'n', help: 'The name to prefix to the ViewModel and ViewModelBuilder. Do not include ViewModel or ViewModelBuilder in the name.',
     valueHelp: 'Home');
  }

  @override
  Future<void> run() async {
    final name = argResults!['name'] as String?;
    if (name == null) {
      throw UsageException('Please provide the view name', usage);
    }

    String snakeCase = ReCase(name).snakeCase;

    String viewModelCode = '''
      import 'package:code_on_the_rocks/code_on_the_rocks.dart';
      import 'package:flutter/material.dart';
      import '${snakeCase}_view_model.dart';
      
      class HomeView extends StatelessWidget {
        const HomeView({Key? key}) : super(key: key);
      
        @override
        Widget build(BuildContext context) {
          return HomeViewModelBuilder(
              builder: (context, model) {
                return Scaffold(
                  body: Center(
                    child: Text('Home'),
                  )
                );
              },
            );
        }
      }
      '''
        .replaceAll('HomeView', '${ReCase(name).pascalCase}View');


    String viewModelBuilderCode = '''
      import 'package:code_on_the_rocks/code_on_the_rocks.dart';
      import 'package:flutter/material.dart';
      
      class HomeViewModelBuilder extends ViewModelBuilder<HomeViewModel> {
        const HomeViewModelBuilder({
          super.key,
          required super.builder,
        });
      
        @override
        State<StatefulWidget> createState() => HomeViewModel();
      }
      
      class HomeViewModel extends ViewModel<HomeViewModel> {
         static HomeViewModel of_(BuildContext context) => getModel<HomeViewModel>(context);
      }
      '''
        .replaceAll('HomeView', '${ReCase(name).pascalCase}View');

    var directory = await Directory(snakeCase).create(recursive: true);

    final viewModel = File('${directory.path}/${snakeCase}_view.dart');
    final viewModelBuilder = File('${directory.path}/${snakeCase}_view_model.dart');

    await viewModel.writeAsString(viewModelCode, mode: FileMode.write);
    await viewModelBuilder.writeAsString(viewModelBuilderCode, mode: FileMode.write);
  }
}