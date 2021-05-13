# Registration Desk

The web application to be used at the registration desk.

## Maintenance

The following tools are needed to execute the maintenance tasks below:

- [Docker](https://github.com/ksch-workflows/developer-guide/wiki/Docker)
- [Sonar Scanner](https://github.com/ksch-workflows/developer-guide/wiki/Sonar-Scanner)
- [Code Charta](https://github.com/ksch-workflows/developer-guide/wiki/Code-Charta)

### SonarCube analysis

```
docker run --env ES_JAVA_OPTS="-Xms1024m -Xmx1024m" -d -p 9000:9000 -p 9092:9092 \
  experimentalsoftware/sonarqube-dart:0.1
sonar-scanner -Dsonar.login=$SONAR_LOGIN -Dsonar.password=$SONAR_PASSWORD
ccsh sonarimport http://localhost:9000 registration_desk > /tmp/sonar.json
codecharta-visualization &
```
