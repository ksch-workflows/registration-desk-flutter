# Registration Desk

This repository contains the source code for the app intended to be used at the registration desk.

## Dependencies

- [K.S.C.H. Workflows - Backend](https://github.com/ksch-workflows/backend)
- [Flutter](https://flutter.dev/)

## Development

### Getting started

```
git clone git@github.com:ksch-workflows/registration-desk.git \
  -o upstream \
  registration_desk
```

### Start the backend

```
cd ../backend
./gradlew bootRun
```

### Start the app

For local development, the Registration Desk app can be started like this:

```
flutter run -d chrome --target lib/main_dev.dart
```

### Linting

```
dart format .
dart analyze
```

## License

K.S.C.H. Workflows is maintained by [KS-plus e.V.](https://ks-plus.org/en/welcome/),
a non-profit association dedicated to supporting the [Kirpal Sagar](https://kirpal-sagar.org/en/welcome/) project.

It is licensed under the [Apache License Version 2.0](https://github.com/ksch-workflows/ksch-workflows/blob/master/LICENSE).
