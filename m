Return-Path: <linux-fsdevel+bounces-46850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57FAA957A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 22:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886797A460E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 20:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A421F12F4;
	Mon, 21 Apr 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A92mKsUj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1071D89F0;
	Mon, 21 Apr 2025 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269032; cv=none; b=B1+96IQHdqAl1rrentru/Ju3fipmF7xMUnVBBO1aRYGqtJCRnnn0K8276ll5/QYeTyZlYS+hYJ8AmBBCosicEgQhXvir3L0dhtehIpxmq+4ezSVndCycinIhOCxZwyRwK1cFaplUoW7fI98D5Qr8tvK4eBLGi7OvNuzsbGZ6GIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269032; c=relaxed/simple;
	bh=Ggc+RzH/TUWrQ1IJBDbxdan5l/yWILcuRFuQso+vSsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNpR8ipXz69oB/w5PAa3u1syQveH+E50UIluctRRU+eLU79tdsQOoHDRrHYq46ZIinkWGIVTGmEAdjP4UmgmkzQ8/1cwYkQL0nN9GPOqm+kaPXk0jFHGayvSIYEyFeueQsQnvM0IzKa7nPB3t2OyyTR7RUtrwKDQyDKoBygWGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A92mKsUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922F3C4CEE4;
	Mon, 21 Apr 2025 20:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745269030;
	bh=Ggc+RzH/TUWrQ1IJBDbxdan5l/yWILcuRFuQso+vSsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A92mKsUjlMTGviZK9Hn6NLba8Ci9svOBrQlwv6imOZHkIe/QkH60mqs90zmmVZ5z+
	 AM/J0aQgho+Ko14r6iYVf47bvBPWO1FwXBbx8y+5ntIMJdiFstp5IAQ7Xc2BVdv3Sj
	 ad4a/KpMADmJ5te4hkhv+iVX6FHt3PtHt8eCsUP9g0xx9lFmjmAMU8XUhLHh+39Wy0
	 qNICuYrhYyVIviTzeU97nPE6zK8p3qg774ES6rrlfkNPqohV3ypZVMqjDI51T+ifAd
	 TIcQKQ8TwrYJw4X3BdZoWs6vyLMaKNsZsXZhQR6+ZQ/iADf+w3w6wmiPuYo0KBRHyW
	 ZbvFofloWk3ug==
Date: Mon, 21 Apr 2025 22:57:05 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: {FD,O,...}_CLOFORK have been added by POSIX.1-2024
Message-ID: <xrhmhkna3mnggfizcb3z6q3ee3pxuskcbilf6k3h73g2jliyac@vbty3psge326>
References: <e2t4obcqeflajygu365ktxnsha5okemawuwl32mximp5ovdo53@2pq2f46wfdkg>
 <4taakq3b6l6lr26qg4rhj6whwkzrgxv77cxgqeoj2edmuot4u6@5yxesrgwzhsp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fltnz4w75r3iwd2v"
Content-Disposition: inline
In-Reply-To: <4taakq3b6l6lr26qg4rhj6whwkzrgxv77cxgqeoj2edmuot4u6@5yxesrgwzhsp>


--fltnz4w75r3iwd2v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: {FD,O,...}_CLOFORK have been added by POSIX.1-2024
References: <e2t4obcqeflajygu365ktxnsha5okemawuwl32mximp5ovdo53@2pq2f46wfdkg>
 <4taakq3b6l6lr26qg4rhj6whwkzrgxv77cxgqeoj2edmuot4u6@5yxesrgwzhsp>
MIME-Version: 1.0
In-Reply-To: <4taakq3b6l6lr26qg4rhj6whwkzrgxv77cxgqeoj2edmuot4u6@5yxesrgwzhsp>

Hi Mateusz,

On Mon, Apr 21, 2025 at 10:44:38PM +0200, Mateusz Guzik wrote:
> On Mon, Apr 21, 2025 at 10:21:26PM +0200, Alejandro Colomar wrote:
> > Hi Jeff, Chuck,
> >=20
> > I'm updating the Linux man-pages for POSIX.1-2024, and I noticed that
> > POSIX.1-2024 has added *_CLOFORK flags (with the obvious behavior).
> > This is just to let you know about it, and also ask if there's any work
> > in adding these flags.  I'll note something about the existence of
> > these flags, and that they're unsupported by Linux, at least for now.
> > Is that okay?
> >=20
>=20
> There was an attempt to add them and the idea itself got NAKed, for
> example:
>=20
> https://lore.kernel.org/all/20200515160342.GE23230@ZenIV.linux.org.uk/

Makes sense.  Thanks for the link!  I'll document that POSIX.1-2024 is
purposefully ignored here.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--fltnz4w75r3iwd2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgGsSEACgkQ64mZXMKQ
wqkH4BAAtPgIUG+iWUQX268+CCfVGNPEQDPgi2DtX86tNHZ/Ob5ZyXbIJ+RjyihM
LEmUPtF8ME+ZAWgEzqklsNVsIRWJ76yRr1yJHWRWGMADe+BOpBYDtVY8ggdWwD+/
3FUAmsT5gt+jz9XgBWzwU/WBX2euUNSCIUsO/z5r3AO7mHELfOUR6QD0nDM8EJtz
BC6S0q1DcOWJZcKNhl6Ne0ZoJs9IJshwKrAYtS+7oF48Ipi4uQk1ym2iCYxNAr/P
TMs8y1ZH8X1QjDYfna5ehGfBFtYz0VTETEd5eVvVqZiH/pb2JGNcrS55V8zMldiv
CMK1gAlGivTTba4xEsR01M4nDWSG4nOTPL7NzXav0IkvzZxo/3n/KzJRxcdia4If
AfP8GoWdNDN9guLuPhmxQwBxzogG2bcQ8i/PP/Hz9IWa4uHAGswvFslLl4fdxYOq
Am2A7FKv2UIY2KSnQ8V6bemcSrM4BQBAU3mtNUkz8Gyi/skRIzQr2T87734x9XNV
MReWSOzVL+G9ujXvNw1Yr5MN4/Oqtsd9TWd+4NHC5atfcppw0K2CN8R0LC+4UUUD
XCkR2tdM43SMRuKcPsCslPEjNcDu8gSMU8cyNfOfSxl0v3fjqmicTqNuHuFpIPa8
eEOqU86GF/9RHOMZtpUxUmygoOvSixDTs29p0+OcpqpnL4oDRzY=
=YDuS
-----END PGP SIGNATURE-----

--fltnz4w75r3iwd2v--

