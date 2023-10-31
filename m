Return-Path: <linux-fsdevel+bounces-1675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D157DD871
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 23:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF105281961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 22:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4852745E;
	Tue, 31 Oct 2023 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w7yoISG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3D27453
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 22:38:51 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B810F
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 15:38:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0ccfc4fc8so5627668276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698791928; x=1699396728; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E4k1hGGxw36dmwLt1HOw2cRLPR7SfORP0QkzJq8sNG4=;
        b=w7yoISG9OB6UaATuaOUv8CjI+FKuWQ4OKjpuN6ItWeh7++/hY9b8JadKneKShLnXxx
         YtEp/DajeMcikLarLTeD6J55jnSuypp/1UyvPW67Fzw6QsuA6lXVq5eRfA0jzQkMBIEU
         7OX0fC02G0HKrzagh2K4bW2z55czxsIq3h2DyFB1GpFeALTf9GVQXzYsQdU0swAZ/q+I
         5g36KrwXngDBFTYnEIdnhk0ejiTTkOCR3GurD8T2+Gynat1n6XTshXGHLT5xjmiHEfh1
         XN2KZBaZO0dPtI/4Ii70g4rb1fYk9CXkrwKekzvdVatPxA1EoijiQdZuxDNsHIezg64Z
         GTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791928; x=1699396728;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4k1hGGxw36dmwLt1HOw2cRLPR7SfORP0QkzJq8sNG4=;
        b=RdgHvlFGY5V8HdfkwiQo70Y/UYn2BZAYT0HEk2U1libh/amDk3EMvl4AE3cuIB44KS
         vlT1sXzUQePPOQy4QnUkrCF7nXwwgpHlc7C7XV2sQiCQ6Y3GCQ8n4ew8rthMX2kGyv09
         TAeNc0BnW4+q3Vx3ewUpy1VVU+WQdh808PD+cLTfFJb1TAYa0rd7wJ6PioCCODGGL5uy
         JLbxWrs+fUpd7xq0PEIqRYdy3hjjBua2taP4xIwej5VFyRo+xpIqRemwz9J2/euQHN2S
         7u0ab1aoA4TPnk1aJmkICTn6/rGkHHxO3mniIP00S2YnO01fMQJrTfDNUOokZQLtb8az
         qmIQ==
X-Gm-Message-State: AOJu0Yz0rwh2bpc6Wy3hgbudPtN5EmtGoRzm8eYRDkDFRR0Wo6P6Luz9
	YF24Q3SOOBCuFp7E5LJcPrcqg5+P8mx5OoJ+KA==
X-Google-Smtp-Source: AGHT+IFM2W41gegeIUvzp7uUlh/DfO8Ica5ODCIQO4qan/QTBGDN4jXaqaSexGBwblyANavfH28+tAwYTUKQP15dBg==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:84c2:bfa0:7c62:5d77])
 (user=souravpanda job=sendgmr) by 2002:a05:6902:549:b0:da3:b96c:6c48 with
 SMTP id z9-20020a056902054900b00da3b96c6c48mr2053ybs.9.1698791928152; Tue, 31
 Oct 2023 15:38:48 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:38:45 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031223846.827173-1-souravpanda@google.com>
Subject: [PATCH v4 0/1] mm: report per-page metadata information
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
v4:
	- Addressed comment from Matthew Wilcox.
		- Used __node_stat_sub_folio and __node_stat_add_folio
		  instead of __mod_node_page_state in mm/hugetlb.c.
		- Used page_pgdat wherever possible in the entire patch.
		- Used DIV_ROUND_UP() wherever possible in the entire
		  patch.
v3:
	- Addressed comment from Matthew Wilcox.
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
 mm/hugetlb_vmemmap.c               |  8 ++++++--
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  3 +++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 24 ++++++++++++++++++++++
 13 files changed, 94 insertions(+), 14 deletions(-)

-- 
2.42.0.820.g83a721a137-goog


