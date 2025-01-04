Return-Path: <linux-fsdevel+bounces-38395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA26A016BF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 21:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADDB3A3B9E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 20:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F441C1AAA;
	Sat,  4 Jan 2025 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlJ65DFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD128377;
	Sat,  4 Jan 2025 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736023017; cv=none; b=XZtBO4BZg+0q7gm4/+lhceV5izrq/hcundOWeHwZ5GpVTwPtO2ngs8Yg6JP0Slrd1VrF9mmIVBWaisBQcaPxkgk/6oday6XLYPxxJHJHOM/XxWhxBGC4sTe1lJZYhMosqxlsSFrJy0cA9pGUmXKV1htDtszQVWoIQ5SjZu7bPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736023017; c=relaxed/simple;
	bh=/RMNgqpwIu/nD7Yk1K3S5jPkpNnDHSYwILmmPuLsHLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igauuBWAOf6uq0Xil2TXgg50h17koRKJNFt8hKxHfxuers/DiKMHQuNtMduUbCXPwgWyydK+el2MZ+sUdPIX9nDNZTkRodBEa1syLyGL1ruBsRz+2hZb03eHEbf4rA2sG7iquCsB4BCopxh81QiUq80/j/0759eDh0XxN4hvl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlJ65DFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C239C4CED1;
	Sat,  4 Jan 2025 20:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736023017;
	bh=/RMNgqpwIu/nD7Yk1K3S5jPkpNnDHSYwILmmPuLsHLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlJ65DFNPVS6gpJmLx/RG2m7yrJ10QDJKVGJK6hUi1H3+rRH3HYpUPROKilKct6Wx
	 8HTErU+kfP5ro/2M06AU0JFPSj4w8h3X1eCnc2yvJNttU4ukcACwnt2PB/u5vUSCED
	 SEiGRu6bf+5QcvT8xpFtbQaVyAZFrcSR1OsBqQ+2j1rCdkYeRvdaVTHmJEF6WqhA3/
	 kEbpl4TKxJcll0I/oFEbFNmuOQvFgqbNB3m2ohKs2/9PpIdi4QY0RUGpYB+66OcG3j
	 tHUHG16qX7nouGd3NaQtA1lK97kMU5KMpz15r5pEOySynVfmRqEHpgrqg2IokZun8v
	 fHYSn4ojGUgvg==
Date: Sat, 4 Jan 2025 21:36:56 +0100
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	dalias@libc.org, brauner@kernel.org
Subject: Re: [PATCH 2/2] io_submit.2: Document RWF_NOAPPEND flag
Message-ID: <nflhswam4ohkepaim2g2r3vspmvnkm3jytknjljf6oukdglztc@phkl335ceelb>
References: <20241126090847.297371-1-john.g.garry@oracle.com>
 <20241126090847.297371-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zr6jkobcxtl6qelc"
Content-Disposition: inline
In-Reply-To: <20241126090847.297371-3-john.g.garry@oracle.com>


--zr6jkobcxtl6qelc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	dalias@libc.org, brauner@kernel.org
Subject: Re: [PATCH 2/2] io_submit.2: Document RWF_NOAPPEND flag
References: <20241126090847.297371-1-john.g.garry@oracle.com>
 <20241126090847.297371-3-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20241126090847.297371-3-john.g.garry@oracle.com>

Hi John,

On Tue, Nov 26, 2024 at 09:08:47AM +0000, John Garry wrote:
> Document flag introduced in Linux v6.9
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>

I've applied this patch.  Thanks!
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D58dcfdd953c1546cb6aea81c2209d6bb076dc246>

Cheers,
Alex

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
> +.TP
>  .BR RWF_ATOMIC " (since Linux 6.11)"
>  Write a block of data such that
>  a write will never be torn from power fail or similar.
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--zr6jkobcxtl6qelc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmd5m+gACgkQnowa+77/
2zJPhw/+K9uCm3aip3EYLgCkqyIBdr4SyCmeNOlfFFempTGgGZhqUfgDPmyWUphF
VHwdInDT0iZbD+JkU50VMLTbzmOkMBRlZf0px1HYiat6mBkmYTSiLH4TC4N3y9zd
yIN0FVAvYj88CRUu46WIPXKp48pljoCCb2Fd+yxBCC05ShfBKPWPGxda8RiYMa8K
41png5xEytROpqSQRoS/QA462PJ/EyCN+PrtXu4f+FTRbGkWvWwYcw5p1DYmKyDc
V7w5xf9/Kk7vaLNK97BlCquK/56xGlPQx0cScdCeLpBMoG8j4G6pv1OhIWU8JuSp
ywoKb7vmDe4HwmHHaFBW+CDrrbs8FIDpa0DccbEVJf4lpEACnzmmCzkzYmkaHyE/
SvqwXriqM2QiqtvGC7NB3PTq2/jpncSLTm4MzXMFjSu9IaCvFVvAtKYD1pU+rHXR
IOYfriBiU2zLhcSQrNaZm4jDkL+9wg1E8pvmY7ZxPsR0SZddleJFRdRzjkJMNdi0
rXwvZ1dCuR85ocWx+HjCtlx11S89UBqcdW6lJph4PaVhr9gu0lKpqJ//2soPQRSk
FQh962mXbkS/TdR253UJSSKiS/VUDHh0vD9aMnjtRlbi7t9TK0WlcMAlSOOqiB/H
X2wKaWwrg0NGZHYhIrOeM9rK+tpUw1331jy/3jQetOw3/KGW0MM=
=UEuN
-----END PGP SIGNATURE-----

--zr6jkobcxtl6qelc--

