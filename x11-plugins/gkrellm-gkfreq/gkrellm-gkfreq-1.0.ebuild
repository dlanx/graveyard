# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-gkfreq/Attic/gkrellm-gkfreq-1.0.ebuild,v 1.2 2007/02/24 15:58:37 beandog Exp $

inherit multilib

DESCRIPTION="Displays CPU's current speed in gkrellm2"
HOMEPAGE="http://www.peakunix.net/gkfreq/"
SRC_URI="http://www.peakunix.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-admin/gkrellm-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins gkfreq.so
}
