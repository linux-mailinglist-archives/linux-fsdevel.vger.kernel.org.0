Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3E24A9D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHSXJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 19:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgHSXJ5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:09:57 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5800920758;
        Wed, 19 Aug 2020 23:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597878596;
        bh=Zs37+NFgfTAwU8+6P/Z6Z9yG76/9zkHQDwSQ51MWWZo=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=FSw4YzJnruXeW8Rpm3WXHryxMmQ66xTldgsuL10QywIO1PmEqYlgTBw/jHbIQtBWq
         mHoEMdNjfUMlliqm2YDlZ7HxBUp+Yf4TExzNbYc4OFCgDVbX6lQ22OtTM4ypsiu84O
         A9G2SEmhx4sWjgk3K0e38OyWtchdfHshG56GskPk=
Date:   Wed, 19 Aug 2020 16:09:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-08-19-16-09 uploaded
Message-ID: <20200819230955._jX0yGRcN%akpm@linux-foundation.org>
In-Reply-To: <20200814172939.55d6d80b6e21e4241f1ee1f3@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-08-19-16-09 has been uploaded to

   https://www.ozlabs.org/~akpm/mmotm/

mmotm-readme.txt says

README for mm-of-the-moment:

https://www.ozlabs.org/~akpm/mmotm/

This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
more than once a week.

