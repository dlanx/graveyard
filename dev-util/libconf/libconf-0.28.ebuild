# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/libconf/Attic/libconf-0.28.ebuild,v 1.1 2004/02/26 21:43:32 seemant Exp $

IUSE=""

MY_P=perl-${PN/l/L}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Centralized abstraction layer for system configuration files"
HOMEPAGE="http://libconf.net/"
SRC_URI="http://libconf.net/download/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ~ppc64"

DEPEND="dev-lang/perl"

src_compile() {
	emake || die "make failed"
}

src_install() {
	einstall PREFIX=${D}/usr
	dodoc AUTHORS COPYING ChangeLog
}
