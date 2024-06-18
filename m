Return-Path: <linux-fsdevel+bounces-21877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7EB90CB6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 14:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B50C1C22554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 12:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045A2139BC;
	Tue, 18 Jun 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsUOoSZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E52139BF;
	Tue, 18 Jun 2024 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712886; cv=none; b=aMmSJRVUu17TJ4dNO5FjyVo57AfuqY/tLlKp9qP0npVLCNuproTMfvooJyVec6+k3nk5QGAQH05E42F/dOvHSz24aWbCgJiymdoVsciWEEH7ee+x2Ax79x9QL1AylQbrp8G0k5VztZew6bfvEJH/V5zay8v0gL4xYbaeIOiBQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712886; c=relaxed/simple;
	bh=/kQQvCSO7koNN5eK0U9bdRCqiX5+Snib6/K2ZBeiXSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7FKVAgSl6WHzgDJwv/BEovdYIvUtBmXy2Q+bl3OkWshlXSrOnK4Xdcw5QGg2sdTUzs6Vk53b19jtGCOxRsukJYMerlxI4xX3luIhU1YUttrYdoZKF2Mp6ZgD1HLPP+xSp++KWf9icI6QVdSgb8I3a85JZM55BXEFN2hN3AhoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsUOoSZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF64C3277B;
	Tue, 18 Jun 2024 12:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718712886;
	bh=/kQQvCSO7koNN5eK0U9bdRCqiX5+Snib6/K2ZBeiXSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsUOoSZVrRj6hq+icFL2OCx5xclrS4ag8xZx5+WNKjG7pkvdV/3pjBGxUWfzyZC+/
	 UJON+rAMvToC/c0NQnUjJZbgTdlmGEtqMkJMBqI8F09CGUd8ap+MpI5z3yDvazqNfB
	 vyj75EWO5R58T+jv2AfWNbc8FOugsgx46rvshFuehZe9+DoPjuM4hXyPB9vLdJCAsU
	 QhG1VCq55gerRbS88DOwTADidIaG/AOeoixD74bdonazDaoqdCs807L9Ey+x6m4/o5
	 fTPDTydeYYXMo0YjfZVhKOGRoF7AZyalL3SDscC1djPH7Y9IZdVFN6eGhwavptK0x0
	 k8Pw/br/x5x8g==
Date: Tue, 18 Jun 2024 14:14:42 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
Message-ID: <7ljnlwwyvzfmfyl2uu726qvvawuedrnvg44jx75yeaeeyef63b@crgy3bn5w2nd>
References: <20240311203221.2118219-1-kent.overstreet@linux.dev>
 <20240312021908.GC1182@sol.localdomain>
 <ZfRRaGMO2bngdFOs@debian>
 <019bae0e-ef9d-4678-80cf-ad9e1b42a1d8@oracle.com>
 <bjrixeb4yxanusxjn6w342bbpfp7vartr2hoo2n7ofwdbjztn4@dawohphne57h>
 <1d188d0e-d94d-4a49-ab88-23f6726b65c2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wrxkr6davydpt5dj"
Content-Disposition: inline
In-Reply-To: <1d188d0e-d94d-4a49-ab88-23f6726b65c2@oracle.com>


--wrxkr6davydpt5dj
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
 <bjrixeb4yxanusxjn6w342bbpfp7vartr2hoo2n7ofwdbjztn4@dawohphne57h>
 <1d188d0e-d94d-4a49-ab88-23f6726b65c2@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1d188d0e-d94d-4a49-ab88-23f6726b65c2@oracle.com>

Hi John,

On Tue, Jun 18, 2024 at 10:19:05AM GMT, John Garry wrote:
> Hi Alex,
>=20
> >=20
> > On Mon, Jun 17, 2024 at 08:36:34AM GMT, John Garry wrote:
> > > On 15/03/2024 13:47, Alejandro Colomar wrote:
> > > > Hi!
> > >=20
> > > Was there ever an updated version of this patch?
> > >=20
> > > I don't see anything for this in the man pages git yet.
> > When I pick a patch, I explicitly notify the author in a reply in the
> > same thread.  I haven't.  I commented some issues with the patch so that
> > the author sends some revised patch.
> >=20
>=20
> I wanted to send a rebased version of my series https://lore.kernel.org/l=
inux-api/20240124112731.28579-1-john.g.garry@oracle.com/
>=20
> [it was an oversight to not cc you / linux-man@vger.kernel.org there]
>=20
> Anyway I would like to use a proper baseline, which includes STATX_SUBVOL
> info. So I will send an updated patch for STATX_SUBVOL if I don't see it
> soon.

Thanks!  no problem.

Have a lovely day!
Alex

>=20
> Thanks,
> John
>=20

--=20
<https://www.alejandro-colomar.es/>

--wrxkr6davydpt5dj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZxejIACgkQnowa+77/
2zLGPg/8C75nI5J27deQxTu1vAf1SyUUbL1gUr4nZRK2Aez7rZ6g+p/wssNGSaJM
bnzB+VB8xfVSom9ilBdLeeokBnA76IXGgRqwFkTJvW7lkXyLF3lzipMDCyxy5NqN
hivglHxIy1rLn9tzjcnGC+uhuuYOdljewKluL6+0niZqUjEo6MjXStEtyDPh8bfZ
Pss0Pp+9fjSvrXFsUjB3p2cWHqMHxDbO6wBtfZZRjjXQZ/MotWJgEtSzfQBtQRqE
6kEcpkKSLJxLEiB3Yv5Phu6lOMDZclPTX9HNtwGPnTWmru3zt4Im4KH5xttBBxqO
K0Chw3iO4ovrtVEwzFe+PgreH5irT2jwwPs9uBpYgxYJYC+fdeA6cuSsz74vWpV1
5jf7OgPPkLHxY65DpbKhAveTgYRbYiteSOmAxFYGtH+aqBtAf1YoYBuFvckrRq4F
p/EEPE8jCJWMRYH+vGxcNBTrGt3LW3+7HVigc7fNi3k8blTg70WULoM+KLYclVHg
wmQSyB0J9JvCNIlYwGAqrS0/1ix7QLWOrOsiwJyOioShBJ2bk+qxhHogGDXx/hrR
yIcIoSUJVczfsCB4Q6p2TcYuNX/MxYIgvE1WMct+kph5bNSRw+FlciVIZ4CHo+2K
DXDXn7ZYxesBpqn3qHDc3sJvzOmFEcpMvHr9K8u8HgYnAbEhhdg=
=o0qs
-----END PGP SIGNATURE-----

--wrxkr6davydpt5dj--

