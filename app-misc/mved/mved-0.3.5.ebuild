# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mved/Attic/mved-0.3.5.ebuild,v 1.4 2005/01/01 15:16:38 eradicator Exp $

DESCRIPTION="An editor-focused multiple file move utility."
HOMEPAGE="http://guerila.com"
SRC_URI="http://guerila.com/downloads/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~mips"

IUSE=""
DEPEND=""
RDEPEND="virtual/python"

src_install() {
	dodoc README
	dobin mved
}
