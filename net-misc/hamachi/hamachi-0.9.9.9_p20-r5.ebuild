# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hamachi/Attic/hamachi-0.9.9.9_p20-r5.ebuild,v 1.3 2010/10/28 10:03:16 ssuominen Exp $

inherit eutils linux-info

# gHamachi GUI

MY_PV=${PV/_p/-}
MY_P=${PN}-${MY_PV}-lnx

DESCRIPTION="Hamachi is a secure mediated peer to peer."
HOMEPAGE="http://hamachi.cc"
LICENSE="as-is"
SRC_URI="sse? ( http://files.hamachi.cc/linux/${MY_P}.tar.gz )
	!sse? ( http://files.hamachi.cc/linux/${MY_P}-pentium.tar.gz )"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="sse"
RESTRICT="mirror"
QA_PRESTRIPPED="/opt/${PN}/bin/hamachi"

pkg_preinst() {
	# Add group "hamachi" & user "hamachi"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

pkg_setup() {
	einfo "Checking your kernel configuration for TUN/TAP support."
	CONFIG_CHECK="~TUN"
	check_extra_config
# Set workdir for both hamachi versions
	if use sse; then
		S=${WORKDIR}/${MY_P}
	else
		S=${WORKDIR}/${MY_P}-pentium
	fi
}

src_compile() {
	# Patching Makefile and tuncfg source code
	epatch "${FILESDIR}"/tuncfg-forcebuild.patch
	# forcing compile of tuncfg
	rm -f "${S}"/tuncfg/tuncfg
	# Compile Tuncfg
	emake -sC "${S}"/tuncfg || die "Compiling of tunecfg failed"
}

src_install() {
	# Hamachi
	einfo "Installing Hamachi"
	dodir /opt/${PN}/bin
	insinto /opt/${PN}/bin
	insopts -m0755
	doins hamachi || die "Couldn't Install hamachi"
	dosym /opt/${PN}/bin/hamachi /usr/bin/hamachi || die "Couldn't create hamachi symlinks"
	dosym /opt/${PN}/bin/hamachi /usr/bin/hamachi-init || die "Couldn't create hamachi symlinks"

	# Tuncfg
	einfo "Installing Tuncfg"
	insopts -m0700
	doins tuncfg/tuncfg
	dosym /opt/${PN}/bin/tuncfg /usr/sbin/tuncfg

	# Create log directory
	dodir /var/log/${PN}

	# Config files
	einfo "Installing config files"
	newinitd "${FILESDIR}"/tuncfg.initd tuncfg
	newconfd "${FILESDIR}"/hamachi.confd hamachi
	newinitd "${FILESDIR}"/hamachi.initd.2 hamachi

	# Docs
	dodir /opt/${PN}/licenses
	insinto /opt/${PN}/licenses
	insopts -m0644
	doins LICENSE LICENSE.openssh LICENSE.openssl LICENSE.tuncfg
	dodoc CHANGES README

}

pkg_postinst() {
	einfo "To start Hamachi just type:"
	einfo "/etc/init.d/hamachi start"

	# added for bug #218481
	einfo "If the 'hamachi' command shows no output, use the following command"
	einfo "to extract the hamachi executable either with app-arch/upx or"
	einfo "app-arch/upx-ucl:"
	einfo "/opt/bin/upx -d /opt/${PN}/bin/hamachi"
}
