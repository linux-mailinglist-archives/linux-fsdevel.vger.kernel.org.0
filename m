Return-Path: <linux-fsdevel+bounces-4915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A2806387
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 01:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603AE1C20366
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3669CA6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="uq0qVrBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C6Qn0OUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D49318F
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 15:56:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id B6E823200ADB;
	Tue,  5 Dec 2023 18:56:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 05 Dec 2023 18:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701820612; x=1701907012; bh=gh
	tkIMaDZaHCN9QSJ6jIoswuBrNryCyvkYooc8K3F2I=; b=uq0qVrBMldzNv60llx
	Tdwll1iRnD2Rf+4u3FVJf16sqDv7DxGOSzVbdZjDk3Km+q6EvM/ULnHJeUdo48Vz
	1j7fzcrZf9f1K2X2iUDTuDImMwZ5M22RICPKnXmOFFtLATdFM+L+wNV29ccFsaz+
	Ckih7u9FlSrzNo2y/J335csx+uDiE5GaXBDVohKYrwQdQNchHvtCyZ8F/T+ClDJG
	y9DY4fji/R5gnTrx+8fAc2Xn5J9KHzezfYwihCg0JzpZze0xjQ12pYuZlry1H1iW
	GhGqZNkYHJQ1Eu9yLBqv0Iuf583bmYBmD+tShHm3KqVc83Iu0RVDzgJ0waNfh5wF
	MKEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701820612; x=1701907012; bh=ghtkIMaDZaHCN
	9QSJ6jIoswuBrNryCyvkYooc8K3F2I=; b=C6Qn0OUnApFsanFJllAZrXPUWsRoI
	f0Ku19wAQNVkDlA9PqmHzHE91bOAnXJaY/d4RUHX6pjE7gPE+ScGZLhWElUkQem7
	Xm3lmXXdfM6JKF21eHZm5EAunhmfKt3thEhUB0cpxav544rt4JrpQxHxj6vDAm+s
	EXCHTmbVv6Vu2kyhKN0uORQMgbvtFGfLjxcBqavBnUzIB1wlIOx1Ia0pmxgPx/Ss
	XlUtcMZpinW2GQfXR6FXouP0XJWoUmh17JTu5CBr+RNXglCcpilperKeRaL8QnDy
	qYTOr7Zm9WP95T5WdSumLZo32jzA6BdqLdCmS3JsHMIaFG2BW44G9hFhQ==
X-ME-Sender: <xms:w7hvZVzo9zc8bNcBNKTQt_tT5DVHs86bH62V2AB6hWl_bdkMD79V_g>
    <xme:w7hvZVSzFtRE5emAbChiVaWiQ3teUZxrPrxg5oddp7yO0IHYjZnKr7wBtOFJ6HGwt
    nNikP2QnkMB84WZ>
X-ME-Received: <xmr:w7hvZfUqmNNsslSdmqVrJdMS73MGM9I0lrwu1xhnKIBD0gNyO6a2rUae382oLiMa0UOIFeXSNBkRYkCc9ncz9u9g45gOqNlJZQb9uosuZk1UihGsx-Mm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptgfkffggfgfuhffvvehfjgesmhdtreertddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpefgfeeuteeihfeiledvtdevieeuhfefteekteeg
    feejheeljefhieehteetffdtfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:w7hvZXjUISPOtNoSUlZoxHuN7xWJkWXJyGZCrgIpcqVepOEtoOH9dQ>
    <xmx:w7hvZXALL4VNsEk8BAk4GxONnk4hSZG8W7q5tSvIij8l_Gd4sy7_kQ>
    <xmx:w7hvZQIbdSUGNIeCbMicKCSgerxyQuRkVIbGL4KeZFgcU7krM3YoTw>
    <xmx:xLhvZZC6o7u_keEuWDeNEfrBxYdzd1bFMPAErOXzVtxofmF3kXRr8g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 18:56:50 -0500 (EST)
Content-Type: multipart/mixed; boundary="------------20H4CKtj5xkpbQ0MJ0Mcjrda"
Message-ID: <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
Date: Wed, 6 Dec 2023 00:56:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
From: Bernd Schubert <bernd.schubert@fastmail.fm>
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
Content-Language: en-US, de-DE
In-Reply-To: <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm>

