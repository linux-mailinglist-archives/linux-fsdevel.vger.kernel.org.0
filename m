Return-Path: <linux-fsdevel+bounces-58115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20C9B298EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 07:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6991D189EB51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 05:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03A126A0D5;
	Mon, 18 Aug 2025 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="u5cu/RKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164F199BC;
	Mon, 18 Aug 2025 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755495104; cv=none; b=Nxh9OOxdfWtuOid/wX1GemjnIgIKY0CaGm/yKwIfBiR4V5aM5MKoZEYqJVCUejsWZP/DMKTViP7YPcnYPiZLVXRaJraFWtznnRlTTD5zbf+TNCwG/ELVQzGJQp3/Qtzh/AJaed7gxLd8nic/bijiLrP8215RnROKoNvCGeCwQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755495104; c=relaxed/simple;
	bh=NfBH7/Ee62pjMpOmYJA3Sx2YYKyVORswUSvb+evmdp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp9MN2LONQrtOyxZf0Q+fNZazYyanzQAA/CrjMEkmnFhOC0fhFOFs25VH7LobKczeVaxdNbLu2rCBNxWaKp9vKG+LbuUxjaO7SFeDI7DBiXWh1iQNzANnC16x0FoMxjnZXVwzZph89r4FM6MqYWJL/1NJqW9vJsuyrOrwku17rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=u5cu/RKM; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c51Y63Lj0z9svR;
	Mon, 18 Aug 2025 07:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755495098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kpXQX+unFOnNS04HN7ZiWoRHNGQv85EMscVXVNZ6kwM=;
	b=u5cu/RKMowvK3lgM4syg+AgCUtfPnqjwHjY7WqjinPlPR8eCRlhTGhBjDWZf7Xob4DKXBS
	jdU544bTmKoLeCC44EqRlsSJTxW0dfNW3rYN+47dshKOKZvIw2tJcZ9knbnW62E7bCgznU
	WOrESitghkoUJ0D388EnxcLK/qsrBKjlG2xjnL/dPWg+oOmF4oqddtwsNUN7l9CUrEAzHy
	S/6CfF3Oy+t1/3bYZRlU5YHq0sxcq+hEgEZrtEgtqxHGikkZA3tB++YuSDylE9paEiaZ3M
	4shvzfb3orsivUA+Vq58Z2s7BVegYtpB85kwdGUcDk8XZGt2qDmNZUAikZKtwQ==
Date: Mon, 18 Aug 2025 15:31:27 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>, 
	linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	autofs mailing list <autofs@vger.kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH 0/4] vfs: if RESOLVE_NO_XDEV passed to openat2, don't
 *trigger* automounts
Message-ID: <2025-08-18.1755494302-front-sloped-tweet-dancers-cO03JX@cyphar.com>
References: <20250817171513.259291-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jykgkqcslnnbmqso"
Content-Disposition: inline
In-Reply-To: <20250817171513.259291-1-safinaskar@zohomail.com>


--jykgkqcslnnbmqso
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] vfs: if RESOLVE_NO_XDEV passed to openat2, don't
 *trigger* automounts
MIME-Version: 1.0

On 2025-08-17, Askar Safin <safinaskar@zohomail.com> wrote:
> openat2 had a bug: if we pass RESOLVE_NO_XDEV, then openat2
> doesn't traverse through automounts, but may still trigger them.
> See this link for full bug report with reproducer:
> https://lore.kernel.org/linux-fsdevel/20250817075252.4137628-1-safinaskar=
@zohomail.com/
>=20
> This patchset fixes the bug.
>=20
> RESOLVE_NO_XDEV logic hopefully becomes more clear:
> now we immediately fail when we cross mountpoints.
>=20
> I think this patchset should get to -fixes and stable trees.

You need to add

  Cc: <stable@vger.kernel.org> # v5.2+

(along with a Fixes: ... tag) for each commit you would like to be
backported.

> I split everything to very small commits to make
> everything as bisectable as possible.

I would merge the first three patches -- adding and removing code like
that is a little unnecessary. I also don't think you need those patches
to be backported, right? (Especially since they are touching stuff that
Al has reworked a few times since openat2 was merged back in Linux 5.2.)

I only think the last one needs to be in stable.

> Minimal testing was performed. I tested that my original
> reproducer doesn't reproduce anymore. And I did boot-test
> with localmodconfig in qemu
>=20
> I'm not very attached to this patchset. I. e. I will not be offended
> if someone else will submit different fix for this bug.
>=20
> Askar Safin (4):
>   vfs: fs/namei.c: move cross-device check to traverse_mounts
>   vfs: fs/namei.c: remove LOOKUP_NO_XDEV check from handle_mounts
>   vfs: fs/namei.c: move cross-device check to __traverse_mounts

This is a minor nit, but could you use something like "namei: ..." (or
"fs: namei: ...") as a prefix for commit subjects? If you merge them
all, something like:

  namei: move LOOKUP_NO_XDEV checks to __traverse_mounts

would be fine.

>   vfs: fs/namei.c: if RESOLVE_NO_XDEV passed to openat2, don't *trigger*
>     automounts

and this one should read a bit clearer with

  openat2: don't trigger automounts with RESOLVE_NO_XDEV

or if you prefer

  namei: don't trigger automounts with LOOKUP_NO_XDEV

>  fs/namei.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--jykgkqcslnnbmqso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKK6rxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/MdgEA3L11gQ26eeut41lKi7q4
7n2gN4rrq2DIZWXWZpHtkfgBANt0yDfXcO5np7+gcF/vq1zJbGDtSicfc16mvHLX
/ysM
=7uJm
-----END PGP SIGNATURE-----

--jykgkqcslnnbmqso--

