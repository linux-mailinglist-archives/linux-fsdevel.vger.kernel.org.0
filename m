Return-Path: <linux-fsdevel+bounces-20540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853D78D4FAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C142282616
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321BC21106;
	Thu, 30 May 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="2Z+pEZqk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YydCgRD4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D667210F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085629; cv=none; b=CPS5imBtN9b4tO/RiGf+TZWER7n7SMD5gBWkTMOUYl5y568bn3B5IanTyOoizYdlbNpMJJrSsRtDz3mq0B6be2AvTZ+90xdDOH5Jl98pDVJ68A2K5A0w229rKqAxRT/19Gzu2ZIXf3Wh7opRSBrlnIcOYLR3xpz5Lth1FAj2WsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085629; c=relaxed/simple;
	bh=IVOw7LtwXnLrKjivjfGYxvyFEaypPoRpUx/pseZTrEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzInLU+qHg6Hztwbuai8ra1+nxeRs3/c+j1HyYxRBSjq1L7qI6D8cGMpGvmaHJdjPqC/latp1zdS9/n64SAJS0eu51QXTrCrYLVzz38Wz1bbP5yXJKgkMW7oFaAmgACrQIRvtYUesASR0AkRlllQPsuGevlT+qs/lrVaNwHJ6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=2Z+pEZqk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YydCgRD4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C4F39114014B;
	Thu, 30 May 2024 12:13:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 30 May 2024 12:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717085626;
	 x=1717172026; bh=nK3Lj4ZuV/ERTvvAkah+/X2JPuxGOZYdbmNhhRX1/zQ=; b=
	2Z+pEZqkjjhd5Er8u1w1Wp6Q48mngOphXnsFq6de/dJQ1eEylhJLw0i4gt4vtOBi
	geHvZJc8XTt+HCOh5vMwTBlwc6mm9rGzHngmWxEcfurtgs+g448yj9xTUpdZWv7j
	smroxK/GooV8wL7pLFj2UqOaNHYdkWQEgkzPQLWLTrhqE/79Ec5M+EFDDOQUKbaT
	F/QnmdE7ltSd9Z2cLgIAKkjaeG/3Q2kqlgHXDwEqCMlICejxdDSSDDUVjuRXVi3F
	zRC3yDckFj2yj6TuR0+qobAHCoxG2apbIfLkwhmrsgjRU4urEHdtFcIBPnY4tdox
	Yr0SiwDOcf+sool4hbVROg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717085626; x=
	1717172026; bh=nK3Lj4ZuV/ERTvvAkah+/X2JPuxGOZYdbmNhhRX1/zQ=; b=Y
	ydCgRD4i7KGwqXyciUrtd/MmnvTuYvJKAFqvRuLfz3ly8TGo3/oF13LTGWQ0U9xV
	iv7xj69ZNyZJSg+aeA6mTdwUrgBF5wSljx7SlezA1rpzvv/6D455239jpP/B5URy
	M6QyB6/Av3+BxUbx1EggWSZpVmokz4RWuPCheCNn3ApR1o8bWUBqsOJhL4+G3r1U
	mVD9uglfMP3TA21oelogadQaA6uiGRgYeN3eEb3V/kT8rQ65S5M+0hE4QcFIOtRR
	Cuj243kJMuEssHiJce2H+e+aL3ZiZJ5JOVkZhuN/Q9myl01tJIEiYGlh+1VsHeh2
	L29F0rpwzvRWqd7G2BXDg==
X-ME-Sender: <xms:uqVYZpMXEeUINOCJaZYCHgzTMBbjjM7lof5Yhz5NFqd2KPBHoXGEhA>
    <xme:uqVYZr8372CedjBFQ6JlCmXmwCDm8Yqaeb4Eo5py5w4-MLB2FBW8eguly8OyIL-p1
    PAQdYjwZEaisOQb>
X-ME-Received: <xmr:uqVYZoSuZC-jc_WimyLof0kYMpnq4hMpiCz3PdPz0cjE24oP81y-0_0O0uP0AsyxqYz8s48PQi2kFzVq8dqXLdAycQt57_DfBNyR2jMKTsNp_ddKTPTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:uqVYZltSPEEJdRNMkV3hc2Slbo9dQty1yIu0rug0WKi7WfvXqTNDtg>
    <xmx:uqVYZheX1AqxQ4vVXei93azHm6fsXIdD909KIiJOQjKu0ssrwlyWhA>
    <xmx:uqVYZh2bXVgcse3z4iyU41aVbHAoXBlUSnEPPzb-dzAB18fbOM33jQ>
    <xmx:uqVYZt-qkFDHNaSMittgHogTZB8bSLBvJ0ySg9Idm4fZYDfQ6WzG1g>
    <xmx:uqVYZrsvIlBGK-07cYUPnD-_cwI43S0Jr23Nt8JQxFNFWqoJzFX0jtA5>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 12:13:45 -0400 (EDT)
