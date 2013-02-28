# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qgit/Attic/qgit-2.3.ebuild,v 1.7 2010/03/17 17:18:04 sping Exp $

EAPI="1"

inherit qt4

MY_PV=${PV//_/}
MY_P=${PN}-${MY_PV}

DESCRIPTION="GUI interface for git/cogito SCM"
HOMEPAGE="http://digilander.libero.it/mcostalba/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	>=dev-vcs/git-1.5.3"

S="${WORKDIR}/${PN}"

src_compile() {
	eqmake4 || die "eqmake failed"
	emake || die "emake failed"
}

src_install() {
	newbin bin/qgit qgit4
	dodoc README
}
