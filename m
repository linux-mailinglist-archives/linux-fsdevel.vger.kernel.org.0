Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9D2B5CAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 11:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgKQKP4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 05:15:56 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2065 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQKP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:15:56 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Cb1zC5fVczVphC;
        Tue, 17 Nov 2020 18:15:19 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 17 Nov 2020 18:15:45 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 17 Nov 2020 18:15:45 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Tue, 17 Nov 2020 18:15:45 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Muchun Song <songmuchun@bytedance.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "almasrymina@google.com" <almasrymina@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "mhocko@suse.com" <mhocko@suse.com>
CC:     "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v4 00/21] Free some vmemmap pages of hugetlb page
Thread-Topic: [PATCH v4 00/21] Free some vmemmap pages of hugetlb page
Thread-Index: AQHWuaxO0H5megy+qEKBM1T+1aO5TKnMHhDQ
Date:   Tue, 17 Nov 2020 10:15:44 +0000
Message-ID: <349168819c1249d4bceea26597760b0a@hisilicon.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.113]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> Behalf Of Muchun Song
> Sent: Saturday, November 14, 2020 12:00 AM
> To: corbet@lwn.net; mike.kravetz@oracle.com; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; x86@kernel.org; hpa@zytor.com;
> dave.hansen@linux.intel.com; luto@kernel.org; peterz@infradead.org;
> viro@zeniv.linux.org.uk; akpm@linux-foundation.org; paulmck@kernel.org;
> mchehab+huawei@kernel.org; pawan.kumar.gupta@linux.intel.com;
> rdunlap@infradead.org; oneukum@suse.com; anshuman.khandual@arm.com;
> jroedel@suse.de; almasrymina@google.com; rientjes@google.com;
> willy@infradead.org; osalvador@suse.de; mhocko@suse.com
> Cc: duanxiongchun@bytedance.com; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> linux-fsdevel@vger.kernel.org; Muchun Song <songmuchun@bytedance.com>
> Subject: [PATCH v4 00/21] Free some vmemmap pages of hugetlb page
> 
> Hi all,
> 
> This patch series will free some vmemmap pages(struct page structures)
> associated with each hugetlbpage when preallocated to save memory.
> 
> Nowadays we track the status of physical page frames using struct page
> structures arranged in one or more arrays. And here exists one-to-one
> mapping between the physical page frame and the corresponding struct page
> structure.
> 
> The HugeTLB support is built on top of multiple page size support that
> is provided by most modern architectures. For example, x86 CPUs normally
> support 4K and 2M (1G if architecturally supported) page sizes. Every
> HugeTLB has more than one struct page structure. The 2M HugeTLB has 512
> struct page structure and 1G HugeTLB has 4096 struct page structures. But
> in the core of HugeTLB only uses the first 4 (Use of first 4 struct page
> structures comes from HUGETLB_CGROUP_MIN_ORDER.) struct page
> structures to
> store metadata associated with each HugeTLB. The rest of the struct page
> structures are usually read the compound_head field which are all the same
> value. If we can free some struct page memory to buddy system so that we
> can save a lot of memory.
> 
> When the system boot up, every 2M HugeTLB has 512 struct page structures
> which size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
> 
>    hugetlbpage                  struct pages(8 pages)          page
> frame(8 pages)
>   +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>   |           |                     |     0     | -------------> |     0
> |
>   |           |                     |     1     | -------------> |     1
> |
>   |           |                     |     2     | -------------> |     2
> |
>   |           |                     |     3     | -------------> |     3
> |
>   |           |                     |     4     | -------------> |     4
> |
>   |     2M    |                     |     5     | -------------> |
> 5     |
>   |           |                     |     6     | -------------> |     6
> |
>   |           |                     |     7     | -------------> |     7
> |
>   |           |                     +-----------+
> +-----------+
>   |           |
>   |           |
>   +-----------+
> 
> 
> When a hugetlbpage is preallocated, we can change the mapping from above
> to
> bellow.
> 
>    hugetlbpage                  struct pages(8 pages)          page
> frame(8 pages)
>   +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>   |           |                     |     0     | -------------> |     0
> |
>   |           |                     |     1     | -------------> |     1
> |
>   |           |                     |     2     | ------------->
> +-----------+
>   |           |                     |     3     | -----------------^ ^ ^ ^
> ^
>   |           |                     |     4     | -------------------+ | |
> |
>   |     2M    |                     |     5     | ---------------------+ |
> |
>   |           |                     |     6     | -----------------------+ |
>   |           |                     |     7     | -------------------------+
>   |           |                     +-----------+
>   |           |
>   |           |
>   +-----------+
> 
> For tail pages, the value of compound_head is the same. So we can reuse
> first page of tail page structs. We map the virtual addresses of the
> remaining 6 pages of tail page structs to the first tail page struct,
> and then free these 6 pages. Therefore, we need to reserve at least 2
> pages as vmemmap areas.
> 
> When a hugetlbpage is freed to the buddy system, we should allocate six
> pages for vmemmap pages and restore the previous mapping relationship.
> 
> If we uses the 1G hugetlbpage, we can save 4088 pages(There are 4096 pages
> for
> struct page structures, we reserve 2 pages for vmemmap and 8 pages for page
> tables. So we can save 4088 pages). This is a very substantial gain. On our
> server, run some SPDK/QEMU applications which will use 1024GB hugetlbpage.
> With this feature enabled, we can save ~16GB(1G hugepage)/~11GB(2MB
> hugepage)

