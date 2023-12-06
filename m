Return-Path: <linux-fsdevel+bounces-5069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF0807D4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D95B21018
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1B23C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="d0N1j8g0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIECAy4P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2372181
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 15:11:29 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id AC22E32000CC;
	Wed,  6 Dec 2023 18:11:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 06 Dec 2023 18:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701904288; x=1701990688; bh=vWjaTzmZql7mKpC1NqH4/DiDovxyRicXjOd
	MLA5Hvh4=; b=d0N1j8g0oksakuYKqqNOkqNWenY+uLOA8KG4skVZMtoRvjvz9B5
	5yluzdRbFjCSXDhid/K5TOSVcB7RnuCIhdXH5LBxZMY4VEFlunxph1ZH00TCIvoE
	bFJ/dbMmWkWVFzdDd4MJXJrtFPPPkzk3sYhrJnYgHT3bNof9r0M6/riuJkzuAxiy
	h/E/tLrTPVBij1LbAwxbxn2jGbhtLP5Fv8XYB+V6MWVbmA+ubvOuyjkhy+kENSOb
	hwNlYym3JMMoatlX9LYMHwwsgomcvg9u0682KeAp91BVwKtmOreIvg53u7af29ul
	jjApB2fkVuxvL9Ej9Qm2vBi4IxzVTmbpyzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701904288; x=1701990688; bh=vWjaTzmZql7mKpC1NqH4/DiDovxyRicXjOd
	MLA5Hvh4=; b=oIECAy4PiNlqAMTKDhg7jpM3RVXZ3+CK37K+FT8/RI6ZtB7eNsk
	ligKWxRlWlVaoKmUn3YkMCIEv2ls+1Lgp2Jkn5ZF6lS5TBqjjl0uRB/+g/BCmj2U
	fnFuTH9sF0adS7w+mpS0cEC+zz1gE2OEmMr/WoV+K/6ohvxJ8UyWlwHRHH77zLlp
	8UgxXXXYa/BmQyc4o15dZ++PaqJDvk4Y2L8wliXSXeSNbkphOMd7+S+/mMeJgzSs
	srMxRbgwBtyV8PWSw3EodZd7mbIwJtHhsdOfN7pUypBKa3KGJVxAiNMAnS1MmbZ0
	sh+ZHOE9zsSf8WtIUKzmX3M42BmURkos+JQ==
X-ME-Sender: <xms:n_9wZZY3nXpf5Td0wIptGjYrViOuRP1kKSCd0_0MKawZv3Vfwa-DqA>
    <xme:n_9wZQaLHw8jTLfZp_CV0vbxIthvNcwfFq4Pjy7erZFfNjaiVEEJvScSCAX4RHQrJ
    iHWM_0Om8OsVQu2>
X-ME-Received: <xmr:n_9wZb_tPRzAdhzk7ty-khIjFv95AETnA8zcTv5kcWdLQhvZe2-LoPV8r1-x7N53EERipBciOWmkZ_-vhTUwQdelWgKpPiJYnyJ5rU20r3lNOX17g5nd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudevleegleffffekudekgeev
    lefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:n_9wZXpA77xm2sbX0OLReK4fKjvZeBYdm87ajxfV2V7OoayquZ1beA>
    <xmx:n_9wZUrUh94IF3Uv4IzcX9EmQ_Tt5RnymtlfQUFpDVOeSjGyCiMpRw>
    <xmx:n_9wZdR7rikWbzvFWnQUYJBXRkViHG14kEYyvGwuJuAGifMSB8Jmmw>
    <xmx:oP9wZcLiOUdfX4I7jBdcJjeKInH1Q20T8wp2LisuVwCfni0tIWwBTA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 18:11:26 -0500 (EST)
Message-ID: <f224ffac-c59e-47dd-8e11-721d7b1c7104@fastmail.fm>
Date: Thu, 7 Dec 2023 00:11:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Daniel Rosenberg <drosen@google.com>,
 Paul Lawrence <paullawrence@google.com>,
 Alessio Balsini <balsini@android.com>, Christian Brauner
 <brauner@kernel.org>, fuse-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
