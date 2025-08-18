Return-Path: <linux-fsdevel+bounces-58111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DA6B2979E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 06:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65721188C0E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 04:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D51622D9F7;
	Mon, 18 Aug 2025 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMQHEenb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BB1E8333;
	Mon, 18 Aug 2025 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489703; cv=none; b=ZhS8Hs7IJldZqRRvgL4Fhomc1tGhINZlC5ym8jnZqSHZLbvDal+g18m+fcidWKP8RDrB749HOqSk7oD7f9t93iXEHr1QSGgU5fCHBBC0bxnHAbTqw7MtvowQRihT+tcCBZf6m8QZLDd7bDflaKiWerU1YoLff84oXpOhvgUSkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489703; c=relaxed/simple;
	bh=n8k6GLuayBQEfj2BoUMTGZ8V/eZoD7HjbQCwc/dbMyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHCL1vyP9FQn9lGpc8nuE5JJ6XCPiz6Ygbt3xSQgaLCKk1icL35FyTzY6uNEKgpgPa5sfVX/D9uw643br3CLfg6NCohobH6pWmLXv6ak0rT4GwzYvOVFwVOTnuXl43Atvsf9fPKE1he7PsUdnWF2gjPipe2QLIprCxWTbuyuoM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMQHEenb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D1CC4CEEB;
	Mon, 18 Aug 2025 04:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755489703;
	bh=n8k6GLuayBQEfj2BoUMTGZ8V/eZoD7HjbQCwc/dbMyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMQHEenb9+plm24rRM17GTZvyzq39VvGvJEAlunBv4oZwV8bCcWZPd6EiEAZsEvnY
	 vdSK5dB4muaIh3g/bj5vrFiU/Lgx+i+dxsERh5NKB1hVPHqQDZOQ3x4xVgiC/7qTCz
	 Kz3MXa9WcwnTw9uGumTeLFGKNdMcmOZgrVKOSDQpk7aumQM8hV4uCBZ/okw0oUsmJM
	 8KAiN3c3TyLDr1mahUlBk5ulrUqfzVE46Y7bHWzG7iE4wQlUxEholWUQXsKw5L7ZBx
	 V7DXEQ9BUYfHuo1wrMgj8vRw9CIMjLiegDdXnDTfabQrzDenqjWuaebUIkGaBzg9gh
	 qvPjYmEUEG7Rg==
Date: Mon, 18 Aug 2025 06:01:37 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-man@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: RWF_DONTCACHE documentation
Message-ID: <dargd4lgdazaqxrw7gz6drrzzgonn34qllkcgei4uxs6ft7jbz@avkuehcbaok6>
References: <aD28onWyzS-HgNcB@infradead.org>
 <cb062be5-04e4-4131-94cc-6a8d90a809ac@kernel.dk>
 <a8a96487-99d9-442d-bf05-2df856458b39@kernel.dk>
 <sxmgk5dskiuq6wdfmdffsk4qtd42dgiyzwjmxv22xchj5gbuls@sln3lw6x2fkh>
 <409ec862-de32-4ea0-aae3-73ac6a59cc25@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5qimfktp3ivmt5j"
Content-Disposition: inline
In-Reply-To: <409ec862-de32-4ea0-aae3-73ac6a59cc25@kernel.dk>


--b5qimfktp3ivmt5j
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
 <sxmgk5dskiuq6wdfmdffsk4qtd42dgiyzwjmxv22xchj5gbuls@sln3lw6x2fkh>
 <409ec862-de32-4ea0-aae3-73ac6a59cc25@kernel.dk>
MIME-Version: 1.0
In-Reply-To: <409ec862-de32-4ea0-aae3-73ac6a59cc25@kernel.dk>

Hi Jens,

On Mon, Aug 11, 2025 at 11:25:52AM -0600, Jens Axboe wrote:
> > Other than this comments, the text looks good to me.  Thanks!
>=20
> I kind of walked away from this one as I didn't have time or motivation
> to push it forward. FWIW, if you want to massage it into submission
> that'd be greatly appreciated. I'm not a regular man page contributor
> nor do I aim to be, but I do feel like we should this feature
> documented.

I understand your lack of interest in writing quality man(7) source code
if that means iterations of patches.  However, you may find the build
system helpful to find some of the most obvious mistakes by yourself.
This might help you in future patches.

	$ make lint-man build-all -R
	TROFF		.tmp/man/man2/readv.2.cat.set
	an.tmac:.tmp/man/man2/readv.2:316: style: .IR expects at least 2 arguments=
