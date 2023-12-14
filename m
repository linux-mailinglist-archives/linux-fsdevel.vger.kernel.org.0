Return-Path: <linux-fsdevel+bounces-6052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A74A812F66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 12:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E1B2830FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 11:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B707405E5;
	Thu, 14 Dec 2023 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="jr5XXa+9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XzZNCHmr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9C2BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 03:50:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4299F5C02AA;
	Thu, 14 Dec 2023 06:50:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 14 Dec 2023 06:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1702554652;
	 x=1702641052; bh=sn5Kzffjt6+tz+CWBStcZ0vwOHGS3pffxyVgrMBqbdA=; b=
	jr5XXa+9SyWeNsr/AnHVE9P6kvY28/ZfJu/lZzRN/T2oZgLzVgFNDDXQZCJGWbD/
	TdPlvmpJZw+7iMGy12453o7c4FlKTyVntIDmE3YJOlY9HyfGgVeGpmUi596xXFVz
	vBD+PhieNVoNEYAtXGXRfeVahwgvFM2hnRjO1V5ePC2uXLmXg/vjX4VFk+S0Ih9F
	NlElzJE/Ckip7NKaQE4jwN5qlZbdVEBbUV9XLbR1cfU+/ti6f7XTHVFvnyzTWbrL
	R78EI5lIe208WkjZaDFW6i0dUzlEcBhFV/hE1Qfuort1v2zgROlKPb6V+5TEIWJw
	9pzxDCY02/V0qhbz+LObvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702554652; x=
	1702641052; bh=sn5Kzffjt6+tz+CWBStcZ0vwOHGS3pffxyVgrMBqbdA=; b=X
	zZNCHmr+bc1hg5TkraWz0Yd1MNLop/iKViYAddTPk2og6m1NKeGrTUQvdsOUpn5Q
	/wG1QEo7F9MAKBTP213i+gf5Swd32NHkYKqyCX/9tSqDIzHV8F/gKMlHcRhhEXkC
	XHQx74pj5p4bR9Bw5u89uJ+qzf8FC7rlN7c1T6MscZZQd2ilF0t6pTpIYhiw2/JZ
	dJmtAJgh5F824UggEFct+fRNL1SYsCzI1VdbDbBN4q6sHuM092wr2o0mlW8u8fL5
	U96cF9TR8aifHMQK96bPm9A8IY/8WSLhNe4FyW/tds497nVqGMfslxh6rqp67DiK
	putywe8Tt7PJheapMtCbg==
X-ME-Sender: <xms:G-x6Zbsx9EDBQGKtKICiTIACmh06yfwvReVyh4xPmQLKOjfrVCSfKg>
    <xme:G-x6ZcdKAVeIe2wN2Dw9DeXAm9wiQikbkxiuEoIGwkUUrY4Itu4GspR3FM5kYmmHM
    ClVIiL4Oq0wcFvr>
X-ME-Received: <xmr:G-x6Zez4j61B_N5DV67dFB1d1WzvwKiqBqyCTH5WXGlGXJCFfKq9kYvZOY6_-vSm6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvdfhfeetfeejfefhtdehffettdevgfeutdeu
    feegheffkeeuvdejieehvdejfefgnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:G-x6ZaNwZKajITvdE500-OUzBVtobtfXnvj7D4xIPzvc5ZnLQty0mQ>
    <xmx:G-x6Zb8rfoIB2DP_a9ZGJJu2Sjyj79lmePfWJ26c25sAya3J3gvPMA>
    <xmx:G-x6ZaXWAGJbaVvZCOy9YCTBogL9K8Cfry1gDqi17Wb6I29kADPv1w>
    <xmx:HOx6ZXT0HrQfHDBB5FWoe2vaeT5lGyZ-uSDYvcuiCMCOzIPvkO5wgg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 06:50:50 -0500 (EST)
Message-ID: <987b9c73-d897-4818-b4be-8f01565f6ffa@fastmail.fm>
Date: Thu, 14 Dec 2023 12:50:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
Content-Language: en-US
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, gmaglione@redhat.com,
 Max Reitz <hreitz@redhat.com>, Hao Xu <howeyxu@tencent.com>,
 Dharmendra Singh <dsingh@ddn.com>, Matthew Wilcox <willy@infradead.org>
References: <20230920024001.493477-1-tfanelli@redhat.com>
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
 <bdfc743b-324c-4f31-b7df-dc3fd598b597@fastmail.fm>
