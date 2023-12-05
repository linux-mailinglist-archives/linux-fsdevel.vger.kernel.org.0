Return-Path: <linux-fsdevel+bounces-4905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 649408061E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 23:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29AF1F216D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD873FE2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0URYktg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAEB181
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 14:31:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d9c036769cso16139607b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 14:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701815480; x=1702420280; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uKnmnhbaB6MZWD6KtkJPA2pbRvwEpH4SeUxeebTu4PU=;
        b=w0URYktgC//m/zmzUjkq2u9uU2yskelhayIoVBBKf26ijRpjld9vC0yGrtZ0WsPRkr
         uProvIG4B0APfICfQP9R08CeZwlafU2dY4NJE9QLIb6LDeKhS3eo/MVO0iKnLcuxhx9c
         y/rM9O1kTRlm7vYno+1VQwVG4AIhxZ6wLFKrPIj0Yoc2AKVEz19Zzltj8gYg+7qFpcLN
         iy1c3SBp+1ydZj9z2inqMWvPuFdSrYzzFzy+CnnouSpIw2xlNJUwgIVSYIDigToxmLBJ
         9rU7pHLseb85Rchf2n5JxsBUk1uBG5FbsvUbxd99r4wV+FgHy7Fd08XKa8gMHO8624a8
         sTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701815480; x=1702420280;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKnmnhbaB6MZWD6KtkJPA2pbRvwEpH4SeUxeebTu4PU=;
        b=WOMN8SNVk4503p9Ym675hv+KSj+acyGkJ143Qu87JCDTYF5aiAdbs0eZF7QIUI83Xw
         zatbSr4oCenK3haBw84bwhvB08Odti0Eh/mVWwOI75RayfmXod2G9x5SzTGDN9VHTuMF
         r/6hWpKZcinOa8jkiDLde/GPSnvXSORTqo6HsftdKFKr/jmOInS1CMU1U2UnZhFgg5Jo
         KQsRcg5i9x/i3TDfREf9QHhbDUcyUYsYAeQ8i9cQD+DbOKpRYXHHWtAb/klckTwAQmSp
         REur9cGEzPfW7kBGV5fF9FDKrtnd7d6N2bkZOQLEuMLx8ng9bL/wX7T3yYrufQYY9yAd
         j56Q==
X-Gm-Message-State: AOJu0YxxpvWZ3erMcC5Ga4N2PoG4MpLM+SMNbgeM+Ec+DDOro4PsBj2k
	l9FJZOnV2HoFGMKonobwvt/NwkXKh7JEFv0h1w==
X-Google-Smtp-Source: AGHT+IG94DctHBHUgLw+r9Z4psNv0tqS0WCNoREA6Q3QtdPaC54TMWcnYVFwHQT6waXor5yVQr6dfzH9vExG9KDf/Q==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:f645:15:697e:b77b])
 (user=souravpanda job=sendgmr) by 2002:a25:7082:0:b0:da0:59f7:3c97 with SMTP
 id l124-20020a257082000000b00da059f73c97mr1098248ybc.12.1701815480325; Tue,
 05 Dec 2023 14:31:20 -0800 (PST)
Date: Tue,  5 Dec 2023 14:31:17 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231205223118.3575485-1-souravpanda@google.com>
Subject: [PATCH v6 0/1] mm: report per-page metadata information
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

Changelog:
v6:
	- Interface changes
	  	- Added per-node nr_page_metadata and
		  nr_page_metadata_boot fields that are exported
		  in /sys/devices/system/node/nodeN/vmstat
		- nr_page_metadata exclusively tracks buddy
		  allocations while nr_page_metadata_boot
		  exclusively tracks memblock allocations.
		- Modified PageMetadata in /proc/meminfo to only
		  include buddy allocations so that it is
		  comparable against MemTotal in /proc/meminfo
		- Removed the PageMetadata field added in
		  /sys/devices/system/node/nodeN/meminfo
	- Addressed bugs reported by the kernel test bot.
	  	- All occurences of __mod_node_page_state have
		  been replaced by mod_node_page_state.
	- Addressed comments from Muchun Song.
	  	- Removed page meta data accouting from
		  mm/hugetlb.c. When CONFIG_SPARSEMEM_VMEMMAP
		  is disabled struct pages should not be returned
		  to buddy.
	- Modified the cover letter with the results and analysis
		- From when memory_hotplug.memmap_on_memory is
		  alternated between 0 and 1.
		- To account for the new interface changes.

v5:
	- Addressed comments from Muchun Song.
		- Fixed errors introduced in v4 when
		  CONFIG_SPARSEMEM_VMEMMAP is disabled by testing
		  against FLATMEM and SPARSEMEM memory models.
		- Handled the condition wherein the allocation of
		  walk.reuse_page fails, by moving NR_PAGE_METADATA
		  update into the clause if( walk.reuse_page ).
		- Removed the usage of DIV_ROUND_UP from
		  alloc_vmemmap_page_list since "end - start" is
		  always a multiple of PAGE_SIZE.
		- Modified alloc_vmemmap_page_list to update
		  NR_PAGE_METADATA once instead of every loop.
v4:
	- Addressed comment from Matthew Wilcox.
		- Used __node_stat_sub_folio and __node_stat_add_folio
		  instead of __mod_node_page_state in mm/hugetlb.c.
		- Used page_pgdat wherever possible in the entire patch.
		- Used DIV_ROUND_UP() wherever possible in the entire
		  patch.
