Return-Path: <linux-fsdevel+bounces-21807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FADB90A8B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 10:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79882B27499
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE6718F2C2;
	Mon, 17 Jun 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7Jyo6US"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606354918;
	Mon, 17 Jun 2024 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614033; cv=none; b=IKVmaCVIMT/xhGtM+iHDZtYOtBjntvZp9nuw0ENDdPVygD5YrpVozpJBme1iAQFWzOaNduya9DT+nJLqkLnYtM0s4oLIAK+2VwXmJi9DlP6VkIlI/g8mJar1RBkRxwUZk8lWRejpEdJjNuX0s8+vgHT/FclPwyNDzfHS5RVjQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614033; c=relaxed/simple;
	bh=FyJfbgYGABPvDIYrtskwk4tu7Q5+IehDwTI9Yxaeguo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pETKqFN1PkkOByf5V+wsWdjBAD6ZzhSE3AJzVSNTHEjP6+qGJjP/tQLfieFTTsrKKTs2diT8WpJ8CNwWu6r5wYqGCO65g2PatBmdqKkAnTkrAZ+Pc9KMEfGrMhM2/MpFNa98zC0fW7DqJJaWPbbRMwZ5GvXQkBPHbkab1H256jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7Jyo6US; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40191C2BD10;
	Mon, 17 Jun 2024 08:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718614033;
	bh=FyJfbgYGABPvDIYrtskwk4tu7Q5+IehDwTI9Yxaeguo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7Jyo6USCYPEDDyRi1/wUCnD59/4fc/qCt+Gk5jdwZEAt4Jp1dIVYsIIknIRRLO1f
	 Cbgm3yuAOV5ikKENLcFlE1CpHtjN+ntpjdPp62ceo1yH+QclJcby8gTHG/i8nN3Kgv
	 XUrlboLZbKI3OG8LpAXfKCFCo49EPBbPGOJeZt+BU59kDfdjZjIowk4YBSaWDXbusz
	 eeXY0CLTAkzkgqT8QqZ/avW8LiBDP7oDNShwcaIS2aSnxElZAi97hqKG5uJSeGo2HF
	 LiZfg6NJeTzCBE1WEjut1+jqIiHCyCSxGDuyySpm4bf3qz9hA4XuQ/Ob9/6BUwuvDO
	 5liuYgcz2fxoA==
Date: Mon, 17 Jun 2024 10:47:05 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
Message-ID: <bjrixeb4yxanusxjn6w342bbpfp7vartr2hoo2n7ofwdbjztn4@dawohphne57h>
References: <20240311203221.2118219-1-kent.overstreet@linux.dev>
 <20240312021908.GC1182@sol.localdomain>
 <ZfRRaGMO2bngdFOs@debian>
 <019bae0e-ef9d-4678-80cf-ad9e1b42a1d8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p5vwi5qgomteimh7"
Content-Disposition: inline
In-Reply-To: <019bae0e-ef9d-4678-80cf-ad9e1b42a1d8@oracle.com>


--p5vwi5qgomteimh7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
References: <20240311203221.2118219-1-kent.overstreet@linux.dev>
 <20240312021908.GC1182@sol.localdomain>
 <ZfRRaGMO2bngdFOs@debian>
 <019bae0e-ef9d-4678-80cf-ad9e1b42a1d8@oracle.com>
MIME-Version: 1.0
In-Reply-To: <019bae0e-ef9d-4678-80cf-ad9e1b42a1d8@oracle.com>

Hi John,

On Mon, Jun 17, 2024 at 08:36:34AM GMT, John Garry wrote:
> On 15/03/2024 13:47, Alejandro Colomar wrote:
> > Hi!
>=20
>=20
> Was there ever an updated version of this patch?
>=20
> I don't see anything for this in the man pages git yet.

When I pick a patch, I explicitly notify the author in a reply in the
same thread.  I haven't.  I commented some issues with the patch so that
the author sends some revised patch.

Have a lovely day!
Alex


--p5vwi5qgomteimh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZv+AgACgkQnowa+77/
2zKErg//SwIaK+IxXsmcOHmGw0k+mFLS6xTjoAfmDspcMoBh9Rk24fzp44EJC5TD
ldVkL/eYPW1X70U/nqevw6H0k2ly4TkcpZllN8BvsX9UL16oI3ZBk0Y2auFN8zlM
srJlro7h1wtw8G6Y1gTjI0a2fOGCBUvHZ1C1nObFxNUx2M27z94U7PZB4B8Y3sfd
R1jkI+Oqjr67umkxDrH4Ts2UdJieFbL/a+iUO5++507ADjuSZOs/BrqCSEAos6Vl
Of7RX28sjTf2B12zQET4jkpPiCrQvRnHw0i34puprWVhI8tWOrKJoQI/QMkhIOV6
WOKqqQc7gHlIlL1b5znHck99bDuHbwQrje5gW4AewgIaQZBIrb8uRxjnXpRvk1Lq
vE4OSHI1gDbV7NcqJB873YP6yRQYXOCOKMxSI8Gfji5I6ow1WsYjwzki1gFQcjY1
Hjy7wcQkkMQpyYb1v37oYX3K59pOMdsxDYw7E42xYBfBdHr/zvLCq9zAysFn6tBA
jS3oP/9yeRqz+QxPVfAZ3pqoQR8SS1ZhSBJoEJgHV7RDyvYCD7GlJ0USyGJBYCxW
eaxPqJNOl8gY7hE/iHI5gGoudRIUhl0uBnD323nfXQ5G3V/aPsXgOUnWaTrcE8pP
RxlTpdGg27nrwUpFPSJMUHIiG/eQrrbAAt5u80dsUI4QoxODByo=
=6Hnj
-----END PGP SIGNATURE-----

--p5vwi5qgomteimh7--

