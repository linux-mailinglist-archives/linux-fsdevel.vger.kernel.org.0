Return-Path: <linux-fsdevel+bounces-38393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A1A016B1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 21:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5BF1884E54
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF061D5178;
	Sat,  4 Jan 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJFDW1/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98A14D708;
	Sat,  4 Jan 2025 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736022223; cv=none; b=GD9MSoHbZntUPsvgywN+V9D4Z8H5aNha0KT3A0CeFW4hjiOYImw4mPtNKINQu/G48oplv29Ga6RYbpUh5h1/7vkfmrIIbu2wD9sQ5gNVH4xQFuarPZe4ZbtPTkz4Vnr1/VeTK5T8OOvkoOtc+dzEAxjGF9iB63dAHaaxMqnBaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736022223; c=relaxed/simple;
	bh=2mkeiyPcv8svYHcZBVyStAYreqemwHgqCRI51Z6+dz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cj3C+jYcNKYCf3nh3Ul/jwiZGjfJKlgvXwePRSi9bTmHpkZeCqWuUcunCE05Qy+bavrjIouJPD3X+nbnNKEcrENGMzzn5vRcr6CbJ7jQaG783PHG3GDOI960Xk4kSuUON9bH1OqPawf+RxSDF8WuiMLUifLU+c1ZbTIAYusT22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJFDW1/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CC2C4CED1;
	Sat,  4 Jan 2025 20:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736022222;
	bh=2mkeiyPcv8svYHcZBVyStAYreqemwHgqCRI51Z6+dz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJFDW1/Brk9elGGxiVs9ULgp7nccjE/VSwhU45heNlUwp7EWAHM0QHnG7SyqevYoW
	 /DLDiJvsNhb3cl3pIWm+AW0/3kVkOPTDysriqzFeCkAnHARrBIUOOJSSg8Hp9JCfux
	 nkuU9dMq3iN3xPFb5EFlRvvSEJHGNaT3ADa/vmzMNcPpO6UHRTUMy1j/8CXilOX6t3
	 sImWZ8nJhnk4PrYT0932y+JAQ+3lmhWuPHS3s2Tz1kDtYl6ZI1vHYxosA1fOGxjXrW
	 nleJJ6kbP8+cVyG6mkOyS/w43CsgyHNyaZildGEhRx8Br1itFyyMflX+NXCtDdUe6b
	 tuC2gWNbFKrAw==
Date: Sat, 4 Jan 2025 21:23:41 +0100
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, 
	ritesh.list@gmail.com
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
Message-ID: <spxtxdh6vmj4vqi5aw3pzywuqnursvp64dwm4giphm55h2glei@w3woe4lf7xij>
References: <20241203145359.2691972-1-john.g.garry@oracle.com>
 <20241204204553.j7e3nzcbkqzeikou@devuan>
 <430694cf-9e34-41d4-9839-9d11db8515fb@oracle.com>
 <20241205100210.vm6gmigeq3acuoen@devuan>
 <ba9bbcbd-a43e-465e-ba17-8982d8adf475@oracle.com>
 <20241216123853.g43jqafi7avnntpg@illithid>
 <20241216124749.nvve7b4q3r2wjud2@devuan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7mylfsyaxyizvew5"
Content-Disposition: inline
In-Reply-To: <20241216124749.nvve7b4q3r2wjud2@devuan>


--7mylfsyaxyizvew5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, 
	ritesh.list@gmail.com
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
References: <20241203145359.2691972-1-john.g.garry@oracle.com>
 <20241204204553.j7e3nzcbkqzeikou@devuan>
 <430694cf-9e34-41d4-9839-9d11db8515fb@oracle.com>
 <20241205100210.vm6gmigeq3acuoen@devuan>
 <ba9bbcbd-a43e-465e-ba17-8982d8adf475@oracle.com>
 <20241216123853.g43jqafi7avnntpg@illithid>
 <20241216124749.nvve7b4q3r2wjud2@devuan>
MIME-Version: 1.0
In-Reply-To: <20241216124749.nvve7b4q3r2wjud2@devuan>

Hi John,

On Mon, Dec 16, 2024 at 01:47:53PM +0100, Alejandro Colomar wrote:
> Hi Branden, John,
>=20
> On Mon, Dec 16, 2024 at 06:38:53AM -0600, G. Branden Robinson wrote:
> > Hi John,
> >=20
> > At 2024-12-16T10:35:42+0000, John Garry wrote:
> > > On 05/12/2024 10:02, Alejandro Colomar wrote:
> > > > On Thu, Dec 05, 2024 at 09:33:18AM +0000, John Garry wrote:
> > > > Nah, we can apply it already.  Just let me know if anything changes
> > > > before the release.
> > >=20
> > > I'd suggest that it is ok to merge this now, but Branden seems to have
> > > comments...
> >=20
> > I don't generally intend my review comments to be gating, and this is no
> > exception.  (I should try harder to state that explicitly more often.)
>=20
> Nah, I just forgot about this patch.  Thanks for the ping; I'll apply it
> later today (if I don't forget again).  :)

I did forget again.  :)

I have applied the patch now.  Thanks!
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3De2d3dadf562ac07d086a9732993cb79898bc6b17>


Cheers,
Alex

>=20
> Cheers,
> Alex
>=20
> > Please don't delay on my account.  :)
> >=20
> > Regards,
> > Branden
>=20
>=20
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--7mylfsyaxyizvew5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmd5mM0ACgkQnowa+77/
2zK8WxAAoYhFCLHZBbhf5+O8CT5QHkCM/FUjDCB0CxQl5nZQHlXxjciwAh5lai67
VqbB6ICbRbeG04wC9IZFSwENhN3BIbgs+1s8oVwytt2+JBCqzirPofdYWxROIuLC
ToJ6AGDqGjTCJvXttFAVbFCaVqrPTIcwTk/OoA27HK4sIiHwWvUnBTHiUd5NQKr8
SQ5unHXydBo7nVJl7bPBlU+SPFKxfDdP08IBLbGfk7M9dmh7Zm6dUhVUHoJQwJVL
2dHhE4esSmkjFQMA6QJHGqvnxgt/q0SBMzDsos58CU3GN/q9EQS8NWqTDrvLy7be
o/tPVOTma9P2wt7F9koO+5cQmlaRspCNSEkfkeeCNBCBz941sm/uEeVDCUOcZQ77
jQ/FOTC5LZrCVNZe0NcOE5XN37LPKoQisPeFGDMBzkaClDbBt6+CZrd3p9r9SqPB
ljW6USusbb9aHZw23pwaJ+BJLCqmojhyjYnTIyHRRvwK6Fmh3pFmQfRpq7xAb+G+
98NR7+EshUl3xLZ7fgvHqHK24uQxZ9Ii9uCvT+1TaUoHydvQs0edvnlPuuXw9G0+
vhXkDDcui3b/ChIywm9W38bjwogpIEw7nzZA70z6w6jvtT8aHBgDAjeDcvHvna2N
elPZwTeUthlylNZn3fRkP5t1JFOsCJJaLC0mWL51OLkWByAUu9M=
=12Ml
-----END PGP SIGNATURE-----

--7mylfsyaxyizvew5--

