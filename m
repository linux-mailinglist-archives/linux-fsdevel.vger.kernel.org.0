Return-Path: <linux-fsdevel+bounces-56636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B681B1A0F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044183BDAD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317DE2586C8;
	Mon,  4 Aug 2025 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="PTbn/7XK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606314EC62;
	Mon,  4 Aug 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309655; cv=none; b=biJ24eCQPkMAldwq7MR6RcjwnI5yLFeB3yoeIql+P+eSUlY+Y44g+/cdKoJzKucHmKrRCK8LXDm5PYS4aHTr71eWIjfkkT6bZt5qcBX+9Cw5oWztMqQfsd+yd/yIlhkzqJ1QOQJHBzP2r8eVK1XE/YZJievY+C9cMegtnVDWXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309655; c=relaxed/simple;
	bh=GZHbkGbaE11j7U/BUeIH+q8MWqWSg7w15TZc2hCrpGc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fVQ8v9rvqLbBmWv/5tJzm0+uSvGZqOuCP3nOeb0sPN4PUAZDDRxOQeWvocEUcgVuuBYLOqbyVO/3LPCc/Inu0qUJ+NPuoGolANQXAf5I9kKEEspgb/JHGCxzSFadXixt3lMp3KePT3Yr7Ba0/1HVtgGMeC4Kl4cDx5fma4jp8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=PTbn/7XK; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bwb7z3hgkz9tFL;
	Mon,  4 Aug 2025 14:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754309647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=80SiyYCvOTGynbWdEDIlGpTbPo36gMMHdma7I3Bjcno=;
	b=PTbn/7XKLbSA21l+wNOWj6V3OW0uE7tX20T4O5uEpLTpYrYZxVUcwfyVvfhjaA7Gx7bFSI
	N6WRTKoknHFtmw/C9D2eoMOakgvFcsn6pHbFbrLGnBHBRJ6WVFVwqqPdCXfrUE+ZcBuTvn
	7zNBdPZFcLXLkmAAOUdNVLdfD1Z4XPgesg0OY2Dfga57zZ53Xb1lo3vw+HhYFu7llqmYkl
	uoJuMm7IxQbfmTyJXZ2vp90OCENuqF8FjBA6A9tlY0qDe2pEbS94T5LZKmV4udcfGrQ3j6
	IyYAIRRVc8JVzf8BtNBhk5XrXbd1W1WlMRQZ05mHKTFm7SULsO6H/nwP1GXDuA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
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
	linux-mm@kvack.org,
	willy@infradead.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/5] add static huge zero folio support
Date: Mon,  4 Aug 2025 14:13:51 +0200
Message-ID: <20250804121356.572917-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bwb7z3hgkz9tFL

From: Pankaj Raghav <p.raghav@samsung.com>

There are many places in the kernel where we need to zeroout larger
chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
is limited by PAGE_SIZE.

This concern was raised during the review of adding Large Block Size support
to XFS[2][3].

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

Usually huge_zero_folio is allocated on demand, and it will be
deallocated by the shrinker if there are no users of it left. At the moment,
huge_zero_folio infrastructure refcount is tied to the process lifetime
that created it. This might not work for bio layer as the completions
can be async and the process that created the huge_zero_folio might no
longer be alive. And, one of the main point that came during discussion
is to have something bigger than zero page as a drop-in replacement.

Add a config option STATIC_HUGE_ZERO_FOLIO that will always allocate
the huge_zero_folio, and it will never drop the reference. This makes
using the huge_zero_folio without having to pass any mm struct and does
not tie the lifetime of the zero folio to anything, making it a drop-in
replacement for ZERO_PAGE.

I have converted blkdev_issue_zero_pages() as an example as a part of
this series. I also noticed close to 4% performance improvement just by
replacing ZERO_PAGE with static huge_zero_folio.

I will send patches to individual subsystems using the huge_zero_folio
once this gets upstreamed.

Looking forward to some feedback.

[1] https://lore.kernel.org/linux-mm/20250707142319.319642-1-kernel@pankajraghav.com/
[2] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[3] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

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
  mm: add static huge zero folio
  mm: add largest_zero_folio() routine
  block: use largest_zero_folio in __blkdev_issue_zero_pages()

 arch/x86/Kconfig         |  1 +
 block/blk-lib.c          | 15 +++----
 include/linux/huge_mm.h  | 35 ++++++++++++++++
 include/linux/mm_types.h |  2 +-
 mm/Kconfig               | 21 ++++++++++
 mm/huge_memory.c         | 86 ++++++++++++++++++++++++++++++----------
 6 files changed, 131 insertions(+), 29 deletions(-)


base-commit: df01d1162a83194a036f0d648ae41e6ad8adbe1a
-- 
2.49.0


