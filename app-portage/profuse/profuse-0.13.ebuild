# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/profuse/Attic/profuse-0.13.ebuild,v 1.1 2004/12/07 22:39:06 dams Exp $

IUSE=""

MY_P=${PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="use flags and profile gtk2 editor, with good features"
HOMEPAGE="http://libconf.net/profuse/"
SRC_URI="http://libconf.net/profuse/download/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND=">=dev-perl/gtk2-fu-0.02
>=dev-util/libconf-0.39.4"

src_compile() {
	emake || die "make failed"
}

src_install() {
	einstall PREFIX=${D}/usr
}
