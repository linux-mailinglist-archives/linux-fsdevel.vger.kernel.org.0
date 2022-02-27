Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C254A4C5AE8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 13:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiB0MIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 07:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiB0MIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:08:38 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5905289BD;
        Sun, 27 Feb 2022 04:08:00 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3ALkOh56sY8hffymy019qEHzhiaOfnVD1fMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3y2oeX26Oa/eKNGDyfdF0bIm3px8F6pTQm95qHAQ9qX1gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm65bLlBKYIiOEL/JGSRte0Zcj0up+H2B?=
 =?us-ascii?q?C3fICLzUKdBqCm6S9x7fTYulnhuwiKsfxNY8Ss30myivWZd4qSJaFQePV5Ntc3?=
 =?us-ascii?q?T41nehPG+rTY4wSbj8HRBjCfBpJNX8UBYg4kePugWPwGxVcqVSIte8y5kDQ0gV?=
 =?us-ascii?q?60/7qKtW9UtqUScRQm26cp3na5CL9AxcHJJqTxCTt2nClgOKJliPmcIUIHba8+?=
 =?us-ascii?q?7hhh1j77mgSDgAGEFWgrfSnh0qWRd1SMQoX9zAooKx081akJvH5XhulsDuHswQ?=
 =?us-ascii?q?aVt54DeI38keOx7DS7gLfAXILJhZFado7pIomSycCyFCEhZXqCCZpvbnTTmiSn?=
 =?us-ascii?q?op4Bxva1TM9dDdEPHFbC1BepYSLnW36tTqXJv4LLUJ/poCd9enM/g23?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AeOnIvKgpfrQAYAtUGwCY7ma8pHBQX/d13DAb?=
 =?us-ascii?q?v31ZSRFFG/FwyPrCoB1L73XJYWgqM03I+eruBEDgewK5yXcR2+Us1NiZLWzbUQ?=
 =?us-ascii?q?eTXeNfBOjZskXd8k/Fh5dgPM5bGsARaeEYZWIK6/oSizPZLz9P+qjlzEj+7t2u?=
 =?us-ascii?q?qEuFADsaG51I3kNcMEK2A0d2TA5JCd4QE4ed3NNOo36FdW4MZsq2K3EZV6ybzu?=
 =?us-ascii?q?e75q7OUFojPVoK+QOOhTSn5PrTFAWZ5A4XV3dqza05+WbIvgTl7uGIsu29yDXb?=
 =?us-ascii?q?y2jPhq4m6+fJ+59mPoihm8IVIjLjhkKDf4J6QYCPuzgzvaWG9EsquMOkmWZXA+?=
 =?us-ascii?q?1Dr1fqOk2lqxrk3AftlBw07WX59FOeiXz/5eTkWTMBDdZbj44xSGqv16MZhqA1?=
 =?us-ascii?q?7Et35RPTi3IOZimw1hgVpuK4Iy2Cr3DE6EbLyoUo/jFiuYh3Us4vkWVQxjIYLH?=
 =?us-ascii?q?46JlOB1GkWKpgUMCji3ocqTbq7VQGmgoA9+q3cYpwMdi32PnTq/PblpgRroA?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122037690"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Feb 2022 20:07:58 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B4CF64D169F1;
        Sun, 27 Feb 2022 20:07:52 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 27 Feb 2022 20:07:54 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 27 Feb 2022 20:07:52 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v11 6/8] mm: Introduce mf_dax_kill_procs() for fsdax case
Date:   Sun, 27 Feb 2022 20:07:45 +0800
Message-ID: <20220227120747.711169-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B4CF64D169F1.A2232
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

This function is called at the end of RMAP routine, i.e. filesystem
recovery function, to collect and kill processes using a shared page of
DAX file.  The difference with mf_generic_kill_procs() is, it accepts
file's (mapping,offset) instead of struct page because different files'
mappings and offsets may share the same page in fsdax mode.
It will be called when filesystem's RMAP results are found.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h  |  4 ++
 mm/memory-failure.c | 96 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9b1d56c5c224..0420189e4788 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3195,6 +3195,10 @@ enum mf_flags {
 	MF_SOFT_OFFLINE = 1 << 3,
 	MF_UNPOISON = 1 << 4,
 };
