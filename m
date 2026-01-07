Return-Path: <linux-fsdevel+bounces-72670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58337CFEFCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 18:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A201735D9ADC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E003A9DAC;
	Wed,  7 Jan 2026 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="H/7IjG5m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cyqQoviZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C53A702F
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803645; cv=none; b=lcJfLDkrsB+Qg+r04McqK2XPDQuUPpv+qGyDTXRdmQTz3VDN3m+YRC4rEm1sHep/Mi7VBYRyOpplZmtAS7XeAeG67BI1TPdEaE0Tv0U+bgxCKkhvjg0i9HWA9nVneKzlGo3vH2tLLhim5BbNZsWlDhb/R1ya+5KXo22qjbt0ofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803645; c=relaxed/simple;
	bh=yyFyFKRsdGXMeAQLPqVOrc239vPCkbIxDXQkQJTT7KE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ejVEE/89nZW6+uG+cvBYZZzIcL+HMhqYfYG4J89kYY67SzmCOpYDnPJm6M/sYJ5poYiQ0rU/6Mqng0UtCdIP05iWG+/aySEA8rV/CUwj+r9e3PagrCpMEI0yoc9Fs+3cXOtI336qH7omDpLWQW8zqrn3lZiZ37+8OmNTlTVESEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=H/7IjG5m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cyqQoviZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4857E1400085;
	Wed,  7 Jan 2026 11:33:52 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 07 Jan 2026 11:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767803632;
	 x=1767890032; bh=upr3TIcCS0yiH2n4i4k6q66b2Ko4sNkbeMY+sV3rUH4=; b=
	H/7IjG5mOjP89nDrNOaVdUqQoT4v/H4vQ+s/kZ7s4gPfc8ChgUd51urNQn+RMwwe
	TmcCsqbxK7mbIcYHDkQP4Szqc7XjTbsuAHZbI9GEVyV5BrUhutB0Tr/MYpTCiYsg
	cXJvIaus4niaCLl7gH5/wPiu21VFMgM1Ixc2I/eUY2XMrDmb+1gxySrI1nBPyAgb
	0Hg9P17LIExvr41IvI27TtEeYvmW6X3Q40TKJQ4D6R+l1SfHg28VNPeh0Zcaqrzh
	1oHHlqVI9xYaNzqeI2p5vtmbq+yPYUia6dJdSZt+ac0UJktQLzCTnyP/jisEzYIv
	tCewcogkDMqE9qTQwDAd4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767803632; x=
	1767890032; bh=upr3TIcCS0yiH2n4i4k6q66b2Ko4sNkbeMY+sV3rUH4=; b=c
	yqQoviZnvCl2P8qfgGwtoJjsH7gM5HUoiYeDUgwtsLWqzP+/Idabmp9P09lYdQJw
	VCUC0fRrBLY05VmuhiSBThmOayjN/yuq9HeHfdOenPlbPtWKjWWjp8GFl61t3w6+
	TiITMuvHgARD7DnYWl225A/AypkiIUKDfhulfL2O8pvCuOyh5fNK7vz91WuZFQp3
	C5qtYXumukF9qDtmU5ekfTBGXgE8zA5Ui9pJTcf9j1dMQDtbRM6m5/tCyHcg5ZFJ
	urpI4/wxnZdLTSlsp3/za5aB28AP8tDt1JJEQ59nZAPIbaQZsgHX8WbNJgqXoxwI
	X+jYo9HLFhzEoFFbXszEQ==
