Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9888AFAAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfIKKqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 06:46:02 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:20039 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfIKKqB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:46:01 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id AC930A2C82;
        Wed, 11 Sep 2019 12:37:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id ATeziMSY9H4D; Wed, 11 Sep 2019 12:37:41 +0200 (CEST)
Date:   Wed, 11 Sep 2019 20:37:30 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org,
        patrick.bellasi@arm.com
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user
 helpers
Message-ID: <20190911103730.72unmfp7lsvvafxo@yavin>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905073205.GY2332@hirez.programming.kicks-ass.net>
 <20190905092622.tlb6nn3uisssdfbu@yavin.dot.cyphar.com>
 <20190905094305.GJ2349@hirez.programming.kicks-ass.net>
 <20190905105749.GW2386@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xpghzs3x7rsccuuz"
Content-Disposition: inline
In-Reply-To: <20190905105749.GW2386@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--xpghzs3x7rsccuuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-05, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Sep 05, 2019 at 11:43:05AM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 05, 2019 at 07:26:22PM +1000, Aleksa Sarai wrote:
> > > On 2019-09-05, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > On Thu, Sep 05, 2019 at 06:19:22AM +1000, Aleksa Sarai wrote:
> > > > > +/**
> > > > > + * copy_struct_to_user: copy a struct to user space
> > > > > + * @dst:   Destination address, in user space.
> > > > > + * @usize: Size of @dst struct.
> > > > > + * @src:   Source address, in kernel space.
> > > > > + * @ksize: Size of @src struct.
> > > > > + *
> > > > > + * Copies a struct from kernel space to user space, in a way tha=
t guarantees
> > > > > + * backwards-compatibility for struct syscall arguments (as long=
 as future
> > > > > + * struct extensions are made such that all new fields are *appe=
nded* to the
> > > > > + * old struct, and zeroed-out new fields have the same meaning a=
s the old
> > > > > + * struct).
> > > > > + *
> > > > > + * @ksize is just sizeof(*dst), and @usize should've been passed=
 by user space.
> > > > > + * The recommended usage is something like the following:
> > > > > + *
> > > > > + *   SYSCALL_DEFINE2(foobar, struct foo __user *, uarg, size_t, =
usize)
> > > > > + *   {
> > > > > + *      int err;
> > > > > + *      struct foo karg =3D {};
> > > > > + *
> > > > > + *      // do something with karg
> > > > > + *
> > > > > + *      err =3D copy_struct_to_user(uarg, usize, &karg, sizeof(k=
arg));
> > > > > + *      if (err)
> > > > > + *        return err;
> > > > > + *
> > > > > + *      // ...
> > > > > + *   }
> > > > > + *
> > > > > + * There are three cases to consider:
> > > > > + *  * If @usize =3D=3D @ksize, then it's copied verbatim.
> > > > > + *  * If @usize < @ksize, then kernel space is "returning" a new=
er struct to an
> > > > > + *    older user space. In order to avoid user space getting inc=
omplete
> > > > > + *    information (new fields might be important), all trailing =
bytes in @src
> > > > > + *    (@ksize - @usize) must be zerored
> > > >=20
> > > > s/zerored/zero/, right?
> > >=20
> > > It should've been "zeroed".
> >=20
> > That reads wrong to me; that way it reads like this function must take
> > that action and zero out the 'rest'; which is just wrong.
> >=20
> > This function must verify those bytes are zero, not make them zero.
> >=20
> > > > >                                          , otherwise -EFBIG is re=
turned.
> > > >=20
> > > > 'Funny' that, copy_struct_from_user() below seems to use E2BIG.
> > >=20
> > > This is a copy of the semantics that sched_[sg]etattr(2) uses -- E2BI=
G for
> > > a "too big" struct passed to the kernel, and EFBIG for a "too big"
> > > struct passed to user-space. I would personally have preferred EMSGSI=
ZE
> > > instead of EFBIG, but felt using the existing error codes would be le=
ss
> > > confusing.
> >=20
> > Sadly a recent commit:
> >=20
> >   1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and robustify=
 sched_read_attr() ABI logic and code")
> >=20
> > Made the situation even 'worse'.
>=20
> And thinking more about things; I'm not convinced the above patch is
> actually right.
>=20
> Do we really want to simply truncate all the attributes of the task?
>=20
> And should we not at least set sched_flags when there are non-default
> clamp values applied?
>=20
> See; that is I think the primary bug that had chrt failing; we tried to
> publish the default clamp values as !0.

I just saw this patch in -rc8 -- should I even attempt to port
sched_getattr(2) to copy_struct_to_user()? I agree that publishing a
default non-zero value is a mistake -- once you do that, old user space
will either get confused or lose information.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--xpghzs3x7rsccuuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXjOZwAKCRCdlLljIbnQ
EgeZAP9UC+Kf1AuY3XgSz6a5avhF1Eskr6DzrSR4wx0T62dnoQD9GcCXU0oVrERB
0xz5K9MrU1nBr6ERqmBwygo/DVsTwAk=
=oep8
-----END PGP SIGNATURE-----

--xpghzs3x7rsccuuz--
