Return-Path: <linux-fsdevel+bounces-45559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18289A796F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 22:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21E77A24EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAC91F3B82;
	Wed,  2 Apr 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpEz5LSe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710E193436;
	Wed,  2 Apr 2025 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627502; cv=none; b=rDRDQp2gDdUyv3bPHsgMsjfpC8HegGV7o9S366v/0Ns5/ekTTh44jjz9qjh/6xyCIEmM3i5TFNFlyjoVFgWtORtQ/prRGT4SkFo7vB0IDG8nXcaC/KgiVMGUX3J5yllNW8XLdLGuNEY2nrGohObG/myroQfOMOhcrZa5JOe16Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627502; c=relaxed/simple;
	bh=LS8lzPuSVwy6U6TgTLTTjZjd5YvFHYJurAtikdh5Zf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ27StBbbtjF3JRLx/gevjbkD8Xmzh4s2Dhf5cpL9mKz/HLDcpk/FHsPKFGDdGHSUkLzIupSx5GMdTJ5y1hweZBIz2JGSFuXnK/Wjm7Jg3wSLhEHCMYUbhzWBq5QVgqXCXPUBXwv4gqeH0v6VIboimTHi5cPPfR8PrJAx0J1Z0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpEz5LSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393F8C4CEDD;
	Wed,  2 Apr 2025 20:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743627501;
	bh=LS8lzPuSVwy6U6TgTLTTjZjd5YvFHYJurAtikdh5Zf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpEz5LSe3zK2P1+s3bvr9He6kGU8WGtTbJuycJ6AFl4Vw8xQTWpKq+KjR3g0FxIQh
	 hGfQa71VfING6ReA23S/t2vkVlO4zhCSBe8SHUBDnGJubJyLlBc9Q8/d18tklah8uE
	 z8Cul559z+Xf2nt9jQX7gK7x5c5ezXrtQH9E4dtne7SnsmH0OjtwDmz8oNAg2dMUpt
	 +mPYZ/2MZNIiYtVGaQpA4V8rD7eKzEQlqN09g3PHgwmadQORGAq75qakd1LXEbqwG3
	 tnKIVRb3x3+tFwkm8yv4Soin7XZDm0obSvLtsNd7hX66wV3YLFUMaCesl+fgkVSVQW
	 ybwX3W2wDwCrA==
Date: Wed, 2 Apr 2025 22:58:17 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: Document FAN_PRE_ACCESS event
Message-ID: <de54ad3do3vz3mi7swdojhwzrpssxk6rzqrfzlrmjaxz4pud6r@ha64lyrespvy>
References: <20250330125536.1408939-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2wrlxfpkdvy6jait"
Content-Disposition: inline
In-Reply-To: <20250330125536.1408939-1-amir73il@gmail.com>


--2wrlxfpkdvy6jait
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: Document FAN_PRE_ACCESS event
References: <20250330125536.1408939-1-amir73il@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250330125536.1408939-1-amir73il@gmail.com>

Hi Amir,

