Return-Path: <linux-fsdevel+bounces-7498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D3825D64
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 01:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08171F245DB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 00:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D41396;
	Sat,  6 Jan 2024 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QibGyKyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06DF10E6
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jan 2024 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso29495ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 16:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704501505; x=1705106305; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUD33VKpxR/NM0Z7MpxcwlTlOFQrCymDr6l5Rozswjk=;
        b=QibGyKytXQf/52ziEP7S001OYKLkgW6EGG3qVXGo8r+9K/ktZUzfw7qfoRthyY1PAp
         yBA+BDfQdhvyzg5cX0lGEcePg1fne1/KkqXNyltO4gXY1wWIME5f42+2f9M1Xep60I11
         tp/hZXzv6Tzq4qDD5SQM731M58HK5CS22F4XXc8vZcZ6euVK6pQmAQ6bTi74kRJKaW+s
         amdKRCctyjfrnmzPHp6Mg0A9DCde54+6HJaN4sI89EKQQBnGvYoIRSqfQpkkdwkXA8XS
         Em51BBt1IuAi3Z4HhBYcNH89mUh0QaMatfDIiJSz8r5F4k7CVphXNWRdBmnfGs6eyJLk
         vBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704501505; x=1705106305;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUD33VKpxR/NM0Z7MpxcwlTlOFQrCymDr6l5Rozswjk=;
        b=WDHpDW7BTYFykHwMhtgMkaGvdXIPclML6/bk7WEiev5PfNGez/6ICyxlChOPiyzmQ9
         kYw94ymdxHfZqTTfffcZ35xQ09MR7dx1p0saG7UvTudmV+kkr/oY6C3UC/P6xtBIu+Hq
         ET48ZfLuKML3Lra3bSVi7PbwN4y57Ul0+Y1wV/Bp3LehOoqYm53lubeXRn1fYwpEhWRH
         MoJO1sDT8NRIb6pcdKvqfVtGcEF77fm/FHuPzJfg9l8BgNWz5IDmdYe2VKaUCmZVfsYp
         Qo9fWNkbLLz9E6pymXZ61nLabdxFVJHp30MOFmBFf3aY8adcv2vNxJnD8/Jhs5HAv+Aw
         GyMw==
X-Gm-Message-State: AOJu0Yw86S5FeCGdKnlD4isUQIdOSKh0q1fqxatcA7xor7q98LOUWmzt
	YF7JS16LwdtxE5bi95U1w1aIuV+jmGUq
X-Google-Smtp-Source: AGHT+IGun2AjNpQEhYtpk7UgWnyqdJ861IR+r/6MI2rt0P4xYDuYpCceEhV6u9wK/p76/7UD4gDpLA==
X-Received: by 2002:a17:903:645:b0:1d3:7db1:388b with SMTP id kh5-20020a170903064500b001d37db1388bmr46427plb.11.1704501504804;
        Fri, 05 Jan 2024 16:38:24 -0800 (PST)
Received: from [2620:0:1008:15:e621:8fdd:e5e:628] ([2620:0:1008:15:e621:8fdd:e5e:628])
        by smtp.gmail.com with ESMTPSA id bb12-20020a170902bc8c00b001d077da4ac4sm1953293plb.212.2024.01.05.16.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 16:38:24 -0800 (PST)
Date: Fri, 5 Jan 2024 16:38:23 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Sourav Panda <souravpanda@google.com>
cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
    Andrew Morton <akpm@linux-foundation.org>, mike.kravetz@oracle.com, 
    muchun.song@linux.dev, rppt@kernel.org, david@redhat.com, 
    rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
    tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
    pasha.tatashin@soleen.com, yosryahmed@google.com, hannes@cmpxchg.org, 
    shakeelb@google.com, kirill.shutemov@linux.intel.com, 
    wangkefeng.wang@huawei.com, adobriyan@gmail.com, 
    Vlastimil Babka <vbabka@suse.cz>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, surenb@google.com, 
    linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-mm@kvack.org, 
    Matthew Wilcox <willy@infradead.org>, weixugc@google.com
