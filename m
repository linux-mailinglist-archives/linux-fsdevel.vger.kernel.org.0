Return-Path: <linux-fsdevel+bounces-14312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FABD87AF9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9791F2B10A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F95A76F0A;
	Wed, 13 Mar 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="YJ9ERQs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C01A38E7;
	Wed, 13 Mar 2024 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349726; cv=none; b=Yzb+4AxPgIKLawOinA8abmPMaYhgnQSQ7JZNqnvR4TBzRwsBAV7FxcQ9msyDKkGTFpX9Qp5JcZeTN7kP2IzFix/2ih6FDaRA5R/4GPISfFmt3pJGVd5VT7thhebUMlEOYuo+FLnTS5xrqDIG7YJCWtBJIwx2i3lnt1tBf9JFHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349726; c=relaxed/simple;
	bh=Z9LlQsF/EJRNh/l0qXkEZ9zchYi8EVtFMXy+4kSbnFM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r6SENM5ZwVaqvLiOuIw2c8Ei77U5f/dD95NrjTSsGhhFY9A/oJ2XI4DZiDihCQDw0tvv+weYFpyw1OP7PtTvR7OBiwnGLemFwgdCnODeHJGOUUMJEUVfrF7b6YEONhnWd3g0oaEEk+0vDln2N9MbHqbnqWTAHs6ctUvJzE4MoXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=YJ9ERQs9; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TvxfB298rz9stG;
	Wed, 13 Mar 2024 18:02:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710349378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+31zPK3/xE4cPa56xvU1Q/V7CpxqVcLqveg5PJbjK2o=;
	b=YJ9ERQs9DogTXCegYDcipGUl7yqugYFeg2RJ3nO8fuWPStMUU93hIsuUYrbTOzREBvY2py
	331cM4G70BV4jZplXsArvi7jV0hGBGilWxeZ58S6ehvJgiAP6Q+eZYZ2RK5Xsl/D1mjg96
	dttySmWJH/HQquMprjMLdz7MY8kVicKjKZDcCDhOEFjgZObUNdmq+fmFhcpIrGfcfUgs6S
	ubRh2Vj1hiJcAyOHOOhtlK1xULZDVEThlmOV/wdPnPKaT9VNUcvBHzWpp4/E7FMDFKUdz+
	vwRKicE0zXxIlE2PeidxjIsVd1PCrC/T0Fh2q8VKH0Z4929vqKW1F6KIrCAFZw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: gost.dev@samsung.com,
	chandan.babu@oracle.com,
	hare@suse.de,
	mcgrof@kernel.org,
	djwong@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 00/11] enable bs > ps in XFS
Date: Wed, 13 Mar 2024 18:02:42 +0100
Message-ID: <20240313170253.2324812-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

This is the third version of the series that enables block size > page size
(Large Block Size) in XFS. The context and motivation can be seen in cover
letter of the RFC v1[1]. We also recorded a talk about this effort at LPC [3],
if someone would like more context on this effort.

A lot of emphasis has been put on testing using kdevops. The testing has
been split into regression and progression.

Regression testing:
In regression testing, we ran the whole test suite to check for
*regression on existing profiles due to the page cache changes.

No regression was found with the patches added on top.

*Baseline for regression was created using SOAK_DURATION of 2.5 hours
and having used about 7-8 XFS test clusters to test loop fstests over
70 times. We then scraped for critical failures (crashes, XFS or page
cache asserts, or hung tasks) and have reported these to the community
as well.[4]

Progression testing:
For progression testing, we tested for 8k, 16k, 32k and 64k block sizes.
To compare it with existing support, an ARM VM with 64k base page system
(without our patches) was used as a reference to check for actual failures
due to LBS support in a 4k base page size system.

There are some common failures upstream for bs=64k that needs to be
fixed[5].
There are also some tests that assumes block size < page size that needs to
be fixed. I have a tree with fixes for xfstests here [6], which I will be
sending soon to the list.

No new failures were found with the LBS support.

We've done some preliminary performance tests with fio on XFS on 4k block
size against pmem and NVMe with buffered IO and Direct IO on vanilla
v6.8-rc4 Vs v6.8-rc4 + these patches applied, and detected no regressions.

We also wrote an eBPF tool called blkalgn [7] to see if IO sent to the device
is aligned and at least filesystem block size in length.

Git tree:
https://github.com/linux-kdevops/linux/tree/large-block-minorder-6.8

