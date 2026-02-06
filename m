Return-Path: <linux-fsdevel+bounces-76639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBIhB2VAhmmFLQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:26:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F83D102B53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 666ED3062C6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF2C3093DE;
	Fri,  6 Feb 2026 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS+ma7Cm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2C2FF161
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405521; cv=none; b=iaRl/musgYwWENNbaUR55jW0n2MpK3EdjsG2/ucLNLAcUO9hgYT1jDbdoOsPr/9D6iRf+7NSSfWckUJ0kIdMN82+Bs1wyS5yXm1hoEbecKp8AoCePt9wMpA6RRB8KxzfX1LHyN0sNU24bSqVbNxtUzrWBBnnZMqSDhm7tyWQuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405521; c=relaxed/simple;
	bh=W/9T75mXJLo63LclVsjsUz0U1jgmURF0NZJoMCy7Nkw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cD4qzuyX6rq4/4vjoTtR7AJsfMFqt24Mmo+a3L5Jx52ZTltI9THOddyuh/FTZhEHBz0a8bmSit5xS47w8zFoPCB7m8Je0EKRFEtGYbIdIuNljBzsdO5kWlDS+wk40q0R7fsU9ib2CVX5GpWK5wsAz7rsrARqARlxCTa9zx2SPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS+ma7Cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89FBC4AF09;
	Fri,  6 Feb 2026 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770405520;
	bh=W/9T75mXJLo63LclVsjsUz0U1jgmURF0NZJoMCy7Nkw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KS+ma7CmYbkBQc5yxjH8CkzAUt6nFwHrzqAHrkTDW1pSwx8dKUJiS3ePgujwVtl6c
	 RGacVV9/dRcWF+1k+KZhFRiBbVblK+tisbOpV6FI7WTluaRj2UQ2pFAeA5U8r1jucA
	 zSsodDoYt8lxkaTxBPvZ9e72dxo/J9+uWQ6U5vraM8Pt2Hjubs/xieM6ONG5oPLDmz
	 KFXk1tvsuyvs9sStOKLq9lF/kEPua7ympy/YCCOEJEXZe3ap1qPb7qMVXp9PHDYcqX
	 oPPvWGz09Hk60lPojpD5Edb1aJrAgaqhhPWDxXN3Ll8ih5VH4/A5pDXlL7W15UlcV2
	 lL5LLXxuX/iyQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7FD0CF4006F;
	Fri,  6 Feb 2026 14:18:39 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 06 Feb 2026 14:18:39 -0500
X-ME-Sender: <xms:jz6GabWutLkXpDl429hV-tJzioEeSISDq-GltFKZ264wrcQhl6lZ6g>
    <xme:jz6GaebUT0dZNHdeqybx9xm7kYbldSX8yfv4f0bQ9Kjo1NrlhTVuwB3ob7G_jc0Lj
    KuCBNyhLMTNQ7N5CkLbDjndEnPDxx120yvR79qYdgVa3u67j-5BAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrd
    hnrghmvgdprhgtphhtthhopehrihgtkhdrmhgrtghklhgvmhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomhdprhgtph
    htthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jz6GaecDLvEOiv4Yz-36tVHwcV8WpjMsl-D-Gz4HkmqV1IrzVhazJA>
    <xmx:jz6GaUCePrCyhnE9Hz-iFiNOSVX-NHyyW1PTAhm89vNcum45ooHRfQ>
    <xmx:jz6Gaa4aKHjA6G2NFiaDGjYLcS2eK-BTq8QTBCL-79GEPOE1RvWFiQ>
    <xmx:jz6GaVftIeCcEDj6yGhuG_PLc-A4r2FyFVs9F2ua7IIcFDqKNiOFVg>
    <xmx:jz6GaYvObG4eYWcaD7mBGHQNwBjkhYq_ebw8qpBAUpNf7l13KOntBlXN>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5C0CC780070; Fri,  6 Feb 2026 14:18:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfV0Pu1ThoXF
Date: Fri, 06 Feb 2026 14:17:49 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-Id: <49ee1e31-6cfa-43f7-ae1a-82dc92073569@app.fastmail.com>
In-Reply-To: <6758BBFF-6A47-4C8F-9F15-B42366E1E110@hammerspace.com>
References: <cover.1770390036.git.bcodding@hammerspace.com>
 <09698b80d78c7c0a8709967f0f3cf103b3ddad9d.1770390036.git.bcodding@hammerspace.com>
 <88c1ea24-2223-4a80-afb0-89c7272dd440@app.fastmail.com>
 <35697253-D872-40B1-85F3-3FD707F0E8C6@hammerspace.com>
 <6758BBFF-6A47-4C8F-9F15-B42366E1E110@hammerspace.com>
