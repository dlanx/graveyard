# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zaptel/Attic/zaptel-1.2.6.ebuild,v 1.1 2006/06/07 17:55:54 stkn Exp $

inherit toolchain-funcs eutils linux-mod

## NOTE:
#
#

BRI_VERSION="0.3.0-PRE-1p"
FLORZ_VERSION="0.3.0-PRE-1o_florz-12"

IUSE="bri ecmark ecmark2 ecmark3 ecaggressive eckb1 ecmg2 ecsteve ecsteve2 florz rtc ukcid watchdog zapras zapnet"

MY_P="${P/_/-}"

DESCRIPTION="Drivers for Digium and ZapataTelephony cards"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="http://ftp.digium.com/pub/zaptel/${MY_P}.tar.gz
	 bri? ( http://www.junghanns.net/downloads/bristuff-${BRI_VERSION}.tar.gz )
	 florz? ( http://www.netdomination.org/pub/asterisk/zaphfc_${FLORZ_VERSION}.diff.gz )"

S="${WORKDIR}/${MY_P}"

S_BRI="${WORKDIR}/bristuff-${BRI_VERSION}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/libc
	virtual/linux-sources
	>=dev-libs/newt-0.50.0"

# list of echo canceller use flags,
# first active in this list is selected (=order does matter)
ZAP_EC_FLAGS="ecmark ecmark2 ecmark3 ecsteve ecsteve2 eckb1 ecmg2"

### Begin: Helper functions

select_echo_cancel() {
	local myEC=""

	for x in ${ZAP_EC_FLAGS}; do
		if use $x; then
			myEC=$(echo "$x" | sed -e "s:^ec::" | tr '[:lower:]' '[:upper:]')
			break;
		fi
	done

	echo ${myEC}
}

zconfig_disable() {
	if grep -q "${1}" ${S}/zconfig.h; then
		# match a little more than ${1} so we can use zconfig_disable
		# to disable all echo cancellers in zconfig.h w/o calling it several times
		sed -i -e "s:^[ \t]*#define[ \t]\+\(${1}[a-zA-Z0-9_-]*\).*:#undef \1:" \
			${S}/zconfig.h
	fi

	return $?
}

zconfig_enable() {
	if grep -q "${1}" ${S}/zconfig.h; then
		sed -i  -e "s:^/\*[ \t]*#define[ \t]\+\(${1}\).*:#define \1:" \
			-e "s:^[ \t]*#undef[ \t]\+\(${1}\).*:#define \1:" \
			${S}/zconfig.h
	fi

	return $?
}

### End: Helper functions

pkg_setup() {
	local result=0 numec=0

	linux-mod_pkg_setup

	einfo "Running pre-flight checks..."

	# basic zaptel checks
	if ! linux_chkconfig_present CRC_CCITT; then
		echo
		eerror "Your kernel lacks CRC_CCIT support!"
		eerror "Enable CONFIG_CRC_CCIT!"
		result=$((result+1))
	fi

	# check if multiple echo cancellers have been selected
	for x in ${ZAP_EC_FLAGS}; do
		use $x && numec=$((numec+1))
	done
	if [[ $numec -gt 1 ]]; then
		# multiple flags are active, only the first in the ZAP_EC_FLAGS list
		# will be used, make sure the user knows about this
		echo
		ewarn "Multiple echo canceller flags are active but only one will be used!"
		ewarn "Selected: $(select_echo_cancel)"
	fi

	# we need at least HDLC generic support
	if use zapnet && ! linux_chkconfig_present HDLC; then
		echo
		eerror "zapnet: Your kernel lacks HDLC support!"
		eerror "zapnet: Enable CONFIG_HDLC* to use zaptel network support!"
		result=$((result+1))
	fi

	# zapras needs PPP support
	if use zapras && ! linux_chkconfig_present PPP; then
		echo
		eerror "zapras: Your kernel lacks PPP support!"
		eerror "zapras: Enable CONFIG_PPP* to use zaptel ras support!"
		result=$((result+1))
	fi

	# rtc needs linux-2.6 and CONFIG_RTC
	if use rtc; then
		if ! kernel_is 2 6; then
			echo
			eerror "rtc: >=Linux-2.6.0 is needed for rtc support!"
			result=$((result+1))
		fi

		if ! linux_chkconfig_present RTC; then
			eerror "rtc: Your kernel lacks RealTime-Clock support!"
			result=$((result+1))
		fi
	fi

	if [[ $result -gt 0 ]]; then
		echo
		ewarn "One or more of the neccessary precondition(s) is/are not met!"
		ewarn "Look at the messages above, resolve the problem (or disable the use-flag) and try again"
		echo

		if [[ $result -lt 3 ]]; then
			eerror "[$result Error(s)] Zaptel is not happy :("
		else
			eerror "[$result Error(s)] You're making zaptel cry :'("
		fi
		die "[$result] Precondition(s) not met"
	fi

	echo
	einfo "Zaptel is happy and continues... :)"
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2.6-gentoo.diff

# gone
#	if kernel_is 2 6 && use devfs26; then
#		if [[ ${KV_PATCH} -ge 14 ]]; then
#			eerror "Devfs has been removed in linux-2.6.14, skipping devfs26!"
#		else
#			epatch ${FILESDIR}/${PN}-1.2.0-devfs26.diff
#
#			# fix Makefile to not create device nodes for
#			# devfs enabled 2.6 kernels
#			sed -i -e 's:grep -q udevd:grep -q \"udevd\\|devfsd\":' \
#				Makefile
#
#			# disable udev support on devfs26 systems
#			zconfig_disable CONFIG_ZAP_UDEV
#		fi
#	fi

	use ukcid && \
		epatch ${FILESDIR}/${PN}-1.2.0-ukcid.patch

	# try to apply bristuff patch
	if use bri; then
		# fix for userpriv
		chmod -R a=rwX ${S_BRI}

		einfo "Patching zaptel w/ BRI stuff (${BRI_VERSION})"
		epatch ${S_BRI}/patches/zaptel.patch

		cd ${S_BRI}

		if use florz; then
			einfo "Using florz patches (${FLORZ_VERSION}) for zaphfc"

			# remove as soon as there's a new florz patch available
			sed -i -e "s:zaptel-1\.2\.5:zaptel-1.2.6:g" \
				${WORKDIR}/zaphfc_${FLORZ_VERSION}.diff

			epatch ${WORKDIR}/zaphfc_${FLORZ_VERSION}.diff
		fi

		# patch includes
		sed -i  -e "s:^#include.*zaptel\.h.*:#include <zaptel.h>:" \
			qozap/qozap.c \
			zaphfc/zaphfc.c \
			cwain/cwain.c

		# patch makefiles
		sed -i  -e "s:^ZAP[\t ]*=.*:ZAP=-I${S}:" \
			-e "s:^MODCONF=.*:MODCONF=/etc/modules.d/zaptel:" \
			-e "s:linux-2.6:linux:g" \
			qozap/Makefile \
			zaphfc/Makefile \
			cwain/Makefile

		sed -i  -e "s:^\(CFLAGS+=-I. \).*:\1 \$(ZAP):" \
			zaphfc/Makefile

		cd ${S}
	fi

### Configuration changes
	local myEC

	# prepare zconfig.h
	myEC=$(select_echo_cancel)
	if [[ -n "${myEC}" ]]; then
		einfo "Selected echo canceller: ${myEC}"
		# disable default first, set new selected ec afterwards
		zconfig_disable ECHO_CAN
		zconfig_enable ECHO_CAN_${myEC}
	fi

	# enable rtc support on 2.6
	if use rtc && linux_chkconfig_present RTC && kernel_is 2 6; then
		einfo "Enabling ztdummy RTC support"
		zconfig_enable USE_RTC
	fi

	# enable agressive echo surpression
	use ecaggressive && \
		zconfig_enable AGGRESSIVE_SUPPRESSOR

	# ppp ras support
	use zapras && \
		zconfig_enable CONFIG_ZAPATA_PPP

	# frame relay, syncppp...
	use zapnet && \
		zconfig_enable CONFIG_ZAPATA_NET

	# zaptel watchdog
	use watchdog && \
		zconfig_enable CONFIG_ZAPTEL_WATCHDOG
}

src_compile() {
	# build
	make KVERS=${KV_FULL} \
	     KSRC=/usr/src/linux ARCH=$(tc-arch-kernel) || die

	if use bri; then
		cd ${S_BRI}
		for x in cwain qozap zaphfc; do
			einfo "Building ${x}..."
			make KVERS=${KV_FULL} \
				KSRC=/usr/src/linux \
				ARCH=$(tc-arch-kernel) \
				-C ${x} || die "make ${x} failed"
		done
	fi
}

src_install() {
	make INSTALL_PREFIX=${D} ARCH=$(tc-arch-kernel) \
	     KVERS=${KV_FULL} KSRC=/usr/src/linux install || die

	dodoc ChangeLog README README.udev README.Linux26 README.fxsusb zaptel.init
	dodoc zaptel.conf.sample LICENSE zaptel.sysconfig

	# additional tools
	dobin ztmonitor ztspeed zttest

	# install all header files, several packages need the complete set
	# (e.g. sangoma wanpipe)
	insinto /usr/include/zaptel
	doins *.h

	if use bri; then
		einfo "Installing bri"
		cd ${S_BRI}

		insinto /lib/modules/${KV_FULL}/misc
		doins qozap/qozap.${KV_OBJ}
		doins zaphfc/zaphfc.${KV_OBJ}
		doins cwain/cwain.${KV_OBJ}

		# install example configs for octoBRI and quadBRI
		insinto /etc
		doins qozap/zaptel.conf.octoBRI
		newins qozap/zaptel.conf zaptel.conf.quadBRI
		newins zaphfc/zaptel.conf zaptel.conf.zaphfc

		insinto /etc/asterisk
		doins qozap/zapata.conf.octoBRI
		newins qozap/zapata.conf zapata.conf.quadBRI
		newins zaphfc/zapata.conf zapata.conf.zaphfc

		docinto bristuff
		dodoc CHANGES INSTALL

		docinto bristuff/qozap
		dodoc qozap/LICENSE qozap/TODO qozap/*.conf*

		docinto bristuff/zaphfc
		dodoc zaphfc/LICENSE zaphfc/*.conf

		docinto bristuff/cwain
		dodoc cwain/TODO cwain/LICENSE

		cd ${S}
	fi

	# install init script
	newinitd ${FILESDIR}/zaptel.rc6 zaptel
	newconfd ${FILESDIR}/zaptel.confd zaptel

	# install devfsd rule file
	insinto /etc/devfs.d
	newins ${FILESDIR}/zaptel.devfsd zaptel

	# install udev rule file
	insinto /etc/udev/rules.d
	newins ${FILESDIR}/zaptel.udevd 10-zaptel.rules

	# fix permissions if there's no udev / devfs around
	if [[ -d ${D}/dev/zap ]]; then
		chown -R root:dialout	${D}/dev/zap
		chmod -R u=rwX,g=rwX,o= ${D}/dev/zap
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

#	if kernel_is 2 6 && [[ ${KV_PATCH} -lt 14 ]] && use devfs26; then
#		ewarn "*** Warning! ***"
#		ewarn "Devfs support for linux-2.6 is experimental and not"
#		ewarn "supported by digium or the asterisk project!"
#		echo
#		ewarn "Send bug-reports to: stkn@gentoo.org"
#	fi

	echo
	einfo "Use the /etc/init.d/zaptel script to load zaptel.conf settings on startup!"
	echo

	if use bri; then
		einfo "Bristuff configs have been merged as:"
		einfo ""
		einfo "${ROOT}etc/"
		einfo "    zaptel.conf.zaphfc"
		einfo "    zaptel.conf.quadBRI"
		einfo "    zaptel.conf.octoBRI"
		einfo ""
		einfo "${ROOT}etc/asterisk/"
		einfo "    zapata.conf.zaphfc"
		einfo "    zapata.conf.quadBRI"
		einfo "    zapata.conf.octoBRI"
		echo
	fi

	# fix permissions if there's no udev / devfs around
	if [[ -d ${ROOT}dev/zap ]]; then
		chown -R root:dialout	${ROOT}dev/zap
		chmod -R u=rwX,g=rwX,o= ${ROOT}dev/zap
	fi
}
