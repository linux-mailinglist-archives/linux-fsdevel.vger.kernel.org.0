Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F1AD855
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 13:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404506AbfIILy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 07:54:56 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:34966 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730901AbfIILy4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:54:56 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id BAB3BA01CD;
        Mon,  9 Sep 2019 13:54:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id v88C_yIZE0OA; Mon,  9 Sep 2019 13:54:46 +0200 (CEST)
Date:   Mon, 9 Sep 2019 21:54:37 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>
Cc:     James Morris <jmorris@namei.org>, Jeff Layton <jlayton@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
Message-ID: <20190909115437.jwpyslcdhhvzo7g5@yavin>
References: <20190906152455.22757-1-mic@digikod.net>
 <20190906152455.22757-2-mic@digikod.net>
 <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
 <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
 <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org>
 <1fbf54f6-7597-3633-a76c-11c4b2481add@ssi.gouv.fr>
 <5a59b309f9d0603d8481a483e16b5d12ecb77540.camel@kernel.org>
 <alpine.LRH.2.21.1909061202070.18660@namei.org>
 <49e98ece-e85f-3006-159b-2e04ba67019e@ssi.gouv.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ez37ojmvznisdz5u"
Content-Disposition: inline
In-Reply-To: <49e98ece-e85f-3006-159b-2e04ba67019e@ssi.gouv.fr>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ez37ojmvznisdz5u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-09, Micka=EBl Sala=FCn <mickael.salaun@ssi.gouv.fr> wrote:
> On 06/09/2019 21:03, James Morris wrote:
> > On Fri, 6 Sep 2019, Jeff Layton wrote:
> >
> >> The fact that open and openat didn't vet unknown flags is really a bug.
> >>
> >> Too late to fix it now, of course, and as Aleksa points out, we've
> >> worked around that in the past. Now though, we have a new openat2
> >> syscall on the horizon. There's little need to continue these sorts of
> >> hacks.
> >>
> >> New open flags really have no place in the old syscalls, IMO.
> >
> > Agree here. It's unfortunate but a reality and Linus will reject any su=
ch
> > changes which break existing userspace.
>=20
> Do you mean that adding new flags to open(2) is not possible?

It is possible, as long as there is no case where a program that works
today (and passes garbage to the unused bits in flags) works with the
change.

O_TMPFILE was okay because it's actually two flags (one is O_DIRECTORY)
and no working program does file IO to a directory (there are also some
other tricky things done there, I'll admit I don't fully understand it).

O_EMPTYPATH works because it's a no-op with non-empty path strings, and
empty path strings have always given an error (so no working program
does it today).

However, O_MAYEXEC will result in programs that pass garbage bits to
potentially get -EACCES that worked previously.

> As I said, O_MAYEXEC should be ignored if it is not supported by the
> kernel, which perfectly fit with the current open(2) flags behavior, and
> should also behave the same with openat2(2).

NACK on having that behaviour with openat2(2). -EINVAL on unknown flags
is how all other syscalls work (any new syscall proposed today that
didn't do that would be rightly rejected), and is a quirk of open(2)
which unfortunately cannot be fixed. The fact that *every new O_ flag
needs to work around this problem* should be an indication that this
interface mis-design should not be allowed to infect any more syscalls.

Note that this point is regardless of the fact that O_MAYEXEC is a
*security* flag -- if userspace wants to have a secure fallback on
old kernels (which is "the right thing" to do) they would have to do
more work than necessary. And programs that don't care don't have to do
anything special.

However with -EINVAL, the programs doing "the right thing" get an easy
-EINVAL check. And programs that don't care can just un-set O_MAYEXEC
and retry. You should be forced to deal with the case where a flag is
not supported -- and this is doubly true of security flags!

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ez37ojmvznisdz5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXY9egAKCRCdlLljIbnQ
EjqNAQDvCWENjLmSU64mc7qWEe/HYDu0pcFBvD0dJVUnIZyr0QD/dtKaeEjccIWh
RCZTPOrv97U5RjHt3IPWeWSeHVLCcAo=
=tOAG
-----END PGP SIGNATURE-----

--ez37ojmvznisdz5u--
