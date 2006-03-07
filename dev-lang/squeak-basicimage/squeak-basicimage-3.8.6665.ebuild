# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak-basicimage/Attic/squeak-basicimage-3.8.6665.ebuild,v 1.1 2006/03/07 11:27:11 araujo Exp $

MY_P="Squeak3.8-6665"
DESCRIPTION="Squeak basic image file"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="http://ftp.squeak.org/current_stable/${MY_P}-basic.zip
		http://ftp.squeak.org/current_stable/SqueakV3.sources.gz"

LICENSE="Apple"
SLOT="3.8"
KEYWORDS="~x86"
IUSE=""
PROVIDE="virtual/squeak-image"

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_compile() {
	einfo "Compressing image/changes files."
	gzip ${MY_P}.image
	gzip ${MY_P}.changes
	einfo "done."
}

src_install() {
	einfo 'Installing Image/Sources/Changes files.'
	insinto /usr/lib/squeak
	# install full image and changes file.
	doins ${MY_P}.image.gz
	doins ${MY_P}.changes.gz
	# install sources
	doins SqueakV3.sources
	# create symlinks to the changes and image files.
	dosym /usr/lib/squeak/${MY_P}.changes.gz \
		/usr/lib/squeak/squeak.changes.gz
	dosym /usr/lib/squeak/${MY_P}.image.gz \
		/usr/lib/squeak/squeak.image.gz
}

pkg_postinst() {
	einfo "Squeak ${PV} image, changes and sources files installed in /usr/lib/squeak"
}