Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8564B47F748
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Dec 2021 15:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhLZOfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 09:35:40 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18864 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233752AbhLZOfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:35:17 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AZWqqgaC+rSajUhVW/1biw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fVAK90D5x0zxTzGQYDW+FaP+DazGje4hxO9vk/EpX68WAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK49CMmi/nRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZPwbpuSXfijXXcu7iheun2HX6/lnEkA6FYMC/eNwG2t?=
 =?us-ascii?q?P6boTLzVlRhCIh8q3xryhQ+Vhj8hlK9PkVKsTs3cmz3fGDPIiQJnGWI3L48NV2?=
 =?us-ascii?q?HE7gcUmNfrceM0fZhJsYQ7GbhkJPU0YYLo6neG1ljz6dhVbtluepuww+We75Ap?=
 =?us-ascii?q?v3LnoNfLRe8eWXoNRn0CFtiTK8nqRKhERNPSb0ibD/n/Eru3Gmy69U4IPPLqi/?=
 =?us-ascii?q?/VujRuYwWl7IBkXU0ar5PeihkOgVtZ3NUMZ4GwtoLI0+UjtScPyNzW8oXiZrls?=
 =?us-ascii?q?fVsBWHukS9g6A0OzX7hyfC2xCSSROAPQitckrVXk62EShgdzkH3psvaeTRHbb8?=
 =?us-ascii?q?a2bxQ5ekwB9wXQqPHdCFFVapYK45txbs/4Gdf47eIbdszE/MW6YL+i2kRUD?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Av6gTsKCVxuPpMprlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,237,1635177600"; 
   d="scan'208";a="119563878"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Dec 2021 22:35:10 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 237F94D13BFD;
        Sun, 26 Dec 2021 22:35:04 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 26 Dec 2021 22:35:06 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 26 Dec 2021 22:35:06 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 26 Dec 2021 22:35:01 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 03/10] mm: factor helpers for memory_failure_dev_pagemap
Date:   Sun, 26 Dec 2021 22:34:32 +0800
Message-ID: <20211226143439.3985960-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 237F94D13BFD.AFF50
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

memory_failure_dev_pagemap code is a bit complex before introduce RMAP
feature for fsdax.  So it is needed to factor some helper functions to
simplify these code.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/memory-failure.c | 141 ++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 64 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 07c875fdeaf0..1ee7d626fed7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1449,6 +1449,80 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
 	return 0;
 }
 
+static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
+		struct address_space *mapping, pgoff_t index, int flags)
+{
+	struct to_kill *tk;
+	unsigned long size = 0;
+
+	list_for_each_entry(tk, to_kill, nd)
+		if (tk->size_shift)
+			size = max(size, 1UL << tk->size_shift);
+
+	if (size) {
+		/*
+		 * Unmap the largest mapping to avoid breaking up device-dax
+		 * mappings which are constant size. The actual size of the
+		 * mapping being torn down is communicated in siginfo, see
+		 * kill_proc()
+		 */
+		loff_t start = (index << PAGE_SHIFT) & ~(size - 1);
+
+		unmap_mapping_range(mapping, start, size, 0);
+	}
+
+	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
+}
+
+static int mf_generic_kill_procs(unsigned long long pfn, int flags,
+		struct dev_pagemap *pgmap)
+{
+	struct page *page = pfn_to_page(pfn);
+	LIST_HEAD(to_kill);
+	dax_entry_t cookie;
+
+	/*
+	 * Prevent the inode from being freed while we are interrogating
+	 * the address_space, typically this would be handled by
+	 * lock_page(), but dax pages do not use the page lock. This
+	 * also prevents changes to the mapping of this pfn until
+	 * poison signaling is complete.
+	 */
+	cookie = dax_lock_page(page);
+	if (!cookie)
+		return -EBUSY;
+
+	if (hwpoison_filter(page))
+		return 0;
+
+	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
+		/*
+		 * TODO: Handle HMM pages which may need coordination
+		 * with device-side memory.
+		 */
+		return -EBUSY;
+	}
+
+	/*
+	 * Use this flag as an indication that the dax page has been
+	 * remapped UC to prevent speculative consumption of poison.
+	 */
+	SetPageHWPoison(page);
+
+	/*
+	 * Unlike System-RAM there is no possibility to swap in a
+	 * different physical page at a given virtual address, so all
+	 * userspace consumption of ZONE_DEVICE memory necessitates
+	 * SIGBUS (i.e. MF_MUST_KILL)
+	 */
+	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
+	collect_procs(page, &to_kill, true);
+
+	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
+	dax_unlock_page(page, cookie);
+	return 0;
+}
+
 static int memory_failure_hugetlb(unsigned long pfn, int flags)
 {
 	struct page *p = pfn_to_page(pfn);
@@ -1538,12 +1612,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
-	unsigned long size = 0;
-	struct to_kill *tk;
 	LIST_HEAD(tokill);
-	int rc = -EBUSY;
-	loff_t start;
-	dax_entry_t cookie;
+	int rc = -ENXIO;
 
 	if (flags & MF_COUNT_INCREASED)
 		/*
@@ -1552,67 +1622,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		put_page(page);
 
 	/* device metadata space is not recoverable */
-	if (!pgmap_pfn_valid(pgmap, pfn)) {
-		rc = -ENXIO;
-		goto out;
-	}
-
-	/*
-	 * Prevent the inode from being freed while we are interrogating
-	 * the address_space, typically this would be handled by
-	 * lock_page(), but dax pages do not use the page lock. This
-	 * also prevents changes to the mapping of this pfn until
-	 * poison signaling is complete.
-	 */
-	cookie = dax_lock_page(page);
-	if (!cookie)
+	if (!pgmap_pfn_valid(pgmap, pfn))
 		goto out;
 
-	if (hwpoison_filter(page)) {
-		rc = 0;
-		goto unlock;
-	}
-
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
-		/*
-		 * TODO: Handle HMM pages which may need coordination
-		 * with device-side memory.
-		 */
-		goto unlock;
-	}
-
-	/*
-	 * Use this flag as an indication that the dax page has been
-	 * remapped UC to prevent speculative consumption of poison.
-	 */
-	SetPageHWPoison(page);
-
-	/*
-	 * Unlike System-RAM there is no possibility to swap in a
-	 * different physical page at a given virtual address, so all
-	 * userspace consumption of ZONE_DEVICE memory necessitates
-	 * SIGBUS (i.e. MF_MUST_KILL)
-	 */
-	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
-
-	list_for_each_entry(tk, &tokill, nd)
-		if (tk->size_shift)
-			size = max(size, 1UL << tk->size_shift);
-	if (size) {
-		/*
-		 * Unmap the largest mapping to avoid breaking up
-		 * device-dax mappings which are constant size. The
-		 * actual size of the mapping being torn down is
-		 * communicated in siginfo, see kill_proc()
-		 */
-		start = (page->index << PAGE_SHIFT) & ~(size - 1);
-		unmap_mapping_range(page->mapping, start, size, 0);
-	}
-	kill_procs(&tokill, flags & MF_MUST_KILL, false, pfn, flags);
-	rc = 0;
-unlock:
-	dax_unlock_page(page, cookie);
+	rc = mf_generic_kill_procs(pfn, flags, pgmap);
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
-- 
2.34.1



