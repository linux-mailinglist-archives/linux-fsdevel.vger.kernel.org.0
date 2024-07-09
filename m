Return-Path: <linux-fsdevel+bounces-23420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA492C1F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E001D29339E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED439185610;
	Tue,  9 Jul 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBzWkgay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51275185609;
	Tue,  9 Jul 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543910; cv=none; b=Q0bkQcunb2zkadPB4PzlNBotH3rD/UkJRrU4psFyyt9alsth9adqccPd8s6gt0gGWFvNBlUbv/e3kFyK0Qx7cV5tL5KgLTfwZojNaW/L+1nsheI7ICIUW+5MmvQ+nhVPm9DWCl5BWY2ex+ni0tqLThHC4I6HyCNWZ+eiKqVSm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543910; c=relaxed/simple;
	bh=N1s+kvz3rs4RQxv5E0yG19F95qh4L5Wd4FsaRQ2ikvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMyZ2aDoHQmuu1TCEqtFlow9CI111GTezDNLMxYyuLakFoYWtQkYQXiccqg/mq2F/OYqMOMl740WCQV6JsvVPNAU/03QXaTPUx6ijdLDqfdnlR3x2GAOhgELxmKSL1u09oyARkLWWLMoeItpFqyp3q6qvTkoz8cE7BHzHwLLKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBzWkgay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22113C3277B;
	Tue,  9 Jul 2024 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720543909;
	bh=N1s+kvz3rs4RQxv5E0yG19F95qh4L5Wd4FsaRQ2ikvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBzWkgay2DRSHLa7AXZC01DZrDtgZvy7NE6j8waq30N+rFwXrGovRQvN3GzRuoUbG
	 20eoFtlJvViUr5jVrQMlz7nSJLjLK0mYbyZEw6H16Ocg0AIHCW2MnoO3ITUqcM4QtL
	 TlptDvR1DJr7ryqhm+bSIt3Lk3WzSEJVO+M4bdADsyHOYGc4/MG+2wkn47p/78Kp75
	 JBf6uGxOWJ0SmWim2v+iTJdVOVxQd/nxqN9IFHETEsRfS3omz3zaoLkDz4Cf2FAcOW
	 hBd0/bCPJDNof+3QqR1m5K0I+a/yBVX16nT6yX7swoGXuMBUW7Jn1gnzHPN25FCUfL
	 yNddkiECFKRtw==
Date: Tue, 9 Jul 2024 18:51:46 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 2/3] readv.2: Document RWF_ATOMIC flag
Message-ID: <epnx2hk2tlpgpadf4duk7du6qy7gvl6tig4j7t2f6ozkqtxftv@72ehsxiuvroj>
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jvprzwgcxrudlnay"
Content-Disposition: inline
In-Reply-To: <20240708114227.211195-3-john.g.garry@oracle.com>


--jvprzwgcxrudlnay
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 2/3] readv.2: Document RWF_ATOMIC flag
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-3-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20240708114227.211195-3-john.g.garry@oracle.com>

Hi John,

On Mon, Jul 08, 2024 at 11:42:26AM GMT, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
>=20
> Add RWF_ATOMIC flag description for pwritev2().
>=20
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> [jpg: complete rewrite]
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  man/man2/readv.2 | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man2/readv.2 b/man/man2/readv.2
> index eecde06dc..78d8305e3 100644
> --- a/man/man2/readv.2
> +++ b/man/man2/readv.2
> @@ -193,6 +193,61 @@ which provides lower latency, but may use additional=
 resources.
>  .B O_DIRECT
>  flag.)
>  .TP
> +.BR RWF_ATOMIC " (since Linux 6.11)"
> +Requires that writes to regular files in block-based filesystems be issu=
ed with
> +torn-write protection. Torn-write protection means that for a power fail=
ure or
> +any other hardware failure, all or none of the data from the write will =
be
> +stored, but never a mix of old and new data. This flag is meaningful onl=
y for
> +.BR pwritev2 (),
> +and its effect applies only to the data range written by the system call.
> +The total write length must be power-of-2 and must be sized between
> +.I stx_atomic_write_unit_min
> + and
> +.I  stx_atomic_write_unit_max
> +, both inclusive. The

We use mathematical notation for ranges:

=2E.. in the range
=2ERI [ stx_atomic_write_unit_min ,
=2EIR stx_atomic_write_unit_max ].

