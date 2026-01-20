Return-Path: <linux-fsdevel+bounces-74601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52791D3C53E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B830D56A100
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816913DA7C9;
	Tue, 20 Jan 2026 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Dwxjo6io";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wg6EdD3y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE33B95F6;
	Tue, 20 Jan 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904012; cv=none; b=ZCtoMI0o8tywUECcHf1CIgZx0gRByqbgNQCy8QZZ1ppmmuYIZydA+v2BNb0IG/F/C0tv8ExRzgPylcWSpVDVJKn09uf8DQwMnsx8ooAnV6QT2bpwRCRpA4wlTMWm6qN+xpHKn+er03AXC73FFhuGbS6q5/M7nYBvZMdxkOq1xaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904012; c=relaxed/simple;
	bh=ALTT/FhZVueHdvdw7CcawKanqBJq8j1DzAKbN1TCnmo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bxtAiuKT5o0eiwtgU+4CGgXPNx9Mk0AlvBhkwGl4h/aiMPdsam6V0ljzCYxBxafn+Qml0vEuJFdM0dYxGe3TDMIqny3rjN30kHbwcbfEiHyd+9sSYoEXS0G/Ucehux0JRxFxVUJKShzx8y15wEGglICwM9c1QXyVYA6/F+EsiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Dwxjo6io; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wg6EdD3y; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A1097A04F6;
	Tue, 20 Jan 2026 05:13:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 20 Jan 2026 05:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768904009; x=1768990409; bh=db6Z446wK3J9k5J5WQyWvVH2FA0QkjIGtbh
	GG0U0LeY=; b=Dwxjo6io44nuCfmNvpIzgxY1SMaAsw7FwI1omoCnXOe/gnmSsAB
	WBrtjbyXJlg+aefSF+pQziQmg9C9qXFJJATbLPLchUrppC5wfUevkhkyXcSTU15Q
	PZTsoBcIHgdWlCQhNldBYYTOQPXH7xHqLdmCiqi5Pri7tFgJF2YU7BnL23ecbZ62
	3oyL7MvsXEQfvxHWY4LPdlvh7LVdY+RBW8CwRm1Dru54DW/xt82VBDals7my+C/r
	O+QYZ6vk518GIbQKIUvdl1KgSQFXX4/BP3ygivn3/z1tsLUeT3zpSXZnp/zXB5Xp
	8UbokaU9k34uxkF3FmNtJLAJi8ATUdzkseA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768904009; x=
	1768990409; bh=db6Z446wK3J9k5J5WQyWvVH2FA0QkjIGtbhGG0U0LeY=; b=W
	g6EdD3yibg76llat98CGN2E2/IjAi9ITduDwr0e1b7fxYYbYHKz/m43iduF7SzUe
	/lx25cXHXpr2AxMSk5+77HvOXi0M4iNIQ2Krec4iDSLAPiQQ6evVfxRllG6HWHAT
	quJiidy9rJS4afG9gKLaKGjZz3n0IlkhsRvbHUP0VU3KW7d/Q2RqcD4tiUO/rSM5
	Jxx6UPSwQD7uO2cz0IqtmvtEgvHie3CxTSPuJDQcGO2D0UTnNBCjMQIRSxZZiMW2
	4+r9ck7fUAm2x+kL6KVgF/1HLiZ1Vs/NYt2J/bssdnBG0wdZsCgd8zzNAIvzocJ9
	il+C+BVNuRcgJMsnXrJVw==
X-ME-Sender: <xms:SVVvaXE8PTwyKKkTpnksi2BXg-QKXhaiosIDyrFPu2Oxrn-55DSo1g>
    <xme:SVVvaaW5jjm8ek7P0jzjQ2SHoW__PkrPKSPrFrMDIek31qE2VGGLKJQOKFrfrRDyt
    Lp2pfAvo8FV-xClI43L729mkzLwWnHCcQwIEU5hfy8HHGgaOgU>
X-ME-Received: <xmr:SVVvaT-ya4pNCLLwrnv9iqoREjp9xRqC7uCcxPThNr3AvMl2kqVBL_X5jBgikB0nw9_GaU1kgB-NlHTv5HrdMu7qCcZBH7Z1T3VdGn0Kybmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
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
X-ME-Proxy: <xmx:SVVvaX6PhWhFQMkbodOE8ixY7AvzGtgF-Al5Gf4qkb4S5AQQacBb2A>
    <xmx:SVVvackObJXt-pw9gp5GPl4LRztlFpNxgREU4iTy71PG7mdqlvhVuQ>
    <xmx:SVVvaaFnDwYBT7HfYItoM_XH3u2FYYiXs2bkWyBF8EXTBrGNjcYS5w>
    <xmx:SVVvaT8JZIkvuwct-3evX6gvBsqDTv4Z619lAQn40HCBin1VCipZfw>
    <xmx:SVVvaWZ8cNXjMgYyoGLDs0cbhmQCgPOfz4q9w77h7Xo4Z-PLT4wkYzLp>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 05:13:26 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
In-reply-to: <cover.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
Date: Tue, 20 Jan 2026 21:13:24 +1100
Message-id: <176890400475.16766.10882526298387036216@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 17 Jan 2026, Benjamin Coddington wrote:
> The following series enables the linux NFS server to add a Message
> Authentication Code (MAC) to the filehandles it gives to clients.  This
> provides additional protection to the exported filesystem against filehandle
> guessing attacks.

I've pondering this some more and I think we can get the same result
without any API change, though it would require internal changes to each
filesystem of interest.

The problem can be rephrased as saying that 32 bits is too small for a
generation number as it allows guessing in a modest time.  A 64bit
generation number would provide sufficient protection (though admittedly
not quite as much as a 32bit gen number with a 64 bit MAC).

If a filesystem had 64 bits or more of random bits in the superblock
which are stable and not visible over NFS, it could combine those with
the 32bit gen number stored in the inode and present a 64 bit generation
number in the filehandle which would, in practice, be unguessable.

ext4 has s_journal_uuid which is stable and (I think) is not visible.
xfs has sb_meta_uuid which seems to fill a vaguely similar role.
I haven't looked further afield but it is credible that filesystems
either have some suitable bits, or could add them.

We could add a generic_encode_ino32_gen64_fh() which takes a uuid or
similar, and some corresponding support for verifying the gen64 on
decode.

This would remove the need to change nfs-utils at all.

This would mean the file handles change when you upgrade to a new kernel
(though a CONFIG option would could give distros control of when to make
the change), but nfsd it able to handle that if we are careful.
Lookups from an "old" style filehandle will always produce an "old"
style filehandle.  But when the client remounts they get a new style for
everything.

This is a lot more work in the kernel and requires buy-in from each
relevant fs maintainer, but saves us any API change and so is largely
transparent.

Is it worth it?  I don't know.

NeilBrown