X-ME-Sender: <xms:7opeaR11_2iw74tfvfy6faYpZ2iFLFB4UtewVT_u7gbyPnvU1p1sIg>
    <xme:7opeaS6_RzBsFCPZ7TBHNXMxCrmGZIEg3Rm5QDjsJZPCT98Huy_tQD2yQBIapYGM2
    wOJZ8EFkrBIlEaxSuQZKRQRPSnArxViqC3eZ9uw4Z_6WS356_T9FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfveholhhi
    nhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtf
    frrghtthgvrhhnpeetfeelhfeiteffvdehgfduveeijefgveeuveelueeuveeiffffhfdv
    ffevfeeuvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpeifrghlthgvrhhssehvvghrsghumhdrohhrghdpnhgspghrtghpthhtohepuddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtg
    homhdprhgtphhtthhopeiisgihshiivghksehinhdrfigrfidrphhlpdhrtghpthhtohep
    sghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohephhhsihgrnhhgkhgroheslhhinhhugidrrghl
    ihgsrggsrgdrtghomhdprhgtphhtthhopehlvghnnhgrrhhtsehpohgvthhtvghrihhngh
    drnhgvthdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjohhs
    vghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7opeaZZdWKrL9FVsiwVaENuqetkevhwzjw9tZgaMNpOpWGKvAIQgBw>
    <xmx:7opeacRv4TzN5Mqgs3igwFXLt8I8NyVL17IOt0H1cZEHDieT94KWdQ>
    <xmx:7opeaY_J4UaAHVEuD0pSTdvIKKrP8rELfRMJLRpcnMFlfOGl0_ZVkQ>
    <xmx:7opeaci2Ppg7rHPbRVOGNnWhcoHFlWbpUHbKdKi3lDbUzHAG0LY7uQ>
    <xmx:8Ipead5TAw0ebO6pRkD61biuOg5AJKmboZvuY_2Xcp3JyogUxqN0wArh>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 806DD78006C; Wed,  7 Jan 2026 11:33:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AND3byiW2PhB
Date: Wed, 07 Jan 2026 11:33:29 -0500
From: "Colin Walters" <walters@verbum.org>
To: "Christian Brauner" <brauner@kernel.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Lennart Poettering" <lennart@poettering.net>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 "Josef Bacik" <josef@toxicpanda.com>
Message-Id: <c118f890-31d8-4330-a146-8a2e7dd47817@app.fastmail.com>
In-Reply-To: <20260107-gebahnt-hinfort-4f6bde731e0e@brauner>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
 <f6bef901-b9a6-4882-83d1-9c5c34402351@linux.alibaba.com>
 <20260107024727.GM1712166@ZenIV>
 <20260107-gebahnt-hinfort-4f6bde731e0e@brauner>
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Jan 7, 2026, at 5:52 AM, Christian Brauner wrote:
> On Wed, Jan 07, 2026 at 02:47:27AM +0000, Al Viro wrote:
>> On Wed, Jan 07, 2026 at 10:28:23AM +0800, Gao Xiang wrote:
>> 
>> > Just one random suggestion.  Regardless of Al's comments,
>> > if we really would like to expose a new visible type to
>> > userspace,   how about giving it a meaningful name like
>> > emptyfs or nullfs (I know it could have other meanings
>> > in other OSes) from its tree hierarchy to avoid the
>> > ambiguous "rootfs" naming, especially if it may be
>> > considered for mounting by users in future potential use
>> > cases?
>> 
>> *boggle*
>> 
>> _what_ potential use cases?  "This here directory is empty and
>> it'll stay empty and anyone trying to create stuff in it will
>> get an error; oh, and we want it to be a mount boundary, for
>> some reason"?
>> 
>> IDGI...
>
> It's not a completely crazy idea. I thought about this as well. You
> could e.g. use it to overmount and hide other directories - like procfs
> overmounting or sysfs overmounting or hiding stuff in /etc where
> currently tmpfs is used. But tmpfs is not ideal because you don't get
> the reliable immutability guarantees.

Yeah, there's e.g. `/usr/share/empty` that is intended for things like that as a canonical bind mount source.

I also like this idea (though bikeshed I'd call it "emptyfs") but if we generalize it beyond just the current case, it probably needs to support configuring things like permissions (some cases may want 0700, others 0755 etc.)


