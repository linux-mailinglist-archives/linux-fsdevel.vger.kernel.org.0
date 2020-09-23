Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C92276288
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 22:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgIWUwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 16:52:02 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33862 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWUwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:52:02 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2992C1C0BB6; Wed, 23 Sep 2020 22:51:57 +0200 (CEST)
Date:   Wed, 23 Sep 2020 22:51:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200923205156.GA12034@duo.ucw.cz>
References: <210d7cd762d5307c2aa1676705b392bd445f1baa>
 <20200922215326.4603-1-madvenka@linux.microsoft.com>
 <20200923084232.GB30279@amd>
 <34257bc9-173d-8ef9-0c97-fb6bd0f69ecb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <34257bc9-173d-8ef9-0c97-fb6bd0f69ecb@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Scenario 2
> >> ----------
> >>
> >> We know what code we need in advance. User trampolines are a good exam=
ple of
> >> this. It is possible to define such code statically with some help fro=
m the
> >> kernel.
> >>
> >> This RFC addresses (2). (1) needs a general purpose trusted code gener=
ator
> >> and is out of scope for this RFC.
> >=20
> > This is slightly less crazy talk than introduction talking about holes
> > in W^X. But it is very, very far from normal Unix system, where you
> > have selection of interpretters to run your malware on (sh, python,
> > awk, emacs, ...) and often you can even compile malware from sources.=
=20
> >=20
> > And as you noted, we don't have "a general purpose trusted code
> > generator" for our systems.
> >=20
> > I believe you should simply delete confusing "introduction" and
> > provide details of super-secure system where your patches would be
> > useful, instead.
>=20
> This RFC talks about converting dynamic code (which cannot be authenticat=
ed)
> to static code that can be authenticated using signature verification. Th=
at
> is the scope of this RFC.
>=20
> If I have not been clear before, by dynamic code, I mean machine code tha=
t is
> dynamic in nature. Scripts are beyond the scope of this RFC.
>=20
> Also, malware compiled from sources is not dynamic code. That is orthogon=
al
> to this RFC. If such malware has a valid signature that the kernel permit=
s its
> execution, we have a systemic problem.
>=20
> I am not saying that script authentication or compiled malware are not pr=
oblems.
> I am just saying that this RFC is not trying to solve all of the security=
 problems.
> It is trying to define one way to convert dynamic code to static code to =
address
> one class of problems.

Well, you don't have to solve all problems at once.

But solutions have to exist, and AFAIK in this case they don't. You
are armoring doors, but ignoring open windows.

Or very probably you are thinking about something different than
normal desktop distros (Debian 10). Because on my systems, I have
python, gdb and gcc...

It would be nice to specify what other pieces need to be present for
this to make sense -- because it makes no sense on Debian 10.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2u1bAAKCRAw5/Bqldv6
8ov1AJ9oh8sVA5W7qErLEsJzifoDuHM8DACgh6w28VCKvVj+dLDCdmUuI6zKsgc=
=0Viq
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
