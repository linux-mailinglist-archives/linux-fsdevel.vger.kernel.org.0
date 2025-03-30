Return-Path: <linux-fsdevel+bounces-45304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC22A75B99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 19:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B243A9348
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7911DDA17;
	Sun, 30 Mar 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sj5Fx6cL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73D17CA1B;
	Sun, 30 Mar 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743357399; cv=none; b=qb726DiQ7GpieeFkzGMwzc4Gn870zl1kyGvYGwOOkk90L6oADA9zgJdE36u7oqutXABeCa6uATSHBgsTSE8AxAckqlJaTXVManIrS2/ZFcod+sUh+vhYrVYQjCl6/w7nijMivdvAJcb8YoqNlVKpQxasDD+0za/v/rbS1iBedQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743357399; c=relaxed/simple;
	bh=7FUVFLvjoO3abDa9TCYrNumtZmwOQ15p1qfdPeDOtMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6UVVgt6JLQlRI84ZrNkegHUvcgacQqV8UrGuhiJ1s69bJmjjV2JNg2P08gA8W2NuLW/wtLROt3SAtzodG0pAFC9f2PBoeqcZ/e/clBeU6sry+5t3zo/yzytzq2BE2xZ2Pk4HnxNCU7PkGmsmnZF5Ijtla1n00vFvhd+9Ob4hUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sj5Fx6cL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E59C4CEDD;
	Sun, 30 Mar 2025 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743357399;
	bh=7FUVFLvjoO3abDa9TCYrNumtZmwOQ15p1qfdPeDOtMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sj5Fx6cLSMGDBgf5Ocu5dr4ucvhbi/KAsLBV7yozCV8oiL9tioi/fbS30ivCgeYS1
	 on625DAqldDgZUzLfcpnN82IdidO+1vS05ERzu6T1U8Cow/5Z7ObPOkqBq5WK4W8JY
	 cEuSPhiXLSICC54qZ8b9IcwHGOyxhVmGaxI0OClVYf4cNkITK8jSMklaDArclAxnXa
	 k/xMLpZjN4j97jJaMf82EVtYZGqUvqiFekudls08KQ3JnJIxRN2tPyAfGBF+xCkbza
	 lb/uyj66Vou+0wYhHsR/MOMhqlAN6x5TTR7YY0SEKg5hIuh9AHZNDa7WpaiKGHlzWg
	 0EU0X0vimzlJg==
Date: Sun, 30 Mar 2025 19:56:35 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@poochiereds.net>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2] name_to_handle_at.2: Document the
 AT_HANDLE_CONNECTABLE flag
Message-ID: <mu6nhfyv77ptgvsvr6n23dc5if3sr6ymjmv3bq7bfnvcas66nu@b7nrofzezhil>
References: <20250330163502.1415011-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="evceypjn7ghavqfu"
Content-Disposition: inline
In-Reply-To: <20250330163502.1415011-1-amir73il@gmail.com>


--evceypjn7ghavqfu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@poochiereds.net>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2] name_to_handle_at.2: Document the
 AT_HANDLE_CONNECTABLE flag
References: <20250330163502.1415011-1-amir73il@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250330163502.1415011-1-amir73il@gmail.com>

Hi Amir,

On Sun, Mar 30, 2025 at 06:35:02PM +0200, Amir Goldstein wrote:
> A flag since v6.13 to indicate that the requested file_handle is
> intended to be used for open_by_handle_at(2) to obtain an open file
> with a known path.
>=20
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@poochiereds.net>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>=20
> Alejandro,
>=20
> Addressed your comments from v1 and added missing documentation for
> AT_HANDLE_MNT_ID_UNIQUE from v6.12.

Please split AT_HANDLE_MNT_ID_UNIQUE into a separate patch, possibly in
the same patch set.  Other than that, it LGTM.  Thanks!


Cheers,
Alex

