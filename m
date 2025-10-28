Return-Path: <linux-fsdevel+bounces-65965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EC6C17626
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB04B4EA436
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 23:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4736B96C;
	Tue, 28 Oct 2025 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtRh9aBJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC92C21EB;
	Tue, 28 Oct 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694743; cv=none; b=LcMFoxCwW2GRbpnSI7nkEAPfcKrpYTj8k8GmIZkILT8h8z2/OFLfSP/HRgbqprTbFrT4htRME+gVzcRw6CgSjOmOILFXpF+Cf/VXqPPwOw2BsbVVaPKk+9y/JjTtnvJj444uPR9fL1HR++xJ/BULIDfD7sV0YgrSBmOJit8YNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694743; c=relaxed/simple;
	bh=usEXZdlQ8ofX0gOhMwCU8++sGXu1iTrFTVbToiGGZUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4uGYmYFQiaflLN6O05Fr76W9wU2iD/v827onflQXlY8z/HUO+tOCjZwWF58LZXIyqErGNlyyJD98OgOmonzjuSNISijZXPriTJC7925i34oIYpv2+sFeoi4d1AeEadLCibiP4xfd3stA+0FJHrmTlJczNpCCdyMIe5JMlmB7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtRh9aBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18226C4CEE7;
	Tue, 28 Oct 2025 23:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761694743;
	bh=usEXZdlQ8ofX0gOhMwCU8++sGXu1iTrFTVbToiGGZUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtRh9aBJv0OrUuBV4+eAVjv3FwU2W/Vmds75avOSkolfvqTgPGlym75HUOkHEgjgC
	 1UMJMF8F74aYJ79n6xhkKfxa2hE2KwaJ2F+dOGZlqLJeAvnIQAFrruBd/xEllby3ge
	 UxH6f4k8wtKB8v14X8rsTmM81w4DtrJWjxz+E/fyKUk9Eub6x0+9ZLJa64O/mVhg4B
	 x8bk6lIr2NVjLkPEwF3Us328FZn/hZm6chcg/crAVlHPAfx4xKkUwb23VCLG5rYOA3
	 nx6VeQ/7MAy2df/Ter5sOM552Db3F56CEsDdcdHRbVF1BbdyPI9j834bBATrR79KyH
	 M2pcn4q4HvLkQ==
Date: Wed, 29 Oct 2025 00:38:59 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: linux-man@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] man/man2/flock.2: Mention non-atomicity w.r.t close
Message-ID: <ajtcmj6vhszc4r5zx647ccagtf67huovte76moslqmpotr5dey@3v5a4lok6rrj>
References: <181d561860e52955b29fe388ad089bde4f67241a.1760627023.git.amonakov@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kcug6qaud2n4ayr6"
Content-Disposition: inline
In-Reply-To: <181d561860e52955b29fe388ad089bde4f67241a.1760627023.git.amonakov@ispras.ru>


--kcug6qaud2n4ayr6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: linux-man@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] man/man2/flock.2: Mention non-atomicity w.r.t close
Message-ID: <ajtcmj6vhszc4r5zx647ccagtf67huovte76moslqmpotr5dey@3v5a4lok6rrj>
References: <181d561860e52955b29fe388ad089bde4f67241a.1760627023.git.amonakov@ispras.ru>
MIME-Version: 1.0
In-Reply-To: <181d561860e52955b29fe388ad089bde4f67241a.1760627023.git.amonakov@ispras.ru>

Hi Jan,

On Thu, Oct 16, 2025 at 06:22:36PM +0300, Alexander Monakov wrote:
> Ideally one should be able to use flock to synchronize with another
> process (or thread) closing that file, for instance before attempting
> to execve it (as execve of a file open for writing fails with ETXTBSY).
>=20
> Unfortunately, on Linux it is not reliable, because in the process of
> closing a file its locks are dropped before the refcounts of the file
> (as well as its underlying filesystem) are decremented, creating a race
> window where execve of the just-unlocked file sees it as if still open.
>=20
> Linux developers have indicated that it is not easy to fix, and the
> appropriate course of action for now is to document this limitation.
>=20
> Link: <https://lore.kernel.org/linux-fsdevel/68c99812-e933-ce93-17c0-3fe3=
ab01afb8@ispras.ru/>
>=20
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>

Would you mind reviewing this?  Thanks!


Have a lovely night!
Alex

> ---
>  man/man2/flock.2 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/man/man2/flock.2 b/man/man2/flock.2
> index b424b3267..793eaa3bd 100644
> --- a/man/man2/flock.2
> +++ b/man/man2/flock.2
> @@ -245,6 +245,21 @@ .SH NOTES
>  and occurs on many other implementations.)
>  .\" Kernel 2.5.21 changed things a little: during lock conversion
>  .\" it is now the highest priority process that will get the lock -- mtk
> +.P
> +Release of a lock when a file descriptor is closed
> +is not sequenced after all observable effects of
> +.BR close (2).
> +For example, if one process writes a file while holding an exclusive loc=
k,
> +then closes that file, and another process blocks placing a shared lock
> +on that file to wait until it is closed, it may observe that subsequent
> +.BR execve (2)
> +of that file fails with
> +.BR ETXTBSY ,
> +and
> +.BR umount (2)
> +of its underlying filesystem fails with
> +.BR EBUSY ,
> +as if the file is still open in the first process.
>  .SH SEE ALSO
>  .BR flock (1),
>  .BR close (2),
>=20
> Range-diff against v0:
> -:  --------- > 1:  181d56186 man/man2/flock.2: Mention non-atomicity w.r=
=2Et close
> --=20
> 2.49.1
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--kcug6qaud2n4ayr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkBVBMACgkQ64mZXMKQ
wqkH2A/+P9pZ5wDkpQiPd10gZTCWunAuijAEgdYFs80osYWuh539MLdZIfzSu77Y
AsEUkUaQmBe1E8FT/S9FPcqaYS1SRVIw4CiHgLXhQakMPQTs6blPJIAoM5UkfhVK
R7OB74/AfbZ6gaQ1fjNoawKLU3wHH1WGxpLEZ//QILtScBvehwp9zpv9fgWCXtoG
mZnzymJCSIEqSQkcWAP7wqM82Fu1oT0ndmTt61uXuNYJ/SAnEoQDL1rmVGy1l/I9
chb2tDyF4reFeDoZAmtRkJJARXwa8TVa5F3ZAQDQg5MiFKrUeyLfamGWxEuYSpN8
byDOe4CKssdpyS168FbVhelcdLPA3jgiEiNVULmAStxtSogK/e5mGOlemQS87fGK
Yjn8M6+IND69rcL2rUTIvyBNvmwR5TgF0bphy8EOunZhdkIK5CSiX8j80u7NrdKt
JwlIs0jPRbZ9q4hiDsDwfYbjJYp5Y04wbOh9mk5uSJOQNXBjkfhzalsGSjk8gPqr
+6mDUxinSJ3Gnvw3J3e0E3BHsgZOsmsh9bgWb23EzPmW9adxnLmdQqvVIq1tDlGa
Xk04Rg+TBiM5/87x9OzoZeHpHh+jVVm9cw37hU3RV0fgsNANWCVYKGQbsRYiPtZ1
0pDBC4C939DeVl1wl6lkheKHkB42T9AIvDEdzwKZw9jVyNFMK8k=
=BFCF
-----END PGP SIGNATURE-----

--kcug6qaud2n4ayr6--

