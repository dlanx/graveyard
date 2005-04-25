# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomeradio/Attic/gnomeradio-1.6.ebuild,v 1.1 2005/04/25 10:44:56 foser Exp $

inherit gnome2

DESCRIPTION="A GNOME2 radio tuner"
SRC_URI="http://www.wh-hms.uni-ulm.de/~mfcn/${PN}/packages/${P}.tar.gz"
HOMEPAGE="http://www.wh-hms.uni-ulm.de/~mfcn/gnomeradio/"

IUSE="lirc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2
	lirc? ( app-misc/lirc )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21
	>=app-text/scrollkeeper-0.3.11"

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO"

use lirc \
	&& G2CONF="${G2CONF} --enable-lirc " \
	|| G2CONF="${G2CONF} --enable-lirc "
