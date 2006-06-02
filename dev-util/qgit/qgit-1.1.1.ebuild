# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qgit/Attic/qgit-1.1.1.ebuild,v 1.3 2006/06/02 12:00:33 caleb Exp $

inherit qt3

MY_PV=${PV//_/}
MY_P=${PN}-${MY_PV}

DESCRIPTION="GUI interface for git/cogito SCM"
HOMEPAGE="http://digilander.libero.it/mcostalba/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=x11-libs/qt-3*"
RDEPEND="${DEPEND}
	>=dev-util/git-1.2.4"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin src/qgit
	dodoc README ChangeLog
}
