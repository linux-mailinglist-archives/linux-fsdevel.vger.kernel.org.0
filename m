Return-Path: <linux-fsdevel+bounces-7606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB2F82858A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 12:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976791C23B30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 11:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751EC381CA;
	Tue,  9 Jan 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JAgmpAIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB037160;
	Tue,  9 Jan 2024 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704801374;
	bh=J2KyjqURSPA1gUY97Bi/m2UU1dp9Uu6ge1Ve3KIiJak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JAgmpAIsL5Anr72TOiGJDd239SEDEyOcxaUV8QXwyeO9iRWBkPhQE2x09bzyeQE+J
	 2sq8x6a+8bdUC8LLciI0X5/7E9UGga8jYs5GIFCoHSUokmY3zgLO22mbMEfWJom1Qg
	 1UvJa6aGatlxkFKTPsAdXPLxrOQ15fuSntPi9R9CkLGcFzkTENRxVbjZTsuyxE2a9d
	 s6vYmBQWTVHf11tuLOETnA13vkWDH9wWn0B7P+efuy8dmCLJs5B4DI0IvdbHGsIFPS
	 VlbR5TIWIvexMnNgIN5rVdULSIHO1VM3Ve+STn3XOjBchrXDoY6LOgFIhAPulCihQe
	 lkaIJdi+5iVBg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8Tsp1K8dz4wcd;
	Tue,  9 Jan 2024 22:56:14 +1100 (AEDT)
Date: Tue, 9 Jan 2024 22:56:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount api updates
Message-ID: <20240109225613.644a25f4@canb.auug.org.au>
In-Reply-To: <CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>
References: <20240105-vfs-mount-5e94596bd1d1@brauner>
	<CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hz/3hh4w=b8XsC4LmnbZTeO";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hz/3hh4w=b8XsC4LmnbZTeO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, 8 Jan 2024 17:02:48 -0800 Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
>=20
> How was this not noted in linux-next? Am I missing something?

I suspect I noticed this when the other syscall adding commits arrived
(in the security tree) and sent
https://lore.kernel.org/all/20231120143106.3f8faedd@canb.auug.org.au/
 - which gave a hint and would have hidden the error you got.  I also do
not do arm64 builds along the way and only at the end of my day.
--=20
Cheers,
Stephen Rothwell

--Sig_/hz/3hh4w=b8XsC4LmnbZTeO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWdNF0ACgkQAVBC80lX
0GwNigf8D0KGE59/GAr+9EuqVRawD5fDLvVJHMcHYhhshKpajHVjWgaw1Ix8EV4f
07mvGT97GYhqLDpAIS3cvBNfE4wzZ+OSEyuBmn40+sUu0ZhbvoraD8BCKzy9AW1d
LPKYTPRi6RZTY6IIeCTw8+VeEcPXfcgAgTc1N+m64MJeZRT2XcqeNKONqPBDH4vX
Qau/lTLG53TbBxlNm0yNK6L+Kh1/lLGENnzr2SOHHeTDghhY73OC6Yo2cpUUp+sH
xBzeIOlHMkBmWoHvQ6BFw6j5pgSj7BxKjNmn9GOVYcy/RAcSHcr1qJT/jLWZbwkD
nGGacwCCR56Vuy9pc/ay71DU7WLheg==
=otWA
-----END PGP SIGNATURE-----

--Sig_/hz/3hh4w=b8XsC4LmnbZTeO--

