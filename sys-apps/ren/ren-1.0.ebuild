# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ren/Attic/ren-1.0.ebuild,v 1.1 2002/05/31 03:05:42 agenkin Exp $

DESCRIPTION="Renames multiple files"
HOMEPAGE="http://freshmeat.net/projects/ren"

SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/${P}.tar.gz"

S="${WORKDIR}/${P}"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	dobin ren
	dodoc README 
	doman ren.1
}
