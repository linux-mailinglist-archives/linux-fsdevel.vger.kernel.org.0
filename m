Return-Path: <linux-fsdevel+bounces-30310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B659893A1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 09:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE2EB23285
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89E013C9CB;
	Sun, 29 Sep 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na/tpird"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B29718641;
	Sun, 29 Sep 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727596711; cv=none; b=qIqCZ/PN4XEKrqW9/UGqcqIGa7PEurFvnID02LWwoymfvvLE8484xBWqwgSp0WI+BIKCO7oeSnn5WRWBOl3N33MxHgiUWT/GBy2klN85LP0wKROwdVO7h9nZlwtGL6jSaYQLeCJfzpcKMHq5vNiDGIh0E6codcJMo+ljFrJw0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727596711; c=relaxed/simple;
	bh=3xHAO/1nMaKipfHebjoHo1sKkeBUhtCQGPDbex00eno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjbaCv7mxKmViur6q41Bsvx/bzK9c7ndh8mALEAdn9mYYD0jV53iBpWBJH0+JzU3i7ydjn+/cRWSmoJ83Bdv2SElQbHa2AIqUcdEn5uiAEfz8ZK6uy5agQD9PlA4CvuY76qPtK3NIf9Ov2xwrDkKm7D5cq7yh/H10r3YsWON77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na/tpird; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4E7C4CEC5;
	Sun, 29 Sep 2024 07:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727596710;
	bh=3xHAO/1nMaKipfHebjoHo1sKkeBUhtCQGPDbex00eno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=na/tpird1bl9uvUKD9qDM4ARwhFA8PdpOm4dQQ7LxTWB/c33ja9fLlbqblYaKveqp
	 Dd1mL5wLQhBBHY5REMFl7wDVk2vg5in81Z/qrjqgroWrMr3iBR0QeIK9xo2g+fID1W
	 fZItj8cABW/yqR2e/9FCQSn2af9tg6wehIBneqHIGm7ROS54HNnV/IcC74/wYenXJj
	 tccFdIJcBXl3O9NWHn38NKksr88Yq2jp0vqBFnpjaGrdNMZbnTJOOK8iAiy+HshUZi
	 5744M39jfLtZQvSe3QV3UBHhc4ZP6RD/28eA0H8XD1lcVIHekhInDLtSvj5jVVewoi
	 1xkMVvPzd8Ktg==
Date: Sun, 29 Sep 2024 09:58:24 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	torvalds@linux-foundation.org, justinstitt@google.com, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
Message-ID: <xzhijtnrz57jxrqoumamxfs3vl7nrsu5qamcjcm4mgtdhruy5r@4az7dbngmfdn>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
 <202409281414.487BFDAB@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sc2ag33lzzfktmx5"
Content-Disposition: inline
In-Reply-To: <202409281414.487BFDAB@keescook>


--sc2ag33lzzfktmx5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	torvalds@linux-foundation.org, justinstitt@google.com, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
 <202409281414.487BFDAB@keescook>
MIME-Version: 1.0
In-Reply-To: <202409281414.487BFDAB@keescook>

[CC +=3D Andy, Gustavo]

