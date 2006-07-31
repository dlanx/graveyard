# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/unieject/Attic/unieject-5.2.ebuild,v 1.2 2006/07/31 23:28:03 flameeyes Exp $

inherit libtool

DESCRIPTION="Multiplatform command to eject and load CD-Rom drives"
HOMEPAGE="http://flameeyes.is-a-geek.org/projects#unieject"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=dev-libs/libcdio-0.75-r1
	dev-libs/popt
	>=dev-libs/confuse-2.5
	nls? ( virtual/libintl )
	!sys-apps/eject
	!sys-block/eject-bsd"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	sys-apps/sed"

PROVIDE="virtual/eject"

src_unpack() {
	unpack ${A}
	cd ${S}

	# libcdio-0.75-r1 in Gentoo is fixed, so no need to ask 0.76 either on
	# FreeBSD.
	sed -i -e '/freebsd/s:libcdiomin="0\.76":libcdiomin="0.75":' \
		${S}/configure

	elibtoolize
}

src_compile() {
	econf \
		$(use_enable nls) \
		--enable-lock-workaround \
		--disable-dependency-tracking \
		--disable-doc \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install
	dodoc README ChangeLog NEWS AUTHORS unieject.conf.sample

	# Symlink to eject to provide a good virtual/eject
	dosym unieject.1.gz /usr/share/man/man1/eject.1.gz
	dosym unieject /usr/bin/eject
}