+#if IS_ENABLED(CONFIG_FS_DAX)
+int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
+		      unsigned long count, int mf_flags);
+#endif /* CONFIG_FS_DAX */
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8dd2f58c1aa8..2ba79c3869ed 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -304,10 +304,9 @@ void shake_page(struct page *p)
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
-static unsigned long dev_pagemap_mapping_shift(struct page *page,
-		struct vm_area_struct *vma)
+static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
+		unsigned long address)
 {
-	unsigned long address = vma_address(page, vma);
 	unsigned long ret = 0;
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -346,10 +345,14 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
 /*
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
+ *
+ * Notice: @fsdax_pgoff is used only when @p is a fsdax page.
+ *   In other cases, such as anonymous and file-backend page, the address to be
+ *   killed can be caculated by @p itself.
  */
 static void add_to_kill(struct task_struct *tsk, struct page *p,
-		       struct vm_area_struct *vma,
-		       struct list_head *to_kill)
+			pgoff_t fsdax_pgoff, struct vm_area_struct *vma,
+			struct list_head *to_kill)
 {
 	struct to_kill *tk;
 
@@ -360,9 +363,15 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	}
 
 	tk->addr = page_address_in_vma(p, vma);
-	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
-	else
+	if (is_zone_device_page(p)) {
+		/*
+		 * Since page->mapping is not used for fsdax, we need
+		 * calculate the address based on the vma.
+		 */
+		if (p->pgmap->type == MEMORY_DEVICE_FS_DAX)
+			tk->addr = vma_pgoff_address(vma, fsdax_pgoff);
+		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
+	} else
 		tk->size_shift = page_shift(compound_head(p));
 
 	/*
@@ -510,7 +519,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -546,12 +555,40 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, vma, to_kill);
+		}
+	}
+	read_unlock(&tasklist_lock);
+	i_mmap_unlock_read(mapping);
+}
+
+#if IS_ENABLED(CONFIG_FS_DAX)
+/*
+ * Collect processes when the error hit a fsdax page.
+ */
+static void collect_procs_fsdax(struct page *page,
+		struct address_space *mapping, pgoff_t pgoff,
+		struct list_head *to_kill)
+{
+	struct vm_area_struct *vma;
+	struct task_struct *tsk;
+
+	i_mmap_lock_read(mapping);
+	read_lock(&tasklist_lock);
+	for_each_process(tsk) {
+		struct task_struct *t = task_early_kill(tsk, true);
+
+		if (!t)
+			continue;
+		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
+			if (vma->vm_mm == t->mm)
+				add_to_kill(t, page, pgoff, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
 	i_mmap_unlock_read(mapping);
 }
+#endif /* CONFIG_FS_DAX */
 
 /*
  * Collect the processes who have the corrupted page mapped to kill.
@@ -1574,6 +1611,45 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_FS_DAX)
+/**
+ * mf_dax_kill_procs - Collect and kill processes who are using this file range
+ * @mapping:	the file in use
+ * @index:	start pgoff of the range within the file
+ * @count:	length of the range, in unit of PAGE_SIZE
+ * @mf_flags:	memory failure flags
+ */
+int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
+		unsigned long count, int mf_flags)
+{
+	LIST_HEAD(to_kill);
+	dax_entry_t cookie;
+	struct page *page;
+	size_t end = index + count;
+
+	mf_flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
+
+	for (; index < end; index++) {
+		page = NULL;
+		cookie = dax_lock_mapping_entry(mapping, index, &page);
+		if (!cookie)
+			return -EBUSY;
+		if (!page)
+			goto unlock;
+
+		SetPageHWPoison(page);
+
+		collect_procs_fsdax(page, mapping, index, &to_kill);
+		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
+				index, mf_flags);
+unlock:
+		dax_unlock_mapping_entry(mapping, index, cookie);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
+#endif /* CONFIG_FS_DAX */
+
 static int memory_failure_hugetlb(unsigned long pfn, int flags)
 {
 	struct page *p = pfn_to_page(pfn);
-- 
2.35.1



