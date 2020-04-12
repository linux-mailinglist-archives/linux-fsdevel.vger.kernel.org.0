Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3478A1A5F6C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 18:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgDLQzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgDLQzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 12:55:07 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848A9C0A3BF5;
        Sun, 12 Apr 2020 09:49:58 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 490d5b5FnlzQl1t;
        Sun, 12 Apr 2020 18:49:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id uaGde-C1kHvu; Sun, 12 Apr 2020 18:49:52 +0200 (CEST)
Date:   Mon, 13 Apr 2020 02:49:43 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2)
 syscall
Message-ID: <20200412164943.imwpdj5qgtyfn5de@yavin.dot.cyphar.com>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-3-cyphar@cyphar.com>
 <1567baea-5476-6d21-4f03-142def0f62e3@gmail.com>
 <20200331143911.lokfoq3lqfri2mgy@yavin.dot.cyphar.com>
 <cd3a6aad-b906-ee57-1b5b-5939b9602ad0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sk2rmexkwnlikbil"
Content-Disposition: inline
In-Reply-To: <cd3a6aad-b906-ee57-1b5b-5939b9602ad0@gmail.com>
X-Rspamd-Queue-Id: 65CA51666
X-Rspamd-Score: -5.74 / 15.00 / 15.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sk2rmexkwnlikbil
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry, I could've sworn I responded when you posted this -- comments
below. And sorry for not getting back to you before the 5.06 release.

On 2020-04-01, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> On 3/31/20 4:39 PM, Aleksa Sarai wrote:
> > On 2020-03-30, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wro=
te:
> >> On 2/2/20 4:19 PM, Aleksa Sarai wrote:
> >>> Rather than trying to merge the new syscall documentation into open.2
> >>> (which would probably result in the man-page being incomprehensible),
> >>> instead the new syscall gets its own dedicated page with links between
> >>> open(2) and openat2(2) to avoid duplicating information such as the l=
ist
> >>> of O_* flags or common errors.
> >>>
> >>> In addition to describing all of the key flags, information about the
> >>> extensibility design is provided so that users can better understand =
why
> >>> they need to pass sizeof(struct open_how) and how their programs will
> >>> work across kernels. After some discussions with David Laight, I also
> >>> included explicit instructions to zero the structure to avoid issues
> >>> when recompiling with new headers.
> >>>
> >>> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> >>
> >> Thanks. I've applied this patch, but also done quite a lot of
> >> editing of the page. The current draft is below (and also pushed=20
> >> to Git). Could I ask you to review the page, to see if I injected
> >> any error during my edits.
> >=20
> > Looks good to me.
> >=20
> >> In addition, I've added a number of FIXMEs in comments
> >> in the page source. Can you please check these, and let me
> >> know your thoughts.
> >=20
> > Will do, see below.
> >=20
> >> .\" FIXME I find the "previously-functional systems" in the previous
> >> .\" sentence a little odd (since openat2() ia new sysycall), so I would
> >> .\" like to clarify a little...
> >> .\" Are you referring to the scenario where someone might take an
> >> .\" existing application that uses openat() and replaces the uses
> >> .\" of openat() with openat2()? In which case, is it correct to
> >> .\" understand that you mean that one should not just indiscriminately
> >> .\" add the RESOLVE_NO_XDEV flag to all of the openat2() calls?
> >> .\" If I'm not on the right track, could you point me in the right
> >> .\" direction please.
> >=20
> > This is mostly meant as a warning to hopefully avoid applications
> > because the developer didn't realise that system paths may contain
> > symlinks or bind-mounts. For an application which has switched to
> > openat2() and then uses RESOLVE_NO_SYMLINKS for a non-security reason,
> > it's possible that on some distributions (or future versions of a
> > distribution) that their application will stop working because a system
> > path suddenly contains a symlink or is a bind-mount.
> >=20
> > This was a concern which was brought up on LWN some time ago. If you can
> > think of a phrasing that makes this more clear, I'd appreciate it.
>=20
> Thanks. I've made the text:
>=20
>                      Applications  that  employ  the RESOLVE_NO_XDEV flag
>                      are encouraged to make its use configurable  (unless
>                      it is used for a specific security purpose), as bind
>                      mounts are widely used by end-users.   Setting  this
>                      flag indiscriminately=E2=80=94i.e., for purposes not=
 specif=E2=80=90
