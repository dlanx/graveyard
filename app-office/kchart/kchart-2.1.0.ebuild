# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kchart/Attic/kchart-2.1.0.ebuild,v 1.5 2010/01/20 21:49:42 ranger Exp $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice chart application."

KEYWORDS="amd64 hppa ~ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libs/
	interfaces/
	filters/
	plugins/
"
KMEXTRA="
	filters/${KMMODULE}/
"

KMLOADLIBS="koffice-libs"
