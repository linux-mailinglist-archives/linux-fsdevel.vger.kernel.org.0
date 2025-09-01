Return-Path: <linux-fsdevel+bounces-59866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26786B3E746
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62243A265F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C753730BF60;
	Mon,  1 Sep 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCuqOwW2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E876C120;
	Mon,  1 Sep 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737287; cv=none; b=OD8FTaUW9D2pTIdNzukAVvikLdF9aC9cjd9770Bi2DNtOqgbq/pj641uLH7SNoD0+bboLKbc1Ps5uisQB1oEGVkHxMX1kR4cg4l/075HnRRmLM6pt+3/Z0jgrMWMLykSB//i4wKu8Tt7qJ2MoIEtNoCKzhK5iE3tILH5wAMdSbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737287; c=relaxed/simple;
	bh=t3mV1mHZjXvzBomXMNQHfdhefYvclgsI17DgHy0L0CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5MUSMyPbhi+wP/8ePZOpw7x0vUUDBx2Zsp4HEKoDzr/pm/BqcyuRan0kxm52IBvCr6m5/Xg7Rj9buNFU3HfimftazHYjQtht66xv1RiCV96ZtV1iiXGWeVOtt4mLwn9gIFcKVeI5m6aEBp7OEq7QYX0UlYTKYm2bYlcHMyx3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCuqOwW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D4EC4CEF0;
	Mon,  1 Sep 2025 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737286;
	bh=t3mV1mHZjXvzBomXMNQHfdhefYvclgsI17DgHy0L0CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCuqOwW2+eAbDYf9PuEiY1fiP/Ijlkc/vm24XNPEoOC+7XvyX1l2uRYvicFjHg2W6
	 tjsjj0uNDjoc+tHyY8/xOHmgMPLmJDuVu2Wu6ij2Gy3GAjP1E3fu5fxUMTQB3sb2Yc
	 ELHWO2JI6GyyqCkNkE18GMZw+84kgdlTR4NK+XTRHImPBCyg50ACIFR8SC9zeuggxr
	 UOqAogghr/Y5hsiNCvhdL8bNYZEd6wbEteZp+CS18z9VZ3nkeAF1/otSf0ylU2wOiP
	 MTCOsmUCxrETFCSx7+bqLngaROMidZWtkKvGAYRTA8NMeyuEE+2JgECKczvwTnKriP
	 lBzW2OgzyKRqA==
Date: Mon, 1 Sep 2025 16:34:41 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] man/man2/readv.2: Document RWF_DONTCACHE
Message-ID: <ju4catrna2jnzlhgc5ka3kw3let5x5olxxtojadwm3ztbgrqjn@6zwzowfow2fd>
References: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>
 <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pg7awu4uytvuix7z"
Content-Disposition: inline
In-Reply-To: <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>


--pg7awu4uytvuix7z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] man/man2/readv.2: Document RWF_DONTCACHE
References: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>
 <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>

Oops, I forgot to sent to linux-man@.

