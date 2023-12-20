Return-Path: <linux-fsdevel+bounces-6585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ACD819EF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 13:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61015B2441D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10822324;
	Wed, 20 Dec 2023 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="PeeiQqHn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0IZrO2nA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D12231D
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id D40955C01D0;
	Wed, 20 Dec 2023 07:26:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Dec 2023 07:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1703075176;
	 x=1703161576; bh=NbhcBqcHuocW/7+bGcwIWzH0eQLeI7Lnr6XMlOPrCI8=; b=
	PeeiQqHnYezQMz55z2hbjzWNrvCHUE7lox+F+KXT0k3eOGnbfkmJfDlsCZJGzKSE
	ZTU9dgKuuCCW4kAoY/fea1EuBg+H6fJ349ZK/ir7uyhS7aKjP2TJoVJWkJyETCpT
	TcHfk9Mkq40gdBXm8/We9tpHzFT9FrVWVFIoSgytodhL8m5NQDcu5UOvGXA+q/sF
	1ufPa0APdl+ew8Bx0NVuwc9v3hFBLJqXPvDkBhMKb70fRbozxqrlWMnCpWc81s/t
	AP2+oz20ig/XGvjgTS+zyZZbg+chWxvTFCUOj1pwODv9onXHc9WJMzeyWjsM+5kN
	S36Lg0sKUiSFj4rJSB13zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703075176; x=
	1703161576; bh=NbhcBqcHuocW/7+bGcwIWzH0eQLeI7Lnr6XMlOPrCI8=; b=0
	IZrO2nASr6aJsdpcPIURsVezx/QjgwzQxMMThjo65zMH+bE5doSkP9MIsYzqpZYd
	1ZZXwHoDeNyJWKHU+Fau1CiMPAAHYAm2pEMssEyeDg2e58f8NJmUaJ2zHYJixbbx
	edaiO0wzToe41SRqvp8RFdZ7FkDY0feLH2BviLC5XbxfVSTcQSXN9Fn4oIZWMMSu
	pLtJjgrhYQ6YZHixUhxPqr2i9HlTGIk0f963XsqCrUhWGWMe84jM8Zp2tVQOb3j4
	OrOZsNnCyBJApUA3LxnxZsye74kSaAfC9ziV71xo+ir7EWR6LUq0Uj9U6d2LMrxL
	EJC3JD96xB0TAb+fas2Ww==
X-ME-Sender: <xms:aN2CZfALBV_xIBnJi2EIKo7qu2MmrPb_o7xyEwWTHUsv1jVkFKvXgA>
    <xme:aN2CZVjRFWcIVrgvF3q9vN5LMIZvYKrq-qsbqdd5eHBtGoby_0G4vVWlSUL5sdT6S
    EONlMbJitfggNsF>
X-ME-Received: <xmr:aN2CZamK38LPYPD3scuQSHUNBN_YkrgbfKz2bPT5eBjUw_fAI2bMeuckqXYS8N8GsszAFegmF93sd-f1GTPwZ6OhTV7pKTX-e6WZeiXGRgJTzN2eM51t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvdfhfeetfeejfefhtdehffettdevgfeutdeu
    feegheffkeeuvdejieehvdejfefgnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:aN2CZRxMcXbyKvYwD22LwLLGxTMYLqnvVM0DDfNB7qMnfd6uAqnVUw>
    <xmx:aN2CZURUsub4JOPaFMJzhmGEiJ8MrAkHWspqFQzv0O6nWob8BfwLGw>
    <xmx:aN2CZUaVOZn4i_M5aK0WzuCV0RW0bHoMkP7OavvIwINg1TXaTmeLvw>
    <xmx:aN2CZZRhdiZzQHgTsIegZ7NRlXD6d9Gsk9tw_crbseLcziRZNjEBkQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 07:26:15 -0500 (EST)
