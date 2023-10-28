Return-Path: <linux-fsdevel+bounces-1463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD757DA467
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 02:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE32F282773
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 00:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B1733E0;
	Sat, 28 Oct 2023 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHIYjWzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD528FC
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 00:38:26 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00F129
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 17:38:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a9012ab0adso23501157b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 17:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698453503; x=1699058303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0U9f0GPnYV6HySM//pU94NgpKMw+FvA1LiNkKj/lR8=;
        b=EHIYjWzbYSU6ctz50ItDaCybvJ62FKZojKJZn85HTwmmEp3tpW/+rGRo2MNXNC98Pu
         hh/PD33x9nftZq/lk9RwnsPsdwN+TeG8ggPrWxzSMPAXF1+SxcgmHWKXEBIP6H0n28Wf
         t4AqOIFAE6ABBu0wGscy1DC4JK4tokB0ryUivqmSYTjMc0h248buSyDbGB4WwbtttyBC
         /1vE6HpWUMQedBfwp7wYBybcDp6/vvCSEhMa7Cp+QTrarWBql+uzocklE7SOI6DuCqNQ
         ganZC/gOcyocj6f01LqvgXSPrXOyP9kqoVQo4wS0gZ4kq9aCmyofAu/84IQvxgvsumqN
         Hkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698453503; x=1699058303;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0U9f0GPnYV6HySM//pU94NgpKMw+FvA1LiNkKj/lR8=;
        b=j0r9OhZ3DYwi/3jvSu/Bg4C3itclKaMmoff8tkvEu+bon+L4QEiKckiZnfbCLeX+6T
         stNpsyk9QB+KDf1hLcNlKypfHzBXdPahh6wsmazG0kUiP9pok3tcdi8NAwzGFHZ1yNxh
         GKquzqGmGroUTsEZhE6UF7wc4WqKrmEQBy7pO6S6VAAPFKzUPrfv/5eCxPegS0k+DAFm
         GVgeB/T+8caxJQZn/dI0qBTp8tXEHXMciADEWmM6o4DGREv4F4XhP+joI3zEljzG7KrN
         Omf6oLxG8S8iWaIiiLVkRCmhUuzYU9TxjDoA4mtosbXooKpns9T2deW0/02P/0Xa8zIw
         akDw==
X-Gm-Message-State: AOJu0Yy2806/Jnri1ZkgvPJUMblSYipi7+wMXn+JOe/6IcUCIk4E5VAs
	yLcMerXb+tuqTi9JFPIcBwfaWbzhzzs=
X-Google-Smtp-Source: AGHT+IF57V2+l/aVGkA00/iDfSW7mW6cgyvOmonBHFBLJFbYX0O4V0VSM4y3Q3AqMWGi3S7FNlYXsVsLlew=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cba3:7e7f:79e4:fa57])
 (user=surenb job=sendgmr) by 2002:a81:92c5:0:b0:5a7:af69:a279 with SMTP id
 j188-20020a8192c5000000b005a7af69a279mr98223ywg.9.1698453503001; Fri, 27 Oct
 2023 17:38:23 -0700 (PDT)
Date: Fri, 27 Oct 2023 17:38:10 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231028003819.652322-1-surenb@google.com>
Subject: [PATCH v4 0/5] userfaultfd move option
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	surenb@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch series introduces UFFDIO_MOVE feature to userfaultfd, which
has long been implemented and maintained by Andrea in his local tree [1],
but was not upstreamed due to lack of use cases where this approach would
be better than allocating a new page and copying the contents. Previous
upstraming attempts could be found at [6] and [7].

UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the application
needs pages to be allocated [2]. However, with UFFDIO_MOVE, if pages are
available (in userspace) for recycling, as is usually the case in heap
compaction algorithms, then we can avoid the page allocation and memcpy
(done by UFFDIO_COPY). Also, since the pages are recycled in the
userspace, we avoid the need to release (via madvise) the pages back to
the kernel [3].
We see over 40% reduction (on a Google pixel 6 device) in the compacting
thread=E2=80=99s completion time by using UFFDIO_MOVE vs. UFFDIO_COPY. This=
 was
measured using a benchmark that emulates a heap compaction implementation
using userfaultfd (to allow concurrent accesses by application threads).
More details of the usecase are explained in [3].

Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
touching them within the same vma. Today, it can only be done by mremap,
however it forces splitting the vma.


TODOs for follow-up improvements:
- cross-mm support. Known differences from single-mm and missing pieces:
	- memcg recharging (might need to isolate pages in the process)
	- mm counters
	- cross-mm deposit table moves
	- cross-mm test
	- document the address space where src and dest reside in struct
	  uffdio_move

- TLB flush batching. Will require extensive changes to PTL locking in
move_pages_pte(). OTOH that might let us reuse parts of mremap code.


Changes since v3 [8]:
- changed retry path in folio_lock_anon_vma_read() to unlock and then
relock RCU, per Peter Xu
- removed cross-mm support from initial patchset, per David Hildenbrand
- replaced BUG_ONs with VM_WARN_ON or WARN_ON_ONCE, per David Hildenbrand
- added missing cache flushing, per Lokesh Gidra and Peter Xu
- updated manpage text in the patch description, per Peter Xu
- renamed internal functions from "remap" to "move", per Peter Xu
- added mmap_changing check after taking mmap_lock, per Peter Xu
- changed uffd context check to ensure dst_mm is registered onto uffd we
are operating on, Peter Xu and David Hildenbrand
- changed to non-maybe variants of maybe*_mkwrite(), per David Hildenbrand
- fixed warning for CONFIG_TRANSPARENT_HUGEPAGE=3Dn, per kernel test robot
- comments cleanup, per David Hildenbrand and Peter Xu
- checks for VM_IO,VM_PFNMAP,VM_HUGETLB,..., per David Hildenbrand
- prevent moving pinned pages, per Peter Xu
- changed uffd tests to call move uffd_test_ctx_clear() at the end of the
test run instead of in the beginning of the next run
- added support for testcase-specific ops
- added test for moving PMD-aligned blocks