Message-ID: <61ea7870-c375-48c9-88e2-6f17fe4ab864@fastmail.fm>
Date: Thu, 30 May 2024 18:13:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
To: Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
 <20240530151001.GC2205585@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240530151001.GC2205585@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 17:10, Josef Bacik wrote:
> On Wed, May 29, 2024 at 08:00:41PM +0200, Bernd Schubert wrote:
>> This is to have a numa aware vmalloc function for memory exposed to
>> userspace. Fuse uring will allocate queue memory using this
>> new function.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> cc: Andrew Morton <akpm@linux-foundation.org>
>> cc: linux-mm@kvack.org
>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>  include/linux/vmalloc.h |  1 +
>>  mm/nommu.c              |  6 ++++++
>>  mm/vmalloc.c            | 41 +++++++++++++++++++++++++++++++++++++----
>>  3 files changed, 44 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
>> index 98ea90e90439..e7645702074e 100644
>> --- a/include/linux/vmalloc.h
>> +++ b/include/linux/vmalloc.h
>> @@ -141,6 +141,7 @@ static inline unsigned long vmalloc_nr_pages(void) { return 0; }
>>  extern void *vmalloc(unsigned long size) __alloc_size(1);
>>  extern void *vzalloc(unsigned long size) __alloc_size(1);
>>  extern void *vmalloc_user(unsigned long size) __alloc_size(1);
>> +extern void *vmalloc_node_user(unsigned long size, int node) __alloc_size(1);
>>  extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
>>  extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
>>  extern void *vmalloc_32(unsigned long size) __alloc_size(1);
>> diff --git a/mm/nommu.c b/mm/nommu.c
>> index 5ec8f44e7ce9..207ddf639aa9 100644
>> --- a/mm/nommu.c
>> +++ b/mm/nommu.c
>> @@ -185,6 +185,12 @@ void *vmalloc_user(unsigned long size)
>>  }
>>  EXPORT_SYMBOL(vmalloc_user);
>>  
>> +void *vmalloc_node_user(unsigned long size, int node)
>> +{
>> +	return __vmalloc_user_flags(size, GFP_KERNEL | __GFP_ZERO);
>> +}
>> +EXPORT_SYMBOL(vmalloc_node_user);
>> +
>>  struct page *vmalloc_to_page(const void *addr)
>>  {
>>  	return virt_to_page(addr);
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 68fa001648cc..0ac2f44b2b1f 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -3958,6 +3958,25 @@ void *vzalloc(unsigned long size)
>>  }
>>  EXPORT_SYMBOL(vzalloc);
>>  
>> +/**
>> + * _vmalloc_node_user - allocate zeroed virtually contiguous memory for userspace
>> + * on the given numa node
>> + * @size: allocation size
>> + * @node: numa node
>> + *
>> + * The resulting memory area is zeroed so it can be mapped to userspace
>> + * without leaking data.
>> + *
>> + * Return: pointer to the allocated memory or %NULL on error
>> + */
>> +static void *_vmalloc_node_user(unsigned long size, int node)
>> +{
>> +	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
>> +				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
>> +				    VM_USERMAP, node,
>> +				    __builtin_return_address(0));
>> +}
>> +
> 
> Looking at the rest of vmalloc it seems like adding an extra variant to do the
> special thing is overkill, I think it would be fine to just have
> 
> void *vmalloc_nod_user(unsigned long size, int node)
> {
> 	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
> 				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
> 				    VM_USERMAP, node,
> 				    __builtin_return_address(0));
> }
> 
> instead of creating a _vmalloc_node_user().

No issue with me either. I had done it like this as there are basically
two caller wit the same flags - vmalloc_user(size, NUMA_NO_NODE) and the new
vmalloc_node_user(size, node).

> 
> Also as an aside, this is definitely being used by this series, but I think it
> would be good to go ahead and send this by itself with just the explanation that
> it's going to be used by the fuse iouring stuff later, that way you can get this
> merged and continue working on the iouring part.

Thanks for your advise, will submit it separately. If the for now used export is
acceptable it would also help me, as we have back ports of these patches.

> 
> This also goes for the other prep patches earlier this this series, but since
> those are fuse related it's probably fine to just keep shipping them with this
> series.  Thanks,


Thanks again for your help and reviews!

Bernd

