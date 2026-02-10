Return-Path: <linux-fsdevel+bounces-76858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD9bJUFli2kMUQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:05:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ADC11D863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0F5430416C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAA132860E;
	Tue, 10 Feb 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKwpFmlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA74326D5C;
	Tue, 10 Feb 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743080; cv=none; b=u6Rtscmdu0GESzNHIIT1unbB3CP+afh4rjfFoUX7KzqwsfFEN24wV6OxjkDFAiAyPvVRv9YUy6Iff26yqXI4bposzx9Rr+6naTh/Uu+tCvIfasyJAYo0ADikwxME8X8WOM2D3zyO5j05XsZjDGIxjU7O+ymepP3N8a0ObEYA4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743080; c=relaxed/simple;
	bh=dQ+qQt8F250LyWvI9EH+vTGCpALOeZQlyqCKfc83a5w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BE9y4Ye/l2FiQyGZa+uegpzYu1qXqk5aDZqDtX3BsttPyFZmeLJuRKab7KqNQLeSmEOlTtWudLLkVko+UvJup+9muE4gwrMeMFKEaibm7ukf1/O6B6CqXe+w9+cnRb2/AgwNgTqa4oipZ2atYzk0U6MlbMPcZNo2WdgNEPAbtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKwpFmlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF94DC116C6;
	Tue, 10 Feb 2026 17:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770743080;
	bh=dQ+qQt8F250LyWvI9EH+vTGCpALOeZQlyqCKfc83a5w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iKwpFmlGrx3dNzKtBrcy+0L6jBuJeHzXzLZfvshGLg+LE9bKtIOy8MmlqOp4jfVxw
	 esrnQjtoZ8hWpgMxswejU7AuISTDI3t3zgWijPdsLqj/XFnFEQhWznVQHAGWMBcECg
	 tdVmoFzO8KMPpell20tlNcOJTjTDX9XKKcktwRKerFTSmvW+cG/p+mLV+q33pojSWV
	 WBQujhHRilYopUtdCbe3y4XBeJHa6p+YckfN3VcxCN3TWLa/jAPW9aJnMhN1p84snl
	 iPwsp5rTjFnlYaKOOPnY4wJIRmzaixGsh7MYdvVB35ErUL2K38/1+Jwe1/v0e2yKmV
	 hONGWkBH6o4sA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A5CE5F4006A;
	Tue, 10 Feb 2026 12:04:38 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 10 Feb 2026 12:04:38 -0500
X-ME-Sender: <xms:JmWLaU2I38mqUkPqRoB9zTB1GHmXIWAD-lMpNwonRU2k-m1S9eyJ9w>
    <xme:JmWLaZ4KLRH3AUf9yczMXzFeYVYROqaBguSTdB60URRk4963SMGukfNmwp4TKSBQh
    NNVWOL4cNLi9JjN2sVqXQ487oFqbr8odpkwOZZvv2enxvdWzzexpyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtvdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:JmWLaT_ezHPrM1ylRrDNTfZVZFr3QHsK4931Z1X9CN4KlxWmkZtjOQ>
    <xmx:JmWLabilLJ_gVOI6EIRo2YfFleA0dLGbAQov0Bb0px1fwcyzZICa7A>
    <xmx:JmWLacYY1wBKXbp9cD7j3QZ-vuIUl1El_JWse4zDhEgtjY0edL2R4A>
    <xmx:JmWLaY-tDVlyrdBM4uGmtk_r0Fz3JTSMnneBVyp6qGp3HGtjNsVmRQ>
    <xmx:JmWLaWP2H33xs8heiVzagVVCi2vkkJZbU6hHvCToZhuiDuIBDK4Yq7EK>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 820B6780075; Tue, 10 Feb 2026 12:04:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Au-WxeZj5vgR
Date: Tue, 10 Feb 2026 12:03:56 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-Id: <51ecc417-2f97-4939-a1fb-af7d23d44640@app.fastmail.com>
In-Reply-To: <D37AD3C9-A137-4E41-B34B-8ADFB1582F23@hammerspace.com>
References: <cover.1770660136.git.bcodding@hammerspace.com>
 <945449ed749872851596a58830d890a7c8b2a9c0.1770660136.git.bcodding@hammerspace.com>
 <961be2e7-6149-4777-b324-1470b77f8696@oracle.com>
 <D37AD3C9-A137-4E41-B34B-8ADFB1582F23@hammerspace.com>
Subject: Re: [PATCH v5 1/3] NFSD: Add a key for signing filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76858-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 37ADC11D863
X-Rspamd-Action: no action



On Tue, Feb 10, 2026, at 11:46 AM, Benjamin Coddington wrote:
> On 9 Feb 2026, at 15:29, Chuck Lever wrote:
>
>> On 2/9/26 1:09 PM, Benjamin Coddington wrote:
>>> A future patch will enable NFSD to sign filehandles by appending a Message
> ...
>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>> index 9fa600602658..c8ed733240a0 100644
>>> --- a/fs/nfsd/netns.h
>>> +++ b/fs/nfsd/netns.h
>>> @@ -224,6 +225,7 @@ struct nfsd_net {
>>>  	spinlock_t              local_clients_lock;
>>>  	struct list_head	local_clients;
>>>  #endif
>>> +	siphash_key_t		*fh_key;
>>
>> I will make a note-to-self to update the field name of the other
>> siphash key in this structure to match its function/purpose.
>>
>> As a performance note, is this field co-located in the same cache
>> line(s) as other fields that are accessed by the FH management
>> code?
>
> The only other nfsd_net field is used by a rare error path in
> nfsd_stats_fh_stale_inc(), a per-cpu counter.  I could try to re-arrange
> things for this, risk is something else gets a bit slower.
>
> Maybe we can optimize if needed later?

Fair enough, later it is.


>>> +		__field(bool, key_set)
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->key_set = true;
>>> +		if (!key)
>>> +			__entry->key_set = false;
>>> +		else
>>> +			memcpy(__entry->key, key, 16);
>>> +		__entry->result = result;
>>> +	),
>>> +	TP_printk("key=%s result=%ld",
>>> +		__entry->key_set ? __print_hex_str(__entry->key, 16) : "(null)",
>>> +		__entry->result
>>> +	)
>>> +);
>>
>> Not sure how I missed this before...
>>
>> We need to discuss the security implications of writing sensitive
>> material like the server FH key to the trace log. AFAICT, no other NFSD
>> tracepoint logs cryptographic material.
>
> I thought this could come up: consider only root can view these tracepoints,

That's not quite true. Yes, only root can enable tracing. But:

  # trace-cmd record -e nfsd

does record the trace event in a file and often the default
mode of that file is 644.


> many vulnerabilities can be exposed by tracepoint data.  The reason for it:
> sysadmin can absolutely verify that the key is getting set correctly to a
> expected value.  There's not a lot of other visibility in our tooling for
> this one point.
>
> In development, its been essential to prove that userspace is doing the
> hashing, that keys are changing properly when key file changes.

Development generally has different needs than deployment and/or
support engineering. Security, I'm thinking, is probably the most
critical need here.


> Let me know what you want to see here, we can hash the key again (like we do
> with pointer hashing), or just remove it altogether.

Yeah, I was thinking of hashing it for display, but then that
loses the ability to confirm the key's actual value. Another
option is to leave the trace point in for the initial merge,
but add a comment that says "to be removed" so that when we
have confidence key setting is working reliably, it can be
made more secure by removing the key from the trace record.

-- 
Chuck Lever

