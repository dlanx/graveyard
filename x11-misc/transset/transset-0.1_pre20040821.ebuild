# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/transset/Attic/transset-0.1_pre20040821.ebuild,v 1.7 2005/10/24 04:51:18 spyderous Exp $

IUSE=""

S=${WORKDIR}/${PN}
DESCRIPTION="Set the transparency levels of windows in an X11 environment"
HOMEPAGE="http://xorg.freedesktop.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND="!<=x11-base/xorg-x11-6.7.99.902"
DEPEND="${RDEPEND}
	|| ( (
		x11-libs/libX11
		x11-proto/xproto
		)
		virtual/x11 )"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	into /usr
	dobin transset
	dodoc ChangeLog
}
