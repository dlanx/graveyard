# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lince/Attic/lince-0.99.1.ebuild,v 1.1 2008/03/08 21:29:23 coldwind Exp $

DESCRIPTION="a light, powerfull and full feature gtkmm bittorrent client"
SRC_URI="mirror://sourceforge/lincetorrent/${P}.tar.gz"
HOMEPAGE="http://lincetorrent.sourceforge.net"

DEPEND="dev-cpp/gtkmm
	x11-libs/cairo
	>=net-libs/rb_libtorrent-0.13_pre1912
	dev-libs/libxml2
	sys-devel/gettext
	dev-util/intltool"

RDEPEND="${DEPEND}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install () {
	emake DESTDIR="${D}" install || die
}
