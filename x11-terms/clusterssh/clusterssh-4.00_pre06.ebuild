# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/clusterssh/Attic/clusterssh-4.00_pre06.ebuild,v 1.1 2010/11/20 09:40:47 jlec Exp $

EAPI=2

inherit perl-module

MY_PN="App-ClusterSSH"
MY_PV="${PV/pre/}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Concurrent Multi-Server Terminal Access."
HOMEPAGE="http://clusterssh.sourceforge.net"
SRC_URI="mirror://sourceforge/clusterssh/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux "
IUSE=""

RDEPEND="
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage
	dev-perl/Test-Trap
	dev-perl/perl-tk
	dev-perl/Config-Simple
	dev-perl/X11-Protocol
	x11-apps/xlsfonts"
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build
	dev-perl/Test-Pod"

S="${WORKDIR}"/${MY_P}

SRC_TEST="do parallel"