Subject: Re: [PATCH v6 1/1] mm: report per-page metadata information
In-Reply-To: <b425ba6e-50b8-d1a6-7cb1-f94ba9e06c35@google.com>
Message-ID: <9266a9f9-71a5-dd88-df7b-facc037aaaff@google.com>
References: <20231205223118.3575485-1-souravpanda@google.com> <20231205223118.3575485-2-souravpanda@google.com> <b425ba6e-50b8-d1a6-7cb1-f94ba9e06c35@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 5 Jan 2024, David Rientjes wrote:

> On Tue, 5 Dec 2023, Sourav Panda wrote:
> 
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 49ef12df631b..d5901d04e082 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -993,6 +993,7 @@ Example output. You may not have all of these fields.
> >      AnonPages:       4654780 kB
> >      Mapped:           266244 kB
> >      Shmem:              9976 kB
> > +    PageMetadata:     513419 kB
> >      KReclaimable:     517708 kB
> >      Slab:             660044 kB
> >      SReclaimable:     517708 kB
> > @@ -1095,6 +1096,8 @@ Mapped
> >                files which have been mmapped, such as libraries
> >  Shmem
> >                Total memory used by shared memory (shmem) and tmpfs
> > +PageMetadata
> > +              Memory used for per-page metadata
> >  KReclaimable
> >                Kernel allocations that the kernel will attempt to reclaim
> >                under memory pressure. Includes SReclaimable (below), and other
> > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > index 45af9a989d40..f141bb2a550d 100644
> > --- a/fs/proc/meminfo.c
> > +++ b/fs/proc/meminfo.c
> > @@ -39,7 +39,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >  	long available;
> >  	unsigned long pages[NR_LRU_LISTS];
> >  	unsigned long sreclaimable, sunreclaim;
> > +	unsigned long nr_page_metadata;
> 
> Initialize it here (if we actually need this variable)?
> 
> >  	int lru;
> > +	int nid;
> >  
> >  	si_meminfo(&i);
> >  	si_swapinfo(&i);
> > @@ -57,6 +59,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >  	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
> >  	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
> >  
> > +	nr_page_metadata = 0;
> > +	for_each_online_node(nid)
> > +		nr_page_metadata += node_page_state(NODE_DATA(nid), NR_PAGE_METADATA);
> 
> Is this intended to be different than 
> global_node_page_state_pages(NR_PAGE_METADATA)?  
> 
> If so, any hint as to why we want to discount page metadata on offline 
> nodes?  We can't make an inference that metadata is always allocated 
> locally, memoryless nodes need things like struct page allocated on nodes 
> with memory.
> 

Sorry, meant a node with only ZONE_MOVABLE here so metadata can't be 
allocated locally.

But would be very interested to learn why this subtlety exists to sum up 
only online nodes.

