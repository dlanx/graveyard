# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Tree/Attic/PEAR-XML_Tree-1.1.ebuild,v 1.4 2003/09/11 17:04:40 robbat2 Exp $

MY_P=${PN/PEAR-//}-${PV}

DESCRIPTION="The XML_Tree package allows one to build XML data structures using a tree representation, without the need for an extension like DOMXML"
HOMEPAGE="http://pear.php.net/package-info.php?pacid=19"
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
LICENSE="PHP"
SLOT="0"

# Afaik, anything that runs php will run this...
KEYWORDS="x86 ppc sparc"

DEPEND=""
# May be some php compile-time dependancies, but for now...
RDEPEND="dev-php/mod_php"

S=${WORKDIR}/${MY_P}

src_compile() {
	einfo "Nothing to build"
}

src_install () {
	insinto /usr/lib/php/XML
	doins Tree.php
	insinto /usr/lib/php/XML/Tree/
	doins Tree/*
}
