Return-Path: <linux-fsdevel+bounces-1038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC267D5225
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433782813AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED9C2B5C3;
	Tue, 24 Oct 2023 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLogfqlT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420452AB46
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:46:46 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA644111
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a828bdcfbaso61797027b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155202; x=1698760002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oKd8MZGxRHabclv0gvs1NEl/RqZcn7BJTw9p45Kd1TY=;
        b=LLogfqlTRkYqohgDuuyJut/+4wKtX6ENRh1UD3YvkMxXvUkJ6Uubw08yPXASh7Hj6n
         3EveuInZaPM+OXyoVWn1hed3dwyyMKGzFENEXwlVPn9KKWQLuW4KWBacOYguH1Zi2Vvg
         RjYNsz6/PAq2yYBUBivpbXTGae8rA+8hch8TAokFrvRb8mOaXbKggqSjaJk9xraVohx1
         4lv1TyRFLLSHscnftKxprzRGCNnhyRj6xpoOGLcARJZnB2CoBv2FaW1TqwYIBUqAbVpe
         6P2+bK35F1QK5iihcEOM7zjH2Kqcj4x+iaHCuuP/mF6xyKSBkJnEUUhQ+GFHcve4qqxI
         u7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155202; x=1698760002;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKd8MZGxRHabclv0gvs1NEl/RqZcn7BJTw9p45Kd1TY=;
        b=NCogl1qVk1T1RguvE5c3V+v7hEaXjaRJsCqtzkoCT7CFUwMEfm/rw2em45PXenVu7u
         LuaWp29gg2oFWaIXrI0JEU690dGh8Mkqew1OUMAJi67/oNLZbjZWkcl5N1Pw1I5XG29X
         9GSPNxvyQMaLOFLb7uaRXamuVlHCROS1M7OGkT8katoZD/zUI1ZHO0g1rEOQjLTbqRtU
         EScByXFtYKntzU2NCMzkO9C5xDN1Lwf98kSh/AnVL7NDBBm/Zis4NOoJQXGINQkRCInX
         V+fuqJuC8Le50sv9PwdiVYe7+TaCIGQByzWREEQ4co1NIl1OAQfXfTND6XPrjPIWEEYg
         /Uww==
X-Gm-Message-State: AOJu0YwJUaTxVDKpnNcNK9QrqPvyyCbagz6zoIZdeYEPKB1iKhdgWyYg
	aX6hcnfBIGwprDV2tF/rzysZhR5uOlk=
X-Google-Smtp-Source: AGHT+IGRo0Dts1mklOBuLsmCD4jbLwl57kFf/772sactqVlWblbXhzRu2gxKqpZGL0ZMuPeoj+qPhP/RqeA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a0d:cbc9:0:b0:59b:f138:c835 with SMTP id
 n192-20020a0dcbc9000000b0059bf138c835mr283078ywd.5.1698155201726; Tue, 24 Oct
 2023 06:46:41 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:45:57 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-1-surenb@google.com>
Subject: [PATCH v2 00/39] Memory allocation profiling
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Updates since the last version [1]
- Simplified allocation tagging macros;
- Runtime enable/disable sysctl switch (/proc/sys/vm/mem_profiling)
instead of kernel command-line option;
- CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT to select default enable state;
- Changed the user-facing API from debugfs to procfs (/proc/allocinfo);
- Removed context capture support to make patch incremental;
- Renamed uninstrumented allocation functions to use _noprof suffix;
- Added __GFP_LAST_BIT to make the code cleaner;
- Removed lazy per-cpu counters; it turned out the memory savings was
minimal and not worth the performance impact;

Things we could not address:
- Alternative way of instrument allocation functions. We discussed an
alternative way of instrumenting the allocators and Steven Rostedt wrote
a proposal [2] to provide compiler support for Callsite Trampolines - a
special attribution of functions to be instrumented. So far we spoke to
representatives of GNU and CLANG communities, will be presenting a
proposal at LPC 2023 and we are working on a proof of concept for CLANG
(see [example 1]). While we will keep working with compiler community on
adding this support, posting the latest version of the patchset as an
immediately available solution until compiler support is implemented;
- Reclaim memory used by pageexts, slabexts, pcpuexts when profiling is
disabled. The main obstacles of reclaiming the memory used for profiling:
  1. References from already allocated objects still point to the
     allocation tags we are trying to reclaim; We would have to scan and
     kill all references before reclaiming;
  2. pageext memory is allocated during early boot when fragmentation is
     low. Once reclaimed we might not be able to get it back;
  3. pageext and slabext objects used for profiling can be interleaved
     with other data. Reformatting these vectors of objects at runtime is
     a complex and racy task.

Overview

