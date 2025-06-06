# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Invoke amd64 instructions (such as clz, popcnt, rdtsc, rdpmc)"
HOMEPAGE="https://github.com/janestreet/ocaml_intrinsics/"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="amd64 arm arm64 ~ppc ~ppc64 x86"
IUSE="+ocamlopt"
RESTRICT="test"

DEPEND="
	>=dev-lang/ocaml-4.14
	dev-ml/dune-configurator:=
"
RDEPEND="${DEPEND}"

src_prepare() {
	if use riscv || use ppc; then
		sed -i -e 's: crc_stubs::' src/dune || die
	fi
	default
}
