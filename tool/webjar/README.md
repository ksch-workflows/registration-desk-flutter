# WebJar

The [backend](https://github.com/ksch-workflows/backend) of the KSCH Workflows project is a [Spring Boot](https://spring.io/projects/spring-boot) application. The Registration Desk web app gets compiled to HTML/JavaScript and then packaged into a [JAR](<https://en.wikipedia.org/wiki/JAR_(file_format)>) file. This JAR file is published to [Jitpack](https://jitpack.io). The backend declares a dependency on Jitpack and then downloads the JAR file from there. Then, when the server starts it hosts the resources from the Registration Desk which can then be used by the clients of the application.

## References

- https://www.webjars.org
- https://jitpack.io/#ksch-workflows/registration-desk
