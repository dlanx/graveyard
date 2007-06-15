# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hal-info/Attic/hal-info-20070425.ebuild,v 1.4 2007/06/15 19:52:54 dertobi123 Exp $

inherit eutils

DESCRIPTION="The fdi scripts that HAL uses."
HOMEPAGE="http://hal.freedesktop.org"
SRC_URI="http://people.freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"

RDEPEND=">=sys-apps/hal-0.5.9_rc2"
DEPEND="${RDEPEND}"

src_compile() {
	econf --enable-recall --enable-video || die "econf failed."
	emake
}

src_install() {
	make DESTDIR="${D}" install || die "install failed."
}
