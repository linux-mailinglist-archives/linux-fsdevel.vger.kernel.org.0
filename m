Return-Path: <linux-fsdevel+bounces-58097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F613B29420
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 18:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067BE3B1DC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C02FE07A;
	Sun, 17 Aug 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="O1MSsZkS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25B29A33E;
	Sun, 17 Aug 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755447747; cv=none; b=kVIwfhA5/hS8tlzmD5Pfl4FAnWNVOYuV3pXPPf0uxPKzvL7FsK7lwYa6eSAdbQ2lGF0sUmhLXjsarrb2nno5JeFMY8CZnL7mEhXgoCqjBGpIBY3EkWrPZhMvP7iQiNCj/hMGks0WH9bTE4Lr5D6+298X32Ihi6rSh5uufecnByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755447747; c=relaxed/simple;
	bh=KIM5YXLmotqsp0FR3cUm3XbYsaPEk8+1QkaPNR5E0GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEQmYXlAgXRrN7g2tB4zYOmKD9wDbngYpI1YsNe42VK8PySx2oigzH/vt2YSq/9xqDeaiMVYF67Pt/HDDFSrirV3gbumV6T0wVd/WGjBQZKjqgzljR6aeGaggHddQ5RDU86v6clNwcxFos2J4/bzkcf3s2J9ag2wTuY0P9iTakc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=O1MSsZkS; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c4gvS3406z9t3Y;
	Sun, 17 Aug 2025 18:16:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755447380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIM5YXLmotqsp0FR3cUm3XbYsaPEk8+1QkaPNR5E0GA=;
	b=O1MSsZkSUZfACH72wpUGYxZutyQe9dz2sfXAI4BXZt9+AYKMGMydcHQEiUpe5iy5am055B
	4zgZA+DqY1GctKXuUKZ4KBruHHPiDt6w5YNCNKE+9AiTtaC5kT4FDPQ2Q83PLtVokoP4eU
	rZoN4fhipKKIi7KXtSjZmHD3xHc2RCwBGOtsJs1f8biXdydccijLV0s2kep1XLcgLaFZ2e
	319KHV1wdEJSxj+WAJt2mb6qsPPTIQfP7jjdzoKAaXdrRaEfqTsThfvQsmAwbaiKNxLNPa
	lXKeq/lKBFsRg8GzaYNVO2P2ozo2MDBW1z/5PZOn0SYVXVQD5arjGkzzMl8GPA==
Date: Mon, 18 Aug 2025 02:16:04 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: alx@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	g.branden.robinson@gmail.com, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, 
	mtk.manpages@gmail.com, viro@zeniv.linux.org.uk, Ian Kent <raven@themaw.net>, 
	autofs mailing list <autofs@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Message-ID: <2025-08-17.1755446479-rotten-curled-charms-robe-vWOBH5@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250817075252.4137628-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ehbyzqii53i3kbg"
Content-Disposition: inline
In-Reply-To: <20250817075252.4137628-1-safinaskar@zohomail.com>


--3ehbyzqii53i3kbg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
MIME-Version: 1.0

On 2025-08-17, Askar Safin <safinaskar@zohomail.com> wrote:
> I noticed that you changed docs for automounts. So I dig into
> automounts implementation. And I found a bug in openat2. If
> RESOLVE_NO_XDEV is specified, then name resolution doesn't cross
> automount points (i. e. we get EXDEV), but automounts still happen! I
> think this is a bug. Bug is reproduced in 6.17-rc1. In the end of this
> mail you will find reproducer. And miniconfig.

Yes, this is a bug -- we check LOOKUP_NO_XDEV after traverse_mounts()
because we want to error out if we actually jumped to a different mount.
We should probably be erroring out in follow_automount() as well, and I
missed this when I wrote openat2().

openat2() also really needs RESOLVE_NO_AUTOMOUNT (and probably
RESOLVE_NO_DOTDOT as well as some other small features). I'll try to
send something soon.

> Are automounts actually used? Is it possible to deprecate or
> remove them? It seems for me automounts are rarely tested obscure
> feature, which affects core namei code.

I use them for auto-mounting NFS shares on my laptop, and I'm sure there
are plenty of other users. They are little bit funky but I highly doubt
they are "unused". Howells probably disagrees in even stronger terms.
Most distributions provide autofs as a supported package (I think it
even comes pre-installed for some distros).

They are not tested by fstests AFAICS, but that's more of a flaw in
fstests (automount requires you to have a running autofs daemon, which
probably makes testing it in fstests or selftests impractical) not the
feature itself.

> This reproducer is based on "tracing" automount, which
> actually *IS* already deprecated. But automount mechanism
> itself is not deprecated, as well as I know.

The automount behaviour of tracefs is different to the general automount
mechanism which is managed by userspace with the autofs daemon. I don't
know the history behind the deprecation, but I expect that it was
deprecated in favour of configuring it with autofs (or just enabling it
by default).

> Also, I did read namei code, and I think that
> options AT_NO_AUTOMOUNT, FSPICK_NO_AUTOMOUNT, etc affect
> last component only, not all of them. I didn't test this yet.
> I plan to test this within next days.

No, LOOKUP_AUTOMOUNT affects all components. I double-checked this with
Christian.

You would think that it's only the last component (like O_DIRECTORY,
O_NOFOLLOW, AT_SYMLINK_{,NO}FOLLOW) but follow_automount() is called for
all components (i.e., as part of step_into()). It hooks into the regular
lookup flow for mountpoints.

Yes, it is quite funky that AT_NO_AUTOMOUNT is the only AT_* flag that
works this way -- hence why I went with a different RESOLVE_* namespace
for openat2() (which _always_ act on _all_ components).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--3ehbyzqii53i3kbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKIARBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+6jAD8D/4PVcL1t2EdmyrkWIjh
tZdIr+KBTQShh2El79nxd/kBAI86sq1SaVvAQXne/CgcAKpQU02tGwiNbAgNEi3f
hNMH
=jA3t
-----END PGP SIGNATURE-----

--3ehbyzqii53i3kbg--

