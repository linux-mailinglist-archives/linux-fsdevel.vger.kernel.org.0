Return-Path: <linux-fsdevel+bounces-1774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB37DE8C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 00:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE132818F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B801BDED;
	Wed,  1 Nov 2023 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vS7A/Awz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC210A3A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 23:08:21 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A10A6
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 16:08:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86766bba9fso182898276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 16:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698880098; x=1699484898; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5qWWijUVxf0dBo3Nq+4AwtcGaRZKaTUhIgmJU1h7y10=;
        b=vS7A/AwzFuO6c9Wg8F034uLUYOAV13dOAuEist4CoQYvCVmgKZz52Gl5NLwoL7Rn80
         p9JPyphNGf3OidqQ3aCvnnwaptX2e/dmUm6stsGMUl0fw8dqS5G1Ff5Sy/LWIfkmJcG/
         h5Ilp6CGIAe0aOLb0j7Dg6iZ5ZO1/uMIKkz/DDuwKT11v/yvkkrMDxrxDmlRYufAUSCQ
         quCw7TzMbcGCk/ek+TI3RPgaNN2wsWTEzv6PTfRXt6A1xclPi2TzzPLHlO74rHO8eJlo
         6hPSmfPPJxY5hG1GofEJonwumRtbRhMAzT72dzx2WicJaD7A33j468boPImPpeavjwBk
         oZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698880098; x=1699484898;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qWWijUVxf0dBo3Nq+4AwtcGaRZKaTUhIgmJU1h7y10=;
        b=MY5ufPhA1CmxDpPkXRFN9Ub3pDr5XS4iW4geH7TIRN5CqZ0OBnUMAFTgzSvp8YuhGy
         ZLP5iCdGtYZQ+heORx//deyuhsNwlUGTqph+rUaQ2CNrZaQv/Dv5d0ckrmWqvP9/7HTI
         qrvGaWqI2mSonWBkAZXc91bhCjEDt+8QDUp3bfiMV/lNo9Df6BWd9HXtgNyKKd2dAe3X
         XUIbicliMC7LCTkNq4x28pVZDLOgQrZHjLe3IgBjo7r8oZ5QwkPmXwjXXjY6nKLjsm+j
         Df+FlRVSotqy0Udl2O7Y71WryFeY/puNyaAMzjUl0S7Mdl7xW5W2ADU9aw7yrzPffMP+
         XVXA==
X-Gm-Message-State: AOJu0YzzYQ4uWfq8JkCqFUWYhDXPdfi5+Epr4zGSqcyLoo7m3B4uvNFW
	bf/RAIL1JDN+ymQIcehjDGGvcfo9xqUM+I6Mdw==
X-Google-Smtp-Source: AGHT+IFdYPqJCyM6xAim+PJhI90ZB8YdsXHWHdsf1a2bYh7xJWEgEFuSl7UhZ0FcxYXizhGP8t1i3U9NTQqL2dt7Ng==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:9bf9:be0e:41ed:e474])
 (user=souravpanda job=sendgmr) by 2002:a25:abc7:0:b0:da0:6216:798f with SMTP
 id v65-20020a25abc7000000b00da06216798fmr238035ybi.13.1698880098507; Wed, 01
 Nov 2023 16:08:18 -0700 (PDT)
Date: Wed,  1 Nov 2023 16:08:15 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231101230816.1459373-1-souravpanda@google.com>
Subject: [PATCH v5 0/1] mm: report per-page metadata information
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
v4:
https://lore.kernel.org/all/20231031223846.827173-1-souravpanda@google.com
v3:
https://lore.kernel.org/all/20231031174459.459480-1-souravpanda@google.com
v2:
https://lore.kernel.org/all/20231018005548.3505662-1-souravpanda@google.com
v1:
https://lore.kernel.org/r/20230913173000.4016218-2-souravpanda@google.com

Hi!

This patch adds a new per-node PageMetadata field to
/sys/devices/system/node/nodeN/meminfo and a global PageMetadata field
to /proc/meminfo. This information can be used by users to see how much
memory is being used by per-page metadata, which can vary depending on
build configuration, machine architecture, and system use.

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
export a new metric that we shall refer to as PageMetadata (exported by
node). This shall also comprise the struct page and page_ext allocations
made during runtime.

Results and analysis
--------------------

Memory model: Sparsemem-vmemmap
$ echo 1 > /proc/sys/vm/hugetlb_optimize_vmemmap

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32918196 kB
$ cat /proc/meminfo | grep Meta
	PageMetadata:     589824 kB
$ cat /sys/devices/system/node/node0/meminfo | grep Meta
	Node 0 PageMetadata:     294912 kB
$ cat /sys/devices/system/node/node1/meminfo | grep Meta
	Node 1 PageMetadata:     294912 kB


AFTER HUGTLBFS RESERVATION
$ echo 512 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal

MemTotal:       32934580 kB
$ cat /proc/meminfo | grep Meta
PageMetadata:     575488 kB
$ cat /sys/devices/system/node/node0/meminfo | grep Meta
Node 0 PageMetadata:     287744 kB
$ cat /sys/devices/system/node/node1/meminfo | grep Meta
Node 1 PageMetadata:     287744 kB

AFTER FREEING HUGTLBFS RESERVATION
$ echo 0 > /proc/sys/vm/nr_hugepages
$ cat /proc/meminfo | grep MemTotal
MemTotal:       32934580 kB
$ cat /proc/meminfo | grep Meta
PageMetadata:    589824 kB
$ cat /sys/devices/system/node/node0/meminfo | grep Meta
Node 0 PageMetadata:       294912 kB
$ cat /sys/devices/system/node/node1/meminfo | grep Meta
Node 1 PageMetadata:       294912 kB

Sourav Panda (1):
  mm: report per-page metadata information

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

-- 
2.42.0.820.g83a721a137-goog