> So even if a memoryless node is offline, we'd still be including its 
> metadata here with the current implementation.
> 
> Or maybe I'm missing a subtlety here for why this is not already 
> global_node_page_state_pages().
> 
> > +
> >  	show_val_kb(m, "MemTotal:       ", i.totalram);
> >  	show_val_kb(m, "MemFree:        ", i.freeram);
> >  	show_val_kb(m, "MemAvailable:   ", available);
> > @@ -104,6 +110,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >  	show_val_kb(m, "Mapped:         ",
> >  		    global_node_page_state(NR_FILE_MAPPED));
> >  	show_val_kb(m, "Shmem:          ", i.sharedram);
> > +	show_val_kb(m, "PageMetadata:   ", nr_page_metadata);
> >  	show_val_kb(m, "KReclaimable:   ", sreclaimable +
> >  		    global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
> >  	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 3c25226beeed..ef176152be7c 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -207,6 +207,10 @@ enum node_stat_item {
> >  	PGPROMOTE_SUCCESS,	/* promote successfully */
> >  	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
> >  #endif
> > +	NR_PAGE_METADATA,	/* Page metadata size (struct page and page_ext)
> > +				 * in pages
> > +				 */
> > +	NR_PAGE_METADATA_BOOT,	/* NR_PAGE_METADATA for bootmem */
> 
> So if some vmemmap pages are freed, then MemTotal could be incremented by 
> a portion of NR_PAGE_METADATA_BOOT and then this stat is decremented?  Is 
> the goal that the sum of MemTotal + SUM(nr_page_metadata_boot) is always 
> constant?
> 
> >  	NR_VM_NODE_STAT_ITEMS
> >  };
> >  
> > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > index fed855bae6d8..af096a881f03 100644
> > --- a/include/linux/vmstat.h
> > +++ b/include/linux/vmstat.h
> > @@ -656,4 +656,8 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
> >  {
> >  	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
> >  }
> > +
> > +void __init mod_node_early_perpage_metadata(int nid, long delta);
> > +void __init store_early_perpage_metadata(void);
> > +
> >  #endif /* _LINUX_VMSTAT_H */
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 87818ee7f01d..5b10d8d2b471 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -230,10 +230,14 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
> >   */
> >  static inline void free_vmemmap_page(struct page *page)
> >  {
> > -	if (PageReserved(page))
> > +	if (PageReserved(page)) {
> >  		free_bootmem_page(page);
> > -	else
> > +		mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA_BOOT,
> > +				    -1);
> > +	} else {
> >  		__free_page(page);
> > +		mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA, -1);
> > +	}
> >  }
> >  
> >  /* Free a list of the vmemmap pages */
> > @@ -389,6 +393,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
> >  		copy_page(page_to_virt(walk.reuse_page),
> >  			  (void *)walk.reuse_addr);
> >  		list_add(&walk.reuse_page->lru, vmemmap_pages);
> > +		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, 1);
> >  	}
> >  
> >  	/*
> > @@ -437,14 +442,20 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> >  	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
> >  	int nid = page_to_nid((struct page *)start);
> >  	struct page *page, *next;
> > +	int i;
> >  
> > -	while (nr_pages--) {
> > +	for (i = 0; i < nr_pages; i++) {
> >  		page = alloc_pages_node(nid, gfp_mask, 0);
> > -		if (!page)
> > +		if (!page) {
> > +			mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> > +					    i);
> >  			goto out;
> > +		}
> >  		list_add(&page->lru, list);
> >  	}
> >  
> > +	mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, nr_pages);
> > +
> >  	return 0;
> >  out:
> >  	list_for_each_entry_safe(page, next, list, lru)
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 077bfe393b5e..38f8e1f454a0 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/pgtable.h>
> >  #include <linux/swap.h>
> >  #include <linux/cma.h>
> > +#include <linux/vmstat.h>
> >  #include "internal.h"
> >  #include "slab.h"
> >  #include "shuffle.h"
> > @@ -1656,6 +1657,8 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
> >  			panic("Failed to allocate %ld bytes for node %d memory map\n",
> >  			      size, pgdat->node_id);
> >  		pgdat->node_mem_map = map + offset;
> > +		mod_node_early_perpage_metadata(pgdat->node_id,
> > +						DIV_ROUND_UP(size, PAGE_SIZE));
> >  	}
> >  	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
> >  				__func__, pgdat->node_id, (unsigned long)pgdat,
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 733732e7e0ba..dd78017105b0 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5636,6 +5636,7 @@ void __init setup_per_cpu_pageset(void)
> >  	for_each_online_pgdat(pgdat)
> >  		pgdat->per_cpu_nodestats =
> >  			alloc_percpu(struct per_cpu_nodestat);
> > +	store_early_perpage_metadata();
> >  }
> >  
> >  __meminit void zone_pcp_init(struct zone *zone)
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index 4548fcc66d74..4ca9f298f34e 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
> >  		return -ENOMEM;
> >  	NODE_DATA(nid)->node_page_ext = base;
> >  	total_usage += table_size;
> > +	mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA_BOOT,
> > +			    DIV_ROUND_UP(table_size, PAGE_SIZE));
> >  	return 0;
> >  }
> >  
> > @@ -255,12 +257,15 @@ static void *__meminit alloc_page_ext(size_t size, int nid)
> >  	void *addr = NULL;
> >  
> >  	addr = alloc_pages_exact_nid(nid, size, flags);
> > -	if (addr) {
> > +	if (addr)
> >  		kmemleak_alloc(addr, size, 1, flags);
> > -		return addr;
> > -	}
> > +	else
> > +		addr = vzalloc_node(size, nid);
> >  
> > -	addr = vzalloc_node(size, nid);
> > +	if (addr) {
> > +		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> > +				    DIV_ROUND_UP(size, PAGE_SIZE));
> > +	}
> >  
> >  	return addr;
> >  }
> > @@ -303,18 +308,27 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
> >  
> >  static void free_page_ext(void *addr)
> >  {
> > +	size_t table_size;
> > +	struct page *page;
> > +	struct pglist_data *pgdat;
> > +
> > +	table_size = page_ext_size * PAGES_PER_SECTION;
> > +
> >  	if (is_vmalloc_addr(addr)) {
> > +		page = vmalloc_to_page(addr);
> > +		pgdat = page_pgdat(page);
> >  		vfree(addr);
> >  	} else {
> > -		struct page *page = virt_to_page(addr);
> > -		size_t table_size;
> > -
> > -		table_size = page_ext_size * PAGES_PER_SECTION;
> > -
> > +		page = virt_to_page(addr);
> > +		pgdat = page_pgdat(page);
> >  		BUG_ON(PageReserved(page));
> >  		kmemleak_free(addr);
> >  		free_pages_exact(addr, table_size);
> >  	}
> > +
> > +	mod_node_page_state(pgdat, NR_PAGE_METADATA,
> > +			    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
> > +
> >  }
> >  
> >  static void __free_page_ext(unsigned long pfn)
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index a2cbe44c48e1..054b49539843 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -469,5 +469,13 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
> >  	if (r < 0)
> >  		return NULL;
> >  
> > +	if (system_state == SYSTEM_BOOTING) {
> > +		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA_BOOT,
> > +				    DIV_ROUND_UP(end - start, PAGE_SIZE));
> > +	} else {
> > +		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> > +				    DIV_ROUND_UP(end - start, PAGE_SIZE));
> > +	}
> > +
> >  	return pfn_to_page(pfn);
> >  }
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 77d91e565045..0c100ae1cf8b 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -14,7 +14,7 @@
> >  #include <linux/swap.h>
> >  #include <linux/swapops.h>
> >  #include <linux/bootmem_info.h>
> > -
> > +#include <linux/vmstat.h>
> >  #include "internal.h"
> >  #include <asm/dma.h>
> >  
> > @@ -465,6 +465,9 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
> >  	 */
> >  	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
> >  	sparsemap_buf_end = sparsemap_buf + size;
> > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > +	mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_SIZE));
> > +#endif
> >  }
> >  
> >  static void __init sparse_buffer_fini(void)
> > @@ -641,6 +644,8 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> >  	unsigned long start = (unsigned long) pfn_to_page(pfn);
> >  	unsigned long end = start + nr_pages * sizeof(struct page);
> >  
> > +	mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_PAGE_METADATA,
> > +			    -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
> >  	vmemmap_free(start, end, altmap);
> >  }
> >  static void free_map_bootmem(struct page *memmap)
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 359460deb377..23e88d8c21b7 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1249,7 +1249,8 @@ const char * const vmstat_text[] = {
> >  	"pgpromote_success",
> >  	"pgpromote_candidate",
> >  #endif
> > -
> > +	"nr_page_metadata",
> > +	"nr_page_metadata_boot",
> >  	/* enum writeback_stat_item counters */
> >  	"nr_dirty_threshold",
> >  	"nr_dirty_background_threshold",
> > @@ -2278,4 +2279,27 @@ static int __init extfrag_debug_init(void)
> >  }
> >  
> >  module_init(extfrag_debug_init);
> > +
> >  #endif
> > +
> > +/*
> > + * Page metadata size (struct page and page_ext) in pages
> > + */
> > +static unsigned long early_perpage_metadata[MAX_NUMNODES] __initdata;
> > +
> > +void __init mod_node_early_perpage_metadata(int nid, long delta)
> > +{
> > +	early_perpage_metadata[nid] += delta;
> > +}
> > +
> > +void __init store_early_perpage_metadata(void)
> > +{
> > +	int nid;
> > +	struct pglist_data *pgdat;
> > +
> > +	for_each_online_pgdat(pgdat) {
> > +		nid = pgdat->node_id;
> > +		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA_BOOT,
> > +				    early_perpage_metadata[nid]);
> > +	}
> > +}
> > -- 
> > 2.43.0.472.g3155946c3a-goog
> > 
> > 
> > 
> 