, got 1
	an.tmac:.tmp/man/man2/readv.2:395: style: .IR expects at least 2 arguments=
, got 1
	make: *** [/srv/alx/src/linux/man-pages/man-pages/contrib/share/mk/build/c=
atman/troff.mk:66: .tmp/man/man2/readv.2.cat.set] Error 1
	make: *** Deleting file '.tmp/man/man2/readv.2.cat.set'

Here's a diff with all the issues I raised fixed.  Please add a commit
message, and I'll apply it.


Have a lovely day!
Alex


diff --git i/man/man2/readv.2 w/man/man2/readv.2
index c3b0a7091..5b2de3025 100644
--- i/man/man2/readv.2
+++ w/man/man2/readv.2
@@ -301,6 +301,39 @@ .SS preadv2() and pwritev2()
 .B RWF_SYNC
 is specified for
 .BR pwritev2 ()).
+.TP
+.BR RWF_DONTCACHE " (since Linux 6.14)"
+Reads or writes to a regular file
+will prune instantiated page cache content
+when the operation completes.
+This is different than normal buffered I/O,
+where the data usually remains in cache
+until such time that it gets reclaimed
+due to memory pressure.
+If ranges of the read or written I/O
+were already in cache before this read or write,
+then those ranges will not be pruned at I/O completion time.
+.IP
+Additionally,
+any range dirtied by a write operation with
+.B RWF_DONTCACHE
+set will get kicked off for writeback.
+This is similar to calling
+.BR sync_file_range (2)
+with
+.I SYNC_FILE_RANGE_WRITE
+to start writeback on the given range.
+.B RWF_DONTCACHE
+is a hint, or best effort,
+where no hard guarantees are given on the state of the page cache
+once the operation completes.
+.IP
+If used on a file system or block device
+that doesn't support it,
+it will return \-1, and
+.I errno
+will be set to
+.BR EOPNOTSUPP .
 .SH RETURN VALUE
 On success,
 .BR readv (),
@@ -368,6 +401,12 @@ .SH ERRORS
 .I statx.
 .TP
 .B EOPNOTSUPP
+.B RWF_DONTCACHE
+was set in
+.I flags
+and the file doesn't support it.
+.TP
+.B EOPNOTSUPP
 An unknown flag is specified in
 .IR flags .
 .SH VERSIONS



>=20
> --=20
> Jens Axboe
>=20

--=20
<https://www.alejandro-colomar.es/>

--b5qimfktp3ivmt5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiipZoACgkQ64mZXMKQ
wql2Yg//fl8kh8tk+ObUu1mrwJBa3rLNdOBMjLeZrmwpow+wRnKOuhQODfLG9d46
QiYjBLIYq0uSAS+Rd4vaDqCzr3XKIK+8ue6iUz0MctmpwyficqM4OJAuzAUtzmVC
2jKVxXipFH9zG05nSG6WMHOPfV5MPO54bxCSvVOc6shGpLk9KsqprBlu4ObCnbWN
fNOdRUT07ZvG/PoRk4dWwWbHzSWuJwhMpcycC+FIZYuw/meDEbGVLFFNoQcTEtkU
IvQ95NXTI5qr/zfLIITW7wn9M4jvcFxrpZkR3cJ8sACH10R9t8vRhxfq3KbAv9gx
qEWKG93eWL1kiFlLFPJu1XfNC7UfPpAlXpr8H0H6ohh4W8ACz+RfnSh01//ohGtC
Zi7b8QfLjsGfPpjDA1qaGBqC/HsmMb0xfVZarjV3R1k2aOFa3INVusvt9Kdg2rP1
aS9aDUla2L24M5EDD96n32n6zwmfle4hotvA3XzeWFuCG4vDhbh94YRWDFuEibgQ
YPgwx4CFaaRsGzBiu31yEs8OPUkdwcNjTT/wsMhabfwBz9YZM8fHOkpuMJg/7fMP
Riz9jxr4D6xEk7tqK8r+uVWIFVkk6B8RTPNjkAEwxwpNJAWsip3zHDL5erQXk5WF
3ZzF8CFNg86bEi7jsEDiREt9FywIrn9lJ9vozI8MFzmmKeDbPYI=
=puvA
-----END PGP SIGNATURE-----

--b5qimfktp3ivmt5j--

