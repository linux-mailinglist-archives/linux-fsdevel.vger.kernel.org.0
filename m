Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE27A47F739
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Dec 2021 15:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhLZOfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 09:35:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18877 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233762AbhLZOfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:35:16 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AOrOmBKio0F8qw7LRz3xAiY5uX161CxEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUEmDdJCz+Fa//bYmWkc9l2btyy8BtV75DVmtcxSFRtpXw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOOlUrS?=
 =?us-ascii?q?aYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHm4JHNlB2ZLhMAxN0rVinaJ7Yw9u9pAG1?=
 =?us-ascii?q?m++YfLTcXZBGfwemxxdqTSuJsrsUlItPiMI4Wtjdn1z6xJfovR9bBBbrL4dtZ1?=
 =?us-ascii?q?TIrrsFIAfvaIcEebFJHYBbfZBtAElQaEpQzmKGvnHaXWzlZrk+F4K8yy2vNxQd?=
 =?us-ascii?q?ylr/3P7L9fMKGRMBQtkKZvX7duWD4BAwKctCS11Kt8Huqi6nEnT7TX5gbH7m1s?=
 =?us-ascii?q?PVthTW7wm0VFQ1TW0C3rOe0jmagVN9FbU8Z4Cwjqe417kPDZt38WQCo5X2JpBg?=
 =?us-ascii?q?RX/JOHOAgrgKA0KzZ50CeHGdsZjpAbsE28d84XhQ02VKT2dDkHzpitPuSU331y?=
 =?us-ascii?q?1s+hVteIgBMdSlbO3BCFlBDvrHeTEgIpkqnZr5e/GSd07UZwQ3N/g0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A3VfheK1plKcFAKBFHVottQqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.88,237,1635177600"; 
   d="scan'208";a="119563875"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Dec 2021 22:35:10 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 4E96E4D146F2;
        Sun, 26 Dec 2021 22:35:07 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 26 Dec 2021 22:35:05 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 26 Dec 2021 22:35:09 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 26 Dec 2021 22:35:05 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v9 08/10] mm: Introduce mf_dax_kill_procs() for fsdax case
Date:   Sun, 26 Dec 2021 22:34:37 +0800
Message-ID: <20211226143439.3985960-9-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4E96E4D146F2.A1120
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
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
---
 include/linux/mm.h  |  2 +
 mm/memory-failure.c | 89 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3f44cd9e296c..15212a78bf1d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3234,6 +3234,8 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 };
+int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
+		      unsigned long count, int mf_flags);
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3cc612b29f89..dc61f97bba2f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -303,10 +303,9 @@ void shake_page(struct page *p)
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
@@ -346,9 +345,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
-static void add_to_kill(struct task_struct *tsk, struct page *p,
-		       struct vm_area_struct *vma,
-		       struct list_head *to_kill)
+static void add_to_kill(struct task_struct *tsk, struct page *p, pgoff_t pgoff,
+			struct vm_area_struct *vma, struct list_head *to_kill)
 {
 	struct to_kill *tk;
 
@@ -359,9 +357,15 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
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
+			tk->addr = vma_pgoff_address(vma, pgoff);
+		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
+	} else
 		tk->size_shift = page_shift(compound_head(p));
 
 	/*
@@ -509,7 +513,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -545,7 +549,33 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
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
@@ -1523,6 +1553,43 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	return 0;
 }
 
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
+
 static int memory_failure_hugetlb(unsigned long pfn, int flags)
 {
 	struct page *p = pfn_to_page(pfn);
-- 
2.34.1



