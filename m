Return-Path: <linux-fsdevel+bounces-75144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPpMNOR0cmlpkwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:05:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF36CE10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7326300B9E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20336F42A;
	Thu, 22 Jan 2026 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmdtNk10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0159288535;
	Thu, 22 Jan 2026 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108572; cv=none; b=l0jEHI8XwbZl1d9KRrz0A8Vcs7KUYp+VXUzpIjJCPmOM+Mos4NjT8AJm6dRD/PH5WL3Wyz5emaOva0U/iKgfVsWYlVwVC9yGWd2sFg5glBhrYZAoXqdEPzfvco75P9P8Kiecy+yBjbnZG/GDU28dirEUCqGosCWWIwcRvqPGdQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108572; c=relaxed/simple;
	bh=ce50hnOQNrf+9Fc6360+QPsx3Q1PXwDGAYQhSaIzh90=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LaLXdhKCDvusPl81f45/qDCTk024rsKIqjqssHfT6loIxH3Th7C3TKAi8wGz+OR+iuxjC3wlW90F3d5FMue9Wp6ow8U5+ozii8pP8LAsMw+YRPxWWg/3RwC/b400vcYsvboq7Yzx7mlnHUjOf8A5nE2pbQERO55kvfYpbLRYpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmdtNk10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFB7C116C6;
	Thu, 22 Jan 2026 19:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108571;
	bh=ce50hnOQNrf+9Fc6360+QPsx3Q1PXwDGAYQhSaIzh90=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kmdtNk10ACp5PRa2QHgt+bgwtt1ZsP3jA6yv01ZYFyIPhqEFJGLkYt/trdQnbiv6t
	 BtdCNnf0BOo7DRMOmGwvIsdAxP35gQo7b+nUIrRxjzmqyMQMMn7DUGnH4cUzF7L1QA
	 JvipZI5f3/dt+j4Y2wd/ktIVEFkQ1cqHw4yL/2A4vaKZpmtJNRFQTyW1TPcAwNcpPy
	 QMAZDdoNP4A9dev7hQ6M2gVs9cPk53JEcNefUd4DdYx4RLgnd2UtDqa7WJtEL7jn05
	 RB0m0L2LyCZ19G/R8O9k43/Pr6S+BaGJ1uJRr48TlacPdo0YjREj5Kvtv8RE3ZbWAh
	 Isa93vDfpsWNQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id EBD90F40068;
	Thu, 22 Jan 2026 14:02:49 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 22 Jan 2026 14:02:49 -0500
X-ME-Sender: <xms:WXRyacIwDbC-MJ2delOQLvOP4h0mRiAwKsOcm-GNvzsy5xWhc4IF0Q>
    <xme:WXRyaW_i0tnjMWSvlG_khTj33spWmFYdZpS4fZJ8u6lbOiPRv90P0obn0bnR78p3c
    jFiV9d712_Y-5NEi9ANWggux1MrX8o47FwqJ-UKUxzL9QSnLLXaeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprhhitghkrdhmrg
    gtkhhlvghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggtohguughinhhgsehhrghm
    mhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:WXRyadxPaNLj8AmS8DVt037xNa96N1aGk7BmVC004wPwS2oZWTkZKA>
    <xmx:WXRyaZETK3Ld9b_U9TBAN6UQ3IsX6D3H6hhIsXKx-beQqdqbfc7aAA>
    <xmx:WXRyaSvU6N_0apHAdLsxfjldgd52nMmUusz5ZHONulNwbP4I4DkRMA>
    <xmx:WXRyaZA1E5nCHWwGi7xcY4KjazW3a5SrHyIWwUfG6zGfakKGYzpwoQ>
    <xmx:WXRyadDEl_b39geJfP7ttqm1VDfFJHL65vkoZfQJl55D5M1pr-zWG0FR>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CF5D7780076; Thu, 22 Jan 2026 14:02:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1vGOqVGteog
Date: Thu, 22 Jan 2026 14:01:43 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-Id: <df581ada-007b-4729-8ac0-19be90dcbfd7@app.fastmail.com>
In-Reply-To: <6D390E12-0EF1-4830-A67F-9C8614E924B7@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
 <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
 <b4b88c29299dde052a8864e7104a40eb616a26ad.camel@kernel.org>
 <6D390E12-0EF1-4830-A67F-9C8614E924B7@hammerspace.com>
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75144-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 64CF36CE10
X-Rspamd-Action: no action



On Thu, Jan 22, 2026, at 1:20 PM, Benjamin Coddington wrote:
> On 22 Jan 2026, at 7:38, Jeff Layton wrote:
>
>> On Wed, 2026-01-21 at 17:56 -0500, Benjamin Coddington wrote:
>>>
>>> Adding instructions to unload the nfsd module would be full of footguns,
>>> depend on other features/modules and config options, and guaranteed to
>>> quickly be out of date.  It might be enough to say the system should be
>>> restarted.  The only reason for replacing the key is (as you've said) that
>>> it was compromised.  That should be rare and serious enough to justify
>>> restarting the server.
>>>
>>
>> This sounds like crazy-pants talk.
>>
>> Why do we need to unload nfsd.ko to change the key? Also, what will you
>> do about folks who don't build nfsd as a module?
>>
>> Personally, I think just disallowing key changes while the nfs server
>> is running should be sufficient. If someone wants to shut down the
>> threads and then change the key on the next startup, then I don't see
>> why that shouldn't be allowed.
>
> Sounds good.  Chuck are you alright with this?

I hadn't thought of the "nfsd.ko is built in" case. Oops.

Yes, I think it's fine to keep the fh_key value locked only while
the server is running, much like most of the other NFSD settings.
It might be the best we can reasonably do, and it will certainly
be easier to document!


-- 
Chuck Lever

