Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E7D298FF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782169AbgJZOxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:53:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44415 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782160AbgJZOxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:53:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id 133so327393pfx.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VlMBblbmRytojibzU/j52EgLGR+Q0tdS6I4eRGdWIMU=;
        b=S5keWXE59lJCym5FyqVjdIRlNh4zCQn0VXzBCqKMZJRBnLZ9UqU0LUvangA1dorBJ9
         UHsbc4Hdtz+CCyV86RY7UhghNmkzNmS03Y4LKgLUF6ZFCGisycP4ts9xc58SiFm6EqNq
         XejO0UZ5fCvtvNRNWLC52fbA0C75YORav6Gr61uAj6jpbOimbVjDtlXatXLgrqvkDfmd
         +i/uf5BjGyCf/XTdBph9xA83PoSWzxegvIRxgX7I5sv6EAS09k1DEcOXsfRxmzfthXWQ
         gVUHjOYu+xQ3iLc5r04JB3k0gkAKV6px9TE/vzlyhAu7Lez5Wm1T0/1wRXH5gkAnRECI
         GCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VlMBblbmRytojibzU/j52EgLGR+Q0tdS6I4eRGdWIMU=;
        b=pVD81eA7z6WkYfqqIV9c2QEsoa6QdShtszolzsuU7hfdKq530MdDNxdmbvZKAyrALv
         36xFqgOMnMHUxQ540T8QOQva6JgWNqovf28Lz+RbltKZSUOib0xYh8hz9psf7nHG9P9/
         35rxciW0l0BRCrxTPpjvBfCjMbBWJSHTqgNxCF+fQhD7AoiRAW5Xxl4kXXY40+AR7Onp
         p+41Z24+gN4QCJ1W1o6ouj7BT6aNtr2JqKygnvwosFUzi5BXRS1vzbru3fIsCgoULrxp
         3IhR/AYA9jyq/kHgfN64eqBel72xfbVE3yX0RSZ7dO2b07P08GRJcm+2IklyTVEtpIoc
         aQUA==
X-Gm-Message-State: AOAM531GA7aJqnbDJyYGIeSrWLrFVMiHo7joj3O/ajjzOqlv8nHWxVF4
        n/sRqLVh+4KG4rICBAlRpBcKZw==
X-Google-Smtp-Source: ABdhPJy5jPK58YPRIufu6al4DMwGRDvPaOtJSMZxZepTlg9IN7o4kftDFuksdY79WSCwX9uzlRXYiQ==
X-Received: by 2002:a05:6a00:7cb:b029:152:94b3:b2ee with SMTP id n11-20020a056a0007cbb029015294b3b2eemr13653849pfu.58.1603723992276;
        Mon, 26 Oct 2020 07:53:12 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.53.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:53:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 00/19] Free some vmemmap pages of hugetlb page
Date:   Mon, 26 Oct 2020 22:50:55 +0800
Message-Id: <20201026145114.59424-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This patch series will free some vmemmap pages(struct page structures)
associated with each hugetlbpage when preallocated to save memory.

Nowadays we track the status of physical page frames using `struct page`
arranged in one or more arrays. And here exists one-to-one mapping between
the physical page frame and the corresponding `struct page`.

The hugetlbpage support is built on top of multiple page size support
that is provided by most modern architectures. For example, x86 CPUs
normally support 4K and 2M (1G if architecturally supported) page sizes.
Every hugetlbpage has more than one `struct page`. The 2M hugetlbpage
has 512 `struct page` and 1G hugetlbpage has 4096 `struct page`. But
in the core of hugetlbpage only uses the first 4 `struct page` to store
metadata associated with each hugetlbpage. The rest of the `struct page`
are usually read the compound_head field which are all the same value.
If we can free some struct page memory to buddy system so that we can
save a lot of memory.