Changes since v2 [5]:
- renamed UFFDIO_REMAP to UFFDIO_MOVE, per David Hildenbrand
- rebase over mm-unstable to use folio_move_anon_rmap(),
per David Hildenbrand
- added text for manpage explaining DONTFORK and KSM requirements for this
feature, per David Hildenbrand
- check for anon_vma changes in the fast path of folio_lock_anon_vma_read,
per Peter Xu
- updated the title and description of the first patch,
per David Hildenbrand
- updating comments in folio_lock_anon_vma_read() explaining the need for
anon_vma checks, per David Hildenbrand
- changed all mapcount checks to PageAnonExclusive, per Jann Horn and
David Hildenbrand
- changed counters in remap_swap_pte() from MM_ANONPAGES to MM_SWAPENTS,
per Jann Horn
- added a check for PTE change after folio is locked in remap_pages_pte(),
per Jann Horn
- added handling of PMD migration entries and bailout when pmd_devmap(),
per Jann Horn
- added checks to ensure both src and dst VMAs are writable, per Peter Xu
- added UFFD_FEATURE_MOVE, per Peter Xu
- removed obsolete comments, per Peter Xu
- renamed remap_anon_pte to remap_present_pte, per Peter Xu
- added a comment for folio_get_anon_vma() explaining the need for
anon_vma checks, per Peter Xu
- changed error handling in remap_pages() to make it more clear,
per Peter Xu
- changed EFAULT to EAGAIN to retry when a hugepage appears or disappears
from under us, per Peter Xu
- added links to previous upstreaming attempts, per David Hildenbrand

Changes since v1 [4]:
- add mmget_not_zero in userfaultfd_remap, per Jann Horn
- removed extern from function definitions, per Matthew Wilcox
- converted to folios in remap_pages_huge_pmd, per Matthew Wilcox
- use PageAnonExclusive in remap_pages_huge_pmd, per David Hildenbrand
- handle pgtable transfers between MMs, per Jann Horn
- ignore concurrent A/D pte bit changes, per Jann Horn
- split functions into smaller units, per David Hildenbrand
- test for folio_test_large in remap_anon_pte, per Matthew Wilcox
- use pte_swp_exclusive for swapcount check, per David Hildenbrand
- eliminated use of mmu_notifier_invalidate_range_start_nonblock,
per Jann Horn
- simplified THP alignment checks, per Jann Horn
- refactored the loop inside remap_pages, per Jann Horn
- additional clarifying comments, per Jann Horn

Main changes since Andrea's last version [1]:
- Trivial translations from page to folio, mmap_sem to mmap_lock
- Replace pmd_trans_unstable() with pte_offset_map_nolock() and handle its
possible failure
- Move pte mapping into remap_pages_pte to allow for retries when source
page or anon_vma is contended. Since pte_offset_map_nolock() start RCU
read section, we can't block anymore after mapping a pte, so have to unmap
the ptesm do the locking and retry.
- Add and use anon_vma_trylock_write()  to avoid blocking while in RCU
read section.
- Accommodate changes in mmu_notifier_range_init() API, switch to
mmu_notifier_invalidate_range_start_nonblock() to avoid blocking while in
RCU read section.
- Open-code now removed __swp_swapcount()
- Replace pmd_read_atomic() with pmdp_get_lockless()
- Add new selftest for UFFDIO_MOVE

[1] https://gitlab.com/aarcange/aa/-/commit/2aec7aea56b10438a3881a20a411aa4=
b1fc19e92
[2] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcange@r=
edhat.com/
[3] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqx=
RCyjniNVjp0Aw@mail.gmail.com/
[4] https://lore.kernel.org/all/20230914152620.2743033-1-surenb@google.com/
[5] https://lore.kernel.org/all/20230923013148.1390521-1-surenb@google.com/
[6] https://lore.kernel.org/all/1425575884-2574-21-git-send-email-aarcange@=
redhat.com/
[7] https://lore.kernel.org/all/cover.1547251023.git.blake.caldwell@colorad=
o.edu/
[8] https://lore.kernel.org/all/20231009064230.2952396-1-surenb@google.com/

The patchset applies over mm-unstable.

Andrea Arcangeli (2):
  mm/rmap: support move to different root anon_vma in
    folio_move_anon_rmap()
  userfaultfd: UFFDIO_MOVE uABI

Suren Baghdasaryan (3):
  selftests/mm: call uffd_test_ctx_clear at the end of the test
  selftests/mm: add uffd_test_case_ops to allow test case-specific
    operations
  selftests/mm: add UFFDIO_MOVE ioctl test

 Documentation/admin-guide/mm/userfaultfd.rst |   3 +
 fs/userfaultfd.c                             |  72 +++
 include/linux/rmap.h                         |   5 +
 include/linux/userfaultfd_k.h                |  11 +
 include/uapi/linux/userfaultfd.h             |  29 +-
 mm/huge_memory.c                             | 122 ++++
 mm/khugepaged.c                              |   3 +
 mm/rmap.c                                    |  30 +
 mm/userfaultfd.c                             | 596 +++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.c     |  51 +-
 tools/testing/selftests/mm/uffd-common.h     |  11 +
 tools/testing/selftests/mm/uffd-stress.c     |   5 +-
 tools/testing/selftests/mm/uffd-unit-tests.c | 144 +++++
 13 files changed, 1078 insertions(+), 4 deletions(-)

--=20
2.42.0.820.g83a721a137-goog


