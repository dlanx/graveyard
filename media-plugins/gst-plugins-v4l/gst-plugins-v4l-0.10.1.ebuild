# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l/Attic/gst-plugins-v4l-0.10.1.ebuild,v 1.1 2006/01/14 00:18:15 compnerd Exp $

inherit gst-plugins-base

DESCRIPION="plugin to allow capture from video4linux1 devices"

KEYWORDS="~x86 ~amd64"

IUSE=""

RDEPEND="virtual/x11"

DEPEND="${RDEPEND}
	virtual/os-headers
	>=dev-util/pkgconfig-0.9"

