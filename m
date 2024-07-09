Return-Path: <linux-fsdevel+bounces-23418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D778892C1F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0622C1C23D2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D924B18004B;
	Tue,  9 Jul 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MokDFKEU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D92180040;
	Tue,  9 Jul 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543687; cv=none; b=u9Khb0H2/TqLPqForsBguUMOZQhagtpc3g52tN3rRSTdJVx5qMXMXrkT4AB1LzpdAXUhZrOO+Vy2KFTusAjZk1aTjTILIggK2YWvoP3g+U47ShSbtTEVp+xKE30u+tdpNPONGUBy3iMaxaTki4f5K5T9iA/QTes48lgn+nqEX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543687; c=relaxed/simple;
	bh=A7Jcx5oRumAX8eZV98UsjPpCTrSH8Zw/GPltiVSDWeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbevyMC5O5rU+2z2bTg3r8yDCIZF5vwqrRs2/Q0s77DKMbeBDT6tSpoWB9LHPOXEFRHDWkZ+o6RbsXPOcC+cMrLZsdf4lDNTMENlCNrwsnOI9bWxZllouuh5jClI48ujqy8pMoxPt6sadSFsA7ljqbJ0XOXHh27ywh3vTdXuWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MokDFKEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EE7C32786;
	Tue,  9 Jul 2024 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720543686;
	bh=A7Jcx5oRumAX8eZV98UsjPpCTrSH8Zw/GPltiVSDWeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MokDFKEUT0N64kawOOEvAnloU2l0oQSTxwH3k+mScz1TqtRRJAT7OtCnU/oV20Ilr
	 H7evqetKqbm3SNQxLpskR19q0SUnMHhTWs2pWJNK4+3r9hTj3dWH9MagemEygOjWjo
	 Xf7J+pt/deh/J8Jrw8cU/GMmYvd7tJ0Hdz2ipLqW088lDvPZ2wScErTqSK2G5jiSBl
	 ftZ5Dq96R2yfgj9QsfPLGl311jOkgNefiUfYkxN01i/wPQpCLhT7fz1WC8A3eT6DBw
	 ELmw4+DCrv/t1xvyFJTA78gpios4E0/m2SJlLHD5urwBIJo89MUfo8bqu4ukorYDfo
	 hD9O6i3lKgN5g==
Date: Tue, 9 Jul 2024 18:48:03 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 1/3] statx.2: Document STATX_WRITE_ATOMIC
Message-ID: <udwezmj36we4bkvlnbxpuvrrikh5yejaf6yetxd2ig3ssgksrw@fi5hsutb7mmu>
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhjnv3mrbrzanzf5"
Content-Disposition: inline
In-Reply-To: <20240708114227.211195-2-john.g.garry@oracle.com>


--xhjnv3mrbrzanzf5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 1/3] statx.2: Document STATX_WRITE_ATOMIC
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-2-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20240708114227.211195-2-john.g.garry@oracle.com>

On Mon, Jul 08, 2024 at 11:42:25AM GMT, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
>=20
> Add the text to the statx man page.
>=20
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  man/man2/statx.2 | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index 3d47319c6..36ecc8360 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -70,6 +70,11 @@ struct statx {
>      __u32 stx_dio_offset_align;
>  \&
>      __u64 stx_subvol;      /* Subvolume identifier */
> +\&
> +    /* Direct I/O atomic write limits */
> +    __u32 stx_atomic_write_unit_min;
> +    __u32 stx_atomic_write_unit_max;
> +    __u32 stx_atomic_write_segments_max;
>  };
>  .EE
>  .in
> @@ -259,6 +264,9 @@ STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_off=
set_align
>  STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
>  STATX_SUBVOL	Want stx_subvol
>  	(since Linux 6.10; support varies by filesystem)
> +STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min, stx_atomic_write_unit=
_max,
> +	and stx_atomic_write_segments_max.
> +	(since Linux 6.11; support varies by filesystem)
>  .TE
>  .in
>  .P
> @@ -463,6 +471,24 @@ Subvolumes are fancy directories,
>  i.e. they form a tree structure that may be walked recursively.
>  Support varies by filesystem;
>  it is supported by bcachefs and btrfs since Linux 6.10.

