# WebJar

The Registration Desk app will be compiled to JavaScript and then packaged in a JAR file.

## Dependencies

To be able to create a WebJar, the following tools need to be installed:

- JDK
- Gradle

The installation can e.g. be done with [SDKMAN!](https://sdkman.io/).

## Local testing

```bash
./tool/webjar/publish.sh -l -v 0.1.0-SNAPSHOT
find ~/.m2/repository/ksch
```

```gradle
repositories {
	mavenLocal()
}
```

## Production release

The actual release packages will be created with the following [GitHub Action](https://github.com/features/actions):

[.github/workflows/publish.yaml](../../.github/workflows/publish.yaml)

## References

- [Create WebJar with Gradle and GitHub Packages | dev.to](https://dev.to/janux_de/create-webjar-with-gradle-and-github-2li3)
