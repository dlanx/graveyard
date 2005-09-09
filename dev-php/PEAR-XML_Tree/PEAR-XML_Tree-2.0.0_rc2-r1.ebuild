# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Tree/Attic/PEAR-XML_Tree-2.0.0_rc2-r1.ebuild,v 1.3 2005/09/09 14:21:31 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="The XML_Tree package allows one to build XML data structures using a tree representation, without the need for an extension like DOMXML"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="${RDEPEND} dev-php/PEAR-XML_Parser"
