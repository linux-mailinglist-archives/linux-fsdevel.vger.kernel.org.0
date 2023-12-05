Return-Path: <linux-fsdevel+bounces-4879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFCC80576A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 15:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7DF1C20F8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2714B5AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Ji0UidzD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JBAHU+Wt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4564119B
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 06:02:01 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 42C433200C06;
	Tue,  5 Dec 2023 09:01:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 05 Dec 2023 09:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701784916; x=1701871316; bh=Ue3Ab3ayCjKDY8fqGgpBhiT1YQjqoYDw9gu
	s3ASpHaA=; b=Ji0UidzDBrzPKD750uthByLyiiRi27pqgTmNFps3c6Mrl+urt5Q
	DNyEKJWjMvf0Kkddtxr29nj1zzm4FMseBKH6ErE6Ybp+zK0+M1AV/CL8atygHsE5
	0J2UuV4/8nbVCKpTQsQyuHQIEWs3mBLrZpGRZFZPlcp1KlfdAtML+bAHu6JBA4Qx
	X7ckpRJsPqC3GejpNyaHDea9AcNWRWKEqQyGiLQxBTvy+6I1cvbCBJMutj43h1q5
	E/NgAV7IByZ3Reyb3a0mfi5+pm3YOgtjKrt34nkOc3T5qSJJg3WO7Pk9VJlzuHM6
	QZRpSWtiro5ApTD8HMuazQK7vXaJUJDRkxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701784916; x=1701871316; bh=Ue3Ab3ayCjKDY8fqGgpBhiT1YQjqoYDw9gu
	s3ASpHaA=; b=JBAHU+Wtv6FhsujaeveL7LrXhoKZsMuSmAFDYr+WNIAJYCE8Nfs
	F4TjyQ1grjAwBUZnXfLbZCITgRA7fkudXRRVPx+VUUoT5DX8+uxSkyVv+xHNQQHY
	zUEYgBaHWimc2cyIWJvYseWTdb/uRgzhko4RMoCp+kuUvz6aAG1NsU3k6wrO4rwN
	cUoGBBKkmdvwVpxYI2z3evYWvfZ1yT3j7nI2TfXr1wPbem6Iw6fgFKZH1++/PA0z
	Mlkg3pmnEY1SSYKyQoBdc9RS6vh4wNLh2iU8FQ3afpx8XjEUnJnMoeBbf5MqHk5k
	5JzDtYakz1hlocxqfR6aKhDOSYWCDHTnL/A==
X-ME-Sender: <xms:Ui1vZbezU-3JzJSMx824_bG_fr-vkY-0Gzv10OsE_2UvASTIcx2hAw>
    <xme:Ui1vZRMLxOb1YhGcoveJ4C2I2BknzNjjw4hoyMzNkjYPKWjjgrhaZC1bDxD72c5fK
    I9mQp5x3Tft-EqE>
X-ME-Received: <xmr:Ui1vZUghUAqkIu2T7TxMZt1Aev5d7LFXz5KokF20SslbhHuRlEp44gnJmutwWRlbCoqmptvh5J-6e_PJpezVi3OGmn_IKIv4MkoGVBdt-5miPly30j2H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepuedtkeeileeghedukefghfdtuddvudfgheel
    jeejgeelueffueekheefheffveelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:Uy1vZc9HSMVUiMWLJ7lLkTrUda2TlaF6yEoG6kZoXDWp8Vx6eXVqfA>
    <xmx:Uy1vZXtRYuFzIU7WWLvarl6zaWg1XHVJgHibcTXVkcoasoYtTrDFvw>
    <xmx:Uy1vZbHPW5QjbQJrLuH4-M8OPrI5EIO3YUh6asmxsei7p9OYeBoqCg>
    <xmx:VC1vZbh0AaSxYqLn87Htnb7Wgzb4I3mCO4w_R-yRWAgwg-MKe2J8ug>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 09:01:53 -0500 (EST)
