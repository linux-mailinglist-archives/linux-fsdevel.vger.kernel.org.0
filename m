Return-Path: <linux-fsdevel+bounces-5071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768C9807D50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17512822D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A5B7F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="JxMPA30G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yFKJbaip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84338A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 15:28:18 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 4B1053200A85;
	Wed,  6 Dec 2023 18:28:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 06 Dec 2023 18:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701905296; x=1701991696; bh=B1rFeRkS3GeZSRxt6EOkZssTjs7TOWBNo53
	RsxFTFrA=; b=JxMPA30Gi7+OBpdhbiy/qSfikRSADxTO8rsbZ6mapMuB/Eya7oC
	htYhuMBT+ktlxpXyPPI5vTY3nzGpf0jssQp5iRhcDdqMaDcWurRrRZTorfBzdmPy
	rwquoGiM26GRMpaYVZp9dIzxYEKg/Hl/aYsx/b387HUc97oXwv6ykgV/0RshJrTe
	3GVL/XVSkT7OjGppZPq8b9zMV2fcWqejN0r9iQrBqda6dqJy/WvkAD1x8R9xU+UM
	B5rWpe/APmcnndNHMBt2tTirUgcBDqDeJ6Hr3540/8agOiFEnx84kRb7oXsOoJ1Y
	ZDaiS5iCZYcbTWW7sAKOHzmsszAtoZikE0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701905296; x=1701991696; bh=B1rFeRkS3GeZSRxt6EOkZssTjs7TOWBNo53
	RsxFTFrA=; b=yFKJbaip0VSgSNU3atDuRFwMmM4naGCnhEY8Yj9tBgAbgKKt40M
	7pHBvLogK3lPGWgRyYkYDJWAMqBuiD9USUUgffbY/G8DMBhu9Ts6RpMElKEgXLKc
	u173V4V4OvBeXGrUnxBA0AqalCS0fUMN5GErgSVhAeUVTGG6IKPH+lc4+TFVnwDs
	FQaoFwiEFd6E6S6rOHS+S0HXnTMYhwNJ29cdfWKE+Hd1yz3cvQzQ+PA7HBKWl13W
	hQ31Mt1OcRDBrFvk9pqfq7t0aeunTpWHC0Zws68MOLR01VmeIIo4QB7Y+vidILF/
	l19UBKTs31uO50eSYth2ISvYu+Snm0BIKLw==
X-ME-Sender: <xms:kANxZRQ9c13mH_iETKHOaVW7et7Wb86_r8DJYenU8oCQ4r9gPOZDNw>
    <xme:kANxZawVV0G9l7DQHIfXUN3t0cgkxtibLoZ4DjxeJLn9KwP6g2ooUne_TaOumHNPb
    H8PWIgfNdsa6ig5>
X-ME-Received: <xmr:kANxZW0afSmGF4ydJ86-sNhVv4MVtA1y01QEJRsQGbkcwO-Z7JMo0YU5GUScueD_SgY15Ab95hM6J5M3Dr40SNjxk2zavVWiJV1ehvyqU6JQOJtNPtx_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnheptddugefgjeefkedtgefhheegvddtfeejheeh
    ueeufffhfeelfeeuheetfedutdeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:kANxZZCaYTdZ7LTpFjdSMEiP5sfim4WMpUbV7hvEi2gKV0r7ztoe2g>
    <xmx:kANxZajzb954YxD3RsDendzNnV92h8KG820CDMjPdMJGBXEy7oKuRw>
    <xmx:kANxZdpKWhrKovjKAhqssHo1HY9eb1DDqYPhfUB5-NnfTeObqT931g>
    <xmx:kANxZehioYnTbPt-E2ZsSsdF0tkQZ-rBO1uh6TWigxDeXWJw9WfYnA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 18:28:14 -0500 (EST)
Message-ID: <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm>
Date: Thu, 7 Dec 2023 00:28:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
Content-Language: en-US, de-DE
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>,
 linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com,
 hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>,
 Dharmendra Singh <dsingh@ddn.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm>
 <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
 <CAOQ4uxh6RpoyZ051fQLKNHnXfypoGsPO9szU0cR6Va+NR_JELw@mail.gmail.com>
 <49fdbcd1-5442-4cd4-8a85-1ddb40291b7d@fastmail.fm>
 <CAOQ4uxjfU0X9Q4bUoQd_U56y4yUUKGaqyFS1EJ3FGAPrmBMSkg@mail.gmail.com>
 <CAJfpeguuB21HNeiK-2o_5cbGUWBh4uu0AmexREuhEH8JgqDAaQ@mail.gmail.com>
 <abbdf30f-c459-4eab-9254-7b24afc5771b@fastmail.fm>
 <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
 <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
 <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm>
 <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
 <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/6/23 09:25, Amir Goldstein wrote:
>>>> Is it actually important for FUSE_DIRECT_IO_ALLOW_MMAP fs
>>>> (e.g. virtiofsd) to support FOPEN_PARALLEL_DIRECT_WRITES?
>>>> I guess not otherwise, the combination would have been tested.
>>>
>>> I'm not sure how many people are aware of these different flags/features.
>>> I had just finalized the backport of the related patches to RHEL8 on
>>> Friday, as we (or our customers) need both for different jobs.
>>>
>>>>
>>>> FOPEN_PARALLEL_DIRECT_WRITES is typically important for
>>>> network fs and FUSE_DIRECT_IO_ALLOW_MMAP is typically not
>>>> for network fs. Right?
>>>
>>> We kind of have these use cases for our network file systems
>>>
>>> FOPEN_PARALLEL_DIRECT_WRITES:
>>>      - Traditional HPC, large files, parallel IO
>>>      - Large file used on local node as container for many small files
>>>
>>> FUSE_DIRECT_IO_ALLOW_MMAP:
>>>      - compilation through gcc (not so important, just not nice when it
>>> does not work)
>>>      - rather recent: python libraries using mmap _reads_. As it is read
>>> only no issue of consistency.
>>>
>>>
>>> These jobs do not intermix - no issue as in generic/095. If such
>>> applications really exist, I have no issue with a serialization penalty.
>>> Just disabling FOPEN_PARALLEL_DIRECT_WRITES because other
>>> nodes/applications need FUSE_DIRECT_IO_ALLOW_MMAP is not so nice.
>>>
>>> Final goal is also to have FOPEN_PARALLEL_DIRECT_WRITES to work on plain
>>> O_DIRECT and not only for FUSE_DIRECT_IO - I need to update this branch
>>> and post the next version
>>> https://github.com/bsbernd/linux/commits/fuse-dio-v4
>>>
>>>
>>> In the mean time I have another idea how to solve
>>> FOPEN_PARALLEL_DIRECT_WRITES + FUSE_DIRECT_IO_ALLOW_MMAP
>>
>> Please find attached what I had in my mind. With that generic/095 is not
>> crashing for me anymore. I just finished the initial coding - it still
>> needs a bit cleanup and maybe a few comments.
>>
> 
> Nice. I like the FUSE_I_CACHE_WRITES state.
> For FUSE_PASSTHROUGH I will need to track if inode is open/mapped
> in caching mode, so FUSE_I_CACHE_WRITES can be cleared on release
> of the last open file of the inode.
> 
> I did not understand some of the complexity here:
> 
>>         /* The inode ever got page writes and we do not know for sure
>>          * in the DIO path if these are pending - shared lock not possible */
>>         spin_lock(&fi->lock);
>>         if (!test_bit(FUSE_I_CACHE_WRITES, &fi->state)) {
>>                 if (!(*cnt_increased)) {
> 
> How can *cnt_increased be true here?

I think you missed the 2nd entry into this function, when the shared 
lock was already taken? I have changed the code now to have all 
complexity in this function (test, lock, retest with lock, release, 
wakeup). I hope that will make it easier to see the intention of the 
code. Will post the new patches in the morning.


> 
>>                         fi->shared_lock_direct_io_ctr++;
>>                         *cnt_increased = true;
>>                 }
>>                 excl_lock = false;
> 
> Seems like in every outcome of this function
> *cnt_increased = !excl_lock
> so there is not need for out arg cnt_increased

If excl_lock would be used as input - yeah, would have worked as well. 
Or a parameter like "retest-under-lock". Code is changed now to avoid 
going in and out.

> 
>>         }
>>         spin_unlock(&fi->lock);
>>
>> out:
>>         if (excl_lock && *cnt_increased) {
>>                 bool wake = false;
>>                 spin_lock(&fi->lock);
>>                 if (--fi->shared_lock_direct_io_ctr == 0)
>>                         wake = true;
>>                 spin_unlock(&fi->lock);
>>                 if (wake)
>>                         wake_up(&fi->direct_io_waitq);
>>         }
> 
> I don't see how this wake_up code is reachable.
> 
> TBH, I don't fully understand the expected result.
> Surely, the behavior of dio mixed with mmap is undefined. Right?
> IIUC, your patch does not prevent dirtying page cache while dio is in
> flight. It only prevents writeback while dio is in flight, which is the same
> behavior as with exclusive inode lock. Right?

Yeah, thanks. I will add it in the patch description.

And there was actually an issue with the patch, as cache flushing needs 
to be initiated before doing the lock decision, fixed now.

> 
> Maybe this interaction is spelled out somewhere else, but if not
> better spell it out for people like me that are new to this code.

Sure, thanks a lot for your helpful comments!



Thanks,
Bernd