When the system boot up, every 2M hugetlbpage has 512 `struct page` which
is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).

   hugetlbpage                  struct pages(8 pages)          page frame(8 pages)
  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  |           |                     |     0     | -------------> |     0     |
  |           |                     |     1     | -------------> |     1     |
  |           |                     |     2     | -------------> |     2     |
  |           |                     |     3     | -------------> |     3     |
  |           |                     |     4     | -------------> |     4     |
  |     2M    |                     |     5     | -------------> |     5     |
  |           |                     |     6     | -------------> |     6     |
  |           |                     |     7     | -------------> |     7     |
  |           |                     +-----------+                +-----------+
  |           |
  |           |
  +-----------+


When a hugetlbpage is preallocated, we can change the mapping from above to
bellow.

   hugetlbpage                  struct pages(8 pages)          page frame(8 pages)
  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  |           |                     |     0     | -------------> |     0     |
  |           |                     |     1     | -------------> |     1     |
  |           |                     |     2     | -------------> +-----------+
  |           |                     |     3     | -----------------^ ^ ^ ^ ^
  |           |                     |     4     | -------------------+ | | |
  |     2M    |                     |     5     | ---------------------+ | |
  |           |                     |     6     | -----------------------+ |
  |           |                     |     7     | -------------------------+
  |           |                     +-----------+
  |           |
  |           |
  +-----------+

For tail pages, the value of compound_dtor is the same. So we can reuse
first page of tail page structs. We map the virtual addresses of the
remaining 6 pages of tail page structs to the first tail page struct,
and then free these 6 pages. Therefore, we need to reserve at least 2
pages as vmemmap areas.

When a hugetlbpage is freed to the buddy system, we should allocate 6
pages for vmemmap pages and restore the previous mapping relationship.

If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
substantial gain. On our server, run some SPDK/QEMU applications which
will use 1000GB hugetlbpage. With this feature enabled, we can save
~16GB(1G hugepage)/~11GB(2MB hugepage) memory.

  changelog in v2:
  1. Fix do not call dissolve_compound_page in alloc_huge_page_vmemmap().
  2. Fix some typo and code style problems.
  3. Remove unused handle_vmemmap_fault().
  4. Merge some commits to one commit suggested by Mike.

Muchun Song (19):
  mm/memory_hotplug: Move bootmem info registration API to
    bootmem_info.c
  mm/memory_hotplug: Move {get,put}_page_bootmem() to bootmem_info.c
  mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
  mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
  mm/hugetlb: Introduce pgtable allocation/freeing helpers
  mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
  mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
  mm/hugetlb: Defer freeing of hugetlb pages
  mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb
    page
  mm/hugetlb: Introduce remap_huge_page_pmd_vmemmap helper
  mm/hugetlb: Use PG_slab to indicate split pmd
  mm/hugetlb: Support freeing vmemmap pages of gigantic page
  mm/hugetlb: Add a BUILD_BUG_ON to check if struct page size is a power
    of two
  mm/hugetlb: Clear PageHWPoison on the non-error memory page
  mm/hugetlb: Flush work when dissolving hugetlb page
  mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
  mm/hugetlb: Merge pte to huge pmd only for gigantic page
  mm/hugetlb: Gather discrete indexes of tail page
  mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct
    page

 .../admin-guide/kernel-parameters.txt         |   9 +
 Documentation/admin-guide/mm/hugetlbpage.rst  |   3 +
 arch/x86/include/asm/hugetlb.h                |  20 +
 arch/x86/include/asm/pgtable_64_types.h       |   8 +
 arch/x86/mm/init_64.c                         |   5 +-
 fs/Kconfig                                    |  16 +
 include/linux/bootmem_info.h                  |  65 ++
 include/linux/hugetlb.h                       |  50 ++
 include/linux/hugetlb_cgroup.h                |  15 +-
 include/linux/memory_hotplug.h                |  27 -
 mm/Makefile                                   |   1 +
 mm/bootmem_info.c                             | 125 +++
 mm/hugetlb.c                                  | 795 +++++++++++++++++-
 mm/memory_hotplug.c                           | 116 ---
 mm/sparse.c                                   |   1 +
 15 files changed, 1091 insertions(+), 165 deletions(-)
 create mode 100644 include/linux/bootmem_info.h
 create mode 100644 mm/bootmem_info.c

-- 
2.20.1

