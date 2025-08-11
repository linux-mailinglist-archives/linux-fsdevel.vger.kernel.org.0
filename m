Return-Path: <linux-fsdevel+bounces-57266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D8B20208
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CD63B3FC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7D72DCC08;
	Mon, 11 Aug 2025 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="0uHcpPOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897D26B761;
	Mon, 11 Aug 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901689; cv=none; b=fONNgB+kdeiCh6tOigXC+mMVyiHpFkvr0LN1spTXh+p80OCwsjwqYrwnAVqleu6S9Za4i0AzdfXsUQD6KWe9EWxmf2xpjHTTubwzPn+AzA5mH2eGNLv7oawuKnQCv6SlykK3P19ln5qkbgEXcZtSZYypQuvzKtsQDAt+OYgwXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901689; c=relaxed/simple;
	bh=j3cLTtzKehbsFpgp29oRlOgHIrIgOy7ixxMdnx5UyoU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mB/9iFj0A3nUGRD0gkYkaXzbt7OIrXVJ0B8M2+RXmU+KEHlGDRCIvpzb53XUpYWQ5UHAF0aTma1Lqxjzm8yoKzq8mi6+wIsSJyyb+DARc/PmBVHYN0KT30Uw5vZrax1pZIdo7eKEgnIzwyS8itusMqMy/rw+xJXsO+pmCPfnkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=0uHcpPOA; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c0p5H3gJKz9tWP;
	Mon, 11 Aug 2025 10:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754901683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eqFGyknN2UA223blsyE9lPSzdzYime/KN+7g1ZDehew=;
	b=0uHcpPOAl94dCRA/8o3A3PeYhCLdXaAVP6t54RIBNY9rjaH6ZH9/G/P61TB6a4DoQLb6tA
	U0nLgf2w5tYZg4qxpZlE28r1S1C0xaZHmHdIULCJ099tRqkUg+7q/53GzPHI40dz3wbpst
	Kzy/jUkXbEgaj+CxELxmv4PYKpgFyo1SE4wjqFrl46oeVa3ewUmybS6tv1zbJVkOodcUZJ
	AjOsQBrPY59/KBg0nBwrativfkIyABaMLeH18bK95r355NkNjKPhDdxkW2KqmTSYOHVzEI
	2DQUKjXDV/CNr2FI2ndKh0DOpe7Dk3vm3wFJVVO91oFQZyPHBc1PFOmevxdz6g==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 0/5] add persistent huge zero folio support
Date: Mon, 11 Aug 2025 10:41:08 +0200
Message-ID: <20250811084113.647267-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Many places in the kernel need to zero out larger chunks, but the
maximum segment we can zero out at a time by ZERO_PAGE is limited by
PAGE_SIZE.

This concern was raised during the review of adding Large Block Size support
to XFS[2][3].

This is especially annoying in block devices and filesystems where
multiple ZERO_PAGEs are attached to the bio in different bvecs. With multipage
bvec support in block layer, it is much more efficient to send out
larger zero pages as a part of single bvec.

Some examples of places in the kernel where this could be useful:
- blkdev_issue_zero_pages()
- iomap_dio_zero()
- vmalloc.c:zero_iter()
- rxperf_process_call()
- fscrypt_zeroout_range_inline_crypt()
- bch2_checksum_update()
...

Usually huge_zero_folio is allocated on demand, and it will be
deallocated by the shrinker if there are no users of it left. At the moment,
huge_zero_folio infrastructure refcount is tied to the process lifetime
that created it. This might not work for bio layer as the completions
can be async and the process that created the huge_zero_folio might no
longer be alive. And, one of the main point that came during discussion
is to have something bigger than zero page as a drop-in replacement.

Add a config option PERSISTENT_HUGE_ZERO_FOLIO that will always allocate
the huge_zero_folio, and disable the shrinker so that huge_zero_folio is
never freed.
This makes using the huge_zero_folio without having to pass any mm struct and does
not tie the lifetime of the zero folio to anything, making it a drop-in
replacement for ZERO_PAGE.

I have converted blkdev_issue_zero_pages() as an example as a part of
this series. I also noticed close to 4% performance improvement just by
replacing ZERO_PAGE with persistent huge_zero_folio.

I will send patches to individual subsystems using the huge_zero_folio
once this gets upstreamed.

Looking forward to some feedback.

[1] https://lore.kernel.org/linux-mm/20250707142319.319642-1-kernel@pankajraghav.com/
[2] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[3] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Changes since v2:
- Minor wording changes. No functional changes.
- Added RVB by Lorenzo

Changes since v1:
- Simplified the code by allocating in thp_shinrker_init() and disable
  the shrinker when this PERSISTENT_HUGE_ZERO_FOLIO config is enabled.
- Reworked commit messages and config messages based on Dave's feedback
- Added RVB and Acked-by tags.

Changes since RFC v2:
- Convert get_huge_zero_page and put_huge_zero_page to *_folio.
- Convert MMF_HUGE_ZERO_PAGE to MMF_HUGE_ZERO_FOLIO.
- Make the retry for huge_zero_folio from 2 to 1.
- Add an extra sanity check in shrinker scan for static huge_zero_folio
  case.

Changes since v1:
- Fixed all warnings.
- Added a retry feature after a particular time.
- Added Acked-by and Signed-off-by from David.

Changes since last series[1]:
- Instead of allocating a new page through memblock, use the same
  infrastructure as huge_zero_folio but raise the reference and never
  drop it. (David)
- And some minor cleanups based on Lorenzo's feedback.

Pankaj Raghav (5):
  mm: rename huge_zero_page to huge_zero_folio
  mm: rename MMF_HUGE_ZERO_PAGE to MMF_HUGE_ZERO_FOLIO
  mm: add persistent huge zero folio
  mm: add largest_zero_folio() routine
  block: use largest_zero_folio in __blkdev_issue_zero_pages()

 block/blk-lib.c          | 15 +++++----
 include/linux/huge_mm.h  | 38 ++++++++++++++++++++++
 include/linux/mm_types.h |  2 +-
 mm/Kconfig               | 16 +++++++++
 mm/huge_memory.c         | 70 ++++++++++++++++++++++++++--------------
 5 files changed, 108 insertions(+), 33 deletions(-)


base-commit: 53c448023185717d0ed56b5546dc2be405da92ff
-- 
2.49.0


