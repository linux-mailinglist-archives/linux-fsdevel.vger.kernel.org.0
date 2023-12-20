Return-Path: <linux-fsdevel+bounces-6576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0003819B0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 10:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9DC8B25BE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1001D545;
	Wed, 20 Dec 2023 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="XxrMbuyX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vDkfWHqa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F81CAB9
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 1ABD45C01C2;
	Wed, 20 Dec 2023 04:00:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Dec 2023 04:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1703062845;
	 x=1703149245; bh=Qn7HnUZYbei5yYhQRbPHxOYVrgFiaPOi+EumobLtLbg=; b=
	XxrMbuyXdB8aRVM2MjedcUCA5JkN3GZ5NNRg6SFlMJ58aHoPx7Ij3RZWwG8b9NBA
	igbIeyIZbM1yDnaqw58NJbsjnG+FLEnBNW4DHNv/YFy26UyU9Qtc4pq5guG7+SD8
	hipwCv0ipgNpZfwWv3lVa2dW+NzXPm4n5bSUBJlkqwYQZzXSoqVbtooE51tWhLY5
	TSzE+eo8KScFhFE+pqOgkrhE/9qkw1NpXukIpYeen3lOFxsP0IfROqKieJCC6+F5
	XPLGV2zzgX51gNqeqcWeLxIk6QHUVYcJvc1XVMeojDJ/tQLk6AB258zNsb/uQiz7
	HlXOMe0OooGLKXoHqDFhdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703062845; x=
	1703149245; bh=Qn7HnUZYbei5yYhQRbPHxOYVrgFiaPOi+EumobLtLbg=; b=v
	DkfWHqajAd9q4cn3zhwYlfBewgwA/wAk7DXD/cZMo6fQHLn3n9/HlhqjGqmpVJAl
	2NYbODCjdhf4QDRLk6vBpA53Q4QYjppoI/BC+j1920FtvAyiwLed8vUMCi3UAabg
	3V34EUMw9vGsbBEWYJOSBPk/vba8obp76Bk9/a5c8XLpKocK9xDF0Y1VFU7BL8OA
	piKQ857geXzD2r8kKo55UDULlVJPtukPdA2MXKKLEBsyN++9X6nN5hzyB+EF3PW5
	YLjXlNM94pq67WdALTaa3f844+626P0KRrzqHmFbFAA7H2TSZ2JEVK+KWqkkD3z9
	G5SodmjBXldfNJ5qmkGjg==
X-ME-Sender: <xms:PK2CZSIixnP85zzYLnjUBBu4L6ZBw6b6ALWCUFvef9TIoKCKijbSYw>
    <xme:PK2CZaIwVYl7O_BOFxpkLv-XWVnbtzKrSFtCTKLPw8sZjUOlmDg_NitmnBeaPP4_M
    LFQsgosAlBTZPis>
X-ME-Received: <xmr:PK2CZSuZr0vjIFrfoFycAvTZ757iG-roji950TbnwMazhrewAwWwX8Ad922IRLDWNtjPnAJMWluIt6T1Pnc5Cp16IjFnpelX9kn-J2GjlGVtlTlc-0cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeeutdekieelgeehudekgffhtdduvddugfeh
    leejjeegleeuffeukeehfeehffevleenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:PK2CZXZF6L-JjUfGrtO0pgnoxKg_55jZaDQbk6Xluui1rAfSPZ1N7A>
    <xmx:PK2CZZZbWf1evaFZQ6CGFspPt3wxxZK_cO6EHO2aa0DkqFMF1zoqzQ>
    <xmx:PK2CZTBfgyrI5O7biF_ZvLoWkamGLJi7Ax0usmjno8g6lPk359LmCA>
    <xmx:Pa2CZV4n1EQ3noPszzRapHaQPyOiEwHwdT393NfkNI11Qrqjp0xDwQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 04:00:43 -0500 (EST)