>=20
> Thanks,
> Amir.
>=20
>  man/man2/open_by_handle_at.2 | 46 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man2/open_by_handle_at.2 b/man/man2/open_by_handle_at.2
> index 6b9758d42..10af60a76 100644
> --- a/man/man2/open_by_handle_at.2
> +++ b/man/man2/open_by_handle_at.2
> @@ -127,6 +127,7 @@ The
>  .I flags
>  argument is a bit mask constructed by ORing together zero or more of
>  .BR AT_HANDLE_FID ,
> +.BR AT_HANDLE_CONNECTABLE,
>  .BR AT_EMPTY_PATH ,
>  and
>  .BR AT_SYMLINK_FOLLOW ,
> @@ -147,6 +148,44 @@ with the returned
>  .I file_handle
>  may fail.
>  .P
> +When
> +.I flags
> +contain the
> +.BR AT_HANDLE_MNT_ID_UNIQUE " (since Linux 6.12)"
> +.\" commit 4356d575ef0f39a3e8e0ce0c40d84ce900ac3b61
> +flag, the caller indicates that the size of the
> +.I mount_id
> +buffer is at least 64bit
> +and then the mount id returned in that buffer
> +is the unique mount id as the one returned by
> +.BR statx (2)
> +with the
> +.BR STATX_MNT_ID_UNIQUE
> +flag.
> +.P
> +When
> +.I flags
> +contain the
> +.BR AT_HANDLE_CONNECTABLE " (since Linux 6.13)"
> +.\" commit a20853ab8296d4a8754482cb5e9adde8ab426a25
> +flag, the caller indicates that the returned
> +.I file_handle
> +is needed to open a file with known path later,
> +so it should be expected that a subsequent call to
> +.BR open_by_handle_at ()
> +with the returned
> +.I file_handle
> +may fail if the file was moved,
> +but otherwise,
> +the path of the opened file is expected to be visible
> +from the
> +.IR /proc/ pid /fd/ *
> +magic link.
> +This flag can not be used in combination with the flags
> +.B AT_HANDLE_FID
> +and/or
> +.BR AT_EMPTY_PATH .
> +.P
>  Together, the
>  .I pathname
>  and
> @@ -311,7 +350,7 @@ points outside your accessible address space.
>  .TP
>  .B EINVAL
>  .I flags
> -includes an invalid bit value.
> +includes an invalid bit value or an invalid bit combination.
>  .TP
>  .B EINVAL
>  .I handle\->handle_bytes
> @@ -398,6 +437,11 @@ was acquired using the
>  .B AT_HANDLE_FID
>  flag and the filesystem does not support
>  .BR open_by_handle_at ().
> +This error can also occur if the
> +.I handle
> +was acquired using the
> +.B AT_HANDLE_CONNECTABLE
> +flag and the file was moved to a different parent.
>  .SH VERSIONS
>  FreeBSD has a broadly similar pair of system calls in the form of
>  .BR getfh ()
> --=20
> 2.34.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--evceypjn7ghavqfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfphdIACgkQ64mZXMKQ
wqnD6xAAqF9nG244sIPmAz0+Gu/kzzBOFb2JiLrGAx5p7VTB6t3ONr8XBK1vaJgi
ssfqZsuSvIIeniNTwk3GO5QcpztCUEUHYIVmFP7mehCyDM6u3cRta4LQl/+ek9O7
CTbEm9iOGmiXYU6aSenKYZ5Y92WnG5ciZVfnSWSdqJcb2evfOp9X2Ts0R4dBA0Xc
OvG8Pe3wJNphnU3dEYuANpEcqNAhmgTE9ekuwoDFAn8kEgOpgUDIIqfft39wp81V
5Uyf5FYhKyx+hibs2hDmQMdyT1n285xk/CbNH7J8M+TjXfNv8JeA/QtA9mD7WrLG
QL3ZaLO9zNXCbQcPulJ9Vogiuo2i6KKxlFGvoNNuNIQT0xRYXhiXoSBjJToOFeXn
QBEmlp2hjho+i62qSdjMjWzA4hV6ClOnLkm3Dc7C/VrRuRm6Ymg19qBe/CH1XjgJ
dy+SgLckBKnp/YXpYRoY02dtHY4qn5eAI/ndYFMKGwSyVGeLi7veE0aaEp0L1W/L
CsVN0J1+N0DPcKazuwxb/enUzHuwURStw69ECoJTAq14coxuDij/xDU6FpgUQG+T
bxiiPwXYVdNuQ5oft9ehwTs+dWKIirvZBg4fJ4sdOLSsWKi27Sx4OyAl1v/ZUgSv
wK/7hcc+LpMimRyE/PcHbn1mob1PadakA5doQsyKuKfTEqF6ick=
=SfgP
-----END PGP SIGNATURE-----

--evceypjn7ghavqfu--

