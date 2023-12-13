Return-Path: <linux-fsdevel+bounces-5900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE48811449
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EBB3B211D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF7F2E82F;
	Wed, 13 Dec 2023 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="FVXoFp2F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2nqhhDcJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A61810C
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 06:09:14 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id C2D965C053E;
	Wed, 13 Dec 2023 09:09:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 13 Dec 2023 09:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1702476551;
	 x=1702562951; bh=oRIpq2PR/OV+2jBeTstR8zLGl0nQF6vG4CgeXTGaLug=; b=
	FVXoFp2FBa6aDtsdppgdqpPfGxKKEYzy4A49W1GpRiakgoe37KK2vaoHd1G22dzQ
	rs9c24O+b7NcRFla54PODyMjWaNZo084an6tcI/CCf0443CJUiqn2BfZQ9AgXsdV
	pMm1HIp5zidiXMZrx9TomEuuZj2+GZTGKYvHPEWTkjWMjAdVfrIt7SS4XNgl59Is
	M21Ia+KSVsrGz94YB1jJuBpYohYCsHcRfxNHK5S3Po8r3BbKNtbLsOqXcPzLW9Jt
	gF1V/z8Z/rZ+QzzIVEK8VUsq3+kwicWlMBIxpjvSsK2hcVf1MO3ptNM4zM6toUHG
	1R0im2MdSnjEBHvMF9DXPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702476551; x=
	1702562951; bh=oRIpq2PR/OV+2jBeTstR8zLGl0nQF6vG4CgeXTGaLug=; b=2
	nqhhDcJiHgP2ZdUvtsoegpTnSf6KQYKQGydvEMHriGlSs/m0xhEyexVz+S3+eXQz
	Zt2EcARnfN4WFza+26YqNCH5NuaSv1TE1C21UZZWyNsma+i9rid6z1Nt/aYlfUqB
	K1MnYw2XZhGPdZPyzRYKOn6OUqmo7id3m7ZmAWOf44T/ZYOVsz2j+lBIXqa4yiF4
	qZctkqlJXyrAOlKFRjah3b6YKGmOkPlGbcnuhDggTxUxQgr2I3zctw206BcqFBbx
	VRD3WQZAHqoYM1hgNoFL0nV8x0QjVSkn700hcteg0ioxzsGpbfesAeBZf9AP5dub
	nc1RqZYhCRe+TpvkysWwQ==
X-ME-Sender: <xms:Bbt5ZY07ThHpiBLmvXy6nTYw2oPLkXCtgEzXHkoiV7QuibDm-dv97Q>
    <xme:Bbt5ZTElwhuEKDjPMlnASxr39x2iq4IH3XnQ9xstabhFSX59Z7-A8Sc7pI8YPUsV5
    70dUXNSuO2FA9wc>
X-ME-Received: <xmr:Bbt5ZQ40oP366-wtpTzYvhXxrAuJlDaWxHt69dQ8eV6TeMgMsANNK8kZO55hS54DsjyukdEFoukgP899k34-nYHwl2zo7cuM6JfaRYGsRHMvObaNaJYV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeljecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuhffvvehfjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfh
    hmqeenucggtffrrghtthgvrhhnpedvhfefteefjeefhfdthefftedtvefguedtueefgeeh
    ffekuedvjeeihedvjeefgfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgt
    hhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:Bbt5ZR0qxlElAt5iHLqzJV0Kqssd6uuxz4yQnLqb-1S5Pq2ruufpyQ>
    <xmx:Bbt5ZbHANRAigw3DsG1SQUbGzx6xFS4JlUfgRVunj-31px8yxH2Qxw>
    <xmx:Bbt5Za-tFNR5eSQnRy8INxpDauMLc6aZeyJH2MKeN4khfGthCQGHqw>
    <xmx:B7t5Za1dM73cxeB70y3etsbx2pTmes7luih-ylrg466fFdRrUPKKuA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 09:09:08 -0500 (EST)
Message-ID: <bdfc743b-324c-4f31-b7df-dc3fd598b597@fastmail.fm>
Date: Wed, 13 Dec 2023 15:09:07 +0100
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
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, gmaglione@redhat.com,
 Max Reitz <hreitz@redhat.com>, Hao Xu <howeyxu@tencent.com>,
 Dharmendra Singh <dsingh@ddn.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
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
 <2e2f0cd1-99fe-4336-9cc8-47416be02451@fastmail.fm>
 <CAOQ4uxh=aBFEiBVBErEA_d+mWcTOysLgbgWVztSzL+D2BvMLdA@mail.gmail.com>
 <b48f7aae-cd84-4f7d-a898-f3552f1195ae@fastmail.fm>
 <CAOQ4uxjnSkZwgQNQTLiLK+juWKNo+ecVPcxm7ZPzPPZCxh0A0w@mail.gmail.com>
 <524bceb8-0d27-4223-a715-576efdc7f74c@fastmail.fm>