Subject: Re: [PATCH v4 1/3] NFSD: Add a key for signing filehandles
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
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76639-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8F83D102B53
X-Rspamd-Action: no action



On Fri, Feb 6, 2026, at 1:51 PM, Benjamin Coddington wrote:
> On 6 Feb 2026, at 12:52, Benjamin Coddington wrote:
>
>> On 6 Feb 2026, at 12:38, Chuck Lever wrote:
>>
>>> On Fri, Feb 6, 2026, at 10:09 AM, Benjamin Coddington wrote:
>>>> A future patch will enable NFSD to sign filehandles by appending a Message
>>>> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
>>>> that can persist across reboots.  A persisted key allows the server to
>>>> accept filehandles after a restart.  Enable NFSD to be configured with this
>>>> key the netlink interface.
>>>>
>>>> Link:
>>>> https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hammerspace.com
>>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>>> ---
>>>
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index a58eb1adac0f..55af3e403750 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -1571,6 +1571,31 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>>>>  	return ret;
>>>>  }
>>>>
>>>> +/**
>>>> + * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
>>>> + * @attr: nlattr NFSD_A_SERVER_FH_KEY
>>>> + * @nn: nfsd_net
>>>> + *
>>>> + * Callers should hold nfsd_mutex, returns 0 on success or negative
>>>> errno.
>>>> + */
>>>> +static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct
>>>> nfsd_net *nn)
>>>> +{
>>>> +	siphash_key_t *fh_key = nn->fh_key;
>>>> +
>>>> +	if (nla_len(attr) != sizeof(siphash_key_t))
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (!fh_key) {
>>>> +		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
>>>> +		if (!fh_key)
>>>> +			return -ENOMEM;
>>>> +		nn->fh_key = fh_key;
>>>> +	}
>>>> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));
>>>> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));
>>>
>>> put_unaligned_le64() takes a value as its first argument and a
>>> destination pointer as its second.  These two lines write the
>>> contents of fh_key->key[0] into the nlattr buffer rather than
>>> reading userspace data into the key.
>>>
>>> On the first call, fh_key was just kmalloc'd and contains
>>> uninitialized heap data, so the key is never populated from
>>> userspace input.
>>>
>>> Additionally, both lines reference key[0] -- the second should
>>> reference key[1] and write to an offset of nla_data(attr).
>>>
>>> The correct form, following the pattern in
>>> fscrypt_derive_siphash_key(), would be something like:
>>>
>>>     fh_key->key[0] = get_unaligned_le64(nla_data(attr));
>>>     fh_key->key[1] = get_unaligned_le64(nla_data(attr) + 8);
>>
>> Yes- thanks Chuck, I really messed this one up.. somehow sending out the
>> wrong version.
>
> I think nla_data() returns void* - and we want to ensure that void* + 8
> moves 8 bytes.  Isn't this a GCC extension that assumes void* + 1 moves 
> one byte?
>
> ISTR other conversations about this with you, is it maybe safer to do
> something like this?
>
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 55af3e403750..f05e2829d032 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1581,6 +1581,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *nn)
>  {
>         siphash_key_t *fh_key = nn->fh_key;
> +       u8 *data;
>
>         if (nla_len(attr) != sizeof(siphash_key_t))
>                 return -EINVAL;
> @@ -1591,8 +1592,10 @@ static int nfsd_nl_fh_key_set(const struct 
> nlattr *attr, struct nfsd_net *nn)
>                         return -ENOMEM;
>                 nn->fh_key = fh_key;
>         }
> -       put_unaligned_le64(fh_key->key[0], nla_data(attr));
> -       put_unaligned_le64(fh_key->key[0], nla_data(attr));
> +
> +       data = nla_data(attr);
> +       fh_key->key[0] = get_unaligned_le64(data);
> +       fh_key->key[1] = get_unaligned_le64(data + 8);
>         return 0;
>  }
>
> Ben

I did a little research. Void pointer arithmetic is explicitly sanctioned
in the kernel code base. Documentation/kernel-hacking/hacking.rst (line 690)
lists "Arithmetic on void pointers" as a standard accepted GNU extension.
The kernel compiles with -std=gnu11. -Wpointer-arith is only enabled at W=3,
not by default.

Additionally, Linus seems to prefer "void *" and I see pointer arithmetic
in other contexts under fs/nfsd/ that use a void * cast.

So "get_unaligned_le64(nla_data(attr) + 8)" is fine.


-- 
Chuck Lever

