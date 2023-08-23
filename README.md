This is a basic CLI app for the [code_on_the_rocks](https://pub.dev/packages/code_on_the_rocks) state management package.

## Installation
```bash
dart pub global activate cotr_cli
```
## Usage
```bash
cotr view -n home
```

The `view` command will create the following contents:
1. A new directory with the name of the view (ex. `home`)
2. A new dart file containing the `ViewModelBuilder` (ex. `home_view.dart`)
3. A new dart file containing the `ViewModel` and `ViewModelBuilder` (ex. `home_view_model.dart`)