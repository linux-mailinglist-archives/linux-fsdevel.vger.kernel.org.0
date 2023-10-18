Return-Path: <linux-fsdevel+bounces-579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA47CD183
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 02:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0924528149B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 00:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D91630;
	Wed, 18 Oct 2023 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8YzATMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376D11115
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 00:55:56 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9721B103
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 17:55:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7d261a84bso98397517b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 17:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697590553; x=1698195353; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0Cb4elSVrghZeaEmzaKnxbinz3u4bbJ3+pTg0JzeAo=;
        b=l8YzATMDAK+NC2BU4mscsiQAiuCIOP81CTBVoLZtzP2G4SF0kn8Gnq79IXuuPRWbvh
         UHDQx/0EUoL4OxmgVtz3+Vgs+N4kkaYFZVJAjxTvQ939SGknXS/UYN3jRHKO1rtX6q02
         7Cy1sODUl1/zmY7dSO2mqxUO7A5fV6n45fe0Sgwzc4rejBkFmbp2WRaM41h/Dq4M3Rda
         glzVMiFhtfmM/h6Pygqcy90pBxg6gyXF5PMo4r1T+LE3lFFqfnLk+L+Ma8XGNrFj0A5s
         g06mI9KpWATj3t/jM+bhEpWgJSzX5LpCZTZs0/ZqosAvGCymPPRYtyjj4JSr4rjtgd5T
         t2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697590553; x=1698195353;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0Cb4elSVrghZeaEmzaKnxbinz3u4bbJ3+pTg0JzeAo=;
        b=H1PBrw82ochC7/hv9eWNBc9Ug5NwnZPpYcESmQvK+JpyBmGswxb/BVFYzy5zfjPTRJ
         IZdYRW+WCLbv3jLJ+Zi3BG9HLLDQ3C/XS2RfTzsqqQqTaacbNovb76H8tcdKrYOdTBxc
         ojhaTumkqmmxleEampMKSr08gASOJRYGTs3TezBTMpy/6099ZhbvuS5+RKQ8u6d8xsSj
         ei2dt0OgeC92BrX6q84fI8d4otOR/2mbpiFykbZZSiaRQ0O77a6gcIFiAgQLQLXHzJUe
         XZ9/wqWGFjsc3wPh5k1yzUDIaUPOn7N5gn3Of6NKtLPNYw5q78/a3x9eWiy1LEX5ceVk
         SU9g==
X-Gm-Message-State: AOJu0YybX9IXU+SHKplj9NZwtFH2/BFdW9YMZekR6MiCGQx788PNstKz
	dUSCX3cD/Z1HQ/GkCj9Z73w0KcMLYbB2nqy1yw==
X-Google-Smtp-Source: AGHT+IGvTkK0BMYi0UEJrHiyZ5v2xsPS/ktu6SjTQ88mrQ3XwLqITjLAWjm0GZvzuiPoJeLDn2Azw7h0j39zaOyT+A==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:26ea:df99:e4a5:e557])
 (user=souravpanda job=sendgmr) by 2002:a0d:d601:0:b0:59b:f138:c835 with SMTP
 id y1-20020a0dd601000000b0059bf138c835mr100183ywd.5.1697590552803; Tue, 17
 Oct 2023 17:55:52 -0700 (PDT)
