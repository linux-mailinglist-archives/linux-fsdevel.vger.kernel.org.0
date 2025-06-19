Return-Path: <linux-fsdevel+bounces-52206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B51AE0313
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF41F3ACA0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F072264C2;
	Thu, 19 Jun 2025 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1Eiu0no"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1458221FB5;
	Thu, 19 Jun 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750331144; cv=none; b=jM8yS4Eo6XC7gLX26BJpALde9lEv2EBJ1IsfcA8QG3wXONeDlg/Xi1ulzw64khqmA4zJ460Y4SrQtpNLdY1xlhJQxjuNPigtxQR7RExX8WI+nTTZWqMhh9/pvM41hSLqi8O3zhMe654Dod7FsCmBwIs4QM0d7S22rF1filSS6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750331144; c=relaxed/simple;
	bh=P5G0GKZeMdKwU8+KZLXBTlpUtLJy/08vDne9MSkvEwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQbePi9XtjgXDjNbju+UA1KI6XCAa1VjxztiL5aent9idjZ/rGUFJFg3eDH8i2TJN3Fn53EH3xnZ/xg1v73EhmL7nfqPHQ5sTAdsD/SHJWsPt3MlxSm8/I7+Ye8EqCvswmERVJCqLXekEydRrbav1lxNSZ4poptHvfrudC//jBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1Eiu0no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DB5C4CEEA;
	Thu, 19 Jun 2025 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750331141;
	bh=P5G0GKZeMdKwU8+KZLXBTlpUtLJy/08vDne9MSkvEwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1Eiu0noL8AwGuJY9Eb/OKyEPKs6wHlgQXhcZxPMlU/jAt/lnWngZYF/la3h+xrGY
	 3BpWETKdylmh60btlkFkJJEv97VLHHjPJxx315jOO8a5+49VeiBffsDh/LN4299M0Y
	 lfFDzHjErzIXaimjs82PqmbepGUfVe/jvQc0GuUtdVZSDv4PFwefx5zp1/nF2uTAsm
	 IpIF4JIv9qAcXsLRZdTxm7a/1ixAUUmNJNSq74F2tPIFr00HfTrFqvb067khNfhG6E
	 uTwe5y3LxVsjlS8XehLW8LRkeWMEsw8TATZii0LOIuPcSU9taGHdfisGBcS58uuSgY
	 DCX6ZJPUdRBDQ==
Date: Thu, 19 Jun 2025 13:05:30 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] statx.2: Add stx_atomic_write_unit_max_opt
Message-ID: <7ret5bl5nbtolpdu2muaoeaheu6klrrfm2pvp3vkdfvfw7jxbr@zwsz2dpx7vxz>
References: <20250619090510.229114-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hlpaxlv3mtoztp6n"
Content-Disposition: inline
In-Reply-To: <20250619090510.229114-1-john.g.garry@oracle.com>


--hlpaxlv3mtoztp6n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] statx.2: Add stx_atomic_write_unit_max_opt
References: <20250619090510.229114-1-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20250619090510.229114-1-john.g.garry@oracle.com>

Hi John,

On Thu, Jun 19, 2025 at 09:05:10AM +0000, John Garry wrote:
> XFS supports atomic writes - or untorn writes - based on two different
> methods:
> - HW offload in the disk
> - FS method based on out-of-place writes
>=20
> The value reported in stx_atomic_write_unit_max will be the max size of t=
he
> FS-based method.
>=20
> The max atomic write unit size of the FS-based atomic writes will
> typically be much larger than what is capable from the HW offload. Howeve=
r,
> FS-based atomic writes will also be typically much slower.
>=20
> Advertise this HW offload size limit to the user in a new statx member,
> stx_atomic_write_unit_max_opt.
>=20
> We want STATX_WRITE_ATOMIC to get this new member in addition to the
> already-existing members, so mention that a value of 0 means that
> stx_atomic_write_unit_max holds this optimised limit.

Please say a "a value of 0 *in stx_atomic_write_unit_max_opt* means
that ...", to clarify.

