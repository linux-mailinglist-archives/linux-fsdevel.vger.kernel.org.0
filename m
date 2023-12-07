Return-Path: <linux-fsdevel+bounces-5133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95521808598
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 11:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64278B209CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176D37D14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="nuRtmPSn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h+lf17fR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B73E10C3
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 00:56:23 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 780B35C01DA;
	Thu,  7 Dec 2023 03:56:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 07 Dec 2023 03:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701939380; x=1702025780; bh=PkOQFYOrwAv5+bw6+i9x6WT4/rCNJ/rW2TV
	uc2i5Zq0=; b=nuRtmPSnXWfZ4+KJGjni0Q7wUg7mAxUrGDD80kgmnwAPxy3sIcS
	DY89ThFVpDUdlXZkLq2OdDKQDOEJ26u2R5yitqWQjF94jEzxBJDC4jo3B+HWAe9g
	dQrkVtqXV9xqPVnr1M51RuJwHWPz/9jI6b91rZkE1gMJyf1bvZKZMB0qVe74VP3g
	FeMRgYvpfqT4bYmN7IpJAO8di4WAg/wh5T8/nSJ3cgk9iOODzZ77TUcKbWhnSwHw
	OlqUK9udXUGXGrQFpCQ9qIl7E0eMEyR61BVOUZVEhkgUHhcZVg6Y+Fu62Nkb5mXI
	gFiFIOTqbGTGtjiSsf+PI1Cw7042LCMCtdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701939380; x=1702025780; bh=PkOQFYOrwAv5+bw6+i9x6WT4/rCNJ/rW2TV
	uc2i5Zq0=; b=h+lf17fR1J2PjtPcg5nKcPJq9uGmcbpSiWwfNpQDVWAD+LsGUke
	Wv9XKdfIu4SJGXN3UNOClbQQRsEQcA72f5MmpaEZmAb+BZPClHsLVcWhW0v0nbvy
	YdLEeAk14SfohfnhFzRSEGd5zuJqODy/VuHmuDq0w1AEw+i7aG3X8a/t+3X7/POW
	V+B0ey6iCaGvXcwY49RD0fnRmapPTysP+DoaLL9gIIPqHHCkeuqdAyDO2uhYGrwE
	ayzUdAya6T+IE3gVe+X0KiX/l3pWE7XPatXNcjGnVTIjX2nEg3PbATGo7q0p2Kos
	1tuMAbl/wS+zyxRu4oNEiUQFfY1neqC+a2Q==
X-ME-Sender: <xms:tIhxZYcXuMw3m219dQpkQMrZV4eW90awwSagedm2ugoQWmonSMiosg>
    <xme:tIhxZaNq75lYCHvidC8d8Ed5MsHYlpyRKFNTyVpREgDL07Gfwb0erERY-RRNIxPfL
    U_cAtacFi_azlyz>
X-ME-Received: <xmr:tIhxZZgxY0QmXpq8RMGb_qIkYAaOh6FNDP3R4FGJLjlp5a6mcayqGpdL1Gt2GII9jAowtHkL3E3GT8i8nGTmGRZWMjGEzQajkepS_NDX5IbAUnnsllzP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeeg
    veelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:tIhxZd8ZzglC2b9sRPiWO3zdRtUjnZNdqrBcL2w8dpjc-zYRcFG2QQ>
    <xmx:tIhxZUsi189iQDlL1Yrg_MV3H1yoc_2cg4s0YhXa_KQ20AVRXMfrIw>
    <xmx:tIhxZUGYc--cpmg-imj1TKgHwVUVSv3K0BLvQ0U2ShzxFmkjbANHbQ>
    <xmx:tIhxZZ_j5Fh_o7WzXBcVAaNUu3KRnL_JYQQdaiLCh8OnwLttX53PCQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 03:56:18 -0500 (EST)
Message-ID: <89bf04b5-fefb-415a-942b-a4e1dc18a62a@fastmail.fm>
Date: Thu, 7 Dec 2023 09:56:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Daniel Rosenberg <drosen@google.com>,
 Paul Lawrence <paullawrence@google.com>,
 Alessio Balsini <balsini@android.com>, Christian Brauner
 <brauner@kernel.org>, fuse-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
References: <20231016160902.2316986-1-amir73il@gmail.com>
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
 <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
 <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com>
 <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
 <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
 <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
 <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
 <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
 <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com>
 <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
 <CAOQ4uxhKEGxLQ4nR1RfX+37x6KN-Vy8X_TobYpETtjcWng+=DA@mail.gmail.com>
 <f224ffac-c59e-47dd-8e11-721d7b1c7104@fastmail.fm>
 <CAOQ4uxh1UWY_OLV1Zq-phFXcOFVp=EJHtgZdXB021Fr-ZHPWzg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxh1UWY_OLV1Zq-phFXcOFVp=EJHtgZdXB021Fr-ZHPWzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/7/23 08:23, Amir Goldstein wrote:
> On Thu, Dec 7, 2023 at 1:11 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Amir,
>>
>>
>> On 12/6/23 10:59, Amir Goldstein wrote:
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
>>>>> A bit more challenging, because we will need to track unmounts, or at
>>>>> least track
>>>>> "was_cached_mmaped" state per file, but doable.
>>>>
>>>> Tracking unmaps via fuse_vma_close() should not be difficult.
>>>>
>>>
>>> I think that it is.
>>>
>>> fuse_vma_close() does not seem to be balanced with fuse_file_mmap()
>>> because IIUC, maps can be cloned via fork() etc.
>>>
>>> It tried to implement an iocachectr refcount to track cache mmaps,
>>> but it keeps underflowing in fuse_vma_close().
>>>
>>> I would like us to consider a slightly different model.
>>>
>>> We agreed that caching and passthrough mode on the same
>>> inode cannot mix and there is no problem with different modes
>>> per inode on the same filesystem.
>>>
>>> I have a use case for mixing direct_io and passthrough on the
>>> same inode (i.e. inode in passthrough mode).
>>>
>>> I have no use case (yet) for the transition from caching to passthrough
>>> mode on the same inode and direct_io cached mmaps complicate
>>> things quite a bit for this scenario.
>>>
>>> My proposal is to taint a direct_io file with FOPEN_CACHE_MMAP
>>> if it was ever mmaped using page cache.
>>> We will not try to clean this flag in fuse_vma_close(), it stays with
>>> the file until release.
>>>
>>> An FOPEN_CACHE_MMAP file forces an inode into caching mode,
>>> same as a regular caching open.
>>
>> where do you actually want to set that flag? My initial idea for
>> FUSE_I_CACHE_WRITES was to set that in fuse_file_mmap, but I would have
>> needed the i_rwsem lock and that resulted in a lock ordering issue.
>>
> 
> Yes, the idea is to set this flag on the first mmap of a FOPEN_DIRECT_IO file.
> Why does that require an i_rwsem lock?
> 
> Before setting FUSE_I_CACHE_WRITES inode flag, your patch does:
>      wait_event(fi->direct_io_waitq, fi->shared_lock_direct_io_ctr == 0);
> 
> We can do the same in direct_io mmap, before setting the
> FOPEN_CACHE_MMAP file flag and consequently changing inode
> mode to caching. No?


Yeah right, that will work.

Thanks,
Bernd