This is a multi-part message in MIME format.
--------------20H4CKtj5xkpbQ0MJ0Mcjrda
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/5/23 15:01, Bernd Schubert wrote:
> 
> 
> On 12/5/23 08:00, Amir Goldstein wrote:
>> On Tue, Dec 5, 2023 at 1:42 AM Bernd Schubert
>> <bernd.schubert@fastmail.fm> wrote:
>>>
>>>
>>>
>>> On 12/4/23 11:04, Bernd Schubert wrote:
>>>>
>>>>
>>>> On 12/4/23 10:27, Miklos Szeredi wrote:
>>>>> On Mon, 4 Dec 2023 at 07:50, Amir Goldstein <amir73il@gmail.com> 
>>>>> wrote:
>>>>>>
>>>>>> On Mon, Dec 4, 2023 at 1:00 AM Bernd Schubert
>>>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>>>
>>>>>>> Hi Amir,
>>>>>>>
>>>>>>> On 12/3/23 12:20, Amir Goldstein wrote:
>>>>>>>> On Sat, Dec 2, 2023 at 5:06 PM Amir Goldstein <amir73il@gmail.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On Mon, Nov 6, 2023 at 4:08 PM Bernd Schubert
>>>>>>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Miklos,
>>>>>>>>>>
>>>>>>>>>> On 9/20/23 10:15, Miklos Szeredi wrote:
>>>>>>>>>>> On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli
>>>>>>>>>>> <tfanelli@redhat.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the
>>>>>>>>>>>> purpose
>>>>>>>>>>>> of allowing shared mmap of files opened/created with DIRECT_IO
>>>>>>>>>>>> enabled.
>>>>>>>>>>>> However, it leaves open the possibility of further relaxing the
>>>>>>>>>>>> DIRECT_IO restrictions (and in-effect, the cache coherency
>>>>>>>>>>>> guarantees of
>>>>>>>>>>>> DIRECT_IO) in the future.
>>>>>>>>>>>>
>>>>>>>>>>>> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its
>>>>>>>>>>>> purpose. It
>>>>>>>>>>>> only serves to allow shared mmap of DIRECT_IO files, while 
>>>>>>>>>>>> still
>>>>>>>>>>>> bypassing the cache on regular reads and writes. The shared
>>>>>>>>>>>> mmap is the
>>>>>>>>>>>> only loosening of the cache policy that can take place with the
>>>>>>>>>>>> flag.
>>>>>>>>>>>> This removes some ambiguity and introduces a more stable flag
>>>>>>>>>>>> to be used
>>>>>>>>>>>> in FUSE_INIT. Furthermore, we can document that to allow shared
>>>>>>>>>>>> mmap'ing
>>>>>>>>>>>> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
>>>>>>>>>>>>
>>>>>>>>>>>> Tyler Fanelli (2):
>>>>>>>>>>>>       fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
>>>>>>>>>>>>       docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
>>>>>>>>>>>
>>>>>>>>>>> Looks good.
>>>>>>>>>>>
>>>>>>>>>>> Applied, thanks.  Will send the PR during this merge window,
>>>>>>>>>>> since the
>>>>>>>>>>> rename could break stuff if already released.
>>>>>>>>>>
>>>>>>>>>> I'm just porting back this feature to our internal fuse module
>>>>>>>>>> and it
>>>>>>>>>> looks these rename patches have been forgotten?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Miklos, Bernd,
>>>>>>>>>
>>>>>>>>> I was looking at the DIRECT_IO_ALLOW_MMAP code and specifically at
>>>>>>>>> commit b5a2a3a0b776 ("fuse: write back dirty pages before direct
>>>>>>>>> write in
>>>>>>>>> direct_io_relax mode") and I was wondering - isn't dirty pages
>>>>>>>>> writeback
>>>>>>>>> needed *before* invalidate_inode_pages2() in fuse_file_mmap() for
>>>>>>>>> direct_io_allow_mmap case?
>>>>>>>>>
>>>>>>>>> For FUSE_PASSTHROUGH, I am going to need to call fuse_vma_close()
>>>>>>>>> for munmap of files also in direct-io mode [1], so I was
>>>>>>>>> considering installing
>>>>>>>>> fuse_file_vm_ops for the FOPEN_DIRECT_IO case, same as caching 
>>>>>>>>> case,
>>>>>>>>> and regardless of direct_io_allow_mmap.
>>>>>>>>>
>>>>>>>>> I was asking myself if there was a good reason why
>>>>>>>>> fuse_page_mkwrite()/
>>>>>>>>> fuse_wait_on_page_writeback()/fuse_vma_close()/write_inode_now()
>>>>>>>>> should NOT be called for the FOPEN_DIRECT_IO case regardless of
>>>>>>>>> direct_io_allow_mmap?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Before trying to make changes to fuse_file_mmap() I tried to test
>>>>>>>> DIRECT_IO_RELAX - I enabled it in libfuse and ran fstest with
>>>>>>>> passthrough_hp --direct-io.
>>>>>>>>
>>>>>>>> The test generic/095 - "Concurrent mixed I/O (buffer I/O, aiodio,
>>>>>>>> mmap, splice)
>>>>>>>> on the same files" blew up hitting BUG_ON(fi->writectr < 0) in
>>>>>>>> fuse_set_nowrite()
>>>>>>>>
>>>>>>>> I am wondering how this code was tested?
>>>>>>>>
>>>>>>>> I could not figure out the problem and how to fix it.
>>>>>>>> Please suggest a fix and let me know which adjustments are needed
>>>>>>>> if I want to use fuse_file_vm_ops for all mmap modes.
>>>>>>>
>>>>>>> So fuse_set_nowrite() tests for inode_is_locked(), but that also
>>>>>>> succeeds for a shared lock. It gets late here (and I might miss
>>>>>>> something), but I think we have an issue with
>>>>>>> FOPEN_PARALLEL_DIRECT_WRITES. Assuming there would be plain O_DIRECT
>>>>>>> and
>>>>>>> mmap, the same issue might triggered? Hmm, well, so far plain 
>>>>>>> O_DIRECT
>>>>>>> does not support FOPEN_PARALLEL_DIRECT_WRITES yet - the patches for
>>>>>>> that
>>>>>>> are still pending.
>>>>>>>
>>>>>>
>>>>>> Your analysis seems to be correct.
>>>>>>
>>>>>> Attached patch fixes the problem and should be backported to 6.6.y.
>>>>>>
>>>>>> Miklos,
>>>>>>
>>>>>> I prepared the patch on top of master and not on top of the rename to
>>>>>> FUSE_DIRECT_IO_ALLOW_MMAP in for-next for ease of backport to
>>>>>> 6.6.y, although if you are planning send the flag rename to v6.7 as a
>>>>>> fix,
>>>>>> you may prefer to apply the fix after the rename and request to 
>>>>>> backport
>>>>>> the flag rename along with the fix to 6.6.y.
>>>>>
>>>>> I've done that.   Thanks for the fix and testing.
>>>>
>>>> Hi Amir, hi Miklos,
>>>>
>>>> could you please hold on a bit before sending the patch upstream?
>>>> I think we can just test for fuse_range_is_writeback in
>>>> fuse_direct_write_iter. I will have a patch in a few minutes.
>>>
>>> Hmm, that actually doesn't work as we would need to hold the inode lock
>>> in page write functions.
>>> Then tried to do it per inode and only when the inode gets cached writes
>>> or mmap - this triggers a lockdep lock order warning, because
>>> fuse_file_mmap is called with mm->mmap_lock and would take the inode
>>> lock. But through
>>> fuse_direct_io/iov_iter_get_pages2/__iov_iter_get_pages_alloc these
>>> locks are taken the other way around.
>>> So right now I don't see a way out - we need to go with Amirs patch 
>>> first.
>>>
>>>
>>
>> Is it actually important for FUSE_DIRECT_IO_ALLOW_MMAP fs
>> (e.g. virtiofsd) to support FOPEN_PARALLEL_DIRECT_WRITES?
>> I guess not otherwise, the combination would have been tested.
> 
> I'm not sure how many people are aware of these different flags/features.
> I had just finalized the backport of the related patches to RHEL8 on 
> Friday, as we (or our customers) need both for different jobs.
> 
>>
>> FOPEN_PARALLEL_DIRECT_WRITES is typically important for
>> network fs and FUSE_DIRECT_IO_ALLOW_MMAP is typically not
>> for network fs. Right?
> 
> We kind of have these use cases for our network file systems
> 
> FOPEN_PARALLEL_DIRECT_WRITES:
>     - Traditional HPC, large files, parallel IO
>     - Large file used on local node as container for many small files
> 
> FUSE_DIRECT_IO_ALLOW_MMAP:
>     - compilation through gcc (not so important, just not nice when it 
> does not work)
>     - rather recent: python libraries using mmap _reads_. As it is read 
> only no issue of consistency.
> 
> 
> These jobs do not intermix - no issue as in generic/095. If such 
> applications really exist, I have no issue with a serialization penalty. 
> Just disabling FOPEN_PARALLEL_DIRECT_WRITES because other 
> nodes/applications need FUSE_DIRECT_IO_ALLOW_MMAP is not so nice.
> 
> Final goal is also to have FOPEN_PARALLEL_DIRECT_WRITES to work on plain 
> O_DIRECT and not only for FUSE_DIRECT_IO - I need to update this branch 
> and post the next version
> https://github.com/bsbernd/linux/commits/fuse-dio-v4
> 
> 
> In the mean time I have another idea how to solve 
> FOPEN_PARALLEL_DIRECT_WRITES + FUSE_DIRECT_IO_ALLOW_MMAP

