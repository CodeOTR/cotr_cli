import 'package:args/command_runner.dart';
import 'package:cotr_cli/cotr_cli.dart';

void main(List<String> arguments) {
  CommandRunner(
    "cotr",
    "CLI for Code on the Rocks",
  )
    ..addCommand(CreateNewView())
    ..run(arguments);
}
