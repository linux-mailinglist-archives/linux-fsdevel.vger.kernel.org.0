Return-Path: <linux-fsdevel+bounces-35895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B360D9D968F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4424F163FC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729821CDFDE;
	Tue, 26 Nov 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcKzmmqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152E17B506;
	Tue, 26 Nov 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621980; cv=none; b=h4gPg1PYWRRExB906NABRtKEoiifRfxKiN0vSzmH2+wHkULIZLfn8jv1CJQhciBzJi14NzTubHRA9SCiBY5wRg6ngeHDoUNsoY9mpcerXZRoYgXlg/MW6z7S89neozUy58Yyc8OCY4x4X9lSjmhktWwEYO1N8srma70HoQIlBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621980; c=relaxed/simple;
	bh=m+Fon3EC0XStbI0qN8vcP5jsqZTOv4n+rTBn8bBdjdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7voD4rFYZqy2T3oaBdh+rKobXAN80xAa3hoTOcH5ZmKtAozFXS2fhcHd9f9QObo+H9zesZiIK8TNDGKLbEV00gspUHS9x19AwjHGmq0tyd0MR4CpLZssz4ALik9a7wIBFSUtDkioZU3Q9FYONvffiIwjudVwSrwibaQ4yPELug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcKzmmqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BFFC4CECF;
	Tue, 26 Nov 2024 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732621980;
	bh=m+Fon3EC0XStbI0qN8vcP5jsqZTOv4n+rTBn8bBdjdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcKzmmqfzhywtXURq1jDsFkUd0tEAuN/nIHkdOep9BxiVxds4T+kBZrbin2VG0Qm5
	 JrPvSOJgmaswUFyzDk7D51sIBDnZvUKjDR/lwFPQNSy1xJcjUJ4EtyzNGSuYnerFVf
	 uqNKP2bqjqNGQPTDGyFqmPE0zYC6awSvaJ7MHStRt3UyrJARBGVI74MkLizW2eQxfT
	 Ue0+FJlorde6VDCFPU/rs9iJnfO3b/LCkZQX2qd+fzv9IrQbOHmJb3Q/JALMfr6Ugt
	 cKyTa4mIR/f3JMMhs0w8lHGG9jPlX5xfwZ3sebt5zT15IFdKeZ7bvRL34BYlJc0biT
	 /MKl/Y/+6G5vQ==
Date: Tue, 26 Nov 2024 12:52:57 +0100
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dalias@libc.org, brauner@kernel.org
Subject: Re: [PATCH 1/2] readv.2: Document RWF_NOAPPEND flag
Message-ID: <20241126115257.r4riru6oot5nn6x6@devuan>
References: <20241126090847.297371-1-john.g.garry@oracle.com>
 <20241126090847.297371-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dpxysf623xg355uw"
Content-Disposition: inline
In-Reply-To: <20241126090847.297371-2-john.g.garry@oracle.com>


--dpxysf623xg355uw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] readv.2: Document RWF_NOAPPEND flag
MIME-Version: 1.0

Hi John,

On Tue, Nov 26, 2024 at 09:08:46AM +0000, John Garry wrote:
> Document flag introduced in Linux v6.9
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  man/man2/readv.2 | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/man/man2/readv.2 b/man/man2/readv.2
> index 78232c19f..836612bbe 100644
> --- a/man/man2/readv.2
> +++ b/man/man2/readv.2
> @@ -238,6 +238,26 @@ However, if the
>  .I offset
>  argument is \-1, the current file offset is updated.
>  .TP
> +.BR RWF_NOAPPEND " (since Linux 6.9)"
> +The
> +.BR pwritev2 ()
> +system call does not honor the

The other surrounding paragraphs talk in imperative (e.g., "Do not
wait").  This should be consistent with them.  How about this?:

	Do not honor the O_APPEND open(2) flag.  This flag is meaningful
	only for pwritev2().  ...

Thanks for the patch!

Have a lovely day!
Alex

> +.B O_APPEND
> +.BR open (2)
> +flag.
> +Historically Linux honored
> +.B O_APPEND
> +flag if set and ignored the offset argument, which is a bug.
> +For
> +.BR pwritev2 (),
> +the
> +.I offset
> +argument is honored as expected if
> +.BR RWF_NOAPPEND
> +flag is set, the same as if
> +.B O_APPEND
> +flag were not set.
> +.TP
>  .BR RWF_ATOMIC " (since Linux 6.11)"
>  Requires that
>  writes to regular files in block-based filesystems
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--dpxysf623xg355uw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdFtpgACgkQnowa+77/
2zIFVQ//Ww7fVUap+NnlF/pr0nV8zGeol+ViuwerEJ5Yh/GZrOn5PVI0auKuvRQl
1t+ViaVKnXv2oACv0VawVhkPHT8rvKINmNMiH2/NvmeVzplTbA3pWUQHs2hs4iKM
L0pMp41kZwZKsOU7HqHLdet2dvu8+08AyUyT0xxdq3Vs0ColZMYcymeaCu26LneT
A9AyGq8OgK0DpEwEnSi3qa5oF/799flWHsu9DAvarAb6UvFxj/it5w54MWqaPUc4
IvjxLSb46jv4Y6KeocXamf8pQrlhCzE7Zi3rqacvDKdb+4lYhos0WnxiYE4CmeN5
160i12tzgn7JFf3xzb/47RxHnts4GCpQ2xljNz+q+ROBoBI1zTMksKEEb0APQE3I
gep7HrbH/slWyRRNwXJH3hhMPIoMdErU+6d/Syp6Bnx1hMuz12xSIkgzHFqgwukp
/J0Xu+rHXVYssD1QJN27+84+hBYQZ3c1qOrvJle/C4V2cVop455TJtOmEj+DS1fF
W628uvU5Mtq+zCUhHijnqP7KOWvERhWAqim7ybfGJwZIfMFXeLUdxocHxnq2LU3+
oGvtt4KZ+1Nd9Kpmu/vz/x+OvCxqcpGQUu5feqnC4hvR2pUcdx1wwRb7P8eSd/ge
LPPun8WHyERBEaSTC0/jA10veso8ZV6yXWNBtLLmAAeEKf3FCIg=
=/Rd3
-----END PGP SIGNATURE-----

--dpxysf623xg355uw--

