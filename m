Return-Path: <linux-fsdevel+bounces-11334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846C852C76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBCA285164
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A62929420;
	Tue, 13 Feb 2024 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="OD4iggFM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92056224D6;
	Tue, 13 Feb 2024 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817049; cv=none; b=H9propiHCzRnjxdSyW0JT9p6/iL8TBuhuDZOTxX7kSFxpanHtkbKVI7PUkYipIbAHIn5f15b49O4tSysPAbEMaaaKHD2SJOQGTxrgxYPmMnqdbl5RH03CwQuS0xQ+JdfZSies7u5TnGuBqeDRS8f/xR/MRIj7wfI6yhDZYjf81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817049; c=relaxed/simple;
	bh=ikGQN6RQmbEcDxqiv7O7NKuMkrjEB30KNcHXstoZjvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=frcIFI86dYKIp2zqm0ulSC1qDaV01lsy+FLpOwWHDEP0Chb1vGYwDnUHz6GAwX7rITWipyWivIePWPw2NEIhYAhD5j4otIjPCIC5928ScI4o9vYcEdS/JP3KznMaN0Zl0sBOtV1JI8ZIEcORa4Vn1vwYmJdntvcHSP0CpHtg8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=OD4iggFM; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TYx7L0BFvz9t1x;
	Tue, 13 Feb 2024 10:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/nATs3SuO4faY1mpCrALcbEB9qiePNdJP0j+dhEQhPM=;
	b=OD4iggFME3PNcclujYe65LlZhySTHyF1jpEsqvMob21KT6LdGRlTn3FA9UB9IUmsfMae98
	ehZzaV52pg7fsEAyJ5zo5G/aNvql1jFmwcGReNIGLrDFW2oFVus14KfdROXRRsv/Hci/Dt
	aMGU0qGt3tYxu5kOlhHTkMTh+K3kDcc4/HnrQREQkHRWH8aAOS0h3GsR61v5i2YaZI15qg
	yBim8jvZ9Sw+lVFHGEgYtwoxq1ze6RrwQUKYdRI1zbrWzgxjCIYsW+Q/FP8fWN7kmNSwbi
	5fLeJOJQb4UTOHp9YOgwGv2Ur2rsUDD9U2djRybjan/ih/EXGhb94vEyC+DXVQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kbusch@kernel.org,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	p.raghav@samsung.com,
	linux-kernel@vger.kernel.org,
	hare@suse.de,
	willy@infradead.org,
	linux-mm@kvack.org,
	david@fromorbit.com
Subject: [RFC v2 00/14] enable bs > ps in XFS
Date: Tue, 13 Feb 2024 10:36:59 +0100
Message-ID: <20240213093713.1753368-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

This is the second version of the series that enables block size > page size
(Large Block Size) in XFS. This version has various bug fixes and suggestion
collected from the v1[1]. The context and motivation can be seen in cover
letter of the v1. We also recorded a talk about this effort at LPC [2],
if someone would like more context on this effort.

A lot of emphasis has been put on testing using kdevops, and fixing some
critical bugs for LBS.

The testing has been split into regression and progression.

Regression testing:
In regression testing, CONFIG_XFS_LBS was disabled and we ran the whole
test suite with SOAK_DURATION=2.5 hours to check for *regression on existing
profiles due to the page cache changes.

No regression was found with the patches added on top.

* Baseline for regression was created using SOAK_DURATION of 2.5 hours
and having used about 7-8 XFS test clustes to test loop fstests over
70 times. We then scraped for critical failures (crashes, XFS or page
cache asserts, or hung tasks) and have reported these to the community
as well.[3]

Progression testing:
For progression testing, CONFIG_XFS_LBS was enabled and we tested for
8k, 16k, 32k and 64k block sizes. To compare it with existing support,
an ARM VM with 64k base page system(without our patches) was used as a
reference to check for actual failures due to LBS support in a 4k base
page size system.

There are some common failures upstream for bs=64k that needs to be fixed[4].
There are also some tests that assumes block size < page size that needs to
be fixed. I have a tree with fixes for xfstests here [5], which I will be
sending soon to the list.

The only real failure for LBS currently is:
- generic/630 for 8k block size. This tests dedupe race and it only fails
for 8k blocksize, and it does not fail on a 64k base page system.

We've done some preliminary performance tests with fio on XFS on 4k block
size against pmem and NVMe with buffered IO and Direct IO on vanilla
v6.8-rc4 Vs v6.8-rc4 + these patches applied, and detected no regressions.

We also wrote an eBPF tool called blkalgn [6] to see if IO sent to the device
is aligned and at least filesystem block size in length.

Git tree: https://github.com/linux-kdevops/linux/tree/large-block-minorder-6.8.0-rc4

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

[1] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
[2] https://www.youtube.com/watch?v=ar72r5Xf7x4
[3] https://github.com/linux-kdevops/kdevops/blob/master/docs/xfs-bugs.md
489 non-critical issues and 55 critical issues. We've determined and reported
that the 55 critical issues have all fall into 5 common  XFS asserts or hung
tasks  and 2 memory management asserts.
[4] https://lore.kernel.org/linux-xfs/fe7fec1c-3b08-430f-9c95-ea76b237acf4@samsung.com/
[5] https://github.com/Panky-codes/xfstests/tree/lbs-fixes
[6] https://github.com/iovisor/bcc/pull/4813

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
  fs: Allow fine-grained control of folio sizes
  mm: Support order-1 folios in the page cache

Pankaj Raghav (7):
  filemap: use mapping_min_order while allocating folios
  readahead: allocate folios with mapping_min_order in
    ra_(unbounded|order)
  mm: do not split a folio if it has minimum folio order requirement
  iomap: fix iomap_dio_zero() for fs bs > system page size
  xfs: make the calculation generic in xfs_sb_validate_fsb_count()
  xfs: add an experimental CONFIG_XFS_LBS option
  xfs: enable block size larger than page size support

 fs/iomap/direct-io.c    | 13 +++++-
 fs/xfs/Kconfig          | 11 +++++
 fs/xfs/xfs_icache.c     |  8 +++-
 fs/xfs/xfs_iops.c       |  4 +-
 fs/xfs/xfs_mount.c      | 10 ++++-
 fs/xfs/xfs_super.c      |  8 ++--
 include/linux/huge_mm.h |  7 ++-
 include/linux/pagemap.h | 92 ++++++++++++++++++++++++++++++--------
 mm/filemap.c            | 61 ++++++++++++++++++++------
 mm/huge_memory.c        | 36 ++++++++++++---
 mm/internal.h           |  4 +-
 mm/readahead.c          | 97 ++++++++++++++++++++++++++++++++---------
 12 files changed, 276 insertions(+), 75 deletions(-)


base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
-- 
2.43.0


