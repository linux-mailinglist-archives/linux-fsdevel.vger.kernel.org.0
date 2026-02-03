Return-Path: <linux-fsdevel+bounces-76227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIKdEFZzgmnBUgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 23:14:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29619DF240
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 23:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCB29300B520
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 22:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9761236E496;
	Tue,  3 Feb 2026 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="L5BsyWTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DLqGPN4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91985261B96
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156877; cv=none; b=cYicF15HA0nVvaqcdSmzPK74wzkFoctaKvF7acW8ye5u4wyDnGJ2a7tHnwTpeYQ/+d4xQWMiszlRUIK89fMzqDqlquB0oH/J47S9U67cDOHB64fZRwlTIRI0ZVmIBQhkB6ePn+PK8T3GPDbPSFl1nLIRY6uh8gSu91WnTbdUerA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156877; c=relaxed/simple;
	bh=cmofU9R717atoU9sHxRAhtCwjgkZw7kDnvyGme+nZLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oE20vh5KCG5j/IadSJx1Db+aSg3K+x4MIODjezBRYLDleyQgVxl5/HgSA+dPxCDoX/ZNvPBcLL+1zA+KFndyMNKVkHqTkz4gBJLTPgLRVCj9EP0/Qsm3RMDUOg3nImaKfXX6v3RgD1bdTmAqpsfWI/jjErCP2c5aPsMxJEeJNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=L5BsyWTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DLqGPN4/; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E3F21D000CA;
	Tue,  3 Feb 2026 17:14:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 17:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770156874;
	 x=1770243274; bh=cmofU9R717atoU9sHxRAhtCwjgkZw7kDnvyGme+nZLs=; b=
	L5BsyWTL+ezvnsMT0IMPBsfpNGmzYWmclDJwf7WVb1t0qBog0ZN5GZqCCaId2ppK
	VJOL7DDnPC5sgqUbPmpX7hINKuBWnmFSJtp7Aj74umveiQevtOcYKv5BNrL4Q0R+
	dEwsEmKz6pFEMGglWpgMjA2E6/+wgan+V3nD6vA1z2nWTNSfxnr1K1MlD5WCGTLZ
	j5syVUQIj0HiBPs6w0Nm7Pdauo+9l+osCuSj0t1Jlu6UQb0S4bw26/zCD1/rsZo8
	/di1V3xfrpenJXWNL44qUJRC//oqEVS/oqGsi3rHWKV+lA/D6Hn0HeIGuzM+sJmq
	zMQzut4la0zI9an1Pkye/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770156874; x=
	1770243274; bh=cmofU9R717atoU9sHxRAhtCwjgkZw7kDnvyGme+nZLs=; b=D
	LqGPN4//AyiqkxuqQSZSxHJmWppwNA4PK/c/bPxJBvNezjvTtiZTQnWFWvgbVk2e
	b60eYjPl21c2b2kMvou8FUVLnPjOui4FNW1U8X2HywbzbB32eTHutmhlQshSKLtK
	8VpbYE9cxuBMkFDK1vZ4rm9Zx04/hp08T0vI08/jJb2NU7idCUBOxYwjARN6QGju
	ECDQyvjGrjnduTjQbb6YeypK6fZcmkQnWmksZR6RBoi7ptK9oHNIyYGHJwo8tDq/
	sF/YiZD3n5wmFsSNi3r3qQGfJa+bTQSAnOmDBj7nYQex38cpqmM1xaw43NPcwYk2
	LOq4KAGhrpDg1EYanKzrA==
X-ME-Sender: <xms:SXOCaRYWG5WfidqFFOsW1W3S51-JkTXP1FcmLbOaAQqbRxrIiKBrjw>
    <xme:SXOCacFsGTo-6KDvSqf07wu4p_DCLkyP0fkoF7GLsDCTVu8Bex3HIMYasoIXf9RlD
    Y2Bh9Q7ggf9LburbCuKiJ3BBu5meYn2ImiZnbWuWrypllKEJapi>
