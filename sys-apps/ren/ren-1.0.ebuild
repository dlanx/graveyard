# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ren/Attic/ren-1.0.ebuild,v 1.15 2004/09/12 19:36:26 kloeri Exp $

DESCRIPTION="Renames multiple files"
HOMEPAGE="http://freshmeat.net/projects/ren"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/${P}.tar.gz"

KEYWORDS="x86 amd64 ppc sparc macos ppc64 ~alpha"
IUSE=""
SLOT="0"
LICENSE="as-is"



DEPEND="virtual/libc"

src_compile() {
	emake || die
}

src_install() {
	dobin ren
	dodoc README
	doman ren.1
}
