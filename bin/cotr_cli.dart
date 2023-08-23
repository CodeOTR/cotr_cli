import 'package:args/command_runner.dart';
import 'package:cotr_cli/cotr_cli.dart';

void main(List<String> arguments) {
  CommandRunner(
    "my_cli",
    "Dart CLI example",
  )
    ..addCommand(CreateNewView())
    ..run(arguments);
}
