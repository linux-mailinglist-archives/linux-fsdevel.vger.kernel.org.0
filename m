Return-Path: <linux-fsdevel+bounces-5135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72AE8085A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 11:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C941C21C6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24243199D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="VoG6d39Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNeEMHea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32C10D0
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 01:12:38 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id B21F35C005B;
	Thu,  7 Dec 2023 04:12:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 07 Dec 2023 04:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701940357; x=1702026757; bh=esDHwjAVxs7hPUyxIilCHFLro/pvAP6O/xz
	I//fk68M=; b=VoG6d39Z8te5dF+iemfWclCizV+L5YCtJQBVnf0oF+5qEji/6ob
	Q6EB37sEjcZb3fbSMV/0k0ahcq0si4kp9hjWvePuDUzsC4txjkIvr3KiL4boEHAG
	rxps0u/nMlDjinH4z+LFqIqJ8pHWft/v+UDcaaK43LsPXf9XtPfIPj5ActV3Er6t
	j6atSSuqrKWyOxu+VttQzS8O7GgDrb4VOBV5Jne1JX3KAMDVRJcGKrOkVB1aDwEX
	r/D0xAZmWDa63r232cLTPnGd5vaZPXG5Dwo9VeMaOYzd7ZkEpILqvYuNHbe/9PJr
	nbWoMbuv9CGNvxlGRwSB90lLCwFV1v5W0IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701940357; x=1702026757; bh=esDHwjAVxs7hPUyxIilCHFLro/pvAP6O/xz
	I//fk68M=; b=lNeEMHeaNW5ED3ZoueV2mBg9V7WbrrlR3ZaWIHVoY/ui/gNkroz
	ARygfm44pxKwV/18JyHDyTACjkZ8ZM04xwAo+bOHIIkr8uIvOq+/SEFUovpi8RWL
	ZemH6yrFKblZHg7piIWMkMVvfk38Lxq/W5q3qo6sus5JuelDqrZ164HVIkGNfkrC
	D8bzvVao1+uZeFlVGLcVNoXgRezTniI+WKIVE9HjZIAJaGFitqUryzfQa4xRpglT
	ROmUeE/ZUuR9Y81yn2zmpa6dJjmQvifPZEPmDC8+IzV/7kgxojVfonJMmyU/xmz5
	0VQC0SwBvJL4Q0PpsRovTh1wM+8ssbADB9g==
X-ME-Sender: <xms:hYxxZe2rrcUx1MEv59P7MNMr9mxewVIR6EulDig2vhxM_jGMBXlzow>
    <xme:hYxxZRE-239c3quuMJ3vTaoAwaJ5CtqXaMyMokRZfIEI7UY1I-FtHI-EqxrcaAM0Y
    xaRdXhPr8Ke5WLW>
X-ME-Received: <xmr:hYxxZW4LKVdhbH6Q3CVmTJQkvJ1AhbJNeWM8JLq2HysVgECNQZVeS8KhVJhlmpIC512N4lw2cgdpXhqFO0jv0b_nyyr6tgnW_gnUurNQm2Be-EltGyQt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfh
    hmqeenucggtffrrghtthgvrhhnpeeutdekieelgeehudekgffhtdduvddugfehleejjeeg
    leeuffeukeehfeehffevleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgt
    hhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:hYxxZf0dCi_5_oO4-YwCQ9NhbhqXxvb_QfQkAdvMDAC5dSdudYt_lA>
    <xmx:hYxxZRHXv2VTN8PaIhvX7bWJib6tdhKNKBXHVskXj6C7553eCZBmpA>
    <xmx:hYxxZY90ejAFMnfgvv--HKkkNvg0vjKPpconrO1GSdYv87sFSuj5hA>
    <xmx:hYxxZY1uRJ_I94xLZTAvIjvgAtE_AWt30UuZx72xVOFgK8tkOwdqpg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 04:12:36 -0500 (EST)
Message-ID: <718af4ac-e33d-4dd5-9009-5f90e7fa0339@fastmail.fm>
Date: Thu, 7 Dec 2023 10:12:35 +0100
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
 <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm>
 <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/7/23 08:39, Amir Goldstein wrote:
