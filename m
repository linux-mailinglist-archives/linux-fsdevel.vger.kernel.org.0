Return-Path: <linux-fsdevel+bounces-1511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A827DAEC8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 23:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A521C208A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D17D12E5D;
	Sun, 29 Oct 2023 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EsX/3KWw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE57107AE
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 22:20:13 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C2B6;
	Sun, 29 Oct 2023 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1698618010;
	bh=BlLtvAP+MVVwR8wWxsfss4snd8c4GzSkTp0hPRbTWUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EsX/3KWwrncA6Nw6IaOA0C7YrDpDF3kM9bYomzwkv/w01dQlRYXOfj4pDnlSM//Xm
	 yS2RIqpYoChK6/RtdwZ1il+poahh3+fOFG2IE8mjfh6Ebvm+VonlMFz4gTyOWCzmVU
	 XpE/t2f7D6UNVtghNY7eFBUqt5yxmV8HCdcLEYM4BtUoxvJn+jcV8w34JuC84HLeK4
	 ElAv1CgZnPrn7SOXrcqPbS1RussQOmKJLBsflyit9T602w1Xs8JlPNuO91eVVYDEsV
	 mZgWTo81pHuwKVeo4tL9atTx/prZrbhAeMqxWRMOGotNCAyFQ/XHR8Z8opePboxBox
	 P3fSjxbukjv6A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJW6y4Yxrz4wnt;
	Mon, 30 Oct 2023 09:20:10 +1100 (AEDT)
Date: Mon, 30 Oct 2023 09:20:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL for v6.7] vfs super updates
Message-ID: <20231030092009.0880e5f3@canb.auug.org.au>
In-Reply-To: <20231027-vfs-super-aa4b9ecfd803@brauner>
References: <20231027-vfs-super-aa4b9ecfd803@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3YX7TPhXJEhErcOOAR0.W+M";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3YX7TPhXJEhErcOOAR0.W+M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Sat, 28 Oct 2023 16:02:33 +0200 Christian Brauner <brauner@kernel.org> w=
rote:
>
> The vfs.super tree originally contained a good chunk of the btrfs tree
> as a merge - as mentioned elsewhere - since we had intended to depend on
> work that Christoph did a few months ago. We had allowed btrfs to carry
> the patches themselves.
>=20
> But it since became clear that btrfs/for-next likely does not contain
> any of the patches there's zero reason for the original merge. So the
> merge is dropped. It's not great because it's a late change but it's
> better than bringing in a completely pointless merge.

Can you please update what you are including in linux-next to match
what you are asking Linus to merge.

--=20
Cheers,
Stephen Rothwell

--Sig_/3YX7TPhXJEhErcOOAR0.W+M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU+2pkACgkQAVBC80lX
0Gw9gwf8CC7/E0jJvFFSboQindi0UnvULAUNq7DtKhDRuDjTziENYj7yXweP4mRh
DTNQG/gThoiu6mVD7ZU6ysSG+fKyxF7gAECFD2brddtD2RIAc1SmRxmKOaDVHNeG
I/y1BE0IP0uRLHYM4XcWVnlwr9gBUGH/SJys/0TXA9ZcCkhvEa20gUcUUUVCch4g
qNPz8CjMrbIyFMoc6ntoivizpAzOGHqShXUGRnrntHZOQf8wiveF+/lLbPyI9ORS
vd3FI4DG3B7k+nZC3zd0JfC5pryNgVgMqz4cXAmlm8n+2I1m0vS9XGXHXdXiOvb1
oVeNVn1HDfBxUqkl8izBa6QtpXCD5Q==
=9U36
-----END PGP SIGNATURE-----

--Sig_/3YX7TPhXJEhErcOOAR0.W+M--

