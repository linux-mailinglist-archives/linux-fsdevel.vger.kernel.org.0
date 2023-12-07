Return-Path: <linux-fsdevel+bounces-5184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E839C809069
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 19:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B12817CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427A44EB53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="st8CR38V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nx3Gsg1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B875810E7
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 10:38:04 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 6B3CC3200B63;
	Thu,  7 Dec 2023 13:38:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Dec 2023 13:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701974280; x=1702060680; bh=uR
	TcNO7dBVtGEjqxKvssLNc6tEHjUOkHd+Urw/UMiZk=; b=st8CR38VM9Ev0ElBG9
	0ECC5XCkoGAXherTGaMJu1eMmXamTUnmFUJ/oo4gd1FgZwmpRCPugmem1QLy92Tv
	y0GUogjnVrfO+2zvFjff04ibSyEomHuDxeJG3GCZn1gG9BzC8Grd5tpFdotF8X7W
	0yr6dOKqVoMg75DejFhr19Myj/0alg9WDRn1mdZzbWeqqnRoa5aaoDnaKliuGEd1
	2+Jz7gGJkgu5rYBbZgHz1ImHqGY7iLoAKVb213qlTW7WmRIx+00jLOAaszESx9d6
	3R8EZUJb5/d7jM2TbRc5i0cwlVFwg2LCxfmCNqhTDrPC75u3/ko29Jg8/ED/+U1h
	j9lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701974280; x=1702060680; bh=uRTcNO7dBVtGE
	jqxKvssLNc6tEHjUOkHd+Urw/UMiZk=; b=nx3Gsg1ZagG+73wv1JhKv+VopEiys
	z1YtuIH6zWTKXUkTddoeLcW9whvHEbmzC0P7Zg6eCzDbz4ovxvGOZTB5KjDJtuAf
	YOs6Zce9C8L2wP0KnM5EwT4dgdD/v/ZXWxca8DdUoxDXsV4jbAtwJBwpGkB6juB/
	4F/PR9J//88m1vksQnLBNhtO4fZiXqzOXVGXdyjuvMkwxijIsvrh0FCDORaAJid/
	IidvckR/iKaTqli/Abtc+tJYq6mge2ZSeRNsq3qtu0jEl2KCxKQaNLmeKxTMCUOe
	7Z04m04S0zdAwpDH71QDbrcoKa3a6b+mHdOHdqxoWrj7cf8Mg/FXeLn8g==
X-ME-Sender: <xms:CBFyZcMKY72pzVIcbDrAFr3-d4U3neZ0Qo6pGDjnnhmlWv3JBb7yyQ>
    <xme:CBFyZS_jkOzkO0KtekgFK-YtWrenXE3rdDRfZsMnh6N2HKMI5iKNAUV-NEh_SDkgY
    nNm2_tsGVBCRdWd>
X-ME-Received: <xmr:CBFyZTRNgQ5G5_fH7felarBz50ZQN_f7LNHrh6ld2W6YI64Wc4AHSnapKxeRa1A6dyzxesiHIWMRFiw-Pmj9RlOw7XoZM5mtJG7PlALIPjFQFVqrYJJy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekfedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptgfkffggfgfuvfevfhfhjgesmhdtreertddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekjeekkeevgfdvudevgfevjeetlefhfeevhfek
    kedutefgkeffheejfedtudfggfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:CBFyZUsDPuGa0S-BOYpN11kHCYxz-s9LgwQGJUusdIk2SMgRBNUt0Q>
    <xmx:CBFyZUeNxO1hDmx8LCGRr0RHi5MsNCxktKdVWMfkO88uDLHcSx20GQ>
    <xmx:CBFyZY2N-CNSYYl441b0QLwPTLaiaZ2JK8Twh_v0HANEZ20mf3d9Yw>
    <xmx:CBFyZSuXRbZx7nfyKtVVCeXstzcw07O1rnQk6lcyvBZieJL2Cf67eQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 13:37:58 -0500 (EST)
Content-Type: multipart/mixed; boundary="------------0C07c0uviFxx0deBMx0CzaTQ"
Message-ID: <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm>
Date: Thu, 7 Dec 2023 19:37:57 +0100
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
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>

This is a multi-part message in MIME format.
--------------0C07c0uviFxx0deBMx0CzaTQ
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
> 
> FUSE_I_CACHE_WRITES means that caching writes happened.
> FUSE_I_CACHE_IO_MODE means the caching writes and reads
> may happen.
> 
> FOPEN_PARALLEL_DIRECT_WRITES obviously shouldn't care
> about "caching reads may happen", but IMO that is a small trade off
> to make for maintaining the same state for
> "do not allow parallel dio" and "do not allow passthrough open".

I think the attached patches should do, it now also unsets 
FUSE_I_CACHE_IO_MODE. Setting the flag actually has to be done from 
fuse_file_mmap (and not from fuse_send_writepage) to avoid a dead stall, 
but that aligns with passthrough anyway? Amir, right now it only sets
FUSE_I_CACHE_IO_MODE for VM_MAYWRITE. Maybe you could add a condition
for passthrough there?

@Miklos, could please tell me how to move forward? I definitely need to 
rebase to fuse-next, but my question is if this patch here should 
replace Amirs fix (and get back ported) or if we should apply it on top
of Amirs patch and so let that simple fix get back ported? Given this is 
all features and new flags - I'm all for for the simple fix.
If you agree on the general approach, I can put this on top of my dio
consolidate branch and rebase the rest of the patches on top of it. That 
part will get a bit more complicated, as we will also need to handle 
plain O_DIRECT.


Thanks,
Bernd
--------------0C07c0uviFxx0deBMx0CzaTQ
Content-Type: text/x-patch; charset=UTF-8;
 name="01-fuse-Create-helper-function-if.patch"
