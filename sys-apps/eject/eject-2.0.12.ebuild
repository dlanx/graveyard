# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/eject/Attic/eject-2.0.12.ebuild,v 1.1 2002/11/08 13:01:36 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A command to eject a disc from the CD-ROM drive"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${P}.tar.gz"
HOMEPAGE="http://eject.sourceforge.net/"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_install() {
	dodir /usr/bin /usr/share/man/man1

# Full install breaks sandbox, and I'm too lazy to figure out how, so:

	make DESTDIR=${D} install-binPROGRAMS || die
	make DESTDIR=${D} install-man1 || die
	make DESTDIR=${D} install-man || die

	dodoc ChangeLog COPYING README PORTING TODO 
	dodoc AUTHORS NEWS PROBLEMS
}