Date: Tue, 17 Oct 2023 17:55:48 -0700
In-Reply-To: <20231018005548.3505662-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231018005548.3505662-1-souravpanda@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231018005548.3505662-2-souravpanda@google.com>
Subject: [PATCH v2 1/1] mm: report per-page metadata information
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
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
Change-Id: I4351791c9f4c1e9759cbd8e646e808565dbb595f
---
 Documentation/filesystems/proc.rst |  3 +++
 drivers/base/node.c                |  2 ++
 fs/proc/meminfo.c                  |  7 +++++++
 include/linux/mmzone.h             |  3 +++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb.c                       |  8 +++++++-
 mm/hugetlb_vmemmap.c               |  8 +++++++-
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 28 ++++++++++++++++++++--------
 mm/sparse-vmemmap.c                |  3 +++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 24 ++++++++++++++++++++++++
 13 files changed, 90 insertions(+), 11 deletions(-)

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
index 52d26072dfda..546f8338aa79 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1758,6 +1758,10 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+		__mod_node_page_state(NODE_DATA(page_to_nid(&folio->page)),
+				      NR_PAGE_METADATA, -huge_page_order(h));
+#endif
 		__free_pages(&folio->page, huge_page_order(h));
 	}
 }
@@ -2143,7 +2147,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		__count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
 		return NULL;
 	}
-
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, huge_page_order(h));
+#endif
 	__count_vm_event(HTLB_BUDDY_PGALLOC);
 	return page_folio(page);
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4b9734777f69..71c44d2471d0 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -214,6 +214,8 @@ static inline void free_vmemmap_page(struct page *page)
 		free_bootmem_page(page);
 	else
 		__free_page(page);
+	__mod_node_page_state(NODE_DATA(page_to_nid(page)),
+			      NR_PAGE_METADATA, -1);
 }
 
 /* Free a list of the vmemmap pages */
@@ -336,6 +338,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, &vmemmap_pages);
 	}
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, 1);
 
 	/*
 	 * In order to make remapping routine most efficient for the huge pages,
@@ -384,11 +387,14 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
 	int nid = page_to_nid((struct page *)start);
 	struct page *page, *next;
+	int i;
 
-	while (nr_pages--) {
+	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
 		if (!page)
 			goto out;
+		__mod_node_page_state(NODE_DATA(page_to_nid(page)),
+				      NR_PAGE_METADATA, 1);
 		list_add_tail(&page->lru, list);
 	}
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 50f2f34745af..e02dce7e2e9a 100644
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
+						PAGE_ALIGN(size) >> PAGE_SHIFT);
 	}
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
 				__func__, pgdat->node_id, (unsigned long)pgdat,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 95546f376302..aa3cb96922e9 100644
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
index 4548fcc66d74..825413888112 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
 	total_usage += table_size;
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+			      PAGE_ALIGN(table_size) >> PAGE_SHIFT);
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
+				    PAGE_ALIGN(size) >> PAGE_SHIFT);
+	}
 
 	return addr;
 }
@@ -303,18 +308,25 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
 
 static void free_page_ext(void *addr)
 {
+	size_t table_size;
+	struct page *page;
+
+	table_size = page_ext_size * PAGES_PER_SECTION;
+
 	if (is_vmalloc_addr(addr)) {
+		page = vmalloc_to_page(addr);
 		vfree(addr);
 	} else {
-		struct page *page = virt_to_page(addr);
-		size_t table_size;
-
-		table_size = page_ext_size * PAGES_PER_SECTION;
+		page = virt_to_page(addr);
 
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
+
+	__mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA,
+			      -1L * (PAGE_ALIGN(table_size) >> PAGE_SHIFT));
+
 }
 
 static void __free_page_ext(unsigned long pfn)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a2cbe44c48e1..e33f302db7c6 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -469,5 +469,8 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
+	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+			      PAGE_ALIGN(end - start) >> PAGE_SHIFT);
+
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 77d91e565045..db78233a85ef 100644
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
+	mod_node_early_perpage_metadata(nid, PAGE_ALIGN(size) >> PAGE_SHIFT);
+#endif
 }
 
 static void __init sparse_buffer_fini(void)
@@ -641,6 +644,8 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
+	__mod_node_page_state(NODE_DATA(page_to_nid(pfn_to_page(pfn))), NR_PAGE_METADATA,
+			      (long)-1 * (PAGE_ALIGN(end - start) >> PAGE_SHIFT));
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
2.42.0.655.g421f12c284-goog


