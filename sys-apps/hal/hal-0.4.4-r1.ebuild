# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hal/Attic/hal-0.4.4-r1.ebuild,v 1.3 2005/01/12 14:22:15 johnm Exp $

inherit eutils python

DESCRIPTION="Hardware Abstraction Layer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"
SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="|| ( GPL-2 AFL-2.0 )"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64 ~ppc ~ppc64"
IUSE="debug pcmcia doc"

RDEPEND=">=dev-libs/glib-2.4
	>=sys-apps/dbus-0.22-r1
	dev-libs/expat
	sys-fs/udev
	sys-apps/hotplug
	sys-libs/libcap
	dev-libs/popt
	>=sys-apps/util-linux-2.12i
	|| ( >=sys-kernel/linux-headers-2.6 sys-kernel/linux26-headers )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( app-doc/doxygen )"

# dep on a specific util-linux version for 
# managed mount patches #70873

src_unpack() {

	unpack ${A}

	cd ${S}
	# remove pamconsole option
	epatch ${FILESDIR}/${PN}-0.4.1-old_storage_policy.patch
	# support IDE zip drives as floppy
	epatch ${FILESDIR}/${P}-check_ide_floppy_for_zip_fdi.patch
	# fix joliet label (#77140)
	epatch ${FILESDIR}/${P}-iso_label.patch
	# fix fat on large volumes
	epatch ${FILESDIR}/${P}-volume_id_fat.patch

}

src_compile() {

	# FIXME : docs
	econf \
		`use_enable debug verbose-mode` \
		`use_enable pcmcia pcmcia-support` \
		--enable-fstab-sync \
		--enable-hotplug-map \
		--disable-docbook-docs \
		`use_enable doc doxygen-docs` \
		--with-pid-file=/var/run/hald/hald.pid \
		|| die

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	# We install this in a seperate package to avoid gnome-python dep
	rm ${D}/usr/bin/hal-device-manager

	# initscript
	exeinto /etc/init.d/
	doexe ${FILESDIR}/hald

	# place our pid file
	keepdir /var/run/hald

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

}

pkg_preinst() {

	enewgroup haldaemon || die "Problem adding haldaemon group"
	enewuser haldaemon -1 /bin/false /dev/null haldaemon || die "Problem adding haldaemon user"

}

pkg_postinst() {

	# make sure the permissions on the pid dir are alright & after preinst
	chown haldaemon:haldaemon /var/run/hald

	ewarn "Enabled in this ebuild by default is the usage of fstab-sync"
	ewarn "that will create mount rules for non-existing devices in"
	ewarn "fstab if needed, mount points will be created in /media."
	ewarn "This functionality alters /etc/fstab runtime on the filesystem"
	ewarn "and should be considered a security risk."
	echo
	einfo "The HAL daemon needs to be running for certain applications to"
	einfo "work. Suggested is to add the init script to your start-up"
	einfo "scripts, this should be done like this :"
	einfo "\`rc-update add hald default\`"

}
