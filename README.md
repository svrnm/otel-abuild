# Alpine APK for OpenTelemetry C++

This project contains an [APKBUILD](./APKBUILD) file for [OpenTelemetry C++](https://github.com/open-telemetry/opentelemetry-cpp)

Before you can build those packages you need to create a signing key:

```
./keygen.sh
```

This will create a folder called `abuild` with a private-public-key pair. Make a copy of them.

To build the packages run the following:

```
./build.sh
```

You will have a folder `packages` now that holds the following packages:

* opentelemetry-cpp
* opentelemetry-cpp-dev
* opentelemetry-cpp-doc
* opentelemetry-cpp-exporter-jaeger
* opentelemetry-cpp-exporter-otlp-common
* opentelemetry-cpp-exporter-otlp-grpc
* opentelemetry-cpp-exporter-otlp-http
* opentelemetry-cpp-exporter-zipkin

To try them out run the following

```
docker run -v ${PWD}/packages:/packages --rm -t -i alpine
```

Within the container you can now install those packages:

```
apk search --allow-untrusted --repository /packages opentelemetry
```
