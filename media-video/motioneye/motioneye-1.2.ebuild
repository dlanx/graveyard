# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/motioneye/Attic/motioneye-1.2.ebuild,v 1.1 2003/09/29 09:46:25 phosphan Exp $

DESCRIPTION="ppm, jpeg or mjpeg grabber for the MotionEye camera on Sony VAIO Picturebooks."
HOMEPAGE="http://spop.free.fr/meye/"
SRC_URI="http://spop.free.fr/meye/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"
DEPEND="X? ( virtual/x11
		media-libs/imlib )"

src_compile() {
	cd ${S}
	epatch ${FILESDIR}/${P}-Makefile.diff
	if [ `use X` ]; then
		export WITHX='yes'
	else
		export WITHX='no'
	fi
	make || die
}

src_install() {
	exeinto /usr/bin
	doexe motioneye
}