Return-Path: <linux-fsdevel+bounces-4815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8711804372
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 01:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B54B20A9B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 00:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B59808
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="fxLyiQAI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mVu6sQL4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D14FA
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 15:42:55 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2099B5C0140;
	Mon,  4 Dec 2023 18:42:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 18:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701733372; x=1701819772; bh=ETAT0Y4MDDbfQ0ayNEcrvBPQi8GcSAsSLam
	g1uecaIo=; b=fxLyiQAIJpmuhzHK20B5n2KpXEResVYO7TkXxi4JVfIw5S12fiT
	5d2PEcai1ESq/s4JljVFYFd011zTD19R5WbPvw4Icb2w90rJ8VZHTN/x3ceF52a/
	Rq7mIDeB4h9bkbLxV4yACQFfFOAcPJTvjMCOFqh3BmM4u0Icops0cEY8iby5Vgn1
	zEMGTljJmdPyvTvjQnnacWqodIeuuDYQOFZasBjDNKyphfmZFD/wH8xBl827U6Jv
	fhNAemh75QlVAcx8fJu2lxBXzSRhgOnmGk3z/XG/kwhgTvsbeC/qBPLx8yAat74d
	gL8e2kogPeVHze4/av5LFOzdcsyWN8Y7JSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701733372; x=1701819772; bh=ETAT0Y4MDDbfQ0ayNEcrvBPQi8GcSAsSLam
	g1uecaIo=; b=mVu6sQL4MlL1kvRn9xhuUkUuXtjjJ9PoszMLT5D0vwgN96fFSV5
	tnnahShKKXt0oJ+unQZVSKjbM99y+OA0jV9NTmpN8W17ZVMh2txQSZy/8nQW86x4
	uKBVsLPkUarn/IihDuC4kwADg4fFPisPRV/CaoKy19fDMCSz9Iq6689Am3xTxwKZ
	y7F41BXnPL8dSrh+Avrqbr/AzsGCHOMgUUG3kT+JAwxL5/AVXYPdUlnXNytM1Usi
	YoJ3lxqUemL7fJYFj4DEDYefLJJiK48PDjqhbAPSxeTi6who9Mh47pXYK3QKSaM5
	kfu2OO6zNT5s7jtGNUok8Q1lMpvYxkV44ig==
X-ME-Sender: <xms:-2NuZeRA5MQ9e4BgeAp5lrazucZ9mGC_Ist1_TSwCrp_tu0ABHJ1ZA>
    <xme:-2NuZTyVork8nfvivD3xX7d6eDrGoV3KmAps_BYqwN93m7WCnXV-13-7hcvAZa_dN
    HNZpJx4irXAuqh4>
X-ME-Received: <xmr:-2NuZb3K_a4cQ3IeHGVmT3A8Li6CsMCnvXlfltEVme48pYjx6fvr4n12pl0NyHRgJ6BbxUJVjoJLeBIe8kKHtq2y42QeVxdKK7T-ZK7oMB19JCFoTFnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejjedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepueeuhfetieetieefueffuedvudfhfeduhefh
    heeftefggefhkedvfeelieevgeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:-2NuZaCMVJeEVBzLHFmDiNujtuBppGfqeRIo4ROnPxiHUJb_ECngNg>
    <xmx:-2NuZXhkGwWnSGxn8tj06_BZHrEHrqfxre1Ty-t1JoDHIprNqjwzHQ>
    <xmx:-2NuZWozdPgAFsKgO470Z2N07p0rDR1RtdQZnTMlTs76xeXhcL3Xcg>
    <xmx:_GNuZSWnM1mNNLb-5OLj9t4DD-svQBmPyYkXkhOmqeUde-9HCJ_uVQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 18:42:50 -0500 (EST)
Message-ID: <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
Date: Tue, 5 Dec 2023 00:42:48 +0100
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
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Tyler Fanelli <tfanelli@redhat.com>, linux-fsdevel@vger.kernel.org,
 mszeredi@redhat.com, gmaglione@redhat.com, hreitz@redhat.com,
 Hao Xu <howeyxu@tencent.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm>
 <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
 <CAOQ4uxh6RpoyZ051fQLKNHnXfypoGsPO9szU0cR6Va+NR_JELw@mail.gmail.com>
 <49fdbcd1-5442-4cd4-8a85-1ddb40291b7d@fastmail.fm>
 <CAOQ4uxjfU0X9Q4bUoQd_U56y4yUUKGaqyFS1EJ3FGAPrmBMSkg@mail.gmail.com>
 <CAJfpeguuB21HNeiK-2o_5cbGUWBh4uu0AmexREuhEH8JgqDAaQ@mail.gmail.com>
 <abbdf30f-c459-4eab-9254-7b24afc5771b@fastmail.fm>
