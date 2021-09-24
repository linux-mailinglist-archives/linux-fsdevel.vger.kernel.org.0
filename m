Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C5417563
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbhIXNVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 09:21:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45104 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345993AbhIXNVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:21:08 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A2dMWUa5x7PHHbJRae7CpEQxRtFPGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENSgjEHmmRKXGvVM6mONGX0Lo1+Pdjko05TvpOEm9c3HFA5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9b9ANkVEmjfvRHuumVLa?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCTu6JPPkhKun3zEhq8G4FsNFYER5Od7KW9?=
 =?us-ascii?q?U8vkfMjoMclaIgOfe6LKwSsFtgMo5JcXmNY9ZvWtvpRnVBPBgQ9bcQqHO5NZdx?=
 =?us-ascii?q?x8xgNxDGbDVYM9xQTZtcxPGbDVMN00RBZZ4m/2n7lH7cjtFuBeQoII0/WHYz0p?=
 =?us-ascii?q?2yreFGNzLdt2PQO1Rn12EvSTC/mLkElcWOcL34TiM9H/qje/StSThUYkWGfuz8?=
 =?us-ascii?q?fsCqFmSwHEDTRMNWValrP2RlEGzQZRcJlYS9y5oqrI9nGSvT9/gT1i7rWSCsxo?=
 =?us-ascii?q?0RdVdCas55RuLx66S5ByWbkAATzhceJk2utQeWzMnzBmKksnvCDgpt6eaIU9xX?=
 =?us-ascii?q?J/8QSiaYHBTdDFdI3RfC1Zt3jUqm6lr5jqnczqpOPTdYgXJJAzN?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AxKatbqiOV12Qtb7XlqI+vFXdQXBQXj4ji2hC?=
 =?us-ascii?q?6mlwRA09TySZ//rBoB19726TtN9xYgBYpTnuAsm9qB/nmaKdpLNhWItKPzOW31?=
 =?us-ascii?q?dATrsSjrcKqgeIc0aVm9K1l50QF5SWY+eQMbEVt6nHCXGDYrQdKce8gd2VrNab?=
 =?us-ascii?q?33FwVhtrdq0lyw94DzyQGkpwSBIuP+tDKLOsotpAuyG7eWkaKuCyBnw+VeDFoN?=
 =?us-ascii?q?HR0L38ZxpuPW9c1CC+ySOv9KXhEwWVmjMXUzZ0y78k9mTf1yzVj5/Ty82G9g?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.85,319,1624291200"; 
   d="scan'208";a="114917457"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Sep 2021 21:10:30 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 14FE94CE84EF;
        Fri, 24 Sep 2021 21:10:24 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 24 Sep 2021 21:10:25 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 24 Sep 2021 21:10:22 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v7 6/8] mm: Introduce mf_dax_kill_procs() for fsdax case
Date:   Fri, 24 Sep 2021 21:09:57 +0800
Message-ID: <20210924130959.2695749-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 14FE94CE84EF.A71B8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is called at the end of RMAP routine, i.e. filesystem
recovery function, to collect and kill processes using a shared page of
DAX file.  The difference between mf_generic_kill_procs() is,
it accepts file's mapping,offset instead of struct page.  Because
different file's mappings and offsets may share the same page in fsdax
mode.  So, it is called when filesystem RMAP results are found.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c            | 10 ------
 include/linux/dax.h |  9 +++++
 include/linux/mm.h  |  2 ++
 mm/memory-failure.c | 83 ++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 86 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 509b65e60478..2536c105ec7f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -852,16 +852,6 @@ static void *dax_insert_entry(struct xa_state *xas,
 	return entry;
 }
 
-static inline
-unsigned long pgoff_address(pgoff_t pgoff, struct vm_area_struct *vma)
-{
-	unsigned long address;
-
-	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
-	return address;
-}
-
 /* Walk all mappings of a given index of a file and writeprotect them */
 static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 		unsigned long pfn)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 65411bee4312..3d90becbd160 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -258,6 +258,15 @@ static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
 }
+static inline unsigned long pgoff_address(pgoff_t pgoff,
+		struct vm_area_struct *vma)
+{
+	unsigned long address;
+
+	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
+	return address;
+}
 
 #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
 void hmem_register_device(int target_nid, struct resource *r);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 73a52aba448f..d06af0051e53 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3114,6 +3114,8 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 };
+extern int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
+			     size_t size, int flags);
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 85eab206b68f..a9d0d487d205 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -302,10 +302,9 @@ void shake_page(struct page *p)
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
-static unsigned long dev_pagemap_mapping_shift(struct page *page,
+static unsigned long dev_pagemap_mapping_shift(unsigned long address,
 		struct vm_area_struct *vma)
 {
-	unsigned long address = vma_address(page, vma);
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -345,7 +344,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
-static void add_to_kill(struct task_struct *tsk, struct page *p,
+static void add_to_kill(struct task_struct *tsk, struct page *p, pgoff_t pgoff,
 		       struct vm_area_struct *vma,
 		       struct list_head *to_kill)
 {
@@ -358,9 +357,15 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	}
 
 	tk->addr = page_address_in_vma(p, vma);
-	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
-	else
+	if (is_zone_device_page(p)) {
+		/*
+		 * Since page->mapping is no more used for fsdax, we should
+		 * calculate the address in a fsdax way.
+		 */
+		if (p->pgmap->type == MEMORY_DEVICE_FS_DAX)
+			tk->addr = pgoff_address(pgoff, vma);
+		tk->size_shift = dev_pagemap_mapping_shift(tk->addr, vma);
+	} else
 		tk->size_shift = page_shift(compound_head(p));
 
 	/*
@@ -508,7 +513,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -544,7 +549,32 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
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
+static void collect_procs_fsdax(struct page *page, struct address_space *mapping,
+		pgoff_t pgoff, struct list_head *to_kill)
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
@@ -1503,6 +1533,43 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	return 0;
 }
 
+/**
+ * mf_dax_kill_procs - Collect and kill processes who are using this file range
+ * @mapping:	the file in use
+ * @index:	start offset of the range
+ * @size:	length of the range
+ * @flags:	memory failure flags
+ */
+int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
+		size_t size, int flags)
+{
+	LIST_HEAD(to_kill);
+	dax_entry_t cookie;
+	struct page *page;
+	size_t end = (index << PAGE_SHIFT) + size;
+
+	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
+
+	for (; (index << PAGE_SHIFT) < end; index++) {
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
+				index, flags);
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
2.33.0



