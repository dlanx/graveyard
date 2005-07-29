# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/scsign/Attic/scsign-0.0.4.ebuild,v 1.2 2005/07/29 22:43:47 dragonheart Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Scsign - a command-line utility to digitally sign a file"
HOMEPAGE="http://opensignature.sourceforge.net/"
SRC_URI="mirror://sourceforge/opensignature/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
S=${WORKDIR}

DEPEND=">=dev-libs/opensc-0.8.1
	dev-libs/openssl
	sys-apps/pcsc-lite"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-printid.patch
}

src_compile() {
	$(tc-getCC) ${CFLAGS}  -lcrypto -lpcsclite -lpthread -lopensc scsign.c -o scsign || die
}

src_install() {
	dobin scsign
}