Hi Muchun,

Do we really save 11GB for 2MB hugepage?
How much do we save if we only get one 2MB hugetlb from one 128MB mem_section?
It seems we need to get at least one page for the PTEs since we are splitting PMD of 
vmemmap into PTE?

> memory.
> 
> Because there are vmemmap page tables reconstruction on the
> freeing/allocating
> path, it increases some overhead. Here are some overhead analysis.
> 
> 1) Allocating 10240 2MB hugetlb pages.
> 
>    a) With this patch series applied:
>    # time echo 10240 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.166s
>    user     0m0.000s
>    sys      0m0.166s
> 
>    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; }
> kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs -
> @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [8K, 16K)           8360
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> @@@@@@@@@@@@@@@@|
>    [16K, 32K)          1868 |@@@@@@@@@@@
> |
>    [32K, 64K)            10 |
> |
>    [64K, 128K)            2 |
> |
> 
>    b) Without this patch series:
>    # time echo 10240 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.066s
>    user     0m0.000s
>    sys      0m0.066s
> 
>    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; }
> kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs -
> @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [4K, 8K)           10176
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> @@@@@@@@@@@@@@@@|
>    [8K, 16K)             62 |
> |
>    [16K, 32K)             2 |
> |
> 
>    Summarize: this feature is about ~2x slower than before.
> 
> 2) Freeing 10240 @MB hugetlb pages.
> 
>    a) With this patch series applied:
>    # time echo 0 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.004s
>    user     0m0.000s
>    sys      0m0.002s
> 

Something is wrong here, it is faster than the case without this patchset:
0.004s vs. 0m0.077s

>    # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; }
> kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]);
> delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [16K, 32K)         10240
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> @@@@@@@@@@@@@@@@|
> 
>    b) Without this patch series:
>    # time echo 0 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.077s
>    user     0m0.001s
>    sys      0m0.075s
> 
>    # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; }
> kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]);
> delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [4K, 8K)            9950
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> @@@@@@@@@@@@@@@@|
>    [8K, 16K)            287 |@
> |
>    [16K, 32K)             3 |
> |
> 
>    Summarize: The overhead of __free_hugepage is about ~2-4x slower than
> before.
>               But according to the allocation test above, I think that here is
> 	      also ~2x slower than before.
> 
>               But why the 'real' time of patched is smaller than before?
> Because
> 	      In this patch series, the freeing hugetlb is asynchronous(through
> 	      kwoker).
> 
> Although the overhead has increased, the overhead is not significant. Like MIke
> said, "However, remember that the majority of use cases create hugetlb pages
> at
> or shortly after boot time and add them to the pool. So, additional overhead is
> at pool creation time. There is no change to 'normal run time' operations of
> getting a page from or returning a page to the pool (think page fault/unmap)".
> 

