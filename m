Return-Path: <linux-fsdevel+bounces-35672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDFE9D7109
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218CA28315D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613951D516F;
	Sun, 24 Nov 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfVT+SB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF0192B81;
	Sun, 24 Nov 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455318; cv=none; b=DFA7Uxd9GXPPJZcIfU0SoxRoomIVr1Jo7tNA28zBpnk5HJIEBzh0oGDRU1GVw6bhbvn6o+vQICnFHC2XVg6lCS5O7pCDMRSP+nad0M8uNRWeOr3EBcsJ+li79jSP2++rmzEeryuJkGHTpJnJJYJBZAUiBOEk0FoUeGBrVxmZjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455318; c=relaxed/simple;
	bh=NSj1wSAy/qfbahm0QBwKnDfovE8e9X2OpaniglPLPhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWImS8pcwZSgYRI94nLKXDauC2foRtVR8LAbe6Ov9ZBAiGAj5Mho7Te8wO21Ts3a5z/1Y9mqZkJ6NqWCR6iXaJYrzAtVkefQr3I2R8ukJoPo73a3cvERNx5LAiN/AsTVUhnNvCIHjqEaEkkiOybgJ/c9lVPqf2pw4m3v8f7Zmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfVT+SB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBBFC4CED6;
	Sun, 24 Nov 2024 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455318;
	bh=NSj1wSAy/qfbahm0QBwKnDfovE8e9X2OpaniglPLPhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfVT+SB5h0mOz8XpC+clKCzEC3vA9NUa98UCsiOsWiNmwxF05HNl1JJEu/rpmgQpw
	 Q/Af16Dls4gkHsEQzr0ub5w/xrF6BOyNgr7K9yVtwwNN6r84au2sek8igaCz2J98hd
	 VnJ93DKT8ibrW6+qWarrxfcdBzcQrhQ6HH8wm+mwWQCfNvEUfjQdTKDyYf3iyCJXJ/
	 UwpGYXpbIQLfexuwweRJ7USvb2xZgmRHoQ6LsbYDpVM1Spf8q9QNPs7nvLjHJUMxrN
	 ifyShMVwDNxtpT3ksXLaoT72h38GUdV5TVdL298x/7Dfv9z5Fh2pozSsfEn0n2j9GA
	 HTxEpUuI7ZeIQ==
Date: Sun, 24 Nov 2024 14:35:15 +0100
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
Message-ID: <20241124133515.cb7u64jccayt3deb@devuan>
References: <20240311203221.2118219-1-kent.overstreet@linux.dev>
 <20240312021908.GC1182@sol.localdomain>
 <ZfRRaGMO2bngdFOs@debian>
 <019bae0e-ef9d-4678-80cf-ad9e1b42a1d8@oracle.com>
 <bjrixeb4yxanusxjn6w342bbpfp7vartr2hoo2n7ofwdbjztn4@dawohphne57h>
 <1d188d0e-d94d-4a49-ab88-23f6726b65c2@oracle.com>
 <7ljnlwwyvzfmfyl2uu726qvvawuedrnvg44jx75yeaeeyef63b@crgy3bn5w2nd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i7e4vfpnwr6ekend"
Content-Disposition: inline
In-Reply-To: <7ljnlwwyvzfmfyl2uu726qvvawuedrnvg44jx75yeaeeyef63b@crgy3bn5w2nd>


--i7e4vfpnwr6ekend
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
MIME-Version: 1.0

Hi Kent, Eric, John,

Thread: <https://lore.kernel.org/linux-man/20240311203221.2118219-1-kent.ov=
erstreet@linux.dev/T/#u>

I revisited this thread today and checked that there wasn't an updated
patch.  Would you like to send a revised version of the patch?

Have a lovely day!
Alex

On Tue, Jun 18, 2024 at 02:14:46PM +0200, Alejandro Colomar wrote:
> Hi John,
>=20
> On Tue, Jun 18, 2024 at 10:19:05AM GMT, John Garry wrote:
> > Hi Alex,
> >=20
> > >=20
> > > On Mon, Jun 17, 2024 at 08:36:34AM GMT, John Garry wrote:
> > > > On 15/03/2024 13:47, Alejandro Colomar wrote:
> > > > > Hi!
> > > >=20
> > > > Was there ever an updated version of this patch?
> > > >=20
> > > > I don't see anything for this in the man pages git yet.
> > > When I pick a patch, I explicitly notify the author in a reply in the
> > > same thread.  I haven't.  I commented some issues with the patch so t=
hat
> > > the author sends some revised patch.
> > >=20
> >=20
> > I wanted to send a rebased version of my series https://lore.kernel.org=
/linux-api/20240124112731.28579-1-john.g.garry@oracle.com/
> >=20
> > [it was an oversight to not cc you / linux-man@vger.kernel.org there]
> >=20
> > Anyway I would like to use a proper baseline, which includes STATX_SUBV=
OL
> > info. So I will send an updated patch for STATX_SUBVOL if I don't see it
> > soon.
>=20
> Thanks!  no problem.
>=20
> Have a lovely day!
> Alex
>=20
> >=20
> > Thanks,
> > John
> >=20
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--i7e4vfpnwr6ekend
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdDK4wACgkQnowa+77/
2zL/cg/4yOgSMw7FeuoYYPp66yZ0dqVpMfSWsavTPNFwhqqozAXtFYNdrSYN9q5H
dapHLr5+BfqClZcvJYiaCLmJq8o0XazxSUfAtE06FFIUgrziv+nNvRAQUiH6JZpV
vnwbIeTo8auggFwf8BUtIb+4jjRMr86DZLTuDcF8E9W5qcr7EY3M8SR3M1/hzXfj
RcDCgEagscbZb1MN7yfGbk5O1UeZ0Cs92svomSm/dvbbkMmZLKQa7OvJfONYpXwp
/BEDYYFlp589PFylhcsrreJV5xZtqQ/Mf58hKwYiSPaEp2DFUdvH1YB3ZhhNwxoe
menU9OTJ+NPR7r9FDuzNTJb7KtCNHMK1SEotKT77AwN4FHSJ/pvNCGltkth9hAIs
89heHB93xGIQuKgDBOL2KxrNG+Zy6P/5Yr54Zg23NFcKijnj3ok95DcarpNITUZn
kIW4EiIsOF+Z39h135wBVfp+pBelhQFtSkpUPEiJKzNyFVkVOsHLtFn0dWMPqgD2
oIJ+SJ61sc7zZjygDghddIUyi5Q+0mWdioUt1NqZOvPxhupmhE96TuX6N9EvfpFq
GqBqz9kMohs+v/N9v4cDgm5ZnoSSosZrN2rYV0lcAqz1Zytja14QdqQs+XQVnS/l
5LubrE6S2Yt6WASbBBR/EZU48QTPmeqp5gxefHubmk31fvyB/Q==
=O9BK
-----END PGP SIGNATURE-----

--i7e4vfpnwr6ekend--

