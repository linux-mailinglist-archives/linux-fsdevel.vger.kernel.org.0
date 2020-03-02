Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D3175E51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCBPhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 10:37:12 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:45268 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgCBPhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:37:12 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48WPQY1crwzQlKM;
        Mon,  2 Mar 2020 16:37:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 6OMBcZierEM3; Mon,  2 Mar 2020 16:37:05 +0100 (CET)
Date:   Tue, 3 Mar 2020 02:36:57 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302153657.7k7qo4k5he2acxct@yavin>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <20200302115239.pcxvej3szmricxzu@wittgenstein>
 <20200302120503.g5pt4ky3uvb2ly63@wittgenstein>
 <20200302151046.447zgo36dmfdr2ik@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z3gcdvurlvimlu7q"
Content-Disposition: inline
In-Reply-To: <20200302151046.447zgo36dmfdr2ik@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--z3gcdvurlvimlu7q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-02, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Mon, Mar 02, 2020 at 01:05:04PM +0100, Christian Brauner wrote:
> > On Mon, Mar 02, 2020 at 12:52:39PM +0100, Christian Brauner wrote:
> > > On Mon, Mar 02, 2020 at 12:30:47PM +0100, Florian Weimer wrote:
> > > > * Christian Brauner:
> > > >=20
> > > > > [Cc Florian since that ends up on libc's table sooner or later...]
> > > >=20
> > > > I'm not sure what you are after here =E2=80=A6
> > >=20
> > > Exactly what you've commented below. Input on whether any of these
> > > changes would be either problematic if you e.g. were to implement
> > > openat() on top of openat2() in the future or if it would be problema=
tic
> > > if we e.g. were to really deprecate AT_* flags for new syscalls.
> > >=20
> > > >=20
> > > > > On Fri, Feb 28, 2020 at 02:53:32PM +0000, David Howells wrote:
> > > > >> =09
> > > > >> I've been told that RESOLVE_* flags, which can be found in linux=
/openat2.h,
> > > > >> should be used instead of the equivalent AT_* flags for new syst=
em calls.  Is
> > > > >> this the case?
> > > > >
> > > > > Imho, it would make sense to use RESOLVE_* flags for new system c=
alls
> > > > > and afair this was the original intention.
> > > > > The alternative is that RESOLVE_* flags are special to openat2().=
 But
> > > > > that seems strange, imho. The semantics openat2() has might be ve=
ry
> > > > > useful for new system calls as well which might also want to supp=
ort
> > > > > parts of AT_* flags (see fsinfo()). So we either end up adding ne=
w AT_*
> > > > > flags mirroring the new RESOLVE_* flags or we end up adding new
> > > > > RESOLVE_* flags mirroring parts of AT_* flags. And if that's a
> > > > > possibility I vote for RESOLVE_* flags going forward. The have be=
tter
> > > > > naming too imho.
> > > > >
> > > > > An argument against this could be that we might end up causing mo=
re
> > > > > confusion for userspace due to yet another set of flags. But mayb=
e this
> > > > > isn't an issue as long as we restrict RESOLVE_* flags to new sysc=
alls.
> > > > > When we introduce a new syscall userspace will have to add suppor=
t for
> > > > > it anyway.
> > > >=20
> > > > I missed the start of the dicussion and what this is about, sorry.
> > > >=20
> > > > Regarding open flags, I think the key point for future APIs is to a=
void
> > > > using the set of flags for both control of the operation itself
> > > > (O_NOFOLLOW/AT_SYMLINK_NOFOLLOW, O_NOCTTY) and properaties of the
> > > > resulting descriptor (O_RDWR, O_SYNC).  I expect that doing that wo=
uld
> >=20
> > Yeah, we have touched on that already and we have other APIs having
> > related problems. A clean way to avoid this problem is to require new
> > syscalls to either have two flag arguments, or - if appropriate -
> > suggest they make use of struct open_how that was implemented for
> > openat2().
>=20
> By the way, if we really means business wrt to: separate resolution from
> fd-property falgs then shouldn't we either require O_NOFOLLOW for
> openat2() be specified in open_how->resolve or disallow O_NOFOLLOW for
> openat2() and introduce a new RESOLVE_* variant?

I think we agreed a while ago we aren't touching O_ flags for openat2()
because it would hamper adoption (this is the same reason we aren't
fixing the whole O_ACCMODE mess, and O_LARGEFILE, and the arch-specific
O_ flags, and O_TMPFILE, and __O_SYNC, and FASYNC/O_ASYNC, and
__FMODE_EXEC and __FMODE_NONOTIFY, and ...).

To be fair, we did fix O_PATH|O_TMPFILE and invalid mode combinations
but that's only because those were fairly broken.

But as I mentioned in a sister mail, I do agree that allowing O_NOFOLLOW
and RESOLVE_NO_TRAILING_SYMLINKS makes me feel a little uneasy. But
maybe it's totally fine and I'm worrying for no reason.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--z3gcdvurlvimlu7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXl0oFwAKCRCdlLljIbnQ
ElnIAP9m9sYf6BaM1rn8GNQEfGPy2a9VHHurhDb+SjelDPiC7AD9E+jCX3UcZ2+5
gTG0XVFUvphs+TqKngfX+EBNIHB8bw0=
=N0M9
-----END PGP SIGNATURE-----

--z3gcdvurlvimlu7q--
