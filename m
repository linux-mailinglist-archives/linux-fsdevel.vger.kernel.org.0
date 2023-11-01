Return-Path: <linux-fsdevel+bounces-1775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169E7DE8C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 00:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30A51C20E5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 23:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD61C29D;
	Wed,  1 Nov 2023 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ku3Y5xja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C081BDEF
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 23:08:23 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28038119
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 16:08:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b3715f3b41so4933757b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 16:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698880100; x=1699484900; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0gcz8AW4zvPHLQTqCYbDOSbq2MMNlZxNadTxx7b2u8=;
        b=Ku3Y5xjasa3/L70JqvoI6kdkW+X5Vj4G2XjZn0TdmboOCYMTrxi0CMK0GJ1CDLbPYa
         60227b0KCS8ndl6IPOFt3V0w0ND/H0JpLAI/0OdJeh1btViqJlZgmmqQa8pPdKy5+bgh
         Fo9YPqhcS9r56l1rmQoK3/RAepm55EXLXp97rUQbIOL58dm3NQIOmRwFtnziZR3zaNty
         1jeeSEpYOtwz8Q5gRC7l3il6I7SH9OJi93nWHswFTOYEbCuawo/nAZ2Lkm9KHs7hlzQm
         2c3XXu7LkVBW8H9XFRzDO4YGQkQoFktulXgfSfSUfJZelyCbQpKNzafWWHGqOuRE2Gqe
         W2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698880100; x=1699484900;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0gcz8AW4zvPHLQTqCYbDOSbq2MMNlZxNadTxx7b2u8=;
        b=aA9iG4KlXwYoRcRZtCmRdggFkYiIhCysORAkqWb//4IvA3VYVI+GyvgijK4/s81tVj
         eecM5tHqa8y3bYzO6PYQS45KyVV5M/A3kQfFr+7MCGy1LlvQ52UXt6P2Ci8nhoZhOtzo
         HZwlFlZwmq/wPnQm0rGIl7LddcbCL4qXIWGkgpEvOKUCYrAs0GyW+RnplAwYRZrkz4Dn
         ulU2gRXy5DDZ6DYr8gpjz8+BEIzdIhLobfyrGoSsqmtlc+1v6U5w1dWV6sP+ExGSJB2l
         ZIoEY9agxj0Es/VqbBv8KqhRUlwVFx/ViGq9oVVEzZjox9kvwrcJFMw1Po4Le/p/wk2A
         Hlkg==
X-Gm-Message-State: AOJu0YwKyZVWmAnaXQy85jbOgFn5yGyanU3H7cACGjWK+tutPEaHo+Li
	53dAlYpcnvsAKj+AeljTb/YK6nr4fR30D//J8Q==
X-Google-Smtp-Source: AGHT+IGnyBfvMS0p9W7NibXU3RDwNk84FnT4J6JqsT9TUqPt5Hl7KZW1fEOngRcvI65hVykkxLDjTYqGJMz6qu5PiA==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:9bf9:be0e:41ed:e474])
 (user=souravpanda job=sendgmr) by 2002:a0d:d443:0:b0:5a8:6397:5bd6 with SMTP
 id w64-20020a0dd443000000b005a863975bd6mr352788ywd.3.1698880100406; Wed, 01
 Nov 2023 16:08:20 -0700 (PDT)
Date: Wed,  1 Nov 2023 16:08:16 -0700
In-Reply-To: <20231101230816.1459373-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231101230816.1459373-2-souravpanda@google.com>
Subject: [PATCH v5 1/1] mm: report per-page metadata information
From: Sourav Panda <souravpanda@google.com>
To: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, souravpanda@google.com, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, hannes@cmpxchg.org, 
	shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@Oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"

Adds a new per-node PageMetadata field to
/sys/devices/system/node/nodeN/meminfo
and a global PageMetadata field to /proc/meminfo. This information can
be used by users to see how much memory is being used by per-page
metadata, which can vary depending on build configuration, machine
architecture, and system use.

Per-page metadata is the amount of memory that Linux needs in order to
manage memory at the page granularity. The majority of such memory is
used by "struct page" and "page_ext" data structures. In contrast to
most other memory consumption statistics, per-page metadata might not
be included in MemTotal. For example, MemTotal does not include memblock
allocations but includes buddy allocations. While on the other hand,
per-page metadata would include both memblock and buddy allocations.

This memory depends on build configurations, machine architectures, and
the way system is used:

Build configuration may include extra fields into "struct page",
and enable / disable "page_ext"
Machine architecture defines base page sizes. For example 4K x86,
8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
overhead is smaller on machines with larger page sizes.
System use can change per-page overhead by using vmemmap
optimizations with hugetlb pages, and emulated pmem devdax pages.
Also, boot parameters can determine whether page_ext is needed
to be allocated. This memory can be part of MemTotal or be outside
MemTotal depending on whether the memory was hot-plugged, booted with,
or hugetlb memory was returned back to the system.

Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 Documentation/filesystems/proc.rst |  3 +++
 drivers/base/node.c                |  2 ++
 fs/proc/meminfo.c                  |  7 +++++++
 include/linux/mmzone.h             |  3 +++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb.c                       | 11 ++++++++--
 mm/hugetlb_vmemmap.c               | 12 +++++++++--
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  3 +++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 24 ++++++++++++++++++++++
 13 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2b59cff8be17..c121f2ef9432 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -987,6 +987,7 @@ Example output. You may not have all of these fields.
     AnonPages:       4654780 kB
     Mapped:           266244 kB
     Shmem:              9976 kB
+    PageMetadata:     513419 kB
     KReclaimable:     517708 kB
     Slab:             660044 kB
     SReclaimable:     517708 kB
@@ -1089,6 +1090,8 @@ Mapped
               files which have been mmapped, such as libraries
 Shmem
               Total memory used by shared memory (shmem) and tmpfs
+PageMetadata
+              Memory used for per-page metadata
 KReclaimable
               Kernel allocations that the kernel will attempt to reclaim
               under memory pressure. Includes SReclaimable (below), and other
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 493d533f8375..da728542265f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -428,6 +428,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d Mapped:         %8lu kB\n"
 			     "Node %d AnonPages:      %8lu kB\n"
 			     "Node %d Shmem:          %8lu kB\n"
+			     "Node %d PageMetadata:   %8lu kB\n"
 			     "Node %d KernelStack:    %8lu kB\n"
 #ifdef CONFIG_SHADOW_CALL_STACK
 			     "Node %d ShadowCallStack:%8lu kB\n"
@@ -458,6 +459,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
 			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
 			     nid, K(i.sharedram),
+			     nid, K(node_page_state(pgdat, NR_PAGE_METADATA)),
 			     nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
 #ifdef CONFIG_SHADOW_CALL_STACK
 			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 45af9a989d40..f141bb2a550d 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -39,7 +39,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	long available;
 	unsigned long pages[NR_LRU_LISTS];
 	unsigned long sreclaimable, sunreclaim;
+	unsigned long nr_page_metadata;
 	int lru;
+	int nid;
 
 	si_meminfo(&i);
 	si_swapinfo(&i);
@@ -57,6 +59,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
 	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
 
+	nr_page_metadata = 0;
+	for_each_online_node(nid)
+		nr_page_metadata += node_page_state(NODE_DATA(nid), NR_PAGE_METADATA);
+
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
 	show_val_kb(m, "MemAvailable:   ", available);
@@ -104,6 +110,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Mapped:         ",
 		    global_node_page_state(NR_FILE_MAPPED));
 	show_val_kb(m, "Shmem:          ", i.sharedram);
+	show_val_kb(m, "PageMetadata:   ", nr_page_metadata);
 	show_val_kb(m, "KReclaimable:   ", sreclaimable +
 		    global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
 	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..dda1ad522324 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -207,6 +207,9 @@ enum node_stat_item {
 	PGPROMOTE_SUCCESS,	/* promote successfully */
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
 #endif
+	NR_PAGE_METADATA,	/* Page metadata size (struct page and page_ext)
+				 * in pages
+				 */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fed855bae6d8..af096a881f03 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -656,4 +656,8 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
 {
 	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
 }
+
+void __init mod_node_early_perpage_metadata(int nid, long delta);
+void __init store_early_perpage_metadata(void);
+
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1301ba7b2c9a..1778e02ed583 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1790,6 +1790,9 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+		__node_stat_sub_folio(folio, NR_PAGE_METADATA);
+#endif
 		__free_pages(&folio->page, huge_page_order(h));
 	}
 }
@@ -2125,6 +2128,7 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	struct page *page;
 	bool alloc_try_hard = true;
 	bool retry = true;
+	struct folio *folio;
 
 	/*
 	 * By default we always try hard to allocate the page with
@@ -2175,9 +2179,12 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		__count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
 		return NULL;
 	}
-
+	folio = page_folio(page);
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+	__node_stat_add_folio(folio, NR_PAGE_METADATA);
+#endif
 	__count_vm_event(HTLB_BUDDY_PGALLOC);
-	return page_folio(page);
+	return folio;
 }
 
 /*
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4b9734777f69..f7ca5d4dd583 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -214,6 +214,7 @@ static inline void free_vmemmap_page(struct page *page)
 		free_bootmem_page(page);
 	else
 		__free_page(page);
+	__mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA, -1);
 }
 
 /* Free a list of the vmemmap pages */
