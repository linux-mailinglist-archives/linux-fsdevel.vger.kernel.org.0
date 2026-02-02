Return-Path: <linux-fsdevel+bounces-76087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HflIw3/gGk6DgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 20:46:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC194D0A86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 20:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38128301492D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0530DEAC;
	Mon,  2 Feb 2026 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utBPvsVE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917330B538
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061420; cv=none; b=bjcRgSPYktIDd02dcY0woAjD7WqIL0hCXZ2tkJl+5lTIhnvK6Xn/2qNB80lTUYvjd4U283IOPN/dk9mkSzjh1wRMQHtXTB4HUfsKWd7sP9+MHqLH5+ZQuXU+XXNhdL2Sbapzfgo4NEfShJjSf73ks6zNZJopFcYiHvJM2X6C8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061420; c=relaxed/simple;
	bh=hq/wkgdPnsy/n7unUoWg2bNDVpMpHe1tPcwYEi7v2Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYYuzhPhRe805pn6cs1LoeNGKgj+4b3DT1pI2oR/r6xfu0LXKB55E9OnSLe5ZHoLf+v29gminDHVwTUBzG80dQoRkg/utonjFU08MSI3nqfwreeXSi6AARyP8rczKiQC8bWCC4HkWs3vqf08SSk+DS55VKWt4qAvG4CJiNCbCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utBPvsVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ECAC19425;
	Mon,  2 Feb 2026 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770061419;
	bh=hq/wkgdPnsy/n7unUoWg2bNDVpMpHe1tPcwYEi7v2Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=utBPvsVEODaRCMfLB7ORx2MPLqLsfljOjbRy6a8CbKkOvkPoWWGDlgbsJ1t9BOUN7
	 SXTnFqw1B8ZBbKyDZ6wZvrzIu+XtWPEC6YX8pkEPoHKlMchwqt7aFWmw4sQ68wmAcf
	 y7IUpHuie9G+JZq7NEzh5Z5OuZTp4pNA5Vzh2Lgl4qjmB/OQ6ETbUjb/8gTB29z/uK
	 cmlsSGKcF9eoFb0UEqGVh+kZNqL7Q73+ElJdDQ1L4JOMBHPfwUFwfbEuGlJZHhk6ks
	 DHE1mvbixEuVLnBXhwN+k5RdKVkRLZgEYJblZeLD7tsGt+j86guUkZSZ1Q4Zhxx80C
	 5Xy+yRY9IXG0A==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6D9F5F40068;
	Mon,  2 Feb 2026 14:43:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 02 Feb 2026 14:43:38 -0500
X-ME-Sender: <xms:av6Aacqc4713DP2VCEM5iEU3nGx90At0PO-Shp-WB0S05uxb8X2a9g>
    <xme:av6AabbZJ6xWyECVYpaWCYXvtBi1KW2_bo7G39p0SDUqE-P9y6VMUjkN0eaxk4yjx
    H5ACX-Yclqyqoe3l_XXDKWqT2Z0MovzcqyNjtVTirQF2zdVqrAIonPq>
X-ME-Received: <xmr:av6Aaf5V-OxVEQ7aGlxoqHrzrOFW-ijFfCDTZyIboC-YhJKqweif2sDYC6ZFQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsg
    hrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdr
    tgiipdhrtghpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsg
    grohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:av6AaWRoQe9VwPYMBlQnL1SkVdwA0x1tw2nKDSWyA0I9U3uE2G8uxg>
    <xmx:av6AafsJijIxdd9W07yMw9SOLzRlEyO3gGmYdGMMfb9Zocc_md8ghw>
    <xmx:av6AaYZ4GGvUFXcYHwUJ4Q5phX5mB35MkDKLX-P9tXhwmD-DNeTugw>
    <xmx:av6AaZ--4frUTtd_I8rDNcRQk-QbMwywmsxTwBjk4ZHdIncliPp68g>
    <xmx:av6AaUph2FTNUmZmEoMPzWEyysX2n6saY4iVUtIJ38MQRhchdQMqCIFF>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:43:37 -0500 (EST)
Date: Mon, 2 Feb 2026 19:43:36 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Orphan filesystems after mount namespace destruction and tmpfs
 "leak"
Message-ID: <aYD7zpZQeeRpy9ho@thinkstation>
References: <aYDjHJstnz2V-ZZg@thinkstation>
 <20260202184356.GD3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202184356.GD3183987@ZenIV>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76087-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BC194D0A86
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 06:43:56PM +0000, Al Viro wrote:
> > I am not sure what a possible solution would be here. I can only think
> > of blocking exit(2) for the last process in the namespace until all
> > filesystems are cleanly unmounted, but that is not very informative
> > either.
> 
> That's insane - if nothing else, the process that holds the sucker
> opened may very well be waiting for the one you've blocked.

Good point. I obviously don't underhand lifecycle here.

> You are getting exactly what you asked for - same as you would on
> lazy umount, for that matter.
> 
> Filesystem may be active without being attached to any namespace;
> it's an intentional behaviour.  What's more, it _is_ visible to
> ustat(2), as well as lsof(1) and similar userland tools in case
> of opened file keeping it busy.

I can only see the opened file, not the rest of filesystem, right?

Do you see the USB stick scenario problematic? It is weird to me that
umount would fail with -EBUSY here, but kill full namespace is fine.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