v3:
	- Addressed one comment from Matthew Wilcox.
	  	- In free_page_ext, page_pgdat() is now extracted
		  prior to freeing the memory.
v2:
	- Fixed the three bugs reported by kernel test robot.
	- Enhanced the commit message as recommended by David Hildenbrand.
	- Addressed comments from Matthew Wilcox:
	  	- Simplified alloc_vmemmap_page_list() and
		  free_page_ext() as recommended.
		- Used the appropriate comment style in mm/vmstat.c.
		- Replaced writeout_early_perpage_metadata() with
		  store_early_perpage_metadata() to reduce ambiguity
		  with what swap does.
	- Addressed comments from Mike Rapoport:
	  	- Simplified the loop in alloc_vmemmap_page_list().
		- Could NOT address a comment to move
		  store_early_perpage_metadata() near where nodes
		  and page allocator are initialized.
		- Included the vmalloc()ed page_ext in accounting
		  within free_page_ext().
		- Made early_perpage_metadata[MAX_NUMNODES] static.


Previous approaches and discussions
-----------------------------------
v5:
https://lore.kernel.org/all/20231101230816.1459373-1-souravpanda@google.com
v4:
https://lore.kernel.org/all/20231031223846.827173-1-souravpanda@google.com
v3:
https://lore.kernel.org/all/20231031174459.459480-1-souravpanda@google.com
v2:
https://lore.kernel.org/all/20231018005548.3505662-1-souravpanda@google.com
v1:
https://lore.kernel.org/r/20230913173000.4016218-2-souravpanda@google.com

Hi!

This patch adds two new per-node fields, namely nr_page_metadata and
nr_page_metadata_boot to /sys/devices/system/node/nodeN/vmstat and a
global PageMetadata field to /proc/meminfo. This information can be
used by users to see how much memory is being used by per-page
metadata, which can vary depending on build configuration, machine
architecture, and system use.

Per-page metadata is the amount of memory that Linux needs in order to
manage memory at the page granularity. The majority of such memory is
used by "struct page" and "page_ext" data structures.


Background
----------

Kernel overhead observability is missing some of the largest
allocations during runtime, including vmemmap (struct pages) and
page_ext. This patch aims to address this problem by exporting a
new metric PageMetadata.

On the contrary, the kernel does provide observibility for boot memory
allocations. For example, the metric reserved_pages depicts the pages
allocated by the bootmem allocator. This can be simply calculated as
present_pages - managed_pages, which are both exported in /proc/zoneinfo.
The metric reserved_pages is primarily composed of struct pages and
page_ext.

What about the struct pages (allocated by bootmem allocator) that are
free'd during hugetlbfs allocations and then allocated by buddy-allocator
once hugtlbfs pages are free'd?

/proc/meminfo MemTotal changes: MemTotal does not include memblock
allocations but includes buddy allocations. However, during runtime
memblock allocations can be shifted into buddy allocations, and therefore
become part of MemTotal.

Once the struct pages get allocated by buddy allocator, we lose track of
these struct page allocations overhead accounting. Therefore, we must
export new metrics. nr_page_metadata and nr_page_metadata_boot
exclusively track the struct page and page ext allocations made by the
buddy allocator and memblock allocator, respectively for each node.
PageMetadata in /proc/meminfo would report the struct page and page ext
allocations made by the buddy allocator.

Results and analysis
--------------------

Memory model: Sparsemem-vmemmap
$ echo 1 > /proc/sys/vm/hugetlb_optimize_vmemmap

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep Meta
	PageMetadata:      65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
        nr_page_metadata 8192
	nr_page_metadata_boot 65536

AFTER HUGTLBFS RESERVATION
$ echo 512 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32935508 kB
$ cat /proc/meminfo | grep Meta
	PageMetadata:      67584 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8448
	nr_page_metadata_boot 63488
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8448
	nr_page_metadata_booy 63488


AFTER FREEING HUGTLBFS RESERVATION
$ echo 0 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal
        MemTotal:       32935508 kB
$ cat /proc/meminfo | grep Meta
        PageMetadata:      81920 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
        nr_page_metadata 10240
	nr_page_metadata_boot 63488
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
        nr_page_metadata 10240
	nr_page_metadata_boot 63488

------------------------

Memory Hotplug with memory_hotplug.memmap_on_memory=1

BEFORE HOTADD
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep PageMeta
	PageMetadata:      65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536

AFTER HOTADDING 1GB
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       33951316 kB
$ cat /proc/meminfo | grep PageMeta
	PageMetadata:      83968 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 12800
	nr_page_metadata_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536

--------------------------

Memory Hotplug with memory_hotplug.memmap_on_memory=0

BEFORE HOTADD
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep PageMeta
	PageMetadata:      65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536

AFTER HOTADDING 1GB
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       33967700 kB
$ cat /proc/meminfo | grep PageMeta
	PageMetadata:      83968 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 12800
	nr_page_metadata_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536

Sourav Panda (1):
  mm: report per-page metadata information

 Documentation/filesystems/proc.rst |  3 +++
 fs/proc/meminfo.c                  |  7 +++++++
 include/linux/mmzone.h             |  4 ++++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb_vmemmap.c               | 19 ++++++++++++++----
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  8 ++++++++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 26 +++++++++++++++++++++++-
 11 files changed, 99 insertions(+), 15 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


