# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libicq2000/Attic/libicq2000-0.3.1.ebuild,v 1.3 2002/06/05 19:18:57 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="ICQ 200x compatible ICQ libraries."
SRC_URI="mirror://sourceforge/libicq2000/${P}.tar.gz"
HOMEPAGE="http://ickle.sf.net"
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND="( >=dev-libs/libsigc++-1.0.4
		  <dev-libs/libsigc++-1.1.9 )"
RDEPEND=$DEPEND

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--localstatedir=/var/lib \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die

}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}