>                      ically related to security=E2=80=94for all uses of o=
penat2()
>                      may  result  in  spurious errors on previously-func=
=E2=80=90
>                      tional systems.  This may occur if, for  example,  a
>                      system  pathname  that  is used by an application is
>                      modified (e.g., in a new  distribution  release)  so
>                      that  a  pathname  component  (now)  contains a bind
>                      mount.
>=20
> Okay?

Yup, and the same text should be used for the same warning I gave for
RESOLVE_NO_SYMLINKS (for the same reason, because system paths may
switch to symlinks -- the prime example being what Arch Linux did
several years ago).

> >> .\" FIXME: what specific details in symlink(7) are being referred
> >> .\" by the following sentence? It's not clear.
> >=20
> > The section on magic-links, but you're right that the sentence ordering
> > is a bit odd. It should probably go after the first sentence.
>=20
> I must admit that I'm still confused. There's only the briefest of=20
> mentions of magic links in symlink(7). Perhaps that needs to be fixed?

It wouldn't hurt to add a longer description of magic-links in
symlink(7). I'll send you a small patch to beef up the description (I
had planned to include a longer rewrite with the O_EMPTYPATH patches but
those require quite a bit more work to land).

> And, while I think of it, the text just preceding that FIXME says:
>=20
>     Due to the potential danger of unknowingly opening=20
>     these magic links, it may be preferable for users to=20
>     disable their resolution entirely.
>=20
> This sentence reads a little strangely. Could you please give me some
> concrete examples, and I will try rewording that sentence a bit.

The primary example is that certain files (such as tty devices) are
best not opened by an unsuspecting program (if you do not have a
controlling TTY, and you open such a file that console becomes your
controlling TTY unless you use O_NOCTTY).

But more generally, magic-links allow programs to be "beamed" all over
the system (bypassing ordinary mount namespace restrictions). Since they
are fairly rarely used intentionally by most programs, this is more of a
tip to programmers that maybe they should play it safe and disallow
magic-links unless they are expecting to have to use them.

> >> .\" FIXME I found the following hard to understand (in particular, the
> >> .\" meaning of "scoped" is unclear) , and reworded as below. Is it oka=
y?
> >> .\"     Absolute symbolic links and ".." path components will be scope=
d to
> >> .\"     .IR dirfd .
> >=20
> > Scoped does broadly mean "interpreted relative to", though the
> > difference is mainly that when I said scoped it's meant to be more of an
> > assertive claim ("the kernel promises to always treat this path inside
> > dirfd"). But "interpreted relative to" is a clearer way of phrasing the
> > semantics, so I'm okay with this change.
>=20
> Okay.
>=20
> >> .\" FIXME The next piece is unclear (to me). What kind of ".." escape
> >> .\" attempts does chroot() not detect that RESOLVE_IN_ROOT does?
> >=20
> > If the root is moved, you can escape from a chroot(2). But this sentence
> > might not really belong in a man-page since it's describing (important)
> > aspects of the implementation and not the semantics.
>=20
> So, should I just remove the sentence?

Yup, sounds reasonable.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--sk2rmexkwnlikbil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXpNGpAAKCRCdlLljIbnQ
Eu41AQC5eoSSECNWVaMgwzaC7W/Qobh6lI4TM6FTh5iy0Z1qqgD/Yq2YO1zmslfV
YITOlptH67Fzel45Fqz0P0Zo0DgGgAE=
=D0Zq
-----END PGP SIGNATURE-----

--sk2rmexkwnlikbil--
