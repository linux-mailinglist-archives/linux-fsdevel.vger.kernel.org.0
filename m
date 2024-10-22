Return-Path: <linux-fsdevel+bounces-32617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1169AB6EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 21:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C19B237FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D501CB33A;
	Tue, 22 Oct 2024 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAWANvJ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4765B1465A5;
	Tue, 22 Oct 2024 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625704; cv=none; b=gyKl71xXDWrQpu83VBGyr6SOjNHHPiIZZq/k4dC+3NVdiYSD9+SxmpIir8pBcBUsF3ZpA9yFrF9fZkXFgcOm4ycRKcItKbV73twSStp154KpJgvDoR42Tf5dbF+3ATJVQVim7ETwdPT1FHXlK8Zu//SB+baHl6qcOspKn8c5NrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625704; c=relaxed/simple;
	bh=gtbLZJzDgq8gJbvY5QFBkT1+qCeD5zFfv44nG1wRVpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq3+udVRCXytzPYBJMBYPPHcqDRdEJFI2GazisRwAiEaX9ATqnjpiZUm6JOPultgIKtQGcP52jHE5urkaxc0dLJFWKY5IqH1S332PVcWymllxcDX/UwGk6/4qpTogU8u4wTHzLSD5vNRfcJYIIIBjz8kclCfb8C9rJYsvDrr81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAWANvJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213EEC4CEC7;
	Tue, 22 Oct 2024 19:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729625703;
	bh=gtbLZJzDgq8gJbvY5QFBkT1+qCeD5zFfv44nG1wRVpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAWANvJ30xNkibAKRRZAKwV2B0e4DD1qMWDwlFJzvr/5u5jiu0H5UxvvUglAQkPoA
	 wyluVpiytN1Y/kS7IXJ1QzZuAEoXZgneVod1GBxTb6OF4+bzuEaBOKvx6GrjzLIgh0
	 u6H0EzzOaWJARBYLvVrpLD1R2an6AyaaIsaMHuHIm/3fYlsplpBsVHdlFr5QfhiXH9
	 vm31/0qYUZl2bxjJl65BbnM7By3OB3ZsX1pe9R4RnuUwow+AXSz+Is5U5HMj1ijhST
	 N5C+RXPEz5fTn7jI2ghNCGyD1vF/t6+1ZZij8VHVnUahtv4s/ME1qDBmOp1nBTdoto
	 9NTjhL2j3N/ug==
Date: Tue, 22 Oct 2024 20:34:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
Message-ID: <28cd4d7e-c6fb-468e-81f8-35e0591f8360@sirena.org.uk>
References: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
 <Zxf3vp82MfPTWNLx@sashalap>
 <202410221225.32958DF786@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3dorXeFmBZUmzGVK"
Content-Disposition: inline
In-Reply-To: <202410221225.32958DF786@keescook>
X-Cookie: Surprise due today.  Also the rent.


--3dorXeFmBZUmzGVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2024 at 12:30:38PM -0700, Kees Cook wrote:
> On Tue, Oct 22, 2024 at 03:06:38PM -0400, Sasha Levin wrote:

> > --------------------
> > a069f014797fd bcachefs: Set bch_inode_unpacked.bi_snapshot in old inode path
> > e04ee8608914d bcachefs: Mark more errors as AUTOFIX
> > f0d3302073e60 bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
> > 3956ff8bc2f39 bcachefs: Don't use wait_event_interruptible() in recovery
> > eb5db64c45709 bcachefs: Fix __bch2_fsck_err() warning

> And then maybe limit this to 5 or 10 (imagine a huge PR like netdev or
> drm).

OTOH since this is supposed to be only for commits that didn't spend
time in -next perhaps exploding badly is getting the message over
clearly?  Or at least putting something in that makes it stand out that
truncation happened.  It's a constant tradeoff with this sort of thing.

> Nice work!

Indeed.

--3dorXeFmBZUmzGVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcX/mEACgkQJNaLcl1U
h9AIXwf9EuJH9LluQG3fN6NDJeNKyulsgw0ncXtrWaF9uTOo+nFERm3wFAG45iYr
wN51ACMgtJJMBvvLtbIdTfSfNg5C2owWAz6Mb/FzhYZ47zyu7f8WiK8z1/iDbTEg
EtDf+qitqod8lVC1zaLD6n3HcfEvbOsCf8EmwvMgbbibsD2jxHXZ7cb39R5L9nNS
2t0TDuANRCKiOWbjO1AjEqkwQOBaUO6MKqTem0f7WlL62CxUqOn0F7aCX8VOpEma
oCp5hZjNF32ytqrF1vb53ITHJBzh5Xy7/OzzJ2k3klluSq2KDdBPJdDFn6IHuewF
OTfkE2At5l7OxuVkqUPd+lFqsnAi3w==
=7BDL
-----END PGP SIGNATURE-----

--3dorXeFmBZUmzGVK--

