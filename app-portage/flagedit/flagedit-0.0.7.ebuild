# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/flagedit/Attic/flagedit-0.0.7.ebuild,v 1.4 2007/01/11 14:37:31 corsair Exp $

IUSE=""

DESCRIPTION="CLI use flags and keyword editor, for system wide or /etc/portage files"
HOMEPAGE="http://damz.net/flagedit/"
SRC_URI="http://damz.net/flagedit/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

RDEPEND="dev-lang/perl
>=dev-util/libconf-0.40.00"

src_install() {
	make install PREFIX="${D}"/usr || die "make install failed"
}