Please find attached what I had in my mind. With that generic/095 is not 
crashing for me anymore. I just finished the initial coding - it still 
needs a bit cleanup and maybe a few comments.


Thanks,
Bernd

--------------20H4CKtj5xkpbQ0MJ0Mcjrda
Content-Type: text/x-patch; charset=UTF-8; name="01-helper-function.patch"
Content-Disposition: attachment; filename="01-helper-function.patch"
Content-Transfer-Encoding: base64

ZnVzZTogQ3JlYXRlIGhlbHBlciBmdW5jdGlvbiBpZiBESU8gd3JpdGUgbmVlZHMgZXhjbHVz
aXZlIGxvY2sKCkZyb206IEJlcm5kIFNjaHViZXJ0IDxic2NodWJlcnRAZGRuLmNvbT4KClRo
aXMgaXMganVzdCBhIHByZXBhcmF0aW9uIGZvciBmb2xsb3cgdXAgcGF0Y2hlcy4KCkNjOiBI
YW8gWHUgPGhvd2V5eHVAdGVuY2VudC5jb20+CkNjOiBNaWtsb3MgU3plcmVkaSA8bWlrbG9z
QHN6ZXJlZGkuaHU+CkNjOiBEaGFybWVuZHJhIFNpbmdoIDxkc2luZ2hAZGRuLmNvbT4KQ2M6
IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJl
cm5kIFNjaHViZXJ0IDxic2NodWJlcnRAZGRuLmNvbT4KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcKUHJlcGFyYXRpb24gZm9yIEZpeGVzOiAxNTM1MjQwNTNiYmIgKCJmdXNlOiBhbGxv
dyBub24tZXh0ZW5kaW5nIHBhcmFsbGVsIGRpcmVjdCB3cml0ZXMgb24gdGhlIHNhbWUgZmls
ZSIpCi0tLQogZnMvZnVzZS9maWxlLmMgfCAgIDUzICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzYgaW5z
ZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9maWxl
LmMgYi9mcy9mdXNlL2ZpbGUuYwppbmRleCAxY2RiNjMyNzUxMWUuLjYwZDRlMWU1MDg0MyAx
MDA2NDQKLS0tIGEvZnMvZnVzZS9maWxlLmMKKysrIGIvZnMvZnVzZS9maWxlLmMKQEAgLTEy
OTgsNiArMTI5OCwzOCBAQCBzdGF0aWMgc3NpemVfdCBmdXNlX3BlcmZvcm1fd3JpdGUoc3Ry
dWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmlpKQogCXJldHVybiByZXM7CiB9
CiAKK3N0YXRpYyBib29sIGZ1c2VfaW9fcGFzdF9lb2Yoc3RydWN0IGtpb2NiICppb2NiLCBz
dHJ1Y3QgaW92X2l0ZXIgKml0ZXIpCit7CisJc3RydWN0IGlub2RlICppbm9kZSA9IGZpbGVf
aW5vZGUoaW9jYi0+a2lfZmlscCk7CisKKwlyZXR1cm4gaW9jYi0+a2lfcG9zICsgaW92X2l0
ZXJfY291bnQoaXRlcikgPiBpX3NpemVfcmVhZChpbm9kZSk7Cit9CisKKy8qCisgKiBAcmV0
dXJuIHRydWUgaWYgYW4gZXhjbHVzaXZlIGxvY2sgZm9yIGRpcmVjdCBJTyB3cml0ZXMgaXMg
bmVlZGVkCisgKi8KK3N0YXRpYyBib29sIGZ1c2VfZGlvX3dyX2V4Y2x1c2l2ZV9sb2NrKHN0
cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQoreworCXN0cnVjdCBm
aWxlICpmaWxlID0gaW9jYi0+a2lfZmlscDsKKwlzdHJ1Y3QgZnVzZV9maWxlICpmZiA9IGZp
bGUtPnByaXZhdGVfZGF0YTsKKworCS8qIHNlcnZlciBzaWRlIGhhcyB0byBhZHZpc2UgdGhh
dCBpdCBzdXBwb3J0cyBwYXJhbGxlbCBkaW8gd3JpdGVzICovCisJaWYgKCEoZmYtPm9wZW5f
ZmxhZ3MgJiBGT1BFTl9QQVJBTExFTF9ESVJFQ1RfV1JJVEVTKSkKKwkJcmV0dXJuIHRydWU7
CisKKwkvKiBhcHBlbmQgd2lsbCBuZWVkIHRvIGtub3cgdGhlIGV2ZW50dWFsIGVvZiAtIGFs
d2F5cyBuZWVkcyBhbgorCSAqIGV4Y2x1c2l2ZSBsb2NrCisJICovCisJaWYgKGlvY2ItPmtp
X2ZsYWdzICYgSU9DQl9BUFBFTkQpCisJCXJldHVybiB0cnVlOworCisJLyogcGFyYWxsZWwg
ZGlvIGJleW9uZCBlb2YgaXMgYXQgbGVhc3QgZm9yIG5vdyBub3Qgc3VwcG9ydGVkICovCisJ
aWYgKGZ1c2VfaW9fcGFzdF9lb2YoaW9jYiwgZnJvbSkpCisJCXJldHVybiB0cnVlOworCisJ
cmV0dXJuIGZhbHNlOworfQorCiBzdGF0aWMgc3NpemVfdCBmdXNlX2NhY2hlX3dyaXRlX2l0
ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20pCiB7CiAJc3Ry
dWN0IGZpbGUgKmZpbGUgPSBpb2NiLT5raV9maWxwOwpAQCAtMTU1NywyNSArMTU4OSwxMiBA
QCBzdGF0aWMgc3NpemVfdCBmdXNlX2RpcmVjdF9yZWFkX2l0ZXIoc3RydWN0IGtpb2NiICpp
b2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKnRvKQogCXJldHVybiByZXM7CiB9CiAKLXN0YXRpYyBi
b29sIGZ1c2VfZGlyZWN0X3dyaXRlX2V4dGVuZGluZ19pX3NpemUoc3RydWN0IGtpb2NiICpp
b2NiLAotCQkJCQkgICAgICAgc3RydWN0IGlvdl9pdGVyICppdGVyKQotewotCXN0cnVjdCBp
bm9kZSAqaW5vZGUgPSBmaWxlX2lub2RlKGlvY2ItPmtpX2ZpbHApOwotCi0JcmV0dXJuIGlv
Y2ItPmtpX3BvcyArIGlvdl9pdGVyX2NvdW50KGl0ZXIpID4gaV9zaXplX3JlYWQoaW5vZGUp
OwotfQotCiBzdGF0aWMgc3NpemVfdCBmdXNlX2RpcmVjdF93cml0ZV9pdGVyKHN0cnVjdCBr
aW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQogewogCXN0cnVjdCBpbm9kZSAq
aW5vZGUgPSBmaWxlX2lub2RlKGlvY2ItPmtpX2ZpbHApOwotCXN0cnVjdCBmaWxlICpmaWxl
ID0gaW9jYi0+a2lfZmlscDsKLQlzdHJ1Y3QgZnVzZV9maWxlICpmZiA9IGZpbGUtPnByaXZh
dGVfZGF0YTsKIAlzdHJ1Y3QgZnVzZV9pb19wcml2IGlvID0gRlVTRV9JT19QUklWX1NZTkMo
aW9jYik7CiAJc3NpemVfdCByZXM7Ci0JYm9vbCBleGNsdXNpdmVfbG9jayA9Ci0JCSEoZmYt
Pm9wZW5fZmxhZ3MgJiBGT1BFTl9QQVJBTExFTF9ESVJFQ1RfV1JJVEVTKSB8fAotCQlpb2Ni
LT5raV9mbGFncyAmIElPQ0JfQVBQRU5EIHx8Ci0JCWZ1c2VfZGlyZWN0X3dyaXRlX2V4dGVu
ZGluZ19pX3NpemUoaW9jYiwgZnJvbSk7CisJYm9vbCBleGNsdXNpdmVfbG9jayA9IGZ1c2Vf
ZGlvX3dyX2V4Y2x1c2l2ZV9sb2NrKGlvY2IsIGZyb20pOwogCiAJLyoKIAkgKiBUYWtlIGV4
Y2x1c2l2ZSBsb2NrIGlmCkBAIC0xNTg4LDEwICsxNjA3LDEwIEBAIHN0YXRpYyBzc2l6ZV90
IGZ1c2VfZGlyZWN0X3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92
X2l0ZXIgKmZyb20pCiAJZWxzZSB7CiAJCWlub2RlX2xvY2tfc2hhcmVkKGlub2RlKTsKIAot
CQkvKiBBIHJhY2Ugd2l0aCB0cnVuY2F0ZSBtaWdodCBoYXZlIGNvbWUgdXAgYXMgdGhlIGRl
Y2lzaW9uIGZvcgotCQkgKiB0aGUgbG9jayB0eXBlIHdhcyBkb25lIHdpdGhvdXQgaG9sZGlu
ZyB0aGUgbG9jaywgY2hlY2sgYWdhaW4uCisJCS8qCisJCSAqIFByZXZpb3VzIGNoZWNrIHdh
cyB3aXRob3V0IGFueSBsb2NrIGFuZCBtaWdodCBoYXZlIHJhY2VkLgogCQkgKi8KLQkJaWYg
KGZ1c2VfZGlyZWN0X3dyaXRlX2V4dGVuZGluZ19pX3NpemUoaW9jYiwgZnJvbSkpIHsKKwkJ
aWYgKGZ1c2VfZGlvX3dyX2V4Y2x1c2l2ZV9sb2NrKGlvY2IsIGZyb20pKSB7CiAJCQlpbm9k
ZV91bmxvY2tfc2hhcmVkKGlub2RlKTsKIAkJCWlub2RlX2xvY2soaW5vZGUpOwogCQkJZXhj
bHVzaXZlX2xvY2sgPSB0cnVlOwo=
--------------20H4CKtj5xkpbQ0MJ0Mcjrda
Content-Type: text/x-patch; charset=UTF-8;
 name="02-fix-dio-write-shared-lock.patch"