Content-Language: en-US, de-DE
In-Reply-To: <524bceb8-0d27-4223-a715-576efdc7f74c@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/13/23 14:03, Bernd Schubert wrote:
> 
> 
> On 12/13/23 12:23, Amir Goldstein wrote:
>>>>
>>>>      Thanks Amir, I'm going to look at it in detail in the morning.
>>>>      Btw, there is another bad direct_io_allow_mmap issue (part of 
>>>> it is
>>>>      invalidate_inode_pages2, which you already noticed, but not 
>>>> alone).
>>>>      Going to send out the patch once xfstests have passed
>>>>      
>>>> https://github.com/bsbernd/linux/commit/3dae6b05854c4fe84302889a5625c7e5428cdd6c <https://github.com/bsbernd/linux/commit/3dae6b05854c4fe84302889a5625c7e5428cdd6c>
>>>>
>>>>
>>>> Nice!
>>>> But I think that invalidate pages issue is not restricted to shared 
>>>> mmap?
>>>
>>> So history for that is
>>>
>>> commit 3121bfe7631126d1b13064855ac2cfa164381bb0
>>> Author: Miklos Szeredi <mszeredi@suse.cz>
>>> Date:   Thu Apr 9 17:37:53 2009 +0200
>>>
>>>       fuse: fix "direct_io" private mmap
>>>
>>>       MAP_PRIVATE mmap could return stale data from the cache for
>>>       "direct_io" files.  Fix this by flushing the cache on mmap.
>>>
>>>       Found with a slightly modified fsx-linux.
>>>
>>>       Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index 0946861b10b7..06f30e965676 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -1298,6 +1298,8 @@ static int fuse_direct_mmap(struct file *file, 
>>> struct vm_area_struct *vma)
>>>           if (vma->vm_flags & VM_MAYSHARE)
>>>                   return -ENODEV;
>>>
>>> +       invalidate_inode_pages2(file->f_mapping);
>>> +
>>>           return generic_file_mmap(file, vma);
>>>    }
>>>
>>>
>>> I don't have a strong opinion here - so idea of this patch is to avoid
>>> exposing stale data from a previous mmap. I guess (and probably hard 
>>> to achieve
>>> semantics) would be to invalidate pages when the last mapping of that 
>>> _area_
>>> is done?
>>> So now with a shared map, data are supposed to be stored in files and
>>> close-to-open consistency with FOPEN_KEEP_CACHE should handle the 
>>> invalidation?
>>>
>>
>> Nevermind, it was just my bad understanding of invalidate_inode_pages2().
>> I think it calls fuse_launder_folio() for dirty pages, so data loss is
>> not a concern.
>>
>>>>
>>>> I think that the mix of direct io file with private mmap is common and
>>>> doesn't have issues, but the mix of direct io files and caching 
>>>> files on
>>>> the same inode is probably not very common has the same issues as the
>>>> direct_io_allow_mmap regression that you are fixing.
>>>
>>> Yeah. I also find it interesting that generic_file_mmap is not doing 
>>> such
>>> things for files opened with O_DIRECT - FOPEN_DIRECT_IO tries to do
>>> strong coherency?
>>>
>>>
>>> I'm going to send out the patch for now as it is, as that might 
>>> become a longer
>>> discussion - maybe Miklos could comment on it.
>>>
>>
>> I think your patch should not be avoiding invalidate_inode_pages2()
>> in the shared mmap case.
>>
>> You have done that part because of my comment which was wrong,
>> not because it reproduced a bug.
> 
> I debating with myself since yesterday, where invalidate_inode_pages2() 
> belongs to.
> 
> We have
> 
> FOPEN_KEEP_CACHE - if not set invalidate_inode_pages2 is done by 
> fuse_open_common().  If set, server side signals that it wants to keep 
> the cache. Also interesting, I don't see anything that prevents that 
> FOPEN_DIRECT_IO and FOPEN_KEEP_CACHE are set together.
> Also to consider, fc->_no_open sets FOPEN_KEEP_CACHE by default.
> 
> MAP_PRIVATE - here I'm sure that invalidate_inode_pages2 is right, even 
> with FOPEN_KEEP_CACHE. There is also zero risk to lose data, as 
> MAP_PRIVATE does not write out data.
> 
> MAP_SHARED - was not allowed with FOPEN_DIRECT_IO before. Unless 
> FOPEN_KEEP_CACHE is set, close-to-open semantics come in. My argument to 
> to avoid invalidate_inode_pages2 in the current patch is that MAP_SHARED 
> wants to share data between processes. And also maybe important, there 
> is no flush in that function - dirty pages would be thrown away - data 
> corruption!?


Ah sorry, I had actually missed folio_launder() -> fuse_launder_folio(), 
ok fine then, we can keep it for both cases.

