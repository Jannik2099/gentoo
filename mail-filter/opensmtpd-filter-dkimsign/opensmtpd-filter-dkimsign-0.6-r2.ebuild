# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="OpenSMTPD filter for signing mail with DKIM"
HOMEPAGE="https://imperialat.at/dev/filter-dkimsign/"
SRC_URI="https://imperialat.at/releases/filter-dkimsign-${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${P#opensmtpd-}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	mail-filter/libopensmtpd
	dev-libs/openssl
	"
RDEPEND="${DEPEND}"
PATCHES=(
	"${FILESDIR}/${PN}-0.6-ed25519.patch"
)

src_prepare() {
	default
	mv -f Makefile.gnu Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" LIBCRYPTOPC="libcrypto" MANFORMAT="man"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" MANFORMAT="man" install
}