Memory allocation profiling infrastructure provides a low overhead
mechanism to make all kernel allocations in the system visible. It can be
used to monitor memory usage, track memory hotspots, detect memory leaks,
identify memory regressions.

To keep the overhead to the minimum, we record only allocation sizes for
every allocation in the codebase. The data is exposed to the user space
via /proc/allocinfo interface. Usage example:

$ sort -hr /proc/allocinfo | head
  153MiB     8599 mm/slub.c:1826 module:slub func:alloc_slab_page
 6.08MiB      49 mm/slab_common.c:950 module:slab_common func:_kmalloc_order
 5.09MiB     6335 mm/memcontrol.c:2814 module:memcontrol func:alloc_slab_obj_exts
 4.54MiB      78 mm/page_alloc.c:5777 module:page_alloc func:alloc_pages_exact
 1.32MiB      338 include/asm-generic/pgalloc.h:63 module:pgtable func:__pte_alloc_one
 1.16MiB      603 fs/xfs/xfs_log_priv.h:700 module:xfs func:xlog_kvmalloc
 1.00MiB      256 mm/swap_cgroup.c:48 module:swap_cgroup func:swap_cgroup_prepare
  734KiB     5380 fs/xfs/kmem.c:20 module:xfs func:kmem_alloc
  640KiB      160 kernel/rcu/tree.c:3184 module:tree func:fill_page_cache_func
  640KiB      160 drivers/char/virtio_console.c:452 module:virtio_console func:alloc_buf

Support for more detailed allocation context including pid, tgid, task
name, allocation size, timestamp and call stack is not posted in this
patchset to keep it small.

Implementation utilizes a more generic concept of code tagging, introduced
as part of this patchset. Code tag is a structure identifying a specific
location in the source code which is generated at compile time and can be
embedded in an application-specific structure. A number of applications
for code tagging have been presented in the original RFC [3].
Code tagging uses the old trick of "define a special elf section for
objects of a given type so that we can iterate over them at runtime" and
creates a proper library for it.

To profile memory allocations, we instrument page, slab and percpu
allocators to record total memory allocated in the associated code tag at
every allocation in the codebase. Every time an allocation is performed by
an instrumented allocator, the code tag at that location increments its
counter by allocation size. Every time the memory is freed the counter is
decremented. To decrement the counter upon freeing, allocated object needs
a reference to its code tag. Page allocators use page_ext to record this
reference while slab allocators use memcg_data (renamed into more generic
slabobj_ext) of the slab page.

Module allocations are accounted for the same way as other kernel
allocations. Module loading and unloading is supported. If a module is
unloaded while one or more of its allocations is still not freed (rather
rare condition), its data section will be kept in memory to allow later
code tag referencing when the allocation is freed later on.

As part of this series we introduce several kernel configs:
CONFIG_CODE_TAGGING - to enable code tagging framework.
CONFIG_MEM_ALLOC_PROFILING - enables memory allocation profiling.
CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT - enables memory allocation
profiling by default.
CONFIG_MEM_ALLOC_PROFILING_DEBUG - enables memory allocation profiling
validation.
Note: CONFIG_MEM_ALLOC_PROFILING enables CONFIG_PAGE_EXTENSION to store
code tag reference in the page_ext object.

/proc/sys/vm/mem_profiling sysctl is provided to enable/disable the
functionality and avoid the performance overhead.

Overhead
To measure the overhead we are comparing the following configurations:
(1) Baseline
(2) Disabled by default (CONFIG_MEM_ALLOC_PROFILING &
    !CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT)
(3) Enabled by default (CONFIG_MEM_ALLOC_PROFILING &
    CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT)
(4) Enabled at runtime (CONFIG_MEM_ALLOC_PROFILING &
    !CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT & /proc/sys/vm/mem_profiling=1)
(5) Memcg (CONFIG_MEMCG_KMEM)
(6) Enabled by default with memcg (CONFIG_MEM_ALLOC_PROFILING &
    CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT & CONFIG_MEMCG_KMEM)

Performance overhead:
To evaluate performance we implemented an in-kernel test executing
multiple get_free_page/free_page and kmalloc/kfree calls with allocation
sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
affinity set to a specific CPU to minimize the noise. Below is performance
comparison between the baseline kernel, profiling when enabled, profiling
when disabled and (for comparison purposes) baseline with
CONFIG_MEMCG_KMEM enabled and allocations using __GFP_ACCOUNT:

                        kmalloc                 pgalloc
(1 baseline)            12.041s                 49.190s
(2 default disabled)    14.970s (+24.33%)       49.684s (+1.00%)
(3 default enabled)     16.859s (+40.01%)       56.287s (+14.43%)
(4 runtime enabled)     16.983s (+41.04%)       55.760s (+13.36%)
(5 memcg)               33.831s (+180.96%)      51.433s (+4.56%)
(6 enabled & memcg)     39.145s (+225.10%)      56.874s (+15.62%)

