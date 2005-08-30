# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/autotoolset/Attic/autotoolset-0.11.4-r1.ebuild,v 1.2 2005/08/30 01:19:29 robbat2 Exp $

inherit eutils

DESCRIPTION="colection of small tools to simplify project development with autotools"
HOMEPAGE="http://autotoolset.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
		 mirror://gentoo/${P}-misc-pending-upstream-fixes.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/libc
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	app-arch/sharutils
	app-arch/gzip
	dev-lang/perl"

src_unpack() {
	unpack ${P}.tar.bz2
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1107954&group_id=75790&atid=545068
	EPATCH_OPTS="-p1 -d ${S}" epatch ${DISTDIR}/${P}-misc-pending-upstream-fixes.gz
}

src_test() {
	emake check || die "test failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