On Mon, Sep 01, 2025 at 04:22:06PM +0200, Alejandro Colomar wrote:
> Add a description of the RWF_DONTCACHE IO flag, which tells the kernel
> that any page cache instantiated by this IO, should be dropped when the
> operation has completed.
>=20
> Reported-by: Christoph Hellwig <hch@infradead.org>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: linux-fsdevel@vger.kernel.org
> Co-authored-by: Jens Axboe <axboe@kernel.dk>
> [alx: editorial improvements; srcfix, ffix]
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>=20
> Hi Jens,
>=20
> Here's the patch.  We don't need to paste it into writev(2), because
> writev(2) is documented in readv(2); they're the same page.
>=20
> Thanks for the commit message!
>=20
> Please sign it, if you like it.
>=20
>=20
> Have a lovely day!
> Alex
>=20
>=20
>  man/man2/readv.2 | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/man/man2/readv.2 b/man/man2/readv.2
> index c3b0a7091..5b2de3025 100644
> --- a/man/man2/readv.2
> +++ b/man/man2/readv.2
> @@ -301,6 +301,39 @@ .SS preadv2() and pwritev2()
>  .B RWF_SYNC
>  is specified for
>  .BR pwritev2 ()).
> +.TP
> +.BR RWF_DONTCACHE " (since Linux 6.14)"
> +Reads or writes to a regular file
> +will prune instantiated page cache content
> +when the operation completes.
> +This is different than normal buffered I/O,
> +where the data usually remains in cache
> +until such time that it gets reclaimed
> +due to memory pressure.
> +If ranges of the read or written I/O
> +were already in cache before this read or write,
> +then those ranges will not be pruned at I/O completion time.
> +.IP
> +Additionally,
> +any range dirtied by a write operation with
> +.B RWF_DONTCACHE
> +set will get kicked off for writeback.
> +This is similar to calling
> +.BR sync_file_range (2)
> +with
> +.I SYNC_FILE_RANGE_WRITE
> +to start writeback on the given range.
> +.B RWF_DONTCACHE
> +is a hint, or best effort,
> +where no hard guarantees are given on the state of the page cache
> +once the operation completes.
> +.IP
> +If used on a file system or block device
> +that doesn't support it,
> +it will return \-1, and
> +.I errno
> +will be set to
> +.BR EOPNOTSUPP .
>  .SH RETURN VALUE
>  On success,
>  .BR readv (),
> @@ -368,6 +401,12 @@ .SH ERRORS
>  .I statx.
>  .TP
>  .B EOPNOTSUPP
> +.B RWF_DONTCACHE
> +was set in
> +.I flags
> +and the file doesn't support it.
> +.TP
> +.B EOPNOTSUPP
>  An unknown flag is specified in
>  .IR flags .
>  .SH VERSIONS
>=20
> Range-diff against v1:
> -:  --------- > 1:  9e1f1b2d6 man/man2/readv.2: Document RWF_DONTCACHE
>=20
> base-commit: aa88bcfabc52b7d4ef52a8e5a4be0260676d81bc
> prerequisite-patch-id: b91cde16f48eeae2a44bae89e8cbb41d9034a865
> prerequisite-patch-id: 0c0617b91c32758d64e6e8b2f8ddd434199d842b
> prerequisite-patch-id: 02385b38b2a5ec5c04a468e888b1bc14aace9ec6
> prerequisite-patch-id: 10e6a0e6e2edd5e74767af533958389454f72ab5
> prerequisite-patch-id: 2dc3d94ce9d6e965182437c822479f55ec67da07
> prerequisite-patch-id: 9e5fef3be8cc4d5d2828c415cf5a923e055640fc
> prerequisite-patch-id: 3de1fc513b71447bb13ac740474138c80e3a463e
> --=20
> 2.50.1
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--pg7awu4uytvuix7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmi1rwEACgkQ64mZXMKQ
wqnt4A/+I+WEevGUiOiMAjTBjNoAuIWnpu2mtOZEEmIyzL6zT/S/2yRDUrkUOG4G
4OvWhp/YIOjYduQEug5skGnpW4s1VZs/GDV1DBjIdvx+afkcHbUO4xDHbyCRJNvG
XBlkECtPODjTWIvnQ5UAgU86vHBygNVZY9G4Kt7yXlFlcBb4En/ILjM5c9BRDYcK
RVr7p55BCynqExUQBYTkpTQAnNVm8+FSLSNrO1yOOYphpiOzEOooui7U2FgjK4gA
4hLUDChQmPCIbtd9hf5bq/nJeUbGEmJr7xBEO8YZgIAFuQqxGS3vfN4C5afzGYwS
NPi7R/XY/DxV3sPMtdr1E1IUuomCMEPkubVsb4iXQ1wArx/1+klTA7L8YmRVjIPX
Os/cV4sEu8OunHOm76txLQkdRehKoeQBbilLMawtw2vAJjzEoLGyeCQyEG3gytvc
f2L9QNW1txqS5y5XonSwKDtUhjyXJC734NG/ieb3cezlgq/hLW1fHRC/dAGixfYj
OQfEkXJD82O+En+7wEK2VL+zPbFT5pYcEhyFhw4HY2i6ifY+h0BngNNLeRRf3QNB
fa5cM0Ikeo9Jf730MqWLkKh960yebXqL4HckznHxMHrgYxn0FxLcBnpkEZAltaVx
Jbkq+3lAtXe7wER7tNCHsO3TKxUvnXolSnONHF8TvhNeF7FGVe8=
=OPfs
-----END PGP SIGNATURE-----

--pg7awu4uytvuix7z--

