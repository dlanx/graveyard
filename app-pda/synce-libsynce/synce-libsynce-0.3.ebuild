# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-libsynce/Attic/synce-libsynce-0.3.ebuild,v 1.2 2002/12/18 14:20:55 vapier Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync." 
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome"

DEPEND="virtual/glibc"

src_compile() {
	econf
	emake || die 
}

src_install() {
	make DESTDIR="${D%/}" install || die
}