=2ETP

> +.I stx_atomic_write_unit_min
> +The minimum size (in bytes) supported for direct I/O
> +.RB ( O_DIRECT )
> +on the file to be written with torn-write protection. This value is guar=
anteed

Please use semantic newlines.  See man-pages(7):

$ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p';
   Use semantic newlines
     In the source of a manual page, new sentences should be started on
     new lines, long sentences should be split  into  lines  at  clause
     breaks  (commas,  semicolons, colons, and so on), and long clauses
     should be split at phrase boundaries.  This convention,  sometimes
     known as "semantic newlines", makes it easier to see the effect of
     patches, which often operate at the level of individual sentences,
     clauses, or phrases.

> +to be a power-of-2.
> +.TP
> +.I stx_atomic_write_unit_max

You should probably merge both fields with a single paragraph.  See for
example 'stx_dev_major' and 'stx_dev_minor'.

Have a lovely day!
Alex

> +The maximum size (in bytes) supported for direct I/O
> +.RB ( O_DIRECT )
> +on the file to be written with torn-write protection. This value is guar=
anteed
> +to be a power-of-2.
> +.TP
> +.I stx_atomic_write_segments_max
> +The maximum number of elements in an array of vectors for a write with
> +torn-write protection enabled. See
> +.BR RWF_ATOMIC
> +flag for
> +.BR pwritev2 (2).
>  .P
>  For further information on the above fields, see
>  .BR inode (7).
> @@ -516,6 +542,9 @@ It cannot be written to, and all reads from it will b=
e verified
>  against a cryptographic hash that covers the
>  entire file (e.g., via a Merkle tree).
>  .TP
> +.BR STATX_ATTR_WRITE_ATOMIC " (since Linux 6.11)"
> +The file supports torn-write protection.
> +.TP
>  .BR STATX_ATTR_DAX " (since Linux 5.8)"
>  The file is in the DAX (cpu direct access) state.
>  DAX state attempts to
> --=20
> 2.31.1


--=20
<https://www.alejandro-colomar.es/>

--xhjnv3mrbrzanzf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaNacIACgkQnowa+77/
2zI+8Q/8C9a6vSqTEiP12bJsHRVgpJaUrnL/vFnCwX9P0+UVtm9pGqL7EWw7lAnd
uYwzCU54GrHyB0b9t8IxSKjznmDQkDfWS8flnwXsq/G/Pkf3vAlYX31eE3i8k+Wk
FZRIhNWzpufRWlXZ8g8uRO3h2vhdFNLj+gId/P33iFJCe0pkD6vT8Ff3gx8dvULe
VJX8zVx5yh/6i8EyaHpr2mya7luT51WQgYBVMNZJOJLwTMahQVyTz3aJjfgo7eRc
/7K4ZyATxzZqvwoYVS4q0e3Cm+6aaUq5WgACSrF96OQYvqw159t0WVpZlpdedSKw
kZp11tBnBjEjq286ICYtOvvlVK+fLYvrqzPJvRob+4YTk/XzCUcLBVZeRKSbuiR7
Obylx+hAR2eEwIzcN2rMmZim9tQ2XYy9xaD6whxfxbFKR3HixiXqJjFRE+4UwA3v
8v08e8KguVAbhr1ePWGehiWAkQys9aFxmQLVr2KJGZ4dwONSCnDkno9z1QTO22dl
rWreCtW1yxynFrxX1H9+Oqv1IoK+feniqMdvGZLZxZVEt2Ks2HU8wJJYH5N6mfHg
qiuQbVRIN1KNpcva0UZJUSSCv4uJboJZUulOJO9vGIuxS1KlL7GEO1twrnX8f+LZ
U2lAV0LQ9bNPrWxuPcgm3mKt4Ap7/GhvofJWcEui+tzyACJ1jJ8=
=QBM9
-----END PGP SIGNATURE-----

--xhjnv3mrbrzanzf5--