On Sat, Sep 28, 2024 at 02:17:30PM GMT, Kees Cook wrote:
> > > diff --git a/mm/util.c b/mm/util.c
> > > index 983baf2bd675..4542d8a800d9 100644
> > > --- a/mm/util.c
> > > +++ b/mm/util.c
> > > @@ -62,8 +62,14 @@ char *kstrdup(const char *s, gfp_t gfp)
> > > =20
> > >  	len =3D strlen(s) + 1;
> > >  	buf =3D kmalloc_track_caller(len, gfp);
> > > -	if (buf)
> > > +	if (buf) {
> > >  		memcpy(buf, s, len);
> > > +		/* During memcpy(), the string might be updated to a new value,
> > > +		 * which could be longer than the string when strlen() is
> > > +		 * called. Therefore, we need to add a null termimator.
> > > +		 */
> > > +		buf[len - 1] =3D '\0';
> > > +	}
> >=20
> > I would compact the above to:
> >=20
> > 	len =3D strlen(s);
> > 	buf =3D kmalloc_track_caller(len + 1, gfp);
> > 	if (buf)
> > 		strcpy(mempcpy(buf, s, len), "");
> >=20
> > It allows _FORTIFY_SOURCE to track the copy of the NUL, and also uses
> > less screen.  It also has less moving parts.  (You'd need to write a
> > mempcpy() for the kernel, but that's as easy as the following:)
> >=20
> > 	#define mempcpy(d, s, n)  (memcpy(d, s, n) + n)
> >=20
> > In shadow utils, I did a global replacement of all buf[...] =3D '\0'; by
> > strcpy(..., "");.  It ends up being optimized by the compiler to the
> > same code (at least in the experiments I did).
>=20
> Just to repeat what's already been said: no, please, don't complicate
> this with yet more wrappers. And I really don't want to add more str/mem
> variants -- we're working really hard to _remove_ them. :P

Hi Kees,

I assume by "[no] more str/mem variants" you're referring to mempcpy(3).

mempcpy(3) is a libc function available in several systems (at least
glibc, musl, FreeBSD, and NetBSD).  It's not in POSIX nor in OpenBSD,
but it's relatively widely available.  Availability is probably
pointless to the kernel, but I mention it because it's not something
random I came up with, but rather something that several projects have
found useful.  I find it quite useful to copy the non-zero part of a
string.  See string_copying(7).
<https://www.man7.org/linux/man-pages/man7/string_copying.7.html>

Regarding "we're working really hard to remove them [mem/str wrappers]",
I think it's more like removing those that are prone to misuse, not just
blinly reducing the amount of wrappers.  Some of them are really useful.

I've done a randomized search of kernel code, and found several places
where mempcpy(3) would be useful for simplifying code:

=2E/drivers/staging/rtl8723bs/core/rtw_ap.c:		memcpy(pwps_ie, pwps_ie_src, =
wps_ielen + 2);
=2E/drivers/staging/rtl8723bs/core/rtw_ap.c-		pwps_ie +=3D (wps_ielen+2);

equivalent to:

	pwps_ie =3D mempcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);

=2E/drivers/staging/rtl8723bs/core/rtw_ap.c:		memcpy(supportRate + supportR=
ateNum, p + 2, ie_len);
=2E/drivers/staging/rtl8723bs/core/rtw_ap.c-		supportRateNum +=3D ie_len;

equivalent to:

	supportRateNum =3D mempcpy(supportRate + supportRateNum, p + 2, ie_len);

=2E/drivers/staging/rtl8723bs/core/rtw_ap.c:		memcpy(dst_ie, &tim_bitmap_le=
, 2);
=2E/drivers/staging/rtl8723bs/core/rtw_ap.c-		dst_ie +=3D 2;

equivalent to:

	dst_ie =3D mempcpy(dst_ie, &tim_bitmap_le, 2);


And there are many cases like this.  Using mempcpy(3) would make this
pattern less repetitive.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--sc2ag33lzzfktmx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmb5CJoACgkQnowa+77/
2zLfmw/9FsLN/M7ZkpM7L+8hpOThHHZDCRD40jrK8GQ9Ao1lmIKMASXMncuGw7Qn
BoGLg+9glMCF47rsNtrqU5iSAoXuXOhIbi6iJUxF6WbK/Y0h4un0vjBoBZuoINnP
fnGIPzVp2pNx70EaOw1Af3zUpXpbdzJYFpI++i7OJ4dnH8uQ5sbZMs2HioBKiWRT
arfK0OD+HhJHE7GRtZMMCPeq1JvaELpBPp2exwe6j29Js6cD0EX4T9cLf7zTzU2n
4enMj6OY04Hq78bmLv2Ej13DHYSrQCQdcbYu5auFN/dF3oq5AuB8XAk6L/gnuXdH
bxIsS3yRvZL3JRYRU/n9RJzzAlrUX7wFo1/EVQFQvw/tbhmizOL3UM4IW8AXTxX+
b4UuHBu+U3bGx1xCREqqWdq0Kl7CaGR2y8HipW5BXRa+58CaqZd3KPiyCvxsFxkN
mMHgXRagtAo/RAjPapyBy++yBNFAy1QiXs4C+WOyONP3x+AA0e+tZiNvZOgFSrHC
82An0a78d7f+1EXhpuE8X+LpVqwR7EFQVnPG1ox9B3B4380hphULOEa9HqstIvvt
WGCtOL6T/Jb7SVoYesDuu26eQFoiK4JmDJht/K/z7NEhJsop3qzKnEnKl81GeX4K
sNCQWo2X1SFnUZcxvQKNzGVMsOlNdjjTO4pOoSEFgurln1kI+BY=
=4tYC
-----END PGP SIGNATURE-----

--sc2ag33lzzfktmx5--

