Return-Path: <linux-fsdevel+bounces-6660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F4581B360
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 934EBB20EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5FA4F60D;
	Thu, 21 Dec 2023 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="a9xUt5Zc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mrV0atNV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073E4F1E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id EBEC95C005B;
	Thu, 21 Dec 2023 05:17:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 21 Dec 2023 05:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1703153852;
	 x=1703240252; bh=AzuzgjBVV+ksukaGiqQLkBuDIXbAh0/AyaP/ga5QZvs=; b=
	a9xUt5Zc4iIo7Ng7SwfaLT5FOrJIL1wpYXTcLBfbSAO8smpgCc06vnpi0NJiix2S
	Egg1vPnDtCII6G5STVZWLGbkpl0VkSo2Htw1gGMTyr6qYblrXyCXNCRBg2uOPNku
	j9nMCDSXXamWKpKCg+opC52Yd6mYsqm8QTBf6If89En1IkZKS5thjA+h4y0wS0Qj
	uPEAmDR5PyDXfVODS6lH2t4ZmqHlA5y44looQmIEpIZ9ZJQCG48wgJsrkHzOVmVC
	eFmBif2vmlVDDs+xHLhSCjjOAoUBVzYY/BLahtVmLyn0DyjTLNNZywgwB1e5AizF
	sMXZ/dq5rn2dLC3YERpZ9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703153852; x=
	1703240252; bh=AzuzgjBVV+ksukaGiqQLkBuDIXbAh0/AyaP/ga5QZvs=; b=m
	rV0atNVNgp7IOlvSUsNtgzc5JdAxYMD61po+5L1d5biQVay1lBPTeM/E9aBuUWoV
	Dgh6QqynjJ7ifE8XxUGNal6AIqVHFMS/rg5JT1QXEZ1CKlNbe4pqW8uAym5XLsi/
	gi5kp/d1fHplN16l1oYf174+iQ2UcDp245o49X30mDHTpCgoESPYE7NhL+UdJxnE
	q6X2q49FyvE8NZJ8vKIuSluVIpHv0rIqgrRfDGrdL4w2iiu2iZgwemsNc8FZU9HS
	ZMXLy/oaNDhd3oSzOrzh6ONm6ST8uVNoDrXEyR3X4luB7GFhQzto7Plwor4ergsX
	eaxpAk0t0JuEpfkajliPw==
X-ME-Sender: <xms:vBCEZXiGBeA91RARgC_Fd1mQaiXXuL4MgLOcjUhu2ZZspD0zXVxrHg>
    <xme:vBCEZUAtwKfu7VJM41GnX1dB0wNOgDVsjd6eEFuBBLi-44R9hW0V7YrVrOJ5L4vXg
    oGcxB5TRBf8NeEe>
X-ME-Received: <xmr:vBCEZXEc20MM0xdySqdeHmgKMJOU61LOr8GW7Xn_FFLDDpGS9TmFf76385HsO6wXUoW5wW6iV2K4xJA0xsEjKkL5727ZHRbjPjF70K8UzzqBq8Akk71T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddugedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepuedtkeeileeghedukefghfdtuddvudfgheel
    jeejgeelueffueekheefheffveelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:vBCEZUQO6Dolng-lDFOEiS546iuh7aRG7vRTx-wSnAbbtfxBvPUb3Q>
    <xmx:vBCEZUzvkuzDWEI_DSNCHzWtsOcBJiL79jEj-4zBeVquOOE_UjgK7g>
    <xmx:vBCEZa7HhMDJRoX8qE8Mmtx0HN7n6sdkel0qdqPC61t3hHAQKy3vWA>
    <xmx:vBCEZXyHj4uxPPAXFcEHt22iGOJIf08mwXwFQ6wR_hwXX5SjppQkFA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 05:17:31 -0500 (EST)
