Return-Path: <linux-fsdevel+bounces-13771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A90873B0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A711F2A6AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4DE135408;
	Wed,  6 Mar 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="v9xhYE9q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOVlo/ak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB000130AEE;
	Wed,  6 Mar 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739926; cv=none; b=K/emThK7h9j5BuvD+kEWAiq5vonr9JPqvW25OgE6zxBX4UMFqv2oUELMMWD7/0CIgOIVKo44XDmsVfIkTAKHHIdN6Fx/WMJ/O4B8XYeDyDyxD0VIH3/RErsTudZpMlTMahzc0rHZRwuIdilvAoNfEX8G4S0TdSqtPgzpkgsvoig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739926; c=relaxed/simple;
	bh=oqxrJdGDDDLyvZySgAQy/XtcFXJ7JIRydTuS3NKeXng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jyt1WtKHBQomeO4T+Oxkcn80xdMS+HU3JtIj69EIPuCGRXKsGBD8muS1c48T5nfq6jawSpMqXGMNCtiRlk4bkWqsvl5Vg2H31uZv9TqmqypW8gMZAzkpubzkdlH+PTBty+1wJCEAL8HAceL7y9iPPQy1yw+lPnKoM/oiJoBDIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=v9xhYE9q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOVlo/ak; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 843E81C000B8;
	Wed,  6 Mar 2024 10:45:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 06 Mar 2024 10:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709739922;
	 x=1709826322; bh=CNl6+jV5cft9DjasTGdstbA/oM1nB7kjDRc4r1kT++k=; b=
	v9xhYE9qaVrSib9zY0xGEO8M2JMm5tQWelonCv3x7YW+xL3dMh7eW8cbu591DG8d
	zU9iwT0IwaSVksJnSoXkoNMb3Jww8R0B0n4KFF9I9rCSDl6yPCxPmdd0H2JRxS7o
	k1eJVNijeDT0+AhgjuHb++DZkdvWqE0OJfP61iGBelm34ZnX0cVVV98mim+ivli5
	ZxWjE1kuuaKVW+JAS466gWLbRL1bvTkG4vc9/+FWhT1PmJj60bhTp4ZoyPdjHEJz
	+X6caoJvYVA+ZwkTA50D8b9LulGC0O91sis3yXqM9Ig9BUZ/D1isql9ItZ8CAP1h
	GKAIGsD+Mpi0fESCa/GjXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709739922; x=
	1709826322; bh=CNl6+jV5cft9DjasTGdstbA/oM1nB7kjDRc4r1kT++k=; b=T
	OVlo/akH/SXrfMMs+EyNCZYN46yVn4hrOZKVPto7ir8BlpCK8azwckyHiHy3EDlv
	mtxDIM2YnBc9ZdF17pneZvO1o+7tSBQJjU7Hda5uOQ9QKqF8m9h+x11KaS/FEzlp
	IgnENiEu05iBFfTrJ1k4sRfhwzIzTFjlxnhBpYZYFIKCR9BaL4hA9DplgE0MdOry
	Pxi0rsicJWfjfBz3bw2rPGt7a+MDplDbBZkdGEVJELmrPl2ToEDT7BTDm8ucksz0
	HNHk/n+V0I820WQnwQAXWwJT4AxSojOFHJcSPEJ+80+ZmenFVIz1R5BLoUKtoo3s
	ORvIJjLKkGM0xfgi6ORLw==
X-ME-Sender: <xms:kY_oZWwoGvLJCvxZD7T9msW8Vpn6E1Q4NLklSYVQTemMe1wqcXq3Vg>
    <xme:kY_oZSRa-sjs7GJwFrTK_U80WOiNov3oaqyNceQWuoSW_gktM01akwPL64bHkOleW
    NUurQjDQko96zc6>
X-ME-Received: <xmr:kY_oZYURJciVjM9UHOKJ0W_qK4EgBfGMJnRidGL9tI_iTOsodCU3UOw-uPw4q6J2vA2zeHx6BO70xV-uovYiRHcIn0L-ENlQk71gz_YBMOjJKRukU3IF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:kY_oZchfBUc8EmJBk4jbqiqKBn7qIYtU_86O-EUuRZ1drBWpJpmjAw>
    <xmx:kY_oZYA8-wkGY1ttSrSFvRtctttdWFSMbcNOwYbHVLcsNDqdXozwKw>
    <xmx:kY_oZdJeOj-G7xGPbXqTC-aPdSKIZfD-kMFI3GXp7FeSHi3_FwAm1w>
    <xmx:ko_oZX5GMaOIT_esqza0mgKEzl1I5iHT-hVWv_WeCf5G4WBtLItYNAWkbj4>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 10:45:20 -0500 (EST)
Message-ID: <5343dc29-83cb-49b4-91ff-57bbd0eaa1df@fastmail.fm>
Date: Wed, 6 Mar 2024 16:45:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangjiachen.jaycee@bytedance.com
References: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
 <CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com>
 <6e6bef3d-dd26-45ce-bc4a-c04a960dfb9c@linux.alibaba.com>
 <b4e6b930-ed06-4e0d-b17d-61d05381ac92@linux.alibaba.com>
 <27b34186-bc7c-4f3c-8818-ee73eb3f82ba@linux.alibaba.com>
 <CAJfpegvLUrqkCkVc=yTXcjZyNNQEG4Z4c6TONEZHGGmjiQ5X2g@mail.gmail.com>
 <7e79a9fa-99a0-47e5-bc39-107f89852d8d@linux.alibaba.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <7e79a9fa-99a0-47e5-bc39-107f89852d8d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/24 14:32, Jingbo Xu wrote:
