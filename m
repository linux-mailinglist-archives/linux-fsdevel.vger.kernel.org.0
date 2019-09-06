Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E5AC258
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 00:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392213AbfIFWNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 18:13:14 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:53754 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731008AbfIFWNO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:13:14 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id E7F84A0204;
        Sat,  7 Sep 2019 00:13:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id Aw57XlzZjjtI; Sat,  7 Sep 2019 00:13:06 +0200 (CEST)
Date:   Sat, 7 Sep 2019 08:12:45 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
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
Message-ID: <20190906221245.3xxgiqhoeycibflj@yavin.dot.cyphar.com>
References: <20190906152455.22757-1-mic@digikod.net>
 <20190906152455.22757-2-mic@digikod.net>
 <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
 <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
 <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org>
 <20190906171335.d7mc3no5tdrcn6r5@yavin.dot.cyphar.com>
 <e1ac9428e6b768ac3145aafbe19b24dd6cf410b9.camel@kernel.org>
 <D2A57C7B-B0FD-424E-9F81-B858FFF21FF0@amacapital.net>
 <8dc59d585a133e96f9adaf0a148334e7f19058b9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ous2hk66zggvczbo"
Content-Disposition: inline
In-Reply-To: <8dc59d585a133e96f9adaf0a148334e7f19058b9.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ous2hk66zggvczbo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-06, Jeff Layton <jlayton@kernel.org> wrote:
> On Fri, 2019-09-06 at 13:06 -0700, Andy Lutomirski wrote:
> > > On Sep 6, 2019, at 12:43 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > > On Sat, 2019-09-07 at 03:13 +1000, Aleksa Sarai wrote:
> > > > > On 2019-09-06, Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > On Fri, 2019-09-06 at 18:06 +0200, Micka=C3=ABl Sala=C3=BCn wro=
te:
> > > > > > > On 06/09/2019 17:56, Florian Weimer wrote:
> > > > > > > Let's assume I want to add support for this to the glibc dyna=
mic loader,
> > > > > > > while still being able to run on older kernels.
> > > > > > >=20
> > > > > > > Is it safe to try the open call first, with O_MAYEXEC, and if=
 that fails
> > > > > > > with EINVAL, try again without O_MAYEXEC?
> > > > > >=20
> > > > > > The kernel ignore unknown open(2) flags, so yes, it is safe eve=
n for
> > > > > > older kernel to use O_MAYEXEC.
> > > > > >=20
> > > > >=20
> > > > > Well...maybe. What about existing programs that are sending down =
bogus
> > > > > open flags? Once you turn this on, they may break...or provide a =
way to
> > > > > circumvent the protections this gives.
> > > >=20
> > > > It should be noted that this has been a valid concern for every new=
 O_*
> > > > flag introduced (and yet we still introduced new flags, despite the
> > > > concern) -- though to be fair, O_TMPFILE actually does have a
> > > > work-around with the O_DIRECTORY mask setup.
> > > >=20
> > > > The openat2() set adds O_EMPTYPATH -- though in fairness it's also
> > > > backwards compatible because empty path strings have always given E=
NOENT
> > > > (or EINVAL?) while O_EMPTYPATH is a no-op non-empty strings.
> > > >=20
> > > > > Maybe this should be a new flag that is only usable in the new op=
enat2()
> > > > > syscall that's still under discussion? That syscall will enforce =
that
> > > > > all flags are recognized. You presumably wouldn't need the sysctl=
 if you
> > > > > went that route too.
> > > >=20
> > > > I'm also interested in whether we could add an UPGRADE_NOEXEC flag =
to
> > > > how->upgrade_mask for the openat2(2) patchset (I reserved a flag bi=
t for
> > > > it, since I'd heard about this work through the grape-vine).
> > > >=20
> > >=20
> > > I rather like the idea of having openat2 fds be non-executable by
> > > default, and having userland request it specifically via O_MAYEXEC (or
> > > some similar openat2 flag) if it's needed. Then you could add an
> > > UPGRADE_EXEC flag instead?
> > >=20
> > > That seems like something reasonable to do with a brand new API, and
> > > might be very helpful for preventing certain classes of attacks.
> > >=20
> > >=20
> >=20
> > There are at least four concepts of executability here:
> >=20
> > - Just check the file mode and any other relevant permissions. Return a=
 normal fd.  Makes sense for script interpreters, perhaps.
> >=20
> > - Make the fd fexecve-able.
> >=20
> > - Make the resulting fd mappable PROT_EXEC.
> >=20
> > - Make the resulting fd upgradable.
> >=20
> > I=E2=80=99m not at all convinced that the kernel needs to distinguish a=
ll these, but at least upgradability should be its own thing IMO.
>=20
> Good point. Upgradability is definitely orthogonal, though the idea
> there is to alter the default behavior. If the default is NOEXEC then
> UPGRADE_EXEC would make sense.
>=20
> In any case, I was mostly thinking about the middle two in your list
> above. After more careful reading of the patches, I now get get that
> Micka=C3=ABl is more interested in the first, and that's really a differe=
nt
> sort of use-case.
>=20
> Most opens never result in the fd being fed to fexecve or mmapped with
> PROT_EXEC, so having userland explicitly opt-in to allowing that during
> the open sounds like a reasonable thing to do.
>=20
> But I get that preventing execution via script interpreters of files
> that are not executable might be something nice to have.

My first glance at the patch lead me to believe that this was about
blocking at fexecve()-time (which was what my first attempt at this
problem looked like) -- hence why I mentioned the upgrade_mask stuff
(because of the dances you can do with O_PATH, if blocking at
fexecve()-time was the goal then you seriously do need the upgrade_mask
and "O_PATH mask" in order for it to be even slightly secure).

But I also agree this is useful, and we can always add FMODE_EXEC,
FMODE_MAP_EXEC, and FMODE_UPGRADE_EXEC (and the related bits) at a later
date.

> Perhaps we need two flags for openat2?
>=20
> OA2_MAYEXEC : test that permissions allow execution and that the file
> doesn't reside on a noexec mount before allowing the open
>=20
> OA2_EXECABLE : only allow fexecve or mmapping with PROT_EXEC if the fd
> was opened with this

That seems reasonable to me. The only thing is that there currently
isn't any code to restrict fexecve() or PROT_EXEC in that fashion
(doubly so when you consider binfmt_script). So if we want to make
certain things default behaviour (such as disallowing exec by default)
we'd need to get the PROT_EXEC restriction work done first.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ous2hk66zggvczbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXLZ2gAKCRCdlLljIbnQ
EmAaAP4zDFWQOoCFE6dg72A3LhSLgvhyHEIPEHEl9DEDVDLzLgD/ayC/B0ck1Mvk
T2lLChd6wfL+d7qgNlFg+yc0dWbxEQA=
=RGyl
-----END PGP SIGNATURE-----

--ous2hk66zggvczbo--