Message-ID: <bde78295-e455-4315-b8c6-57b0d3b60c6c@fastmail.fm>
Date: Thu, 21 Dec 2023 11:17:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>,
 linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com,
 hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>,
 Dharmendra Singh <dsingh@ddn.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
 <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm>
 <CAOQ4uxjKbQkqTHb9_3kqRW7BPPzwNj--4=kqsyq=7+ztLrwXfw@mail.gmail.com>
 <6e9e8ff6-1314-4c60-bf69-6d147958cf95@fastmail.fm>
 <CAOQ4uxiJfcZLvkKZxp11aAT8xa7Nxf_kG4CG1Ft2iKcippOQXg@mail.gmail.com>
 <06eedc60-e66b-45d1-a936-2a0bb0ac91c7@fastmail.fm>
 <CAOQ4uxhRbKz7WvYKbjGNo7P7m+00KLW25eBpqVTyUq2sSY6Vmw@mail.gmail.com>
 <7c588ab3-246f-4d9d-9b84-225dedab690a@fastmail.fm>
 <CAOQ4uxgb2J8zppKg63UV88+SNbZ+2=XegVBSXOFf=3xAVc1U3Q@mail.gmail.com>
 <9d3c1c2b-53c0-4f1d-b4c0-567b23d19719@fastmail.fm>
 <CAOQ4uxhd9GsWgpw4F56ACRmHhxd6_HVB368wAGCsw167+NHpvw@mail.gmail.com>
 <2d58c415-4162-441e-8887-de6678b2be28@fastmail.fm>
 <98795992-589d-44cb-a6d0-ccf8575a4cc4@fastmail.fm>
 <c4c87b07-bcae-4c6e-aaec-86168db7804a@fastmail.fm>
 <CAOQ4uxgy5mV4aP4YHJtoYeeLMzNfj0qYh7zTL32gO1TfJDvYYg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxgy5mV4aP4YHJtoYeeLMzNfj0qYh7zTL32gO1TfJDvYYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/21/23 10:18, Amir Goldstein wrote:
> On Thu, Dec 21, 2023 at 12:13 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>>
>> [...]
>>
>>>>>>> I think that we are going to need to use some inode state flag
>>>>>>> (e.g. FUSE_I_DIO_WR_EXCL) to protect against this starvation,
>>>>>>> unless we do not care about this possibility?
>>>>>>> We'd only need to set this in fuse_file_io_mmap() until we get
>>>>>>> the iocachectr refcount.
>>
>>
>> I added back FUSE_I_CACHE_IO_MODE I had used previously.
>>
> 
> ACK.
> Name is a bit confusing for the "want io mode" case, but IMO
> a comment would be enough to make it clear.
> Push a version with a comment to my branch.
> 
> 
>>
>>>>>>>
>>>>>>> I *think* that fuse_inode_deny_io_cache() should be called with
>>>>>>> shared inode lock held, because of the existing lock chain
>>>>>>> i_rwsem -> page lock -> mmap_lock for page faults, but I am
>>>>>>> not sure. My brain is too cooked now to figure this out.
>>>>>>> OTOH, I don't see any problem with calling
>>>>>>> fuse_inode_deny_io_cache() with shared lock held?
>>>>>>>
>>>>>>> I pushed this version to my fuse_io_mode branch [1].
>>>>>>> Only tested generic/095 with FOPEN_DIRECT_IO and
>>>>>>> DIRECT_IO_ALLOW_MMAP.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Amir.
>>>>>>>
>>>>>>> [1] https://github.com/amir73il/linux/commits/fuse_io_mode
>>>>>>
>>>>>> Thanks, will look into your changes next. I was looking into the
>>>>>> initial
>>>>>> issue with generic/095 with my branch. Fixed by the attached patch. I
>>>>>> think it is generic and also applies to FOPEN_DIRECT_IO + mmap.
>>>>>> Interesting is that filemap_range_has_writeback() is exported, but
>>>>>> there
>>>>>> was no user. Hopefully nobody submits an unexport patch in the mean
>>>>>> time.
>>>>>>
>>>>>
>>>>> Ok. Now I am pretty sure that filemap_range_has_writeback() should be
>>>>> check after taking the shared lock in fuse_dio_lock() as in my branch
>>>>> and
>>>>> not in fuse_dio_wr_exclusive_lock() outside the lock.
>>>>
>>>>
>>>>
>>>>>
>>>>> But at the same time, it is a little concerning that you are able to
>>>>> observe
>>>>> dirty pages on a fuse inode after success of fuse_inode_deny_io_cache().
>>>>> The whole point of fuse_inode_deny_io_cache() is that it should be
>>>>> granted after all users of the inode page cache are gone.
>>>>>
>>>>> Is it expected that fuse inode pages remain dirty after no more open
>>>>> files
>>>>> and no more mmaps?
>>>>
>>>>
>>>> I'm actually not sure anymore if filemap_range_has_writeback() is
>>>> actually needed. In fuse_flush() it calls write_inode_now(inode, 1),
>>>> but I don't think that will flush queued fi->writectr
>>>> (fi->writepages). Will report back in the afternoon.
>>>
>>> Sorry, my fault, please ignore the previous patch. Actually no dirty
>>> pages to be expected, I had missed the that fuse_flush calls
>>> fuse_sync_writes(). The main bug in my branch was due to the different
>>> handling of FOPEN_DIRECT_IO and O_DIRECT - for O_DIRECT I hadn't called
>>> fuse_file_io_mmap().
> 
> But why would you need to call fuse_file_io_mmap() for O_DIRECT?
> If a file was opened without FOPEN_DIRECT_IO, we already set inode to
> caching mode on open.
> Does your O_DIRECT patch to mmap solve an actual reproducible bug?

