# Contributor: Severin Neumann <neumanns@cisco.com>
# Maintainer: Severin Neumann <neumanns@cisco.com>
pkgname=opentelemetry-cpp
pkgver=1.16.1
pkgrel=4
_opentelemetryproto_ver=1.3.2
pkgdesc="OpenTelemetry C++"
url="https://opentelemetry.io/"
arch="all !s390x" # failing test (TraceIdRatioBasedSampler.ShouldSampleWithoutContext)
license="Apache-2.0"
depends_dev="
	$pkgname=$pkgver-r$pkgrel
	$pkgname-exporter-otlp-common=$pkgver-r$pkgrel
	$pkgname-exporter-otlp-grpc=$pkgver-r$pkgrel
	$pkgname-exporter-otlp-http=$pkgver-r$pkgrel
	$pkgname-exporter-zipkin=$pkgver-r$pkgrel
	"
makedepends="
	abseil-cpp-dev
	c-ares-dev
	cmake
	curl-dev
	grpc-dev
	nlohmann-json
	protobuf-dev
	re2-dev
	samurai
	"
checkdepends="
	benchmark-dev
	gtest-dev
	"
subpackages="
	$pkgname-dev
	$pkgname-exporter-otlp-common
	$pkgname-exporter-otlp-grpc
	$pkgname-exporter-otlp-http
	$pkgname-exporter-zipkin
	"
source="
	https://github.com/open-telemetry/opentelemetry-cpp/archive/v$pkgver/opentelemetry-cpp-v$pkgver.tar.gz
	opentelemetry-proto-$_opentelemetryproto_ver.tar.gz::https://github.com/open-telemetry/opentelemetry-proto/archive/refs/tags/v$_opentelemetryproto_ver.tar.gz
	add-loongarch64-support.patch
	"

build() {
	# skip some broken asm in benchmark 1.8.1
	export CXXFLAGS="$CXXFLAGS -DBENCHMARK_HAS_NO_INLINE_ASSEMBLY"
	cmake -B build -G Ninja -Wno-dev \
		-DOTELCPP_PROTO_PATH="$srcdir/opentelemetry-proto-$_opentelemetryproto_ver" \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DBUILD_SHARED_LIBS=ON \
		-DBUILD_TESTING="$(want_check && echo ON || echo OFF)" \
		-DBUILD_W3CTRACECONTEXT_TEST="$(want_check && echo ON || echo OFF)" \
		-DCMAKE_BUILD_TYPE=None \
		-DWITH_ABSEIL=ON \
		-DWITH_STL=OFF \
		-DWITH_EXAMPLES=OFF \
		-DWITH_OTLP_GRPC=ON \
		-DWITH_OTLP_HTTP=ON \
		-DWITH_ZIPKIN=ON \
		-DWITH_PROMETHEUS=OFF
	cmake --build build
}

check() {
	cd build
	# these seem to fail on 32-bit as passing an invalid curl option
	CTEST_OUTPUT_ON_FAILURE=TRUE ctest -j1 -E '(SendPostRequest.*)'
}

package() {
	DESTDIR="$pkgdir" cmake --install build
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
c93005c9b24b358a9998141f6c7fd9675778731775dacaad18f0e81117fd00aaabff371c04cf96688a9c86117727181052a141d961d4db28fc457b454351c570  opentelemetry-cpp-v1.16.1.tar.gz
ac95bb70c5566bab5c9ec7b9c469414b013f2bcf1c5ea82e7b7466311c767de091be819ddbbb01de8ce6e49f163035fec2a9d691c19ae47645b3c4a27c227f2b  opentelemetry-proto-1.3.2.tar.gz
af3c7063773cf64d305f4d8a1c95ccfd2a45b48014b8f5509642a8efc1a58b16adab00c5e6a4662c83252574b9b5fadf07d07f6ec9c70cf5fab22083da85a6cf  add-loongarch64-support.patch
"
