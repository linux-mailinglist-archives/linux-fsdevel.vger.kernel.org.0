Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959DE4C5AEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 13:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiB0MI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 07:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiB0MIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:08:36 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB07724584;
        Sun, 27 Feb 2022 04:07:57 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3A82ZU/K1N+DeMKMbQBPbD5axwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ0jpzgzYBnzZMD2vSaa6Dazb0ed8lPY6y90xSuZDRyt42QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfvQH+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfouWfeifh4ZH7I0ruNiGEL+9VJE0/I4wU0uhtBmR?=
 =?us-ascii?q?J7/YZNHYGaRXrr+K9wJq6TOd2j8guJcWtO5kQ0llsxDefD7A5QJTHQqzP/vdZ2?=
 =?us-ascii?q?is9goZFGvO2T8Ybdj1pYzzDbgdJN1NRD4gx9M+sh3/iY3hdrXqWu6M84C7U1gM?=
 =?us-ascii?q?Z+L7zPNvQf/SORN5JhQCcp2Tb7yL1Dw9yHNyUyRKB6W7qiuKntSHyXo9UH72l3?=
 =?us-ascii?q?vlwiVaXyyoYDxh+fV+6p+Spz0ClV99BJkg85CUjt+4x+VatQ927WAe3yFaAvxg?=
 =?us-ascii?q?BS59THvc85QWl1KXZ+UCaC3ICQzoHb8Yp3OcyRDo3xhqZkcjBGzNiqvuWRGib+?=
 =?us-ascii?q?7PSqim9URX5h0dqiTQsFFNDuoe85tpoyE+nczqqK4bt5vWdJN06623iQPACuog?=
 =?us-ascii?q?u?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AANP46as7AlF8G7kftE7fIMd+7skCW4Mji2hC?=
 =?us-ascii?q?6mlwRA09TyXGra2TdaUgvyMc1gx7ZJhBo7+90ci7MBfhHPtOjbX5Uo3SOTUO1F?=
 =?us-ascii?q?HYTr2KjrGSuwEIeReOj9K1vJ0IG8YeNDSZNykdsS+Q2mmF+rgbsbq6GPfCv5a4?=
 =?us-ascii?q?854hd3AbV4hQqyNCTiqLGEx/QwdLQbI/CZqn/8JC4x6tY24eYMiXDmQMG7Grna?=
 =?us-ascii?q?y4qLvWJTo9QzI34giHij2lrJb8Dhijxx8bFxdC260r/2TpmxHwoo+jr/a44BnB?=
 =?us-ascii?q?0HK71eUkpPLRjv94QOCcgMkcLTvhziyyYp56ZrGEtDcp5Mmy9VcDirD30mEdFv?=
 =?us-ascii?q?U2z0mUUnC+oBPr1QWl+i0p8WXexViRhmamidDlRQg9F9FKietiA2zkAnIbzZlB?=
 =?us-ascii?q?OZ9wrimkX8I9N2KLoM293am9a/hSrDv8nZJ4+tRjwkC2UuMlGcBsRMIkjQ9o+a?=
 =?us-ascii?q?w7bVjHAbAcYZJT5f7nlYtrmHOhHg7kVzpUsa2RtkpaJGb7fqFFgL3h7wRr?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122037685"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Feb 2022 20:07:51 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 30F494D169F2;
        Sun, 27 Feb 2022 20:07:50 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 27 Feb 2022 20:07:52 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 27 Feb 2022 20:07:49 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 2/8] mm: factor helpers for memory_failure_dev_pagemap
Date:   Sun, 27 Feb 2022 20:07:41 +0800
Message-ID: <20220227120747.711169-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 30F494D169F2.A100C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

memory_failure_dev_pagemap code is a bit complex before introduce RMAP
feature for fsdax.  So it is needed to factor some helper functions to
simplify these code.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/memory-failure.c | 141 ++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 64 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14ae5c18e776..98b6144e4b9b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1500,6 +1500,80 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
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
@@ -1576,12 +1650,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
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
@@ -1590,67 +1660,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
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
2.35.1