Message-ID: <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm>
Date: Tue, 5 Dec 2023 15:01:51 +0100
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
 hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>
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
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/5/23 08:00, Amir Goldstein wrote:
> On Tue, Dec 5, 2023 at 1:42 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 12/4/23 11:04, Bernd Schubert wrote:
>>>
>>>
>>> On 12/4/23 10:27, Miklos Szeredi wrote:
>>>> On Mon, 4 Dec 2023 at 07:50, Amir Goldstein <amir73il@gmail.com> wrote:
>>>>>
>>>>> On Mon, Dec 4, 2023 at 1:00 AM Bernd Schubert
>>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>>
>>>>>> Hi Amir,
>>>>>>
>>>>>> On 12/3/23 12:20, Amir Goldstein wrote:
>>>>>>> On Sat, Dec 2, 2023 at 5:06 PM Amir Goldstein <amir73il@gmail.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> On Mon, Nov 6, 2023 at 4:08 PM Bernd Schubert
>>>>>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>>>>>
>>>>>>>>> Hi Miklos,
>>>>>>>>>
>>>>>>>>> On 9/20/23 10:15, Miklos Szeredi wrote:
>>>>>>>>>> On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli
>>>>>>>>>> <tfanelli@redhat.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the
>>>>>>>>>>> purpose
>>>>>>>>>>> of allowing shared mmap of files opened/created with DIRECT_IO
>>>>>>>>>>> enabled.
>>>>>>>>>>> However, it leaves open the possibility of further relaxing the
>>>>>>>>>>> DIRECT_IO restrictions (and in-effect, the cache coherency
>>>>>>>>>>> guarantees of
>>>>>>>>>>> DIRECT_IO) in the future.
>>>>>>>>>>>
>>>>>>>>>>> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its
>>>>>>>>>>> purpose. It
>>>>>>>>>>> only serves to allow shared mmap of DIRECT_IO files, while still
>>>>>>>>>>> bypassing the cache on regular reads and writes. The shared
>>>>>>>>>>> mmap is the
>>>>>>>>>>> only loosening of the cache policy that can take place with the
>>>>>>>>>>> flag.
>>>>>>>>>>> This removes some ambiguity and introduces a more stable flag
>>>>>>>>>>> to be used
>>>>>>>>>>> in FUSE_INIT. Furthermore, we can document that to allow shared
>>>>>>>>>>> mmap'ing
>>>>>>>>>>> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
>>>>>>>>>>>
>>>>>>>>>>> Tyler Fanelli (2):
>>>>>>>>>>>       fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
>>>>>>>>>>>       docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
>>>>>>>>>>
>>>>>>>>>> Looks good.
>>>>>>>>>>
>>>>>>>>>> Applied, thanks.  Will send the PR during this merge window,
>>>>>>>>>> since the
>>>>>>>>>> rename could break stuff if already released.
>>>>>>>>>
>>>>>>>>> I'm just porting back this feature to our internal fuse module
>>>>>>>>> and it
>>>>>>>>> looks these rename patches have been forgotten?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Miklos, Bernd,
>>>>>>>>
>>>>>>>> I was looking at the DIRECT_IO_ALLOW_MMAP code and specifically at
>>>>>>>> commit b5a2a3a0b776 ("fuse: write back dirty pages before direct
>>>>>>>> write in
>>>>>>>> direct_io_relax mode") and I was wondering - isn't dirty pages
>>>>>>>> writeback
>>>>>>>> needed *before* invalidate_inode_pages2() in fuse_file_mmap() for
>>>>>>>> direct_io_allow_mmap case?
>>>>>>>>
>>>>>>>> For FUSE_PASSTHROUGH, I am going to need to call fuse_vma_close()
>>>>>>>> for munmap of files also in direct-io mode [1], so I was
>>>>>>>> considering installing
>>>>>>>> fuse_file_vm_ops for the FOPEN_DIRECT_IO case, same as caching case,
>>>>>>>> and regardless of direct_io_allow_mmap.
>>>>>>>>
>>>>>>>> I was asking myself if there was a good reason why
>>>>>>>> fuse_page_mkwrite()/
>>>>>>>> fuse_wait_on_page_writeback()/fuse_vma_close()/write_inode_now()
>>>>>>>> should NOT be called for the FOPEN_DIRECT_IO case regardless of
>>>>>>>> direct_io_allow_mmap?
>>>>>>>>
>>>>>>>
>>>>>>> Before trying to make changes to fuse_file_mmap() I tried to test
>>>>>>> DIRECT_IO_RELAX - I enabled it in libfuse and ran fstest with
>>>>>>> passthrough_hp --direct-io.
>>>>>>>
>>>>>>> The test generic/095 - "Concurrent mixed I/O (buffer I/O, aiodio,
>>>>>>> mmap, splice)
>>>>>>> on the same files" blew up hitting BUG_ON(fi->writectr < 0) in
>>>>>>> fuse_set_nowrite()
>>>>>>>
>>>>>>> I am wondering how this code was tested?
>>>>>>>
>>>>>>> I could not figure out the problem and how to fix it.
>>>>>>> Please suggest a fix and let me know which adjustments are needed
>>>>>>> if I want to use fuse_file_vm_ops for all mmap modes.
>>>>>>
>>>>>> So fuse_set_nowrite() tests for inode_is_locked(), but that also
>>>>>> succeeds for a shared lock. It gets late here (and I might miss
>>>>>> something), but I think we have an issue with
>>>>>> FOPEN_PARALLEL_DIRECT_WRITES. Assuming there would be plain O_DIRECT
>>>>>> and
>>>>>> mmap, the same issue might triggered? Hmm, well, so far plain O_DIRECT
>>>>>> does not support FOPEN_PARALLEL_DIRECT_WRITES yet - the patches for
>>>>>> that
>>>>>> are still pending.
>>>>>>
>>>>>
>>>>> Your analysis seems to be correct.
>>>>>
>>>>> Attached patch fixes the problem and should be backported to 6.6.y.
>>>>>
>>>>> Miklos,
>>>>>
>>>>> I prepared the patch on top of master and not on top of the rename to
>>>>> FUSE_DIRECT_IO_ALLOW_MMAP in for-next for ease of backport to
>>>>> 6.6.y, although if you are planning send the flag rename to v6.7 as a
>>>>> fix,
>>>>> you may prefer to apply the fix after the rename and request to backport
>>>>> the flag rename along with the fix to 6.6.y.
>>>>
>>>> I've done that.   Thanks for the fix and testing.
>>>
>>> Hi Amir, hi Miklos,
>>>
>>> could you please hold on a bit before sending the patch upstream?
>>> I think we can just test for fuse_range_is_writeback in
>>> fuse_direct_write_iter. I will have a patch in a few minutes.
>>
>> Hmm, that actually doesn't work as we would need to hold the inode lock
>> in page write functions.
>> Then tried to do it per inode and only when the inode gets cached writes
>> or mmap - this triggers a lockdep lock order warning, because
>> fuse_file_mmap is called with mm->mmap_lock and would take the inode
>> lock. But through
>> fuse_direct_io/iov_iter_get_pages2/__iov_iter_get_pages_alloc these
>> locks are taken the other way around.
>> So right now I don't see a way out - we need to go with Amirs patch first.
>>
>>
> 
> Is it actually important for FUSE_DIRECT_IO_ALLOW_MMAP fs
> (e.g. virtiofsd) to support FOPEN_PARALLEL_DIRECT_WRITES?
> I guess not otherwise, the combination would have been tested.

