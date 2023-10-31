Return-Path: <linux-fsdevel+bounces-1676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9557DD874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 23:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01051C20D41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 22:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2FB2744C;
	Tue, 31 Oct 2023 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRyJwryH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BAB27461
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 22:38:54 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B9102
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 15:38:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so6390118276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 15:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698791930; x=1699396730; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnEX3Ipnl6U3xsx2QZl+mCo0I6dOB/z20ZQd7gIgRzQ=;
        b=zRyJwryHhtBqmEh8vsQ2HmeGOQ2j3Cepr2seMLAugs2uwFWqMoYeDeLXDJZecfL8E+
         c77FjPJr/AvZLFAdS55nYUF4G8kuF8y7JLe3E+zQLyiqCCNtPjQt5+yx3AxOGBvL7AVM
         yEw2NsT2IzXKFurF7/FgNYXjBaOXVYJX/9ocIMR7cyQ4448qefl8OW1+D3rDLEq0c06K
         6oSPbpc2EA56mZv7b9E9XB9Nqesfa2I+XQuRJRGzWtqmxqZc6usGmD2LDbfgJsv6Et5C
         tUY6xEd+XM2FXTmiehNb/LigsO9NxY1dCUay25nJMYkt0Ib8xOc2yqOXGcBIPfIDxJI9
         BcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791930; x=1699396730;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnEX3Ipnl6U3xsx2QZl+mCo0I6dOB/z20ZQd7gIgRzQ=;
        b=Yx55/Tdgj6LR4vjZPnXBq5YINg3Y4nRZiqTC0HkG8s02THreTZY+peq5ceAlaVcD0S
         lneEHwd79KzMSy3aXjEtJGNeCw3wL8b1TQWd9GEjybfB/5NeBJtZ675lL0KkZrT8Q7DI
         D1TWzr6lEWmPVrctItWLiC2Hp6hqG5YUMbwv7DSiHRgmu2askxyUPzz/YD7DW85YnHbk
         dnhTMgYOKPp9gJr7VHFYrhZv/lu9+qJ26UhLjLFQo43ufWieb1fLq0bSFhuzvCkJhl7K
         wSSaNwuelYvR6NuxdQ4eofOiPr+M+L046VZ65jAluNhL+w2isVpfvN1ySindTTjs4ex1
         aZww==
X-Gm-Message-State: AOJu0Ywe6KHUL8bsNl6xXd4uaekvui2kQobiFdT19xkS3TaHPaxX4PiO
	gk/w7CmrqLxGvbHdt1aw9lNVKknevPms7gUX0g==
X-Google-Smtp-Source: AGHT+IHFyNsZ+MrJsyXfzlDZ6K4oNRulgdq3qzq5cSwz+kfiHPrH6AuLmBgt3mHyZYO8LhTrq4g2ahFlSRm+f+YQqQ==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:84c2:bfa0:7c62:5d77])
 (user=souravpanda job=sendgmr) by 2002:a25:aa47:0:b0:d9a:d272:ee58 with SMTP
 id s65-20020a25aa47000000b00d9ad272ee58mr254454ybi.9.1698791930521; Tue, 31
 Oct 2023 15:38:50 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:38:46 -0700
In-Reply-To: <20231031223846.827173-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231031223846.827173-1-souravpanda@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031223846.827173-2-souravpanda@google.com>
Subject: [PATCH v4 1/1] mm: report per-page metadata information
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
 mm/hugetlb_vmemmap.c               |  8 ++++++--
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  3 +++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 24 ++++++++++++++++++++++
 13 files changed, 94 insertions(+), 14 deletions(-)

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
index 1301ba7b2c9a..cd3158a9c7f3 100644
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
+	__node_stat_add_folio(folio, NR_PAGE_METADATA)
+#endif
 	__count_vm_event(HTLB_BUDDY_PGALLOC);
-	return page_folio(page);
+	return folio;
 }
 
 /*
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4b9734777f69..804a93d18cab 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -214,6 +214,7 @@ static inline void free_vmemmap_page(struct page *page)
 		free_bootmem_page(page);
 	else
 		__free_page(page);
+	__mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA, -1);
 }
 
 /* Free a list of the vmemmap pages */
@@ -336,6 +337,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, &vmemmap_pages);
 	}
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, 1);
 
 	/*
 	 * In order to make remapping routine most efficient for the huge pages,
@@ -381,14 +383,16 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 				   struct list_head *list)
 {
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_THISNODE;
-	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
+	unsigned long nr_pages = DIV_ROUND_UP(end - start, PAGE_SIZE);
 	int nid = page_to_nid((struct page *)start);
 	struct page *page, *next;
+	int i;
 
-	while (nr_pages--) {
+	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
 		if (!page)
 			goto out;
+		__mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA, 1);
 		list_add_tail(&page->lru, list);
 	}
 
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


