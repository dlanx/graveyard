# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak-fullimage/Attic/squeak-fullimage-3.4.5170.ebuild,v 1.2 2004/06/24 22:57:09 agriffis Exp $

DESCRIPTION="Highly-portable Smalltalk-80 implementation VM image"
HOMEPAGE="http://www.squeak.org/"
MV=3.4
NV=${MV}-5170

SRC_URI="ftp://st.cs.uiuc.edu/Smalltalk/Squeak/${MV}/Squeak${NV}.zip
	ftp://st.cs.uiuc.edu/Smalltalk/Squeak/${MV}/SqueakV3.sources.gz"
LICENSE="Apple"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
PROVIDE="virtual/squeak-image"

S=
DEPEND=
RDEPEND="dev-lang/squeak"

src_compile() {
	cd ${WORKDIR}
	gzip Squeak${MV}.image
	gzip Squeak${MV}.changes
}

src_install() {
	cd ${WORKDIR}
	dodoc ReadMe.txt
	insinto /usr/lib/squeak
	doins	Squeak${MV}.changes.gz \
			Squeak${MV}.image.gz \
			SqueakV3.sources
	dosym /usr/lib/squeak/Squeak${MV}.changes.gz /usr/lib/squeak/squeak.changes.gz
	dosym /usr/lib/squeak/Squeak${MV}.image.gz /usr/lib/squeak/squeak.image.gz
}
