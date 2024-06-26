Return-Path: <linux-fsdevel+bounces-22552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F0919A51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4101F23708
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 22:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96288193079;
	Wed, 26 Jun 2024 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED7KxfLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4063EEC3;
	Wed, 26 Jun 2024 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439331; cv=none; b=b7WEtztsnHIjEwNzAPgngeTZcS2jwusLF4Yf4M61V5ewi+QsEKqNdPW8MuAwLz/Up02q+dUtAa6AU+WvObyvqG2FjEegvHgBkoNu3VJu9SbPHIpMxy6J38pPkWf9S5srWpufpFRplsmZZR8z75MFks7yXL9uCKZi+m3tDseI+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439331; c=relaxed/simple;
	bh=IT9QLWEm4LoknT6flZWXJ7YL59bSuQjJcGoW5Bk0wc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA81IXDyDb/o0+2LyJxrmy32lixEBdtx5DS0pCecaxXlizl1m4X/amkv7D5+epCXBKVlIAf6WNqPEm9LraeNDm3+lnYiuiPxno3vRkuPJveBUf1chO7gi1zA+4pwVXup6lq1Z8dR9uTT/WD8jc32pMHYOQd1xSU4QJVsfPKtupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED7KxfLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3423DC116B1;
	Wed, 26 Jun 2024 22:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719439330;
	bh=IT9QLWEm4LoknT6flZWXJ7YL59bSuQjJcGoW5Bk0wc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ED7KxfLdH00CPcrTBqgN5Jd4tl8iUmCs/3dIw4TyB9ZaMpUkZwzXlXU2Q1Ms0/hWw
	 pFZ2kuHQYEA6aPECw1QzjFdD9ppNdHiC37M66I0Y/BRf+3jk/wpn+jLU1YHd5HubE8
	 CSS+yLvGdWsrhMxChaNneDFbjkvQlsYl9sad/y2B3mmVrfEbD73jiGjsmptaUfBwVM
	 A7oo/4Nl0DL+AVtF0wvGoNRxeMuKC7A6muMnuHmiOhqbOAAKtDotXegpfzzb1/EiCF
	 Ve4caex6MEBU3DgB0AmbcMVbKOtYEsB6nUgRjEwWYL5NixjVM+bviQxeDpH7vmIo7G
	 YHq/IP6wZWjKQ==
Date: Thu, 27 Jun 2024 00:02:07 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] man-pages: add documentation for
 statmount/listmount
Message-ID: <x3u4n5bpmi2vko426wjlf5io5l6je7xaeckawe5htgppu2yt5v@lrf5grwbh3i5>
References: <cover.1719417184.git.josef@toxicpanda.com>
 <t6z4z33wkaf2ufqzt4dtkpw2xdjrr67pm5p5leikj3uj3ahhkg@jzssz7gcv2h5>
 <20240626180434.GA3370416@perftesting>
 <gsfbaxnh7blhcldfbnhup4wqb2e6gsccpgy4aoyglohvwkoly5@fcctrxviaspy>
 <20240626214407.GA3602100@perftesting>
 <20240626215034.GA3606318@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pxcsjgncvpetpixc"
Content-Disposition: inline
In-Reply-To: <20240626215034.GA3606318@perftesting>


--pxcsjgncvpetpixc
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
 <20240626215034.GA3606318@perftesting>
MIME-Version: 1.0
In-Reply-To: <20240626215034.GA3606318@perftesting>

On Wed, Jun 26, 2024 at 05:50:34PM GMT, Josef Bacik wrote:
> Err that just shows the one error, this is all of them
>=20
> https://paste.centos.org/view/b68c2fb1

For skipping the cpplint(1) errors (I don't see cpplint(1) being
packaged for Fedora according to <pkgs.org>), you can do something
like with checkpatch:

	$ make -t lint-c-cpplint

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--pxcsjgncvpetpixc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ8j94ACgkQnowa+77/
2zIQoQ//UK80IdF3vHLGQheqEGJBmGcsSVCGDB+FceUeWEzjZ77k4nMhWuVyZkmE
poCwpkEyPPHET0UQuBBqFiB5EXzOzvOq5vYpWw+gtGKVzAItmxt3FPhzCF71RWyf
yZZjTAmjWBm4FcvJ75Zwh99eII20ToWxLDbSEcchsfcld9KPLTwZWZjLrlzG+jAQ
qy6sy5XF/qnMMO5eu5tdsUawgJ8tUivt840AQje2/Mg5OiY3OE6lIof+XRdnSAfU
kKtUMUXJjD+IQcZbLKHOOwIJPal4OpCJj9BXKMXuDIJGNmesutp8SfoDwCg/9nw1
98E2ohtdYG7bwhbniDvEK3dOOE1RSyzf9O1ZF/iTfOL76fjIFmLxN07hlD7J6XZn
+wUOp5aTqTL4tyEDujmKochArJPIFSssUwWhcA/haTqD7LLBXfufZ+9nTdei9QKn
d97iklKOxmZ6xsFwTAia3JfoQ3S8A2+GazzXZh2+/ucTiHX2IlpWUCRnP63I7XG5
bHQNSc8OULZay7UamNm2YHeP1fhJRheCdzwJ8mAAl90tHLf+s18u3ocPTeP5Iopv
uj5SgtbvldDRU5mtH8hkKOy4KzXwhbkofW/Bu2JLpdu9yEop/d+yeegnMFaIxKAZ
pkQEVukJoKlWjreq/Trcpzx+tiFxL0VZe8jJncgGFDHlV75yXAU=
=Wy4H
-----END PGP SIGNATURE-----

--pxcsjgncvpetpixc--

