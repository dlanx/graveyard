# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/fwlanusb/Attic/fwlanusb-1.00.00.ebuild,v 1.2 2007/07/12 08:54:58 genstef Exp $

inherit eutils linux-mod

SUSEVER="10.2"

DESCRIPTION="Driver for the AVM FRITZ!WLAN USB stick"
HOMEPAGE="http://www.avm.de"
SRC_URI="http://www.avm.de/files/cardware/fritzwlanusb.stick/linux/suse.${SUSEVER}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/fritz"

pkg_setup() {
	CONFIG_CHECK="WIRELESS_EXT"
	ERROR_WIRELESS_EXT="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions"
	linux-mod_pkg_setup
	if ! kernel_is 2 6; then
		die "This package works only with 2.6 kernel!"
	fi
	BUILD_TARGETS="all"
	BUILD_PARAMS="KDIR=${KV_DIR} LIBDIR=${S}/src"
	MODULE_NAMES="fwlanusb(net:${S}/src)"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	convert_to_m "src/Makefile"
}

src_install() {
	linux-mod_src_install
	dohtml *.html
}
