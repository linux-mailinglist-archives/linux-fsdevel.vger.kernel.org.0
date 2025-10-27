Return-Path: <linux-fsdevel+bounces-65658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7CEC0BB88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 03:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF746189C7E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 02:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B52C2D2497;
	Mon, 27 Oct 2025 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c/3+pTM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E882A274B59;
	Mon, 27 Oct 2025 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533844; cv=none; b=gvKhgO8wtyR5whADvQnW4H6XgxPbiJqtPtB4P+xUvf+hN9x1Nv7okSt8FCeFLdZucwEUb8RuRORnSsLuHlXAHZ6KRj7EXJ2XojKE6yGijzdHYo+YICYYDnGQ6gH4HvjDVQYiqCYKTglsXWKYad8My4gzJlzkejqxnmLVEQDMu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533844; c=relaxed/simple;
	bh=vicwMSkBC8SiYCHGfcE17HKJUhro6jph1byqn8KWXZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VwLAsgKidVH1XHu6nMWAqWAy/o3znZ8FVuXqKFmmlXed8cZcINujok03QfhhXpDVzNdxQSyh994irw+/1WCNsUVg4Ah3LpV2ZP8T+3SVyH6EympO4BaiqCIEBsQClxHGe/smD0B2yi72OxzRQ/f/h2fx1PWsu0SYdNGg/C8Up+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c/3+pTM4; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bmKr3gs2o9uU3aOUtwCT4DF/FX3VA2tgiedTv3vuvRk=;
	b=c/3+pTM4U8FSRw10vA2AeHj0gabjZulb7wdAhA8uw2gblZ2Xp2TjEkoUjwO2h2EJUch1F74Wk
	4c6X7APTEccLl4DMvNL07Efjc/z1nregFeU9v5LLEOPDUERXQTKtIMAtfWklCzxu86uf2xUk+dt
	zN85c0VETcO4PEJuTWDpGSo=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cvynY2VLYz1T4Fg;
	Mon, 27 Oct 2025 10:56:17 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 15FA21400C8;
	Mon, 27 Oct 2025 10:57:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 27 Oct
 2025 10:57:16 +0800
Message-ID: <2d5ee2b9-e348-4d4e-a514-6c698f19f7e5@huawei.com>
Date: Mon, 27 Oct 2025 10:57:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, <linux-ext4@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<catherine.hoang@oracle.com>, Baokun Li <libaokun@huaweicloud.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-23-libaokun@huaweicloud.com>
 <aPxV6QnXu-OufSDH@casper.infradead.org>
 <adccaa99-ffbc-4fbf-9210-47932724c184@huaweicloud.com>
 <aP0PachXS8Qxjo9Q@casper.infradead.org>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aP0PachXS8Qxjo9Q@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-10-26 01:56, Matthew Wilcox wrote:
> On Sat, Oct 25, 2025 at 02:32:45PM +0800, Baokun Li wrote:
>> On 2025-10-25 12:45, Matthew Wilcox wrote:
>>> On Sat, Oct 25, 2025 at 11:22:18AM +0800, libaokun@huaweicloud.com wrote:
>>>> +	while (1) {
>>>> +		folio = __filemap_get_folio(mapping, index, fgp_flags,
>>>> +					    gfp & ~__GFP_NOFAIL);
>>>> +		if (!IS_ERR(folio) || !(gfp & __GFP_NOFAIL))
>>>> +			return folio;
>>>> +
>>>> +		if (PTR_ERR(folio) != -ENOMEM && PTR_ERR(folio) != -EAGAIN)
>>>> +			return folio;
>>>> +
>>>> +		memalloc_retry_wait(gfp);
>>>> +	}
>>> No, absolutely not.  We're not having open-coded GFP_NOFAIL semantics.
>>> The right way forward is for ext4 to use iomap, not for buffer heads
>>> to support large block sizes.
>> ext4 only calls getblk_unmovable or __getblk when reading critical
>> metadata. Both of these functions set __GFP_NOFAIL to ensure that
>> metadata reads do not fail due to memory pressure.
> If filesystems actually require __GFP_NOFAIL for high-order allocations,
> then this is a new requirement that needs to be communicated to the MM
> developers, not hacked around in filesystems (or the VFS).  And that
> communication needs to be a separate thread with a clear subject line
> to attract the right attention, not buried in patch 26/28.

