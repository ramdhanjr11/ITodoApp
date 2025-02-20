
# ITodo App

Welcome to this project. This project are supposed to completed task flutter developer test candidate in PLN Icon Plus 

## Tech Stack
This project has been built by `Flutter` and `MVVM` pattern. [click here for reference](https://docs.flutter.dev/app-architecture), the following is tech stack we used.

#### Tools and environment
| Name    | Description                       |
| :------ | :-------------------------------- |
| Flutter | Used for create UI                |
| FVM     | Used for changing flutter version |
| VS Code | Used for text editor              |

#### Tools and environment
| Name    | Version  |
| :------ | :------- |
| Flutter | `3.27.3` |
| Dart    | `3.6.1`  |

#### Packages
| Name                 | Version    |
| :------------------- | :--------- |
| cached_network_image | `3.4.1`    |
| dartz                | `^0.10.1`  |
| dio                  | `^5.8.0+1` |
| equatable            | `^2.0.7`   |
| faker                | `^2.2.0`   |
| flutter_animate      | `^4.5.2`   |
| flutter_bloc         | `9.0.0`    |
| get_it               | `8.0.3`    |
| haptic_feedback      | `^0.5.1+1` |
| intl                 | `^0.20.2`  |
| json_annotation      | `^4.9.0`   |
| pretty_dio_logger    | `^1.4.0`   |
| skeletonizer         | `1.4.3`    |
| toastification       | `^2.3.0`   |

## Installation

To install this project to your local device, please clone `https://gitlab.aqi.co.id/aqi-jogja/kodomo-mimamori/kodomo-mimamori-ios` in your text editor.

```
  git clone  
```
> After you finished clone the project, dont forget to `flutter clean` and `flutter pub get`.

# How to run the app?
To run the app, you can follow this following command for several flavors:
#### SIT
```dart
// You can adjust run mode --debug || --profile || --release
flutter run --debug --flavor sit -t lib/main_sit.dart
```

#### UAT
```dart
flutter run --debug --flavor uat -t lib/main_uat.dart
```

#### PROD
```dart
flutter run --debug --flavor prod -t lib/main_prod.dart
```

*or for alternative you can use vscode launch



