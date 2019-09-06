Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1FAC251
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 00:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392141AbfIFWGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 18:06:15 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:29954 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392106AbfIFWGP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:06:15 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id E1EB1A107B;
        Sat,  7 Sep 2019 00:06:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id A7H_cRDXqsD8; Sat,  7 Sep 2019 00:06:06 +0200 (CEST)
Date:   Sat, 7 Sep 2019 08:05:46 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Florian Weimer <fweimer@redhat.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190906220546.gkqxzm4y3ynevvtz@yavin.dot.cyphar.com>
References: <20190906152455.22757-1-mic@digikod.net>
 <20190906152455.22757-2-mic@digikod.net>
 <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
 <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
 <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org>
 <20190906171335.d7mc3no5tdrcn6r5@yavin.dot.cyphar.com>
 <e1ac9428e6b768ac3145aafbe19b24dd6cf410b9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hzjxi4l2tpqisjxr"
Content-Disposition: inline
In-Reply-To: <e1ac9428e6b768ac3145aafbe19b24dd6cf410b9.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--hzjxi4l2tpqisjxr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-06, Jeff Layton <jlayton@kernel.org> wrote:
> On Sat, 2019-09-07 at 03:13 +1000, Aleksa Sarai wrote:
> > On 2019-09-06, Jeff Layton <jlayton@kernel.org> wrote:
> > > On Fri, 2019-09-06 at 18:06 +0200, Micka=EBl Sala=FCn wrote:
> > > > On 06/09/2019 17:56, Florian Weimer wrote:
> > > > > Let's assume I want to add support for this to the glibc dynamic =
loader,
> > > > > while still being able to run on older kernels.
> > > > >=20
> > > > > Is it safe to try the open call first, with O_MAYEXEC, and if tha=
t fails
> > > > > with EINVAL, try again without O_MAYEXEC?
> > > >=20
> > > > The kernel ignore unknown open(2) flags, so yes, it is safe even for
> > > > older kernel to use O_MAYEXEC.
> > > >=20
> > >=20
> > > Well...maybe. What about existing programs that are sending down bogus
> > > open flags? Once you turn this on, they may break...or provide a way =
to
> > > circumvent the protections this gives.
> >=20
> > It should be noted that this has been a valid concern for every new O_*
> > flag introduced (and yet we still introduced new flags, despite the
> > concern) -- though to be fair, O_TMPFILE actually does have a
> > work-around with the O_DIRECTORY mask setup.
> >=20
> > The openat2() set adds O_EMPTYPATH -- though in fairness it's also
> > backwards compatible because empty path strings have always given ENOENT
> > (or EINVAL?) while O_EMPTYPATH is a no-op non-empty strings.
> >=20
> > > Maybe this should be a new flag that is only usable in the new openat=
2()
> > > syscall that's still under discussion? That syscall will enforce that
> > > all flags are recognized. You presumably wouldn't need the sysctl if =
you
> > > went that route too.
> >=20
> > I'm also interested in whether we could add an UPGRADE_NOEXEC flag to
> > how->upgrade_mask for the openat2(2) patchset (I reserved a flag bit for
> > it, since I'd heard about this work through the grape-vine).
> >=20
>=20
> I rather like the idea of having openat2 fds be non-executable by
> default, and having userland request it specifically via O_MAYEXEC (or
> some similar openat2 flag) if it's needed. Then you could add an
> UPGRADE_EXEC flag instead?
>=20
> That seems like something reasonable to do with a brand new API, and
> might be very helpful for preventing certain classes of attacks.

In that case, maybe openat2(2) should default to not allowing any
upgrades by default? The reason I pitched UPGRADE_NOEXEC is because
UPGRADE_NO{READ,WRITE} are the existing @how->upgrade_mask flags.

However, I just noticed something else about this series -- if you do
O_PATH|O_MAYEXEC the new flag gets ignored. Given that you can do
fexecve(2) on an O_PATH (and O_PATHs have some other benefits), is this
something that we'd want to have?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--hzjxi4l2tpqisjxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXLYNwAKCRCdlLljIbnQ
EgL6APsE8ukJjBgDXqsWSAB5qojHX/kiDFpH8SNcQ7ll9qDWoQEA1azjUmwZIuag
abVp9S1zKQWqQobR05kRty8P5rp3swE=
=ubv+
-----END PGP SIGNATURE-----

--hzjxi4l2tpqisjxr--
