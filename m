Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362D7FA7B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 04:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKMD4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 22:56:16 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:39380 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfKMD4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:56:16 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 47CW4V73MqzQlBG;
        Wed, 13 Nov 2019 04:56:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id ovfePb6AeJGC; Wed, 13 Nov 2019 04:56:05 +0100 (CET)
Date:   Wed, 13 Nov 2019 14:55:42 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 5/9] namei: LOOKUP_IN_ROOT: chroot-like scoped
 resolution
Message-ID: <20191113035542.3ckc7oudahn3xtnj@yavin.dot.cyphar.com>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191105090553.6350-6-cyphar@cyphar.com>
 <20191113020307.GB26530@ZenIV.linux.org.uk>
 <20191113024414.wlmvtjstpnkxa36n@yavin.dot.cyphar.com>
 <20191113025941.GE26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j4f7d32jpyqpzflk"
Content-Disposition: inline
In-Reply-To: <20191113025941.GE26530@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--j4f7d32jpyqpzflk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-13, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Nov 13, 2019 at 01:44:14PM +1100, Aleksa Sarai wrote:
> > On 2019-11-13, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > On Tue, Nov 05, 2019 at 08:05:49PM +1100, Aleksa Sarai wrote:
> > >=20
> > > > @@ -2277,12 +2277,20 @@ static const char *path_init(struct nameida=
ta *nd, unsigned flags)
> > > > =20
> > > >  	nd->m_seq =3D read_seqbegin(&mount_lock);
> > > > =20
> > > > -	/* Figure out the starting path and root (if needed). */
> > > > -	if (*s =3D=3D '/') {
> > > > +	/* Absolute pathname -- fetch the root. */
> > > > +	if (flags & LOOKUP_IN_ROOT) {
> > > > +		/* With LOOKUP_IN_ROOT, act as a relative path. */
> > > > +		while (*s =3D=3D '/')
> > > > +			s++;
> > >=20
> > > Er...  Why bother skipping slashes?  I mean, not only link_path_walk()
> > > will skip them just fine, you are actually risking breakage in this:
> > >                 if (*s && unlikely(!d_can_lookup(dentry))) {
> > >                         fdput(f);
> > >                         return ERR_PTR(-ENOTDIR);
> > >                 }
> > > which is downstream from there with you patch, AFAICS.
> >=20
> > I switched to stripping the slashes at your suggestion a few revisions
> > ago[1], and had (wrongly) assumed we needed to handle "/" somehow in
> > path_init(). But you're quite right about link_path_walk() -- and I'd be
> > more than happy to drop it.
>=20
> That, IIRC, was about untangling the weirdness around multiple calls of
> dirfd_path_init() and basically went "we might want just strip the slashes
> in case of that flag very early in the entire thing, so that later the
> normal logics for absolute/relative would DTRT".

Ah okay, I'd misunderstood the point you were making in that thread.

> Since your check is right next to checking for absolute pathnames (and
> not in the very beginning of path_init()), we might as well turn the
> check for absolute pathname into *s =3D=3D '/' && !(flags &
> LOOKUP_IN_ROOT) and be done with that.

Yup, agreed.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--j4f7d32jpyqpzflk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXct+uwAKCRCdlLljIbnQ
EpaMAQCKfJalyFfg/QA8aH/wuTwb0JmHpxt9HKverNfj5BncXAEA8J+s2/4xFPcn
vy6IqraafPiOMkqsiqA03ofQ3tR8tQ4=
=Qq3t
-----END PGP SIGNATURE-----

--j4f7d32jpyqpzflk--
