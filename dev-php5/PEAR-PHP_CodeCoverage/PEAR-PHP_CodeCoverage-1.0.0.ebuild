# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/PEAR-PHP_CodeCoverage/Attic/PEAR-PHP_CodeCoverage-1.0.0.ebuild,v 1.1 2010/10/04 22:48:27 jokey Exp $

inherit php-pear-r1 depend.php eutils

DESCRIPTION="Library that provides collection, processing, and rendering functionality for PHP code coverage"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_URI="http://pear.phpunit.de/get/PHP_CodeCoverage-${PV}.tgz"

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-ConsoleTools-1.6
	>=dev-php5/PEAR-File_Iterator-1.2.2
	dev-php5/PEAR-PHP_TokenStream
	dev-php5/PEAR-Text_Template
	dev-php5/xdebug"
