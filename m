Return-Path: <linux-fsdevel+bounces-51262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F6AD4EA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1C93A775A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6022023ED63;
	Wed, 11 Jun 2025 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdLdOahu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57A223C8C9;
	Wed, 11 Jun 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631264; cv=none; b=k09pkSOKJ605ny4oUKo0tzuU9gbPxBJJ2pPwlx/0BVx0N9cw20AbgX24J3NV3LYgo6c5gOr3m5PWLGUmVFD6tkS3WDFJ+hcGfUTgPFh1vwt+Hr1WYuOa1HLZ2Zv3a5qlAYM5F5394t00aBbkGdBvRO4M3j9Cwne0PkHufXfJl3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631264; c=relaxed/simple;
	bh=4HYFS9JugtpIRtLXhDRyHDNPnv43ljpAxk5bo9qUBmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHBI6eBHfHJUUv141JmnNONjfBuvgZLBpEadBqqFW+mbTerCYWUT8h9knlj5RXhozcf8Q+CkdnRouBcEekjA8mB6tWDvKgVN5NLxK1b+mNqA2OGawqqPtLG6x3+MmxCC9PS+Gyxqul1BWhONKykBBe6z5NKS/Hgqt3+RDqVZ8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdLdOahu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243B3C4CEEE;
	Wed, 11 Jun 2025 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749631264;
	bh=4HYFS9JugtpIRtLXhDRyHDNPnv43ljpAxk5bo9qUBmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdLdOahud2SU+Jj1jWm0NVydU0RnaG8zYAU+zbPpJ20DI0/uaaTc5HuR6e73Ik2IC
	 kv9ptdVy/1MEcJdboLhiZCeM04HwO1g4R/kda/LnAxJ09CRPuD2jBo12TIbeKx/bnj
	 xVBkrWsf6atlfhhEdndPKfL0IwczCXyxsMpgW9OZYO47SP+R+Y5R3tusyWY7zmfPAu
	 dqQ5SJIWENHxywz0CxR6XcY+VRgS1/Exft9dzZyfSRwUaEJGixpY4arG7tb9h1besd
	 eC2YXmoSZmJPZEzPOrbIVAp4nbSHIy598uqM4IbL+d9kJI1glqpCbM1bf/RLe8l2WW
	 oJf/ndrGWxFTQ==
Date: Wed, 11 Jun 2025 10:41:00 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-man@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: RWF_DONTCACHE documentation
Message-ID: <sxmgk5dskiuq6wdfmdffsk4qtd42dgiyzwjmxv22xchj5gbuls@sln3lw6x2fkh>
References: <aD28onWyzS-HgNcB@infradead.org>
 <cb062be5-04e4-4131-94cc-6a8d90a809ac@kernel.dk>
 <a8a96487-99d9-442d-bf05-2df856458b39@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4oc7qb5wdnbeqglb"
Content-Disposition: inline
In-Reply-To: <a8a96487-99d9-442d-bf05-2df856458b39@kernel.dk>


--4oc7qb5wdnbeqglb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-man@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: RWF_DONTCACHE documentation
References: <aD28onWyzS-HgNcB@infradead.org>
 <cb062be5-04e4-4131-94cc-6a8d90a809ac@kernel.dk>
 <a8a96487-99d9-442d-bf05-2df856458b39@kernel.dk>
MIME-Version: 1.0
In-Reply-To: <a8a96487-99d9-442d-bf05-2df856458b39@kernel.dk>

Hi Jens,

On Mon, Jun 02, 2025 at 02:54:01PM -0600, Jens Axboe wrote:
> On 6/2/25 9:49 AM, Jens Axboe wrote:
> > On 6/2/25 9:00 AM, Christoph Hellwig wrote:
> >> Hi Jens,
> >>
> >> I just tried to reference RWF_DONTCACHE semantics in a standards
> >> discussion, but it doesn't seem to be documented in the man pages
> >> or in fact anywhere else I could easily find.  Could you please write
> >> up the semantics for the preadv2/pwritev2 man page?
> >=20
> > Sure, I can write up something for the man page.
>=20
> Adding Darrick as well, as a) he helped review the patches, and b) his
> phrasing is usually much better than mine.
>=20
> Anyway, here's my first attempt:
>=20
> diff --git a/man/man2/readv.2 b/man/man2/readv.2
> index c3b0a7091619..2e23e2f15cf4 100644
> --- a/man/man2/readv.2
> +++ b/man/man2/readv.2
> @@ -301,6 +301,28 @@ or their equivalent flags and system calls are used
>  .B RWF_SYNC
>  is specified for
>  .BR pwritev2 ()).
> +.TP
> +.BR RWF_DONTCACHE " (since Linux 6.14)"
> +Reads or writes to a regular file will prune instantiated page cache con=
tent
> +when the operation completes. This is different than normal buffered I/O,

