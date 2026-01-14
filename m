Return-Path: <linux-fsdevel+bounces-73799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94200D20C0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3375302E3FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1931335573;
	Wed, 14 Jan 2026 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRDvxWRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6DE335078;
	Wed, 14 Jan 2026 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414752; cv=none; b=MixrW2hpsM/evOfHihibW4Zy3ORNvjY6rcB/U8rXmeCFFZ2dhO/QK87nmehy3/I21HtxLa6PcpLQTik+rgfEtivRgSzK/PSTDBptNyT7LpnBghwaEkPhrKj6IrMAzwFI6RyGdKXyPMkPD49zEbLfJ9oQ/1IbiFQ0nwGXIw45RLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414752; c=relaxed/simple;
	bh=SNwKlTj1KUcDg443k2u2DvKNCx4bcMWiBS92RLLjjMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5LNYrjrwQuwtNAoWUz+HaCxF6hVsQRz0D2VIZuFu9FG1LxC7bbfBi+FCOHfqxjfb+cdtRHWflYzkHXFQ/70ruVQBjEeONRZPPdowezz9KUi1ysRxXnYQIK0laKL7Yc4dGoIqomGy9U1EtPyWdYdPHpN+NbZ2N5d3YJqe3Z+A9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRDvxWRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD56C19421;
	Wed, 14 Jan 2026 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768414751;
	bh=SNwKlTj1KUcDg443k2u2DvKNCx4bcMWiBS92RLLjjMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRDvxWRTuVepHxgjIAi5mUJizCUZE72ncdLbI7YrOxH8WvDh6YGvAjlsv3jET0Ic1
	 pBOH06CwE37qD2j1iu7cVW/5gqVmJDi7pVdY4cfoHXAB8D1/z8nEazqJxA/WEQSUGS
	 xiEWB+la1yHjDRRUbH9hS+szdCJ/mxVoPYEJqlD0symHeJHF14k+/MOjpG1of7soAo
	 A8UaW+DnVNJczn8NF6K4PnsK2z1+BY7VA7KwEF2esbKNbwFMLtUtNOlgdbUUrrXBgS
	 1cy+AdRyC3EltdCd6dcyldTZ8gQdVEFOZEe6qqwsil4uFbJqvmvOyQdLpjfFUcFDGh
	 odMTKO9I2NqVg==
Date: Wed, 14 Jan 2026 19:19:08 +0100
From: Alejandro Colomar <alx@kernel.org>
To: "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 1/2] man/man2const: document the new
 F_SETDELEG and F_GETDELEG constants
Message-ID: <aWfdwopXGgBP4x5w@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <20260114-master-v2-1-719f5b47dfe2@kernel.org>
 <20260114175048.krre2hmydplaluty@illithid>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jbkc6gbcwupehkrs"
Content-Disposition: inline
In-Reply-To: <20260114175048.krre2hmydplaluty@illithid>


--jbkc6gbcwupehkrs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 1/2] man/man2const: document the new
 F_SETDELEG and F_GETDELEG constants
Message-ID: <aWfdwopXGgBP4x5w@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <20260114-master-v2-1-719f5b47dfe2@kernel.org>
 <20260114175048.krre2hmydplaluty@illithid>
MIME-Version: 1.0
In-Reply-To: <20260114175048.krre2hmydplaluty@illithid>

Hi Branden, Jeff,

On Wed, Jan 14, 2026 at 11:50:48AM -0600, G. Branden Robinson wrote:
> Hi Jeff,
>=20
> The following observation is not a blocker.
>=20
> At 2026-01-14T12:35:24-0500, Jeff Layton wrote:
> [...]
> > +.P
> > +A file delegation is a mechanism whereby
> > +the process holding the delegation (the "delegation holder")
> > +is notified (via delivery of a signal)
> > +when a process (the "delegation breaker") tries to
>=20
> I recommend use of typographer's quotes marks in prose (contrast code).
>=20
> groff_man_style(7):
>      \[lq]
>      \[rq]  Left and right double quotation marks.  Use these for paired
>             directional double quotes, =E2=80=9Clike this=E2=80=9D.

I don't have a strong opinion in either way.  However, I'd say I should
do a global pass before asking contributors to do this in new code.

For now, I'll take the patch with the '"'.

Thanks!


Have a lovely night!
Alex

> These look better in typeset output (like PDF) and on UTF-8 terminals,
> and avoid collisions with `"` when searching man(7) documents in source
> and, on the aforemented devices, as rendered too.
>=20
> Regards,
> Branden



--=20
<https://www.alejandro-colomar.es>

--jbkc6gbcwupehkrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmln3hwACgkQ64mZXMKQ
wqmB+A/7BbQHofay6dRua9KUVDl56LH4jYOJjsl2qkAADiI1ZQ1xX4dAJGAP5qxi
MOEZ6jlExUybgeZS4agqgRT2W01R45p1iU9GxQCrDuKryknOJmjTMoDUHKzGid+8
yuxOBhK4gthtSqoQtPriliuVXWlETjQJzmOjdtyiivA7oSLErqwZolapVFK5HKCb
m9v+rQMPMzJ8nRy1sdbCTGGECf/kgyC0GUgKZQlAspW9JTAvykxSVbIMIu3O+f+F
MkieoWmW2GKOj26F4irXy58oKqMIpLb7RPe9kfdvAySp9SQDwA7W+gKBS0Cba3bM
WagcsDJBx8F3Gs1yGL2p1+22AVBH1VjEEbPPPUb4310Gzlmyc5djwxkIe0HRXUCJ
/zHRe4RPJkxoYFfCBHBCfeKvmFSlOsKW9mqRH7kBM9s5fNtQ015dBeMNmw0PZXwZ
tRlir+v3ExqvMysPe0YP368H/VL28zvSxEm8Fsq7lsPxRsQlNOekGfuvlFvfqM8j
TGDAjQHCCYnsf7nDR8Z2Nn6+JqPKvMp2OvYwwDd7wYLx+5Qa57NHUY0rlScaIq8R
rJrOrWJxM3FPlVViyy+ArfOpqmqhR3VzO9VuM1cpX5wyZDeaPLeUwo2+7QEItVEy
114vU99A1xYCSOZ6bGvFyziK9eRrJOBTmeoQc/OAgzPz+W4JAhA=
=H8xM
-----END PGP SIGNATURE-----

--jbkc6gbcwupehkrs--

