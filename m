Return-Path: <linux-fsdevel+bounces-4278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5527FE350
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8141DB20994
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10B47A51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="snhJOtvr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NIQxiM/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C89CA8
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 14:01:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 455355C0203;
	Wed, 29 Nov 2023 17:01:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 29 Nov 2023 17:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701295316; x=1701381716; bh=lXOO7lu24YffT49ykZAtLwujUQPygkahy5d
	Sb/cpT7Y=; b=snhJOtvrSXENb4ah8llNf33xfgJfx9AD2xfvXExw+Ol5lRBXF6n
	IRbpKSVNlyi8rHJCYRI4jLIu9x9djJ0MPWpjjorAtspHHvzwiejXtI9uQGqJXp36
	hdIYne/v5xrwb2+TJY8tBAsUdzz4C8R/d17uFfq4Ju+UE9TAW/VIfMh5tHjH7Yyy
	t8EVkIUZ+UTLH58TzydJpv7y7BgQxbMvoUqaTgpjqN+TQ146M/UYBS9ifKg8Dzpb
	XhO4VKDbv3X0uRt0OUItTwdDFso9Ju6uH2bokfzUbRDMuTtsVNQJjXtlWf91ZxEj
	rlnSD9+OY0omaJ+SFv00/FgTgOJfNKFveEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701295316; x=1701381716; bh=lXOO7lu24YffT49ykZAtLwujUQPygkahy5d
	Sb/cpT7Y=; b=NIQxiM/YwI8dro9b91N+tOohs+05n4ke5RAxAwiGc5J1IRFvd5Y
	F0msYxHf0yW1I9iO5fMaACuuDyrwznMMboPsXPFuTw9zpqYbzR/MRMA3sLGkqw89
	RzQq6L1ecpk19P12FTYViB+BrUTWVW4NLF6aGgIpNFdCtxkV6TTgZEqmCr/0vJFj
	a3mRSP8/V2n4OjklqpvoiHaMki9HKMD9wHb7+n+blYbJ4H9FpkIZ7cf04TGJ0Vur
	7O6BTzpn2Gwumj50TZJ9HHUWSU0oG0s0gxtxiq/xDEPRf3PhX+tGKvBlqg0JxiS6
	MamNOm9QWNvuRPJNmFf9O+c/rBbXGe1H96Q==
X-ME-Sender: <xms:07RnZRSkvgQwkMMpyqWrpteYAaE0QVVdLjmPLh-w3Fskdjov9QYEcw>
    <xme:07RnZazw-y7HnVia1zzHihC--ip8vTFJeqyzrHqyaFNrnIOq2iIM6iBX8wNJglXJJ
    Aw1Z2e9UGOP-6Lq>
X-ME-Received: <xmr:07RnZW1ZcFkY_wsC5tZeyesYkJ26MqKDj9depdqSsfLo1H0i8AXlO-OTbbU2jnBplFkd-tw9uztSDg6kkKBwlsc8kdOFf1Ypob_pIWOVGXcjrjuzzmpb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeeg
    veelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:07RnZZBtjUCjuusEf8Nz_jVeg9X5Vq7XIwgR4QVQcucnMzJ3XNj08g>
    <xmx:07RnZajKqqlEEzG0esabKbPzLMJ66k0nnsXoxQPDngPwu24xghdJiw>
    <xmx:07RnZdrVkbOGpm5mzMCneZCA2_LO0Fh2L0FcR4ZfRb5X0YU6zVVwNg>
    <xmx:1LRnZTV3TDPzU3Aginisi_-Gy3MYmVIP2NJ-P0CK3h-TNOnCH2Sayw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 17:01:53 -0500 (EST)
Message-ID: <de783ce4-6ac1-42ca-94a2-a15aa1795b5d@fastmail.fm>
Date: Wed, 29 Nov 2023 23:01:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
Content-Language: en-US, de-DE
To: Antonio SJ Musumeci <trapexit@spawn.link>,
 Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Daniel Rosenberg <drosen@google.com>,
 Paul Lawrence <paullawrence@google.com>,
 Alessio Balsini <balsini@android.com>, Christian Brauner
 <brauner@kernel.org>, fuse-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
References: <20231016160902.2316986-1-amir73il@gmail.com>
 <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
 <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
 <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
 <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
 <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com>
 <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
 <CAOQ4uxiCjX2uQqdikWsjnPtpNeHfFk_DnWO3Zz2QS3ULoZkGiA@mail.gmail.com>
 <2f6513fa-68d8-43c8-87a4-62416c3e1bfd@fastmail.fm>
 <44ff6b37-7c4b-485d-8ebf-de5fadd3c527@spawn.link>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <44ff6b37-7c4b-485d-8ebf-de5fadd3c527@spawn.link>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/29/23 22:39, Antonio SJ Musumeci wrote:
> On 11/29/23 14:46, Bernd Schubert wrote:
>>
>>
>> On 11/29/23 18:39, Amir Goldstein wrote:
>>> On Wed, Nov 29, 2023 at 6:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>
>>>> On Wed, 29 Nov 2023 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:
>>>>
>>>>> direct I/O read()/write() is never a problem.
>>>>>
>>>>> The question is whether mmap() on a file opened with FOPEN_DIRECT_IO
>>>>> when the inode is in passthrough mode, also uses fuse_passthrough_mmap()?
>>>>
>>>> I think it should.
>>>>
>>>>> or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_IO &&
>>>>> vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
>>>>> is denied?
>>>>
>>>> What would be the use case for FOPEN_DIRECT_IO with passthrough mmap?
>>>>
>>>
>>> I don't have a use case. That's why I was wondering if we should
>>> support it at all, but will try to make it work.
>>
>> What is actually the use case for FOPEN_DIRECT_IO and passthrough?
>> Avoiding double page cache?
>>
>>>
>>>>> A bit more challenging, because we will need to track unmounts, or at
>>>>> least track
>>>>> "was_cached_mmaped" state per file, but doable.
>>>>
>>>> Tracking unmaps via fuse_vma_close() should not be difficult.
>>>>
>>>
>>> OK. so any existing mmap, whether on FOPEN_DIRECT_IO or not
>>> always prevents an inode from being "neutral".
>>>
>>
>>
>> Thanks,
>> Bernd
>>
> 
>   > Avoiding double page cache?
> 
> Currently my users enable direct_io because 1) it is typically
> materially faster than not 2) avoiding double page caching (it is a
> union filesystem).

3) You want coherency for network file systems (our use case).

So performance kind of means it is preferred to have it enabled for 
passthrough. And with that MAP_SHARED gets rather important, imho. I 
don't know if recent gcc versions still do it, but gcc used to write 
files using MAP_SHARED. In the HPC AI world python tools also tend to do 
IO with MAP_SHARED.

> 
> The only real reason people disable direct_io is because many apps need
> shared mmap. I've implemented a mode to lookup details about the
> requesting app and optionally disable direct_io for apps which are known
> to need shared mmap but that isn't ideal. The relaxed mode being
> discussed would likely be more performant and more transparent to the
> user. That transparency is nice if that can continue as it is already
> pretty difficult to explain all these options to the layman.
> 
> Offtopic: What happens in passthrough mode when an error occurs?
> Currently I have a number of behaviors relying on the fact that I can
> intercept and respond to errors. I think my users will gladly give them
> up for near native io perf but if they can get both it would be nice.
> 
> 

