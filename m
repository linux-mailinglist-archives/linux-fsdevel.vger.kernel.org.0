Return-Path: <linux-fsdevel+bounces-12768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABA386701A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EF228A403
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355762A1A;
	Mon, 26 Feb 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="S3AGLgpI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BD62A16;
	Mon, 26 Feb 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940989; cv=none; b=TOjCGtlb/XVIhmOOab4B9LOOZumKtfB0FJEmKixrvD9ztkXkQQ1rXzmpE//f2a09K3YtBvWeJZoa54rLFDgpodBPpnx4uQmYLJ+rr7GfIAUpKjkGQ/MYA7pxN9VLMVWe1iFoJJNr2YPjQit06oINKpTA0Hb9OXE37GxRFPyyJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940989; c=relaxed/simple;
	bh=OJY78OpesueWAjk/1o1SOcU1QBh6YJtiAhd/eFP8P8U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oznyGKErLjOTEaJl+ELLIkh1qWxhd10YGOaR2pbi4amOA8+iCGeBtrTtB5T5BHJFri0EWNq2QF9YEikaaTwSpQ+75W0G0B2Xs9T4dtLK4D/aMi7qp/umuR/AA8RdaAGltqH8xZ1NxbKGx5cBmXWtHUawIGRMhnb2ZZ/18YAgvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=S3AGLgpI; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Tjwng2wSlz9sQ6;
	Mon, 26 Feb 2024 10:49:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708940983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tmcxRgQrgikqUmGiWud6EjwhzhebLvaHxb8lOPproZk=;
	b=S3AGLgpItA0Uhbu1dopT9xOXQu8rfZMFECkdvS8T6HuS3MUKgraJqsHYBKFjtMRrOl8BJe
	/uxvU+InJsRtD3rWVOXdspyqvMEMMxRsCufXJpmcz+qpm2HgnUA7Or8br9ttuzj1q3kDYH
	BTcEC4YS3A2H5BNFugtQKlWBM5K/1VqipCtIsKTrveo6gK8ENZ81dMQuN6FNdXydgmqUiw
	+E/wNwujEAE3crrP3JOSaYciBwYZHsEGABlT86BFVZqvPkYcSzGT+nlsB/K7DGQieFJnpH
	D6rXfyNKcdhDIEasozRYT14p1ajzq/6CsmqaYbZh7+XyOrKuHfpZ77OFKAI2MA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	ziy@nvidia.com,
	hare@suse.de,
	djwong@kernel.org,
	gost.dev@samsung.com,
	linux-mm@kvack.org,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 00/13] enable bs > ps in XFS
Date: Mon, 26 Feb 2024 10:49:23 +0100
Message-ID: <20240226094936.2677493-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Tjwng2wSlz9sQ6

From: Pankaj Raghav <p.raghav@samsung.com>

This is the first version of the series(2 RFCs posted before) that enables
block size > page size(Large Block Size) in XFS. This version has various
bug fixes and suggestion collected from previous RFCs[1][2]. The context
and motivation can be seen in cover letter of the RFC v1[1]. We also
recorded a talk about this effort at LPC [3], if someone would like more
context on this effort.

A lot of emphasis has been put on testing using kdevops. The testing has
been split into regression and progression.

Regression testing:
In regression testing, we ran the whole test suite with SOAK_DURATION=2.5
hours to check for *regression on existing profiles due to the page cache
changes.

No regression was found with the patches added on top.

*Baseline for regression was created using SOAK_DURATION of 2.5 hours
and having used about 7-8 XFS test clusters to test loop fstests over
70 times. We then scraped for critical failures (crashes, XFS or page
cache asserts, or hung tasks) and have reported these to the community
as well.[5]

Progression testing:
For progression testing, we tested for 8k, 16k, 32k and 64k block sizes.
To compare it with existing support, an ARM VM with 64k base page system
(without our patches) was used as a reference to check for actual failures
due to LBS support in a 4k base page size system.

There are some common failures upstream for bs=64k that needs to be fixed[4].
There are also some tests that assumes block size < page size that needs to
be fixed. I have a tree with fixes for xfstests here [6], which I will be
sending soon to the list.

No new failures were found with LBS support.

We've done some preliminary performance tests with fio on XFS on 4k block
size against pmem and NVMe with buffered IO and Direct IO on vanilla
v6.8-rc4 Vs v6.8-rc4 + these patches applied, and detected no regressions.

We also wrote an eBPF tool called blkalgn [7] to see if IO sent to the device
is aligned and at least filesystem block size in length.

I have also started the discussion with Zi Yan to upstream truncation
with lower folio order that will improve the memory utilization when
partial truncate happens with LBS support(Patch 9).[8]

The series has been greatly improved (and simplified) since the previous
version. Thanks to Chinner, Darrick, Hannes and willy for your comments.

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
[8] https://lore.kernel.org/all/dvamjmlss62p5pf4das7nu5q35ftf4jlk3viwzyyvzasv4qjns@h3omqs7ecstd/

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

Dave Chinner (1):
  xfs: expose block size in stat

Hannes Reinecke (1):
  readahead: rework loop in page_cache_ra_unbounded()

Luis Chamberlain (3):
  filemap: align the index to mapping_min_order in the page cache
  readahead: set file_ra_state->ra_pages to be at least
    mapping_min_order
  readahead: align index to mapping_min_order in ondemand_ra and
    force_ra

Matthew Wilcox (Oracle) (2):
  mm: Support order-1 folios in the page cache
  fs: Allow fine-grained control of folio sizes

Pankaj Raghav (6):
  filemap: use mapping_min_order while allocating folios
  readahead: allocate folios with mapping_min_order in
    ra_(unbounded|order)
  mm: do not split a folio if it has minimum folio order requirement
  iomap: fix iomap_dio_zero() for fs bs > system page size
  xfs: make the calculation generic in xfs_sb_validate_fsb_count()
  xfs: enable block size larger than page size support

 fs/iomap/direct-io.c       |  13 ++++-
 fs/xfs/libxfs/xfs_ialloc.c |   5 ++
 fs/xfs/libxfs/xfs_shared.h |   3 ++
 fs/xfs/xfs_icache.c        |   6 ++-
 fs/xfs/xfs_iops.c          |   2 +-
 fs/xfs/xfs_mount.c         |   9 +++-
 fs/xfs/xfs_super.c         |  10 +---
 include/linux/huge_mm.h    |   7 ++-
 include/linux/pagemap.h    | 108 ++++++++++++++++++++++++++++++-------
 mm/filemap.c               |  48 +++++++++++------
 mm/huge_memory.c           |  36 +++++++++++--
 mm/internal.h              |   4 +-
 mm/readahead.c             |  74 ++++++++++++++++++-------
 13 files changed, 246 insertions(+), 79 deletions(-)


base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
-- 
2.43.0