> Linux will zero unused statx members, so stx_atomic_write_unit_max_opt
> will always hold 0 for older kernel versions which do not support
> this FS-based atomic write method (for XFS).
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> Differences to RFC (v1):
> - general rewrite
> - mention that linux zeroes unused statx fields
>=20
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index ef7dbbcf9..29400d055 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -74,6 +74,9 @@ struct statx {
>  \&
>      /* File offset alignment for direct I/O reads */
>      __u32   stx_dio_read_offset_align;
> +\&
> +    /* Direct I/O atomic write max opt limit */
> +    __u32 stx_atomic_write_unit_max_opt;

Please align the member with the one above.

>  };
>  .EE
>  .in
> @@ -266,7 +269,8 @@ STATX_SUBVOL	Want stx_subvol
>  	(since Linux 6.10; support varies by filesystem)
>  STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min,
>  	stx_atomic_write_unit_max,
> -	and stx_atomic_write_segments_max.
> +	stx_atomic_write_segments_max,
> +	and stx_atomic_write_unit_max_opt.
>  	(since Linux 6.11; support varies by filesystem)
>  STATX_DIO_READ_ALIGN	Want stx_dio_read_offset_align.
>  	(since Linux 6.14; support varies by filesystem)
> @@ -514,6 +518,20 @@ is supported on block devices since Linux 6.11.
>  The support on regular files varies by filesystem;
>  it is supported by xfs and ext4 since Linux 6.13.
>  .TP
> +.I stx_atomic_write_unit_max_opt
> +The maximum size (in bytes) which is optimised for writes issued with
> +torn-write protection.

Please break the line before 'optimized' and remove the current line
break.

> +If non-zero, this value will not exceed the value in

Please break the line after ','.

> +.I stx_atomic_write_unit_max
> +and will not be less than the value in
> +.I stx_atomic_write_unit_min.

This should be IR, and the '.' separated by a space, so that the '.' is
not in italics.


Have a lovely day!
Alex

> +A value of zero indicates that
> +.I stx_atomic_write_unit_max
> +is the optimised limit.
> +Slower writes may be experienced when the size of the write exceeds
> +.I stx_atomic_write_unit_max_opt
> +(when non-zero).
> +.TP
>  .I stx_atomic_write_segments_max
>  The maximum number of elements in an array of vectors
>  for a write with torn-write protection enabled.
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--hlpaxlv3mtoztp6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhT7vMACgkQ64mZXMKQ
wqnuVBAAgoPmOQzNRqsRdHZja+VBk7yJZPHH9IzpUEYKm87MW/L4FcP7wcYTbL8X
KDkHmAdySKlJXBH01GLJ/lbVAzBxzcigpz7xWBmer6tPTF2irohmm8rBRx265ZdA
wDdLo2bxFo175wxwx0ZY7lEWG/M4bfWpJPt7PXqFucgVehoRT4Ae/nVwdxkctN4x
/ZPI+9esP7zKVNPxAr2Gu3RU/FjcrVo9AZXRpqYITg4sY8kGP14790rC1F6zM5ay
qc4ADd4vUxRfp+1EVWl3sJ6NoxpTbS2nT40j3jlhLIxSH3PhvlladbxZpapDxRiK
jmc6CXW6q4XbMoqzsK6lddcTKrBUZouO2AoBuWESizoqufp11mDl6q3DiMwH2a61
i/4Q1/hRtzCQHu7JqCzshH4s34plL3UxeZjPIXMyPdJBie6sRaP63qvUXjNukX4Q
ex43F88VlsqyUqwF93WUSM5W+F69BYFy8EDtPAQMikw2Cetd+LyCjVdWdwyhLlSV
sgVmufZ5kwvnIWBxfgv3EU9QFPw+l2PRqeePCtnRMty04MvXsjqmdWfrdUXKrdto
2y7gLjrFHq51qye1NPVA4d/EaF4ib6ZecNvefDsG1pdjIr5C3YaecSa2ipwT0O3V
xJ33lOp3hVGkyd0MAuMk5nBmgLcFBCO0KJmLMuo2bXvNVCtoNBA=
=3Qpk
-----END PGP SIGNATURE-----

--hlpaxlv3mtoztp6n--

