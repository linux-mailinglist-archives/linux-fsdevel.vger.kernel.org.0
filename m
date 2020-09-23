Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A1627537D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIWImf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 04:42:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45778 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIWImf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:42:35 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 59AD61C0BB1; Wed, 23 Sep 2020 10:42:33 +0200 (CEST)
Date:   Wed, 23 Sep 2020 10:42:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     madvenka@linux.microsoft.com
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200923084232.GB30279@amd>
References: <210d7cd762d5307c2aa1676705b392bd445f1baa>
 <20200922215326.4603-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <20200922215326.4603-1-madvenka@linux.microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Solution proposed in this RFC
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>=20
> >From this RFC's perspective, there are two scenarios for dynamic code:
>=20
> Scenario 1
> ----------
>=20
> We know what code we need only at runtime. For instance, JIT code generat=
ed
> for frequently executed Java methods. Only at runtime do we know what
> methods need to be JIT compiled. Such code cannot be statically defined. =
It
> has to be generated at runtime.
>=20
> Scenario 2
> ----------
>=20
> We know what code we need in advance. User trampolines are a good example=
 of
> this. It is possible to define such code statically with some help from t=
he
> kernel.
>=20
> This RFC addresses (2). (1) needs a general purpose trusted code generator
> and is out of scope for this RFC.

This is slightly less crazy talk than introduction talking about holes
in W^X. But it is very, very far from normal Unix system, where you
have selection of interpretters to run your malware on (sh, python,
awk, emacs, ...) and often you can even compile malware from sources.=20

And as you noted, we don't have "a general purpose trusted code
generator" for our systems.

I believe you should simply delete confusing "introduction" and
provide details of super-secure system where your patches would be
useful, instead.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9rCngACgkQMOfwapXb+vKeqgCgpVQMutlRE7F/wzcDjcBTlXwI
RbAAnjRDzunOtf0iSPKO6rIM9FPy6+JQ
=wVZX
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
