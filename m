Return-Path: <linux-fsdevel+bounces-54971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87501B06027
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C541C43DEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C802ED871;
	Tue, 15 Jul 2025 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="KchWQKSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2422ECD16;
	Tue, 15 Jul 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587647; cv=none; b=KTeljGaDc90H+msqzq5xqWxgXBXXBwRmFrXjB551IdODbbVm+MXPq1Z2Dh/gy/6dqAAOLh3XDbVVs4pyvHQAO8BbThA6FxyEti3vOx3fG5xHkbjX91oitlMGHnIqcH3flZIleI/oLadZ1ZTCoTw6PTwMrmUS+D6zBaaC9moQGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587647; c=relaxed/simple;
	bh=TI+q4X7B5ajg00//PiUBxtm7Tx45E2OavIud3tLqh7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU1Q5fZP7ij1dUMiYjYMcegowA6KjqOu3/5zfKSrjV5KrRxe9kSsQxi2c95QYCRRAtFuZI7t4FlM1q/zTjhSAUNBP6OasBwPPEOGkdZeVCVGSuThDgTWezHNTQwv6DTX+lt6XPnh2CN+BkZy6XxiI2+Sb3r3AYDSuRToJcxsjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=KchWQKSf; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bhLJS6ZJhz9tJh;
	Tue, 15 Jul 2025 15:54:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752587641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+/pRfnziQy+vnrr7cy84X8As3YxPBFjo6viEF0K4AM=;
	b=KchWQKSfMAVs5akCV9f1abNSHWlPgTEZYnAr/TBieZnSm6LGk5YhpCi2CPiagz9rloCJnU
	5V+irsqtIe3z3O66EoJGSDBpAOAXpfUhVnKabLFn62PqumdoU/26UXEIbfk7lmDIAyGXTb
	lzmuvm8oMug9rLOtQchKKowFg0DBd0OD5sf6wGQzggcTvGgHsiGQv0gSzvJdg1f6ITF29g
	hz1SUTlSwUua2jfdjYzBzKnYYELaB8wSJCDjXwYLIPYnSsqJ4Ud0Rd97DEB9gBx7CBJfMo
	BsKx3j29JVYo0YdByz7sOBeG7th/B73sF9pTKgTB5KEN4UDe7L+aim3Xw5uj9Q==
Message-ID: <f51efc9a-20ae-4304-812b-824d64d17e4f@pankajraghav.com>
Date: Tue, 15 Jul 2025 15:53:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko
 <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 linux-kernel@vger.kernel.org, Dev Jain <dev.jain@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, willy@infradead.org,
 linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>, Ingo Molnar <mingo@redhat.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20250707142319.319642-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

For now I have some feedback from Zi. It would be great to hear your
feedback before I send the next version :)

--
Pankaj

On Mon, Jul 07, 2025 at 04:23:14PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
>
> This concern was raised during the review of adding Large Block Size support
> to XFS[1][2].
>
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of a single bvec.
>
> Some examples of places in the kernel where this could be useful:
> - blkdev_issue_zero_pages()
> - iomap_dio_zero()
> - vmalloc.c:zero_iter()
> - rxperf_process_call()
> - fscrypt_zeroout_range_inline_crypt()
> - bch2_checksum_update()
> ...
>
> We already have huge_zero_folio that is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left.
>
> At moment, huge_zero_folio infrastructure refcount is tied to the process
> lifetime that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive.
>
> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
> the huge_zero_folio via memblock, and it will never be freed.
>
> I have converted blkdev_issue_zero_pages() as an example as a part of
> this series.
>
> I will send patches to individual subsystems using the huge_zero_folio
> once this gets upstreamed.
>
> Looking forward to some feedback.
>
> [1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
> [2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
>
> Changes since v1:
> - Move from .bss to allocating it through memblock(David)
>
> Changes since RFC:
> - Added the config option based on the feedback from David.
> - Encode more info in the header to avoid dead code (Dave hansen
>   feedback)
> - The static part of huge_zero_folio in memory.c and the dynamic part
>   stays in huge_memory.c
> - Split the patches to make it easy for review.
>
> Pankaj Raghav (5):
>   mm: move huge_zero_page declaration from huge_mm.h to mm.h
>   huge_memory: add huge_zero_page_shrinker_(init|exit) function
>   mm: add static PMD zero page
>   mm: add largest_zero_folio() routine
>   block: use largest_zero_folio in __blkdev_issue_zero_pages()
>
>  block/blk-lib.c         | 17 +++++----
>  include/linux/huge_mm.h | 31 ----------------
>  include/linux/mm.h      | 81 +++++++++++++++++++++++++++++++++++++++++
>  mm/Kconfig              |  9 +++++
>  mm/huge_memory.c        | 62 +++++++++++++++++++++++--------
>  mm/memory.c             | 25 +++++++++++++
>  mm/mm_init.c            |  1 +
>  7 files changed, 173 insertions(+), 53 deletions(-)
>
>
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> --
> 2.49.0


