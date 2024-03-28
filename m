Return-Path: <linux-fsdevel+bounces-15617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6C890D64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 23:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3811C31397
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 22:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665C914A0A6;
	Thu, 28 Mar 2024 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="4IhdKtwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RA45swQm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A4149C7F;
	Thu, 28 Mar 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663700; cv=none; b=JMPlfW5QaEk0/TKcoL+ewvtx4ZsjcFnx7v4QtwKLtXFpT0TnWcQa3S6fFMzyK3xc+P3jRVjYQCiZ2JIr3VrzgzFJS1oNUTw3p/z63KkyZyQL/AueeHyYNtSbvnfZJ64WL5l0GlY6oe2fpC9UDABTOA652lfsff8vvxAT80N7lvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663700; c=relaxed/simple;
	bh=9KpTE8EZMiRYziQ6dJYq7BGFymVdzSp4XqIpfaWFInI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQWToTjLkj0mBcTQi9ParF/yHsdYZFGVYEtRBqgX53xuJc4eSSvvblIGaR+OXtREGbFcsiMm7PERg+DpuK1dUXBQfIMPiQ4Lj7d71mQPCNfDZ5821C61agli0/0CLmazfyGjdLnEWhz4m4e3iLupyhotZBJdFbL51/dX8WdoeOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=4IhdKtwy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RA45swQm; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 47EBF180008D;
	Thu, 28 Mar 2024 18:08:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Mar 2024 18:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1711663695;
	 x=1711750095; bh=0WfY8MAV7a4yv3eWWZiOqIPq7rlB7kyJAhryWf5Obto=; b=
	4IhdKtwyGnV0Jmrf9FtqbHu9z5ZujL4vneSX/TMlCiaGB7e4MpX2YyaSI4Kwkusk
	JWZkOy+IgnqIcYXtx3DHQGcwoRdzT0XsGUxFB5Sd9PcplpeKhn7WoVPw+4sBoSx5
	regEZK3OsEDDxmK98Fi1A5D08Ru0K2oX2skv7jc8/KGQ9onC3F6pygjeBWJ3TYQ1
	OvGQQJ1aMHNaCgnD48ekG+rz1nlivjU3xX5lDEFcym0v4hxZrvzfolglNE9TdjSb
	0aLxJMzPNd/8W9+yeK1tCIMzaLNsLRg7dKlHMiEDEqUD2gOX1qDjquscOtWaKwnJ
	z9DWN5XEWcUd6RaLhGSzDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711663695; x=
	1711750095; bh=0WfY8MAV7a4yv3eWWZiOqIPq7rlB7kyJAhryWf5Obto=; b=R
	A45swQmgWnKRpJ8norwwD0iRRPtY5eDatY2fk2+LyxPXCYFMaHfyGeOJ6iIxuQSU
	HTEZQ0iU6kdO6Q6yDz+L5FoOLUwKewW8fvuVrRIYWpv2nxhxnFYh5bWPatKUz55Y
	U8DWptZmO1ojV4PdmpSdsgIuIyTPHJiP0rx5TKFrQ6CA/YoSqQSB0YfPQskSOAOi
	BN6oSgITtZB4mff8x4UOU07esuIWhQWRxBRolkcyOKnBMFOwoC5yGE4pxr2Ta3Lr
	96roBsFBVkaYMzSjlHLQz4BbSfJ5rhTJZT090bVJ/U/F9cEkNw27UunjQ741xPM9
	1iZGtaPQf0hCM/1n5vWVQ==
X-ME-Sender: <xms:TuoFZiV3ngiz93DIAT_ZozTp442iSx0deIdeXfvayQekNuFEKZL8MQ>
    <xme:TuoFZukUlj6ZVzMahNOsASahD4KOQVlKPQYSvXXTtqSTQb3Qm8i6J7PcZ0Ee9DdVs
    U8hEE4Hcictgmh5>
