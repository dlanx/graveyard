# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ren/Attic/ren-1.0.ebuild,v 1.3 2002/07/17 01:20:05 seemant Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Renames multiple files"
HOMEPAGE="http://freshmeat.net/projects/ren"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/${P}.tar.gz"

KEYWORDS="x86"
SLOT="0"
LICENSE="as-is"



DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	dobin ren
	dodoc README 
	doman ren.1
}
