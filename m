Return-Path: <linux-fsdevel+bounces-6523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02F48191AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 21:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7064C2875F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 20:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940583D0A4;
	Tue, 19 Dec 2023 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="JNPqC36i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D4Lh3cSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D823D0A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D7C905C01D8;
	Tue, 19 Dec 2023 15:47:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 19 Dec 2023 15:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703018832; x=1703105232; bh=eqQyTLjhtq
	lvMvzyccCO8GBclVXSsnJWw05FhZXyeKs=; b=JNPqC36iicgjG08ViZRfWxhibF
	1akzVc7sc7pNj1aKDG0oCO+7NU8WKxNbsBcz8RsUGk4tSzvdNsax8o4Wz2bGavoO
	0vr5knTrngKo0cDTz4Ib4REbBfYDkZWSj05VDuytioIwHVKhgpfXhUDIsTVf3EBp
	ynGwfOfgaafeArc6cywW2JdHkruFHYPPn3/SfD/spo8HxF4bQ+Zi8LOmzNyyu3pD
	5gyQYinOtO5wkhX0NZ1l/lCJjsvzavPEoxQiskpQqcNUvlhESShCN+SGGs/pP6lX
	JlozYMR35ohSVCL+A1AYp3wDvQzA+5zVXxfR30GxO633QUMC2gaL+04WjV6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703018832; x=1703105232; bh=eqQyTLjhtqlvMvzyccCO8GBclVXS
	snJWw05FhZXyeKs=; b=D4Lh3cSjBtc1xE/DfvHeg+DmbtudGS6XPNdNSFv1oKcu
	oCqj6cx7KIybxjLSk4dZlldFcsDtymQ4POgUoqx8u61/eKGGTZRD8ZwbFU866rNp
	nXoFM581/7XQcUYajZTjPsez1dUe4lkHTjzvwvD4SbYlK33s5opNXYrGEc0mRT8w
	6HUqK/1gH2rJQmWUqiqx6ywpl8oqOpchPFm4vio8s/slKbaGpoaYXI69hMmB1q6J
	Nqzy6FBtVdeYf3w/6OUuBo3pN/yg1vkufI7eg1O7rpuwhCiON69cQi8dV0E3Z12M
	YjYyAPVNHRSb+iEzEOXaTNaNBwPGbaTSX+c0fQWuWQ==
X-ME-Sender: <xms:UAGCZSsfj-OOcV8lZgCAl8TUdR1BTKs4rl6L1fb_ADv5AGG27OjzhA>
    <xme:UAGCZXcDi8cK4akjYiXCOq8I6TceaDdwp44pCgPLuhmt29aFKNgvVUHSDBEz_ybuv
    8Ppmh-FhkD1oQJ5>
X-ME-Received: <xmr:UAGCZdy7YTZxSjP6GsJDDmGujQaCrGQaAphjfjOu77QZ0746cekKMxrcHq2KoPCkSDd-AcrQAGpv429dqVw-UxIhRRpL1tPZ28iJ229bSmtmPqw3SKGc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddutddgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtkfffgggfuffvvehfhfgjsehmtderredtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeejkeekvefgvdduvefgveejteelhfefvefh
    keekudetgfekffehjeeftddugffgnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:UAGCZdMQGDL8unYLYteaCjxENOs_pcsxuRapH0ZjJALMXabFHBtgmg>
    <xmx:UAGCZS-AJKx5WnGznF0jIOZnIrUkFEfrnI_COlYJFHWCNsAbmVztaw>
    <xmx:UAGCZVVq74TM6B1h6PV78FzowPCA_MjnPtq3wxXanxpkgHUck2cnYQ>
    <xmx:UAGCZXNZqOQh4PW3XdyKganJOIj3d3O-FE8q0HhuaDjzDcSRDIuyZg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 15:47:10 -0500 (EST)