[1] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
[2] https://lore.kernel.org/linux-xfs/20240213093713.1753368-1-kernel@pankajraghav.com/
[3] https://www.youtube.com/watch?v=ar72r5Xf7x4
[4] https://github.com/linux-kdevops/kdevops/blob/master/docs/xfs-bugs.md
489 non-critical issues and 55 critical issues. We've determined and reported
that the 55 critical issues have all fall into 5 common  XFS asserts or hung
tasks  and 2 memory management asserts.
[5] https://lore.kernel.org/linux-xfs/fe7fec1c-3b08-430f-9c95-ea76b237acf4@samsung.com/
[6] https://github.com/Panky-codes/xfstests/tree/lbs-fixes
[7] https://github.com/iovisor/bcc/pull/4813

Changes since v2:
- Simplified the filemap and readahead changes. (Thanks willy)
- Removed DEFINE_READAHEAD_ALIGN.
- Added minorder support to readahead_expand().

Changes since v1:
- Round up to nearest min nr pages in ra_init
- Calculate index in filemap_create instead of doing in
  filemap_get_pages
- Remove unnecessary BUG_ONs in the delete path
- Use check_shl_overflow instead of check_mul_overflow
- Cast to uint32_t instead of unsigned long in xfs_stat_blksize

Changes since RFC v2:
- Move order 1 patch above the 1st patch
- Remove order == 1 conditional in `fs: Allow fine-grained control of
folio sizes`. This fixed generic/630 that was reported in the previous version.
- Hide the max order and expose `mapping_set_folio_min_order` instead.
- Add new helper mapping_start_index_align and DEFINE_READAHEAD_ALIGN
- don't call `page_cache_ra_order` with min order in do_mmap_sync_readahead
- simplify ondemand readahead with only aligning the start index at the end
- Don't cap ra_pages based on bdi->io_pages
- use `checked_mul_overflow` while calculating bytes in validate_fsb
- Remove config lbs option
- Add a warning while mounting a LBS kernel
- Add Acked-by and Reviewed-by from Hannes and Darrick.

Changes since RFC v1:
- Added willy's patch to enable order-1 folios.
- Unified common page cache effort from Hannes LBS work.
- Added a new helper min_nrpages and added CONFIG_THP for enabling mapping_large_folio_support
- Don't split a folio if it has minorder set. Remove the old code where we set extra pins if it has that requirement.
- Split the code in XFS between the validation of mapping count. Put the icache code changes with enabling bs > ps.
- Added CONFIG_XFS_LBS option
- align the index in do_read_cache_folio()
- Removed truncate changes
- Fixed generic/091 with iomap changes to iomap_dio_zero function.
- Took care of folio truncation scenario in page_cache_ra_unbounded() that happens after read_pages if a folio was found.
- Sqaushed and moved commits around
- Rebased on top of v6.8-rc4

Hannes Reinecke (1):
  readahead: rework loop in page_cache_ra_unbounded()

Luis Chamberlain (2):
  filemap: allocate mapping_min_order folios in the page cache
  readahead: round up file_ra_state->ra_pages to mapping_min_nrpages

Matthew Wilcox (Oracle) (2):
  mm: Support order-1 folios in the page cache
  fs: Allow fine-grained control of folio sizes

Pankaj Raghav (6):
  readahead: allocate folios with mapping_min_order in readahead
  mm: do not split a folio if it has minimum folio order requirement
  iomap: fix iomap_dio_zero() for fs bs > system page size
  xfs: expose block size in stat
  xfs: make the calculation generic in xfs_sb_validate_fsb_count()
  xfs: enable block size larger than page size support

 fs/iomap/direct-io.c       |  13 ++++-
 fs/xfs/libxfs/xfs_ialloc.c |   5 ++
 fs/xfs/libxfs/xfs_shared.h |   3 ++
 fs/xfs/xfs_icache.c        |   6 ++-
 fs/xfs/xfs_iops.c          |   2 +-
 fs/xfs/xfs_mount.c         |  10 +++-
 fs/xfs/xfs_super.c         |  10 +---
 include/linux/huge_mm.h    |   7 ++-
 include/linux/pagemap.h    | 100 ++++++++++++++++++++++++++++--------
 mm/filemap.c               |  26 ++++++----
 mm/huge_memory.c           |  36 +++++++++++--
 mm/internal.h              |   4 +-
 mm/readahead.c             | 101 +++++++++++++++++++++++++++++--------
 13 files changed, 247 insertions(+), 76 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.43.0