Please use semantic newlines, even for drafts; it makes editing later
much easier.  See man-pages(7):

$ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
   Use semantic newlines
     In the source of a manual page, new sentences should be started on
     new lines, long sentences should be split  into  lines  at  clause
     breaks  (commas,  semicolons, colons, and so on), and long clauses
     should be split at phrase boundaries.  This convention,  sometimes
     known as "semantic newlines", makes it easier to see the effect of
     patches, which often operate at the level of individual sentences,
     clauses, or phrases.

And a quote from Brian W. Kernighan about preparing documents:

    Brian W. Kernighan, 1974 [UNIX For Beginners]:
   =20
    [
    Hints for Preparing Documents
   =20
    Most documents go through several versions
    (always more than you expected)
    before they are finally finished.
    Accordingly,
    you should do whatever possible
    to make the job of changing them easy.
   =20
    First,
    when you do the purely mechanical operations of typing,
    type so subsequent editing will be easy.
    Start each sentence on a new line.
    Make lines short,
    and break lines at natural places,
    such as after commas and semicolons,
    rather than randomly.
    Since most people change documents
    by rewriting phrases and
    adding, deleting and rearranging sentences,
    these precautions simplify any editing you have to do later.
    ]

> +where the data usually remains in cache until such time that it gets rec=
laimed
> +due to memory pressure. If ranges of the read or written I/O was already=
 in

s/was/were/

> +cache before this read or write, then those range will not be pruned at =
I/O

s/range/&s/

> +completion time. Additionally, any range dirtied by a write operation wi=
th
> +.B RWF_DONTCACHE
> +set will get kicked off for writeback. This is similar to calling
> +.BR sync_file_range (2)
> +with
> +.IR SYNC_FILE_RANGE_WRITE
> +to start writeback on the given range.
> +.B RWF_DONTCACHE
> +is a hint, or best effort, where no hard guarantees are given on the sta=
te of
> +the page cache once the operation completes.


> +Note: file systems must support
> +this feature as well.

I'd remove the sentence above.  It's redundant with the following one.
Also, to give it more visibility, and because it's not connected with
the preceding text, I'd move it to a new paragraph with '.IP'.

Other than this comments, the text looks good to me.  Thanks!


Have a lovely day!
Alex

> +If used on a file system or block device that doesn't
> +support it will return \-1 and
> +.I errno
> +will be set to
> +.B EOPNOTSUPP .
>  .SH RETURN VALUE
>  On success,
>  .BR readv (),
> @@ -368,6 +390,12 @@ value from
>  .I statx.
>  .TP
>  .B EOPNOTSUPP
> +.B RWF_DONTCACHE
> +was set in
> +.IR flags
> +and the file doesn't support it.
> +.TP
> +.B EOPNOTSUPP
>  An unknown flag is specified in
>  .IR flags .
>  .SH VERSIONS
>=20
> --=20
> Jens Axboe
>=20

--=20
<https://www.alejandro-colomar.es/>

--4oc7qb5wdnbeqglb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhJQRYACgkQ64mZXMKQ
wqlpBg/+KVksu3Nq/uSlhJSaTEpkEh9r4l1NHq1rQRYTMjJ4XTX3mVX+0S7bW7Tb
M/ZMr5Wmg/AdUXZh0ktmnHm6N0uelazA7ssr0wS1um9MrVjFOGX8PwVVPcIL5cqm
CX/fo4wETJCsGSxgLNzdGeTli7juCI9misKkMFE5JA6Gok0uUiC+9NAPg2h03AGb
P2jVYukXUBf6KZbaIacxxN+CRhV8fdee+ocRG20WNTuetkK9hhwx2cS/UTPQ9y6s
Ol0O+NZcxG2FZjsnV/rZp7a2xGJeFT5uqXNdSxquWJtoF7fJuP2XHzJ5BeBtUU9N
LPm97OF19MEDRukB2so86+6Fg1migslx7DusjQ+85pUGKmrYqbRD8prgoBFsvNc9
vShrft6xBrHNvvN2HMDSlnNkKtpRiq8Lt89UQfARW58pMirvJBZbutsx8BiSys2D
9a0P29+W90AVnLe88OZ3cbISYwYPwRu5BkXPHSPHF1bWUl+/GPw7erjNik23jJcU
Igs7pjK2J4OEzmlrY39nNtATjl6b6bsN11eZPd9aT1/5yUc1dr3r7saQkLIiEWIP
bFQWnB+ZzypJ67RhtqHG32IKPRoxf6Zmcv4mzCQ1+TNCo4OHYstqSyYP52toHjuW
FrmJdS43DPhDctotoMbv6hdOolZ7AUl/zTbWnOn+Hex4AMyHGc4=
=1n7e
-----END PGP SIGNATURE-----

--4oc7qb5wdnbeqglb--