@@ -335,6 +336,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, &vmemmap_pages);
+		__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, 1);
 	}
 
 	/*
@@ -384,14 +386,20 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
 	int nid = page_to_nid((struct page *)start);
 	struct page *page, *next;
+	int i;
 
-	while (nr_pages--) {
+	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page)
+		if (!page) {
+			__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+					      i);
 			goto out;
+		}
 		list_add_tail(&page->lru, list);
 	}
 
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, nr_pages);
+
 	return 0;
 out:
 	list_for_each_entry_safe(page, next, list, lru)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 50f2f34745af..6997bf00945b 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
+#include <linux/vmstat.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -1656,6 +1657,8 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 			panic("Failed to allocate %ld bytes for node %d memory map\n",
 			      size, pgdat->node_id);
 		pgdat->node_mem_map = map + offset;
+		mod_node_early_perpage_metadata(pgdat->node_id,
+						DIV_ROUND_UP(size, PAGE_SIZE));
 	}
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
 				__func__, pgdat->node_id, (unsigned long)pgdat,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 85741403948f..522dc0c52610 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5443,6 +5443,7 @@ void __init setup_per_cpu_pageset(void)
 	for_each_online_pgdat(pgdat)
 		pgdat->per_cpu_nodestats =
 			alloc_percpu(struct per_cpu_nodestat);
+	store_early_perpage_metadata();
 }
 
 __meminit void zone_pcp_init(struct zone *zone)
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4548fcc66d74..d8d6db9c3d75 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
 	total_usage += table_size;
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+			      DIV_ROUND_UP(table_size, PAGE_SIZE));
 	return 0;
 }
 
@@ -255,12 +257,15 @@ static void *__meminit alloc_page_ext(size_t size, int nid)
 	void *addr = NULL;
 
 	addr = alloc_pages_exact_nid(nid, size, flags);
-	if (addr) {
+	if (addr)
 		kmemleak_alloc(addr, size, 1, flags);
-		return addr;
-	}
+	else
+		addr = vzalloc_node(size, nid);
 
-	addr = vzalloc_node(size, nid);
+	if (addr) {
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+				    DIV_ROUND_UP(size, PAGE_SIZE));
+	}
 
 	return addr;
 }
@@ -303,18 +308,27 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
 
 static void free_page_ext(void *addr)
 {
+	size_t table_size;
+	struct page *page;
+	struct pglist_data *pgdat;
+
+	table_size = page_ext_size * PAGES_PER_SECTION;
+
 	if (is_vmalloc_addr(addr)) {
+		page = vmalloc_to_page(addr);
+		pgdat = page_pgdat(page);
 		vfree(addr);
 	} else {
-		struct page *page = virt_to_page(addr);
-		size_t table_size;
-
-		table_size = page_ext_size * PAGES_PER_SECTION;
-
+		page = virt_to_page(addr);
+		pgdat = page_pgdat(page);
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
+
+	__mod_node_page_state(pgdat, NR_PAGE_METADATA,
+			      -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
+
 }
 
 static void __free_page_ext(unsigned long pfn)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a2cbe44c48e1..2bc67b2c2aa2 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -469,5 +469,8 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+			      DIV_ROUND_UP(end - start, PAGE_SIZE));
+
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 77d91e565045..7f67b5486cd1 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -14,7 +14,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/bootmem_info.h>
-
+#include <linux/vmstat.h>
 #include "internal.h"
 #include <asm/dma.h>
 
@@ -465,6 +465,9 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	 */
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+	mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_SIZE));
+#endif
 }
 
 static void __init sparse_buffer_fini(void)
@@ -641,6 +644,8 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
+	__mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_PAGE_METADATA,
+			      -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 00e81e99c6ee..070d2b3d2bcc 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1245,6 +1245,7 @@ const char * const vmstat_text[] = {
 	"pgpromote_success",
 	"pgpromote_candidate",
 #endif
+	"nr_page_metadata",
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
@@ -2274,4 +2275,27 @@ static int __init extfrag_debug_init(void)
 }
 
 module_init(extfrag_debug_init);
+
 #endif
+
+/*
+ * Page metadata size (struct page and page_ext) in pages
+ */
+static unsigned long early_perpage_metadata[MAX_NUMNODES] __initdata;
+
+void __init mod_node_early_perpage_metadata(int nid, long delta)
+{
+	early_perpage_metadata[nid] += delta;
+}
+
+void __init store_early_perpage_metadata(void)
+{
+	int nid;
+	struct pglist_data *pgdat;
+
+	for_each_online_pgdat(pgdat) {
+		nid = pgdat->node_id;
+		__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+				      early_perpage_metadata[nid]);
+	}
+}
-- 
2.42.0.820.g83a721a137-goog


