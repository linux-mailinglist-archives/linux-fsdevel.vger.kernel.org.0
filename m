Return-Path: <linux-fsdevel+bounces-6609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E930581A8E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 23:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194941C230A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 22:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6274A988;
	Wed, 20 Dec 2023 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Q5dK6TFu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7ezv9lKJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2D4A983
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 09E405C07F4;
	Wed, 20 Dec 2023 17:13:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 20 Dec 2023 17:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1703110427;
	 x=1703196827; bh=LkfSZIimGwx5I8FP/rzS6hLOwiWVs+bvEStKNdN1p/g=; b=
	Q5dK6TFus/4qerhRzaNwUPYd82ZNVyrQMBHrigopP71X2/ymgIqldxp7ztyA67eM
	Wz+okwYXpJsZ8tEGhsohicZnL6A/yQyTQlbHjvn+IfK5B34GjEjt5XqVuFYZ9ngR
	dKbP6yZDU8Z9sa8HVAn6r5T3LEmLK5BLrkmInBGw7xWCFsNUlvYMvZOl0nU12vid
	YwPV8dBtYC1VE52Z0xVT/qmCxFgjNtnP1cRW3KzRh1WCoyQK5Y6/LdBm6/LOA3U3
	eeS6Yo1tBBokQ0j5kzeNf6jysjh4esUmJKu/Uv56SKbqh53z2UGkNNiRVgf1dD7g
	kd4fDsFZPY2TZrzRlynEaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703110427; x=
	1703196827; bh=LkfSZIimGwx5I8FP/rzS6hLOwiWVs+bvEStKNdN1p/g=; b=7
	ezv9lKJP5MfuGWfXMh4eyftBLpHv58z2nlICzZXvdI+QdS8W+N0BUO2cmNbRdw1V
	Ulkb4VVsWIWVu4dUOFxbj9IaWmlpSGIHfvhHsXd+GHoNKh3LriuAQaNDjVeVxrpH
	HohCXjXv9l+y2LStJ+wyrVmEoKgyMM23QXSKTzN/Kyt2jlDuODG+4V/iOGeaHTpm
	BDvRQDNH0XQ4NuqUU1Wd8JQotkkbIb4NzwKMzwblxgrVws+TMtxoZVffDyKNAkOa
	HuD+JFEm2OuG/00dM4rs1iGwuXiEBmynE8R+6l5BJ81NjANFu2un2QIqx8GRYqjG
	mHwP4vGC4jKMWPfoXNAfQ==
X-ME-Sender: <xms:GmeDZdxiojN9B_15FCE6KYCPwKG8zebm296cSe0XbZzLDh72UY1MLg>
    <xme:GmeDZdTbuxM1Sb-ctik1FBkUXZPEqrWSyqN-FuZvUoLX6uRkK-UFhkOK_m6b3LGCD
    9wxi-OcCPoUdhDn>
X-ME-Received: <xmr:GmeDZXVpTaV6JTwAKfMxfXMCy6nM5ZYPID2B0wnYQmXAOfgEMOt93crbnztfKC8dnLMXLeY0RxB2Izq94OJTXGkL-eZ5m5_fH50xb3MpaROvLbnQooD2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuhffvvehfjggtgfesthejredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeejjeefgeeuiedvtdeuiefhieefhfduudej
    tdekjeeugeeuuefhheeffffhfefhieenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:GmeDZfhwdOH1yhCg8_6oRD62IYnvFcMsQNYSgGCQVqq4nK1ivH4e5Q>
    <xmx:GmeDZfCt9gzGswiPgfpYGoUbG0IPyMysT5dzEFt6y3nWI4fsG6uRcQ>
    <xmx:GmeDZYJLdB9wO_7twb1LQHg1ReNCmx5ZJ3YBJK9ZD5ZHtZcGjvbl0A>
    <xmx:G2eDZRAD5Ihxnjm4EvVjx7TayNSbxFcrt6qLbnGoV1zcfcCS1mrIlw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 17:13:45 -0500 (EST)