It seems it is true. At runtime, people normally don't change hugetlb.

>   changelog in v4:
>   1. Move all the vmemmap functions to hugetlb_vmemmap.c.
>   2. Make the CONFIG_HUGETLB_PAGE_FREE_VMEMMAP default to y, if we
> want to
>      disable this feature, we should disable it by a boot/kernel command line.
>   3. Remove vmemmap_pgtable_{init, deposit, withdraw}() helper functions.
>   4. Initialize page table lock for vmemmap through core_initcall mechanism.
> 
>   Thanks for Mike and Oscar's suggestions.
> 
>   changelog in v3:
>   1. Rename some helps function name. Thanks Mike.
>   2. Rework some code. Thanks Mike and Oscar.
>   3. Remap the tail vmemmap page with PAGE_KERNEL_RO instead of
>      PAGE_KERNEL. Thanks Matthew.
>   4. Add some overhead analysis in the cover letter.
>   5. Use vmemap pmd table lock instead of a hugetlb specific global lock.
> 
>   changelog in v2:
>   1. Fix do not call dissolve_compound_page in alloc_huge_page_vmemmap().
>   2. Fix some typo and code style problems.
>   3. Remove unused handle_vmemmap_fault().
>   4. Merge some commits to one commit suggested by Mike.
> 
> Muchun Song (21):
>   mm/memory_hotplug: Move bootmem info registration API to
>     bootmem_info.c
>   mm/memory_hotplug: Move {get,put}_page_bootmem() to bootmem_info.c
>   mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
>   mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
>   mm/hugetlb: Introduce pgtable allocation/freeing helpers
>   mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
>   mm/bootmem_info: Combine bootmem info and type into page->freelist
>   mm/hugetlb: Initialize page table lock for vmemmap
>   mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
>   mm/hugetlb: Defer freeing of hugetlb pages
>   mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb
>     page
>   mm/hugetlb: Introduce remap_huge_page_pmd_vmemmap helper
>   mm/hugetlb: Use PG_slab to indicate split pmd
>   mm/hugetlb: Support freeing vmemmap pages of gigantic page
>   mm/hugetlb: Set the PageHWPoison to the raw error page
>   mm/hugetlb: Flush work when dissolving hugetlb page
>   mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
>   mm/hugetlb: Merge pte to huge pmd only for gigantic page
>   mm/hugetlb: Gather discrete indexes of tail page
>   mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct
>     page
>   mm/hugetlb: Disable freeing vmemmap if struct page size is not power
>     of two
> 
>  Documentation/admin-guide/kernel-parameters.txt |   9 +
>  Documentation/admin-guide/mm/hugetlbpage.rst    |   3 +
>  arch/x86/include/asm/hugetlb.h                  |  17 +
>  arch/x86/include/asm/pgtable_64_types.h         |   8 +
>  arch/x86/mm/init_64.c                           |   7 +-
>  fs/Kconfig                                      |  14 +
>  include/linux/bootmem_info.h                    |  78 +++
>  include/linux/hugetlb.h                         |  19 +
>  include/linux/hugetlb_cgroup.h                  |  15 +-
>  include/linux/memory_hotplug.h                  |  27 -
>  mm/Makefile                                     |   2 +
>  mm/bootmem_info.c                               | 124 ++++
>  mm/hugetlb.c                                    | 163 +++++-
>  mm/hugetlb_vmemmap.c                            | 732
> ++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.h                            | 104 ++++
>  mm/memory_hotplug.c                             | 116 ----
>  mm/sparse.c                                     |   5 +-
>  17 files changed, 1263 insertions(+), 180 deletions(-)
>  create mode 100644 include/linux/bootmem_info.h
>  create mode 100644 mm/bootmem_info.c
>  create mode 100644 mm/hugetlb_vmemmap.c
>  create mode 100644 mm/hugetlb_vmemmap.h
> 

Thanks
Barry

