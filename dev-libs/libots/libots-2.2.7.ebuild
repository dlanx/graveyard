# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libots/Attic/libots-2.2.7.ebuild,v 1.6 2004/05/24 08:58:49 kloeri Exp $

At="libots-2.2.7-2.alpha.rpm"
S=${WORKDIR}/usr/lib/compaq/libots-2.2.7
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/${At}"
DESCRIPTION="Compaq Linux optimized runtime for Alpha/Linux/GNU"
HOMEPAGE="http://www.support.compaq.com/alpha-tools/"
DEPEND="virtual/glibc
	app-arch/rpm2targz "
RDEPEND="$DEPEND"
LICENSE="compaq-sdla"
SLOT="2.2.7"
KEYWORDS="-x86 -ppc -sparc alpha"

src_unpack() {
	#if [ ! -f ${DISTDIR}/${At} ] ; then
	#	die "Please download ${At} from ${HOMEPAGE}"
	#fi
	rpm2targz ${DISTDIR}/${At}
	tar zxf libots-2.2.7-2.alpha.tar.gz
}

src_install () {
	dodir /usr/lib

	cp libots.* ${D}/usr/lib

	dodoc README
}

