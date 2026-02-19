Return-Path: <linux-fsdevel+bounces-77716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MTeGsAgl2nwuwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 15:40:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB57715FA5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 15:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 977CA303323C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74501340295;
	Thu, 19 Feb 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgK9N2vG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7133FE34
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511843; cv=none; b=e66GeV32EGMqYibIRTUdiNc4SRNk8b5vPNcJvgJsXGpRDI8PXXaLXhJDWrgeu10bNHOAzTemdMdk5H5dBLSl3gSV87zCV7Djn3eAlLZewXyER5spKnXZjJ7b09N0jfFr9gNpWx8xmm3oMScBvySTIDLTZkvWse8KFmrd7uY/E1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511843; c=relaxed/simple;
	bh=DSPahkdo8ILvWgbqPcBLidO0ahLMj0bm+B9KJZLcXng=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KjXPTn0jmQdT9NeXR2O4s50kvbzqcC0/1ZXFayxynFyh8eOHauJBHV0HqEIryQkzthd5n/GnSICMlpiRuojFjP5E1NHW3fNEOJ8SvWzKTxILV2ZEnYN89vfPfpIGTbjPe3517cp0Wa+GZCxfQJ4LeDhCVd0T1hh9HEQIT9/Cs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgK9N2vG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33817C116C6;
	Thu, 19 Feb 2026 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771511843;
	bh=DSPahkdo8ILvWgbqPcBLidO0ahLMj0bm+B9KJZLcXng=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=mgK9N2vGT0j/gYwwuROJyc51CF9k9zZ/XdOM8E3/LiRluv0G4H1AkHnZ94Z5qd+kY
	 tEMSoQmJudOevnK71f/KJ8UpQj/IhQPVCuHG0oAa9lsTYv/nPYL9XeTWuh55reh/69
	 CR9nKnj/GQ/MH+EfFYCSS+rUL1UaIiqa2xS8wHF4D+zXRHoBNLUAaawsKabi8iKzVd
	 X3IMAMQyr6wN9fQgsEJBo96rdU8W747tahfA2lNg0XhrR7uqGcBu9aOYcRwtM+poQ4
	 9xkz149b6j09iZqwLRdqgZ5w9Mz0BX4KLYNODk1FLMd5VnfysIsHPHk5bcVq2A/BhF
	 Grr2w2mWIT3mA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F11C8F40068;
	Thu, 19 Feb 2026 09:37:21 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 19 Feb 2026 09:37:22 -0500
X-ME-Sender: <xms:ISCXaVq2GU4tF0_E43cqX7gcndxIw_m6wLgKAGif2z2cs1sY4BmybQ>
    <xme:ISCXaSdUTl2Ge5gOdPsGG67kb7U5qQL7GwgvPUtZG1yqGaHZFryDIjTA4NX-E2oOK
    xKrrbt8D0Wafe4w5dWGugm70pwjYeVBt5WwEFTjlNLWVAg46URNjm4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheehjeelgeffffeihfduudevudeghfehheefhffgueeluedufeetjeduhfdukeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlshhfqdhptgeslhhishhtshdrlhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhig
    qdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ISCXaTOhbMvu8CZlz-kAPnHF4vbToDLtDgwqhnfWEOoObxhtGF3Qbg>
    <xmx:ISCXaeH1qRWQ32rq8-znAIA7qnnKSzhxpW5kKGenZDKYDtblwa7HUw>
    <xmx:ISCXaaPghCMDXpF-MRGqCZ2M9CizKgqKbHYoNuA1I45m6ieiLjKNyQ>
    <xmx:ISCXaf_X2FQ4b_2lBd5v0vTWgk4G_XS0l6JHf0M1OCFlSThQyRm4Yw>
    <xmx:ISCXaWQfYaFwwUnnNGW3gkrSdN_h-ch8prOb4O3EOl7TaUtQ22QQ4ESW>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D1F13780070; Thu, 19 Feb 2026 09:37:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AF-UQ4tyUUpo
Date: Thu, 19 Feb 2026 09:37:01 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Theodore Tso" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
 lsf-pc@lists.linux-foundation.org
Message-Id: <b62498ba-51d1-47c1-8657-b8d2f4dbd979@app.fastmail.com>
In-Reply-To: <20260218150736.GD45984@macsyma-wired.lan>
References: <20260218150736.GD45984@macsyma-wired.lan>
Subject: Re: [LSF/MM/BPF TOPIC] File system testing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-77716-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB57715FA5C
X-Rspamd-Action: no action


On Wed, Feb 18, 2026, at 10:07 AM, Theodore Tso wrote:
> I'd like to propose a perennial favorite file system testing as a
> topic for the FS track.  Topics to cover would include:
>
> 1) Standardizing test scenarios for various file systems.
>
>    I have test scenarios for ext4 and xfs in my test appliance (e.g.,
>    4k, 64k, and 1k blocksizes, with fscrypt enabled, with dax enabled,
>    etc.)  But I don't have those for other file systems, such as
>    btrfs, etc.  It would be nice if this could be centrally documented
>    some where, perhaps in the kernel sources?
>
> 2) Standardized way of expressing that certain tests are expected to
>    fail for a given test scenario.  Ideally, we can encode this in
>    xfstests upstream (an example of this is requiring metadata
>    journalling for generic/388).  But in some cases the failure is
>    very specific to a particular set of file system configurations,
>    and it may vary depending on kernel version (e.g., a problem that
>    was fixed in 6.6 and later LTS kernels, but it was too hard to
>    backport to earlier LTS kernels).
>
> 3) Automating the use of tests to validate file system backports to
>    LTS kernels, so that commits which might cause file system
>    regressions can be automatically dropped from a LTS rc kernel.

As a subsystem maintainer of kdevops, I'm interested in the topic
of shared FS testing infrastructure. These talking points seem
relevant and valuable.


-- 
Chuck Lever

