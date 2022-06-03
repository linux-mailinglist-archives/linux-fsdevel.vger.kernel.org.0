Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAF153C45B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 07:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbiFCFhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 01:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiFCFhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:37:51 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 148312873A;
        Thu,  2 Jun 2022 22:37:45 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AbCmCqq1M7JuFZmOvw/bD5VJwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJh2h0hjEFxmEXC26FM6yIZ2rxf912Pt/i9BgE7cWGnN82QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfvQH+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfouOZcSbg4Jz7I0ruNiGEL+9VJE0/I4wU0uhtBmR?=
 =?us-ascii?q?J7/YZNHYGaRXrr+a3xre6Q+5si+wjMcD0MYJZsXZlpRnZBvYOQJbNWazG6NZUm?=
 =?us-ascii?q?jAqiahmAvfaY9sxaDxhdh3MbhRDfFANB/oWkO6uwHu5bDxcrFOcoLEf4m7PwQg?=
 =?us-ascii?q?327/oWPLZeMONQ8p9nUuCoG/CuWPjDXkyMN2Z1CrA93eEhfHGliC9X5gdfJWx9?=
 =?us-ascii?q?eZvqFmSwHEDTRMRSF23qOW4jUj4XMhQQ2QS5CYvqK0a8E2wUsK7Wxy+vW7CshM?=
 =?us-ascii?q?CM/JQGO0S7BqRjKbZiy6fD28VR3hBb8Ynu9I9RT0C0FKC2djuAFRHsrSTRDSW9?=
 =?us-ascii?q?qq8qim7MiwYa2QFYEcsVwQC59X8sYcblQ/UQ5BvHcaditzzBCG1zSuGoTYzg50?=
 =?us-ascii?q?NgsMRkaa251bKh3SrvJehZgo04BjHG2Go9AV0YKa7aIGyr1vW9/BNKMCeVFbpl?=
 =?us-ascii?q?HwFndWOqfAAFrmTmyGXBuYABrek47CCKjK0qUBuBZ4J5Tmr+mDleYFW/SE4I11?=
 =?us-ascii?q?mdNsHEQIFyme7VRh5vccVZSX1K/QsJd/ZNijj9oC4ffyNaxweRoMmjkBNSTK6?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AcdLwSKBufTgKKjDlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124686798"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2022 13:37:44 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id EEC204D17199;
        Fri,  3 Jun 2022 13:37:42 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:41 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:43 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Jun 2022 13:37:42 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <akpm@linux-foundation.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 02/14] mm: factor helpers for memory_failure_dev_pagemap
Date:   Fri, 3 Jun 2022 13:37:26 +0800
Message-ID: <20220603053738.1218681-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: EEC204D17199.A22E2
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
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 167 ++++++++++++++++++++++++--------------------
 1 file changed, 92 insertions(+), 75 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 36072c10658a..b39424da7625 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1502,6 +1502,95 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
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
+	int rc = 0;
+
+	/*
+	 * Pages instantiated by device-dax (not filesystem-dax)
+	 * may be compound pages.
+	 */
+	page = compound_head(page);
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
+	if (hwpoison_filter(page)) {
+		rc = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+		/*
+		 * TODO: Handle device pages which may need coordination
+		 * with device-side memory.
+		 */
+		rc = -ENXIO;
+		goto unlock;
+	default:
+		break;
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
+unlock:
+	dax_unlock_page(page, cookie);
+	return rc;
+}
+
 /*
  * Called from hugetlb code with hugetlb_lock held.
  *
@@ -1636,12 +1725,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
-	unsigned long size = 0;
-	struct to_kill *tk;
-	LIST_HEAD(tokill);
-	int rc = -EBUSY;
-	loff_t start;
-	dax_entry_t cookie;
+	int rc = -ENXIO;
 
 	if (flags & MF_COUNT_INCREASED)
 		/*
@@ -1650,77 +1734,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		put_page(page);
 
 	/* device metadata space is not recoverable */
-	if (!pgmap_pfn_valid(pgmap, pfn)) {
-		rc = -ENXIO;
-		goto out;
-	}
-
-	/*
-	 * Pages instantiated by device-dax (not filesystem-dax)
-	 * may be compound pages.
-	 */
-	page = compound_head(page);
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
-		rc = -EOPNOTSUPP;
-		goto unlock;
-	}
-
-	switch (pgmap->type) {
-	case MEMORY_DEVICE_PRIVATE:
-	case MEMORY_DEVICE_COHERENT:
-		/*
-		 * TODO: Handle device pages which may need coordination
-		 * with device-side memory.
-		 */
-		goto unlock;
-	default:
-		break;
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
-	collect_procs(page, &tokill, true);
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
-	kill_procs(&tokill, true, false, pfn, flags);
-	rc = 0;
-unlock:
-	dax_unlock_page(page, cookie);
+	rc = mf_generic_kill_procs(pfn, flags, pgmap);
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
-- 
2.36.1



