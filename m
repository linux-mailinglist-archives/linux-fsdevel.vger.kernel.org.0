Return-Path: <linux-fsdevel+bounces-24672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53EA942BD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 12:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA5FB20E62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0DC1AC430;
	Wed, 31 Jul 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAXTrcN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDC1AAE3D;
	Wed, 31 Jul 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421237; cv=none; b=UhPlfUDF9MMIamRyuS7VZvDVo5rkom+GLmUwLCfLUfT2Fk52ycf4DWdzrZ5oOJeg6HCAqrADAiMHElAKXdMQUNYJ4n46EE4VrRQu31zH1VZI3nhhU3czalvxtdUNHhaCeu2aqSZCr1ZoE7WNRLLHcGm5cKumQS2/9h50pcNwfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421237; c=relaxed/simple;
	bh=grMArfYO8CSfM/P+90j415AKQ/GQfZeA47Ulr1FUtNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3eZFzWt0JZzy1uhwBm88pcehDl1q+XR0DDxVszwL9WPbo5mdo1i6qFgmYx14elKs7AILkBgXCgRHEO0518dcsjpE2845kQQCTkenn68sN5U/0iTmZnSVWvTf4OZqOn+9mopJN6GNAk/5pXMrnETRRL8dcBmGUJtKyPCeIUwrds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAXTrcN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28325C4AF15;
	Wed, 31 Jul 2024 10:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722421236;
	bh=grMArfYO8CSfM/P+90j415AKQ/GQfZeA47Ulr1FUtNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAXTrcN7fwkGLNoMwdmPOj9eb7lfBZ5xwWAAwyr/kGPtjVPGCa6MWY4J9ICI0W4Et
	 0/5H2em4nBk80ZMyc6Mu3HUnhtZ96lSxqROScZVOWd4V6s9NlxQAOo3x1q7wUl1J6/
	 bA0WTMa5bEIMcpX/8gj3Aa/p2h1rEZDHecoQyifcdidJsJkN28Wdc99ahyOoqGdx6x
	 YgjXYZxBC84iA6Rd5XMPGoht8FLDrvOWyyB3DGPRIZkEK4LktMh5cfR8DoC/3GqFXV
	 elDUmMe+WoT/DN9SkVdlHd8sZbFpSSnbPbnHDVpdeAzqMuXQJcra4o4JeEJo2VBkBl
	 j8rE0AKiYtPvw==
Date: Wed, 31 Jul 2024 12:20:33 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 0/3] man2: Document RWF_ATOMIC
Message-ID: <dp5zbkeyj5yevce5djgmxvs7dk7dqarunz3x4csdifye7hxlka@3mmo6bpicm3v>
References: <20240722095723.597846-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vvjo6s7xhaqvkb2"
Content-Disposition: inline
In-Reply-To: <20240722095723.597846-1-john.g.garry@oracle.com>


--2vvjo6s7xhaqvkb2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 0/3] man2: Document RWF_ATOMIC
References: <20240722095723.597846-1-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20240722095723.597846-1-john.g.garry@oracle.com>

Hi John, Darrick,

On Mon, Jul 22, 2024 at 09:57:20AM GMT, John Garry wrote:
> Document RWF_ATOMIC flag for pwritev2().
>=20
> RWF_ATOMIC is used for enabling torn-write protection.
>=20
> We use RWF_ATOMIC as this is legacy name for similar feature proposed in
> the past.
>=20
> Kernel support has now been merged into Linus' tree, to be released in
> v6.11
>=20
> Differences to v4:
> - Add RB tags from Darrick (thanks)
> - Revise description for readv.2 (Darrick)
> - Re-order RWF_ATOMIC in readv.2
>=20
> Differences to v3:
> - Formatting changes (Alex)
>  - semantic newlines
>  - Add missing .TP in statx
>  - Combine description of atomic write unit min and max
>  - misc others
>=20
> Himanshu Madhani (2):
>   statx.2: Document STATX_WRITE_ATOMIC
>   readv.2: Document RWF_ATOMIC flag
>=20
> John Garry (1):
>   io_submit.2: Document RWF_ATOMIC

I've applied the 3 patches, with Darrick's RB extra tag, and some
formatting fixes from myself.  Thanks for the patches!

Have a lovely day!
Alex

>=20
>  man/man2/io_submit.2 | 19 ++++++++++++++
>  man/man2/readv.2     | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  man/man2/statx.2     | 27 ++++++++++++++++++++
>  3 files changed, 107 insertions(+)
>=20
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--2vvjo6s7xhaqvkb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaqD/AACgkQnowa+77/
2zJtIA//cNlXwGg3ul8+pJp+ZiEeAMqc/4xk8KLZ3+a1VXSiEOOWo6N6wDaxXIZs
g17OePGCnQG8RxAarhngK0pzZIkkQSx31GEAlnQTVIqja2b4by/YHaR7V167nVem
YvOcNKJL3ruwQmKpUgYuHMJi0py+BPYEQSdmARE9PEEdWoXQu2xY271Y5IWYarzf
mcDimUqhsjMYmyzQmWM7ikiGCWyZdVkg5XCaMxiaXw015q2IB9jHL6HF7Ym/ZtKU
wBa+pxTrMLqVXWWeA/zPij5UFAfqeigXlreBFE+hsvFD28GYEMv+DETf5OmoW7mK
Bm/1pjWNXHO4z/5NoYrVJ2GXg3w1fzK2AVv7BbwrwJCkpPxvAvbw9PPLxzHGMRIr
Hhf9Drdpn29p0J3EXvJMpYPfUs0RKhmgwteYe/FHI2ZpqwNPJlCigxzLsAdpUJFi
E9fbZMjyKAB4CpwubT6TJLaV0Uk7VxBHJHUZcPQuSH8y+OEnnH2cKEIvy62eg0Jf
nBwKLQTHgVnCAQZQx7Jl2MZPBdqLC2Znmdnp5kN8UmBafs/HQKKHCSM9WMSkOPEZ
FSfJho3monlINawWUpTMwKyjUYx2RgZfKSgmSi0JSuTJBOA6NncWVq/IGWJ7WMqU
VM5XliAnkoY9XWPy13voUTrnO7xFntrjnTnr1Odb3h3+ArEQtms=
=T+5+
-----END PGP SIGNATURE-----

--2vvjo6s7xhaqvkb2--