I'm not sure how many people are aware of these different flags/features.
I had just finalized the backport of the related patches to RHEL8 on 
Friday, as we (or our customers) need both for different jobs.

> 
> FOPEN_PARALLEL_DIRECT_WRITES is typically important for
> network fs and FUSE_DIRECT_IO_ALLOW_MMAP is typically not
> for network fs. Right?

We kind of have these use cases for our network file systems

FOPEN_PARALLEL_DIRECT_WRITES:
    - Traditional HPC, large files, parallel IO
    - Large file used on local node as container for many small files

FUSE_DIRECT_IO_ALLOW_MMAP:
    - compilation through gcc (not so important, just not nice when it 
does not work)
    - rather recent: python libraries using mmap _reads_. As it is read 
only no issue of consistency.


These jobs do not intermix - no issue as in generic/095. If such 
applications really exist, I have no issue with a serialization penalty. 
Just disabling FOPEN_PARALLEL_DIRECT_WRITES because other 
nodes/applications need FUSE_DIRECT_IO_ALLOW_MMAP is not so nice.

Final goal is also to have FOPEN_PARALLEL_DIRECT_WRITES to work on plain 
O_DIRECT and not only for FUSE_DIRECT_IO - I need to update this branch 
and post the next version
https://github.com/bsbernd/linux/commits/fuse-dio-v4


In the mean time I have another idea how to solve 
FOPEN_PARALLEL_DIRECT_WRITES + FUSE_DIRECT_IO_ALLOW_MMAP

> 
> FWIW, with FUSE_PASSTHROUGH, I plan that a shared mmap of an inode
> in "passthrough mode" (i.e. has an open FOPEN_PASSTHROUGH file) will
> be allowed (maps the backing file) regardless of fc->direct_io_allow_mmap.
> FOPEN_PARALLEL_DIRECT_WRITES will also be allowed on an inode in
> "passthrough mode", because an inode in "passthrough mode" cannot have
> any pending page cache writes.
> 
> This makes me realize that I will also need to handle passthrough of
> ->direct_IO() on an FOPEN_PASSTHROUGH file.

I really need to take a few hours to look at your patches.


Thanks,
Bernd