X-ME-Received: <xmr:TuoFZmaV3Mh4a6agewzJDKJ9fLiGztd6LYh_y-OoQ3RBZov7uifvo8PRPFwA17i54FOPgaVMAflRGmnQKkTXRa9E9dg64aWjjaK7gHAKP8KCVYElStX3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeeutdekieelgeehudekgffhtdduvddugfeh
    leejjeegleeuffeukeehfeehffevleenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:TuoFZpWsECeHZ290QO_-RETxetvS8kNN8G7LqF_l4VJm2He59HM4ng>
    <xmx:TuoFZskdxyi_HrhwJT8m3vSvxw4-hBuPp74PTKuHWUlD9aaSMO7Kfg>
    <xmx:TuoFZufgvIWQWf2J94AoMNXXuUxUEwKejQHCHr1T2l1DlUAkDLaDpA>
    <xmx:TuoFZuHdDL3rAQESCMC7cF6iwJIL1QxSjqK2Iq0lyGGWKcYpKZuN3A>
    <xmx:T-oFZmWrQtxHHyxomf4LSx-vhtEiDM573ygi5upDC3_LStxlkPIeWRI0BlE>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Mar 2024 18:08:13 -0400 (EDT)
Message-ID: <4e488ba4-b474-4dff-984e-c66fbcf3334c@fastmail.fm>
Date: Thu, 28 Mar 2024 23:08:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangjiachen.jaycee@bytedance.com
References: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
 <CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com>
 <6e6bef3d-dd26-45ce-bc4a-c04a960dfb9c@linux.alibaba.com>
 <b4e6b930-ed06-4e0d-b17d-61d05381ac92@linux.alibaba.com>
 <27b34186-bc7c-4f3c-8818-ee73eb3f82ba@linux.alibaba.com>
 <CAJfpegvLUrqkCkVc=yTXcjZyNNQEG4Z4c6TONEZHGGmjiQ5X2g@mail.gmail.com>
 <7e79a9fa-99a0-47e5-bc39-107f89852d8d@linux.alibaba.com>
 <5343dc29-83cb-49b4-91ff-57bbd0eaa1df@fastmail.fm>
 <cb39ba49-eada-44b4-97fd-ea27ac8ba1f4@linux.alibaba.com>
 <b24ed720-5490-46e7-8f64-0410d6ea23b5@fastmail.fm>
 <a58ad76f-780e-42de-86b3-44e24164d945@dorminy.me>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <a58ad76f-780e-42de-86b3-44e24164d945@dorminy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/28/24 17:46, Sweet Tea Dorminy wrote:
> 
> 
> On 3/7/24 17:06, Bernd Schubert wrote:
>> Hi Jingbo,
>>
>> On 3/7/24 03:16, Jingbo Xu wrote:
>>> Hi Bernd,
>>>
>>> On 3/6/24 11:45 PM, Bernd Schubert wrote:
>>>>
>>>>
>>>> On 3/6/24 14:32, Jingbo Xu wrote:
>>>>>
>>>>>
>>>>> On 3/5/24 10:26 PM, Miklos Szeredi wrote:
>>>>>> On Mon, 26 Feb 2024 at 05:00, Jingbo Xu
>>>>>> <jefflexu@linux.alibaba.com> wrote:
>>>>>>>
>>>>>>> Hi Miklos,
>>>>>>>
>>>>>>> On 1/26/24 2:29 PM, Jingbo Xu wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/24/24 8:47 PM, Jingbo Xu wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 1/24/24 8:23 PM, Miklos Szeredi wrote:
>>>>>>>>>> On Wed, 24 Jan 2024 at 08:05, Jingbo Xu
>>>>>>>>>> <jefflexu@linux.alibaba.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> From: Xu Ji <laoji.jx@alibaba-inc.com>
>>>>>>>>>>>
>>>>>>>>>>> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data
>>>>>>>>>>> size of a
>>>>>>>>>>> single request is increased.
>>>>>>>>>>
>>>>>>>>>> The only worry is about where this memory is getting accounted
>>>>>>>>>> to.
>>>>>>>>>> This needs to be thought through, since the we are increasing the
>>>>>>>>>> possible memory that an unprivileged user is allowed to pin.
>>>>>>>>
>>>>>>>> Apart from the request size, the maximum number of background
>>>>>>>> requests,
>>>>>>>> i.e. max_background (12 by default, and configurable by the fuse
>>>>>>>> daemon), also limits the size of the memory that an unprivileged
>>>>>>>> user
>>>>>>>> can pin.  But yes, it indeed increases the number proportionally by
>>>>>>>> increasing the maximum request size.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> This optimizes the write performance especially when the
>>>>>>>>>>> optimal IO size
>>>>>>>>>>> of the backend store at the fuse daemon side is greater than
>>>>>>>>>>> the original
>>>>>>>>>>> maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
>>>>>>>>>>> 4096 PAGE_SIZE).
>>>>>>>>>>>
>>>>>>>>>>> Be noted that this only increases the upper limit of the
>>>>>>>>>>> maximum request
>>>>>>>>>>> size, while the real maximum request size relies on the
>>>>>>>>>>> FUSE_INIT
>>>>>>>>>>> negotiation with the fuse daemon.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
>>>>>>>>>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>>>>>>>>> ---
>>>>>>>>>>> I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
>>>>>>>>>>> Bytedance floks seems to had increased the maximum request
>>>>>>>>>>> size to 8M
>>>>>>>>>>> and saw a ~20% performance boost.
>>>>>>>>>>
>>>>>>>>>> The 20% is against the 256 pages, I guess.
>>>>>>>>>
>>>>>>>>> Yeah I guess so.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> It would be interesting to
>>>>>>>>>> see the how the number of pages per request affects
>>>>>>>>>> performance and
>>>>>>>>>> why.
>>>>>>>>>
>>>>>>>>> To be honest, I'm not sure the root cause of the performance
>>>>>>>>> boost in
>>>>>>>>> bytedance's case.
>>>>>>>>>
>>>>>>>>> While in our internal use scenario, the optimal IO size of the
>>>>>>>>> backend
>>>>>>>>> store at the fuse server side is, e.g. 4MB, and thus if the
>>>>>>>>> maximum
>>>>>>>>> throughput can not be achieved with current 256 pages per
>>>>>>>>> request. IOW
>>>>>>>>> the backend store, e.g. a distributed parallel filesystem, get
>>>>>>>>> optimal
>>>>>>>>> performance when the data is aligned at 4MB boundary.  I can
>>>>>>>>> ask my folk
>>>>>>>>> who implements the fuse server to give more background info and
>>>>>>>>> the
>>>>>>>>> exact performance statistics.
>>>>>>>>
>>>>>>>> Here are more details about our internal use case:
>>>>>>>>
>>>>>>>> We have a fuse server used in our internal cloud scenarios,
>>>>>>>> while the
>>>>>>>> backend store is actually a distributed filesystem.  That is,
>>>>>>>> the fuse
>>>>>>>> server actually plays as the client of the remote distributed
>>>>>>>> filesystem.  The fuse server forwards the fuse requests to the
>>>>>>>> remote
>>>>>>>> backing store through network, while the remote distributed
>>>>>>>> filesystem
>>>>>>>> handles the IO requests, e.g. process the data from/to the
>>>>>>>> persistent store.
>>>>>>>>
>>>>>>>> Then it comes the details of the remote distributed filesystem
>>>>>>>> when it
>>>>>>>> process the requested data with the persistent store.
>>>>>>>>
>>>>>>>> [1] The remote distributed filesystem uses, e.g. a 8+3 mode, EC
>>>>>>>> (ErasureCode), where each fixed sized user data is split and
>>>>>>>> stored as 8
>>>>>>>> data blocks plus 3 extra parity blocks. For example, with 512 bytes
>>>>>>>> block size, for each 4MB user data, it's split and stored as 8 (512
>>>>>>>> bytes) data blocks with 3 (512 bytes) parity blocks.
>>>>>>>>
>>>>>>>> It also utilize the stripe technology to boost the performance, for
>>>>>>>> example, there are 8 data disks and 3 parity disks in the above
>>>>>>>> 8+3 mode
>>>>>>>> example, in which each stripe consists of 8 data blocks and 3
>>>>>>>> parity
>>>>>>>> blocks.
>>>>>>>>
>>>>>>>> [2] To avoid data corruption on power off, the remote distributed
>>>>>>>> filesystem commit a O_SYNC write right away once a write (fuse)
>>>>>>>> request
>>>>>>>> received.  Since the EC described above, when the write fuse
>>>>>>>> request is
>>>>>>>> not aligned on 4MB (the stripe size) boundary, say it's 1MB in
>>>>>>>> size, the
>>>>>>>> other 3MB is read from the persistent store first, then compute the
>>>>>>>> extra 3 parity blocks with the complete 4MB stripe, and finally
>>>>>>>> write
>>>>>>>> the 8 data blocks and 3 parity blocks down.
>>>>>>>>
>>>>>>>>
>>>>>>>> Thus the write amplification is un-neglectable and is the
>>>>>>>> performance
>>>>>>>> bottleneck when the fuse request size is less than the stripe size.
>>>>>>>>
>>>>>>>> Here are some simple performance statistics with varying request
>>>>>>>> size.
>>>>>>>> With 4MB stripe size, there's ~3x bandwidth improvement when the
>>>>>>>> maximum
>>>>>>>> request size is increased from 256KB to 3.9MB, and another ~20%
>>>>>>>> improvement when the request size is increased to 4MB from 3.9MB.
>>>>>>
>>>>>> I sort of understand the issue, although my guess is that this could
>>>>>> be worked around in the client by coalescing writes.  This could be
>>>>>> done by adding a small delay before sending a write request off to
>>>>>> the
>>>>>> network.
>>>>>>
>>>>>> Would that work in your case?
>>>>>
>>>>> It's possible but I'm not sure. I've asked my colleagues who
>>>>> working on
>>>>> the fuse server and the backend store, though have not been replied
>>>>> yet.
>>>>>   But I guess it's not as simple as increasing the maximum FUSE
>>>>> request
>>>>> size directly and thus more complexity gets involved.
>>>>>
>>>>> I can also understand the concern that this may increase the risk of
>>>>> pinning more memory footprint, and a more generic using scenario needs
>>>>> to be considered.  I can make it a private patch for our internal
>>>>> product.
>>>>>
>>>>> Thanks for the suggestions and discussion.
>>>>
>>>> It also gets kind of solved in my fuse-over-io-uring branch - as
>>>> long as
>>>> there are enough free ring entries. I'm going to add in a flag there
>>>> that other CQEs might be follow up requests. Really time to post a new
>>>> version.
>>>
>>> Thanks for the information.  I've not read the fuse-over-io-uring branch
>>> yet, but sounds like it would be much helpful .  Would there be a flag
>>> in the FUSE request indicating it's one of the linked FUSE requests?  Is
>>> this feature, say linked FUSE requests, enabled only when io-uring is
>>> upon FUSE?
>>
>>
>> Current development branch is this
>> https://github.com/bsbernd/linux/tree/fuse-uring-for-6.8
>> (It sometimes gets rebase/force pushes and incompatible changes - the
>> corresponding libfuse branch is also persistently updated).
>>
>> Patches need clean up before I can send the next RFC version. And I
>> first want to change fixed single request size (not so nice to use 1MB
>> requests when 4K would be sufficient, for things like metadata and small
>> IO).
>>
> 
> Let me know if there's something you'd like collaboration on --
> fuse_iouring sounds very exciting and I'd love to help out any way that
> would be useful.

