# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hal-info/Attic/hal-info-20070425.ebuild,v 1.7 2007/08/25 13:46:34 vapier Exp $

inherit eutils

DESCRIPTION="The fdi scripts that HAL uses"
HOMEPAGE="http://hal.freedesktop.org/"
SRC_URI="http://people.freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ~ia64 ppc -ppc64 sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=sys-apps/hal-0.5.9_rc2"
DEPEND="${RDEPEND}"

src_compile() {
	econf --enable-recall --enable-video || die "econf failed."
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "install failed."
}
