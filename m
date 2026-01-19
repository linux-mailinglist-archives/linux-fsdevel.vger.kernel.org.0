Return-Path: <linux-fsdevel+bounces-74361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B32D39D79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 05:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08FC0300A855
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 04:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC76285C8D;
	Mon, 19 Jan 2026 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Sbh6Edqy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0ZVnr76k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46FD197A7D;
	Mon, 19 Jan 2026 04:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768796700; cv=none; b=dzwuEEmA3m6wIrAtUsxFUXfEF/qTQDfoytz9wG+Ee9IC/liNEMEe61U6E40u/UIwIZbCStOtWDeLrkDhiQFdVDbi6bi4xFaPOy7fEwt+AWL6cjyaIF/AnnFL/ekbI72OvqDgJKNvzYO+4MJGDON2VMxgQTvgmFGTGfXECyJjDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768796700; c=relaxed/simple;
	bh=HdSZCarGGS3RuGsKep6hC7LR7qDsWU4SWvZnwDUELpk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TkzxGicH5e1G8IAkxj2cS1MnFn0imo2PmiHGCo9G3tcASd/GX9dosQrYC/U0R0zyjdA+D+Vs+XUl0mBJ8rQhVG4HKSJOpk23OrZ6D2l7ysEe21fHUQYRGjPzwBlQjgVc52Ja2fLbN2y1VaSaRcy03uFz5neCpR3lyCgRwZ5jQL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Sbh6Edqy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0ZVnr76k; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BC74EEC0684;
	Sun, 18 Jan 2026 23:24:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 18 Jan 2026 23:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768796696; x=1768883096; bh=w4J1Lzoj001fG0Dd8Z4gKIcNfCsBwsKpnYS
	5sVzQybM=; b=Sbh6Edqy5uN86z9VVPbrNkciPQkfvtZP6HjypI+HJn9mO/S94oT
	xxtkP5iFoDKPRowxx3PmUke9K9f0UgDHwfHqj/wuYnFZRdCJhTuNF5sreetzyXUa
	z9FReR5bNF2emNOftvXsBz+HcXJfIpLoqUT5dJyqHIT/tA1xlGc93gF/dFlFDqNW
	5cP3MkBqrEWU3MWo/oR9KlGuCvlzTHDPQynQp647+2lh3ClHmDZBFSqjVMCn8ZYo
	KK7WGXoacFN7m0s7DHKxz3Cz1HiaprvvbroGSl4Xj9+8MFejY7BY02CgQx42jUHX
	Ll7GRYJAzFokeJS9IHRMZQb3h/7P1lADJYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768796696; x=
	1768883096; bh=w4J1Lzoj001fG0Dd8Z4gKIcNfCsBwsKpnYS5sVzQybM=; b=0
	ZVnr76k17K31SGYBRrq05Vbhv7ngIWaWSRA+S9zWwevbvLlA0dR2Lt3idN0l/GQF
	n0oPnOsXavaEqpwTMNNPj79D3DGaz8jwXn3IYiDfMtN99pgZT6PIZu6NEuabM2Vx
	CK2hgwkD2lHPeJkND92ILUrDruL8gNeFvCgcLeke+BcReia/o+eWlVsjvMPpM7Ow
	S1Ae93f4zvv1v42yqSlchLhtNmDw4TkgzWE+6538wPOCLakc44goB5P9hClKZMjg
	CyZ51n0jssnCOQSr1xMIjAW9dGOyYIm/PGUU8jh4FI6e8PGj9tsCN7wJwF5ECOIN
	Avg5In7Q+vnikD9quTzpw==
X-ME-Sender: <xms:GLJtaRKyEdXzmPqgktMiaigYQypMNuRivdcsJ7ivQlWWgVM9MqioaQ>
    <xme:GLJtaTJ1HzzH6m-2sMPnHidUaDImJi4CGoR2OPlb9uRxH4H7F1wb43xRGETaTRlmF
    JMVR_c0zoleXhWfP1Kqqz8BA_SxfVxRimI0NiBMIeZnF17Gcws>
