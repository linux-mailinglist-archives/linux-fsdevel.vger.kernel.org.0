Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00507465FE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 09:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356380AbhLBIwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 03:52:47 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52057 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1356285AbhLBIwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:52:37 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AIU7MkKtLihByASzzcDmlmmRFHefnVD1fMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3zGtLWmyCbP+CNGL3f41zbYrnpE5U78OBzNMwQQU5rStgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8hGQ6YnSHuClUbS?=
 =?us-ascii?q?cYHgoLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm6JzIlhyfKiOEL/JGSRte0Zcj0up+H2B?=
 =?us-ascii?q?C3fICLzUKdBqCm6S9x7fTYulnhuwiKsfxNY8Ss30myivWZd4qSJaFQePV5Ntc3?=
 =?us-ascii?q?T41nehPG+rTY4wSbj8HRBjCfBpJNX8UBYg4kePugWPwGxVcqVSIte8y5kDQ0gV?=
 =?us-ascii?q?60/7qKtW9UtqUScRQm26cp3na5CL9AxcHJJqTxCTt2nClgOKJliPmcIUIHba8+?=
 =?us-ascii?q?7hhh1j77mgSDgAGEFWgrfSnh0qWRd1SMQoX9zAooKx081akJvH5XhulsDuHswQ?=
 =?us-ascii?q?aVt54DeI38keOx7DS7gLfAXILJhZFado7pIomSycCyFCEhZXqCCZpvbnTTmiSn?=
 =?us-ascii?q?op4Bxva1TM9dDdEPHFbC1BepYSLnW36tTqXJv4LLUJ/poSd9enM/g23?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A5phM1KFbcXWr50J9pLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="118319110"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Dec 2021 16:49:10 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 3BD124D13A1B;
        Thu,  2 Dec 2021 16:49:05 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Dec 2021 16:49:03 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Dec 2021 16:49:05 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 2 Dec 2021 16:49:02 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v8 6/9] mm: Introduce mf_dax_kill_procs() for fsdax case
Date:   Thu, 2 Dec 2021 16:48:53 +0800
Message-ID: <20211202084856.1285285-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
References: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3BD124D13A1B.A1402
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
index b3c737aff9de..66366ba83ffc 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -853,16 +853,6 @@ static void *dax_insert_entry(struct xa_state *xas,
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
index 7e75d2c45f78..500d048d444e 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -254,6 +254,15 @@ static inline bool dax_mapping(struct address_space *mapping)
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
index a7e4a9e7d807..8a48097d5fb8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3221,6 +3221,8 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 };
+extern int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
+			     unsigned long count, int mf_flags);
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3cc612b29f89..0daab294444b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -303,10 +303,9 @@ void shake_page(struct page *p)
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
-static unsigned long dev_pagemap_mapping_shift(struct page *page,
+static unsigned long dev_pagemap_mapping_shift(unsigned long address,
 		struct vm_area_struct *vma)
 {
-	unsigned long address = vma_address(page, vma);
 	unsigned long ret = 0;
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -346,7 +345,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
-static void add_to_kill(struct task_struct *tsk, struct page *p,
+static void add_to_kill(struct task_struct *tsk, struct page *p, pgoff_t pgoff,
 		       struct vm_area_struct *vma,
 		       struct list_head *to_kill)
 {
@@ -359,9 +358,15 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
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
@@ -509,7 +514,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -545,7 +550,32 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
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
2.34.0



