(https://github.com/saurabhsharmaj/Java-MicroService-Training.git)

# Sample REST CRUD API with Spring Boot, Mysql, JPA and Hibernate 

## Steps to Setup

**1. Clone the application**

```bash
https://github.com/saurabhsharmaj/Java-MicroService-Training.git
```

**2. Create Mysql database**
```bash
create database user_database
```

**3. Change mysql username and password as per your installation**

+ open `src/main/resources/application.properties`

+ change `spring.datasource.username` and `spring.datasource.password` as per your mysql installation

**4. Build and run the app using maven**

```bash
mvn package
java -jar target/spring-boot-rest-api-tutorial-0.0.1-SNAPSHOT.jar

```
Install curl in container: apt update && apt install -y curl

docker-compose up --force-recreate

docker build -t ersaurabhsharmamca/api-tutorial:latest .

docker push ersaurabhsharmamca/api-tutorial:latest

docker run -p 8082:8082 ersaurabhsharmamca/api-tutorial:latest

Alternatively, you can run the app without packaging it using -



go inside the Docker and docker-compose up
add your prometheus : http://host.docker.internal:9090/
Grafana Dashboard ID: 4701 (Micrometer + Spring Boot)

```bash
mvn spring-boot:run
```

The app will start running at <http://localhost:8080>.

## Explore Rest APIs

The app defines following CRUD APIs.

    GET /api/v1/users
    
    POST /api/v1/users
    
    GET /api/v1/users/{userId}
    
    PUT /api/v1/users/{userId}
    
    DELETE /api/v1/users/{userId}

You can find the tutorial for this application on my blog -

