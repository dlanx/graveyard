# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/unionfs/Attic/unionfs-1.0.13.ebuild,v 1.1 2005/08/11 08:59:26 genstef Exp $

inherit eutils linux-mod

DESCRIPTION="Stackable unification file system, which can appear to merge the contents of several directories"
HOMEPAGE="http://www.fsl.cs.sunysb.edu/project-unionfs.html"
SRC_URI="ftp://ftp.fsl.cs.sunysb.edu/pub/unionfs/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="acl debug"

pkg_setup() {
	linux-mod_pkg_setup

	MODULE_NAMES="unionfs(fs:)"
	BUILD_TARGETS="all"
	BUILD_PARAMS="LINUXSRC=${KV_DIR} KERNELVERSION=${KV_MAJOR}.${KV_MINOR}"
}

src_unpack() {
	local user_Makefile=fistdev.mk EXTRACFLAGS=""

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-delbranch-fix.patch

	use amd64 && epatch ${FILESDIR}/unionfs-1.0.11-amd64.patch

	if ! use debug; then
		echo "UNIONFS_DEBUG_CFLAG=" >> ${user_Makefile}
		EXTRACFLAGS="${EXTRACFLAGS} -DUNIONFS_NDEBUG"
	fi

	use acl && EXTRACFLAGS="${EXTRACFLAGS} -DUNIONFS_XATTR" # -DFIST_SETXATTR_CONSTVOID"

	echo "EXTRACFLAGS=${EXTRACFLAGS}" >> ${user_Makefile}
}

src_install() {
	dosbin unionctl uniondbg unionimap snapmerge
	doman man/unionfs.4 man/unionctl.8 man/uniondbg.8 man/unionimap.8

	linux-mod_src_install

	dodoc INSTALL NEWS README ChangeLog patch-kernel.sh
}