Memory overhead:
Kernel size:

   text           data            bss            dec            hex
(1) 32638461      18286426        18325508       69250395       420ad5b
(2) 32710110      18646586        18071556       69428252       423641c
(3) 32706918      18646586        18071556       69425060       42357a4
(4) 32709664      18646586        18071556       69427806       423625e
(5) 32715893      18345334        18239492       69300719       42171ef
(6) 32786068      18701958        17993732       69481758       424351e

Memory consumption on a 56 core Intel CPU with 125GB of memory running
Fedora:
Code tags:           192 kB
PageExts:         262144 kB (256MB)
SlabExts:           9876 kB (9.6MB)
PcpuExts:            512 kB (0.5MB)

Total overhead is 0.2% of total memory.

[1] https://lore.kernel.org/all/20230501165450.15352-1-surenb@google.com/
[2] https://docs.google.com/presentation/d/1zQnuMbEfcq9lHUXgJRUZsd1McRAkr3Xq6Wk693YA0To/edit?usp=sharing
[3] https://lore.kernel.org/all/20220830214919.53220-1-surenb@google.com/

[example 1]:
typedef struct codetag {
  const char* file;
  int line;
  int counter;
} codetag;

void my_trampoline(func_ptr func, ...) {
  static codetag callsite_data __section("alloc_tags") =
    { __callsite_FILE, __callsite_LINE, 0 };
  callsite_data.counter++;
  func(...);
}

__callsite_wrapper(my_trampoline)
__attribute__ ((always_inline))
static inline void foo1(void) {
  printf("foo1 function\n");
}

__callsite_wrapper(my_trampoline)
__attribute__ ((always_inline))
static inline void foo2(void) {
  printf("foo2 function\n");
}

void bar(void) {
  foo1();
}

int main(int argc, char** argv) {
  foo1();
  foo2();
  bar();
  return 0;
}

Kent Overstreet (16):
  lib/string_helpers: Add flags param to string_get_size()
  scripts/kallysms: Always include __start and __stop symbols
  fs: Convert alloc_inode_sb() to a macro
  nodemask: Split out include/linux/nodemask_types.h
  prandom: Remove unused include
  change alloc_pages name in ivpu_bo_ops to avoid conflicts
  mm/slub: Mark slab_free_freelist_hook() __always_inline
  mempool: Hook up to memory allocation profiling
  xfs: Memory allocation profiling fixups
  timekeeping: Fix a circular include dependency
  mm: percpu: Introduce pcpuobj_ext
  mm: percpu: Add codetag reference into pcpuobj_ext
  arm64: Fix circular header dependency
  mm: vmalloc: Enable memory allocation profiling
  rhashtable: Plumb through alloc tag
  MAINTAINERS: Add entries for code tagging and memory allocation
    profiling

