# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/Attic/ggv-2.8.3.ebuild,v 1.11 2005/07/12 00:07:10 geoman Exp $

inherit gnome2

DESCRIPTION="The GNOME PostScript document viewer"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/orbit-2.4.1
	virtual/ghostscript
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.30"

PROVIDE="virtual/psviewer"

DOCS="AUTHORS ChangeLog MAINTAINERS TODO README"