> 
> 
> On 3/5/24 10:26 PM, Miklos Szeredi wrote:
>> On Mon, 26 Feb 2024 at 05:00, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>
>>> Hi Miklos,
>>>
>>> On 1/26/24 2:29 PM, Jingbo Xu wrote:
>>>>
>>>>
>>>> On 1/24/24 8:47 PM, Jingbo Xu wrote:
>>>>>
>>>>>
>>>>> On 1/24/24 8:23 PM, Miklos Szeredi wrote:
>>>>>> On Wed, 24 Jan 2024 at 08:05, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>>
>>>>>>> From: Xu Ji <laoji.jx@alibaba-inc.com>
>>>>>>>
>>>>>>> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of a
>>>>>>> single request is increased.
>>>>>>
>>>>>> The only worry is about where this memory is getting accounted to.
>>>>>> This needs to be thought through, since the we are increasing the
>>>>>> possible memory that an unprivileged user is allowed to pin.
>>>>
>>>> Apart from the request size, the maximum number of background requests,
>>>> i.e. max_background (12 by default, and configurable by the fuse
>>>> daemon), also limits the size of the memory that an unprivileged user
>>>> can pin.  But yes, it indeed increases the number proportionally by
>>>> increasing the maximum request size.
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> This optimizes the write performance especially when the optimal IO size
>>>>>>> of the backend store at the fuse daemon side is greater than the original
>>>>>>> maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
>>>>>>> 4096 PAGE_SIZE).
>>>>>>>
>>>>>>> Be noted that this only increases the upper limit of the maximum request
>>>>>>> size, while the real maximum request size relies on the FUSE_INIT
>>>>>>> negotiation with the fuse daemon.
>>>>>>>
>>>>>>> Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
>>>>>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>>>>> ---
>>>>>>> I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
>>>>>>> Bytedance floks seems to had increased the maximum request size to 8M
>>>>>>> and saw a ~20% performance boost.
>>>>>>
>>>>>> The 20% is against the 256 pages, I guess.
>>>>>
>>>>> Yeah I guess so.
>>>>>
>>>>>
>>>>>> It would be interesting to
>>>>>> see the how the number of pages per request affects performance and
>>>>>> why.
>>>>>
>>>>> To be honest, I'm not sure the root cause of the performance boost in
>>>>> bytedance's case.
>>>>>
>>>>> While in our internal use scenario, the optimal IO size of the backend
>>>>> store at the fuse server side is, e.g. 4MB, and thus if the maximum
>>>>> throughput can not be achieved with current 256 pages per request. IOW
>>>>> the backend store, e.g. a distributed parallel filesystem, get optimal
>>>>> performance when the data is aligned at 4MB boundary.  I can ask my folk
>>>>> who implements the fuse server to give more background info and the
>>>>> exact performance statistics.
>>>>
>>>> Here are more details about our internal use case:
>>>>
>>>> We have a fuse server used in our internal cloud scenarios, while the
>>>> backend store is actually a distributed filesystem.  That is, the fuse
>>>> server actually plays as the client of the remote distributed
>>>> filesystem.  The fuse server forwards the fuse requests to the remote
>>>> backing store through network, while the remote distributed filesystem
>>>> handles the IO requests, e.g. process the data from/to the persistent store.
>>>>
>>>> Then it comes the details of the remote distributed filesystem when it
>>>> process the requested data with the persistent store.
>>>>
>>>> [1] The remote distributed filesystem uses, e.g. a 8+3 mode, EC
>>>> (ErasureCode), where each fixed sized user data is split and stored as 8
>>>> data blocks plus 3 extra parity blocks. For example, with 512 bytes
>>>> block size, for each 4MB user data, it's split and stored as 8 (512
>>>> bytes) data blocks with 3 (512 bytes) parity blocks.
>>>>
>>>> It also utilize the stripe technology to boost the performance, for
>>>> example, there are 8 data disks and 3 parity disks in the above 8+3 mode
>>>> example, in which each stripe consists of 8 data blocks and 3 parity
>>>> blocks.
>>>>
>>>> [2] To avoid data corruption on power off, the remote distributed
>>>> filesystem commit a O_SYNC write right away once a write (fuse) request
>>>> received.  Since the EC described above, when the write fuse request is
>>>> not aligned on 4MB (the stripe size) boundary, say it's 1MB in size, the
>>>> other 3MB is read from the persistent store first, then compute the
>>>> extra 3 parity blocks with the complete 4MB stripe, and finally write
>>>> the 8 data blocks and 3 parity blocks down.
>>>>
>>>>
>>>> Thus the write amplification is un-neglectable and is the performance
>>>> bottleneck when the fuse request size is less than the stripe size.
>>>>
>>>> Here are some simple performance statistics with varying request size.
>>>> With 4MB stripe size, there's ~3x bandwidth improvement when the maximum
>>>> request size is increased from 256KB to 3.9MB, and another ~20%
>>>> improvement when the request size is increased to 4MB from 3.9MB.
>>
>> I sort of understand the issue, although my guess is that this could
>> be worked around in the client by coalescing writes.  This could be
>> done by adding a small delay before sending a write request off to the
>> network.
>>
>> Would that work in your case?
> 
> It's possible but I'm not sure. I've asked my colleagues who working on
> the fuse server and the backend store, though have not been replied yet.
>  But I guess it's not as simple as increasing the maximum FUSE request
> size directly and thus more complexity gets involved.
> 
> I can also understand the concern that this may increase the risk of
> pinning more memory footprint, and a more generic using scenario needs
> to be considered.  I can make it a private patch for our internal product.
> 
> Thanks for the suggestions and discussion.

It also gets kind of solved in my fuse-over-io-uring branch - as long as
there are enough free ring entries. I'm going to add in a flag there
that other CQEs might be follow up requests. Really time to post a new
version.

Bernd

