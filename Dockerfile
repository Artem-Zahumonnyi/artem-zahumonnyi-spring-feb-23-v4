FROM maven:3-jdk-8-alpine as builder

WORKDIR /usr/src/app

COPY . /usr/src/app
RUN mvn package

FROM openjdk:8-jre-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /usr/src/app/target/*.jar /app.jar

RUN chown appuser:appgroup /app.jar


USER appuser

EXPOSE 8080


ENTRYPOINT ["java"]
CMD ["-jar", "/app.jar"]
