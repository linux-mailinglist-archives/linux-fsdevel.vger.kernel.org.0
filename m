Return-Path: <linux-fsdevel+bounces-22762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B718691BD79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 13:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C717B2096B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20C15688D;
	Fri, 28 Jun 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqV3VBjc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A0155A58;
	Fri, 28 Jun 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574297; cv=none; b=mFj35Bsa32nKsuMH82nF4dKkLa6tk0PNwjdDtBTQHa076vdvMhKJ9s+4Sfhp5gBNlnfzDDFB9CH946JSxoslv3ga/28dNDO7UDa2CsM/SAFslG8YgTw6h9z8bVdarqXXgjp9vkdwk19y9PMq1bL3CHuXusKsTp1Gx3aGvQUJDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574297; c=relaxed/simple;
	bh=DQGiKP1Rgd4cmBgyGaT6H/sjY+H4TcgZFYa/FjW9Yp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeliE98A2rzatmuggj4uVBRR9xDBESzngNA0mZwAo9OqMA02AshW+VQqg1KSOhRzrxsctI92F3Q8dR00J0EvxVZY5rmiksmSIO3stANZSXzsx9h5C9dXpZBIAcc4jElWfTTgBzDeTKA+Y24riBK6gzlCqA3cNub8Ysfqz6SO884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqV3VBjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448A8C116B1;
	Fri, 28 Jun 2024 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719574296;
	bh=DQGiKP1Rgd4cmBgyGaT6H/sjY+H4TcgZFYa/FjW9Yp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqV3VBjcKDBnYB3vKvE4LhOXvtFs5FshHVWoE1faHexcG2lOzgy79bbOlL5NeVTvy
	 DCWz03T7Li0/YwCWHlWtKkJfkZSxaz2XOtqLKtIvG32dSCYMHov4dJYbnWsZdPB2WX
	 s+aVWBIxkkSTXpI2dgr/JhxPXErVvXFpWUFvHhHA6x6dK/obBemU4XcQBGZ99gcS9b
	 h51TGS8qqKICouLKssVdbaTt0g2uDo2pIf0b3Bh6trNboNffqfxbtwPS8ZpSOqj1cn
	 nBl8FlQWLEeDcJ1cEOFOENj3ExFJeAHn02SqwuUkmAVCTMtIcvMb0nQGetDZR+GzFh
	 w8SOgmYIIRIQA==
Date: Fri, 28 Jun 2024 13:31:33 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: kent.overstreet@linux.dev, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v2] statx.2: Document STATX_SUBVOL
Message-ID: <5ista6w4cre2odwdwfm76zphnhho5r6br3ahvbawus7f437ueo@k2q7azf7daq3>
References: <20240620130017.2686511-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcltyjurxel5b3jg"
Content-Disposition: inline
In-Reply-To: <20240620130017.2686511-1-john.g.garry@oracle.com>


--pcltyjurxel5b3jg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: kent.overstreet@linux.dev, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v2] statx.2: Document STATX_SUBVOL
References: <20240620130017.2686511-1-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20240620130017.2686511-1-john.g.garry@oracle.com>

Hi Kent, John,

On Thu, Jun 20, 2024 at 01:00:17PM GMT, John Garry wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
>=20
> Document the new statx.stx_subvol field.
>=20
> This would be clearer if we had a proper API for walking subvolumes that
> we could refer to, but that's still coming.
>=20
> Link: https://lore.kernel.org/linux-fsdevel/20240308022914.196982-1-kent.=
overstreet@linux.dev/
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> [jpg: mention supported FSes and formatting improvements]
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Patch applied.  Thanks!

Have a lovely day!
Alex

> ---
> I am just sending a new version as I want to post more statx updates
> which are newer than stx_subvol.
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index 0dcf7e20b..5b17d9afe 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -68,6 +68,8 @@ struct statx {
>      /* Direct I/O alignment restrictions */
>      __u32 stx_dio_mem_align;
>      __u32 stx_dio_offset_align;
> +\&
> +    __u64 stx_subvol;      /* Subvolume identifier */
>  };
>  .EE
>  .in
> @@ -255,6 +257,8 @@ STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
>  STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
>  	(since Linux 6.1; support varies by filesystem)
> +STATX_SUBVOL	Want stx_subvol
> +	(since Linux 6.10; support varies by filesystem)
>  .TE
>  .in
>  .P
> @@ -439,6 +443,14 @@ or 0 if direct I/O is not supported on this file.
>  This will only be nonzero if
>  .I stx_dio_mem_align
>  is nonzero, and vice versa.
> +.TP
> +.I stx_subvol
> +Subvolume number of the current file.
> +.IP
> +Subvolumes are fancy directories,
> +i.e. they form a tree structure that may be walked recursively.
> +Support varies by filesystem;
> +it is supported by bcachefs and btrfs since Linux 6.10.
>  .P
>  For further information on the above fields, see
>  .BR inode (7).
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--pcltyjurxel5b3jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ+nxQACgkQnowa+77/
2zIGrxAAga+Xm8gQb/XwumNE6v5Y3BrZvvQSwraScehic8mDEberfxITuRKvbRTT
cooOLeAzTv2e4Sq6vPtdSAmqa/WUiGlvPxE4hMdrDKJ4VCTNlRpiu3kIpQXREq9S
mkOwckjHkLL+7Kkd4OKqvQxwPxmfWL6uziTlb7jhyYBlIAxgnqOPQW9DBuUfyH5u
n+Dvm4hcLZuvgy8R3U4bK7SVzWKUAcMa7qHg1oQPOFVf5KGbp7R90X+xTd5w4TCE
9zmYQVQIyadnmK81jE32TU7BJHQ8MMkK5z1afGaoFj5gICg0L2MeX9DHJOOUDb19
AtTcf8NzNA+aqvElMJ/uSb3T8iZA/S8appisq7JWaMifEBsE/utYOKJdHFGvvvaa
m7lLy2yBMg08iwbtBpJ+v46Ffip26GEZBpVkhCb/vzHq/VqjHsnTPKBb4cuPoCzG
zm4eeH6r+ff8oUtxjVO3AWi+7Jh4NS9NuuTSwID8RSZpu3qY2K5CbOPdL0VaZReY
OFf11Tg7O8uuN+/H2WBzbRXL4nZWETwvCp5rOoL4gd+H9n1wEqY1kHeAQjfr86vv
hwbQ0ICnjHKzEkKWyBiZ19bn4GSzLpZat57U4scDdjgw0LueblTJ9ZwjYJKwuZEM
5M2KGNORD3K7z9kL/QKPoP0QvL/xdmGWVLXYE+q3eqxtmyOqXr0=
=JWdx
-----END PGP SIGNATURE-----

--pcltyjurxel5b3jg--