Content-Type: multipart/mixed; boundary="------------Hcp2NvYrtSDFXS4JJRtzYmrW"
Message-ID: <9d3c1c2b-53c0-4f1d-b4c0-567b23d19719@fastmail.fm>
Date: Tue, 19 Dec 2023 21:47:09 +0100
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
 <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
 <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
 <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm>
 <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
 <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
 <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm>
 <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
 <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm>
 <CAOQ4uxjKbQkqTHb9_3kqRW7BPPzwNj--4=kqsyq=7+ztLrwXfw@mail.gmail.com>
 <6e9e8ff6-1314-4c60-bf69-6d147958cf95@fastmail.fm>
 <CAOQ4uxiJfcZLvkKZxp11aAT8xa7Nxf_kG4CG1Ft2iKcippOQXg@mail.gmail.com>
 <06eedc60-e66b-45d1-a936-2a0bb0ac91c7@fastmail.fm>
 <CAOQ4uxhRbKz7WvYKbjGNo7P7m+00KLW25eBpqVTyUq2sSY6Vmw@mail.gmail.com>
 <7c588ab3-246f-4d9d-9b84-225dedab690a@fastmail.fm>
 <CAOQ4uxgb2J8zppKg63UV88+SNbZ+2=XegVBSXOFf=3xAVc1U3Q@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxgb2J8zppKg63UV88+SNbZ+2=XegVBSXOFf=3xAVc1U3Q@mail.gmail.com>

This is a multi-part message in MIME format.
--------------Hcp2NvYrtSDFXS4JJRtzYmrW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/23 14:01, Amir Goldstein wrote:
>>> Here is what I was thinking about:
>>>
>>> https://github.com/amir73il/linux/commits/fuse_io_mode
>>>
>>> The concept that I wanted to introduce was the
>>> fuse_inode_deny_io_cache()/fuse_inode_allow_io_cache()
>>> helpers (akin to deny_write_access()/allow_write_access()).
>>>
>>> In this patch, parallel dio in progress deny open in caching mode
>>> and mmap, and I don't know if that is acceptable.
>>> Technically, instead of deny open/mmap you can use additional
>>> techniques to wait for in progress dio and allow caching open/mmap.
>>>
>>> Anyway, I plan to use the iocachectr and fuse_inode_deny_io_cache()
>>> pattern when file is open in FOPEN_PASSTHROUGH mode, but
>>> in this case, as agreed with Miklos, a server trying to mix open
>>> in caching mode on the same inode is going to fail the open.
>>>
>>> mmap is less of a problem for inode in passthrough mode, because
>>> mmap in of direct_io file and inode in passthrough mode is passthrough
>>> mmap to backing file.
>>>
>>> Anyway, if you can use this patch or parts of it, be my guest and if you
>>> want to use a different approach that is fine by me as well - in that case
>>> I will just remove the fuse_file_shared_dio_{start,end}() part from my patch.
>>
>> Hi Amir,
>>
>> here is my fuse-dio-v5 branch:
>> https://github.com/bsbernd/linux/commits/fuse-dio-v5/
>>
>> (v5 is just compilation tested, tests are running now over night)
> 
> This looks very nice!
> I left comments about some minor nits on github.
> 
>>
>> This branch is basically about consolidating fuse write direct IO code
>> paths and to allow a shared lock for O_DIRECT. I actually could have
>> noticed the page cache issue with shared locks before with previous
>> versions of these patches, just my VM kernel is optimized for
>> compilation time and some SHM options had been missing - with that fio
>> refused to run.
>>
>> The branch includes a modified version of your patch:
>> https://github.com/bsbernd/linux/commit/6b05e52f7e253d9347d97de675b21b1707d6456e
>>
>> Main changes are
>> - fuse_file_io_open() does not set the FOPEN_CACHE_IO flag for
>> file->f_flags & O_DIRECT
>> - fuse_file_io_mmap() waits on a dio waitq
>> - fuse_file_shared_dio_start / fuse_file_shared_dio_end are moved up in
>> the file, as I would like to entirely remove the fuse_direct_write iter
>> function (all goes through cache_write_iter)
>>
> 
> Looks mostly good, but I think that fuse_file_shared_dio_start() =>
> fuse_inode_deny_io_cache() should actually be done after taking
> the inode lock (shared or exclusive) and not like in my patch.
> 
> First of all, this comment in fuse_dio_wr_exclusive_lock():
> 
>          /*
>           * fuse_file_shared_dio_start() must not be called on retest,
>           * as it decreases a counter value - must not be done twice
>           */
>          if (!fuse_file_shared_dio_start(inode))
>                  return true;
> 
> ...is suggesting that semantics are not clean and this check
> must remain last, because if fuse_dio_wr_exclusive_lock()
> returns false, iocachectr must not be elevated.
> This is easy to get wrong in the future with current semantics.
> 
> The more important thing is that while fuse_file_io_mmap()
> is waiting for iocachectr to drop to zero, new parallel dio can
> come in and starve the mmap() caller forever.
> 
> I think that we are going to need to use some inode state flag
> (e.g. FUSE_I_DIO_WR_EXCL) to protect against this starvation,
> unless we do not care about this possibility?
> We'd only need to set this in fuse_file_io_mmap() until we get
> the iocachectr refcount.
> 
> I *think* that fuse_inode_deny_io_cache() should be called with
> shared inode lock held, because of the existing lock chain
> i_rwsem -> page lock -> mmap_lock for page faults, but I am
> not sure. My brain is too cooked now to figure this out.
> OTOH, I don't see any problem with calling
> fuse_inode_deny_io_cache() with shared lock held?
> 
> I pushed this version to my fuse_io_mode branch [1].
> Only tested generic/095 with FOPEN_DIRECT_IO and
> DIRECT_IO_ALLOW_MMAP.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/linux/commits/fuse_io_mode