You will need quilt to apply these patches to the latest Linus release (5.x
or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
https://ozlabs.org/~akpm/mmotm/series

The file broken-out.tar.gz contains two datestamp files: .DATE and
.DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
followed by the base kernel version against which this patch series is to
be applied.

This tree is partially included in linux-next.  To see which patches are
included in linux-next, consult the `series' file.  Only the patches
within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
linux-next.


A full copy of the full kernel tree with the linux-next and mmotm patches
already applied is available through git within an hour of the mmotm
release.  Individual mmotm releases are tagged.  The master branch always
points to the latest release, so it's constantly rebasing.

	https://github.com/hnaz/linux-mm

The directory https://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
contains daily snapshots of the -mm tree.  It is updated more frequently
than mmotm, and is untested.

A git copy of this tree is also available at

	https://github.com/hnaz/linux-mm



This mmotm tree contains the following patches against 5.9-rc1:
(patches marked "*" will be included in linux-next)

  origin.patch
* mailmap-add-andi-kleen.patch
* hugetlb_cgroup-convert-comma-to-semicolon.patch
* khugepaged-adjust-vm_bug_on_mm-in-__khugepaged_enter.patch
* mm-vunmap-add-cond_resched-in-vunmap_pmd_range.patch
* mm-slub-fix-conversion-of-freelist_corrupted.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mm-fix-missing-function-declaration.patch
* fork-silence-a-false-postive-warning-in-__mmdrop.patch
* romfs-fix-uninitialized-memory-leak-in-romfs_dev_read.patch
* kernel-relayc-fix-memleak-on-destroy-relay-channel.patch
* uprobes-__replace_page-avoid-bug-in-munlock_vma_page.patch
* squashfs-avoid-bio_alloc-failure-with-1mbyte-blocks.patch
* mm-include-cma-pages-in-lowmem_reserve-at-boot.patch
* mm-page_alloc-fix-core-hung-in-free_pcppages_bulk.patch
* mm-slub-re-initialize-randomized-freelist-sequence-in-calculate_sizes.patch
* mm-slub-re-initialize-randomized-freelist-sequence-in-calculate_sizes-fix.patch
* mm-thp-swap-fix-allocating-cluster-for-swapfile-by-mistake.patch
* checkpatch-test-git_dir-changes.patch
* scripts-tagssh-exclude-tools-directory-from-tags-generation.patch
* fs-ocfs2-delete-repeated-words-in-comments.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-slub-branch-optimization-in-free-slowpath.patch
* mm-slub-fix-missing-alloc_slowpath-stat-when-bulk-alloc.patch
* mm-slub-make-add_full-condition-more-explicit.patch
* device-dax-fix-mismatches-of-request_mem_region.patch
* mm-debug-do-not-dereference-i_ino-blindly.patch
* mm-dump_page-rename-head_mapcount-head_compound_mapcount.patch
* mm-gup_benchmark-use-pin_user_pages-for-foll_longterm-flag.patch
* mm-gup-dont-permit-users-to-call-get_user_pages-with-foll_longterm.patch
* mm-remove-activate_page-from-unuse_pte.patch
* mm-remove-superfluous-__clearpageactive.patch
* mm-remove-superfluous-__clearpagewaiters.patch
* memremap-convert-devmap-static-branch-to-incdec.patch
* mm-memcg-warning-on-memcg-after-readahead-page-charged.patch
* mm-memcg-remove-useless-check-on-page-mem_cgroup.patch
* mm-thp-move-lru_add_page_tail-func-to-huge_memoryc.patch
* mm-thp-clean-up-lru_add_page_tail.patch
* mm-thp-remove-code-path-which-never-got-into.patch
* mm-thp-narrow-lru-locking.patch
* mm-memcontrol-use-flex_array_size-helper-in-memcpy.patch
* mm-memcontrol-use-the-preferred-form-for-passing-the-size-of-a-structure-type.patch
* mm-account-pmd-tables-like-pte-tables.patch
* mm-memory-fix-typo-in-__do_fault-comment.patch
* mm-memoryc-replace-vmf-vma-with-variable-vma.patch
* mm-mmap-rename-__vma_unlink_common-to-__vma_unlink.patch
* mm-mmap-leverage-vma_rb_erase_ignore-to-implement-vma_rb_erase.patch
* mmap-locking-api-add-mmap_lock_is_contended.patch
* mm-smaps-extend-smap_gather_stats-to-support-specified-beginning.patch
* mm-proc-smaps_rollup-do-not-stall-write-attempts-on-mmap_lock.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-dmapoolc-replace-open-coded-list_for_each_entry_safe.patch
* mm-dmapoolc-replace-hard-coded-function-name-with-__func__.patch
* mm-memory-failure-do-pgoff-calculation-before-for_each_process.patch
* docs-vm-fix-mm_count-vs-mm_users-counter-confusion.patch
* mm-page_alloc-tweak-comments-in-has_unmovable_pages.patch
* mm-page_isolation-exit-early-when-pageblock-is-isolated-in-set_migratetype_isolate.patch
* mm-page_isolation-drop-warn_on_once-in-set_migratetype_isolate.patch
* mm-page_isolation-cleanup-set_migratetype_isolate.patch
* virtio-mem-dont-special-case-zone_movable.patch
* mm-document-semantics-of-zone_movable.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* kvm-ppc-book3s-hv-simplify-kvm_cma_reserve.patch
* dma-contiguous-simplify-cma_early_percent_memory.patch
* arm-xtensa-simplify-initialization-of-high-memory-pages.patch
* arm64-numa-simplify-dummy_numa_init.patch
* h8300-nds32-openrisc-simplify-detection-of-memory-extents.patch
* riscv-drop-unneeded-node-initialization.patch
* mircoblaze-drop-unneeded-numa-and-sparsemem-initializations.patch
* memblock-make-for_each_memblock_type-iterator-private.patch
* memblock-make-memblock_debug-and-related-functionality-private.patch
* memblock-make-memblock_debug-and-related-functionality-private-fix.patch
* memblock-reduce-number-of-parameters-in-for_each_mem_range.patch
* arch-mm-replace-for_each_memblock-with-for_each_mem_pfn_range.patch
* arch-drivers-replace-for_each_membock-with-for_each_mem_range.patch
* x86-setup-simplify-initrd-relocation-and-reservation.patch
* x86-setup-simplify-reserve_crashkernel.patch
* memblock-remove-unused-memblock_mem_size.patch
* memblock-implement-for_each_reserved_mem_region-using-__next_mem_region.patch
* memblock-use-separate-iterators-for-memory-and-reserved-regions.patch
* mmhwpoison-cleanup-unused-pagehuge-check.patch
* mm-hwpoison-remove-recalculating-hpage.patch
* mmhwpoison-inject-dont-pin-for-hwpoison_filter.patch
* mmhwpoison-un-export-get_hwpoison_page-and-make-it-static.patch
* mmhwpoison-kill-put_hwpoison_page.patch
* mmhwpoison-unify-thp-handling-for-hard-and-soft-offline.patch
* mmhwpoison-rework-soft-offline-for-free-pages.patch
* mmhwpoison-rework-soft-offline-for-in-use-pages.patch
* mmhwpoison-refactor-soft_offline_huge_page-and-__soft_offline_page.patch
* mmhwpoison-return-0-if-the-page-is-already-poisoned-in-soft-offline.patch
* mmhwpoison-introduce-mf_msg_unsplit_thp.patch
* mmhwpoison-double-check-page-count-in-__get_any_page.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
* mm-util-update-the-kerneldoc-for-kstrdup_const.patch
* mm-memory_hotplug-inline-__offline_pages-into-offline_pages.patch
* mm-memory_hotplug-enforce-section-granularity-when-onlining-offlining.patch
* mm-memory_hotplug-simplify-page-offlining.patch
* mm-page_alloc-simplify-__offline_isolated_pages.patch
* mm-memory_hotplug-drop-nr_isolate_pageblock-in-offline_pages.patch
* mm-page_isolation-simplify-return-value-of-start_isolate_page_range.patch
* mm-memory_hotplug-simplify-page-onlining.patch
* mm-page_alloc-drop-stale-pageblock-comment-in-memmap_init_zone.patch
* mm-pass-migratetype-into-memmap_init_zone-and-move_pfn_range_to_zone.patch
* mm-memory_hotplug-mark-pageblocks-migrate_isolate-while-onlining-memory.patch
* mm-slab-remove-duplicate-include.patch
* mm-page_reporting-drop-stale-list-head-check-in-page_reporting_cycle.patch
* mm-highmem-clean-up-endif-comments.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-sysctl-make-protected_-world-readable.patch
* fs-configfs-delete-repeated-words-in-comments.patch
* bitops-simplify-get_count_order_long.patch
* bitops-use-the-same-mechanism-for-get_count_order.patch
* checkpatch-add-kconfig-prefix.patch
* checkpatch-move-repeated-word-test.patch
* checkpatch-add-test-for-comma-use-that-should-be-semicolon.patch
* panic-dump-registers-on-panic_on_warn.patch
* aio-simplify-read_events.patch
* proc-add-struct-mount-struct-super_block-addr-in-lx-mounts-command.patch
* tasks-add-headers-and-improve-spacing-format.patch
* romfs-support-inode-blocks-calculation.patch
  linux-next.patch
* ia64-fix-build-error-with-coredump.patch
* mm-madvise-pass-task-and-mm-to-do_madvise.patch
* pid-move-pidfd_get_pid-to-pidc.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix.patch
* mm-madvise-check-fatal-signal-pending-of-target-process.patch
* mm-memory-failure-remove-a-wrapper-for-alloc_migration_target.patch
* mm-memory_hotplug-remove-a-wrapper-for-alloc_migration_target.patch
* mm-migrate-avoid-possible-unnecessary-process-right-check-in-kernel_move_pages.patch
* mm-mmap-add-inline-vma_next-for-readability-of-mmap-code.patch
* mm-mmap-add-inline-munmap_vma_range-for-code-readability.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