Message-ID: <c4c87b07-bcae-4c6e-aaec-86168db7804a@fastmail.fm>
Date: Wed, 20 Dec 2023 23:13:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>,
 linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com,
 hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>,
 Dharmendra Singh <dsingh@ddn.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
 <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm>
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
Content-Language: en-US, de-DE
In-Reply-To: <98795992-589d-44cb-a6d0-ccf8575a4cc4@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




[...]

>>>>> I think that we are going to need to use some inode state flag
>>>>> (e.g. FUSE_I_DIO_WR_EXCL) to protect against this starvation,
>>>>> unless we do not care about this possibility?
>>>>> We'd only need to set this in fuse_file_io_mmap() until we get
>>>>> the iocachectr refcount.


I added back FUSE_I_CACHE_IO_MODE I had used previously.


>>>>>
>>>>> I *think* that fuse_inode_deny_io_cache() should be called with
>>>>> shared inode lock held, because of the existing lock chain
>>>>> i_rwsem -> page lock -> mmap_lock for page faults, but I am
>>>>> not sure. My brain is too cooked now to figure this out.
>>>>> OTOH, I don't see any problem with calling
>>>>> fuse_inode_deny_io_cache() with shared lock held?
>>>>>
>>>>> I pushed this version to my fuse_io_mode branch [1].
>>>>> Only tested generic/095 with FOPEN_DIRECT_IO and
>>>>> DIRECT_IO_ALLOW_MMAP.
>>>>>
>>>>> Thanks,
>>>>> Amir.
>>>>>
>>>>> [1] https://github.com/amir73il/linux/commits/fuse_io_mode
>>>>
>>>> Thanks, will look into your changes next. I was looking into the 
>>>> initial
>>>> issue with generic/095 with my branch. Fixed by the attached patch. I
>>>> think it is generic and also applies to FOPEN_DIRECT_IO + mmap.
>>>> Interesting is that filemap_range_has_writeback() is exported, but 
>>>> there
>>>> was no user. Hopefully nobody submits an unexport patch in the mean 
>>>> time.
>>>>
>>>
>>> Ok. Now I am pretty sure that filemap_range_has_writeback() should be
>>> check after taking the shared lock in fuse_dio_lock() as in my branch 
>>> and
>>> not in fuse_dio_wr_exclusive_lock() outside the lock.
>>
>>
>>
>>>
>>> But at the same time, it is a little concerning that you are able to 
>>> observe
>>> dirty pages on a fuse inode after success of fuse_inode_deny_io_cache().
>>> The whole point of fuse_inode_deny_io_cache() is that it should be
>>> granted after all users of the inode page cache are gone.
>>>
>>> Is it expected that fuse inode pages remain dirty after no more open 
>>> files
>>> and no more mmaps?
>>
>>
>> I'm actually not sure anymore if filemap_range_has_writeback() is 
>> actually needed. In fuse_flush() it calls write_inode_now(inode, 1), 
>> but I don't think that will flush queued fi->writectr 
>> (fi->writepages). Will report back in the afternoon.
> 
> Sorry, my fault, please ignore the previous patch. Actually no dirty 
> pages to be expected, I had missed the that fuse_flush calls 
> fuse_sync_writes(). The main bug in my branch was due to the different 
> handling of FOPEN_DIRECT_IO and O_DIRECT - for O_DIRECT I hadn't called 
> fuse_file_io_mmap().


I pushed a few fixes/updates into my fuse-dio-v5 branch and also to 
simplify it for you to my fuse_io_mode branch. Changes are onto of the 
previous patches io-mode patch to simplify it for you to see the changes 
and to possibly squash it into the main io patch.

https://github.com/bsbernd/linux/commits/fuse_io_mode/


Thanks,
Bernd


PS: I start to feel a bit guilty about this long thread on 
linux-fsdevel. Would be better to have that on fuse-devel, just the 
sourceforge list is badly spammed.