Yeah it does, in my fuse-dio-v5 branch, which adds in shared locks for 
O_DIRECT writes without FOPEN_DIRECT_IO.

> 
>>
>>
>> I pushed a few fixes/updates into my fuse-dio-v5 branch and also to
>> simplify it for you to my fuse_io_mode branch. Changes are onto of the
>> previous patches io-mode patch to simplify it for you to see the changes
>> and to possibly squash it into the main io patch.
>>
>> https://github.com/bsbernd/linux/commits/fuse_io_mode/
>>
> 
> Cool. I squashed all your fixes to my branch, with minor comments
> that I also left on github, except for the O_DIRECT patch, because
> I do not understand why it is needed.

No issue with that, I can keep that patch on the branch that actually 
needs it.

Oh, I just see your comments - I didn't get github notification and so 
missed your comments before. Sorry about that. Checking where I need to 
enable it. I do get notifications for other projects, so didn't suspect 
that anything would be missing...


> 
> The 6.8 merge window is very close and the holidays are upon us,
> so not sure if you and Miklos could be bothered, but do you think there
> is  a chance that we can get fuse_io_mode patches ready for queuing
> in time for the 6.8 merge window?
> 
> They do have merit on their own for re-allowing parallel dio along with
> FOPEN_PARALLEL_DIRECT_WRITES, but also, it would make it easier
> for the both of us to develop fuse-dio and fuse-passthrough based on
> the io cache mode during the 6.9 dev cycle.

I definitely would also like to get these patches in. Holidays have the 
merit that I don't need to get up at 7am to wake up kids and am then 
tired all the day. And no meetings ;)

 From my point my dio-v5 branch is also ready, it relies on these 
patches. Not sure how to post it with the dependency.
I also have no issue to wait for 6.9, for now I'm going to take these 
patches to our fuse module for ubuntu and rhel9 kernels (quite heavily 
patched, as it needs to live aside the kernel included module - symbol 
renames, etc).


> 
>>
>> PS: I start to feel a bit guilty about this long thread on
>> linux-fsdevel. Would be better to have that on fuse-devel, just the
>> sourceforge list is badly spammed.
>>
> 
> According to MAINTAINERS, linux-fsdevel is the list for linux FUSE
> kernel development. The sourceforge fuse-devel is for libfuse.
> 
> We could open a linux-fuse list, but it has been this way forever
> and I do not know of any complaints from fsdevel members.
> the downside of not having linux-fuse list IMO is that we do not
> have a "fuse only" searchable archive, but we won't have it for all the
> historic messages on fsdevel anyway.

Sure, fine with me. I'm just a bit worried that others might get 
disturbed by all the fuse only messages.


Thanks,
Bernd

