Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2B1A7892
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 12:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438463AbgDNKh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 06:37:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:48660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438448AbgDNKfi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:35:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 873BAABB2;
        Tue, 14 Apr 2020 10:35:33 +0000 (UTC)
Date:   Tue, 14 Apr 2020 20:35:24 +1000
From:   Aleksa Sarai <asarai@suse.de>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2)
 syscall
Message-ID: <20200414103524.wjhyfobzpjk236o7@yavin.dot.cyphar.com>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-3-cyphar@cyphar.com>
 <1567baea-5476-6d21-4f03-142def0f62e3@gmail.com>
 <20200331143911.lokfoq3lqfri2mgy@yavin.dot.cyphar.com>
 <cd3a6aad-b906-ee57-1b5b-5939b9602ad0@gmail.com>
 <20200412164943.imwpdj5qgtyfn5de@yavin.dot.cyphar.com>
 <cd1438ab-cfc6-b286-849e-d7de0d5c7258@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imnm2xqfgm757zs2"
Content-Disposition: inline
In-Reply-To: <cd1438ab-cfc6-b286-849e-d7de0d5c7258@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--imnm2xqfgm757zs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-13, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> >>>> .\" FIXME I find the "previously-functional systems" in the previous
> >>>> .\" sentence a little odd (since openat2() ia new sysycall), so I wo=
uld
> >>>> .\" like to clarify a little...
> >>>> .\" Are you referring to the scenario where someone might take an
> >>>> .\" existing application that uses openat() and replaces the uses
> >>>> .\" of openat() with openat2()? In which case, is it correct to
> >>>> .\" understand that you mean that one should not just indiscriminate=
ly
> >>>> .\" add the RESOLVE_NO_XDEV flag to all of the openat2() calls?
> >>>> .\" If I'm not on the right track, could you point me in the right
> >>>> .\" direction please.
> >>>
> >>> This is mostly meant as a warning to hopefully avoid applications
> >>> because the developer didn't realise that system paths may contain
> >>> symlinks or bind-mounts. For an application which has switched to
> >>> openat2() and then uses RESOLVE_NO_SYMLINKS for a non-security reason,
> >>> it's possible that on some distributions (or future versions of a
> >>> distribution) that their application will stop working because a syst=
em
> >>> path suddenly contains a symlink or is a bind-mount.
> >>>
> >>> This was a concern which was brought up on LWN some time ago. If you =
can
> >>> think of a phrasing that makes this more clear, I'd appreciate it.
> >>
> >> Thanks. I've made the text:
> >>
> >>                      Applications  that  employ  the RESOLVE_NO_XDEV f=
lag
> >>                      are encouraged to make its use configurable  (unl=
ess
> >>                      it is used for a specific security purpose), as b=
ind
> >>                      mounts are widely used by end-users.   Setting  t=
his
> >>                      flag indiscriminately=E2=80=94i.e., for purposes =
not specif=E2=80=90
> >>                      ically related to security=E2=80=94for all uses o=
f openat2()
> >>                      may  result  in  spurious errors on previously-fu=
nc=E2=80=90
> >>                      tional systems.  This may occur if, for  example,=
  a
> >>                      system  pathname  that  is used by an application=
 is
> >>                      modified (e.g., in a new  distribution  release) =
 so
> >>                      that  a  pathname  component  (now)  contains a b=
ind
> >>                      mount.
> >>
> >> Okay?
> >=20
> > Yup,
>=20
> Thanks.
>=20
> > and the same text should be used for the same warning I gave for
> > RESOLVE_NO_SYMLINKS (for the same reason, because system paths may
> > switch to symlinks -- the prime example being what Arch Linux did
> > several years ago).
>=20
> Okay -- I added similar text to RESOLVE_NO_SYMLINKS.

Much appreciated.

> >>>> .\" FIXME: what specific details in symlink(7) are being referred
> >>>> .\" by the following sentence? It's not clear.
> >>>
> >>> The section on magic-links, but you're right that the sentence orderi=
ng
> >>> is a bit odd. It should probably go after the first sentence.
> >>
> >> I must admit that I'm still confused. There's only the briefest of=20
> >> mentions of magic links in symlink(7). Perhaps that needs to be fixed?
> >=20
> > It wouldn't hurt to add a longer description of magic-links in
> > symlink(7). I'll send you a small patch to beef up the description (I
> > had planned to include a longer rewrite with the O_EMPTYPATH patches but
> > those require quite a bit more work to land).
>=20
> That would be great. Thank you!

I'll cook something up later this week.

