# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/inotail/Attic/inotail-0.5-r1.ebuild,v 1.3 2009/11/14 16:05:26 maekke Exp $

inherit linux-info toolchain-funcs

DESCRIPTION="tail replacement using inotify"
HOMEPAGE="http://distanz.ch/inotail/"
SRC_URI="http://distanz.ch/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

CONFIG_CHECK="~INOTIFY"

src_unpack() {
	unpack ${A}

	sed -i 's/\s*gzip/#&/' "${S}"/Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake prefix="${D}/usr" install || die "install failed"
	dodoc changelog README
}