With pleasure, I take whatever help you offer. Right now I'm quite
jumping between between different projects and I'm not too happy that I
still didn't sent out a new patch version yet. (And the atomic-open
branch also needs updates).

> 
> For our internal usecase at Meta, the relevant backend store operates on
> 8M chunks, so I'm also very interested in the simplicity of just opting
> in to receiving 8M IOs from the kernel instead of needing to buffer our
> own 8MB IOs. But io_uring does seem like a plausible general-purpose
> improvement too, so either or both of these paths is interesting and I'm
> working on gathering performance numbers on the relative merits.

Merging requests requires a bit scanning through the CQEs on the
userspace side, it all arrives randomly. I haven't even tried yet to
merge requests, I have just seen with debugging that ring the queue gets
filled with requests that belong together.

Out of interest, are you using libfuse or your own kernel interface
library? I would be quite interested to know if the fuse-uring
kernel/userspace and then libfuse interface matches your needs. Example,
our next-gen DDN file system runs in spdk reactor context and I had to
update our own code base and libfuse to support ring polling. So one
project outside of libfuse example/ and already some changes needed...
Another change I haven't implemented yet in libfuse is ring request
buffer registration with the file system (for network rdma).

Btw, I just run into bug that came up with FUSE_CAP_WRITEBACK_CACHE - I
definitely don't claim that all code paths are perfectly tested already
(fixed now in the fuse-uring-for-6.8 branch).


Thanks,
Bernd

