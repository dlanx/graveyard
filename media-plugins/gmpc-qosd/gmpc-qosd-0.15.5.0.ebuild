# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-qosd/Attic/gmpc-qosd-0.15.5.0.ebuild,v 1.9 2011/03/19 16:47:53 angelos Exp $

EAPI=3
inherit autotools multilib

DESCRIPTION="This plugin provides an on-screen-display written to look nicer than xosd"
HOMEPAGE="http://sarine.nl/q-on-screen-display"
SRC_URI="http://download.sarine.nl/gmpc-0.15.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2
	x11-libs/cairo"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e "/^libdir/s/share/$(get_libdir)/" src/Makefile.am
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die
	find "${ED}" -name "*.la" -delete || die
}
