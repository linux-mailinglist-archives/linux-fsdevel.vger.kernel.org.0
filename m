Return-Path: <linux-fsdevel+bounces-71696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF83CCE010
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 00:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E35302FA05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 23:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B8030AD1D;
	Thu, 18 Dec 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGhlHB8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4562D7DE9;
	Thu, 18 Dec 2025 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766101820; cv=none; b=LNz/7LkYJM+BfB0Wi76ndi7pT/qCtkBUZqBwj0BiGib1fvOfFmYMyVD0y2ngBW3O1je98lzdpuOabX3o+g3He8WIw5JX53JMLko5R7Y6sMdi3yScos+ZJf0uFSPR91QL+Z7uLqBLivZQqpzEJAj3Io0ofnYPs7G2fNdynuVF7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766101820; c=relaxed/simple;
	bh=TVA+9B1Nko+1t8FR0Py8aHGwvKA195Xcos+KzqHzQrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B17x15qyJz2KCPFs85n9w5Jt42VAhyDRmgeeFt3zklQqyNzP/WQNvPL8zamCRoRo4XaTZksNCYpauyrL6L9SIo286g9cx9Iw1JvtOzATIGpR4hDjXnNGb+En00qhQAZ2/ZYmpzXXKyWaDaGS60/27uZR8/Y3P1XFn1wulwN37/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGhlHB8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028CEC4CEFB;
	Thu, 18 Dec 2025 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766101819;
	bh=TVA+9B1Nko+1t8FR0Py8aHGwvKA195Xcos+KzqHzQrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGhlHB8UbaP7XIjiKFAi5J9sh4fsorNlaSaxyxKKf/8n//OIXjYeciE3x2e0XZMNK
	 V8Rt0sdD6yA72CdiMiHuhjE60WTAvm21gt4pNHMIJzRFcjRNZhXkziJuodRjDTobGP
	 KZGCSedZHyaappJxXzuVZiRAO07R6fvE8+6zAPz/QAuMNKjUEntL5rfZcjIf3x4NVt
	 nwJqgbzrabv6slne7gyO/yPXQCkWnAEFyno2t3nCOzLIqnB8FZsNVjTj24zr5xp3nP
	 DlJM/raRsUxjGUmk62rcYAB0C0gzlmwjvpJBPUZCAvjEvOxzV267HLYyHWPy+GhoNg
	 bZizDLKZlwnhw==
Date: Fri, 19 Dec 2025 00:50:15 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Alyssa Ross <hi@alyssa.is>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-man@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] man/man2/statmount.2: document flags argument
Message-ID: <lphsqrquupbreqi2jl7nddryhuj6p3gmrdujihnxmr4z2f5lgz@spr4mq5dek6e>
References: <20251218230517.244704-1-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5q2lvqctxhlxiirg"
Content-Disposition: inline
In-Reply-To: <20251218230517.244704-1-hi@alyssa.is>


--5q2lvqctxhlxiirg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Alyssa Ross <hi@alyssa.is>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-man@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] man/man2/statmount.2: document flags argument
Message-ID: <lphsqrquupbreqi2jl7nddryhuj6p3gmrdujihnxmr4z2f5lgz@spr4mq5dek6e>
References: <20251218230517.244704-1-hi@alyssa.is>
MIME-Version: 1.0
In-Reply-To: <20251218230517.244704-1-hi@alyssa.is>

Hi Alyssa,

On Fri, Dec 19, 2025 at 12:05:17AM +0100, Alyssa Ross wrote:
> Reading the man page for the first time, I assumed the lack of
> mentioned flags meant that there weren't any, but I had to check the
> kernel source to be sure.  Sure enough:
>=20
> 	if (flags)
> 		return -EINVAL;
>=20
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Thanks!  Patch applied.


Have a lovely night!
Alex

> ---
>  man/man2/statmount.2 | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
> index 8a83d5e34..cdc96da92 100644
> --- a/man/man2/statmount.2
> +++ b/man/man2/statmount.2
> @@ -68,6 +68,8 @@ The returned buffer is a
>  which is of size
>  .I bufsize
>  with the fields filled in as described below.
> +.I flags
> +must be 0.
>  .P
>  (Note that reserved space and padding is omitted.)
>  .SS The mnt_id_req structure
>=20
> base-commit: a5342ef55f0a96790bf279a98c9d2a30b19fc9eb
> --=20
> 2.51.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--5q2lvqctxhlxiirg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmlEkzcACgkQ64mZXMKQ
wqmcMA/7B/Or2/oR4Zk7f9HH0RFOl7yCsv+z5RM6FbyaZUm8fwcoI3YgnM7pCMLm
KHjMgFSEGFvZFnlKT3m8B1SKYD6aHEu/KAjFSQCjED0SINsnTs+EKAWCmx6GewV0
DxpXRX7GMaGO30z8/M95uYfvt/PqVHczYXbzeCdcJ9Uhynxb4oeLA6ZjmQ19qQy0
tlxl1LATJySjYeOvusaRA8tu/6h5tlc3CXaEnSJGM9GJ4mK1UY+y7j2hLmHMmY8h
PJLTA2cNVjP0v62dDGytYFBuvJcwbDdn9jJ+JfNbTCJNJ51wm9kjJLSye2NK/wni
PUnN5jenHvK+5IO5Ox6ZNm7TuW8m89BzK/3vT8LGRCV8PydCac6dmobZ2O68X9wh
7Q6sHa+YAnN5mroiEhIX5dA53T4jz2MNecnX0mSMmFqYJ2U251myEWtFr0l7Vc0O
qYwuVpOjRkv043+37oVENrfzHruFt00RsSenQ2RFi1CKkPIW8uW9FEYCKUas1ktw
Kel/J5z1o03Zoc9dhp/piQesb7yVPQIkPme0d2mUaxYNpa59rbFz2xas/HEFbRCj
6IAq/ONrTzm8wT+AiWBgS69hQxfOR6NONqemJLXB8uUvHnQPxLgtu6iJgwA57W8R
x5Me9qKRHPeQ1cX3jHS9gIz/C+h0UFeecMSyEyI+ypSeOrc8OVg=
=LLN/
-----END PGP SIGNATURE-----

--5q2lvqctxhlxiirg--

