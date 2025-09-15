Return-Path: <linux-fsdevel+bounces-61286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E9CB572D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9867B3A57A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE332ECE8D;
	Mon, 15 Sep 2025 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="jDK53D5f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RohgOMoe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146A2EBBB9;
	Mon, 15 Sep 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924831; cv=none; b=CaSlY1Osi9PsU1SaWY9eWkCvnrnGhvDjtqYyzNSB7Wk6+RbtalOC9lcEQOysWJx4tsslo/0gswj7paaK9EWvAzFc8JkGf0yVTaggk4p6CR+lnp4j9Plv7XTzqWcq76mTB9yPnKD4LMZJ4ZbS/XKJAUFo4GMjHy4Uw9mdAPGss3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924831; c=relaxed/simple;
	bh=MwKW1j5C/Mxi9S65ThJMDTePbmKy4k+vT+QSpNKt1Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFGZCU7/Fwa4+lxdag3Ml1TXJqjH/7wKC3qDbLHnnn+jwnkFZ+WTvOc0vfmhSzPz2mbmJpo6zyxgbLIL5gvO2nlj6stZJrIIHqX3mgEHnzlRyqmPaMeHePpsM6dLKAjVGLl1P8Bn2f2PlJ1oxsQAw/baBeLuK1jn3ALP757KxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=jDK53D5f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RohgOMoe; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9ABEA1D00139;
	Mon, 15 Sep 2025 04:27:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 04:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757924827;
	 x=1758011227; bh=gAjnymfqtKvOeXp2MIvQ9ZaX/+pZDQWnOgc69c44Ros=; b=
	jDK53D5frxtjCbVAZjfA9JmdznYEWXcejoz6EwxMnjboVNGGJ1K3fKl0dPcf5Axj
	Ugmb5e0YCPwHaTonR7K+YfIpc7adCAKbevaNhSSPCbe8grDzvItqBOHyCfVK7+a7
	54T9CPtwW9nNMvkjScCeJKLTf0lHooQJLpB0KlLN9UE+l8gw07Red5qVK/aWTSlF
	Or4aJXSz7VCzL7gcoBS9XrZoKCsid1AsSy6AIe1670EUwqtTLXWF1sCZnE8omneY
	krfKIg+D1c9F/rznCnlxrnqccAbChqOHgHQDjA/0L6Nv/KB0/6qmA9IBeRKrMJOL
	OchDcYlW6hvG8j/kVNBs6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757924827; x=
	1758011227; bh=gAjnymfqtKvOeXp2MIvQ9ZaX/+pZDQWnOgc69c44Ros=; b=R
	ohgOMoeBvcadqn/jeU/fDT8tnc08DlyRNjcnWn83+K1BtoRrSHBOSdHKelJU7KtU
	HgkAyk7xbSLKbLsd1E/jnAIDa4f1w0LfDsfHRHc3lHqPLUzZHatEtEzIMt/8fTed
	BmZvhg477M/7l/HL3xHGBhJVnlP1i1R1+Gi2m+71WVia7A/dLO/zouJ2TPk0U32d
	Lp7ZAVH3rfKJulg5LUcO/QjVGR/TEaw9J0bC1Q7SfSobjGMve8SoLNOL5za7ynlV
	+NP22kM9s6gHbnmb9dEumzbcQ3B5NlDGLBTNXNT+YjrX2b31mZ63C08g6ysOISr0
	LDK8Cfw2Ghg3Zb6/R+JlA==
X-ME-Sender: <xms:2s3HaKLa-Y8vsDGeZBhhkgtyNJPr_kwxJhPcpLhwGpJyRQVn6_nHyA>
    <xme:2s3HaMzSp1IkbEAq9C9sExHQGSkxNX5aQbDDhA0gvZlPECWLqGV0ezgmYRGfN-YeE
    cZ2ok6yRNOoGctj>
X-ME-Received: <xmr:2s3HaAu_iUZhQRZcXpzlc2grH0Pz9V1LiBjRj7lmtz-tbYnxgUGBqz5w0kxCk5B1fG6LBmPhe6daYTUUpnyp0qW2sUzuJ_ZVh1EDYDGxavX7YBSFBmWt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnheptdeuvdeuudeltddukefhueeludduieejvdevveevteduvdefuedvkeffjeel
    ueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmh
    hirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopegujhifohhngheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhuihhssehighgrlhhirgdrtghomhdprhgtphhtth
    hopehthihtshhosehmihhtrdgvughupdhrtghpthhtohepmhhikhhlohhssehsiigvrhgv
    ughirdhhuhdprhgtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehktghhvghnseguughnrdgtohhm
X-ME-Proxy: <xmx:2s3HaPA1dTv6EdmdTHAFYVvk3cdqGptSSbB9slKSa1oyNdGLxuaMHg>
    <xmx:2s3HaCF-afBXDWbgLA_m_xlQ7peibKpCF_tz501dtoRtpP38m7QvSw>
    <xmx:2s3HaPCSTnzpL4OcJ08nsrNfK8NRxjGqd6AqETpwD-6StKbH2Fmvjw>
    <xmx:2s3HaIkxLUsuYipnGac7C28nO6EZP7ItCzXiacfQq-zAdZVz04finw>
    <xmx:283HaMqQ1r-jVFsVWSZzHaNomnPFQ8dL602rdZq6zgZNWGVMVDDycshH>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:27:05 -0400 (EDT)
