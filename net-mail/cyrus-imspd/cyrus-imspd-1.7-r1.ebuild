# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cyrus-imspd/Attic/cyrus-imspd-1.7-r1.ebuild,v 1.2 2003/11/04 05:11:59 max Exp $

inherit ssl-cert

DESCRIPTION="Internet Message Support Protocol (IMSP) server."
HOMEPAGE="http://asg.web.cmu.edu/cyrus/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/${PN}-v${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="kerberos ldap ssl"

DEPEND="virtual/glibc
	>=sys-libs/db-3.2
	>=dev-libs/cyrus-sasl-2.1.3
	>=dev-libs/cyrus-imap-dev-2.1.14
	>=sys-apps/sed-4
	kerberos? ( virtual/krb5 )
	ldap? ( >=net-nds/openldap-2.0 )
	ssl? ( >=net-misc/stunnel-4 )"

S="${WORKDIR}/${PN}-v${PV}"

src_unpack() {
	unpack ${A} && cd "${S}"
	epatch "${FILESDIR}/cyrus-imspd-gentoo.patch"
	epatch "${FILESDIR}/cyrus-imspd-db4.patch"

	# cyrus 2.2.x has an extra library.
	if [ "`best_version '=dev-libs/cyrus-imap-dev-2.2*'`" ] ; then
		sed -e "s:-lcyrus:-lcyrus -lcyrus_min:" \
			-i "${S}/imsp/Makefile.in" \
			-i "${S}/cmulocal/libcyrus.m4" || die "sed failed"
	fi

	# recreate configure.
	ebegin "Recreating configure"
	rm -f configure acconfig.h
	sh SMakefile &>/dev/null || die "SMakefile failed"
	eend $?
}

src_compile() {
	local myconf
	myconf="${myconf} `use_with ldap ldap ldap`"
	myconf="${myconf} `use_enable kerberos gssapi`"

	econf \
		--without-krb \
		--with-auth=unix \
		${myconf}
	emake || die "compile problem"
}

src_install() {
	newsbin imsp/cyrus-imspd imspd

	exeinto /etc/init.d
	newexe "${FILESDIR}/imspd.rc6" imspd
	insinto /etc/conf.d
	newins "${FILESDIR}/imspd.conf" imspd

	keepdir /var/imsp{,/user}

	if [ "`use ssl`" ] ; then
		insinto /etc/stunnel
		newins "${FILESDIR}/stunnel.conf" imspd.conf

		dosed "s:#IMSPD_USE_SSL:IMSPD_USE_SSL:" /etc/conf.d/imspd

		SSL_ORGANIZATION="${SSL_ORGANIZATION:-Cyrus IMSP Server}"
		insinto /etc/ssl/imspd
		docert server
	fi

	dodoc README imsp/options.sample notes/*
}
