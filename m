Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4EB8E2AC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 09:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392436AbfJXHGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 03:06:41 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:11256 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfJXHGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:06:41 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 46zJFS55d2zKmhs;
        Thu, 24 Oct 2019 09:06:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id DAIjq9oYK49d; Thu, 24 Oct 2019 09:06:30 +0200 (CEST)
Date:   Thu, 24 Oct 2019 18:06:04 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v14 2/6] namei: LOOKUP_IN_ROOT: chroot-like path
 resolution
Message-ID: <20191024070604.howuh6x6qrzd5jsm@yavin.dot.cyphar.com>
References: <20191010054140.8483-1-cyphar@cyphar.com>
 <20191010054140.8483-3-cyphar@cyphar.com>
 <CAHk-=wh8L50f31vW8BwRUXhLiq3eoCQ3tg8ER4Yp2dzuU1w5rQ@mail.gmail.com>
 <20191012040815.gnc43cfmo5mnv67u@yavin.dot.cyphar.com>
 <20191012041541.milbmfbjpj5bcl5a@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i56sxfhksaspu3tw"
Content-Disposition: inline
In-Reply-To: <20191012041541.milbmfbjpj5bcl5a@yavin.dot.cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--i56sxfhksaspu3tw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-12, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2019-10-12, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > On 2019-10-10, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > On Wed, Oct 9, 2019 at 10:42 PM Aleksa Sarai <cyphar@cyphar.com> wrot=
e:
> > > >
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -2277,6 +2277,11 @@ static const char *path_init(struct nameidat=
a *nd, unsigned flags)
> > > >
> > > >         nd->m_seq =3D read_seqbegin(&mount_lock);
> > > >
> > > > +       /* LOOKUP_IN_ROOT treats absolute paths as being relative-t=
o-dirfd. */
> > > > +       if (flags & LOOKUP_IN_ROOT)
> > > > +               while (*s =3D=3D '/')
> > > > +                       s++;
> > > > +
> > > >         /* Figure out the starting path and root (if needed). */
> > > >         if (*s =3D=3D '/') {
> > > >                 error =3D nd_jump_root(nd);
> > >=20
> > > Hmm. Wouldn't this make more sense all inside the if (*s =3D- '/') te=
st?
> > > That way if would be where we check for "should we start at the root",
> > > which seems to make more sense conceptually.
> >=20
> > I don't really agree (though I do think that both options are pretty
> > ugly). Doing it before the block makes it clear that absolute paths are
> > just treated relative-to-dirfd -- doing it inside the block makes it
> > look more like "/" is a special-case for nd_jump_root(). And while that
>=20
> Sorry, I meant "special-case for LOOKUP_IN_ROOT".
>=20
> > is somewhat true, this is just a side-effect of making the code more
> > clean -- my earlier versions reworked the dirfd handling to always grab
> > nd->root first if LOOKUP_IS_SCOPED. I switched to this method based on
> > Al's review.
> >=20
> > In fairness, I do agree that the lonely while loop looks ugly.
>=20
> And with the old way I did it (where we grabbed nd->root first) the
> semantics were slightly more clear -- stripping leading "/"s doesn't
> really look as "clearly obvious" as grabbing nd->root beforehand and
> treating "/"s normally. But the code was also needlessly more complex.
>=20
> > > That test for '/' currently has a "} else if (..)", but that's
> > > pointless since it ends with a "return" anyway. So the "else" logic is
> > > just noise.
> >=20
> > This depends on the fact that LOOKUP_BENEATH always triggers -EXDEV for
> > nd_jump_root() -- if we ever add another "scoped lookup" flag then the
> > logic will have to be further reworked.
> >=20
> > (It should be noted that the new version doesn't always end with a
> > "return", but you could change it to act that way given the above
> > assumption.)
> >=20
> > > And if you get rid of the unnecessary else, moving the LOOKUP_IN_ROOT
> > > inside the if-statement works fine.
> > >=20
> > > So this could be something like
> > >=20
> > >     --- a/fs/namei.c
> > >     +++ b/fs/namei.c
> > >     @@ -2194,11 +2196,19 @@ static const char *path_init(struct
> > > nameidata *nd, unsigned flags)
> > >=20
> > >         nd->m_seq =3D read_seqbegin(&mount_lock);
> > >         if (*s =3D=3D '/') {
> > >     -           set_root(nd);
> > >     -           if (likely(!nd_jump_root(nd)))
> > >     -                   return s;
> > >     -           return ERR_PTR(-ECHILD);
> > >     -   } else if (nd->dfd =3D=3D AT_FDCWD) {
> > >     +           /* LOOKUP_IN_ROOT treats absolute paths as being
> > > relative-to-dirfd. */
> > >     +           if (!(flags & LOOKUP_IN_ROOT)) {
> > >     +                   set_root(nd);
> > >     +                   if (likely(!nd_jump_root(nd)))
> > >     +                           return s;
> > >     +                   return ERR_PTR(-ECHILD);
> > >     +           }
> > >     +
> > >     +           /* Skip initial '/' for LOOKUP_IN_ROOT */
> > >     +           do { s++; } while (*s =3D=3D '/');
> > >     +   }
> > >     +
> > >     +   if (nd->dfd =3D=3D AT_FDCWD) {
> > >                 if (flags & LOOKUP_RCU) {
> > >                         struct fs_struct *fs =3D current->fs;
> > >                         unsigned seq;
> > >=20
> > > instead. The patch ends up slightly bigger (due to the re-indentation)
> > > but now it handles all the "start at root" in the same place. Doesn't
> > > that make sense?
> >=20
> > It is correct (though I'd need to clean it up a bit to handle
> > nd_jump_root() correctly), and if you really would like me to change it
> > I will -- but I just don't agree that it's cleaner.

Linus, did you still want me to make your proposed change?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--i56sxfhksaspu3tw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXbFNWQAKCRCdlLljIbnQ
Ert5AP0aC5CrGCVvHOpelKBjUDOS5duq76VaVyiiUWcy3eeeFwD/aQEQPqkGREqr
5Lo0df+nvE9H+89b7vJGbcaEZNxkTQc=
=rtfF
-----END PGP SIGNATURE-----

--i56sxfhksaspu3tw--
