Return-Path: <linux-fsdevel+bounces-54126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39637AFB5F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EED1AA6DE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239A2D8DD9;
	Mon,  7 Jul 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="MehnIVD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ABD2D8DBC;
	Mon,  7 Jul 2025 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898221; cv=none; b=HAkqDM0PuDLv9dw2E9L51ysYpNzUB5rxm7p083SAzIAmkk81jr4WWAzs8pW/rmZlEcJzhwHKzAgVXmmpZpBFdG2Y1hJwiuKmiXvWJAmo2nBSFTRBVjsXOupORirV9hwX5aqzioSsEr+GzpKXA/2U0wa6RU+XTElR4ro8UKhDUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898221; c=relaxed/simple;
	bh=RUjQXbCJnwboPtEi0gct+9fAzyg2mYvrTnWVxKHKEYU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pr8aMhXvmm8enlGbTHtvojMDfxThmUP1u17J7r+0Amq4ZMIPFj21MqD+j1PtZlcCeVRsimrgRfJdavxmMXDcAB8WmC+MzWpRJGW08nEud0og4aw6hcjRwNAlA63XrsZytnpCsxx5b5GBmq1s5YRNZRSaA0h7ff+NC1oBPKegdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=MehnIVD/; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bbRLB14fvz9tCk;
	Mon,  7 Jul 2025 16:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1751898210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s4EZdHf+U3R+v43lcZijWizNqsqKvK4IRVcr5nu5cj0=;
	b=MehnIVD/KloRf9rrD61bo8uVvO5mi99kSgMuUHeUYXOq1A2yxGunRzTwFMljMjGdO3rsq4
	k78IzmiGbP2h2P76t6xsZOb4fGQgYFde80jo21p6JNNwqoTMjKQw/sZW2ykSSNq7su0VrS
	3JObETkyU/36rBzUEKeXhn3//bturtQRiYGi/g2CeeEIL6XfqDdADkRFgSjuhQBhd01HlL
	fD0+wRlqHp9eWWZBEkUgNgwTfd1vUi2VbSQEpXffRiw5zX6Am92eIxHm6snQlXBeylxkOk
	aUR/7HreJ2iBQWDgQYtNyQRLg83nDzPRFd5YzQeNMcwJRPe1BN/UrM54QIfV9g==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
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
	willy@infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 0/5] add static PMD zero page support
Date: Mon,  7 Jul 2025 16:23:14 +0200
Message-ID: <20250707142319.319642-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

There are many places in the kernel where we need to zeroout larger
chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
is limited by PAGE_SIZE.

This concern was raised during the review of adding Large Block Size support
to XFS[1][2].

This is especially annoying in block devices and filesystems where we
attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
bvec support in block layer, it is much more efficient to send out
larger zero pages as a part of a single bvec.

Some examples of places in the kernel where this could be useful:
- blkdev_issue_zero_pages()
- iomap_dio_zero()
- vmalloc.c:zero_iter()
- rxperf_process_call()
- fscrypt_zeroout_range_inline_crypt()
- bch2_checksum_update()
...

We already have huge_zero_folio that is allocated on demand, and it will be
deallocated by the shrinker if there are no users of it left.

At moment, huge_zero_folio infrastructure refcount is tied to the process
lifetime that created it. This might not work for bio layer as the completions
can be async and the process that created the huge_zero_folio might no
longer be alive.

Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
the huge_zero_folio via memblock, and it will never be freed.

I have converted blkdev_issue_zero_pages() as an example as a part of
this series.

I will send patches to individual subsystems using the huge_zero_folio
once this gets upstreamed.

Looking forward to some feedback.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Changes since v1:
- Move from .bss to allocating it through memblock(David)

Changes since RFC:
- Added the config option based on the feedback from David.
- Encode more info in the header to avoid dead code (Dave hansen
  feedback)
- The static part of huge_zero_folio in memory.c and the dynamic part
  stays in huge_memory.c
- Split the patches to make it easy for review.

Pankaj Raghav (5):
  mm: move huge_zero_page declaration from huge_mm.h to mm.h
  huge_memory: add huge_zero_page_shrinker_(init|exit) function
  mm: add static PMD zero page
  mm: add largest_zero_folio() routine
  block: use largest_zero_folio in __blkdev_issue_zero_pages()

 block/blk-lib.c         | 17 +++++----
 include/linux/huge_mm.h | 31 ----------------
 include/linux/mm.h      | 81 +++++++++++++++++++++++++++++++++++++++++
 mm/Kconfig              |  9 +++++
 mm/huge_memory.c        | 62 +++++++++++++++++++++++--------
 mm/memory.c             | 25 +++++++++++++
 mm/mm_init.c            |  1 +
 7 files changed, 173 insertions(+), 53 deletions(-)


base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
-- 
2.49.0