Suren Baghdasaryan (23):
  mm: enumerate all gfp flags
  mm: introduce slabobj_ext to support slab object extensions
  mm: introduce __GFP_NO_OBJ_EXT flag to selectively prevent slabobj_ext
    creation
  mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
  mm: prevent slabobj_ext allocations for slabobj_ext and kmem_cache
    objects
  slab: objext: introduce objext_flags as extension to
    page_memcg_data_flags
  lib: code tagging framework
  lib: code tagging module support
  lib: prevent module unloading if memory is not freed
  lib: add allocation tagging support for memory allocation profiling
  lib: introduce support for page allocation tagging
  change alloc_pages name in dma_map_ops to avoid name conflicts
  mm: enable page allocation tagging
  mm: create new codetag references during page splitting
  mm/page_ext: enable early_page_ext when
    CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
  lib: add codetag reference into slabobj_ext
  mm/slab: add allocation accounting into slab allocation and free paths
  mm/slab: enable slab allocation tagging for kmalloc and friends
  mm: percpu: enable per-cpu allocation tagging
  lib: add memory allocations report in show_mem()
  codetag: debug: skip objext checking when it's for objext itself
  codetag: debug: mark codetags for reserved pages as empty
  codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext
    allocations

 Documentation/admin-guide/sysctl/vm.rst       |  16 ++
 Documentation/filesystems/proc.rst            |  28 ++
 MAINTAINERS                                   |  16 ++
 arch/arm64/include/asm/spectre.h              |   4 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   2 +-
 arch/x86/kernel/amd_gart_64.c                 |   2 +-
 drivers/accel/ivpu/ivpu_gem.c                 |   8 +-
 drivers/accel/ivpu/ivpu_gem.h                 |   2 +-
 drivers/block/virtio_blk.c                    |   4 +-
 drivers/gpu/drm/gud/gud_drv.c                 |   2 +-
 drivers/iommu/dma-iommu.c                     |   2 +-
 drivers/mmc/core/block.c                      |   4 +-
 drivers/mtd/spi-nor/debugfs.c                 |   6 +-
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    |   4 +-
 drivers/scsi/sd.c                             |   8 +-
 drivers/staging/media/atomisp/pci/hmm/hmm.c   |   2 +-
 drivers/xen/grant-dma-ops.c                   |   2 +-
 drivers/xen/swiotlb-xen.c                     |   2 +-
 fs/xfs/kmem.c                                 |   4 +-
 fs/xfs/kmem.h                                 |  10 +-
 include/asm-generic/codetag.lds.h             |  14 +
 include/asm-generic/vmlinux.lds.h             |   3 +
 include/linux/alloc_tag.h                     | 188 +++++++++++++
 include/linux/codetag.h                       |  83 ++++++
 include/linux/dma-map-ops.h                   |   2 +-
 include/linux/fortify-string.h                |   5 +-
 include/linux/fs.h                            |   6 +-
 include/linux/gfp.h                           | 111 +++++---
 include/linux/gfp_types.h                     | 101 +++++--
 include/linux/hrtimer.h                       |   2 +-
 include/linux/memcontrol.h                    |  56 +++-
 include/linux/mempool.h                       |  73 +++--
 include/linux/mm.h                            |   8 +
 include/linux/mm_types.h                      |   4 +-
 include/linux/nodemask.h                      |   2 +-
 include/linux/nodemask_types.h                |   9 +
 include/linux/page_ext.h                      |   1 -
 include/linux/pagemap.h                       |   9 +-
 include/linux/percpu.h                        |  23 +-
 include/linux/pgalloc_tag.h                   | 105 +++++++
 include/linux/prandom.h                       |   1 -
 include/linux/rhashtable-types.h              |  11 +-
 include/linux/sched.h                         |  26 +-
 include/linux/slab.h                          | 180 ++++++------
 include/linux/slab_def.h                      |   2 +-
 include/linux/slub_def.h                      |   4 +-
 include/linux/string.h                        |   4 +-
 include/linux/string_helpers.h                |  13 +-
 include/linux/time_namespace.h                |   2 +
 include/linux/vmalloc.h                       |  60 +++-
 init/Kconfig                                  |   4 +
 kernel/dma/mapping.c                          |   4 +-
 kernel/kallsyms_selftest.c                    |   2 +-
 kernel/module/main.c                          |  25 +-
 lib/Kconfig.debug                             |  31 +++
 lib/Makefile                                  |   3 +
 lib/alloc_tag.c                               | 212 ++++++++++++++
 lib/codetag.c                                 | 258 ++++++++++++++++++
 lib/rhashtable.c                              |  52 +++-
 lib/string_helpers.c                          |  24 +-
 lib/test-string_helpers.c                     |   4 +-
 mm/compaction.c                               |   7 +-
 mm/filemap.c                                  |   6 +-
 mm/huge_memory.c                              |   2 +
 mm/hugetlb.c                                  |   8 +-
 mm/kfence/core.c                              |  14 +-
 mm/kfence/kfence.h                            |   4 +-
 mm/memcontrol.c                               |  56 +---
 mm/mempolicy.c                                |  42 +--
 mm/mempool.c                                  |  34 +--
 mm/mm_init.c                                  |   1 +
 mm/page_alloc.c                               |  66 +++--
 mm/page_ext.c                                 |  13 +
 mm/page_owner.c                               |   2 +-
 mm/percpu-internal.h                          |  26 +-
 mm/percpu.c                                   | 120 ++++----
 mm/show_mem.c                                 |  15 +
 mm/slab.c                                     |  24 +-
 mm/slab.h                                     | 246 +++++++++++++----
 mm/slab_common.c                              |  96 +++++--
 mm/slub.c                                     |  26 +-
 mm/util.c                                     |  44 +--
 mm/vmalloc.c                                  |  88 +++---
 scripts/kallsyms.c                            |  13 +
 scripts/module.lds.S                          |   7 +
 85 files changed, 2117 insertions(+), 698 deletions(-)
 create mode 100644 include/asm-generic/codetag.lds.h
 create mode 100644 include/linux/alloc_tag.h
 create mode 100644 include/linux/codetag.h
 create mode 100644 include/linux/nodemask_types.h
 create mode 100644 include/linux/pgalloc_tag.h
 create mode 100644 lib/alloc_tag.c
 create mode 100644 lib/codetag.c

-- 
2.42.0.758.gaed0368e0e-goog


