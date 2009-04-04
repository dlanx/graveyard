# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/podsleuth/Attic/podsleuth-0.6.4.ebuild,v 1.4 2009/04/04 14:44:06 maekke Exp $

EAPI=2

inherit mono

DESCRIPTION="a tool to discover detailed model information about an Apple (TM) iPod (TM)."
HOMEPAGE="http://banshee-project.org/PodSleuth"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0
	dev-dotnet/dbus-glib-sharp
	>=sys-apps/hal-0.5.6
	sys-apps/sg3_utils"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf --with-hal-callouts-dir=/usr/libexec
}

src_compile() {
	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
	mono_multilib_comply
}