X-ME-Received: <xmr:SXOCadwOOH1BBGd3-WFW1lKy0Ii2iUmXhYn8yvh_M0g9KlM1jQ5EBoNb6AV0WKTWYMk1xtIqyyCMkDYW1aWQjudtl1j1wPpInsTTPP-hJcesYJpXVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrd
    hfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudevleegleffffekudekgeevlefg
    keeluedvheekheehheekhfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrd
    hstghhuhgvthhhsehjohhtshgthhhirdguvgdprhgtphhtthhopehmihhklhhoshesshii
    vghrvgguihdrhhhupdhrtghpthhtohepthhrrghpvgigihhtsehsphgrfihnrdhlihhnkh
    dprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:SXOCaWlr9Qy_alY7_b01eELXEmclZ7bSEDmA1zTYYW5z27MOJB6fZw>
    <xmx:SXOCaengQHw7RpQOwUp2RU_zKBtRT-EVYM2gpPsPQAkAMOJeie5TlA>
    <xmx:SXOCaQw4rSWd87jssEVlmuyc1zKQ6EZiuzkxHgxsVPU4VAFeK4CqTw>
    <xmx:SXOCabobNMzI-eU40uAthlWWvTjsswozgrAWt_zUKcWrtKNB8-zTag>
    <xmx:SnOCaat_zxgku1u0uSu1CYoiLTACgxuC3FBxLE_Zvmoi8zFJzpUB7alD>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 17:14:32 -0500 (EST)
Message-ID: <3cc4d93f-a0ad-4069-a6fd-348b11125afc@fastmail.fm>
Date: Tue, 3 Feb 2026 23:14:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
To: =?UTF-8?Q?Johannes_Sch=C3=BCth?= <j.schueth@jotschi.de>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>,
 Trond Myklebust <trondmy@kernel.org>, linux-fsdevel@vger.kernel.org,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link>
 <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org>
 <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link>
 <9ceb6cbcef39f8e82ab979b3d617b521aa0fcf83.camel@kernel.org>
 <CA+zj3DKAraQASpyVfkcDyGXu_oaR9SnYY18pDkN+jDgi54kRMQ@mail.gmail.com>
 <998f6d6819c2e0c3745599d61d8452c3bc478765.camel@kernel.org>
 <3DMb18lL2VzwORom5oMGlQizKpO_Na6Rhmv5GDA9GpN3ELrsA5plqhzezDxDs_UcXaqFQ9qUHb9y4cY4JRy7TjQ108_dVkZH9D2Yj48ABH0=@spawn.link>
 <CAJfpegu5tAFr3+sEQGi6YWGHMEVpVByFoVxzCONERGvJJdk5vg@mail.gmail.com>
 <CA+zj3DLwu20Q-1qUU-o8fSvnz9V_us35uQ5nqi7AEPNwZ=DAbA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CA+zj3DLwu20Q-1qUU-o8fSvnz9V_us35uQ5nqi7AEPNwZ=DAbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.fm,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.fm:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76227-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.fm];
	DKIM_TRACE(0.00)[fastmail.fm:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd.schubert@fastmail.fm,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 29619DF240
X-Rspamd-Action: no action

[Would be ideal to keep kernel style and to post below quotes]

On 2/3/26 19:29, Johannes Schüth wrote:
> Thank you for the patch. I applied it to 6.18.8 and 6.15.11.
> Unfortunately the xattr operations still fail in the same way.
> Note that 6.15.10 was still working for me.
> I included the wireshark dumps [0] [1] from the mount process. The
> access rights show up as:
> Access Denied: MD XT DL XAW, [Allowed RD LU XAR XAL] in 6.18.8


@Antonio, is there a way to get libfuse debug option output from
mergerfs? I.e. to log fuse requests?

I guess that should be simple to reproduce with libfuse (too late for to
try it now).


Thanks,
Bernd

