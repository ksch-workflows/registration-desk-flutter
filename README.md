# Registration Desk

The Registration Desk app is a single-page web application, powered by [Flutter Web](https://flutter.dev/web).

## Context

The Registration Desk is used by nurses and clerks.
The tasks they need to do there are around the patient registration and billing.

![Context diagram](doc/img/context.png)

The app depends upon the [Backend](https://github.com/ksch-workflows/backend) for the reading and writing of its data.
For this purpose, it is accessing the [REST API](https://www.redhat.com/en/topics/api/what-is-a-rest-api) of the backend with the help of the [K.S.C.H. Dart Client](https://github.com/ksch-workflows/ksch-dart-client).

### Technology

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
flutter run -d chrome
```

### Linting

```
dart format .
dart analyze
```

### Enable desktop supporting

During development it might be useful to start the app in desktop mode, so that hot reload can be used.
To enable this, you need to enable desktop support in your global Flutter configuration.

See https://flutter.dev/desktop

**macOS**

```shell
$ flutter config --enable-macos-desktop
```

**Ubuntu**

```shell
$ sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
$ flutter config --enable-linux-desktop
```

## Maintenance

### Release process

If there is a new release tag, this automatically triggers the [GitHub Actions](https://github.com/features/actions) workflow specified in [release.yml](../../.github/workflows/release.yml).

So, releasing a new version of the Registration Desk is done by creating a release as described at [docs.github.com](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository#creating-a-release).

## License

K.S.C.H. Workflows is maintained by [KS-plus e.V.](https://ks-plus.org/en/welcome/),
a non-profit association dedicated to supporting the [Kirpal Sagar](https://kirpal-sagar.org/en/welcome/) project.

It is licensed under the [Apache License Version 2.0](https://github.com/ksch-workflows/ksch-workflows/blob/master/LICENSE).
