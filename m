Return-Path: <linux-fsdevel+bounces-76503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LkyHF8gphWmT9QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 00:37:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC830F85E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 00:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32D3A3004DEF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614B33D6FF;
	Thu,  5 Feb 2026 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHOLfnJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E332C026C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770334660; cv=none; b=XuqUTclVIlZLj0gehgrDY1xCKVT1Pjy1dU1TbsGSHDQ3xmTGPXMALiWDOypzoqfnYSBtGKAcKPo0ip9lvK7j7G85McNGDDa09WvEE6b5VvvXq1K+vmaoCnTHogras9QOa2TZklwX8Ayy5WKTE1KwDtZ2mPP9k0Q5JFpLpNoRNCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770334660; c=relaxed/simple;
	bh=9fsQs8XyfGV7KTfiHy+W3SDSyzHyIaPegIt6rYd4HUQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EPyaqvLCbcC7IrLqOIzQyXntGknJFTVC3fWxOm6WYV/9kYyjIKQYhzo5GaedVxqLaQZIg9VebFqf9cytkmscSCsODu+oIMSv7g1pG3k9U/OyUaQ1E1K9xA1wjEuLoC8+REUpTwBlUDi1oAeFvQuYS6/XzoSuSjN4N/cr21dfh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHOLfnJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D86C19421
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 23:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770334660;
	bh=9fsQs8XyfGV7KTfiHy+W3SDSyzHyIaPegIt6rYd4HUQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hHOLfnJor7JN/Fk+Ipfr8313t5UcmUT4+/bPAdvLFp9KcVAfrJlCXC8jeZxgK7ZKu
	 UAJnyL9LitnG/o8sqDUIAmZimtnaV0qSBIgOgU79OEIu9eSm/a1F+63Ss8jx4Do+KO
	 GuTNTdFKXU2kWHSMSqEK0xI7TaRGf2z9/dNBzYdmxI5vi0m4PDh8FrovW1Nk+1eU7w
	 L3T2TEnWpIExy6AiXi+lNdpEHyiz4EkoyWUyR5/tlqzqSTrFEfdbPk/CLgdk361JYG
	 CkNqnKu1IfP6tZPpZomk3ZcFK+pl4Zk3glIkVSvLvqq9IoPedZOIqQZkJ8PWvoTaiy
	 nw++dTLuaZfVw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E87B0F4006A;
	Thu,  5 Feb 2026 18:37:38 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 05 Feb 2026 18:37:38 -0500
X-ME-Sender: <xms:wimFaezCUfDBlfEYFLVzioBh4Z28aXLdgMUqYRP7In0ecaqYyjkS3A>
    <xme:wimFaVHaDv2KDpCVAjlmDegnwZVQgiqhxr9FnqgPQ0iTm-cn1LuamV8rTKH1VUpnP
    S4FlQLC3N7ywiRAqAgcyzlOnGsGxzXlAqlWr0_YEhESQZKIliMPuYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeiieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrghmvghsrdgsohhtthhomh
    hlvgihsehhrghnshgvnhhprghrthhnvghrshhhihhprdgtohhmpdhrtghpthhtohephhgr
    rhhishdrihhqsggrlhesihhonhhoshdrtghomhdprhgtphhtthhopehlihhnuhigqdgslh
    hotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hstghsihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wimFaamcC7LS6xrIjGsMcMZp71GshtwnFO8kurRootLvqHU_R_jxjQ>
    <xmx:wimFaVjL7i6qC9voVRUaffyClSrEoJlSoaJFyDWh_Iny7Xu1P3fAUA>
    <xmx:wimFaSf_QJSDBvyWiOup5ZVVb7suhF6dRJl3aCXmQQQIReXQvjIQIg>
    <xmx:wimFaVgdy3IKuQ1KTgm-5i6Bwf4XabBaGrrPTB3_TXGXioZM0Cpn-A>
    <xmx:wimFaaxdbiCLgKb98sy8mIrBvP2vGFFF7YXJVyISgZbPkJGq3fwgVK1e>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BF118780070; Thu,  5 Feb 2026 18:37:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag-6jdtruc1N
Date: Thu, 05 Feb 2026 18:37:03 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Haris Iqbal" <haris.iqbal@ionos.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org
Message-Id: <8cf8658a-4cea-45d6-b098-0c44da503e44@app.fastmail.com>
In-Reply-To: 
 <5cfff8c0b44968cf75d74aef17de6dce73e1a26d.camel@HansenPartnership.com>
References: 
 <32e620691c0ecf76f469a21bffaba396f207ccb9.camel@HansenPartnership.com>
 <CAJpMwyg4Etv3qOw2Ur+L9YmWbt7Rw19uTs0=RsRtuORaEOoHnQ@mail.gmail.com>
 <5cfff8c0b44968cf75d74aef17de6dce73e1a26d.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Documenting the correct pushback on AI inspired (and
 other) fixes in older drivers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76503-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC830F85E5
X-Rspamd-Action: no action

Hello James,

On Thu, Feb 5, 2026, at 5:40 PM, James Bottomley wrote:
> On Thu, 2026-02-05 at 17:40 +0100, Haris Iqbal wrote:
> [...]
>> It is an interesting proposal, but I feel the problem statement
>> overlaps with some other, already being discussed, or covered topics.
>> For example, the topic of fixes requiring effort and time of the
>> maintainer/reviewer, and the fact that AI now potentially leads to
>> too many such fixes is being discussed in the following link,
>> 
>> https://lore.kernel.org/ksummit/20251114183528.1239900-1-dave.hansen@linux.intel.com/#t
>
> They are actually pretty orthogonal.  The email is about identifying AI
> tools used in submission.  I may suspect the uptick in the fixes is due
> to the use of AI, but I don't really care.  The problem isn't what tool
> you used it's that the risk vs benefit of actually fixing the driver
> isn't favourable.

Agreed, the fire hose of patches that a maintainer has to deal with
is a perennial problem, no matter the source of the patches.

Seems to me that benefits/cost analysis is part of patch review. But
when using AI for review, you can ask it to do an initial analysis
for you, rather than legislating contributor behavior (over which you
have no control).


-- 
Chuck Lever

