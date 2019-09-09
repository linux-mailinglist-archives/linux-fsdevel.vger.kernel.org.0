Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD22AD8FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfIIM2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 08:28:19 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38106 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfIIM2T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:28:19 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id E3311A1563;
        Mon,  9 Sep 2019 14:28:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id P6hzAd9wlhqS; Mon,  9 Sep 2019 14:28:10 +0200 (CEST)
Date:   Mon, 9 Sep 2019 22:28:02 +1000
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
Message-ID: <20190909122802.imfx6wp4zeroktuz@yavin>
References: <20190906152455.22757-2-mic@digikod.net>
 <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
 <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
 <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org>
 <1fbf54f6-7597-3633-a76c-11c4b2481add@ssi.gouv.fr>
 <5a59b309f9d0603d8481a483e16b5d12ecb77540.camel@kernel.org>
 <alpine.LRH.2.21.1909061202070.18660@namei.org>
 <49e98ece-e85f-3006-159b-2e04ba67019e@ssi.gouv.fr>
 <alpine.LRH.2.21.1909090309260.27895@namei.org>
 <073cb831-7c6b-1882-9b7d-eb810a2ef955@ssi.gouv.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="no5u7udk75jfhvvn"
Content-Disposition: inline
In-Reply-To: <073cb831-7c6b-1882-9b7d-eb810a2ef955@ssi.gouv.fr>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--no5u7udk75jfhvvn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-09, Micka=EBl Sala=FCn <mickael.salaun@ssi.gouv.fr> wrote:
> On 09/09/2019 12:12, James Morris wrote:
> > On Mon, 9 Sep 2019, Micka=EBl Sala=FCn wrote:
> >> As I said, O_MAYEXEC should be ignored if it is not supported by the
> >> kernel, which perfectly fit with the current open(2) flags behavior, a=
nd
> >> should also behave the same with openat2(2).
> >
> > The problem here is programs which are already using the value of
> > O_MAYEXEC, which will break.  Hence, openat2(2).
>=20
> Well, it still depends on the sysctl, which doesn't enforce anything by
> default, hence doesn't break existing behavior, and this unused flags
> could be fixed/removed or reported by sysadmins or distro developers.

Okay, but then this means that new programs which really want to enforce
O_MAYEXEC (and know that they really do want this feature) won't be able
to unless an admin has set the relevant sysctl. Not to mention that the
old-kernel fallback will not cover the "it's disabled by the sysctl"
case -- so the fallback handling would need to be:

    int fd =3D open("foo", O_MAYEXEC|O_RDONLY);
    if (!(fcntl(fd, F_GETFL) & O_MAYEXEC))
        fallback();
    if (!sysctl_feature_is_enabled)
        fallback();

However, there is still a race here -- if an administrator enables
O_MAYEXEC after the program gets the fd, then you still won't hit the
fallback (and you can't tell that O_MAYEXEC checks weren't done).

You could fix the issue with the sysctl by clearing O_MAYEXEC from
f_flags if the sysctl is disabled. You could also avoid some of the
problems with it being a global setting by making it a prctl(2) which
processes can opt-in to (though this has its own major problems).

Sorry, but I'm just really not a fan of this.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--no5u7udk75jfhvvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXZFTwAKCRCdlLljIbnQ
EtYQAP92uUzYfjG2cN2Nhj9vRhmas2XNnL0JbyC5U6zyFRSNVgEAwyjwWaK6kTQb
EJallcqZNlIhaATVDcNFHXkpq0QtTQ0=
=Hxqm
-----END PGP SIGNATURE-----

--no5u7udk75jfhvvn--
