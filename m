Return-Path: <linux-fsdevel+bounces-73236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1323D12DCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9114C304067C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D83590A3;
	Mon, 12 Jan 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="C3nW0yFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327A1531C8
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225065; cv=none; b=qamxveewO4tRvaC+8E7rae8qNm3X6lEgeCI6e8P/IDvhxr+DYYy41Ph+17qcaLYgUV3QK/Uv9JBkxELl+58ToS/50hyvDpgxdnSljDfRGrQPKm3lMEvpuN1MppTR4GdQYAKFdktWmbSpUpX6p5vEb8TKPi2Y8zCZYQXfD2QMVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225065; c=relaxed/simple;
	bh=ZOy9UayOdrfOF7TXtrthgpa/VKmO+QHdR22I3PNKD+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqlQVphlrUg+xnr6lTBRLRvAvWMPpuWjL/5aHxfFtV/KcZN0Og3ZH4cM4mpE7do6sbAv+dZvENjWLqlh/76rn/HYEm2HbXZ/JbLGxDU2zdjxZRHIBGDgWpv1Xl3guyLXgeN4sj+V4yuy8tyvbXFWkQDzqGgLzmEACw7NS3DdIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=C3nW0yFd; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dqYN06SB3z9sWs;
	Mon, 12 Jan 2026 14:37:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1768225056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOy9UayOdrfOF7TXtrthgpa/VKmO+QHdR22I3PNKD+M=;
	b=C3nW0yFdA+50WpXRlkUg3Gq3bC89f77Oon56COSnEBdFaRX4kZ6qmcyi4ixtRqXidAIQkl
	2mUbN0bTPr1fonn13AsYWA5Hkk7OE+uGatM8YS5W3ErXcZ8TWcZPXQaOCAA7tqAmwbQKfU
	XmkWlMQIrniWq/lIhCxoBRLbF6yAxQGJaFgYh/4BLOxu7CsuNO0Q4bKJyChu/ZaljULoQg
	lFxjVlBJonr/dRfA2hJZuad2/rLrC9zOKMH9SFxxVj8wnG0DsX9HgTAmU5cKtO+s+4SlI6
	OTZHL8uBKNDTQyT5AjZXhoCWKtH+/rNiqO4G21BXet2TInAZlLi35kdNusBHYw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Mon, 12 Jan 2026 14:37:32 +0100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
Message-ID: <2026-01-12-pointed-no-garb-dram-nwHAjb@cyphar.com>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
 <2026-01-07-oldest-grim-captions-spills-ywC2O3@cyphar.com>
 <20260112-unbeugsam-erbrachten-b86991c19851@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q6rixq6lj3nxmf62"
Content-Disposition: inline
In-Reply-To: <20260112-unbeugsam-erbrachten-b86991c19851@brauner>
X-Rspamd-Queue-Id: 4dqYN06SB3z9sWs


--q6rixq6lj3nxmf62
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
MIME-Version: 1.0

On 2026-01-12, Christian Brauner <brauner@kernel.org> wrote:
> > I think there are a few other things I would really like (with my runc
> > hat on), such as being able to move_mount(2) into this new kind of
> > OPEN_TREE_NAMESPACE handle.
>=20
> As you know I have outlined multiple ways how we can do it on-list and
> then again in Tokyo. There's a ToDo item I'm going to get to soon.
> Around end of November someone asked about related changes again. I have
> the beginnings for that in a branch. I just need to get to it but I need
> to catch up with the list first...

Sure, I just wanted to have an on-list note about that bit of the
discussion.

> > However, on the whole I think this seems very reasonable and is much
> > simpler than I anticipated when we talked about this at LPC. I've just
> > taken a general look but feel free to take my
> >=20
> > Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> >=20
> > and also maybe a
> >=20
> > Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
> >=20
> > If you feel it's appropriate, since we came up with this together at
> > LPC? ;)
>=20
> Eh, well, this rubs me the wrong way a little bit, I have to say. The
> idea was basically just "what if we had an empty mount namespace" which
> doesn't really work without other work I mentioned there. So to me this
> was basically a fragment thrown around that I then turned into the
> open_tree() idea that I explained later and which is rather different.
> So adding a "Suggested-by" for that kinda makes it sound like I was the
> code monkey which I very much disagree with. But I'll give us both a
> Suggested-by line which should solve this nicely.

Of course I didn't mean to suggest you were a code monkey.

You're quite right that this did turn out differently to the very rough
version we spoke about (though I think the same insight about removing
the wasted cloning for mounts that get blown away alleviating the cost
of the contention on namespace_sem applies regardless) -- in any case,
I'll leave it up to you.

--=20
Aleksa Sarai
https://www.cyphar.com/

--q6rixq6lj3nxmf62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaWT5GRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+L+QEAnEp8D461R6EB56rubEWV
fsHKDmY7pD4AErnclZVkYqoA/RZBOX9hmJYCGMEzdPg1HXeGASxf0P0tcdxsG7sE
PfIC
=Rbj8
-----END PGP SIGNATURE-----

--q6rixq6lj3nxmf62--

