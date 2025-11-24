Return-Path: <linux-fsdevel+bounces-69702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20316C81D93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 18:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4213D3A2F0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0C5D8F0;
	Mon, 24 Nov 2025 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqnasZs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E81E51E1;
	Mon, 24 Nov 2025 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004515; cv=none; b=K79ZX0CdLAMy8VIf0kqVWQ+ZAhX8qS9u4uA1AGjPl7lacS4XvwUFEQyNnlS87R8TAewiyyw5j1EFniRf5bWYNBR8L0V9uN40lxsFmSL8DeROCR0h+5lSZ9NZ3CNcc/9AuDbIdLPh7eUbdT5G2OtGfTy/dapIoAcMDFrRlE4dEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004515; c=relaxed/simple;
	bh=5fpneErPLD71fYDR7LijjjyhQO1wEZK6D5zE3eiieMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/pS8c5qfzVBzkgJE/0bHU19Im5sL6sISGZwoVLhy99hlBIRIVvpo2oWxX8WW1tLPJQdbpu7NEbxZ9w7jRF4M+KC65z2e+EIHzGnooLLThIFn5iqlRxQkvCRQOkqo1mwkUUiQKr7kKaNacPBhNAPULWE2ZRNyFlb3S2wS+cJaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqnasZs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C0EC116C6;
	Mon, 24 Nov 2025 17:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764004515;
	bh=5fpneErPLD71fYDR7LijjjyhQO1wEZK6D5zE3eiieMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqnasZs0y6yeXb0pKA4W2EgaGVK9TnzkU3F/ZTX4Tq2RFo2/xRDAdvVPYYRuG3Era
	 dJe/xsM34tThHGIjin0EAYfH+/1ntYBO4r8eO/5gWBHQEz7oqVX+Zhozl1xdnXFZCb
	 Ici//XFRRq+0LJrAcRQb6cmy8sjCbR6ZXJNccrrCQ1fgbBBdJAkA/9oZxYy7imIeAN
	 KnmF9dZJSRqnfZp1TD1UOmaRPKn41+R+K2t0zEzzybeUawYyBcQ3q4GIJ45JaHLWQP
	 sftIpCK4H6A6E9Eq0n9BJsMqiMaciLMaUSE1qJ/fcFylIDqVob+SMPVVwOXVgCvwXT
	 SuatZ7e7cNA2g==
Date: Mon, 24 Nov 2025 18:15:11 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH v2] man/man2/readv.2: Document RWF_DONTCACHE
Message-ID: <qwits4w3kxdfma3i4okx4der5dbko763fzaxf2hoq2u7qz5xl7@4hj2ab4mkmxw>
References: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>
 <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
 <aLZ-7TG2OvC5tazU@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="puoejbvzsopg34fp"
Content-Disposition: inline
In-Reply-To: <aLZ-7TG2OvC5tazU@infradead.org>


--puoejbvzsopg34fp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH v2] man/man2/readv.2: Document RWF_DONTCACHE
Message-ID: <qwits4w3kxdfma3i4okx4der5dbko763fzaxf2hoq2u7qz5xl7@4hj2ab4mkmxw>
References: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>
 <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
 <aLZ-7TG2OvC5tazU@infradead.org>
MIME-Version: 1.0
In-Reply-To: <aLZ-7TG2OvC5tazU@infradead.org>

On Mon, Sep 01, 2025 at 10:21:49PM -0700, Christoph Hellwig wrote:
> Looks good:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Hi Chirstoph,

Thanks!  For some reason, I accidentally pushed the patch without
appending the review tags.  :(


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--puoejbvzsopg34fp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkkkoUACgkQ64mZXMKQ
wqlE+Q//ZXKlKV1ZPqF9EWzwUPggDG4xnJZ8MvN42gk5Ov3fcKhD1xVc2b37VKY2
mIvBZy7SDDO6KmTmdZPuinr4oHPAZeA4w8p3CZyV6uCf3hJjJd46DsFIUPvVsz/F
uXwCpL6mFGI7uvXt6WjkNp7Hxu30HLdC2CFlaEI8cjA7o4ojhHu7lQUKwl8jwnGj
ZZenKg0vjBYEmQ6dJE6YvfeILG2pOIGqJhl4F1s3UsP7wwKjErG3VhtbYqZXRTP7
3HzRa0qsEYYfLwX44CECwYq+oDNiFIPsCOUGRgVz7HI1FEsmM4s07Qyoct12ACKI
quNp//GByssRygCHh0Brx/DIGZJ+v8frp9oJXsWh/el3qW0NdO5d4K1HuDe6Df7E
qo0Gt1EJgtbn+3fBKai2Fwcuq4JGCR9iS1awqhWm7lULibe8Z9ryx7a7+PyNl56/
tNHxKDVezTTytsihUUcJTrND/JIgEXTC+dufX4OfWW6GEAq3K3Btjt1V+cpd+JMe
80Sgea/fdgeLwzMjqzUyRWO65EGtLRwRHMaGzyapiqt78yoNyai1CYOdY/F5ox5n
qMDLEoDwXQ+24vFjrS852prlQlNowR+pyMOQjhtDG2p/Iq7tX7wdqdF4EZ189GPd
3qWRfN+j1e9ikbfHscaTLdz2yp9DDwwHbFM7zdm1jfTWedwsMnc=
=3Izx
-----END PGP SIGNATURE-----

--puoejbvzsopg34fp--

