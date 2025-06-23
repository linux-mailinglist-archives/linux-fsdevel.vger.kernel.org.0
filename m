Return-Path: <linux-fsdevel+bounces-52429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC70AE3335
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 02:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC79F3AFEA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 00:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8CEBA2D;
	Mon, 23 Jun 2025 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlqEl02E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764571853;
	Mon, 23 Jun 2025 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750640360; cv=none; b=oKyyBvCh6i/qBmkReYxr0MNwiin64ilSmQZYYbFyliZYiyIdsaaDNa/H32g1SjrjALaAMyyF/3SliBVgLFDV35Cek4+3I+cIOx8FaHpRi1dNSAOiyGd1HIUU4fEcQPxmLxEYFfcOT7F+HFH91X2kE5uKF6frRtPNE+8oeTccGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750640360; c=relaxed/simple;
	bh=TW30CT8o4JIzUuqKpt7//Nvk1jL8VGRaEJcaEPW34ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9j3nM2AVv5S1peSgs1Zg7a8DMs3+zhFRlKp8j/VrbMQkCHKUUIdMUIpBq0Iu+OybFsqEkdyt36wWLriBKs8BbHI67DVb3zSm+QFHG0gjPOLEiT/+QNcJrDLnP1M10cmGSWKGEAvM/nrXs6VxSIo58hs5gFHSls+GLYUbbS+d8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlqEl02E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18147C4CEE3;
	Mon, 23 Jun 2025 00:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750640358;
	bh=TW30CT8o4JIzUuqKpt7//Nvk1jL8VGRaEJcaEPW34ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlqEl02EuEdTfvHG6k63JUn7UXZiX0AYmb25RgK9WIndQdeLicpqE4LPkCRN00soJ
	 ruydlzhlb/xKwYDizVb0ZiJjXNDbZ0cYCFMXjLtUA95RvbAPPCi8SXYpR3cbkWK/8/
	 nTFKQSy06nEyVqTj3KGfVFyyCVS9q2Zwwk6eleiTMTgM4eNFPZxhMhdKd0kkqci6Hv
	 7zvCPQK8Y22kDl1Da3d34/L8OPSzufsTRh4n36frTl11T2TV2qYqkx2v5GKC/8nEWZ
	 GKoW9f6UHiOggrfZ6OgmHj01duaZibcvHr2n8NxuqiyXiAuBedgRLqpWZ3WtEvh3SD
	 fawfSGpRJb5fg==
Date: Mon, 23 Jun 2025 02:59:10 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] statx.2: Add stx_atomic_write_unit_max_opt
Message-ID: <yf45fs54p6wjoys2jsk2ji6bmh23on5exfpqdvyv3hzc6nymwx@brtt457ustsb>
References: <20250619154455.321848-1-john.g.garry@oracle.com>
 <20250619154455.321848-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3j3zysi3igkp4pl"
Content-Disposition: inline
In-Reply-To: <20250619154455.321848-3-john.g.garry@oracle.com>


--h3j3zysi3igkp4pl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] statx.2: Add stx_atomic_write_unit_max_opt
References: <20250619154455.321848-1-john.g.garry@oracle.com>
 <20250619154455.321848-3-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20250619154455.321848-3-john.g.garry@oracle.com>

Hi John,

On Thu, Jun 19, 2025 at 03:44:55PM +0000, John Garry wrote:
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
> already-existing members, so mention that a value of 0 in
> stx_atomic_write_unit_max_opt means that stx_atomic_write_unit_max holds
> this optimised limit.
>=20
> Linux will zero unused statx members, so stx_atomic_write_unit_max_opt
> will always hold 0 for older kernel versions which do not support
> this FS-based atomic write method (for XFS).
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Thanks!  Patch applied.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D6dd3ceed42a94815ae41f0a7ec2e946a12a8f4be>


Cheers,
Alex

> ---
>  man/man2/statx.2 | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index 273d80711..07ac60b3c 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -74,6 +74,9 @@ struct statx {
>  \&
>      /* File offset alignment for direct I/O reads */
>      __u32 stx_dio_read_offset_align;
> +\&
> +    /* Direct I/O atomic write max opt limit */
> +    __u32 stx_atomic_write_unit_max_opt;
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
> @@ -514,6 +518,21 @@ is supported on block devices since Linux 6.11.
>  The support on regular files varies by filesystem;
>  it is supported by xfs and ext4 since Linux 6.13.
>  .TP
> +.I stx_atomic_write_unit_max_opt
> +The maximum size (in bytes) which is
> +optimised for writes issued with torn-write protection.
> +If non-zero,
> +this value will not exceed the value in
> +.I stx_atomic_write_unit_max
> +and will not be less than the value in
> +.IR stx_atomic_write_unit_min .
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

--h3j3zysi3igkp4pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhYpt0ACgkQ64mZXMKQ
wqk8SBAAuSDQ/vHTAd9DhazHb94Z/ObZJ0zikGIP9Eh0dAsJNbHduGzgpE7f0HTo
NYDSSRGZRgbutAxNXectURamO2VNxjJ2kdnrY3DmT2bD65IoiYKTaztk95e6ju0E
4JsEP4A0mPTSBGrSYyDBqAaSZHJGbnrE27cicnoK8g7PtmoxyFMsNtEGP0b6EEMP
hwveN4wJ/JeYwQSmFU51CH6Lp2MP4eU+gNZ9IwmlkRwqGYAQPTLxHlnN2eg+6cBO
JR9RCPtnK9vtANLoCy+UCfsXT5XLFOsn2lvDx1ur2mbgFJyx/rnNXvui2W3R0I89
NYNvESBu8ATVB72H7uJ7ONG8ShZvZuK8F7UYMPRfdTxu4VcrWO8Br6MWhObl/wx4
OrM2YSbSgTeizW47i05c7ZIeuu/T0RiPHzJoVwcKoDDMSiHkmQON8TVzFdIMn0S6
Z/hK9Ppuhyo2JQE7Q/Xk1UsabnYGrs1fJBmRjh8BxGuTBBPWZNVoDzqeRYg1Q9fh
f/e0r+VIGxfce5jab7igdGUmmqxY5NJOtAxugE0zAiFfnwUQMfw4P7rS7ma/zuj7
4x4rcHY0YlJCOdCXsz7LelmY49kbrlvEH0l9liBO1rht7dUdEVDLxS002tODuwPX
NipbvkQAIAkeWaCqy+B9RmaqST53tBQP8fSBf4wUWRpGXDiSy8g=
=WxJL
-----END PGP SIGNATURE-----

--h3j3zysi3igkp4pl--