Message-ID: <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
Date: Mon, 15 Sep 2025 10:27:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Henriques <luis@igalia.com>, Theodore Ts'o <tytso@mit.edu>,
 Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Chen <kchen@ddn.com>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs> <20250731130458.GE273706@mit.edu>
 <20250731173858.GE2672029@frogsfrogsfrogs> <8734abgxfl.fsf@igalia.com>
 <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
 <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
 <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
 <20250912145857.GQ8117@frogsfrogsfrogs>
 <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/15/25 09:07, Amir Goldstein wrote:
> On Fri, Sep 12, 2025 at 4:58 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>
>> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
>>>
>>>
>>> On 9/12/25 13:41, Amir Goldstein wrote:
>>>> On Fri, Sep 12, 2025 at 12:31 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 8/1/25 12:15, Luis Henriques wrote:
>>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
>>>>>>
>>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
>>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
>>>>>>>>>
>>>>>>>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
>>>>>>>>> could restart itself.  It's unclear if doing so will actually enable us
>>>>>>>>> to clear the condition that caused the failure in the first place, but I
>>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
>>>>>>>>> aren't totally crazy.
>>>>>>>>
>>>>>>>> I'm trying to understand what the failure scenario is here.  Is this
>>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
>>>>>>>> is supposed to happen with respect to open files, metadata and data
>>>>>>>> modifications which were in transit, etc.?  Sure, fuse2fs could run
>>>>>>>> e2fsck -fy, but if there are dirty inode on the system, that's going
>>>>>>>> potentally to be out of sync, right?
>>>>>>>>
>>>>>>>> What are the recovery semantics that we hope to be able to provide?
>>>>>>>
>>>>>>> <echoing what we said on the ext4 call this morning>
>>>>>>>
>>>>>>> With iomap, most of the dirty state is in the kernel, so I think the new
>>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
>>>>>>> would initiate GETATTR requests on all the cached inodes to validate
>>>>>>> that they still exist; and then resend all the unacknowledged requests
>>>>>>> that were pending at the time.  It might be the case that you have to
>>>>>>> that in the reverse order; I only know enough about the design of fuse
>>>>>>> to suspect that to be true.
>>>>>>>
>>>>>>> Anyhow once those are complete, I think we can resume operations with
>>>>>>> the surviving inodes.  The ones that fail the GETATTR revalidation are
>>>>>>> fuse_make_bad'd, which effectively revokes them.
>>>>>>
>>>>>> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
>>>>>> but probably GETATTR is a better option.
>>>>>>
>>>>>> So, are you currently working on any of this?  Are you implementing this
>>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
>>>>>> look at fuse2fs too.
>>>>>
>>>>> Sorry for joining the discussion late, I was totally occupied, day and
>>>>> night. Added Kevin to CC, who is going to work on recovery on our
>>>>> DDN side.
>>>>>
>>>>> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
>>>>> server restart we want kernel to recover inodes and their lookup count.
>>>>> Now inode recovery might be hard, because we currently only have a
>>>>> 64-bit node-id - which is used my most fuse application as memory
>>>>> pointer.
>>>>>
>>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
>>>>> outstanding requests. And that ends up in most cases in sending requests
>>>>> with invalid node-IDs, that are casted and might provoke random memory
>>>>> access on restart. Kind of the same issue why fuse nfs export or
>>>>> open_by_handle_at doesn't work well right now.
>>>>>
>>>>> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
>>>>> would not return a 64-bit node ID, but a max 128 byte file handle.
>>>>> And then FUSE_REVALIDATE_FH on server restart.
>>>>> The file handles could be stored into the fuse inode and also used for
>>>>> NFS export.
>>>>>
>>>>> I *think* Amir had a similar idea, but I don't find the link quickly.
>>>>> Adding Amir to CC.
>>>>
>>>> Or maybe it was Miklos' idea. Hard to keep track of this rolling thread:
>>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
>>>
>>> Thanks for the reference Amir! I even had been in that thread.
>>>
>>>>
>>>>>
>>>>> Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
>>>>> will iterate over all superblock inodes and mark them with fuse_make_bad.
>>>>> Any objections against that?
>>
>> What if you actually /can/ reuse a nodeid after a restart?  Consider
>> fuse4fs, where the nodeid is the on-disk inode number.  After a restart,
>> you can reconnect the fuse_inode to the ondisk inode, assuming recovery
>> didn't delete it, obviously.
> 
> FUSE_LOOKUP_HANDLE is a contract.
> If fuse4fs can reuse nodeid after restart then by all means, it should sign
> this contract, otherwise there is no way for client to know that the
> nodeids are persistent.
> If fuse4fs_handle := nodeid, that will make implementing the lookup_handle()
> API trivial.
> 
>>
>> I suppose you could just ask for refreshed stat information and either
>> the server gives it to you and the fuse_inode lives; or the server
>> returns ENOENT and then we mark it bad.  But I'd have to see code
>> patches to form a real opinion.
>>
> 
> You could make fuse4fs_handle := <nodeid:fuse_instance_id>
> where fuse_instance_id can be its start time or random number.
> for auto invalidate, or maybe the fuse_instance_id should be
> a native part of FUSE protocol so that client knows to only invalidate
> attr cache in case of fuse_instance_id change?
> 
> In any case, instead of a storm of revalidate messages after
> server restart, do it lazily on demand.

For a network file system, probably. For fuse4fs or other block
based file systems, not sure. Darrick has the example of fsck.
Let's assume fuse4fs runs with attribute and dentry timeouts > 0,
fuse-server gets restarted, fsck'ed and some files get removed.
Now reading these inodes would still work - wouldn't it
be better to invalidate the cache before going into operation
again?


Thanks,
Bernd

