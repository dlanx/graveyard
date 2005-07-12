# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qbankmanager/Attic/qbankmanager-0.9.23.ebuild,v 1.1 2005/07/12 22:03:09 hanno Exp $

inherit eutils kde-functions
need-qt 3

DESCRIPTION="Onlinebanking frontend for aqbanking"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND=">=net-libs/aqbanking-1.1.0
	>=x11-libs/qt-3.0.0
	>=net-libs/aqhbci-qt-tools-1.0.6_beta"

src_compile() {
	econf `use_enable debug` || die
	emake -j1 || die
}

src_install() {
	einstall || die
	dodoc AUTHORS README TODO README COPYING NEWS
}
