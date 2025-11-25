# Custom connector

## 1. Build connector

When we talk about a connector in the context of Eclipse Dataspace Components, we really mean a JAR file that runs on a machine.
Before we can run a connector, we need to build the JAR file.

Execute this command in project root:

```bash
./gradlew launchers:connector-postgresql:build
```

## 2. Run the connectors

To run the provider, just run the following command

```bash
java -Dedc.fs.config=launchers/connector-postgresql/resources/configuration/provider-configuration.properties -jar launchers/connector-postgresql/build/libs/connector-postgresql.jar
```

To run the consumer, just run the following command (different terminal)

```bash
java -Dedc.fs.config=launchers/connector-postgresql/resources/configuration/consumer-configuration.properties -jar launchers/connector-postgresql/build/libs/connector-postgresql.jar
```
