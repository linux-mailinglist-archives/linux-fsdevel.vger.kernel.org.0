Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20EC18AE19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 09:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCSIJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 04:09:58 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:43918 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgCSIJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:09:56 -0400
Received: by mout-p-102.mailbox.org (Postfix, from userid 51)
        id 48jfhd5MvxzKmds; Thu, 19 Mar 2020 09:09:27 +0100 (CET)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 48gz4W18xTzKmRB;
        Mon, 16 Mar 2020 15:21:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id iCfejkjpJ5ez; Mon, 16 Mar 2020 15:21:11 +0100 (CET)
Date:   Tue, 17 Mar 2020 01:20:57 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stefan Metzmacher <metze@samba.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Allison <jra@samba.org>,
        Ralph =?utf-8?B?QsO2aG1l?= <slow@samba.org>,
        Volker Lendecke <vl@sernet.de>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <20200316142057.xo24zea3k5zwswra@yavin>
References: <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
 <20200313095901.tdv4vl7envypgqfz@yavin>
 <20200313182844.GO23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4df6bjmhtolysrje"
Content-Disposition: inline
In-Reply-To: <20200313182844.GO23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--4df6bjmhtolysrje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-13, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Mar 13, 2020 at 08:59:01PM +1100, Aleksa Sarai wrote:
> > On 2020-03-12, Stefan Metzmacher <metze@samba.org> wrote:
> > > Am 12.03.20 um 17:24 schrieb Linus Torvalds:
> > > > But yes, if we have a major package like samba use it, then by all
> > > > means let's add linkat2(). How many things are we talking about? We
> > > > have a number of system calls that do *not* take flags, but do do
> > > > pathname walking. I'm thinking things like "mkdirat()"?)
> > >=20
> > > I haven't looked them up in detail yet.
> > > Jeremy can you provide a list?
> > >=20
> > > Do you think we could route some of them like mkdirat() and mknodat()
> > > via openat2() instead of creating new syscalls?
> >=20
> > I have heard some folks asking for a way to create a directory and get a
> > handle to it atomically -- so arguably this is something that could be
> > inside openat2()'s feature set (O_MKDIR?). But I'm not sure how popular
> > of an idea this is.
>=20
> For fuck sake, *NO*!
>=20
> We don't need any more multiplexors from hell.  mkdir() and open() have
> deeply different interpretation of pathnames (and anyone who asks for
> e.g. traversals of dangling symlinks on mkdir() is insane).  Don't try to
> mix those; even O_TMPFILE had been a mistake.

I agree that O_TMPFILE is a mess, and you're right that it wouldn't be a
good idea to fold it into open*(). But what is your opinion on a
hypothetical mkdirat2() which would let you get an fd to the directory
that was just created?

> We really don't need openat2() turning into another one.  Syscall table
> slots are not in a short supply, and the level of review one gets from
> "new syscall added" is higher than from "make fubar(2) recognize a new
> member in options->union_full_of_crap if it has RESOLVE_TO_WANK_WITH_RIGH=
T_HAND
> set in options->flags, affecting its behaviour in some odd ways".
> Which is a good thing, damnit.

You're quite right, and I don't intend openat2() to become another
ioctl-but-with-even-more-fun-semantics.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--4df6bjmhtolysrje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXm+LRgAKCRCdlLljIbnQ
ElaGAP9fIzu4LXSjbBKEZbs6rG1neKLKVE2Rsq9L4OP4o/amMgD+PgF9GjE/nolu
40b4nj09uWyhqFo1UO9AbuIefV4TJQo=
=iIAL
-----END PGP SIGNATURE-----

--4df6bjmhtolysrje--