Content-Disposition: attachment;
 filename="01-fuse-Create-helper-function-if.patch"
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
ZSIpCi0tLQogZnMvZnVzZS9maWxlLmMgfCAgIDU3ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDAg
aW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9m
aWxlLmMgYi9mcy9mdXNlL2ZpbGUuYwppbmRleCAxY2RiNjMyNzUxMWUuLjljYzcxODQyNDFl
NSAxMDA2NDQKLS0tIGEvZnMvZnVzZS9maWxlLmMKKysrIGIvZnMvZnVzZS9maWxlLmMKQEAg
LTEyOTgsNiArMTI5OCw0MiBAQCBzdGF0aWMgc3NpemVfdCBmdXNlX3BlcmZvcm1fd3JpdGUo
c3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmlpKQogCXJldHVybiByZXM7
CiB9CiAKK3N0YXRpYyBib29sIGZ1c2VfaW9fcGFzdF9lb2Yoc3RydWN0IGtpb2NiICppb2Ni
LCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpCit7CisJc3RydWN0IGlub2RlICppbm9kZSA9IGZp
bGVfaW5vZGUoaW9jYi0+a2lfZmlscCk7CisKKwlyZXR1cm4gaW9jYi0+a2lfcG9zICsgaW92
X2l0ZXJfY291bnQoaXRlcikgPiBpX3NpemVfcmVhZChpbm9kZSk7Cit9CisKKy8qCisgKiBA
cmV0dXJuIHRydWUgaWYgYW4gZXhjbHVzaXZlIGxvY2sgZm9yIGRpcmVjdCBJTyB3cml0ZXMg
aXMgbmVlZGVkCisgKi8KK3N0YXRpYyBib29sIGZ1c2VfZGlvX3dyX2V4Y2x1c2l2ZV9sb2Nr
KHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQoreworCXN0cnVj
dCBmaWxlICpmaWxlID0gaW9jYi0+a2lfZmlscDsKKwlzdHJ1Y3QgZnVzZV9maWxlICpmZiA9
IGZpbGUtPnByaXZhdGVfZGF0YTsKKwlib29sIGV4Y2xfbG9jayA9IHRydWU7CisKKwkvKiBz
ZXJ2ZXIgc2lkZSBoYXMgdG8gYWR2aXNlIHRoYXQgaXQgc3VwcG9ydHMgcGFyYWxsZWwgZGlv
IHdyaXRlcyAqLworCWlmICghKGZmLT5vcGVuX2ZsYWdzICYgRk9QRU5fUEFSQUxMRUxfRElS
RUNUX1dSSVRFUykpCisJCWdvdG8gb3V0OworCisJLyogYXBwZW5kIHdpbGwgbmVlZCB0byBr
bm93IHRoZSBldmVudHVhbCBlb2YgLSBhbHdheXMgbmVlZHMgYW4KKwkgKiBleGNsdXNpdmUg
bG9jaworCSAqLworCWlmIChpb2NiLT5raV9mbGFncyAmIElPQ0JfQVBQRU5EKQorCQlnb3Rv
IG91dDsKKworCS8qIHBhcmFsbGVsIGRpbyBiZXlvbmQgZW9mIGlzIGF0IGxlYXN0IGZvciBu
b3cgbm90IHN1cHBvcnRlZCAqLworCWlmIChmdXNlX2lvX3Bhc3RfZW9mKGlvY2IsIGZyb20p
KQorCQlnb3RvIG91dDsKKworCWV4Y2xfbG9jayA9IGZhbHNlOworCitvdXQ6CisJcmV0dXJu
IGV4Y2xfbG9jazsKK30KKwogc3RhdGljIHNzaXplX3QgZnVzZV9jYWNoZV93cml0ZV9pdGVy
KHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQogewogCXN0cnVj
dCBmaWxlICpmaWxlID0gaW9jYi0+a2lfZmlscDsKQEAgLTE1NTcsMjUgKzE1OTMsMTIgQEAg
c3RhdGljIHNzaXplX3QgZnVzZV9kaXJlY3RfcmVhZF9pdGVyKHN0cnVjdCBraW9jYiAqaW9j
Yiwgc3RydWN0IGlvdl9pdGVyICp0bykKIAlyZXR1cm4gcmVzOwogfQogCi1zdGF0aWMgYm9v
bCBmdXNlX2RpcmVjdF93cml0ZV9leHRlbmRpbmdfaV9zaXplKHN0cnVjdCBraW9jYiAqaW9j
YiwKLQkJCQkJICAgICAgIHN0cnVjdCBpb3ZfaXRlciAqaXRlcikKLXsKLQlzdHJ1Y3QgaW5v
ZGUgKmlub2RlID0gZmlsZV9pbm9kZShpb2NiLT5raV9maWxwKTsKLQotCXJldHVybiBpb2Ni
LT5raV9wb3MgKyBpb3ZfaXRlcl9jb3VudChpdGVyKSA+IGlfc2l6ZV9yZWFkKGlub2RlKTsK
LX0KLQogc3RhdGljIHNzaXplX3QgZnVzZV9kaXJlY3Rfd3JpdGVfaXRlcihzdHJ1Y3Qga2lv
Y2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSkKIHsKIAlzdHJ1Y3QgaW5vZGUgKmlu
b2RlID0gZmlsZV9pbm9kZShpb2NiLT5raV9maWxwKTsKLQlzdHJ1Y3QgZmlsZSAqZmlsZSA9
IGlvY2ItPmtpX2ZpbHA7Ci0Jc3RydWN0IGZ1c2VfZmlsZSAqZmYgPSBmaWxlLT5wcml2YXRl
X2RhdGE7CiAJc3RydWN0IGZ1c2VfaW9fcHJpdiBpbyA9IEZVU0VfSU9fUFJJVl9TWU5DKGlv
Y2IpOwogCXNzaXplX3QgcmVzOwotCWJvb2wgZXhjbHVzaXZlX2xvY2sgPQotCQkhKGZmLT5v
cGVuX2ZsYWdzICYgRk9QRU5fUEFSQUxMRUxfRElSRUNUX1dSSVRFUykgfHwKLQkJaW9jYi0+
a2lfZmxhZ3MgJiBJT0NCX0FQUEVORCB8fAotCQlmdXNlX2RpcmVjdF93cml0ZV9leHRlbmRp
bmdfaV9zaXplKGlvY2IsIGZyb20pOworCWJvb2wgZXhjbHVzaXZlX2xvY2sgPSBmdXNlX2Rp
b193cl9leGNsdXNpdmVfbG9jayhpb2NiLCBmcm9tKTsKIAogCS8qCiAJICogVGFrZSBleGNs
dXNpdmUgbG9jayBpZgpAQCAtMTU4OCwxMCArMTYxMSwxMCBAQCBzdGF0aWMgc3NpemVfdCBm
dXNlX2RpcmVjdF93cml0ZV9pdGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9p
dGVyICpmcm9tKQogCWVsc2UgewogCQlpbm9kZV9sb2NrX3NoYXJlZChpbm9kZSk7CiAKLQkJ
LyogQSByYWNlIHdpdGggdHJ1bmNhdGUgbWlnaHQgaGF2ZSBjb21lIHVwIGFzIHRoZSBkZWNp
c2lvbiBmb3IKLQkJICogdGhlIGxvY2sgdHlwZSB3YXMgZG9uZSB3aXRob3V0IGhvbGRpbmcg
dGhlIGxvY2ssIGNoZWNrIGFnYWluLgorCQkvKgorCQkgKiBQcmV2aW91cyBjaGVjayB3YXMg
d2l0aG91dCBhbnkgbG9jayBhbmQgbWlnaHQgaGF2ZSByYWNlZC4KIAkJICovCi0JCWlmIChm
dXNlX2RpcmVjdF93cml0ZV9leHRlbmRpbmdfaV9zaXplKGlvY2IsIGZyb20pKSB7CisJCWlm
IChmdXNlX2Rpb193cl9leGNsdXNpdmVfbG9jayhpb2NiLCBmcm9tKSkgewogCQkJaW5vZGVf
dW5sb2NrX3NoYXJlZChpbm9kZSk7CiAJCQlpbm9kZV9sb2NrKGlub2RlKTsKIAkJCWV4Y2x1
c2l2ZV9sb2NrID0gdHJ1ZTsK
--------------0C07c0uviFxx0deBMx0CzaTQ
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
d291bGQgYmUgdG8KZGlzYWJsZSB0aGUgc2hhcmVkIGlub2RlIGxvY2sgZm9yIEZPUEVOX0RJ
UkVDVF9JTywgd2hlbgpGVVNFX0RJUkVDVF9JT19SRUxBWCBpcyBzZXQsIGJ1dCB0eXBpY2Fs
bHkgdXNlcnNwYWNlL3NlcnZlciBzaWRlIHdpbGwgc2V0CnRoZXNlIGZsYWdzIGZvciBhbGwg
aW5vZGVzIChvciBub3QgYXQgYWxsKS4gV2l0aCB0aGF0IEZVU0VfRElSRUNUX0lPX1JFTEFY
CndvdWxkIGVudGlyZWx5IGRpc2FibGUgdGhlIHNoYXJlZCBsb2NrIGFuZCBpbXBvc2Ugc2Vy
aWFsaXphdGlvbiBldmVuCnRob3VnaCBubyBwYWdlIElPIGlzIGV2ZXIgZG9uZSBmb3IgaW5v
ZGVzLiAgVGhlIHNvbHV0aW9uIGhlcmUgc3RvcmVzIGEKZmxhZyBpbnRvIHRoZSBmdXNlIGlu
b2RlIHdoZW4gbW1hcCBpcyBzdGFydGVkLiBUaGlzIGZsYWcgaXMgdXNlZCB0bwp0byBlbmZv
cmNlIHRoZSBleGNsdXNpdmUgaW5vZGUgbG9jayBmb3IgRk9QRU5fRElSRUNUX0lPLgpPdGhl
ciB0aGFuIHRoYXQsIHRoZSBwYXRjaCBkb2VzIG5vdCBoZWxwIHRvIGltcHJvdmUgY29uc2lz
dGVuc3R5IGZvcgpjb25jdXJyZW50IHBhZ2UgY2FjaGUgKHNvIGZhciBvbmx5IG1tYXApIGFu
ZCBkaXJlY3QgSU8gZmlsZSB3cml0ZXMuCgpDYzogSGFvIFh1IDxob3dleXh1QHRlbmNlbnQu
Y29tPgpDYzogTWlrbG9zIFN6ZXJlZGkgPG1pa2xvc0BzemVyZWRpLmh1PgpDYzogRGhhcm1l
bmRyYSBTaW5naCA8ZHNpbmdoQGRkbi5jb20+CkNjOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjcz
aWxAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0
QGRkbi5jb20+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAxNTM1MjQwNTNi
YmIgKCJmdXNlOiBhbGxvdyBub24tZXh0ZW5kaW5nIHBhcmFsbGVsIGRpcmVjdCB3cml0ZXMg
b24gdGhlIHNhbWUgZmlsZSIpCi0tLQogZnMvZnVzZS9kaXIuYyAgICB8ICAgIDEgCiBmcy9m
dXNlL2ZpbGUuYyAgIHwgIDE1MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0KIGZzL2Z1c2UvZnVzZV9pLmggfCAgIDEyICsrKysKIGZz
L2Z1c2UvaW5vZGUuYyAgfCAgICAxIAogNCBmaWxlcyBjaGFuZ2VkLCAxMzMgaW5zZXJ0aW9u
cygrKSwgMzQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9kaXIuYyBiL2Zz
L2Z1c2UvZGlyLmMKaW5kZXggZDE5Y2JmMzRjNjM0Li4wOWFhYWEzMWFlMjggMTAwNjQ0Ci0t
LSBhL2ZzL2Z1c2UvZGlyLmMKKysrIGIvZnMvZnVzZS9kaXIuYwpAQCAtMTc1MSw2ICsxNzUx
LDcgQEAgdm9pZCBmdXNlX3NldF9ub3dyaXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUpCiAJc3Ry
dWN0IGZ1c2VfaW5vZGUgKmZpID0gZ2V0X2Z1c2VfaW5vZGUoaW5vZGUpOwogCiAJQlVHX09O
KCFpbm9kZV9pc19sb2NrZWQoaW5vZGUpKTsKKwlsb2NrZGVwX2Fzc2VydF9oZWxkX3dyaXRl
KCZpbm9kZS0+aV9yd3NlbSk7CiAKIAlzcGluX2xvY2soJmZpLT5sb2NrKTsKIAlCVUdfT04o
ZmktPndyaXRlY3RyIDwgMCk7CmRpZmYgLS1naXQgYS9mcy9mdXNlL2ZpbGUuYyBiL2ZzL2Z1
c2UvZmlsZS5jCmluZGV4IDljYzcxODQyNDFlNS4uNWQ3NmViZDU0MTljIDEwMDY0NAotLS0g
YS9mcy9mdXNlL2ZpbGUuYworKysgYi9mcy9mdXNlL2ZpbGUuYwpAQCAtOTksNiArOTksMTYg
QEAgc3RhdGljIHZvaWQgZnVzZV9yZWxlYXNlX2VuZChzdHJ1Y3QgZnVzZV9tb3VudCAqZm0s
IHN0cnVjdCBmdXNlX2FyZ3MgKmFyZ3MsCiAJCQkgICAgIGludCBlcnJvcikKIHsKIAlzdHJ1
Y3QgZnVzZV9yZWxlYXNlX2FyZ3MgKnJhID0gY29udGFpbmVyX29mKGFyZ3MsIHR5cGVvZigq
cmEpLCBhcmdzKTsKKwlzdHJ1Y3QgZnVzZV9pbm9kZSAqZmkgPSBnZXRfZnVzZV9pbm9kZShy
YS0+aW5vZGUpOworCisJc3Bpbl9sb2NrKCZmaS0+bG9jayk7CisJaWYgKC0tZmktPm9wZW5f
Y3RyID09IDApIHsKKwkJLyogbm8gb3BlbiBmaWxlIGxlZnQgYW55bW9yZSwgcmVtb3ZlIHJl
c3RyaWN0aW9ucyBmcm9tCisJCSAqIHRoZSBjYWNoZSBiaXQKKwkJICovCisJCWNsZWFyX2Jp
dChGVVNFX0lfQ0FDSEVfSU9fTU9ERSwgJmZpLT5zdGF0ZSk7CisJfQorCXNwaW5fdW5sb2Nr
KCZmaS0+bG9jayk7CiAKIAlpcHV0KHJhLT5pbm9kZSk7CiAJa2ZyZWUocmEpOwpAQCAtMTIx
LDYgKzEzMSw3IEBAIHN0YXRpYyB2b2lkIGZ1c2VfZmlsZV9wdXQoc3RydWN0IGZ1c2VfZmls
ZSAqZmYsIGJvb2wgc3luYywgYm9vbCBpc2RpcikKIAkJCQkJCSAgIEdGUF9LRVJORUwgfCBf
X0dGUF9OT0ZBSUwpKQogCQkJCWZ1c2VfcmVsZWFzZV9lbmQoZmYtPmZtLCBhcmdzLCAtRU5P
VENPTk4pOwogCQl9CisKIAkJa2ZyZWUoZmYpOwogCX0KIH0KQEAgLTE5OCw2ICsyMDksNyBA
QCB2b2lkIGZ1c2VfZmluaXNoX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZp
bGUgKmZpbGUpCiB7CiAJc3RydWN0IGZ1c2VfZmlsZSAqZmYgPSBmaWxlLT5wcml2YXRlX2Rh
dGE7CiAJc3RydWN0IGZ1c2VfY29ubiAqZmMgPSBnZXRfZnVzZV9jb25uKGlub2RlKTsKKwlz
dHJ1Y3QgZnVzZV9pbm9kZSAqZmkgPSBnZXRfZnVzZV9pbm9kZShpbm9kZSk7CiAKIAlpZiAo
ZmYtPm9wZW5fZmxhZ3MgJiBGT1BFTl9TVFJFQU0pCiAJCXN0cmVhbV9vcGVuKGlub2RlLCBm
aWxlKTsKQEAgLTIwNSw4ICsyMTcsNiBAQCB2b2lkIGZ1c2VfZmluaXNoX29wZW4oc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJCW5vbnNlZWthYmxlX29wZW4o
aW5vZGUsIGZpbGUpOwogCiAJaWYgKGZjLT5hdG9taWNfb190cnVuYyAmJiAoZmlsZS0+Zl9m
bGFncyAmIE9fVFJVTkMpKSB7Ci0JCXN0cnVjdCBmdXNlX2lub2RlICpmaSA9IGdldF9mdXNl
X2lub2RlKGlub2RlKTsKLQogCQlzcGluX2xvY2soJmZpLT5sb2NrKTsKIAkJZmktPmF0dHJf
dmVyc2lvbiA9IGF0b21pYzY0X2luY19yZXR1cm4oJmZjLT5hdHRyX3ZlcnNpb24pOwogCQlp
X3NpemVfd3JpdGUoaW5vZGUsIDApOwpAQCAtMjE2LDYgKzIyNiwxMCBAQCB2b2lkIGZ1c2Vf
ZmluaXNoX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJ
fQogCWlmICgoZmlsZS0+Zl9tb2RlICYgRk1PREVfV1JJVEUpICYmIGZjLT53cml0ZWJhY2tf
Y2FjaGUpCiAJCWZ1c2VfbGlua193cml0ZV9maWxlKGZpbGUpOworCisJc3Bpbl9sb2NrKCZm
aS0+bG9jayk7CisJZmktPm9wZW5fY3RyKys7CisJc3Bpbl91bmxvY2soJmZpLT5sb2NrKTsK
IH0KIAogaW50IGZ1c2Vfb3Blbl9jb21tb24oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
IGZpbGUgKmZpbGUsIGJvb2wgaXNkaXIpCkBAIC0xMzA2LDEzICsxMzIwLDE5IEBAIHN0YXRp
YyBib29sIGZ1c2VfaW9fcGFzdF9lb2Yoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92
X2l0ZXIgKml0ZXIpCiB9CiAKIC8qCi0gKiBAcmV0dXJuIHRydWUgaWYgYW4gZXhjbHVzaXZl
IGxvY2sgZm9yIGRpcmVjdCBJTyB3cml0ZXMgaXMgbmVlZGVkCisgKiBAcmV0dXJuIHRydWUg
aWYgYW4gZXhjbHVzaXZlIGxvY2sgZm9yIGRpcmVjdCBJTyB3cml0ZXMgaXMgdGFrZW4sIGZh
bHNlCisgKgkgICBmb3IgdGhlIHNoYXJlZCBsb2NrCiAgKi8KLXN0YXRpYyBib29sIGZ1c2Vf
ZGlvX3dyX2V4Y2x1c2l2ZV9sb2NrKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9p
dGVyICpmcm9tKQorYm9vbCBmdXNlX2Rpb19sb2NrX2lub2RlKHN0cnVjdCBraW9jYiAqaW9j
Yiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQogewogCXN0cnVjdCBmaWxlICpmaWxlID0gaW9j
Yi0+a2lfZmlscDsKKwlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShpb2NiLT5r
aV9maWxwKTsKKwlzdHJ1Y3QgZnVzZV9pbm9kZSAqZmkgPSBnZXRfZnVzZV9pbm9kZShpbm9k
ZSk7CiAJc3RydWN0IGZ1c2VfZmlsZSAqZmYgPSBmaWxlLT5wcml2YXRlX2RhdGE7CisJc3Ry
dWN0IGZ1c2VfY29ubiAqZmMgPSBmZi0+Zm0tPmZjOwogCWJvb2wgZXhjbF9sb2NrID0gdHJ1
ZTsKKwlib29sIHJldGVzdCA9IGZhbHNlOworCWJvb2wgd2FrZSA9IGZhbHNlOwogCiAJLyog
c2VydmVyIHNpZGUgaGFzIHRvIGFkdmlzZSB0aGF0IGl0IHN1cHBvcnRzIHBhcmFsbGVsIGRp
byB3cml0ZXMgKi8KIAlpZiAoIShmZi0+b3Blbl9mbGFncyAmIEZPUEVOX1BBUkFMTEVMX0RJ
UkVDVF9XUklURVMpKQpAQCAtMTMyNCwxMyArMTM0NCw2NyBAQCBzdGF0aWMgYm9vbCBmdXNl
X2Rpb193cl9leGNsdXNpdmVfbG9jayhzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3Zf
aXRlciAqZnJvbQogCWlmIChpb2NiLT5raV9mbGFncyAmIElPQ0JfQVBQRU5EKQogCQlnb3Rv
IG91dDsKIAorcmV0ZXN0X3dpdGhfbG9jazoKIAkvKiBwYXJhbGxlbCBkaW8gYmV5b25kIGVv
ZiBpcyBhdCBsZWFzdCBmb3Igbm93IG5vdCBzdXBwb3J0ZWQgKi8KIAlpZiAoZnVzZV9pb19w
YXN0X2VvZihpb2NiLCBmcm9tKSkKIAkJZ290byBvdXQ7CiAKLQlleGNsX2xvY2sgPSBmYWxz
ZTsKKwkvKiBubyBuZWVkIHRvIG9wdGltaXplIGFzeW5jIHJlcXVlc3RzICovCisJaWYgKCFp
c19zeW5jX2tpb2NiKGlvY2IpICYmIGlvY2ItPmtpX2ZsYWdzICYgSU9DQl9ESVJFQ1QgJiYK
KwkgICAgZmMtPmFzeW5jX2RpbykKKwkJZ290byBvdXQ7CisKKwkvKiBJZiB0aGUgaW5vZGUg
ZXZlciBnb3QgcGFnZSB3cml0ZXMsIHdlIGRvIG5vdCBrbm93IGZvciBzdXJlCisJICogaW4g
dGhlIERJTyBwYXRoIGlmIHRoZXNlIGFyZSBwZW5kaW5nIC0gYSBzaGFyZWQgbG9jayBpcyB0
aGVuCisJICogbm90IHBvc3NpYmxlCisJICovCisJc3Bpbl9sb2NrKCZmaS0+bG9jayk7CisJ
aWYgKHRlc3RfYml0KEZVU0VfSV9DQUNIRV9JT19NT0RFLCAmZmktPnN0YXRlKSkgeworCQlp
ZiAocmV0ZXN0KSB7CisJCQlleGNsX2xvY2sgPSB0cnVlOworCQkJaWYgKC0tZmktPnNoYXJl
ZF9sb2NrX2RpcmVjdF9pb19jdHIgPT0gMCkKKwkJCQl3YWtlID0gdHJ1ZTsKKwkJfQorCX0g
ZWxzZSB7CisJCWlmICghcmV0ZXN0KSB7CisJCQlleGNsX2xvY2sgPSBmYWxzZTsKKwkJCS8q
IEluY3JlYXNlIHRoZSBjb3VudGVyIGFzIHNvb24gYXMgdGhlIGRlY2lzaW9uIGZvcgorCQkJ
ICogc2hhcmVkIGxvY2tzIHdhcyBtYWRlIHRvIGhvbGQgb2ZmIHBhZ2UgSU8gdGFza3MKKwkJ
CSAqLworCQkJaWYgKCFyZXRlc3QpCisJCQkJZmktPnNoYXJlZF9sb2NrX2RpcmVjdF9pb19j
dHIrKzsKKwkJfQorCX0KKwlzcGluX3VubG9jaygmZmktPmxvY2spOwogCiBvdXQ6CisJaWYg
KHJldGVzdCkgeworCQlpZiAoZXhjbF9sb2NrKSB7CisJCQkvKiBhIHJhY2UgaGFwcGVuZWQg
dGhlIGxvY2sgdHlwZSBuZWVkcyB0byBjaGFuZ2UgKi8KKwkJCWlub2RlX3VubG9ja19zaGFy
ZWQoaW5vZGUpOworCisJCQkvKiBJbmNyZWFzaW5nIHRoZSBzaGFyZWRfbG9ja19kaXJlY3Rf
aW9fY3RyIGNvdW50ZXIKKwkJCSAqICBtaWdodCBoYXZlIGhvbGQgb2ZmIHBhZ2UgY2FjaGUg
dGFza3MsIHdha2UgdGhlc2UgdXAuCisJCQkgKi8KKwkJCWlmICh3YWtlKQorCQkJCXdha2Vf
dXAoJmZpLT5kaXJlY3RfaW9fd2FpdHEpOworCisJCQlpbm9kZV9sb2NrKGlub2RlKTsKKwkJ
fQorCX0gZWxzZSB7CisJCWlmIChleGNsX2xvY2spIHsKKwkJCWlub2RlX2xvY2soaW5vZGUp
OworCQl9IGVsc2UgeworCQkJaW5vZGVfbG9ja19zaGFyZWQoaW5vZGUpOworCisJCQkvKiBO
ZWVkIHRvIHJldGVzdCBhZnRlciB0YWtlbiB0aGUgc2hhcmVkIGxvY2ssIHRvIHNlZQorCQkJ
ICogaWYgdGhlcmUgYXJlIHJhY2VzCisJCQkgKi8KKwkJCXJldGVzdCA9IHRydWU7CisJCQln
b3RvIHJldGVzdF93aXRoX2xvY2s7CisJCX0KKwl9CisKIAlyZXR1cm4gZXhjbF9sb2NrOwog
fQogCkBAIC0xNTk2LDMwICsxNjcwLDEyIEBAIHN0YXRpYyBzc2l6ZV90IGZ1c2VfZGlyZWN0
X3JlYWRfaXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqdG8pCiBz
dGF0aWMgc3NpemVfdCBmdXNlX2RpcmVjdF93cml0ZV9pdGVyKHN0cnVjdCBraW9jYiAqaW9j
Yiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQogewogCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBm
aWxlX2lub2RlKGlvY2ItPmtpX2ZpbHApOworCXN0cnVjdCBmdXNlX2lub2RlICpmaSA9IGdl
dF9mdXNlX2lub2RlKGlub2RlKTsKIAlzdHJ1Y3QgZnVzZV9pb19wcml2IGlvID0gRlVTRV9J
T19QUklWX1NZTkMoaW9jYik7CiAJc3NpemVfdCByZXM7Ci0JYm9vbCBleGNsdXNpdmVfbG9j
ayA9IGZ1c2VfZGlvX3dyX2V4Y2x1c2l2ZV9sb2NrKGlvY2IsIGZyb20pOwotCi0JLyoKLQkg
KiBUYWtlIGV4Y2x1c2l2ZSBsb2NrIGlmCi0JICogLSBQYXJhbGxlbCBkaXJlY3Qgd3JpdGVz
IGFyZSBkaXNhYmxlZCAtIGEgdXNlciBzcGFjZSBkZWNpc2lvbgotCSAqIC0gUGFyYWxsZWwg
ZGlyZWN0IHdyaXRlcyBhcmUgZW5hYmxlZCBhbmQgaV9zaXplIGlzIGJlaW5nIGV4dGVuZGVk
LgotCSAqICAgVGhpcyBtaWdodCBub3QgYmUgbmVlZGVkIGF0IGFsbCwgYnV0IG5lZWRzIGZ1
cnRoZXIgaW52ZXN0aWdhdGlvbi4KLQkgKi8KLQlpZiAoZXhjbHVzaXZlX2xvY2spCi0JCWlu
b2RlX2xvY2soaW5vZGUpOwotCWVsc2UgewotCQlpbm9kZV9sb2NrX3NoYXJlZChpbm9kZSk7
CiAKLQkJLyoKLQkJICogUHJldmlvdXMgY2hlY2sgd2FzIHdpdGhvdXQgYW55IGxvY2sgYW5k
IG1pZ2h0IGhhdmUgcmFjZWQuCi0JCSAqLwotCQlpZiAoZnVzZV9kaW9fd3JfZXhjbHVzaXZl
X2xvY2soaW9jYiwgZnJvbSkpIHsKLQkJCWlub2RlX3VubG9ja19zaGFyZWQoaW5vZGUpOwot
CQkJaW5vZGVfbG9jayhpbm9kZSk7Ci0JCQlleGNsdXNpdmVfbG9jayA9IHRydWU7Ci0JCX0K
LQl9CisJLyogdGFrZSBpbm9kZV9sb2NrIG9yIGlub2RlX2xvY2tfc2hhcmVkICovCisJYm9v
bCBleGNsdXNpdmUgPSBmdXNlX2Rpb19sb2NrX2lub2RlKGlvY2IsIGZyb20pOwogCiAJcmVz
ID0gZ2VuZXJpY193cml0ZV9jaGVja3MoaW9jYiwgZnJvbSk7CiAJaWYgKHJlcyA+IDApIHsK
QEAgLTE2MzEsMTAgKzE2ODcsMjAgQEAgc3RhdGljIHNzaXplX3QgZnVzZV9kaXJlY3Rfd3Jp
dGVfaXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSkKIAkJ
CWZ1c2Vfd3JpdGVfdXBkYXRlX2F0dHIoaW5vZGUsIGlvY2ItPmtpX3BvcywgcmVzKTsKIAkJ
fQogCX0KLQlpZiAoZXhjbHVzaXZlX2xvY2spCisKKwlpZiAoZXhjbHVzaXZlKQogCQlpbm9k
ZV91bmxvY2soaW5vZGUpOwotCWVsc2UKKwllbHNlIHsKKwkJYm9vbCB3YWtlID0gZmFsc2U7
CisKIAkJaW5vZGVfdW5sb2NrX3NoYXJlZChpbm9kZSk7CisJCXNwaW5fbG9jaygmZmktPmxv
Y2spOworCQlpZiAoLS1maS0+c2hhcmVkX2xvY2tfZGlyZWN0X2lvX2N0ciA9PSAwKQorCQkJ
d2FrZSA9IHRydWU7CisJCXNwaW5fdW5sb2NrKCZmaS0+bG9jayk7CisJCWlmICh3YWtlKQor
CQkJd2FrZV91cCgmZmktPmRpcmVjdF9pb193YWl0cSk7CisJfQogCiAJcmV0dXJuIHJlczsK
IH0KQEAgLTI0ODEsMTggKzI1NDcsMzUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVy
YXRpb25zX3N0cnVjdCBmdXNlX2ZpbGVfdm1fb3BzID0gewogc3RhdGljIGludCBmdXNlX2Zp
bGVfbW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEp
CiB7CiAJc3RydWN0IGZ1c2VfZmlsZSAqZmYgPSBmaWxlLT5wcml2YXRlX2RhdGE7CisJc3Ry
dWN0IGlub2RlICppbm9kZSA9IGZpbGVfaW5vZGUoZmlsZSk7CisJc3RydWN0IGZ1c2VfaW5v
ZGUgKmZpID0gZ2V0X2Z1c2VfaW5vZGUoaW5vZGUpOwogCXN0cnVjdCBmdXNlX2Nvbm4gKmZj
ID0gZmYtPmZtLT5mYzsKIAogCS8qIERBWCBtbWFwIGlzIHN1cGVyaW9yIHRvIGRpcmVjdF9p
byBtbWFwICovCi0JaWYgKEZVU0VfSVNfREFYKGZpbGVfaW5vZGUoZmlsZSkpKQorCWlmIChG
VVNFX0lTX0RBWChpbm9kZSkpCiAJCXJldHVybiBmdXNlX2RheF9tbWFwKGZpbGUsIHZtYSk7
CiAKIAlpZiAoZmYtPm9wZW5fZmxhZ3MgJiBGT1BFTl9ESVJFQ1RfSU8pIHsKLQkJLyogQ2Fu
J3QgcHJvdmlkZSB0aGUgY29oZXJlbmN5IG5lZWRlZCBmb3IgTUFQX1NIQVJFRAotCQkgKiBp
ZiBGVVNFX0RJUkVDVF9JT19SRUxBWCBpc24ndCBzZXQuCi0JCSAqLwotCQlpZiAoKHZtYS0+
dm1fZmxhZ3MgJiBWTV9NQVlTSEFSRSkgJiYgIWZjLT5kaXJlY3RfaW9fcmVsYXgpCi0JCQly
ZXR1cm4gLUVOT0RFVjsKKwkJaWYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9NQVlTSEFSRSkgewor
CQkJLyogQ2FuJ3QgcHJvdmlkZSB0aGUgY29oZXJlbmN5IG5lZWRlZCBmb3IgTUFQX1NIQVJF
RAorCQkJICogaWYgRlVTRV9ESVJFQ1RfSU9fUkVMQVggaXNuJ3Qgc2V0LgorCQkJICovCisJ
CQlpZiAoIWZjLT5kaXJlY3RfaW9fcmVsYXgpCisJCQkJcmV0dXJuIC1FTk9ERVY7CisKKwkJ
CWlmICh2bWEtPnZtX2ZsYWdzICYgVk1fTUFZV1JJVEUpIHsKKwkJCQlpZiAoIXRlc3RfYml0
KEZVU0VfSV9DQUNIRV9JT19NT0RFLCAmZmktPnN0YXRlKSkKKwkJCQkJc2V0X2JpdChGVVNF
X0lfQ0FDSEVfSU9fTU9ERSwgJmZpLT5zdGF0ZSk7CisKKwkJCQkvKiBkaXJlY3QtaW8gd2l0
aCBzaGFyZWQgbG9ja3MgY2Fubm90IGhhbmRsZQorCQkJCSAqIHBhZ2UgY2FjaGUgaW8gLSB3
YWl0IHVudGlsIGl0IGlzIGRvbmUKKwkJCQkgKi8KKwkJCQlpZiAoZmktPnNoYXJlZF9sb2Nr
X2RpcmVjdF9pb19jdHIgIT0gMCkgeworCQkJCQl3YWl0X2V2ZW50KGZpLT5kaXJlY3RfaW9f
d2FpdHEsCisJCQkJCQkgICBSRUFEX09OQ0UoZmktPnNoYXJlZF9sb2NrX2RpcmVjdF9pb19j
dHIpID09IDApOworCQkJCX0KKwkJCX0KKwkJfQogCiAJCWludmFsaWRhdGVfaW5vZGVfcGFn
ZXMyKGZpbGUtPmZfbWFwcGluZyk7CiAKQEAgLTMyNjUsNyArMzM0OCw5IEBAIHZvaWQgZnVz
ZV9pbml0X2ZpbGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgaW50IGZs
YWdzKQogCUlOSVRfTElTVF9IRUFEKCZmaS0+d3JpdGVfZmlsZXMpOwogCUlOSVRfTElTVF9I
RUFEKCZmaS0+cXVldWVkX3dyaXRlcyk7CiAJZmktPndyaXRlY3RyID0gMDsKKwlmaS0+c2hh
cmVkX2xvY2tfZGlyZWN0X2lvX2N0ciA9IDA7CiAJaW5pdF93YWl0cXVldWVfaGVhZCgmZmkt
PnBhZ2Vfd2FpdHEpOworCWluaXRfd2FpdHF1ZXVlX2hlYWQoJmZpLT5kaXJlY3RfaW9fd2Fp
dHEpOwogCWZpLT53cml0ZXBhZ2VzID0gUkJfUk9PVDsKIAogCWlmIChJU19FTkFCTEVEKENP
TkZJR19GVVNFX0RBWCkpCmRpZmYgLS1naXQgYS9mcy9mdXNlL2Z1c2VfaS5oIGIvZnMvZnVz
ZS9mdXNlX2kuaAppbmRleCA2ZTZlNzIxZjQyMWIuLjI3NzUwMjUxZDBlNSAxMDA2NDQKLS0t
IGEvZnMvZnVzZS9mdXNlX2kuaAorKysgYi9mcy9mdXNlL2Z1c2VfaS5oCkBAIC04NCw2ICs4
NCw5IEBAIHN0cnVjdCBmdXNlX2lub2RlIHsKIAkvKiBXaGljaCBhdHRyaWJ1dGVzIGFyZSBp
bnZhbGlkICovCiAJdTMyIGludmFsX21hc2s7CiAKKwkvKiBudW1iZXIgb2Ygb3BlbmVkIGZp
bGVzIGJ5IHRoaXMgaW5vZGUgKi8KKwl1MzIgb3Blbl9jdHI7CisKIAkvKiogVGhlIHN0aWNr
eSBiaXQgaW4gaW5vZGUtPmlfbW9kZSBtYXkgaGF2ZSBiZWVuIHJlbW92ZWQsIHNvCiAJICAg
IHByZXNlcnZlIHRoZSBvcmlnaW5hbCBtb2RlICovCiAJdW1vZGVfdCBvcmlnX2lfbW9kZTsK
QEAgLTExMCwxMSArMTEzLDE3IEBAIHN0cnVjdCBmdXNlX2lub2RlIHsKIAkJCSAqIChGVVNF
X05PV1JJVEUpIG1lYW5zIG1vcmUgd3JpdGVzIGFyZSBibG9ja2VkICovCiAJCQlpbnQgd3Jp
dGVjdHI7CiAKKwkJCS8qIGNvdW50ZXIgb2YgdGFza3Mgd2l0aCBzaGFyZWQgbG9jayBkaXJl
Y3QtaW8gd3JpdGVzICovCisJCQlpbnQgc2hhcmVkX2xvY2tfZGlyZWN0X2lvX2N0cjsKKwog
CQkJLyogV2FpdHEgZm9yIHdyaXRlcGFnZSBjb21wbGV0aW9uICovCiAJCQl3YWl0X3F1ZXVl
X2hlYWRfdCBwYWdlX3dhaXRxOwogCiAJCQkvKiBMaXN0IG9mIHdyaXRlcGFnZSByZXF1ZXN0
c3QgKHBlbmRpbmcgb3Igc2VudCkgKi8KIAkJCXN0cnVjdCByYl9yb290IHdyaXRlcGFnZXM7
CisKKwkJCS8qIHdhaXRxIGZvciBkaXJlY3QtaW8gY29tcGxldGlvbiAqLworCQkJd2FpdF9x
dWV1ZV9oZWFkX3QgZGlyZWN0X2lvX3dhaXRxOwogCQl9OwogCiAJCS8qIHJlYWRkaXIgY2Fj
aGUgKGRpcmVjdG9yeSBvbmx5KSAqLwpAQCAtMTcyLDYgKzE4MSw5IEBAIGVudW0gewogCUZV
U0VfSV9CQUQsCiAJLyogSGFzIGJ0aW1lICovCiAJRlVTRV9JX0JUSU1FLAorCS8qIEhhcyBw
YWdlIGNhY2hlIElPICovCisJRlVTRV9JX0NBQ0hFX0lPX01PREUsCisKIH07CiAKIHN0cnVj
dCBmdXNlX2Nvbm47CmRpZmYgLS1naXQgYS9mcy9mdXNlL2lub2RlLmMgYi9mcy9mdXNlL2lu
b2RlLmMKaW5kZXggNzRkNGYwOWQ1ODI3Li4zMTFkMWVkNzNmYjcgMTAwNjQ0Ci0tLSBhL2Zz
L2Z1c2UvaW5vZGUuYworKysgYi9mcy9mdXNlL2lub2RlLmMKQEAgLTgzLDYgKzgzLDcgQEAg
c3RhdGljIHN0cnVjdCBpbm9kZSAqZnVzZV9hbGxvY19pbm9kZShzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiKQogCWZpLT5hdHRyX3ZlcnNpb24gPSAwOwogCWZpLT5vcmlnX2lubyA9IDA7CiAJ
ZmktPnN0YXRlID0gMDsKKwlmaS0+b3Blbl9jdHIgPSAwOwogCW11dGV4X2luaXQoJmZpLT5t
dXRleCk7CiAJc3Bpbl9sb2NrX2luaXQoJmZpLT5sb2NrKTsKIAlmaS0+Zm9yZ2V0ID0gZnVz
ZV9hbGxvY19mb3JnZXQoKTsK

--------------0C07c0uviFxx0deBMx0CzaTQ--