X-ME-Received: <xmr:GLJtaUg7iNYcfsO2L1KKQUt-OeC5pQizt692kvDVfyPSf89kGooAkjmD9ZReHXJ8fYq1rBewsKkK8bCuSdMhkLVVL6A6ZRvcCQmIShQHZXrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:GLJtaVP-FZaumHFuXl5HiPb_M95k9xVB-eMcFNrlS7YDuiZsfrFMXQ>
    <xmx:GLJtaXqd2qGXKA8WADVZpPKvpB3YYjRC_OfV39wa_LerJnOb0cCF8Q>
    <xmx:GLJtaf4uga64WAdrLRpuVIG4MD6kOsxAinRoCZi384IDqRtuiX_Dgw>
    <xmx:GLJtadh5r-rLEcCz6cczkcqxccA4dqA-3pzd8QLXNrzAOtjkLTk3iA>
    <xmx:GLJtaefUZ4e9Innv7uARva7GUZu9hGJV_8NXw7GTPOL21a9lgCipmVFU>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Jan 2026 23:24:53 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
In-reply-to: <8C67F451-980D-4739-B044-F8562B2A8B74@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>,
 <176861309837.16766.10645274004289940807@noble.neil.brown.name>,
 <8C67F451-980D-4739-B044-F8562B2A8B74@hammerspace.com>
Date: Mon, 19 Jan 2026 15:24:49 +1100
Message-id: <176879668905.16766.5840486885381698639@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 17 Jan 2026, Benjamin Coddington wrote:
> On 16 Jan 2026, at 20:24, NeilBrown wrote:
>=20
> > On Sat, 17 Jan 2026, Benjamin Coddington wrote:
> >> The following series enables the linux NFS server to add a Message
> >> Authentication Code (MAC) to the filehandles it gives to clients.  This
> >> provides additional protection to the exported filesystem against fileha=
ndle
> >> guessing attacks.
> >>
> >> Filesystems generate their own filehandles through the export_operation
> >> "encode_fh" and a filehandle provides sufficient access to open a file
> >> without needing to perform a lookup.  An NFS client holding a valid
> >> filehandle can remotely open and read the contents of the file referred =
to
> >> by the filehandle.
> >
> > A *trusted* NFS client holding a valid filehandle can remotely access
> > the corresponding file without reference to access-path restrictions
> > that might be imposed by the ancestor directories or the server exports.
>=20
> Mind if I use your words next time?  I'm thinking that most of this
> cover-letter should end up in the docs.

Please do!

> >
> > Iterating a 32 bit generation number would be expected to take a long
> > time to succeed - except that they tend to cluster early.  Though in
> > your example the msb is 1!
>=20
> Trond posited that with a 1ms round-trip and 50 parallel GETATTRs it only
> takes one day.
>=20
> > Do you have exploit code which demonstrates unauthorised access to a
> > given inode number?  What runtime?  Could attack-detection in the server
> > be a simple effective counter-measure?  Should we do that anyway?
>=20
> Yes, its a modification of t_open_by_handle_at.c example program in the
> open_by_handle_at(2) man page.  On my single system NFS client and server
> with a local mount, I averaged 16usec per open, and discovered my target
> filehandle in less than an hour.  I didn't have any network latency to worry
> about, but I think it still shows its possible and a determined attacker can
> do it.

This information would be useful to include in the cover letter/documentation.

>=20
> The server could be modified to notice elevated counts of error returns for
> a client and then try to notify about it.   But, I don't think it will be
> simple - I imagine it would need a lot of tunable (how many failed fh, at
> what rate..  etc) because you need to tune the system to make a signal from
> the noise of regular operations and returns.  That tuning can be worked
> around by a very determined attacker.  You end up in a behavior
> detection/modification feedback loop and the server's not guaranteed to
> catch everything.  Still it would be another layer of defense-in-depth that
> would have value.

I would like to explore this, at least for the defense-in-depth
rationale.  Maybe it would also supply some protection wehn sign_fh
isn't enabled.

We would need to monitor the result of exportfs_decode_fh_raw() for
stale vs non-stale, and if the proportion of stale filehandles (on a
given export) exceeds some low threshold (1%?) over a modest time period
(5 minutes?) then .... what?

I don't think a hard fail would be a good idea, but maybe serialise
future requests from that auth_domain and impose a delay on any stale
filehandles until the proportion drops below some lower threshold??

Does anyone else thinks this would be worth pursuing?

Thanks,
NeilBrown

