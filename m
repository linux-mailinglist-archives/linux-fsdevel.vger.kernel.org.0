Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310B153C484
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 07:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiFCFiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 01:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbiFCFh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:37:56 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D98F136E01;
        Thu,  2 Jun 2022 22:37:54 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AuRKkiqqJZhYIM/2tcSU1cf7FvnBeBmKZZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmQYCz+EOarYYmrwfN1zO4y+90NXsZXUyNZrTVBq+C4yQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JbPkR2YIyK1qxlpJARsVWECwc57CH9?=
 =?us-ascii?q?P+dQWMjcIaQqJhv7wy7W+IsFoh8ImLcDsPI43umxp0jzYS/0hRPjrQ67Kzd5e0?=
 =?us-ascii?q?i05is1HEbDZfcVxQSVuaBDRSxxJNE0eBJ83kKGvnHaXWzFRrhSX47U252zSxQl?=
 =?us-ascii?q?q+LnrLNfRPNeNQK19kkSHoWTJ12f0GBcXMJqY0zXt2natgPLf2Cb+cIEMHba7s?=
 =?us-ascii?q?PlwjzW7z28LDTUSVF2msby3jVO4V9tDKksSvC00osAa8lKnT9z4dxm5u2Kf+Bo?=
 =?us-ascii?q?dXcdAVeE39mmlyqHUywKCGi4IQ1ZpbtUhpcZwRTsw11CUlNPoLTpiu/ueTnf13?=
 =?us-ascii?q?rWdqz70MigIBWgYbCQAQE0O5NyLiJs8iRbDUcdlOLWoldCzFTyY6zSLqjUuwrs?=
 =?us-ascii?q?IgcMV2qGT41/KmXSvq4LPQwpz4R/YNkqh7wVkdMumapau5Fzz8/lNNsCaQ0OHs?=
 =?us-ascii?q?XxCnNKRhMgKDJeQhGmdTv4lAr6k/bCGPSfajFopGIMunxyz+mSkVZJd5jBgYkN?=
 =?us-ascii?q?oNNsUPzjzbwnOumtsCDV7VJexRfYvJdvvVIJxlu69fekJn8v8NrJmCqWdvifal?=
 =?us-ascii?q?M22WXOt4g=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ar1HnfqAi9Sh0ojvlHelI55DYdb4zR+YMi2TC?=
 =?us-ascii?q?1yhKJyC9Ffbo8fxG/c5rrCMc5wxwZJhNo7y90ey7MBbhHP1OkO4s1NWZLWrbUQ?=
 =?us-ascii?q?KTRekIh+bfKn/baknDH4VmtJuIHZIQNDSJNykZsS/l2njEL/8QhMmA7LuzhfrT?=
 =?us-ascii?q?i1NkTQRRYalm6AtjYzzraXFedU1XA4YjDpqA6o5irzqkQ34eacO2HT0rRO7Gzu?=
 =?us-ascii?q?e77q7OUFoXAQI98gmSgXeN4L7+KRKR2RATSHdu7N4ZgBD4rzA=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124686811"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2022 13:37:51 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3D6C44D17189;
        Fri,  3 Jun 2022 13:37:45 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:45 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Jun 2022 13:37:45 +0800
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
Subject: [PATCH v2 05/14] mm: Introduce mf_dax_kill_procs() for fsdax case
Date:   Fri, 3 Jun 2022 13:37:29 +0800
Message-ID: <20220603053738.1218681-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3D6C44D17189.AEC45
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

This new function is a variant of mf_generic_kill_procs that accepts a
file, offset pair instead of a struct to support multiple files sharing
a DAX mapping.  It is intended to be called by the file systems as part
of the memory_failure handler after the file system performed a reverse
mapping from the storage address to the file and file offset.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h  |  2 +
 mm/memory-failure.c | 96 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8a96197b9afd..623c2ee8330a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3250,6 +3250,8 @@ enum mf_flags {
 	MF_UNPOISON = 1 << 4,
 	MF_NO_RETRY = 1 << 5,
 };
+int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
+		      unsigned long count, int mf_flags);
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a9d93c30a1e4..5d015e1387bd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -301,10 +301,9 @@ void shake_page(struct page *p)
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
@@ -344,10 +343,14 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
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
 
@@ -358,9 +361,15 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
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
+			tk->addr = vma_pgoff_address(fsdax_pgoff, 1, vma);
+		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
+	} else
 		tk->size_shift = page_shift(compound_head(p));
 
 	/*
@@ -509,7 +518,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -545,13 +554,41 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
 	i_mmap_unlock_read(mapping);
 }
 
+#ifdef CONFIG_FS_DAX
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
+		}
+	}
+	read_unlock(&tasklist_lock);
+	i_mmap_unlock_read(mapping);
+}
+#endif /* CONFIG_FS_DAX */
+
 /*
  * Collect the processes who have the corrupted page mapped to kill.
  */
@@ -1591,6 +1628,45 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	return rc;
 }
 
+#ifdef CONFIG_FS_DAX
+/**
+ * mf_dax_kill_procs - Collect and kill processes who are using this file range
+ * @mapping:	address_space of the file in use
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
 /*
  * Called from hugetlb code with hugetlb_lock held.
  *
-- 
2.36.1



