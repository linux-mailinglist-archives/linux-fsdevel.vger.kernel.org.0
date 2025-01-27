Return-Path: <linux-fsdevel+bounces-40156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A65DA1DD7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 21:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1726D3A4FC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 20:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E9C198857;
	Mon, 27 Jan 2025 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZbD8sm/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5192194C9E;
	Mon, 27 Jan 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738010336; cv=none; b=CU/W7fb8XA8Yzjdb51F12Z2AUOA3Gmc0O1Lt8W9kwpcB7uzmily0WNbOlLzBng8deL7dbsJJR8RZs5CyhHGVcQgyO4gr0N1mOWEfPr9UPmklAHLFnwAB+kfn3gdkLF7Pe80oQemxsR3A3Jh9+KSM50YEYLqOMMMgKQoz+Xon/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738010336; c=relaxed/simple;
	bh=9tjZPyiG0CmH9pRlCoosP8bUzk3qx59WBw4tH4dadiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyYJfgB+1FA5HEpAuSbuIJ+FGZzOP8kO8/SMHHilwbIcMe/KP7+kAPYzHvecXhXWi5UGv5+umQb84uoRZ6+AZxA+m9wlgzn/yDZpuvqVRhmqFR2K5p2MnDkDd/sMfxMs7E/cEy+ppuSoUQcMYz5m2O75RiRn9dHbT6KCqpnq3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZbD8sm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E69C4CED2;
	Mon, 27 Jan 2025 20:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738010335;
	bh=9tjZPyiG0CmH9pRlCoosP8bUzk3qx59WBw4tH4dadiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZbD8sm/enLtb50S3/sC87UUtXcxRREEbj/loA72eJZLsVWJaPpOa01XYxNP8XBKg
	 bCUJ9cbj3U7i4WYN8SD/nxDaPWzWhAt4rBT0JX4ii0vsRGem/4gt3i9iph5edPpMG9
	 cRXoMdrD9784ZythEXhabCuQ3NH2oi22zSMXyt9uV7WTXC/zPoUHv/8sY5OtLQDc/5
	 eqntQjr0H0hpBNAeWXiUG3DNnHOM08VE5mXSey1c64xFG89EVqISiyuPCOEpqEM9Uu
	 99jbjYzpFMVv87SiLQ/Zz0FropeXA5ShOBi5Aa1YDe2cb7s+p8AScOoi4fVpXpznU5
	 vlXFolXXRZ5ZQ==
Date: Mon, 27 Jan 2025 20:38:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>, kernelci@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <804bea31-973e-40b6-974a-0d7c6e16ac29@sirena.org.uk>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <CAHk-=wh=PVSpnca89fb+G6ZDBefbzbwFs+CG23+WGFpMyOHkiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sjhhmSXafkPDKpEd"
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=PVSpnca89fb+G6ZDBefbzbwFs+CG23+WGFpMyOHkiw@mail.gmail.com>
X-Cookie: Printed on recycled paper.


--sjhhmSXafkPDKpEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2025 at 11:12:11AM -0800, Linus Torvalds wrote:
> On Mon, 27 Jan 2025 at 09:19, Sasha Levin <sashal@kernel.org> wrote:

> > With this pulled on top of Linus's tree, LKFT is managing to trigger
> > kfence warnings:

> > <3>[   62.180289] BUG: KFENCE: out-of-bounds read in d_same_name+0x4c/0xd0
> > <3>[   62.180289]
> > <3>[   62.182647] Out-of-bounds read at 0x00000000eedd4b55 (64B right of kfence-#174):
> > <4>[   62.184178]  d_same_name+0x4c/0xd0

> Bah. I've said this before, but I really wish LKFT would use debug
> builds and run the warnings through scripts/decode_stacktrace.sh.

> Getting filenames and line numbers (and inlining information!) for
> stack traces can be really really useful.

> I think you are using KernelCI builds (at least that was the case last
> time), and apparently they are non-debug builds. And that's possibly
> due to just resource issues (the debug info does take a lot more disk
> space and makes link times much longer too). So it might not be easily
> fixable.

They're not, they're using their own builds done with their tuxsuite
service which is a cloud front end for their tuxmake tool, that does
have the ability to save the vmlinux.  Poking around the LKFT output it
does look like they're doing that for the LKFT builds:

   https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-8584-gd4639f3659ae/testrun/27027254/suite/build/test/gcc-13-tinyconfig/details/
   https://storage.tuxsuite.com/public/linaro/lkft/builds/2sDW1jDhjHPNl1XNezFhsjSlvpI/

so hopefully the information is all there and it's just a question of
people doing the decode when reporting issues from LKFT.

> But let's see if it might be an option to get this capability. So I'm
> adding the kernelci list to see if somebody goes "Oh, that was just an
> oversight" and might easily be made to happen. Fingers crossed.

The issue with KernelCI has been that it's not storing the vmlinux, this
was indeed done due to space issues like you suggest.  With the new
infrastructure that's been rolled out as part of the KernelCI 2.0 revamp
the storage should be a lot more scaleable and so this should hopefully
be a cost issue rather than actual space limits like it used to be so
more tractable.  AFAICT we haven't actually revisited making the
required changes to include the vmlinux in the stored output though, I
filed a ticket:

   https://github.com/kernelci/kernelci-project/issues/509

The builds themselves are generally using standard defconfigs and
derivatives of that so will normally have enough debug info for
decode_stacktrace.sh.  Where they don't we should probably just change
that upstream.

--sjhhmSXafkPDKpEd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeX7toACgkQJNaLcl1U
h9Bl1wf9Fadxqmm7XmkrjT1PLaIqtE/38tRkeeggPdC7tWcWp1hXzsP9qtaBuIuE
VM7QqeKyG2kEFH0tAI1m9T6PDxGduwm5mPHg0fBDl812K6IuM2IhkhR5t6NVL9lb
8KPk8WsoIbLVBgLS83MKi9HAMKgDeCwukoq2Np7U6xbHpRTd5G+MU5/bB+iG5Zcl
7mi+mELt4NUi4PX5u/cVGxXT4Fa9VKUmdQ6NMbyoU3XtALcZtz76nY26qU85NIwB
FwPibKc5uabpnNBq3vVp2JxrLs5MZka2ZRtSlWKHwaC+22cODiwNB92oy0FfIswK
smPi+2HS2jokfcL0PejZ5sCuHgmojA==
=FysA
-----END PGP SIGNATURE-----

--sjhhmSXafkPDKpEd--

