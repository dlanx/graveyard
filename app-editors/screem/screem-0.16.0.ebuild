# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/screem/Attic/screem-0.16.0.ebuild,v 1.2 2006/02/24 00:29:28 allanonjl Exp $

inherit gnome2

DESCRIPTION="SCREEM is an integrated environment of the creation and maintenance of websites and pages"
HOMEPAGE="http://www.screem.org/"
SRC_URI="mirror://sourceforge/screem/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc ssl zlib dbus spell"

RDEPEND=">=dev-libs/glib-2.5.6
	>=x11-libs/gtk+-2.6
	>=dev-libs/libxml2-2.4.3
	>=gnome-base/libglade-2.3
	>=gnome-base/gconf-2.2
	>=gnome-base/gnome-vfs-2.8.3
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.6
	=gnome-extra/gtkhtml-2*
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=x11-libs/gtksourceview-1.1.90
	>=dev-libs/libcroco-0.6.0
	>=gnome-base/gnome-menus-2.9.2
	dbus? ( >=sys-apps/dbus-0.22 )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	spell? ( >=app-text/enchant-1.1.6 )
	"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.1.1
	>=dev-util/intltool-0.29
	dev-util/pkgconfig
	>=x11-misc/shared-mime-info-0.14
	"

DOCS="AUTHORS BUGS COPYING-DOCS ChangeLog NEWS README TODO"
USE_DESTDIR="1"

pkg_setup()
{
	G2CONF="${G2CONF} \
		--disable-update-mime \
		--disable-update-desktop \
		--disable-schemas-install \
		$(use_with ssl) \
		$(use_with zlib) \
		$(use_enable dbus) \
		$(use_enable spell enchant)
		"
}

src_unpack()
{
	unpack ${A}
	cd ${S}

	gnome2_omf_fix docs/*/Makefile.in docs/omf.make
}

pkg_postinst() {
	gnome2_pkg_postinst

	echo
	einfo "Run gconftool-2 --shutdown in order to be able to run screem."
	einfo "(As a normal user)"
	einfo "Otherwise, you will get an error about missing configuration"
	einfo "files."
	echo
}