EXT4 is not the first filesystem to support LBS. I believe other
filesystems that already support LBS, even if they manage their own
metadata, have similar requirements. A filesystem cannot afford to become
read-only, shut down, or enter an inconsistent state due to memory
allocation failures in critical paths. Large folios have been around for
some time, and the fact that this warning still exists shows that the
problem is not trivial to solve.

Therefore, following the approach of filesystems that already support LBS,
such as XFS and the soon-to-be-removed bcachefs, I avoid adding
__GFP_NOFAIL for large allocations and instead retry internally to prevent
failures.

I do not intend to hide this issue in Patch 22/25. I cc’d linux-mm@kvack.org
precisely to invite memory management experts to share their thoughts on
the current situation.

Here is my limited understanding of the history of __GFP_NOFAIL:

Originally, in commit 4923abf9f1a4 ("Don't warn about order-1 allocations
with __GFP_NOFAIL"), Linus Torvalds raised the warning order from 0 to 1,
and commented,
    "Maybe we should remove this warning entirely."

We had considered removing this warning, but then saw the discussion below.

Previously we used WARN_ON_ONCE_GFP, which meant the warning could be
suppressed with __GFP_NOWARN. But with the introduction of large folios,
memory allocation and reclaim have become much more challenging.
__GFP_NOFAIL can still fail, and many callers do not check the return
value, leading to potential NULL pointer dereferences.

Linus also noted that __GFP_NOFAIL is heavily abused, and even said in [1]:
“Honestly, I'm perfectly fine with just removing that stupid useless flag
 entirely.”
"Because the blame should go *there*, and it should not even remotely look
 like "oh, the MM code failed". No. The caller was garbage."

[1]:
https://lore.kernel.org/linux-mm/CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com/


From this, my understanding is that handling or retrying large allocation
failures in the caller is the direction going forward.

As for why retries are done in the VFS, there are two reasons: first, both
ext4 and jbd2 read metadata through blkdev, so a unified change is simpler.
Second, retrying here allows other buffer-head-based filesystems to support
LBS more easily.

For now, until large memory allocation and reclaim are properly handled,
this approach serves as a practical workaround.

> For what it's worth, I think you have a good case.  This really is
> a new requirement (bs>PS) and in this scenario, we should be able to
> reclaim page cache memory of the appropriate order to satisfy the NOFAIL
> requirement.  There will be concerns that other users will now be able to
> use it without warning, but I think eventually this use case will prevail.
Yeah, it would be best if the memory subsystem could add a flag like
__GFP_LBS to suppress these warnings and guide allocation and reclaim to
perform optimizations suited for this scenario.
>> Both functions eventually call grow_dev_folio(), which is why we
>> handle the __GFP_NOFAIL logic there. xfs_buf_alloc_backing_mem()
>> has similar logic, but XFS manages its own metadata, allowing it
>> to use vmalloc for memory allocation.
> The other possibility is that we switch ext4 away from the buffer cache
> entirely.  This is a big job!  I know Catherine has been working on
> a generic replacement for the buffer cache, but I'm not sure if it's
> ready yet.
>
The key issue is not whether ext4 uses buffer heads; even using vmalloc
with __GFP_NOFAIL for large allocations faces the same problem. 
 
As Linus also mentioned in the link[1] above:  
"It has then expanded and is now a problem. The cases using GFP_NOFAIL
 for things like vmalloc() - which is by definition not a small
 allocation - should be just removed as outright bugs."


Thanks,
Baokun


