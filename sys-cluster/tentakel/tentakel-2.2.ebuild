# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/tentakel/Attic/tentakel-2.2.ebuild,v 1.1 2005/09/03 13:51:55 dragonheart Exp $

inherit distutils eutils

DESCRIPTION="Execute commands on many hosts in parallel"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://tentakel.biskalar.de/"
DEPEND="dev-lang/python"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${P}/py

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${P}
	epatch ${FILESDIR}/${P}-manpath.patch
}