Have a lovely day!
Alex

> +write must be at a naturally-aligned offset within the file with respect=
 to the
> +total write length - for example, a write of length 32KB at a file offse=
t of
> +32KB is permitted, however a write of length 32KB at a file offset of 48=
KB is
> +not permitted. The upper limit of
> +.I iovcnt
> +for
> +.BR pwritev2 ()
> +is in
> +.I stx_atomic_write_segments_max.
> +Torn-write protection only works with
> +.B O_DIRECT
> +flag, i.e. buffered writes are not supported. To guarantee consistency f=
rom
> +the write between a file's in-core state with the storage device,
> +.BR fdatasync (2),
> +or
> +.BR fsync (2),
> +or
> +.BR open (2)
> +and either
> +.B O_SYNC
> +or
> +.B O_DSYNC,
> +or
> +.B pwritev2 ()
> +and either
> +.B RWF_SYNC
> +or
> +.B RWF_DSYNC
> +is required. Flags
> +.B O_SYNC
> +or
> +.B RWF_SYNC
> +provide the strongest guarantees for
> +.BR RWF_ATOMIC,
> +in that all data and also file metadata updates will be persisted for a
> +successfully completed write. Just using either flags
> +.B O_DSYNC
> +or
> +.B RWF_DSYNC
> +means that all data and any file updates will be persisted for a success=
fully
> +completed write. Not using any sync flags means that there
> +is no guarantee that data or filesystem updates are persisted.
> +.TP
>  .BR RWF_SYNC " (since Linux 4.7)"
>  .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
>  Provide a per-write equivalent of the
> @@ -279,10 +334,26 @@ values overflows an
>  .I ssize_t
>  value.
>  .TP
> +.B EINVAL
> + For
> +.BR RWF_ATOMIC
> +set,
> +the combination of the sum of the
> +.I iov_len
> +values and the
> +.I offset
> +value
> +does not comply with the length and offset torn-write protection rules.
> +.TP
>  .B EINVAL
>  The vector count,
>  .IR iovcnt ,
> -is less than zero or greater than the permitted maximum.
> +is less than zero or greater than the permitted maximum. For
> +.BR RWF_ATOMIC
> +set, this maximum is in
> +.I stx_atomic_write_segments_max
> +from
> +.I statx.
>  .TP
>  .B EOPNOTSUPP
>  An unknown flag is specified in \fIflags\fP.
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--jvprzwgcxrudlnay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaNaqEACgkQnowa+77/
2zLGFxAAqIewrU9k3vbS5h26FFg8hBze+gYTeXGpgQAWLXY1HOVrfdP2fTp3EOqg
GdaHuJbd3rVDq3M6lvRhDBA0/buZXBgyAdYrkIv4ZUK2vQMHHQxquyfxcF5uaPNT
2Vxq3X+Bawq6I/jqniXn8xj1VIHVf8I39tCh4bep1Ad0U0R6zovfcFxuOrpHpHhC
k+HfvkX3CmUtyRshHjdemx3ZYLiN1FE1TkDl1eFq3RFEIbMBxUa7oIwQZWRwWele
o2bJTJqj1Vyj1THEFtC2fO63jHpu+qZDj2kkN4QdiFiD+rqlJODohd3wpBqIBrYp
Y7p4OXIN0tgc/G8V6eR9VB7hGn4A8bVDf5DGtPKhiD+NlUKO/1oEGmt9BSE6oxjG
Sue9SfBifISdQHz/Nr5fD2/ghh1uSo7bhMX3+AxEMX2HCph+KZ2nLDnq+ZsmlGGh
Bz0u2Z4rvi4hg3xaDXNPBt1LtEPoedaKV6H8wFalgFSRvLwzlPn2tifkHv30cez4
uAQMXt8FJSfXCMxSCfO1rM2BMqXBiD/fcWL7Js9qfBbX4IwwXL+vpnSnjGa6JQDJ
4tuKsaTkYCfVLVuHCibCRBZ5S1X3BjCTytlEjK00/wFApW7SyJKq8p2dneWceD/y
kUvpkZA6mt/C4WJb3jz6DIAWgbaiEI/zp1KEmlKgfRuuvXyzdwM=
=q75c
-----END PGP SIGNATURE-----

--jvprzwgcxrudlnay--