In-Reply-To: <bdfc743b-324c-4f31-b7df-dc3fd598b597@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/13/23 15:09, Bernd Schubert wrote:
> 
> 
> On 12/13/23 14:03, Bernd Schubert wrote:
>>
>>
>> On 12/13/23 12:23, Amir Goldstein wrote:
>>>>>
>>>>>      Thanks Amir, I'm going to look at it in detail in the morning.
>>>>>      Btw, there is another bad direct_io_allow_mmap issue (part of 
>>>>> it is
>>>>>      invalidate_inode_pages2, which you already noticed, but not 
>>>>> alone).
>>>>>      Going to send out the patch once xfstests have passed
>>>>> https://github.com/bsbernd/linux/commit/3dae6b05854c4fe84302889a5625c7e5428cdd6c <https://github.com/bsbernd/linux/commit/3dae6b05854c4fe84302889a5625c7e5428cdd6c>
>>>>>
>>>>>
>>>>> Nice!
>>>>> But I think that invalidate pages issue is not restricted to shared 
>>>>> mmap?
>>>>
>>>> So history for that is
>>>>
>>>> commit 3121bfe7631126d1b13064855ac2cfa164381bb0
>>>> Author: Miklos Szeredi <mszeredi@suse.cz>
>>>> Date:   Thu Apr 9 17:37:53 2009 +0200
>>>>
>>>>       fuse: fix "direct_io" private mmap
>>>>
>>>>       MAP_PRIVATE mmap could return stale data from the cache for
>>>>       "direct_io" files.  Fix this by flushing the cache on mmap.
>>>>
>>>>       Found with a slightly modified fsx-linux.
>>>>
>>>>       Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
>>>>
>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>> index 0946861b10b7..06f30e965676 100644
>>>> --- a/fs/fuse/file.c
>>>> +++ b/fs/fuse/file.c
>>>> @@ -1298,6 +1298,8 @@ static int fuse_direct_mmap(struct file *file, 
>>>> struct vm_area_struct *vma)
>>>>           if (vma->vm_flags & VM_MAYSHARE)
>>>>                   return -ENODEV;
>>>>
>>>> +       invalidate_inode_pages2(file->f_mapping);
>>>> +
>>>>           return generic_file_mmap(file, vma);
>>>>    }
>>>>
>>>>
>>>> I don't have a strong opinion here - so idea of this patch is to avoid
>>>> exposing stale data from a previous mmap. I guess (and probably hard 
>>>> to achieve
>>>> semantics) would be to invalidate pages when the last mapping of 
>>>> that _area_
>>>> is done?
>>>> So now with a shared map, data are supposed to be stored in files and
>>>> close-to-open consistency with FOPEN_KEEP_CACHE should handle the 
>>>> invalidation?
>>>>
>>>
>>> Nevermind, it was just my bad understanding of 
>>> invalidate_inode_pages2().
>>> I think it calls fuse_launder_folio() for dirty pages, so data loss is
>>> not a concern.
>>>
>>>>>
>>>>> I think that the mix of direct io file with private mmap is common and
>>>>> doesn't have issues, but the mix of direct io files and caching 
>>>>> files on
>>>>> the same inode is probably not very common has the same issues as the
>>>>> direct_io_allow_mmap regression that you are fixing.
>>>>
>>>> Yeah. I also find it interesting that generic_file_mmap is not doing 
>>>> such
>>>> things for files opened with O_DIRECT - FOPEN_DIRECT_IO tries to do
>>>> strong coherency?
>>>>
>>>>
>>>> I'm going to send out the patch for now as it is, as that might 
>>>> become a longer
>>>> discussion - maybe Miklos could comment on it.
>>>>
>>>
>>> I think your patch should not be avoiding invalidate_inode_pages2()
>>> in the shared mmap case.
>>>
>>> You have done that part because of my comment which was wrong,
>>> not because it reproduced a bug.
>>
>> I debating with myself since yesterday, where 
>> invalidate_inode_pages2() belongs to.
>>
>> We have
>>
>> FOPEN_KEEP_CACHE - if not set invalidate_inode_pages2 is done by 
>> fuse_open_common().  If set, server side signals that it wants to keep 
>> the cache. Also interesting, I don't see anything that prevents that 
>> FOPEN_DIRECT_IO and FOPEN_KEEP_CACHE are set together.
>> Also to consider, fc->_no_open sets FOPEN_KEEP_CACHE by default.
>>
>> MAP_PRIVATE - here I'm sure that invalidate_inode_pages2 is right, 
>> even with FOPEN_KEEP_CACHE. There is also zero risk to lose data, as 
>> MAP_PRIVATE does not write out data.
>>
>> MAP_SHARED - was not allowed with FOPEN_DIRECT_IO before. Unless 
>> FOPEN_KEEP_CACHE is set, close-to-open semantics come in. My argument 
>> to to avoid invalidate_inode_pages2 in the current patch is that 
>> MAP_SHARED wants to share data between processes. And also maybe 
>> important, there is no flush in that function - dirty pages would be 
>> thrown away - data corruption!?
> 
> 
> Ah sorry, I had actually missed folio_launder() -> fuse_launder_folio(), 
> ok fine then, we can keep it for both cases.


Hmm, actually, why is fuse_launder_folio only writing out one single 
page, instead of all pages in the folio? This actually applies to all 
file systems that have have .launder_folio method (nfs, orangefs, smb, 
fuse) with the exception of v9fs. The latter is the only that writes out 
the entire folio.


Thanks,
Bernd

