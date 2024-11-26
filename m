Return-Path: <linux-fsdevel+bounces-35896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC819D96BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A1A281188
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F3C1CDA15;
	Tue, 26 Nov 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn9TJLI7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01E1CEAD4;
	Tue, 26 Nov 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622115; cv=none; b=UTxZA6BJfx+k93BacuqTuO9OE8aCS/50XviyYaM5djtv9suG+An476qU8mjUPg7Umqtjr8NIULdy+jLNLTx5WMN30Px4+OzvJzL9anhgkVGn0pp0hYCDKqczV1y8tWGZ3YmFa/c0ruxoMFAC0KOxFNMp+tEleFBb76NHDHSYF3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622115; c=relaxed/simple;
	bh=VvdJkXuaM32ucNjZ52HMD3LKsA7tWOycv44JwvlpCPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klzEGmh4q1m/137hkrxD+eYifNVykcqbszkQwEGkSLciFsa6Y7C4Ak6jh+pgyE1AlHRCWG4ROL9ZPHArwd6+N2LsjpqtdVxhqaFS43riqfTb5zX/yUxvtJUw782HvrmvjppP2VoowDQYiLitf3t+Hr/V7tXCYp3niiA+Fkdye6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn9TJLI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395F7C4CECF;
	Tue, 26 Nov 2024 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732622114;
	bh=VvdJkXuaM32ucNjZ52HMD3LKsA7tWOycv44JwvlpCPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hn9TJLI7a0l/uwfGcwIzkGNk/b/HJcIXuATxgyzDkmJTzKCIu4wENIA74arjlmDk+
	 uuBq3v5Vo7DSnQuK54M8xlFnSVbKm/PQxzVWvVZcRLsSRn7XtTNewVYtTt23C9lLy/
	 OX48dT2/SSPgYziYwfBsIKpxk3tsmXXbt0x4zT/EhDaHvU5Z+0toFyywFW0n015Qqx
	 MhRC4h4GF0CTC4fI55LFSufCWFTiVYL7RnARYyoNnT1zPy6v/gXNCOrZVhVkGxWyck
	 cs28PphgbjC3xrxGPpBdaSHVXS8GpbP/qQwlmcCB4gKKy/DnxSg1tgByBkl11RC8T/
	 aPn8BtYrW5DPw==
Date: Tue, 26 Nov 2024 12:55:11 +0100
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dalias@libc.org, brauner@kernel.org
Subject: Re: [PATCH 2/2] io_submit.2: Document RWF_NOAPPEND flag
Message-ID: <20241126115511.aw4igyvlrd2ak7dz@devuan>
References: <20241126090847.297371-1-john.g.garry@oracle.com>
 <20241126090847.297371-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ua5qad3vdrn6s7xp"
Content-Disposition: inline
In-Reply-To: <20241126090847.297371-3-john.g.garry@oracle.com>


--ua5qad3vdrn6s7xp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] io_submit.2: Document RWF_NOAPPEND flag
MIME-Version: 1.0

Hi John,

On Tue, Nov 26, 2024 at 09:08:47AM +0000, John Garry wrote:
> Document flag introduced in Linux v6.9
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Please add the Cc:s also to the patch trailer section.  (That means less
work for me pasting them.:)

> ---
>  man/man2/io_submit.2 | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/man/man2/io_submit.2 b/man/man2/io_submit.2
> index c3d86b4c4..64292037d 100644
> --- a/man/man2/io_submit.2
> +++ b/man/man2/io_submit.2
> @@ -141,6 +141,16 @@ as well the description of
>  in
>  .BR open (2).
>  .TP
> +.BR RWF_NOAPPEND " (since Linux 6.9)"
> +Do not honor
> +.B O_APPEND
> +.BR open (2)
> +flag.
> +See the description of
> +.B RWF_NOAPPEND
> +in
> +.BR pwritev2 (2).

LGTM.  Thanks!  I'll wait to apply it once patch 1/2 is applied.

Have a lovely day!
Alex

> +.TP
>  .BR RWF_ATOMIC " (since Linux 6.11)"
>  Write a block of data such that
>  a write will never be torn from power fail or similar.
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--ua5qad3vdrn6s7xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdFtx4ACgkQnowa+77/
2zKf6BAApkVdk4mq6MRXaqIkFWYVOwt6IzpahPQTjKRJ4uw0g5p4tu2FH2QQCcQl
N6vIvFxgJgf838BCSEqcouUqL9U60SpnI3nM65Ymh45QAgz64nn4uwLVTTG6/ISy
NxiS94xpa3v4yBed4JINdEqY8rjN6r+OEEOjJ6VYNwLRwl2+t3yuScII0M6fYXaj
2K0CxObF+rueGPnvsacMmMy3WJmxXoH+T8M/PLGHhPAsTF36GFsg25hyglnACnzA
OOB3ARGcM9/LZq+c2pw1cRDlcAELBoMsGVsgu+VRLKvyXoXPPFcTtR5MJ8OLAv9F
jrjWD/59G2JqAdyHynCxqBAJJ5iCh842FY9FsBnn4E8/83GAHuscSvWIXV6rVu+x
xS24sHEBBXXDLbvOJymSIjuy2UwcAFY4KXoQ5xnqM2ESQPrGJ4dYzI7WXbMaVa7E
XiP7aXn2npAhJ35yxg95I4MeHLHb3Jeb8ElCKrugYQWz5M1ffxbU5bIgQ97O20ja
CL5o1UD+xMbod9m5qwcJ2tXtlijyDOgeXu3bZpHPtS9CPdvIRY+YSCSeqCdtB4F/
GIukFRy1gM7jP6RApDf/OioZ8ZLzpDsQxQXzaaSmeFaM9icKLPVlt5Z139eSJfui
i6eCKx28IqXxjljUH8GxEWtsgRnJOMbn/d4g6bQxZ9sumbdaoJs=
=yNbH
-----END PGP SIGNATURE-----

--ua5qad3vdrn6s7xp--

