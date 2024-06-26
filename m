Return-Path: <linux-fsdevel+bounces-22551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B34919A29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 23:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FF71F236E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 21:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8B0194083;
	Wed, 26 Jun 2024 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrSgCdhQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3C433B3;
	Wed, 26 Jun 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439095; cv=none; b=sTS+/kodwpjEAZ2lEwGd+txP6Bv6MAnug2A2nBSKItXCeCu/puF8ChuSraDb8EjIPDXR+H/oDnfWEV5Gey5J7h86qip6O5dt2bZJXqFISNS9ZSLncsySgGmh5Mthat4+BWcDNsp+s8dOq6DRtafGlKlCH84EkaN5NvLAdY0e7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439095; c=relaxed/simple;
	bh=QZJ7/HzBH4pTZwiH4TLihPPK7mwNS/dpzGdnBUwpgTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTEMjnWElg/gAHynGnPLUkboYFxx5v/9PGlvfC2dcQBoewJ0uZK2QFSyDIxA4fOc7pBxR6LPOI9e6oWvBgfe4lgQcucuS+okHdMyYd+XP3dKekRtFm0MMPLqnenDTm7zTAmcIpL4kDscRb2dUiLecy3FdCOGUq7YoyjqfRsU0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrSgCdhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE116C116B1;
	Wed, 26 Jun 2024 21:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719439095;
	bh=QZJ7/HzBH4pTZwiH4TLihPPK7mwNS/dpzGdnBUwpgTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrSgCdhQivaH7YasvqVD1rsL6UVkYtB0gd46U1ApXjt2X85J5/wYa0+lvBdoVHPVN
	 UblVcSKMzY/lTWGGRAppDMUvoZ2GaXAesGRVqedHSmio4gowfH/OmOhNoEpsSn5D/3
	 5pkM6ktdyMQ6Fo2QNkn3UU0/GnQY96FwA98njorfU/X2schp29xli7Ozb323DmubU+
	 F2nOqJmbJEXmFgt+vUIfryq/8MlxvP0+1SWBmbCeohGvdvPcsLL4oWhGDVRF9ZcA2T
	 +6+/iEYl37+zOsgmQ24t/LFVSgw/yzsrE01LYlC4P3+MvuzLukd80CWODtCX88Jb92
	 v3wz2Rksdch/A==
Date: Wed, 26 Jun 2024 23:58:11 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] man-pages: add documentation for
 statmount/listmount
Message-ID: <kkufg5ao56qt5awoglqlzpt55jozkwaioxqxwcjscrxmkt73mu@f6ll5xhxfcvi>
References: <cover.1719417184.git.josef@toxicpanda.com>
 <t6z4z33wkaf2ufqzt4dtkpw2xdjrr67pm5p5leikj3uj3ahhkg@jzssz7gcv2h5>
 <20240626180434.GA3370416@perftesting>
 <gsfbaxnh7blhcldfbnhup4wqb2e6gsccpgy4aoyglohvwkoly5@fcctrxviaspy>
 <20240626214407.GA3602100@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ospkzesuvkynuiey"
Content-Disposition: inline
In-Reply-To: <20240626214407.GA3602100@perftesting>


--ospkzesuvkynuiey
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] man-pages: add documentation for
 statmount/listmount
References: <cover.1719417184.git.josef@toxicpanda.com>
 <t6z4z33wkaf2ufqzt4dtkpw2xdjrr67pm5p5leikj3uj3ahhkg@jzssz7gcv2h5>
 <20240626180434.GA3370416@perftesting>
 <gsfbaxnh7blhcldfbnhup4wqb2e6gsccpgy4aoyglohvwkoly5@fcctrxviaspy>
 <20240626214407.GA3602100@perftesting>
MIME-Version: 1.0
In-Reply-To: <20240626214407.GA3602100@perftesting>

Hi Josef,

On Wed, Jun 26, 2024 at 05:44:07PM GMT, Josef Bacik wrote:
>=20
> Ok well those two things fixed most of the errors, now I'm down to just t=
his
>=20
> https://paste.centos.org/view/acd71eb7
>=20

Nice; there seems to only be one error:

CLANG_TIDY      .tmp/man/man2/bind.2.d/bind.c.lint-c.clang-tidy.touch

I guess you have a newer version of clang-tidy(1).  I have

	$ clang-tidy --version
	Debian LLVM version 16.0.6
	  Optimized build.

You probably have 18 (or maybe 17).  I guess we'll get there more
eventually in Debian.

I don't see why it fails, so I'll have to wait for reproducing it.

> I'm on Fedora btw. Thanks,

Thank you!

Have a lovely night!
Alex

>=20
> Josef
>=20

--=20
<https://www.alejandro-colomar.es/>

--ospkzesuvkynuiey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ8juwACgkQnowa+77/
2zI5uw//ZZgn9SQ3iRYDWmcDzack5xY6SVy7lONgTpBPCzcSWcmL85oB+g5l/6qM
xtBiByCEOJSIBQPqhkl9rtJ79rpYNsMvc6xqXqpDraVtiLv8N/1NY6yHZwWR1aDb
H49VJqTm1wzhyDEjNiB7Mz3olL6jD5z2e3vYiUqaB/uaUrDF2IudlE/HGWMbzhGM
ZaAig1h3ht6bfAgYAL/iIkR5OvQov42pc+BoN0n+PqGTa9YsxHD3+quptR+SA4RB
weYtOQcAyM8b4cSeGjHBbIqqEs4AG8Tmy0NdENy56mhDC6KGHp0DXOoau+cu3RBl
7s1Lj47fD9QmZaMW35+z8mzbNek2GRgRga0AXonWheTiBQVvRS261saS2yS/EXf5
1dCb7n88EWW40DbI93tft96fQxeGi5zQyXYGakpmOZqgGowW2cUa8MDL6Y1Ewxd0
srAMVIlHlaWCDckKFUKU1we45nfxTw9DcBVK62bzOQlfGPam8GFdLhpXzq/xkbwY
VVB4Hm69+iew056Jv+F76vz5WqlAT/F6EW3h6mcGSsCVm+Vj7WvwSvXWi4PU7qLb
6LRqULG/CJKAZhmPRB74ONiCVVgrWHThVE/jbrMFLv6vEYoCkaIOOQXenpozZw5R
MAOinKnqSytUzK1P/hkyaLVCaZ3qwX1YUUKRuSho/5fCBAuvCrE=
=gCNs
-----END PGP SIGNATURE-----

--ospkzesuvkynuiey--

