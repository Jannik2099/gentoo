# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A lightweight implementation of Desktop Notification Spec"
HOMEPAGE="https://github.com/projg2/libtinynotify/"
SRC_URI="https://github.com/projg2/libtinynotify/releases/download/${P}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug static-libs"

RDEPEND="sys-apps/dbus:0="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( README )

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable static-libs static)
	)

	econf "${myconf[@]}"
}

src_install() {
	default
	find "${D}" -name '*.la' -delete
}
