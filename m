Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618811C752A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgEFPlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 11:41:52 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:24776 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgEFPlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 11:41:50 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 49HLRq0L5BzKmVK;
        Wed,  6 May 2020 17:41:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id iNb9taX10f5N; Wed,  6 May 2020 17:41:38 +0200 (CEST)
Date:   Thu, 7 May 2020 01:41:17 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Lev R. Oshvang ." <levonshe@gmail.com>
Cc:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Add support for O_MAYEXEC
Message-ID: <20200506154117.gibiibfytrdl4exo@yavin.dot.cyphar.com>
References: <20200505153156.925111-1-mic@digikod.net>
 <d4616bc0-39df-5d6c-9f5b-d84cf6e65960@digikod.net>
 <CAP22eLHres_shVWEC+2=wcKXRsQzfNKDAnyRd8yuO_gJ3Wi_JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ljnqns477wlvxj5l"
Content-Disposition: inline
In-Reply-To: <CAP22eLHres_shVWEC+2=wcKXRsQzfNKDAnyRd8yuO_gJ3Wi_JA@mail.gmail.com>
X-Rspamd-Queue-Id: BECC31754
X-Rspamd-Score: -7.67 / 15.00 / 15.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ljnqns477wlvxj5l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-06, Lev R. Oshvang . <levonshe@gmail.com> wrote:
> On Tue, May 5, 2020 at 6:36 PM Micka=EBl Sala=FCn <mic@digikod.net> wrote:
> >
> >
> > On 05/05/2020 17:31, Micka=EBl Sala=FCn wrote:
> > > Hi,
> > >
> > > This fifth patch series add new kernel configurations (OMAYEXEC_STATI=
C,
> > > OMAYEXEC_ENFORCE_MOUNT, and OMAYEXEC_ENFORCE_FILE) to enable to
> > > configure the security policy at kernel build time.  As requested by
> > > Mimi Zohar, I completed the series with one of her patches for IMA.
> > >
> > > The goal of this patch series is to enable to control script execution
> > > with interpreters help.  A new O_MAYEXEC flag, usable through
> > > openat2(2), is added to enable userspace script interpreter to delega=
te
> > > to the kernel (and thus the system security policy) the permission to
> > > interpret/execute scripts or other files containing what can be seen =
as
> > > commands.
> > >
> > > A simple system-wide security policy can be enforced by the system
> > > administrator through a sysctl configuration consistent with the mount
> > > points or the file access rights.  The documentation patch explains t=
he
> > > prerequisites.
> > >
> > > Furthermore, the security policy can also be delegated to an LSM, eit=
her
> > > a MAC system or an integrity system.  For instance, the new kernel
> > > MAY_OPENEXEC flag closes a major IMA measurement/appraisal interpreter
> > > integrity gap by bringing the ability to check the use of scripts [1].
> > > Other uses are expected, such as for openat2(2) [2], SGX integration
> > > [3], bpffs [4] or IPE [5].
> > >
> > > Userspace needs to adapt to take advantage of this new feature.  For
> > > example, the PEP 578 [6] (Runtime Audit Hooks) enables Python 3.8 to =
be
> > > extended with policy enforcement points related to code interpretatio=
n,
> > > which can be used to align with the PowerShell audit features.
> > > Additional Python security improvements (e.g. a limited interpreter
> > > withou -c, stdin piping of code) are on their way.
> > >
> > > The initial idea come from CLIP OS 4 and the original implementation =
has
> > > been used for more than 12 years:
> > > https://github.com/clipos-archive/clipos4_doc
> > >
> > > An introduction to O_MAYEXEC was given at the Linux Security Summit
> > > Europe 2018 - Linux Kernel Security Contributions by ANSSI:
> > > https://www.youtube.com/watch?v=3DchNjCRtPKQY&t=3D17m15s
> > > The "write xor execute" principle was explained at Kernel Recipes 201=
8 -
> > > CLIP OS: a defense-in-depth OS:
> > > https://www.youtube.com/watch?v=3DPjRE0uBtkHU&t=3D11m14s
> > >
> > > This patch series can be applied on top of v5.7-rc4.  This can be tes=
ted
> > > with CONFIG_SYSCTL.  I would really appreciate constructive comments =
on
> > > this patch series.
> > >
> > > Previous version:
> > > https://lore.kernel.org/lkml/20200428175129.634352-1-mic@digikod.net/
> >
> > The previous version (v4) is
> > https://lore.kernel.org/lkml/20200430132320.699508-1-mic@digikod.net/
>=20
>=20
> Hi Michael
>=20
> I have couple of question
> 1. Why you did not add O_MAYEXEC to open()?
> Some time ago (around v4.14) open() did not return EINVAL when
> VALID_OPEN_FLAGS check failed.
> Now it does, so I do not see a problem that interpreter will use
> simple open(),  ( Although that path might be manipulated, but file
> contents will be verified by IMA)

You don't get -EINVAL from open() in the case of unknown flags, that's
something only openat2() does in the open*() family. Hence why it's only
introduced for openat2().

> 2. When you apply a new flag to mount, it means that IMA will check
> all files under this mount and it does not matter whether the file in
> question is a script or not.
> IMHO it is too hard overhead for performance reasons.
>=20
> Regards,
> LEv


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ljnqns477wlvxj5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXrLamgAKCRCdlLljIbnQ
Eo2EAQDv6NtU9F0Nl45n0HGqLDKRn1IEH5GBUZwhlkUR72xbbAD8CqwZXGFnsYZB
+Che7WXy1zSGWAJq84tQAqCqj97ABAQ=
=EWAe
-----END PGP SIGNATURE-----

--ljnqns477wlvxj5l--
