# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l/Attic/gst-plugins-v4l-0.10.24.ebuild,v 1.7 2010/01/05 18:19:38 nixnut Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 hppa ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.23"
DEPEND="${RDEPEND}
	virtual/os-headers
	dev-util/pkgconfig"
