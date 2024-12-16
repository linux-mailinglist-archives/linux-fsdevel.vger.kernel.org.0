Return-Path: <linux-fsdevel+bounces-37487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA4D9F30D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 13:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F5218867C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2727F204C3A;
	Mon, 16 Dec 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVkt5FA4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83734381B9;
	Mon, 16 Dec 2024 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353273; cv=none; b=Lu6UGa61EY75Hp8aFn15vGgD0TmzLnufjC3D3Fe/46hF9fePkct15Tt7F3e9s97ywNEIwwV5D7+GhgiR/dU0/1xldBR/sY87VaLNvZqiQkWrAD4pLTJKqOe/Y5pH8F+FpyR85lukZi6it4HKcmF4ebox415zNvZCr/t3extDuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353273; c=relaxed/simple;
	bh=+dkja2gk76NlzuPJ+81Q1pBvJyzK4Ay2zqIp/1+uqqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee8esLbLPZOTnsarJkWfQfxgpM653JmjylbjeIfJDJEVP8JwMzK1bpjajX2wWpCcVC5hSshIgOtu5XTypbAxDwlcUgJ2ZzQmnIIUOVT6Ck2lx5k5Y7D6l5p4oiMq3CoHZQjjt4AYAnozaoQWlTEAgmXhAgN8cjyrtSThI0LVzAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVkt5FA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4185C4CED0;
	Mon, 16 Dec 2024 12:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734353273;
	bh=+dkja2gk76NlzuPJ+81Q1pBvJyzK4Ay2zqIp/1+uqqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVkt5FA4ur0+4MXie0JrYvbbXvl8MnHJ8FDuG9l5LGryEtSwmJ67cUFdSOiAkquKo
	 cD76DNV+IABRhRqrd7V49x8sSQsVlof4FqzBGlZ6Q6kNjTuTDBl2aXBQ0N/b+o9JS/
	 YupX9reeHCwIXk/neaAQSCvZFeK0pe5zYfBbaZBRezKraqAM6HASPeu8rNFVazh1kN
	 XCIDA261rZPdm+0f1IuXn8Da+3Cp0xqoB8htpyWJ01HXOLh8oTEJFfGbi9YOlvMuyN
	 w+16VnDJSbwliF1QC0IH5nV6pXYNpbNdKlxPJZLllQv9ZJ93VSUHmWwIHJ07F4/mMm
	 L62ZBfmrm8CEQ==
Date: Mon, 16 Dec 2024 13:47:49 +0100
From: Alejandro Colomar <alx@kernel.org>
To: "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	ritesh.list@gmail.com
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
Message-ID: <20241216124749.nvve7b4q3r2wjud2@devuan>
References: <20241203145359.2691972-1-john.g.garry@oracle.com>
 <20241204204553.j7e3nzcbkqzeikou@devuan>
 <430694cf-9e34-41d4-9839-9d11db8515fb@oracle.com>
 <20241205100210.vm6gmigeq3acuoen@devuan>
 <ba9bbcbd-a43e-465e-ba17-8982d8adf475@oracle.com>
 <20241216123853.g43jqafi7avnntpg@illithid>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lyg3yhz2y7mj7n7v"
Content-Disposition: inline
In-Reply-To: <20241216123853.g43jqafi7avnntpg@illithid>


--lyg3yhz2y7mj7n7v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
MIME-Version: 1.0

Hi Branden, John,

On Mon, Dec 16, 2024 at 06:38:53AM -0600, G. Branden Robinson wrote:
> Hi John,
>=20
> At 2024-12-16T10:35:42+0000, John Garry wrote:
> > On 05/12/2024 10:02, Alejandro Colomar wrote:
> > > On Thu, Dec 05, 2024 at 09:33:18AM +0000, John Garry wrote:
> > > Nah, we can apply it already.  Just let me know if anything changes
> > > before the release.
> >=20
> > I'd suggest that it is ok to merge this now, but Branden seems to have
> > comments...
>=20
> I don't generally intend my review comments to be gating, and this is no
> exception.  (I should try harder to state that explicitly more often.)

Nah, I just forgot about this patch.  Thanks for the ping; I'll apply it
later today (if I don't forget again).  :)

Cheers,
Alex

> Please don't delay on my account.  :)
>=20
> Regards,
> Branden



--=20
<https://www.alejandro-colomar.es/>

--lyg3yhz2y7mj7n7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdgIXUACgkQnowa+77/
2zKODg/+Jo4NV06VbX2Bp0DyL8X/uXFjlaCB4Ut+vFZsKLjlXNP1dMnPn0NQ+7+L
O61qUSXDDl2+LRhPro0uBJdXWQlQ/P5BcIS8IARIeTgvmPC3JrXWoq0Y3zUOvnPH
snZccBsqAiLo8m1zEN3efEfT+EGvywytdQCc50Eoo28/J5g0e+//es5SLYhwEOPI
8hKXBWapXKvoEdXPy8qdCJGH/sGKwAOfUGAgWBSdceVdV475YpbChrumhoaZODOz
xp3JS3/yCUStK9/BxKf8zQI+l/6kfdoP/Vici3GLokmENb0gt7BmaOfPSzoBDWeW
UUO5B2IslwcVABM+K5VP0FU2brc+peqN2qt8PTnXcteATRuL75rLjv6WCBT1Q7yz
NoXGQI862/w0KXKFYyYzDQRWf0jHSZr7hgFUEMVRKvyN8g6i0v9QyK/ogUL4fJtS
FrQwCNsP9BGp3rrVa0z/zO73hZFqN3+3RewxRTiPdRDZ3QjxEZdIXKOU7RG0OD/5
D5Gy6+8FS9iZScPew03QfejJdAeCL/pK7Vc9n79Pf87pZs1n5jw8pFZmkbAi4x8V
xacGZS1ordLgRDFfBTtGe407BYVaSebJqykneImEftX4uESJNWcFHtorECznj7yp
IqkGd7pLRH6+Shv81KJvMoGgaL+b3Ki3Sd8EdwRWNHwBro6UGDQ=
=13Dj
-----END PGP SIGNATURE-----

--lyg3yhz2y7mj7n7v--

