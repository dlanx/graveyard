# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx/Attic/upx-1.23.ebuild,v 1.3 2002/10/17 12:48:56 vapier Exp $

S=${WORKDIR}/${P}-linux
DESCRIPTION="upx is the Ultimate Packer for eXecutables."
SRC_URI="http://upx.sourceforge.net/download/${P}-linux.tar.gz"
HOMEPAGE="http://upx.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_install() {
	#the pre-compiled version works on gcc-3.2 systems; source version won't compile.
	dobin upx
	doman upx.1
	dodoc upx.doc upx.html BUGS COPYING LICENSE NEWS README THANKS
}
