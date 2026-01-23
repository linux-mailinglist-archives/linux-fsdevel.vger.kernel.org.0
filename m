Return-Path: <linux-fsdevel+bounces-75290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oONjNkeAc2ncwwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:05:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D176A5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67F76302A9E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827D314A70;
	Fri, 23 Jan 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="q2gkz5Dc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yoBmesHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29C2F25F5;
	Fri, 23 Jan 2026 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177132; cv=none; b=teyGkw1RdGNZVHVo2qjGwP25Vv5ORdRnmHkwm2zxRr/PXQSw9bNRrazWxchdv+4Ne+23hbUG0J22jiyaQy4WtKx4eBJWhIxpAUI7LJOJ/c11Z18XYMY2sQSvBQUenJkW3wdoexkw48xs/asC6h3HtGDw63lHE+WWPztrVgHFJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177132; c=relaxed/simple;
	bh=OQTaSMcIAF6bWQVY1JH9xFAwvj0Vzr+7o82NCYOHOMo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IlKqi4K1U6dylsbB33qKrhTBBWP2iUeQhxghq3kR4yqvDnUnVcfNz+dFSxT90OxTPO0Q0OH7dXfg6MpY5+HQxr6LVVMX+qk/4LZjozyvYk0w5PNrQ3mOm0QNtB4r/X7nOVeJFkAxnR/5X+P6O9c1akNThDOeaQoAG04ck9PoZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=q2gkz5Dc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yoBmesHV; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CB5B14000F9;
	Fri, 23 Jan 2026 09:05:29 -0500 (EST)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-01.internal (MEProxy); Fri, 23 Jan 2026 09:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769177129;
	 x=1769263529; bh=pk4oWxexOPz3HPbfz++uzPI9ag55319aFMsCTEBhc5U=; b=
	q2gkz5DcSxCbSeOjN5g0sbSKnVvw+CX36k/p62NVNI+5h0B5gX8vd5wZ4sghUaWz
	VtKgKy2w5VAj0tJlitRH5QLRMbGqUni0Yyw7TUBlUrThfzKdjwzJufIKbbNX0RAR
	y/krEe6f/qc2Q2kvjkOllVa55xivN85txXJ8nzzAgYwzbIzHzbcdXAFvJgQ498Et
	9JrB9QwUAC9Jday1UFYY/iWFBnNiMnxfY+as7AITLLKvgN48fUZLgrZvcY5a7jNr
	2Mls3VPwtAxIy2IH/NqZkvHv349uVBbQVPUaMWVCmgdz5ELbJrolRYTbFg9DbXJk
	kYBeaTBm+1vGYpl0Opayhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769177129; x=
	1769263529; bh=pk4oWxexOPz3HPbfz++uzPI9ag55319aFMsCTEBhc5U=; b=y
	oBmesHVBwPU7gcdupKiDZND4UYtTsHcNacV7KKEKEkpthLB/jDQPFnn648NPXDEP
	CnhN0VbxONWY1/k8871CH7LqD9nvg5OGV6kIsnKFvWU7VDz/DNJGj8zI3yEuVTJV
	5CwSglIOLJTlLc290LZqhSORD/Sx5eVXA165U1wTRw2l8BmPftXcwIHxjkNsReyd
	GK6C0hH/4uTlUM4kQdQZHVIdaoWJqPWRn6xk5qrbE42rIwtuHNgewvNt46V4W0gQ
	pSm5p4docfYLyTMQJ499b3XpsuyWsfjXw58OCNeU3Mvaa28ot95xLcDNS3fv+hMR
	y7vVn7Kemz3ojt5JlAoFQ==
X-ME-Sender: <xms:KIBzaWqdDXfuMEEUBW2V8ADWnSoHSxvVj18PLXrHh2NgaxUue4zIrA>
    <xme:KIBzafcVgNE9IT8ciDM2KdZb17jbTnffLdFwCp_8V-DECuwpoazrqqVxz8BPxrC2D
    798s33feAbI-QKD5FreyoWn1OT0ZTiYiC5WqVppNyMKxdwCGhfwlTqu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfkggrtghk
    ucghvghinhgsvghrghdfuceoiigrtghksehofihlfhholhhiohdrohhrgheqnecuggftrf
    grthhtvghrnhepffffleeihfekfeetheeiieelueffleegvdejgffhhffhheehgfethfeg
    jeduueehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epiigrtghksehofihlfhholhhiohdrohhrghdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghlgieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrlhhirghs
    sehlihgstgdrohhrghdprhgtphhtthhopehlihgstgdqrghlphhhrgesshhouhhrtggvfi
    grrhgvrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohep
    lhhinhhugidqrghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vhhinhgtvghnthesvhhinhgtudejrdhnvghtpdhrtghpthhtohepvhhirhhoseiivghnih
    hvrdhlihhnuhigrdhorhhgrdhukh
X-ME-Proxy: <xmx:KIBzaSI7MKRfwSPzWuIvZru1sztCVWb2QCpWNUrCqtbYJrpMAlsNRw>
    <xmx:KIBzadO6dm10MSlaRDDV4pklt47xIlHVFlr1HScr979E18UMTCglpQ>
    <xmx:KIBzadX1CNiBZtLldvxJdVWZaCDh7ONfS8Y45_5XwOQjrpu8sVwknw>
    <xmx:KIBzaTmBDDj5AOHE23EQmEXMAmRpZv2A_jT__3QC9BMX1RSSXeNrTw>
    <xmx:KYBzacb75xHFEE542UKSAmpoH-DO3nrA_Tcpgm0gukapnHhZS_4fqUfE>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 874E1C4006E; Fri, 23 Jan 2026 09:05:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANFeMez8yEXZ
Date: Fri, 23 Jan 2026 09:05:08 -0500
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Alejandro Colomar" <alx@kernel.org>
Cc: "Vincent Lefevre" <vincent@vinc17.net>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Rich Felker" <dalias@libc.org>,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 "GNU libc development" <libc-alpha@sourceware.org>
Message-Id: <29f34ba2-a059-4d7b-891b-d2e8c4ed7754@app.fastmail.com>
In-Reply-To: <aXLGdWGTrYo1s6v7@devuan>
References: <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx> <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <aXLGdWGTrYo1s6v7@devuan>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from POSIX.1-2024
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[owlfolio.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[owlfolio.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75290-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[owlfolio.org:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack@owlfolio.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 507D176A5B
X-Rspamd-Action: no action

On Thu, Jan 22, 2026, at 8:02 PM, Alejandro Colomar wrote:
> On Thu, Jan 22, 2026 at 07:33:58PM -0500, Zack Weinberg wrote:
> [...]
>
>> (Alejandro, do you have a preference between -man
>> and -mdoc markup?)
>
> Strong preference for man(7).

OK.

>>               close(),=E2=80=9D below.
>
> Punctuation like commas should go outside of the quotes (yes, I know
> some styles do that, but we don't).

Will correct.

>> HISTORY
>>        The close() system call was present in Unix V7.
>
> That would be simply stated as:
>
> 	V7.

Looking at other really old system calls (fork(), open(), read(), _exit(=
), link()),
they all say "SVr4, 4.3BSD, POSIX.1-2001" and that's what this one said =
too,
before I changed it.  I think I'll put it back the way it was.

zw

