Return-Path: <linux-fsdevel+bounces-22440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4CF9171F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 22:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3901F240BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BE418C340;
	Tue, 25 Jun 2024 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyQwe7WI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52B17D88A;
	Tue, 25 Jun 2024 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345309; cv=none; b=u6gi08kZWjNcaAvjAx7GPzzNkQOeIyk1PfFXEsb9wDgpGI/CduDdTH+ZVvrVLj7gzzl6gmREacWk65DOzH7fSAPghqnEyNEj3wmKcDFj+HRFwZ4aQ8hxERrIFNKL4Q7BGJAGHFMVG7+PcqvVIpprUci0iuIqadPEI+X9DFJcMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345309; c=relaxed/simple;
	bh=iryRieb8apbUc/yfZMhRfoh3RNQGqab+OXS41szrIkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geK/9Z0UZGlysPsDawDaRqgPNEVETh8/XwUwyw7tDJXRaKtS2ggnaNNoM1mAR+oBBmk1fInevxZVVfkzVSSgMMDt1d0s48pG9FagSNDgV1M0qVq0I9Yts+Yls9Dq+k6rEBMZdZlPHx+apEaq+ymKwElrUtFo/G4EE/e5miD69lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyQwe7WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A3CC4AF15;
	Tue, 25 Jun 2024 19:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719345309;
	bh=iryRieb8apbUc/yfZMhRfoh3RNQGqab+OXS41szrIkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyQwe7WIj+zocWYiUw3cHhZV5+PDYpkK3BjrhL2xsTmPEVGvqj8JS6dl8utuCM0hM
	 wbm98fEscGvP/viec9OYqxh0oyERTSpn1y4mvEiNI6SdcXaZ99jcrcQCJO9bZlG4x7
	 IuGAGVDltc8+e8tGpvwWzhrIml8O1LWfv4oJ2/icb2pi5+OjfZ1wkD7Q+AIkvnSDaS
	 RnRFqT5Xu+EmKgBtUDa3T308bZg8bjZ5DmffyVY3zy0TSr4XSc6bo4FcbBWaelLnae
	 N+8ch2ZGvgM1pU7pwy/NgxG3E6q/0MBcqc88ZcwOilXixMM3+z2agGzRFIHRgFthM+
	 fPbnTSwlrE1og==
Date: Tue, 25 Jun 2024 21:55:05 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH 1/3] statx.2: Document STATX_MNT_ID_UNIQUE
Message-ID: <tqs2e6l65hyntuxsfsbgjra5gnnrtyfwfynmml54dkf3dsjtyp@at5ov7rptpma>
References: <cover.1719341580.git.josef@toxicpanda.com>
 <a45b2623a25357f33978b49963dad5f99b984386.1719341580.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bximcu3znwvhfc6z"
Content-Disposition: inline
In-Reply-To: <a45b2623a25357f33978b49963dad5f99b984386.1719341580.git.josef@toxicpanda.com>


--bximcu3znwvhfc6z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH 1/3] statx.2: Document STATX_MNT_ID_UNIQUE
References: <cover.1719341580.git.josef@toxicpanda.com>
 <a45b2623a25357f33978b49963dad5f99b984386.1719341580.git.josef@toxicpanda.com>
MIME-Version: 1.0
In-Reply-To: <a45b2623a25357f33978b49963dad5f99b984386.1719341580.git.josef@toxicpanda.com>

On Tue, Jun 25, 2024 at 02:56:04PM GMT, Josef Bacik wrote:
> Linux 6.8 adds STATX_MNT_ID_UNIQUE support
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D98d2b43081972
>=20
> Add the text and explanation to the statx man page.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Hi Josef,

Thanks for the patch.  I've applied it with some minor tweaks.  I
changed mostly the line breaks (see /Use semantic newlines/ in
man-pages(7)).

<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D080218fbb88a94db7a9b24858ee5bad2610f13d5>

Have a lovely night!
Alex

> ---
>  man/man2/statx.2 | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index 0dcf7e20b..3d5ecd651 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -234,7 +234,7 @@ .SH DESCRIPTION
>  .I mask
>  is an ORed combination of the following constants:
>  .P
> -.in +4n
> +.in +1n
>  .TS
>  lB l.
>  STATX_TYPE	Want stx_mode & S_IFMT
> @@ -255,6 +255,7 @@ .SH DESCRIPTION
>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
>  STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
>  	(since Linux 6.1; support varies by filesystem)
> +STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
>  .TE
>  .in
>  .P
> @@ -410,11 +411,18 @@ .SH DESCRIPTION
>  .TP
>  .I stx_mnt_id
>  .\" commit fa2fcf4f1df1559a0a4ee0f46915b496cc2ebf60
> -The mount ID of the mount containing the file.
> +If using STATX_MNT_ID, this is the mount ID of the mount containing the =
file.
>  This is the same number reported by
>  .BR name_to_handle_at (2)
>  and corresponds to the number in the first field in one of the records in
>  .IR /proc/self/mountinfo .
> +.IP
> +If using STATX_MNT_ID_UNIQUE, this is the unique mount ID of the mount
> +containing the file.  This is the number reported by
> +.BR listmount (2)
> +and is the ID used to query the mount with
> +.BR statmount (2) .
> +It is guaranteed to not be reused while the system is running.
>  .TP
>  .I stx_dio_mem_align
>  The alignment (in bytes) required for user memory buffers for direct I/O
> --=20
> 2.43.0
>=20

--=20
<https://www.alejandro-colomar.es/>

--bximcu3znwvhfc6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ7IJMACgkQnowa+77/
2zJ0CA//dmc3il6zPdQm2nyTb+L1OFdWfS2zb6DTk6xLaGwQb5BXJLYwg04c05Jx
jF0K2d+WbP65ckHXLSCKvliNZ7CjHTJ1g82vW+vbHsAUv78Loe6eON4lcthoJkiD
BPNqT2VF2ZsLdOt5utXEc1s1RKTklccgum6jnxnxfkD8iJCcBOnUD0oPIADeE6kZ
otdWU+8Noq4uyitnTOx4g7cKElkR3k4zs6T2VDRRlbPY0aHok2f4jRoKcKxCYxXP
h8+1HrRL447966biGRLF+thPWUpvRwqmHiip9djr1MhhdtIf4F7faRlKN5Q77TkU
G5o4V4XtH4HkbE65NDFizMxZLzz303S9EydFXhvI8vOyhnhpXxa3yNQIj68M9a6O
i6bYGstZdxrSvl1oXQkourkCcWT43DcxzS6y4Kdem9O82AzJ7FgL/hNIO2txmrkK
zUiYNZQV06AMc2//0cxqQh8hef7dDMTODHjGOniHFD6PnK9rSxCu7d6fyObbMhoz
21qY7kC6LjSDXubvd9XqQ8cZpXl8fvZR6S8G0IE0VBA7uqE/doXl8lLwd7cL9wq0
Zd/RFOoAefAndgVVEsZqpeqZd2/LLKhxzeIKXUVdgRqxqxSJxDBZ22e8mIkZ8uc0
/uX+2lcq5nLAuS3jfzW5fYzFUy3iZbizd7VwjbVvL5NYwZZuzAE=
=+/3W
-----END PGP SIGNATURE-----

--bximcu3znwvhfc6z--