Thanks, will look into your changes next. I was looking into the initial 
issue with generic/095 with my branch. Fixed by the attached patch. I 
think it is generic and also applies to FOPEN_DIRECT_IO + mmap.
Interesting is that filemap_range_has_writeback() is exported, but there
was no user. Hopefully nobody submits an unexport patch in the mean time.


Thanks,
Bernd
--------------Hcp2NvYrtSDFXS4JJRtzYmrW
Content-Type: text/x-patch; charset=UTF-8; name="dirty-pages.patch"
Content-Disposition: attachment; filename="dirty-pages.patch"
Content-Transfer-Encoding: base64

Y29tbWl0IGJjZTY2YmY0YjBiNWQ4Y2JlZWIwNmVmMzU1MGFiNGUwMjQ3N2YzZTQKQXV0aG9y
OiBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+CkRhdGU6ICAgVHVlIERlYyAx
OSAyMDozNjoxMCAyMDIzICswMTAwCgogICAgZGlydHkgcGFnZXMKCmRpZmYgLS1naXQgYS9m
cy9mdXNlL2ZpbGUuYyBiL2ZzL2Z1c2UvZmlsZS5jCmluZGV4IDFmZDNiYTU3YWNjYzguLjI2
YjEzMTI4YjFlMjkgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZmlsZS5jCisrKyBiL2ZzL2Z1c2Uv
ZmlsZS5jCkBAIC01MDMsNiArNTAzLDE5IEBAIHN0YXRpYyBzdHJ1Y3QgZnVzZV93cml0ZXBh
Z2VfYXJncyAqZnVzZV9maW5kX3dyaXRlYmFjayhzdHJ1Y3QgZnVzZV9pbm9kZSAqZmksCiAJ
cmV0dXJuIE5VTEw7CiB9CiAKK3N0YXRpYyBib29sIGZ1c2VfaW5vZGVfaGFzX3dyaXRlYmFj
ayhzdHJ1Y3QgaW5vZGUgKmlub2RlKQoreworCXN0cnVjdCBmdXNlX2lub2RlICpmaSA9IGdl
dF9mdXNlX2lub2RlKGlub2RlKTsKKwlzdHJ1Y3QgZnVzZV93cml0ZXBhZ2VfYXJncyAqd3Bh
OworCisJc3Bpbl9sb2NrKCZmaS0+bG9jayk7CisJd3BhID0gcmJfZW50cnkoZmktPndyaXRl
cGFnZXMucmJfbm9kZSwKKwkJICAgICAgIHN0cnVjdCBmdXNlX3dyaXRlcGFnZV9hcmdzLCB3
cml0ZXBhZ2VzX2VudHJ5KTsKKwlzcGluX3VubG9jaygmZmktPmxvY2spOworCisJcmV0dXJu
IHdwYSAhPSBOVUxMOworfQorCiAvKgogICogQ2hlY2sgaWYgYW55IHBhZ2UgaW4gYSByYW5n
ZSBpcyB1bmRlciB3cml0ZWJhY2sKICAqCkBAIC0xNDQ5LDggKzE0NjIsMTggQEAgc3RhdGlj
IGJvb2wgZnVzZV9kaW9fd3JfZXhjbHVzaXZlX2xvY2soc3RydWN0IGtpb2NiICppb2NiLCBz
dHJ1Y3QgaW92X2l0ZXIgKmZyb20KIAkvKiBmdXNlX2ZpbGVfc2hhcmVkX2Rpb19zdGFydCgp
IG11c3Qgbm90IGJlIGNhbGxlZCBvbiByZXRlc3QsCiAJICogYXMgaXQgZGVjcmVhc2VzIGEg
Y291bnRlciB2YWx1ZSAtIG11c3Qgbm90IGJlIGRvbmUgdHdpY2UKIAkgKi8KLQlpZiAoIWZ1
c2VfZmlsZV9zaGFyZWRfZGlvX3N0YXJ0KGlub2RlKSkKKwlpZiAoIWZ1c2VfZmlsZV9zaGFy
ZWRfZGlvX3N0YXJ0KGlub2RlKSkgewogCQlyZXR1cm4gdHJ1ZTsKKwl9IGVsc2UgeworCQkv
KiB3ZSBzdWNjZWVkZWQgdG8gZW5hYmxlIHNoYXJlZCBkaW8sIGJ1dCB0aGVyZSBzdGlsbCBt
aWdodCBiZQorCQkgKiBkaXJ0eSBwYWdlcworCQkgKi8KKwkJaWYgKGZpbGVtYXBfcmFuZ2Vf
aGFzX3dyaXRlYmFjayhmaWxlLT5mX21hcHBpbmcsIDAsIExMT05HX01BWCkgfHwKKwkJICAg
IGZ1c2VfaW5vZGVfaGFzX3dyaXRlYmFjayhpbm9kZSkpIHsKKwkJCWZ1c2VfZmlsZV9zaGFy
ZWRfZGlvX2VuZChpbm9kZSk7CisJCQlyZXR1cm4gdHJ1ZTsKKwkJfQorCX0KIAogCXJldHVy
biBmYWxzZTsKIH0KQEAgLTE0NzIsNiArMTQ5NSw3IEBAIHN0YXRpYyB2b2lkIGZ1c2VfZGlv
X2xvY2soc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20sCiAJCWlu
b2RlX2xvY2soaW5vZGUpOwogCX0gZWxzZSB7CiAJCWlub2RlX2xvY2tfc2hhcmVkKGlub2Rl
KTsKKwogCQkvKgogCQkgKiBQcmV2aW91cyBjaGVjayB3YXMgd2l0aG91dCBpbm9kZSBsb2Nr
IGFuZCBtaWdodCBoYXZlIHJhY2VkLAogCQkgKiBjaGVjayBhZ2Fpbi4K

--------------Hcp2NvYrtSDFXS4JJRtzYmrW--