> >> And, while I think of it, the text just preceding that FIXME says:
> >>
> >>     Due to the potential danger of unknowingly opening=20
> >>     these magic links, it may be preferable for users to=20
> >>     disable their resolution entirely.
> >>
> >> This sentence reads a little strangely. Could you please give me some
> >> concrete examples, and I will try rewording that sentence a bit.
> >=20
> > The primary example is that certain files (such as tty devices) are
> > best not opened by an unsuspecting program (if you do not have a
> > controlling TTY, and you open such a file that console becomes your
> > controlling TTY unless you use O_NOCTTY).
> >=20
> > But more generally, magic-links allow programs to be "beamed" all over
> > the system (bypassing ordinary mount namespace restrictions). Since they
> > are fairly rarely used intentionally by most programs, this is more of a
> > tip to programmers that maybe they should play it safe and disallow
> > magic-links unless they are expecting to have to use them.
>=20
>=20
> I've reworked the text on RESOLVE_NO_MAGICLINKS substantially:
>=20
>        RESOLVE_NO_MAGICLINKS
>               Disallow all magic-link resolution during path reso=E2=80=90
>               lution.
>=20
>               Magic links are symbolic link-like objects that  are
>               most  notably  found  in  proc(5);  examples include
>               /proc/[pid]/exe  and  /proc/[pid]/fd/*.   (See  sym=E2=80=90
>               link(7) for more details.)
>=20
>               Unknowingly  opening  magic  links  can be risky for
>               some applications.  Examples of such  risks  include
>               the following:
>=20
>               =C2=B7 If the process opening a pathname is a controlling
>                 process that currently has no controlling terminal
>                 (see  credentials(7)),  then  opening a magic link
>                 inside /proc/[pid]/fd that happens to refer  to  a
>                 terminal would cause the process to acquire a con=E2=80=90
>                 trolling terminal.
>=20
>               =C2=B7 In  a  containerized  environment,  a  magic  link
>                 inside  /proc  may  refer to an object outside the
>                 container, and thus may provide a means to  escape
>                 from the container.
>=20
> [The above example derives from https://lwn.net/Articles/796868/]
>=20
>               Because  of such risks, an application may prefer to
>               disable   magic   link    resolution    using    the
>               RESOLVE_NO_MAGICLINKS flag.
>=20
>               If  the trailing component (i.e., basename) of path=E2=80=90
>               name is a magic link, and  how.flags  contains  both
>               O_PATH  and O_NOFOLLOW, then an O_PATH file descrip=E2=80=90
>               tor referencing the magic link will be returned.
>=20
> How does the above look?

The changes look correct, though you could end up going through procfs
even if you weren't resolving a path inside proc directly (since you can
bind-mount symlinks or have a symlink to procfs). But I'm not sure if
it's necessary to outline all the ways a program could be tricked into
doing something unintended.

> Also, regarding the last paragraph, I  have a question.  The
> text doesn't seem quite to relate to the rest of the discussion.
> Should it be saying something like:
>=20
> If the trailing component (i.e., basename) of pathname is a magic link,
> **how.resolve contains RESOLVE_NO_MAGICLINKS,**
> and how.flags contains both O_PATH and O_NOFOLLOW, then an O_PATH
> file descriptor referencing the magic link will be returned.
>=20
> ?

Yes, that is what I meant to write -- and I believe that the
RESOLVE_NO_SYMLINKS section is missing similar text in the second
paragraph (except it should refer to RESOLVE_NO_SYMLINKS, obviously).

Thanks!

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--imnm2xqfgm757zs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAl6VkekACgkQnhiqJn3b
jbRFCBAAySOXNoi4rBtphTOrPpV04SkFI3zJXufokazx9NSB/q0Wn399VAyuwORF
R8Zlq+6SvA/jDR/oOBduXIWOWs1wcnI3a+fBF5lhm63Gidvf1NroIAYnHS+kJ91Z
gnZlleHHx9QOwYp3Ds6CTphKBJ5kYIArTIMaPyrEyd7gmDyT+oEJ25s+WidiYDUe
I0IVdjLJNc9U7QG2va02xhv91QSkZYDvsZH+mjcZs1fZAksccEIB8oovUUz7sI8t
mLlpHdcx9X+75QJozHyzoBB4Zh0fyndkzVpgKyvZgS2ZKWzra94Lln0ZBv/jP+kl
4Lk0a1L0YIrr2EYXVgcjQM+G8HOozVYQfoaabtdxLB5qKTv3Xlfb/imeOAG0d86K
9pUANSuDg0JQwFcxnIcEDoNtmiRdmovF67wdBM73z001TScYuBchwQALkBAwbpXF
OAi0wrOv6oZ7xpoCHEY5jrV472fGA/3fnBR+eV/9X2jEjmsLTFZSaINxvRTNZT1H
ClxmIEJE0pkS1FsuBCxYyihpTWNZ2nDlSmSZAxNrz9/s7zyAvOUEr1zY3yACsjLJ
Xx0A/TiTdvm4d8/Zw6cteImWKVXxj6Wko1pLvXTbOEgv3xQV1WAe4hbvraqUnoB0
PBSuKd7vQtGxlg9cHOEPGablYwu4SXnIgQPBszoGOBT6vRNf5Jo=
=vLXb
-----END PGP SIGNATURE-----

--imnm2xqfgm757zs2--