On Sun, Mar 30, 2025 at 02:55:36PM +0200, Amir Goldstein wrote:
> The new FAN_PRE_ACCESS events are created before access to a file range,
> to provides an opportunity for the event listener to modify the content
> of the object before the user can accesss it.
>=20
> Those events are available for group in class FAN_CLASS_PRE_CONTENT
> They are reported with FAN_EVENT_INFO_TYPE_RANGE info record.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  man/man2/fanotify_init.2 |  4 ++--
>  man/man2/fanotify_mark.2 | 14 +++++++++++++
>  man/man7/fanotify.7      | 43 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 57 insertions(+), 4 deletions(-)
>=20
> diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> index 23fbe126f..b1ef8018c 100644
> --- a/man/man2/fanotify_init.2
> +++ b/man/man2/fanotify_init.2
> @@ -57,8 +57,8 @@ Only one of the following notification classes may be s=
pecified in
>  .B FAN_CLASS_PRE_CONTENT
>  This value allows the receipt of events notifying that a file has been
>  accessed and events for permission decisions if a file may be accessed.
> -It is intended for event listeners that need to access files before they
> -contain their final data.
> +It is intended for event listeners that may need to write data to files
> +before their final data can be accessed.
>  This notification class might be used by hierarchical storage managers,
>  for example.
>  Use of this flag requires the
> diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> index 47cafb21c..edbcdc592 100644
> --- a/man/man2/fanotify_mark.2
> +++ b/man/man2/fanotify_mark.2
> @@ -445,6 +445,20 @@ or
>  .B FAN_CLASS_CONTENT
>  is required.
>  .TP
> +.BR FAN_PRE_ACCESS " (since Linux 6.14)"
> +.\" commit 4f8afa33817a6420398d1c177c6e220a05081f51
> +Create an event before read or write access to a file range,
> +that provides an opportunity for the event listener
> +to modify the content of the file
> +before access to the content
> +in the specified range.
> +An additional information record of type
> +.B FAN_EVENT_INFO_TYPE_RANGE
> +is returned for each event in the read buffer.
> +An fanotify file descriptor created with
> +.B FAN_CLASS_PRE_CONTENT
> +is required.
> +.TP
>  .B FAN_ONDIR
>  Create events for directories\[em]for example, when
>  .BR opendir (3),
> diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> index 7844f52f6..6f3a9496e 100644
> --- a/man/man7/fanotify.7
> +++ b/man/man7/fanotify.7
> @@ -247,6 +247,26 @@ struct fanotify_event_info_error {
>  .EE
>  .in
>  .P
> +In case of
> +.B FAN_PRE_ACCESS
> +events,
> +an additional information record describing the access range
> +is returned alongside the generic
> +.I fanotify_event_metadata
> +structure within the read buffer.
> +This structure is defined as follows:
> +.P
> +.in +4n
> +.EX
> +struct fanotify_event_info_range {
> +    struct fanotify_event_info_header hdr;
> +    __u32 pad;
> +    __u64 offset;
> +    __u64 count;
> +};
> +.EE
> +.in
> +.P
>  All information records contain a nested structure of type
>  .IR fanotify_event_info_header .
>  This structure holds meta-information about the information record
> @@ -509,8 +529,9 @@ The value of this field can be set to one of the foll=
owing:
>  .BR FAN_EVENT_INFO_TYPE_FID ,
>  .BR FAN_EVENT_INFO_TYPE_DFID ,
>  .BR FAN_EVENT_INFO_TYPE_DFID_NAME ,
> -or
> -.BR FAN_EVENT_INFO_TYPE_PIDFD .
> +.BR FAN_EVENT_INFO_TYPE_PIDFD ,
> +.BR FAN_EVENT_INFO_TYPE_ERROR ,
> +.BR FAN_EVENT_INFO_TYPE_RANGE .
>  The value set for this field
>  is dependent on the flags that have been supplied to
>  .BR fanotify_init (2).
> @@ -711,6 +732,24 @@ Identifies the type of error that occurred.
>  This is a counter of the number of errors suppressed
>  since the last error was read.
>  .P
> +The fields of the
> +.I fanotify_event_info_range
> +structure are as follows:
> +.TP
> +.I hdr

We should use .hdr here too (and in the fields below, '.' too), right?


Cheers,
Alex

> +This is a structure of type
> +.IR fanotify_event_info_header .
> +The
> +.I info_type
> +field is set to
> +.BR FAN_EVENT_INFO_TYPE_RANGE .
> +.TP
> +.I count
> +The number of bytes being read or written to the file.
> +.TP
> +.I offset
> +The offset from which bytes are read or written to the file.
> +.P
>  The following macros are provided to iterate over a buffer containing
>  fanotify event metadata returned by a
>  .BR read (2)
> --=20
> 2.34.1
>=20

--=20
<https://www.alejandro-colomar.es/>
<https://www.alejandro-colomar.es:8443/>
<http://www.alejandro-colomar.es:8080/>

--2wrlxfpkdvy6jait
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmftpOkACgkQ64mZXMKQ
wqmidhAAiT4GKNxVG6x2KKMPRhXSusiwpH1jGmwC+yeKVvLpK7cH6REeQUUrmBRk
QhdEIQzoLtwubV6QWMm+ahltMfJRVWx52kBCRiHMb1o0xpue4X7XOnb6lsWVPhum
H70bkyHe9MH1UiAASTuNl7yJYM2496rNk9KBYRXr+BgWVv1spU6HCO09v0StYr2l
NPXkdJY0pdYCC2SiOqwPtNqBORTOGPnvQN1PseEV+OP9DqVP+cP/hT4GISoCAz9+
nVbSB370EmOj//0CZSery0GrVomTVt0Skrl9Wz87h1tyHcHnJC6AQ1EG2uRW+ZQ9
bd2vBrWEHAyrVtoJA+WPH6yTKrkMrhFwP+wvncewBoCAdzZUbUCgS+JI/AhLgAXz
iXoehT+woXFXhawG6Y64uwTIfCHosBu0EVS0q/nqmK9HB5ug28KV8O3WdQG0J2OX
9A4VjVzr2chlSCRYxML/TAdpjAebkI7rdRsemKzFIi0u5D9wwa0hX9juH6tuCk8L
hcCdU8XT2w+moa9qmFXs7sTMfMWES4W2/VY6XDl0YkWnY9Dm86FknwWUyMKdlaR4
/SNVjIdS6fk8JsgVjquOPzyQtHzGZUyh7kFSDFM+pKIUWC9fXDfo1Ir7tXQ/13G3
1DcVwWNEWs+4Wz0RSP3lb/CIOkLxk0yxNgD9JDgYgcU2BkT6gkk=
=lx52
-----END PGP SIGNATURE-----

--2wrlxfpkdvy6jait--