In-Reply-To: <abbdf30f-c459-4eab-9254-7b24afc5771b@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/4/23 11:04, Bernd Schubert wrote:
> 
> 
> On 12/4/23 10:27, Miklos Szeredi wrote:
>> On Mon, 4 Dec 2023 at 07:50, Amir Goldstein <amir73il@gmail.com> wrote:
>>>
>>> On Mon, Dec 4, 2023 at 1:00 AM Bernd Schubert
>>> <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> Hi Amir,
>>>>
>>>> On 12/3/23 12:20, Amir Goldstein wrote:
>>>>> On Sat, Dec 2, 2023 at 5:06 PM Amir Goldstein <amir73il@gmail.com> 
>>>>> wrote:
>>>>>>
>>>>>> On Mon, Nov 6, 2023 at 4:08 PM Bernd Schubert
>>>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>>>
>>>>>>> Hi Miklos,
>>>>>>>
>>>>>>> On 9/20/23 10:15, Miklos Szeredi wrote:
>>>>>>>> On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli 
>>>>>>>> <tfanelli@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the 
>>>>>>>>> purpose
>>>>>>>>> of allowing shared mmap of files opened/created with DIRECT_IO 
>>>>>>>>> enabled.
>>>>>>>>> However, it leaves open the possibility of further relaxing the
>>>>>>>>> DIRECT_IO restrictions (and in-effect, the cache coherency 
>>>>>>>>> guarantees of
>>>>>>>>> DIRECT_IO) in the future.
>>>>>>>>>
>>>>>>>>> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its 
>>>>>>>>> purpose. It
>>>>>>>>> only serves to allow shared mmap of DIRECT_IO files, while still
>>>>>>>>> bypassing the cache on regular reads and writes. The shared 
>>>>>>>>> mmap is the
>>>>>>>>> only loosening of the cache policy that can take place with the 
>>>>>>>>> flag.
>>>>>>>>> This removes some ambiguity and introduces a more stable flag 
>>>>>>>>> to be used
>>>>>>>>> in FUSE_INIT. Furthermore, we can document that to allow shared 
>>>>>>>>> mmap'ing
>>>>>>>>> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
>>>>>>>>>
>>>>>>>>> Tyler Fanelli (2):
>>>>>>>>>      fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
>>>>>>>>>      docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
>>>>>>>>
>>>>>>>> Looks good.
>>>>>>>>
>>>>>>>> Applied, thanks.  Will send the PR during this merge window, 
>>>>>>>> since the
>>>>>>>> rename could break stuff if already released.
>>>>>>>
>>>>>>> I'm just porting back this feature to our internal fuse module 
>>>>>>> and it
>>>>>>> looks these rename patches have been forgotten?
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Hi Miklos, Bernd,
>>>>>>
>>>>>> I was looking at the DIRECT_IO_ALLOW_MMAP code and specifically at
>>>>>> commit b5a2a3a0b776 ("fuse: write back dirty pages before direct 
>>>>>> write in
>>>>>> direct_io_relax mode") and I was wondering - isn't dirty pages 
>>>>>> writeback
>>>>>> needed *before* invalidate_inode_pages2() in fuse_file_mmap() for
>>>>>> direct_io_allow_mmap case?
>>>>>>
>>>>>> For FUSE_PASSTHROUGH, I am going to need to call fuse_vma_close()
>>>>>> for munmap of files also in direct-io mode [1], so I was 
>>>>>> considering installing
>>>>>> fuse_file_vm_ops for the FOPEN_DIRECT_IO case, same as caching case,
>>>>>> and regardless of direct_io_allow_mmap.
>>>>>>
>>>>>> I was asking myself if there was a good reason why 
>>>>>> fuse_page_mkwrite()/
>>>>>> fuse_wait_on_page_writeback()/fuse_vma_close()/write_inode_now()
>>>>>> should NOT be called for the FOPEN_DIRECT_IO case regardless of
>>>>>> direct_io_allow_mmap?
>>>>>>
>>>>>
>>>>> Before trying to make changes to fuse_file_mmap() I tried to test
>>>>> DIRECT_IO_RELAX - I enabled it in libfuse and ran fstest with
>>>>> passthrough_hp --direct-io.
>>>>>
>>>>> The test generic/095 - "Concurrent mixed I/O (buffer I/O, aiodio, 
>>>>> mmap, splice)
>>>>> on the same files" blew up hitting BUG_ON(fi->writectr < 0) in
>>>>> fuse_set_nowrite()
>>>>>
>>>>> I am wondering how this code was tested?
>>>>>
>>>>> I could not figure out the problem and how to fix it.
>>>>> Please suggest a fix and let me know which adjustments are needed
>>>>> if I want to use fuse_file_vm_ops for all mmap modes.
>>>>
>>>> So fuse_set_nowrite() tests for inode_is_locked(), but that also
>>>> succeeds for a shared lock. It gets late here (and I might miss
>>>> something), but I think we have an issue with
>>>> FOPEN_PARALLEL_DIRECT_WRITES. Assuming there would be plain O_DIRECT 
>>>> and
>>>> mmap, the same issue might triggered? Hmm, well, so far plain O_DIRECT
>>>> does not support FOPEN_PARALLEL_DIRECT_WRITES yet - the patches for 
>>>> that
>>>> are still pending.
>>>>
>>>
>>> Your analysis seems to be correct.
>>>
>>> Attached patch fixes the problem and should be backported to 6.6.y.
>>>
>>> Miklos,
>>>
>>> I prepared the patch on top of master and not on top of the rename to
>>> FUSE_DIRECT_IO_ALLOW_MMAP in for-next for ease of backport to
>>> 6.6.y, although if you are planning send the flag rename to v6.7 as a 
>>> fix,
>>> you may prefer to apply the fix after the rename and request to backport
>>> the flag rename along with the fix to 6.6.y.
>>
>> I've done that.   Thanks for the fix and testing.
> 
> Hi Amir, hi Miklos,
> 
> could you please hold on a bit before sending the patch upstream?
> I think we can just test for fuse_range_is_writeback in 
> fuse_direct_write_iter. I will have a patch in a few minutes.

Hmm, that actually doesn't work as we would need to hold the inode lock 
in page write functions.
Then tried to do it per inode and only when the inode gets cached writes 
or mmap - this triggers a lockdep lock order warning, because 
fuse_file_mmap is called with mm->mmap_lock and would take the inode 
lock. But through 
fuse_direct_io/iov_iter_get_pages2/__iov_iter_get_pages_alloc these 
locks are taken the other way around.
So right now I don't see a way out - we need to go with Amirs patch first.


Thanks,
Bernd