Content-Disposition: attachment; filename="02-fix-dio-write-shared-lock.patch"
Content-Transfer-Encoding: base64

ZnVzZTogVGVzdCBmb3IgcGFnZSBjYWNoZSB3cml0ZXMgaW4gdGhlIHNoYXJlZCBsb2NrIERJ
TyBkZWNpc2lvbgoKRnJvbTogQmVybmQgU2NodWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPgoK
eGZzdGVzdCBnZW5lcmljLzA5NSB0cmlnZ2VycyBCVUdfT04oZmktPndyaXRlY3RyIDwgMCkg
aW4KZnVzZV9zZXRfbm93cml0ZSgpLgpUaGlzIGhhcHBlbnMgd2l0aCBhIHNoYXJlZCBsb2Nr
IGZvciBGT1BFTl9ESVJFQ1RfSU8gYW5kIHdoZW4gaW4gcGFyYWxsZWwKbW1hcCB3cml0ZXMg
aGFwcGVuIChGVVNFX0RJUkVDVF9JT19SRUxBWCBpcyBzZXQpLgpSZWFzb24gaXMgdGhhdCBt
dWx0aXBsZSBESU8gd3JpdGVycyBzZWUgdGhhdCB0aGUgaW5vZGUgaGFzIHBlbmRpbmcKcGFn
ZSBJTyB3cml0ZXMgYW5kIHRyeSB0byBzZXQgRlVTRV9OT1dSSVRFLCBidXQgdGhpcyBjb2Rl
IHBhdGggcmVxdWlyZXMKc2VyaWFsaXphdGlvbi4gSWRlYWwgd291bGQgYmUgdG8gbGV0IGZ1
c2VfZGlvX3dyX2V4Y2x1c2l2ZV9sb2NrIGRldGVjdCBpZgp0aGVyZSBhcmUgb3V0c3RhbmRp
bmcgd3JpdGVzLCBidXQgdGhhdCB3b3VsZCByZXF1aXJlIHRvIGhvbGQgYW4gaW5vZGUKbG9j
ayBpbiByZWxhdGVkIHBhZ2UvZm9saW8gd3JpdGUgcGF0aHMuIEFub3RoZXIgc29sdXRpb24g
d291bGQgYmUgdG8gZGlzYWJsZQp0aGUgc2hhcmVkIGlub2RlIGxvY2sgZm9yIEZPUEVOX0RJ
UkVDVF9JTywgd2hlbiBGVVNFX0RJUkVDVF9JT19SRUxBWCBpcyBzZXQsCmJ1dCB0eXBpY2Fs
bHkgdXNlcnNwYWNlL3NlcnZlciBzaWRlIHdpbGwgc2V0IHRoZXNlIGZsYWdzIGZvciBhbGwg
aW5vZGVzIChvciBub3QKYXQgYWxsKS4gSGVuY2UsIEZVU0VfRElSRUNUX0lPX1JFTEFYIHdv
dWxkIGVudGlyZWx5IGRpc2FibGUgdGhlIHNoYXJlZCBsb2NrIGFuZAppbXBvc2Ugc2VyaWFs
aXphdGlvbiBldmVuIHRob3VnaCBubyBwYWdlIElPIGlzIGV2ZXIgZG9uZSBmb3IgaW5vZGVz
LgpUaGUgc29sdXRpb24gaGVyZSBzdG9yZXMgYSBmbGFnIGludG8gdGhlIGZ1c2UgaW5vZGUs
IGlmIHBhZ2Ugd3JpdGVzIGV2ZXIKaGFwcGVuZWQgdG8gYW4gaW5vZGUgYW5kIG9ubHkgdGhl
biB0byBlbmZvcmNlIHRoZSBub24tc2hhcmVkIGxvY2suCgpDYzogSGFvIFh1IDxob3dleXh1
QHRlbmNlbnQuY29tPgpDYzogTWlrbG9zIFN6ZXJlZGkgPG1pa2xvc0BzemVyZWRpLmh1PgpD
YzogRGhhcm1lbmRyYSBTaW5naCA8ZHNpbmdoQGRkbi5jb20+CkNjOiBBbWlyIEdvbGRzdGVp
biA8YW1pcjczaWxAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCZXJuZCBTY2h1YmVydCA8
YnNjaHViZXJ0QGRkbi5jb20+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAx
NTM1MjQwNTNiYmIgKCJmdXNlOiBhbGxvdyBub24tZXh0ZW5kaW5nIHBhcmFsbGVsIGRpcmVj
dCB3cml0ZXMgb24gdGhlIHNhbWUgZmlsZSIpCi0tLQogZnMvZnVzZS9kaXIuYyAgICB8ICAg
IDEgKwogZnMvZnVzZS9maWxlLmMgICB8ICAgNzIgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCiBmcy9mdXNlL2Z1c2VfaS5oIHwgICAg
OSArKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9kaXIuYyBiL2ZzL2Z1c2UvZGlyLmMKaW5k
ZXggZDE5Y2JmMzRjNjM0Li4wOWFhYWEzMWFlMjggMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZGly
LmMKKysrIGIvZnMvZnVzZS9kaXIuYwpAQCAtMTc1MSw2ICsxNzUxLDcgQEAgdm9pZCBmdXNl
X3NldF9ub3dyaXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUpCiAJc3RydWN0IGZ1c2VfaW5vZGUg
KmZpID0gZ2V0X2Z1c2VfaW5vZGUoaW5vZGUpOwogCiAJQlVHX09OKCFpbm9kZV9pc19sb2Nr
ZWQoaW5vZGUpKTsKKwlsb2NrZGVwX2Fzc2VydF9oZWxkX3dyaXRlKCZpbm9kZS0+aV9yd3Nl
bSk7CiAKIAlzcGluX2xvY2soJmZpLT5sb2NrKTsKIAlCVUdfT04oZmktPndyaXRlY3RyIDwg
MCk7CmRpZmYgLS1naXQgYS9mcy9mdXNlL2ZpbGUuYyBiL2ZzL2Z1c2UvZmlsZS5jCmluZGV4
IDYwZDRlMWU1MDg0My4uOTk1OWVhZmNhMGEwIDEwMDY0NAotLS0gYS9mcy9mdXNlL2ZpbGUu
YworKysgYi9mcy9mdXNlL2ZpbGUuYwpAQCAtMTMwOCwyNiArMTMwOCw1OSBAQCBzdGF0aWMg
Ym9vbCBmdXNlX2lvX3Bhc3RfZW9mKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9p
dGVyICppdGVyKQogLyoKICAqIEByZXR1cm4gdHJ1ZSBpZiBhbiBleGNsdXNpdmUgbG9jayBm
b3IgZGlyZWN0IElPIHdyaXRlcyBpcyBuZWVkZWQKICAqLwotc3RhdGljIGJvb2wgZnVzZV9k
aW9fd3JfZXhjbHVzaXZlX2xvY2soc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0
ZXIgKmZyb20pCitzdGF0aWMgYm9vbCBmdXNlX2Rpb193cl9leGNsdXNpdmVfbG9jayhzdHJ1
Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSwKKwkJCQkgICAgICAgYm9v
bCAqY250X2luY3JlYXNlZCkKIHsKIAlzdHJ1Y3QgZmlsZSAqZmlsZSA9IGlvY2ItPmtpX2Zp
bHA7CisJc3RydWN0IGlub2RlICppbm9kZSA9IGZpbGVfaW5vZGUoaW9jYi0+a2lfZmlscCk7
CisJc3RydWN0IGZ1c2VfaW5vZGUgKmZpID0gZ2V0X2Z1c2VfaW5vZGUoaW5vZGUpOwogCXN0
cnVjdCBmdXNlX2ZpbGUgKmZmID0gZmlsZS0+cHJpdmF0ZV9kYXRhOworCXN0cnVjdCBmdXNl
X2Nvbm4gKmZjID0gZmYtPmZtLT5mYzsKKwlib29sIGV4Y2xfbG9jayA9IHRydWU7CiAKIAkv
KiBzZXJ2ZXIgc2lkZSBoYXMgdG8gYWR2aXNlIHRoYXQgaXQgc3VwcG9ydHMgcGFyYWxsZWwg
ZGlvIHdyaXRlcyAqLwogCWlmICghKGZmLT5vcGVuX2ZsYWdzICYgRk9QRU5fUEFSQUxMRUxf
RElSRUNUX1dSSVRFUykpCi0JCXJldHVybiB0cnVlOworCQlnb3RvIG91dDsKIAogCS8qIGFw
cGVuZCB3aWxsIG5lZWQgdG8ga25vdyB0aGUgZXZlbnR1YWwgZW9mIC0gYWx3YXlzIG5lZWRz
IGFuCiAJICogZXhjbHVzaXZlIGxvY2sKIAkgKi8KIAlpZiAoaW9jYi0+a2lfZmxhZ3MgJiBJ
T0NCX0FQUEVORCkKLQkJcmV0dXJuIHRydWU7CisJCWdvdG8gb3V0OwogCiAJLyogcGFyYWxs
ZWwgZGlvIGJleW9uZCBlb2YgaXMgYXQgbGVhc3QgZm9yIG5vdyBub3Qgc3VwcG9ydGVkICov
CiAJaWYgKGZ1c2VfaW9fcGFzdF9lb2YoaW9jYiwgZnJvbSkpCi0JCXJldHVybiB0cnVlOwor
CQlnb3RvIG91dDsKIAotCXJldHVybiBmYWxzZTsKKwkvKiBubyBuZWVkIHRvIG9wdGltaXpl
IGFzeW5jIHJlcXVlc3RzICovCisJaWYgKCFpc19zeW5jX2tpb2NiKGlvY2IpICYmIGlvY2It
PmtpX2ZsYWdzICYgSU9DQl9ESVJFQ1QgJiYKKwkgICAgZmMtPmFzeW5jX2RpbykKKwkJZ290
byBvdXQ7CisKKwkvKiBUaGUgaW5vZGUgZXZlciBnb3QgcGFnZSB3cml0ZXMgYW5kIHdlIGRv
IG5vdCBrbm93IGZvciBzdXJlCisJICogaW4gdGhlIERJTyBwYXRoIGlmIHRoZXNlIGFyZSBw
ZW5kaW5nIC0gc2hhcmVkIGxvY2sgbm90IHBvc3NpYmxlICovCisJc3Bpbl9sb2NrKCZmaS0+
bG9jayk7CisJaWYgKCF0ZXN0X2JpdChGVVNFX0lfQ0FDSEVfV1JJVEVTLCAmZmktPnN0YXRl
KSkgeworCQlpZiAoISgqY250X2luY3JlYXNlZCkpIHsKKwkJCWZpLT5zaGFyZWRfbG9ja19k
aXJlY3RfaW9fY3RyKys7CisJCQkqY250X2luY3JlYXNlZCA9IHRydWU7CisJCX0KKwkJZXhj
bF9sb2NrID0gZmFsc2U7CisJfQorCXNwaW5fdW5sb2NrKCZmaS0+bG9jayk7CisKK291dDoK
KwlpZiAoZXhjbF9sb2NrICYmICpjbnRfaW5jcmVhc2VkKSB7CisJCWJvb2wgd2FrZSA9IGZh
bHNlOworCQlzcGluX2xvY2soJmZpLT5sb2NrKTsKKwkJaWYgKC0tZmktPnNoYXJlZF9sb2Nr
X2RpcmVjdF9pb19jdHIgPT0gMCkKKwkJCXdha2UgPSB0cnVlOworCQlzcGluX3VubG9jaygm
ZmktPmxvY2spOworCQlpZiAod2FrZSkKKwkJCXdha2VfdXAoJmZpLT5kaXJlY3RfaW9fd2Fp
dHEpOworCX0KKworCXJldHVybiBleGNsX2xvY2s7CiB9CiAKIHN0YXRpYyBzc2l6ZV90IGZ1
c2VfY2FjaGVfd3JpdGVfaXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRl
ciAqZnJvbSkKQEAgLTE1NDksNiArMTU4Miw3IEBAIHNzaXplX3QgZnVzZV9kaXJlY3RfaW8o
c3RydWN0IGZ1c2VfaW9fcHJpdiAqaW8sIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwKIAkJCQli
cmVhazsKIAkJfQogCX0KKwogCWlmIChpYSkKIAkJZnVzZV9pb19mcmVlKGlhKTsKIAlpZiAo
cmVzID4gMCkKQEAgLTE1OTIsOSArMTYyNiwxMiBAQCBzdGF0aWMgc3NpemVfdCBmdXNlX2Rp
cmVjdF9yZWFkX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKnRv
KQogc3RhdGljIHNzaXplX3QgZnVzZV9kaXJlY3Rfd3JpdGVfaXRlcihzdHJ1Y3Qga2lvY2Ig
KmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSkKIHsKIAlzdHJ1Y3QgaW5vZGUgKmlub2Rl
ID0gZmlsZV9pbm9kZShpb2NiLT5raV9maWxwKTsKKwlzdHJ1Y3QgZnVzZV9pbm9kZSAqZmkg
PSBnZXRfZnVzZV9pbm9kZShpbm9kZSk7CiAJc3RydWN0IGZ1c2VfaW9fcHJpdiBpbyA9IEZV
U0VfSU9fUFJJVl9TWU5DKGlvY2IpOwogCXNzaXplX3QgcmVzOwotCWJvb2wgZXhjbHVzaXZl
X2xvY2sgPSBmdXNlX2Rpb193cl9leGNsdXNpdmVfbG9jayhpb2NiLCBmcm9tKTsKKwlib29s
IHNoYXJlZF9sb2NrX2NudF9pbmMgPSBmYWxzZTsKKwlib29sIGV4Y2x1c2l2ZV9sb2NrID0g
ZnVzZV9kaW9fd3JfZXhjbHVzaXZlX2xvY2soaW9jYiwgZnJvbSwKKwkJCQkJCQkgJnNoYXJl
ZF9sb2NrX2NudF9pbmMpOwogCiAJLyoKIAkgKiBUYWtlIGV4Y2x1c2l2ZSBsb2NrIGlmCkBA
IC0xNjEwLDcgKzE2NDcsOCBAQCBzdGF0aWMgc3NpemVfdCBmdXNlX2RpcmVjdF93cml0ZV9p
dGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQogCQkvKgog
CQkgKiBQcmV2aW91cyBjaGVjayB3YXMgd2l0aG91dCBhbnkgbG9jayBhbmQgbWlnaHQgaGF2
ZSByYWNlZC4KIAkJICovCi0JCWlmIChmdXNlX2Rpb193cl9leGNsdXNpdmVfbG9jayhpb2Ni
LCBmcm9tKSkgeworCQlpZiAoZnVzZV9kaW9fd3JfZXhjbHVzaXZlX2xvY2soaW9jYiwgZnJv
bSwKKwkJCQkJICAgICAgICZzaGFyZWRfbG9ja19jbnRfaW5jKSkgewogCQkJaW5vZGVfdW5s
b2NrX3NoYXJlZChpbm9kZSk7CiAJCQlpbm9kZV9sb2NrKGlub2RlKTsKIAkJCWV4Y2x1c2l2
ZV9sb2NrID0gdHJ1ZTsKQEAgLTE2MjksOCArMTY2NywxNyBAQCBzdGF0aWMgc3NpemVfdCBm
dXNlX2RpcmVjdF93cml0ZV9pdGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9p
dGVyICpmcm9tKQogCX0KIAlpZiAoZXhjbHVzaXZlX2xvY2spCiAJCWlub2RlX3VubG9jayhp
bm9kZSk7Ci0JZWxzZQorCWVsc2UgeworCQlib29sIHdha2UgPSBmYWxzZTsKKwogCQlpbm9k
ZV91bmxvY2tfc2hhcmVkKGlub2RlKTsKKwkJc3Bpbl9sb2NrKCZmaS0+bG9jayk7CisJCWlm
ICgtLWZpLT5zaGFyZWRfbG9ja19kaXJlY3RfaW9fY3RyID09IDApCisJCQl3YWtlID0gdHJ1
ZTsKKwkJc3Bpbl91bmxvY2soJmZpLT5sb2NrKTsKKwkJaWYgKHdha2UpCisJCQl3YWtlX3Vw
KCZmaS0+ZGlyZWN0X2lvX3dhaXRxKTsKKwl9CiAKIAlyZXR1cm4gcmVzOwogfQpAQCAtMTcx
OSw2ICsxNzY2LDEzIEBAIF9fYWNxdWlyZXMoZmktPmxvY2spCiAJX191NjQgZGF0YV9zaXpl
ID0gd3BhLT5pYS5hcC5udW1fcGFnZXMgKiBQQUdFX1NJWkU7CiAJaW50IGVycjsKIAorCWlm
ICghdGVzdF9iaXQoRlVTRV9JX0NBQ0hFX1dSSVRFUywgJmZpLT5zdGF0ZSkpIHsKKwkJc2V0
X2JpdChGVVNFX0lfQ0FDSEVfV1JJVEVTLCAmZmktPnN0YXRlKTsKKwkJc3Bpbl91bmxvY2so
JmZpLT5sb2NrKTsKKwkJd2FpdF9ldmVudChmaS0+ZGlyZWN0X2lvX3dhaXRxLCBmaS0+c2hh
cmVkX2xvY2tfZGlyZWN0X2lvX2N0ciA9PSAwKTsKKwkJc3Bpbl9sb2NrKCZmaS0+bG9jayk7
CisJfQorCiAJZmktPndyaXRlY3RyKys7CiAJaWYgKGluYXJnLT5vZmZzZXQgKyBkYXRhX3Np
emUgPD0gc2l6ZSkgewogCQlpbmFyZy0+c2l6ZSA9IGRhdGFfc2l6ZTsKQEAgLTMyNjEsNyAr
MzMxNSw5IEBAIHZvaWQgZnVzZV9pbml0X2ZpbGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9k
ZSwgdW5zaWduZWQgaW50IGZsYWdzKQogCUlOSVRfTElTVF9IRUFEKCZmaS0+d3JpdGVfZmls
ZXMpOwogCUlOSVRfTElTVF9IRUFEKCZmaS0+cXVldWVkX3dyaXRlcyk7CiAJZmktPndyaXRl
Y3RyID0gMDsKKwlmaS0+c2hhcmVkX2xvY2tfZGlyZWN0X2lvX2N0ciA9IDA7CiAJaW5pdF93
YWl0cXVldWVfaGVhZCgmZmktPnBhZ2Vfd2FpdHEpOworCWluaXRfd2FpdHF1ZXVlX2hlYWQo
JmZpLT5kaXJlY3RfaW9fd2FpdHEpOwogCWZpLT53cml0ZXBhZ2VzID0gUkJfUk9PVDsKIAog
CWlmIChJU19FTkFCTEVEKENPTkZJR19GVVNFX0RBWCkpCmRpZmYgLS1naXQgYS9mcy9mdXNl
L2Z1c2VfaS5oIGIvZnMvZnVzZS9mdXNlX2kuaAppbmRleCA2ZTZlNzIxZjQyMWIuLmZlYmIx
ZjVjZDUzZiAxMDA2NDQKLS0tIGEvZnMvZnVzZS9mdXNlX2kuaAorKysgYi9mcy9mdXNlL2Z1
c2VfaS5oCkBAIC0xMTAsMTEgKzExMCwxNyBAQCBzdHJ1Y3QgZnVzZV9pbm9kZSB7CiAJCQkg
KiAoRlVTRV9OT1dSSVRFKSBtZWFucyBtb3JlIHdyaXRlcyBhcmUgYmxvY2tlZCAqLwogCQkJ
aW50IHdyaXRlY3RyOwogCisJCQkvKiBjb3VudGVyIG9mIHRhc2tzIHdpdGggc2hhcmVkIGxv
Y2sgZGlyZWN0LWlvIHdyaXRlcyAqLworCQkJaW50IHNoYXJlZF9sb2NrX2RpcmVjdF9pb19j
dHI7CisKIAkJCS8qIFdhaXRxIGZvciB3cml0ZXBhZ2UgY29tcGxldGlvbiAqLwogCQkJd2Fp
dF9xdWV1ZV9oZWFkX3QgcGFnZV93YWl0cTsKIAogCQkJLyogTGlzdCBvZiB3cml0ZXBhZ2Ug
cmVxdWVzdHN0IChwZW5kaW5nIG9yIHNlbnQpICovCiAJCQlzdHJ1Y3QgcmJfcm9vdCB3cml0
ZXBhZ2VzOworCisJCQkvKiB3YWl0cSBmb3IgZGlyZWN0LWlvIGNvbXBsZXRpb24gKi8KKwkJ
CXdhaXRfcXVldWVfaGVhZF90IGRpcmVjdF9pb193YWl0cTsKIAkJfTsKIAogCQkvKiByZWFk
ZGlyIGNhY2hlIChkaXJlY3Rvcnkgb25seSkgKi8KQEAgLTE3Miw2ICsxNzgsOSBAQCBlbnVt
IHsKIAlGVVNFX0lfQkFELAogCS8qIEhhcyBidGltZSAqLwogCUZVU0VfSV9CVElNRSwKKwkv
KiBIYXMgcGFnZWQgd3JpdGVzICovCisJRlVTRV9JX0NBQ0hFX1dSSVRFUywKKwogfTsKIAog
c3RydWN0IGZ1c2VfY29ubjsKL2ZzL2Z1c2UvZnVzZV9pLmgKQEAgLTExMCwxMSArMTEwLDE3
IEBAIHN0cnVjdCBmdXNlX2lub2RlIHsKIAkJCSAqIChGVVNFX05PV1JJVEUpIG1lYW5zIG1v
cmUgd3JpdGVzIGFyZSBibG9ja2VkICovCiAJCQlpbnQgd3JpdGVjdHI7CiAKKwkJCS8qIGNv
dW50ZXIgb2YgdGFza3Mgd2l0aCBzaGFyZWQgbG9jayBkaXJlY3QtaW8gd3JpdGVzICovCisJ
CQlpbnQgc2hhcmVkX2xvY2tfZGlyZWN0X2lvX2N0cjsKKwogCQkJLyogV2FpdHEgZm9yIHdy
aXRlcGFnZSBjb21wbGV0aW9uICovCiAJCQl3YWl0X3F1ZXVlX2hlYWRfdCBwYWdlX3dhaXRx
OwogCiAJCQkvKiBMaXN0IG9mIHdyaXRlcGFnZSByZXF1ZXN0c3QgKHBlbmRpbmcgb3Igc2Vu
dCkgKi8KIAkJCXN0cnVjdCByYl9yb290IHdyaXRlcGFnZXM7CisKKwkJCS8qIHdhaXRxIGZv
ciBkaXJlY3QtaW8gY29tcGxldGlvbiAqLworCQkJd2FpdF9xdWV1ZV9oZWFkX3QgZGlyZWN0
X2lvX3dhaXRxOwogCQl9OwogCiAJCS8qIHJlYWRkaXIgY2FjaGUgKGRpcmVjdG9yeSBvbmx5
KSAqLwpAQCAtMTcyLDYgKzE3OCw5IEBAIGVudW0gewogCUZVU0VfSV9CQUQsCiAJLyogSGFz
IGJ0aW1lICovCiAJRlVTRV9JX0JUSU1FLAorCS8qIEhhcyBwYWdlZCB3cml0ZXMgKi8KKwlG
VVNFX0lfQ0FDSEVfV1JJVEVTLAorCiB9OwogCiBzdHJ1Y3QgZnVzZV9jb25uOwo=

--------------20H4CKtj5xkpbQ0MJ0Mcjrda--