Message-ID: <98795992-589d-44cb-a6d0-ccf8575a4cc4@fastmail.fm>
Date: Wed, 20 Dec 2023 13:26:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>,
 linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com,
 hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>,
 Dharmendra Singh <dsingh@ddn.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
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
In-Reply-To: <2d58c415-4162-441e-8887-de6678b2be28@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/23 10:00, Bernd Schubert wrote:
> 
> 
> On 12/20/23 05:18, Amir Goldstein wrote:
>> On Tue, Dec 19, 2023 at 10:47 PM Bernd Schubert
>> <bernd.schubert@fastmail.fm> wrote:
>>>
>>>
>>>
>>> On 12/19/23 14:01, Amir Goldstein wrote:
>>>>>> Here is what I was thinking about:
>>>>>>
>>>>>> https://github.com/amir73il/linux/commits/fuse_io_mode
>>>>>>
>>>>>> The concept that I wanted to introduce was the
>>>>>> fuse_inode_deny_io_cache()/fuse_inode_allow_io_cache()
>>>>>> helpers (akin to deny_write_access()/allow_write_access()).
>>>>>>
>>>>>> In this patch, parallel dio in progress deny open in caching mode
>>>>>> and mmap, and I don't know if that is acceptable.
>>>>>> Technically, instead of deny open/mmap you can use additional
>>>>>> techniques to wait for in progress dio and allow caching open/mmap.
>>>>>>
>>>>>> Anyway, I plan to use the iocachectr and fuse_inode_deny_io_cache()
>>>>>> pattern when file is open in FOPEN_PASSTHROUGH mode, but
>>>>>> in this case, as agreed with Miklos, a server trying to mix open
>>>>>> in caching mode on the same inode is going to fail the open.
>>>>>>
>>>>>> mmap is less of a problem for inode in passthrough mode, because
>>>>>> mmap in of direct_io file and inode in passthrough mode is 
>>>>>> passthrough
>>>>>> mmap to backing file.
>>>>>>
>>>>>> Anyway, if you can use this patch or parts of it, be my guest and 
>>>>>> if you
>>>>>> want to use a different approach that is fine by me as well - in 
>>>>>> that case
>>>>>> I will just remove the fuse_file_shared_dio_{start,end}() part 
>>>>>> from my patch.
>>>>>
>>>>> Hi Amir,
>>>>>
>>>>> here is my fuse-dio-v5 branch:
>>>>> https://github.com/bsbernd/linux/commits/fuse-dio-v5/
>>>>>
>>>>> (v5 is just compilation tested, tests are running now over night)
>>>>
>>>> This looks very nice!
>>>> I left comments about some minor nits on github.
>>>>
>>>>>
>>>>> This branch is basically about consolidating fuse write direct IO code
>>>>> paths and to allow a shared lock for O_DIRECT. I actually could have
>>>>> noticed the page cache issue with shared locks before with previous
>>>>> versions of these patches, just my VM kernel is optimized for
>>>>> compilation time and some SHM options had been missing - with that fio
>>>>> refused to run.
>>>>>
>>>>> The branch includes a modified version of your patch:
>>>>> https://github.com/bsbernd/linux/commit/6b05e52f7e253d9347d97de675b21b1707d6456e
>>>>>
>>>>> Main changes are
>>>>> - fuse_file_io_open() does not set the FOPEN_CACHE_IO flag for
>>>>> file->f_flags & O_DIRECT
>>>>> - fuse_file_io_mmap() waits on a dio waitq
>>>>> - fuse_file_shared_dio_start / fuse_file_shared_dio_end are moved 
>>>>> up in
>>>>> the file, as I would like to entirely remove the fuse_direct_write 
>>>>> iter
>>>>> function (all goes through cache_write_iter)
>>>>>
>>>>
>>>> Looks mostly good, but I think that fuse_file_shared_dio_start() =>
>>>> fuse_inode_deny_io_cache() should actually be done after taking
>>>> the inode lock (shared or exclusive) and not like in my patch.
>>>>
>>>> First of all, this comment in fuse_dio_wr_exclusive_lock():
>>>>
>>>>           /*
>>>>            * fuse_file_shared_dio_start() must not be called on retest,
>>>>            * as it decreases a counter value - must not be done twice
>>>>            */
>>>>           if (!fuse_file_shared_dio_start(inode))
>>>>                   return true;
>>>>
>>>> ...is suggesting that semantics are not clean and this check
>>>> must remain last, because if fuse_dio_wr_exclusive_lock()
>>>> returns false, iocachectr must not be elevated.
>>>> This is easy to get wrong in the future with current semantics.
>>>>
>>>> The more important thing is that while fuse_file_io_mmap()
>>>> is waiting for iocachectr to drop to zero, new parallel dio can
>>>> come in and starve the mmap() caller forever.
>>>>
>>>> I think that we are going to need to use some inode state flag
>>>> (e.g. FUSE_I_DIO_WR_EXCL) to protect against this starvation,
>>>> unless we do not care about this possibility?
>>>> We'd only need to set this in fuse_file_io_mmap() until we get
>>>> the iocachectr refcount.
>>>>
>>>> I *think* that fuse_inode_deny_io_cache() should be called with
>>>> shared inode lock held, because of the existing lock chain
>>>> i_rwsem -> page lock -> mmap_lock for page faults, but I am
>>>> not sure. My brain is too cooked now to figure this out.
>>>> OTOH, I don't see any problem with calling
>>>> fuse_inode_deny_io_cache() with shared lock held?
>>>>
>>>> I pushed this version to my fuse_io_mode branch [1].
>>>> Only tested generic/095 with FOPEN_DIRECT_IO and
>>>> DIRECT_IO_ALLOW_MMAP.
>>>>
>>>> Thanks,
>>>> Amir.
>>>>
>>>> [1] https://github.com/amir73il/linux/commits/fuse_io_mode
>>>
>>> Thanks, will look into your changes next. I was looking into the initial
>>> issue with generic/095 with my branch. Fixed by the attached patch. I
>>> think it is generic and also applies to FOPEN_DIRECT_IO + mmap.
>>> Interesting is that filemap_range_has_writeback() is exported, but there
>>> was no user. Hopefully nobody submits an unexport patch in the mean 
>>> time.
>>>
>>
>> Ok. Now I am pretty sure that filemap_range_has_writeback() should be
>> check after taking the shared lock in fuse_dio_lock() as in my branch and
>> not in fuse_dio_wr_exclusive_lock() outside the lock.
> 
> 
> 
>>
>> But at the same time, it is a little concerning that you are able to 
>> observe
>> dirty pages on a fuse inode after success of fuse_inode_deny_io_cache().
>> The whole point of fuse_inode_deny_io_cache() is that it should be
>> granted after all users of the inode page cache are gone.
>>
>> Is it expected that fuse inode pages remain dirty after no more open 
>> files
>> and no more mmaps?
> 
> 
> I'm actually not sure anymore if filemap_range_has_writeback() is 
> actually needed. In fuse_flush() it calls write_inode_now(inode, 1), but 
> I don't think that will flush queued fi->writectr (fi->writepages). Will 
> report back in the afternoon.

Sorry, my fault, please ignore the previous patch. Actually no dirty 
pages to be expected, I had missed the that fuse_flush calls 
fuse_sync_writes(). The main bug in my branch was due to the different 
handling of FOPEN_DIRECT_IO and O_DIRECT - for O_DIRECT I hadn't called 
fuse_file_io_mmap().


Thanks,
Bernd