References: <20231016160902.2316986-1-amir73il@gmail.com>
 <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
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
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxhKEGxLQ4nR1RfX+37x6KN-Vy8X_TobYpETtjcWng+=DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Amir,


On 12/6/23 10:59, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 6:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Wed, 29 Nov 2023 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>>> direct I/O read()/write() is never a problem.
>>>
>>> The question is whether mmap() on a file opened with FOPEN_DIRECT_IO
>>> when the inode is in passthrough mode, also uses fuse_passthrough_mmap()?
>>
>> I think it should.
>>
>>> or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_IO &&
>>> vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
>>> is denied?
>>
>> What would be the use case for FOPEN_DIRECT_IO with passthrough mmap?
>>
>>> A bit more challenging, because we will need to track unmounts, or at
>>> least track
>>> "was_cached_mmaped" state per file, but doable.
>>
>> Tracking unmaps via fuse_vma_close() should not be difficult.
>>
> 
> I think that it is.
> 
> fuse_vma_close() does not seem to be balanced with fuse_file_mmap()
> because IIUC, maps can be cloned via fork() etc.
> 
> It tried to implement an iocachectr refcount to track cache mmaps,
> but it keeps underflowing in fuse_vma_close().
> 
> I would like us to consider a slightly different model.
> 
> We agreed that caching and passthrough mode on the same
> inode cannot mix and there is no problem with different modes
> per inode on the same filesystem.
> 
> I have a use case for mixing direct_io and passthrough on the
> same inode (i.e. inode in passthrough mode).
> 
> I have no use case (yet) for the transition from caching to passthrough
> mode on the same inode and direct_io cached mmaps complicate
> things quite a bit for this scenario.
> 
> My proposal is to taint a direct_io file with FOPEN_CACHE_MMAP
> if it was ever mmaped using page cache.
> We will not try to clean this flag in fuse_vma_close(), it stays with
> the file until release.
> 
> An FOPEN_CACHE_MMAP file forces an inode into caching mode,
> same as a regular caching open.

where do you actually want to set that flag? My initial idea for 
FUSE_I_CACHE_WRITES was to set that in fuse_file_mmap, but I would have 
needed the i_rwsem lock and that resulted in a lock ordering issue.

> We could allow server to set FOPEN_CACHE_MMAP along with
> FOPEN_DIRECT_IO to preemptively deny future passthrough open,
> but not sure this is important.
> If we wanted to, we could let this flag combination have the same
> meaning as direct_io_allow_mmap, but per file/inode.
> 
> In relation to the FOPEN_PARALLEL_DIRECT_WRITES vs.
> FUSE_DIRECT_IO_ALLOW_MMAP discussion, Bernd has suggested
> a per inode FUSE_I_CACHE_WRITES, state that tracks if caching writes
> were ever done on inode to allow parallel dio on the rest of the inodes
> in the filesystem.
> 
> FUSE_I_CACHE_WRITES is a sub-state of caching mode inode state.
> I think maybe caching mode would be enough for both use cases -
> preventing parallel dio and preventing passthrough open.
> 
> The result would be that parallel dio would be performed on inodes that
> are not currently open in caching mode and have not been mmaped
> at all (regardless of writes to page cache) using any of the currently
> open direct_io files.
> 
> As long as the applications that use mmap write (e.g. compiler)
> do not usually work on the same files as the applications that do
> parallel dio writes (e.g. db) and as long as files that are typically mmaped
> privately (exe and libs) don't need parallel dio writes,
> I think that FUSE_I_CACHE_WRITES state will not be needed.
> 
> But maybe I am missing some cases. In any case, there is nothing
> preventing FUSE_I_CACHE_WRITES to exist along side caching mode
> if needed.

 From the description is sounds like the caching mode inode state should 
be enough for FOPEN_PARALLEL_DIRECT_WRITES/FUSE_DIRECT_IO_ALLOW_MMAP. 
I'm just not sure where the flag will be set (as above).
I guess at some point also use cases might come up that need MMAP + 
parallel DIO, at different times or different offsets. Though, before 
making the code even more complex I would first like to see a real world 
use case for that. Next part for me is to rebase the dio consolidation 
branch and to get a shared lock for O_DIRECT (without the need for 
FOPEN_DIRECT_IO).


Thanks,
Bernd

