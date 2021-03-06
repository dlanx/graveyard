# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmbups/Attic/gkrellmbups-2.0.2-r1.ebuild,v 1.5 2008/07/29 15:23:15 lack Exp $

inherit gkrellm-plugin

IUSE="nut"
DESCRIPTION="GKrellM2 Belkin UPS monitor Plugin"
SRC_URI="http://www.starforge.co.uk/gkrellm/files/${P}.tar.gz"
HOMEPAGE="http://www.starforge.co.uk/gkrellm/gkrellmbups.shtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc sparc x86"

RDEPEND="nut? ( sys-power/nut )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:/usr/include/gkrell:/usr/include/gkrellm2:g' configure
}

src_compile() {
	econf `use_enable nut` || die "Configure failed"
	emake || die "Make failed"
}

src_install () {
	insinto $(gkrellm-plugin_dir)
	newins src/gkrellmbups gkrellmbups.so
	dodoc INSTALL README TODO
}
