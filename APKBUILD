# Contributor: Severin Neumann <neumanns@cisco.com>
# Maintainer:
pkgname=opentelemetry-cpp
pkgver=1.8.2
pkgrel=0
pkgdesc="OpenTelemetry C++"
url="https://opentelemetry.io/"
arch="all"
license="Apache-2.0"
depends_dev="
	$pkgname=$pkgver-r$pkgrel
	$pkgname-exporter-otlp-common=$pkgver-r$pkgrel
	$pkgname-exporter-otlp-http=$pkgver-r$pkgrel
	$pkgname-exporter-otlp-grpc=$pkgver-r$pkgrel
	$pkgname-exporter-zipkin=$pkgver-r$pkgrel
"
makedepends="cmake grpc-dev re2-dev protobuf-dev c-ares-dev curl-dev nlohmann-json thrift-dev boost-dev"
checkdepends="gtest-dev benchmark-dev"
subpackages="
	$pkgname-dev
	$pkgname-doc
	$pkgname-exporter-otlp-common
	$pkgname-exporter-otlp-http
	$pkgname-exporter-otlp-grpc
	$pkgname-exporter-zipkin
	"
source="https://github.com/open-telemetry/opentelemetry-cpp/archive/v$pkgver/opentelemetry-cpp-v$pkgver.tar.gz"
# builddir="$srcdir/"

prepare() {
	default_prepare
}

build() {
	# Required until https://github.com/open-telemetry/opentelemetry-cpp/issues/1940 is fixed
	export LDFLAGS="$LDFLAGS -Wl,--copy-dt-needed-entries"

	cmake -B build \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DBUILD_SHARED_LIBS=ON \
		-DCMAKE_POSITION_INDEPENDENT_CODE=ON \
		-DBUILD_TESTING="$(want_check && echo ON || echo OFF)" \
		-DBUILD_W3CTRACECONTEXT_TEST="$(want_check && echo ON || echo OFF)" \
		-DCMAKE_BUILD_TYPE=Release \
		-DWITH_EXAMPLES=OFF \
		-DWITH_ZPAGES=OFF \
		-DWITH_OTLP=ON \
		-DWITH_OTLP_HTTP=ON \
		-DWITH_JAEGER=OFF \
		-DWITH_ZIPKIN=ON \
		-DWITH_PROMETHEUS=OFF \
		-DWITH_LOGS_PREVIEW=OFF \
		-DWITH_ASYNC_EXPORT_PREVIEW=OFF \
		-DWITH_METRICS_EXEMPLAR_PREVIEW=OFF 
	cmake --build build
}

check() {
	cd build
	CTEST_OUTPUT_ON_FAILURE=TRUE ctest
}

package() {
	DESTDIR="$pkgdir" cmake --install build
	install -Dm644 LICENSE "$pkgdir"/usr/share/licenses/$pkgname/LICENSE
}

common() {
	pkgdesc="OpenTelemetry C++ OTLP Common Libraries"
	depends="$pkgname=$pkgver-r$pkgrel"
	amove usr/lib/libopentelemetry_otlp*
}

http() {
	pkgdesc="OpenTelemetry C++ OTLP HTTP exporter"
	depends="$pkgname=$pkgver-r$pkgrel $pkgname-exporter-otlp-common=$pkgver-r$pkgrel"
	amove usr/lib/libopentelemetry_exporter_otlp_http*
}

grpc() {
	pkgdesc="OpenTelemetry C++ OTLP gRPC exporter"
	depends="$pkgname=$pkgver-r$pkgrel $pkgname-exporter-otlp-common=$pkgver-r$pkgrel"
	amove usr/lib/libopentelemetry_exporter_otlp_grpc*
}

zipkin() {
	pkgdesc="OpenTelemetry C++ OTLP Zipkin exporter"
	depends="$pkgname=$pkgver-r$pkgrel"
	amove usr/lib/libopentelemetry_exporter_zipkin*
}

sha512sums="
5d3efb7c31626acd9655b795da497ef3829a88f1e33532f26d011fda01ec41e08e88539900151224f5c19161d9bc1f76e502f14a358c4e01440d832432cd0c0b  opentelemetry-cpp-v1.8.2.tar.gz
"