> On Thu, Dec 7, 2023 at 1:28 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 12/6/23 09:25, Amir Goldstein wrote:
>>>>>> Is it actually important for FUSE_DIRECT_IO_ALLOW_MMAP fs
>>>>>> (e.g. virtiofsd) to support FOPEN_PARALLEL_DIRECT_WRITES?
>>>>>> I guess not otherwise, the combination would have been tested.
>>>>>
>>>>> I'm not sure how many people are aware of these different flags/features.
>>>>> I had just finalized the backport of the related patches to RHEL8 on
>>>>> Friday, as we (or our customers) need both for different jobs.
>>>>>
>>>>>>
>>>>>> FOPEN_PARALLEL_DIRECT_WRITES is typically important for
>>>>>> network fs and FUSE_DIRECT_IO_ALLOW_MMAP is typically not
>>>>>> for network fs. Right?
>>>>>
>>>>> We kind of have these use cases for our network file systems
>>>>>
>>>>> FOPEN_PARALLEL_DIRECT_WRITES:
>>>>>       - Traditional HPC, large files, parallel IO
>>>>>       - Large file used on local node as container for many small files
>>>>>
>>>>> FUSE_DIRECT_IO_ALLOW_MMAP:
>>>>>       - compilation through gcc (not so important, just not nice when it
>>>>> does not work)
>>>>>       - rather recent: python libraries using mmap _reads_. As it is read
>>>>> only no issue of consistency.
>>>>>
>>>>>
>>>>> These jobs do not intermix - no issue as in generic/095. If such
>>>>> applications really exist, I have no issue with a serialization penalty.
>>>>> Just disabling FOPEN_PARALLEL_DIRECT_WRITES because other
>>>>> nodes/applications need FUSE_DIRECT_IO_ALLOW_MMAP is not so nice.
>>>>>
>>>>> Final goal is also to have FOPEN_PARALLEL_DIRECT_WRITES to work on plain
>>>>> O_DIRECT and not only for FUSE_DIRECT_IO - I need to update this branch
>>>>> and post the next version
>>>>> https://github.com/bsbernd/linux/commits/fuse-dio-v4
>>>>>
>>>>>
>>>>> In the mean time I have another idea how to solve
>>>>> FOPEN_PARALLEL_DIRECT_WRITES + FUSE_DIRECT_IO_ALLOW_MMAP
>>>>
>>>> Please find attached what I had in my mind. With that generic/095 is not
>>>> crashing for me anymore. I just finished the initial coding - it still
>>>> needs a bit cleanup and maybe a few comments.
>>>>
>>>
>>> Nice. I like the FUSE_I_CACHE_WRITES state.
>>> For FUSE_PASSTHROUGH I will need to track if inode is open/mapped
>>> in caching mode, so FUSE_I_CACHE_WRITES can be cleared on release
>>> of the last open file of the inode.
>>>
>>> I did not understand some of the complexity here:
>>>
>>>>          /* The inode ever got page writes and we do not know for sure
>>>>           * in the DIO path if these are pending - shared lock not possible */
>>>>          spin_lock(&fi->lock);
>>>>          if (!test_bit(FUSE_I_CACHE_WRITES, &fi->state)) {
>>>>                  if (!(*cnt_increased)) {
>>>
>>> How can *cnt_increased be true here?
>>
>> I think you missed the 2nd entry into this function, when the shared
>> lock was already taken?
> 
> Yeh, I did.
> 
>> I have changed the code now to have all
>> complexity in this function (test, lock, retest with lock, release,
>> wakeup). I hope that will make it easier to see the intention of the
>> code. Will post the new patches in the morning.
>>
> 
> Sounds good. Current version was a bit hard to follow.
> 
>>
>>>
>>>>                          fi->shared_lock_direct_io_ctr++;
>>>>                          *cnt_increased = true;
>>>>                  }
>>>>                  excl_lock = false;
>>>
>>> Seems like in every outcome of this function
>>> *cnt_increased = !excl_lock
>>> so there is not need for out arg cnt_increased
>>
>> If excl_lock would be used as input - yeah, would have worked as well.
>> Or a parameter like "retest-under-lock". Code is changed now to avoid
>> going in and out.
>>
>>>
>>>>          }
>>>>          spin_unlock(&fi->lock);
>>>>
>>>> out:
>>>>          if (excl_lock && *cnt_increased) {
>>>>                  bool wake = false;
>>>>                  spin_lock(&fi->lock);
>>>>                  if (--fi->shared_lock_direct_io_ctr == 0)
>>>>                          wake = true;
>>>>                  spin_unlock(&fi->lock);
>>>>                  if (wake)
>>>>                          wake_up(&fi->direct_io_waitq);
>>>>          }
>>>
>>> I don't see how this wake_up code is reachable.
>>>
>>> TBH, I don't fully understand the expected result.
>>> Surely, the behavior of dio mixed with mmap is undefined. Right?
>>> IIUC, your patch does not prevent dirtying page cache while dio is in
>>> flight. It only prevents writeback while dio is in flight, which is the same
>>> behavior as with exclusive inode lock. Right?
>>
>> Yeah, thanks. I will add it in the patch description.
>>
>> And there was actually an issue with the patch, as cache flushing needs
>> to be initiated before doing the lock decision, fixed now.
>>
> 
> I thought there was, because of the wait in fuse_send_writepage()
> but wasn't sure if I was following the flow correctly.
> 
>>>
>>> Maybe this interaction is spelled out somewhere else, but if not
>>> better spell it out for people like me that are new to this code.
>>
>> Sure, thanks a lot for your helpful comments!
>>
> 
> Just to be clear, this patch looks like a good improvement and
> is mostly independent of the "inode caching mode" and
> FOPEN_CACHE_MMAP idea that I suggested.
> 
> The only thing that my idea changes is replacing the
> FUSE_I_CACHE_WRITES state with a FUSE_I_CACHE_IO_MODE
> state, which is set earlier than FUSE_I_CACHE_WRITES
> on caching file open or first direct_io mmap and unlike
> FUSE_I_CACHE_WRITES, it is cleared on the last file close.

That is actually an improvement over my patch, I can add this in as 
well. Will also change to FUSE_I_CACHE_IO_MODE and update the patch to 
set it the flag in fuse_file_mmap.

First need to investigate why a loop of generic/095 triggers a locking 
issue, probably something wrong with my latest patch version.

> 
> FUSE_I_CACHE_WRITES means that caching writes happened.
> FUSE_I_CACHE_IO_MODE means the caching writes and reads
> may happen.
> 
> FOPEN_PARALLEL_DIRECT_WRITES obviously shouldn't care
> about "caching reads may happen", but IMO that is a small trade off
> to make for maintaining the same state for
> "do not allow parallel dio" and "do not allow passthrough open".

Yeah and better to improve things (and add more complexity) when someone 
has a real live workload.


Thanks,
Bernd

