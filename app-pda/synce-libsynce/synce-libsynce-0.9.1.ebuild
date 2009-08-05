# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-libsynce/Attic/synce-libsynce-0.9.1.ebuild,v 1.7 2009/08/05 23:29:55 mescalinum Exp $

inherit eutils

DESCRIPTION="Common Library for Synce (connecting WinCE devices to Linux)"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc x86"
IUSE=""

DEPEND=">=dev-libs/check-0.8.3.1"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-amd64.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
