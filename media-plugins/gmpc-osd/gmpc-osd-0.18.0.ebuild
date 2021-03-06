# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-osd/Attic/gmpc-osd-0.18.0.ebuild,v 1.7 2011/03/19 17:05:21 angelos Exp $

EAPI=3

DESCRIPTION="This plugin provides an on-screen-display using xosd"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Osd"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2
	x11-libs/xosd"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die
	find "${ED}" -name "*.la" -delete || die
}
