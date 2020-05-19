Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802BE1D8D92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 04:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgESCXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 22:23:46 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:12746 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgESCXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 22:23:45 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 49R0714S3fzQlJp;
        Tue, 19 May 2020 04:23:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id DZqWh7er1wSe; Tue, 19 May 2020 04:23:34 +0200 (CEST)
Date:   Tue, 19 May 2020 12:23:07 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        "Lev R. Oshvang ." <levonshe@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: How about just O_EXEC? (was Re: [PATCH v5 3/6] fs: Enable to
 enforce noexec mounts or file exec through O_MAYEXEC)
Message-ID: <20200519022307.oqpdb4vzghs3coyi@yavin.dot.cyphar.com>
References: <202005132002.91B8B63@keescook>
 <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
 <202005140830.2475344F86@keescook>
 <CAEjxPJ4R_juwvRbKiCg5OGuhAi1ZuVytK4fKCDT_kT6VKc8iRg@mail.gmail.com>
 <b740d658-a2da-5773-7a10-59a0ca52ac6b@digikod.net>
 <202005142343.D580850@keescook>
 <87a729wpu1.fsf@oldenburg2.str.redhat.com>
 <202005150732.17C5EE0@keescook>
 <87r1vluuli.fsf@oldenburg2.str.redhat.com>
 <202005150847.2B1ED8F81@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nmvvtdsznpppdmip"
Content-Disposition: inline
In-Reply-To: <202005150847.2B1ED8F81@keescook>
X-Rspamd-Queue-Id: 7E02D177E
X-Rspamd-Score: -7.06 / 15.00 / 15.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--nmvvtdsznpppdmip
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-15, Kees Cook <keescook@chromium.org> wrote:
> On Fri, May 15, 2020 at 04:43:37PM +0200, Florian Weimer wrote:
> > * Kees Cook:
> >=20
> > > On Fri, May 15, 2020 at 10:43:34AM +0200, Florian Weimer wrote:
> > >> * Kees Cook:
> > >>=20
> > >> > Maybe I've missed some earlier discussion that ruled this out, but=
 I
> > >> > couldn't find it: let's just add O_EXEC and be done with it. It ac=
tually
> > >> > makes the execve() path more like openat2() and is much cleaner af=
ter
> > >> > a little refactoring. Here are the results, though I haven't email=
ed it
> > >> > yet since I still want to do some more testing:
> > >> > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log=
/?h=3Dkspp/o_exec/v1
> > >>=20
> > >> I think POSIX specifies O_EXEC in such a way that it does not confer
> > >> read permissions.  This seems incompatible with what we are trying to
> > >> achieve here.
> > >
> > > I was trying to retain this behavior, since we already make this
> > > distinction between execve() and uselib() with the MAY_* flags:
> > >
> > > execve():
> > >         struct open_flags open_exec_flags =3D {
> > >                 .open_flag =3D O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
> > >                 .acc_mode =3D MAY_EXEC,
> > >
> > > uselib():
> > >         static const struct open_flags uselib_flags =3D {
> > >                 .open_flag =3D O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
> > >                 .acc_mode =3D MAY_READ | MAY_EXEC,
> > >
> > > I tried to retain this in my proposal, in the O_EXEC does not imply
> > > MAY_READ:
> >=20
> > That doesn't quite parse for me, sorry.
> >=20
> > The point is that the script interpreter actually needs to *read* those
> > files in order to execute them.
>=20
> I think I misunderstood what you meant (Micka=EBl got me sorted out
> now). If O_EXEC is already meant to be "EXEC and _not_ READ nor WRITE",
> then yes, this new flag can't be O_EXEC. I was reading the glibc
> documentation (which treats it as a permission bit flag, not POSIX,
> which treats it as a complete mode description).

On the other hand, if we had O_EXEC (or O_EXONLY a-la O_RDONLY) then the
interpreter could re-open the file descriptor as O_RDONLY after O_EXEC
succeeds. Not ideal, but I don't think it's a deal-breaker.

Regarding O_MAYEXEC, I do feel a little conflicted.

I do understand that its goal is not to be what O_EXEC was supposed to
be (which is loosely what O_PATH has effectively become), so I think
that this is not really a huge problem -- especially since you could
just do O_MAYEXEC|O_PATH if you wanted to disallow reading explicitly.
It would be nice to have an O_EXONLY concept, but it's several decades
too late to make it mandatory (and making it optional has questionable
utility IMHO).

However, the thing I still feel mildly conflicted about is the sysctl. I
do understand the argument for it (ultimately, whether O_MAYEXEC is
usable on a system depends on the distribution) but it means that any
program which uses O_MAYEXEC cannot rely on it to provide the security
guarantees they expect. Even if the program goes and reads the sysctl
value, it could change underneath them. If this is just meant to be a
best-effort protection then this doesn't matter too much, but I just
feel uneasy about these kinds of best-effort protections.

I do wonder if we could require that fexecve(3) can only be done with
file descriptors that have been opened with O_MAYEXEC (obviously this
would also need to be a sysctl -- *sigh*). This would tie in to some of
the magic-link changes I wanted to push (namely, upgrade_mask).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nmvvtdsznpppdmip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXsNDCAAKCRCdlLljIbnQ
Ep1qAQCjFv2VG5NQz8tGYkrTeOm2XgvCB0zQ3mmGYhFYEMKpYgD+J4hGIJA2Uqq8
NSOE5oY1uvmG7wnuYY2/cbJlZVeF/Ao=
=GDei
-----END PGP SIGNATURE-----

--nmvvtdsznpppdmip--