Message-ID: <2d58c415-4162-441e-8887-de6678b2be28@fastmail.fm>
Date: Wed, 20 Dec 2023 10:00:41 +0100
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
 <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm>
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
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxhd9GsWgpw4F56ACRmHhxd6_HVB368wAGCsw167+NHpvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/23 05:18, Amir Goldstein wrote:
> On Tue, Dec 19, 2023 at 10:47 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 12/19/23 14:01, Amir Goldstein wrote:
>>>>> Here is what I was thinking about:
>>>>>
>>>>> https://github.com/amir73il/linux/commits/fuse_io_mode
>>>>>
>>>>> The concept that I wanted to introduce was the
>>>>> fuse_inode_deny_io_cache()/fuse_inode_allow_io_cache()
>>>>> helpers (akin to deny_write_access()/allow_write_access()).
>>>>>
>>>>> In this patch, parallel dio in progress deny open in caching mode
>>>>> and mmap, and I don't know if that is acceptable.
>>>>> Technically, instead of deny open/mmap you can use additional
>>>>> techniques to wait for in progress dio and allow caching open/mmap.
>>>>>
>>>>> Anyway, I plan to use the iocachectr and fuse_inode_deny_io_cache()
>>>>> pattern when file is open in FOPEN_PASSTHROUGH mode, but
>>>>> in this case, as agreed with Miklos, a server trying to mix open
>>>>> in caching mode on the same inode is going to fail the open.
>>>>>
>>>>> mmap is less of a problem for inode in passthrough mode, because
>>>>> mmap in of direct_io file and inode in passthrough mode is passthrough
>>>>> mmap to backing file.
>>>>>
>>>>> Anyway, if you can use this patch or parts of it, be my guest and if you
>>>>> want to use a different approach that is fine by me as well - in that case
>>>>> I will just remove the fuse_file_shared_dio_{start,end}() part from my patch.
>>>>
>>>> Hi Amir,
>>>>
>>>> here is my fuse-dio-v5 branch:
>>>> https://github.com/bsbernd/linux/commits/fuse-dio-v5/
>>>>
>>>> (v5 is just compilation tested, tests are running now over night)
>>>
>>> This looks very nice!
>>> I left comments about some minor nits on github.
>>>
>>>>
>>>> This branch is basically about consolidating fuse write direct IO code
>>>> paths and to allow a shared lock for O_DIRECT. I actually could have
>>>> noticed the page cache issue with shared locks before with previous
>>>> versions of these patches, just my VM kernel is optimized for
>>>> compilation time and some SHM options had been missing - with that fio
>>>> refused to run.
>>>>
>>>> The branch includes a modified version of your patch:
>>>> https://github.com/bsbernd/linux/commit/6b05e52f7e253d9347d97de675b21b1707d6456e
>>>>
>>>> Main changes are
>>>> - fuse_file_io_open() does not set the FOPEN_CACHE_IO flag for
>>>> file->f_flags & O_DIRECT
>>>> - fuse_file_io_mmap() waits on a dio waitq
>>>> - fuse_file_shared_dio_start / fuse_file_shared_dio_end are moved up in
>>>> the file, as I would like to entirely remove the fuse_direct_write iter
>>>> function (all goes through cache_write_iter)
>>>>
>>>
>>> Looks mostly good, but I think that fuse_file_shared_dio_start() =>
>>> fuse_inode_deny_io_cache() should actually be done after taking
>>> the inode lock (shared or exclusive) and not like in my patch.
>>>
>>> First of all, this comment in fuse_dio_wr_exclusive_lock():
>>>
>>>           /*
>>>            * fuse_file_shared_dio_start() must not be called on retest,
>>>            * as it decreases a counter value - must not be done twice
>>>            */
>>>           if (!fuse_file_shared_dio_start(inode))
>>>                   return true;
>>>
>>> ...is suggesting that semantics are not clean and this check
>>> must remain last, because if fuse_dio_wr_exclusive_lock()
>>> returns false, iocachectr must not be elevated.
>>> This is easy to get wrong in the future with current semantics.
>>>
>>> The more important thing is that while fuse_file_io_mmap()
>>> is waiting for iocachectr to drop to zero, new parallel dio can
>>> come in and starve the mmap() caller forever.
>>>
>>> I think that we are going to need to use some inode state flag
>>> (e.g. FUSE_I_DIO_WR_EXCL) to protect against this starvation,
>>> unless we do not care about this possibility?
>>> We'd only need to set this in fuse_file_io_mmap() until we get
>>> the iocachectr refcount.
>>>
>>> I *think* that fuse_inode_deny_io_cache() should be called with
>>> shared inode lock held, because of the existing lock chain
>>> i_rwsem -> page lock -> mmap_lock for page faults, but I am
>>> not sure. My brain is too cooked now to figure this out.
>>> OTOH, I don't see any problem with calling
>>> fuse_inode_deny_io_cache() with shared lock held?
>>>
>>> I pushed this version to my fuse_io_mode branch [1].
>>> Only tested generic/095 with FOPEN_DIRECT_IO and
>>> DIRECT_IO_ALLOW_MMAP.
>>>
>>> Thanks,
>>> Amir.
>>>
>>> [1] https://github.com/amir73il/linux/commits/fuse_io_mode
>>
>> Thanks, will look into your changes next. I was looking into the initial
>> issue with generic/095 with my branch. Fixed by the attached patch. I
>> think it is generic and also applies to FOPEN_DIRECT_IO + mmap.
>> Interesting is that filemap_range_has_writeback() is exported, but there
>> was no user. Hopefully nobody submits an unexport patch in the mean time.
>>
> 
> Ok. Now I am pretty sure that filemap_range_has_writeback() should be
> check after taking the shared lock in fuse_dio_lock() as in my branch and
> not in fuse_dio_wr_exclusive_lock() outside the lock.



> 
> But at the same time, it is a little concerning that you are able to observe
> dirty pages on a fuse inode after success of fuse_inode_deny_io_cache().
> The whole point of fuse_inode_deny_io_cache() is that it should be
> granted after all users of the inode page cache are gone.
> 
> Is it expected that fuse inode pages remain dirty after no more open files
> and no more mmaps?


I'm actually not sure anymore if filemap_range_has_writeback() is 
actually needed. In fuse_flush() it calls write_inode_now(inode, 1), but 
I don't think that will flush queued fi->writectr (fi->writepages). Will 
report back in the afternoon.


> 
> Did we miss some case of access to page cache? unaligned dio perhaps?

Yeah, there is indeed another problem,
fuse_cache_write_iter() can fall back to page writes, but I had 
especially added a warning message in temporary patch - I didn't manage 
to trigger that path yet. Will add a fix for that.

Thanks,
Bernd



