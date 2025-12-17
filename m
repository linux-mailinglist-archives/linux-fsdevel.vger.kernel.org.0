Return-Path: <linux-fsdevel+bounces-71539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12929CC68BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD5353017F1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878724C692;
	Wed, 17 Dec 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY2mmZ7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE531A577;
	Wed, 17 Dec 2025 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765959869; cv=none; b=RClbaS8no4v5TLNUY7k0CL+X+zkSCwT3doTpdAeu7WO2vWWcE43mFWUmfYGwazriw5gMzytv8YZthRPn+5Ny9TDFqBnN6o8+K5DJJTUXxMc2Bu8kh8UFlZ0lfkz71f8o+wyusnj9Ub5iQ8TDR+lijOc3HWIQpSMpGTRkUe0k6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765959869; c=relaxed/simple;
	bh=UjSWNokrPiRmBOkhIvTV/KHSorM1SUJh+TEB6/v6vRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l00wUNK0KGzcg+pz7WXjkRaJaemf+ZeofvUqMiOmmCTHingsL+AA9HY7SVIb534K4OcQhxXgs1M9JwSiIi/X6sO54l4YZt7RBG4TRzGqRKX2R94ZBwVL2WPMGUKFzPSb8hBTC8CuTBXYQWhicGFC6HmLzBaVDXVeXPztqi2b3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY2mmZ7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA48C4CEF5;
	Wed, 17 Dec 2025 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765959869;
	bh=UjSWNokrPiRmBOkhIvTV/KHSorM1SUJh+TEB6/v6vRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NY2mmZ7dr8921oUBzFol7SfsL2Ar8PZaWprX37uUjyHBQdgKakLrw3CoewgC8J+F8
	 9t8kV/nTXgvBz17L63LyQ7kiVbJHEEtR01WVFT7LPGmXbcKjPFG5HGwcuzzHopfzn7
	 Qp/XlwTzXfXMIuyhe79FbDks4VDZt8njzTFl8jwYregGYeIVoX/quKdJoM1cq9GSn4
	 g9MNF5XOYvgsCB/R8iwUX9htn3UUC/dp2ubnUUIUFJcArj3iBaMW2mzABTv0Q+Sdg6
	 oQfvdiGXScIj4rFqtzDrsqIMIRnuhp62mWqjbqoLZUogSPzz+Kg4H2p7tvRyyqT5OL
	 4gG6dqjAC8n3A==
Date: Wed, 17 Dec 2025 09:24:22 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] sysctl: Add missing kernel-doc for proc_dointvec_conv
Message-ID: <rzpzqzt5isug3q3owhbzufgezizv2t532zujk3gpbywpjflwlf@jj4okt23acje>
References: <20251215-jag-sysctl-doc-v1-1-2099a2dcd894@kernel.org>
 <202512160038.2C7DAA20@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="32qhfetqupl7qy6o"
Content-Disposition: inline
In-Reply-To: <202512160038.2C7DAA20@keescook>


--32qhfetqupl7qy6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 12:40:15AM -0800, Kees Cook wrote:
> On Mon, Dec 15, 2025 at 04:52:58PM +0100, Joel Granados wrote:
> > Add kernel-doc documentation for the proc_dointvec_conv function to
> > describe its parameters and return value.
> >=20
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> >  kernel/sysctl.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 2cd767b9680eb696efeae06f436548777b1b6844..b589f50d62854985c4c0632=
32c95bd7590434738 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -862,6 +862,22 @@ int proc_doulongvec_minmax(const struct ctl_table =
*table, int dir,
> >  	return proc_doulongvec_minmax_conv(table, dir, buffer, lenp, ppos, 1l=
, 1l);
> >  }
> > =20
> > +/**
> > + * proc_dointvec_conv - read a vector of ints with a custom converter
> > + * @table: the sysctl table
> > + * @dir: %TRUE if this is a write to the sysctl file
> > + * @buffer: the user buffer
> > + * @lenp: the size of the user buffer
> > + * @ppos: file position
> > + * @conv: Custom converter call back
> > + *
> > + * Reads/writes up to table->maxlen/sizeof(unsigned int) unsigned inte=
ger
> > + * values from/to the user buffer, treated as an ASCII string. Negative
> > + * strings are not allowed.
> > + *
> > + * Returns 0 on success
>=20
> I think kern-doc expects "Returns:" rather than "Returns". But
They are all like this. Forwarding to linux-doc in case someone wants to
modify all the "Returns" to "Returns:".

Best

> otherwise, yes! :)
>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
>=20
> -Kees
>=20
> > + */
> > +
> >  int proc_dointvec_conv(const struct ctl_table *table, int dir, void *b=
uffer,
> >  		       size_t *lenp, loff_t *ppos,
> >  		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
> >=20
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20251215-jag-sysctl-doc-d3cb5bd14699
> >=20
> > Best regards,
> > --=20
> > Joel Granados <joel.granados@kernel.org>
> >=20
> >=20
>=20
> --=20
> Kees Cook

--=20

Joel Granados

--32qhfetqupl7qy6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmlCaK4ACgkQupfNUreW
QU8W1Qv+LWeolpPZAhJCbMBaRuTslP1C6yeO+1nkfpYZ4SMDgRARsLVED5s4gVHj
VyGA7mJCef2qmJR7m420kO8J8oGr4SEFbzbYsOu6jjGQcJxxdGk6mIKeG3KBB62C
f3hT5Qny7LZYk1JuT9fsieMbm9etb08UO5DuMYomzMilj8Fp8xZZwNaMIziHUXmf
n6tSEJVVgTECZel3ZJflmj/eFgJ0OOgIdaGXuNIDzywTyAtwoq6OxTCx5Kxv7SqH
0A9j7LOAoka6a8zEmT9qevryQ1RIT1I3a1thNL64L5rokGPL8xPVldhoItWNhb5i
7EvIl/4ETdF291G34iR7F57boRioQXjTUDZGq7xiiZu/e4z1YMZuimm2xkNrNWbe
9MfApK+lvDjbE9nHBnuh/aFFiNedeMhAhZUn24nB3IU/tLUHHoYNBsNWqam7E3yN
fqB5wo3K/5PvXKoGzjw9H4513Ci9KQcCTrb41eXx39wBKJYQlU/mn4KuxjyAujRe
0xJnK0MB
=q/hA
-----END PGP SIGNATURE-----

--32qhfetqupl7qy6o--

