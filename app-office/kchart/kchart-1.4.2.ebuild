# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kchart/Attic/kchart-1.4.2.ebuild,v 1.6 2005/11/30 06:36:10 halcy0n Exp $

MAXKOFFICEVER=${PV}
KMNAME=koffice
inherit kde-meta eutils

DESCRIPTION="KOffice integrated graph and chart drawing tool."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KMCOPYLIB="
	libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkoscript lib/koscript
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store
	libkochart interfaces"

KMEXTRACTONLY="lib/
	interfaces/"

KMEXTRA="filters/kchart"

need-kde 3.3
