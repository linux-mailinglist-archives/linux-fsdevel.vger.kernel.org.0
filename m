Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0EC3A8F5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 05:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFPD0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 23:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFPD0s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:26:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6F0861246;
        Wed, 16 Jun 2021 03:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623813882;
        bh=iJeVB8yFksfhIwGsN39/Cvtle6B/gHwyqNvQ8MSz9eE=;
        h=Date:From:To:Subject:From;
        b=YENC6qBKuSJUvUZj986XXJl3thzfxDOPA14lhjahnzJdKDabUI1grtRXjj2GdtxTU
         +pCODNioffj/00/dw3KH4srXXQbkPwGq5l4056ycnFJQlfpCpcSgtIck887/v4PI5+
         EXp5lwxAuiiM5pDSbrl5rNWu7ccDQfKZWyRHtv14=
Date:   Tue, 15 Jun 2021 20:24:42 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-06-15-20-24 uploaded
Message-ID: <20210616032442.8mhWwutt2%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-06-15-20-24 has been uploaded to

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



This mmotm tree contains the following patches against 5.13-rc6:
(patches marked "*" will be included in linux-next)

  origin.patch
* mmhwpoison-fix-race-with-hugetlb-page-allocation.patch
* mm-swap-fix-pte_same_as_swp-not-removing-uffd-wp-bit-when-compare.patch
* mm-slub-clarify-verification-reporting.patch
* mm-slub-fix-redzoning-for-small-allocations.patch
* mm-slub-actually-fix-freelist-pointer-vs-redzoning.patch
* mm-hugetlb-expand-restore_reserve_on_error-functionality.patch
* mm-memory-failure-make-sure-wait-for-page-writeback-in-memory_failure.patch
* crash_core-vmcoreinfo-append-section_size_bits-to-vmcoreinfo.patch
* mm-slubc-include-swabh.patch
* mm-thp-use-head-page-in-__migration_entry_wait.patch
* mm-thp-fix-__split_huge_pmd_locked-on-shmem-migration-entry.patch
* mm-thp-make-is_huge_zero_pmd-safe-and-quicker.patch
* mm-thp-try_to_unmap-use-ttu_sync-for-safe-splitting.patch
* mm-thp-fix-vma_address-if-virtual-address-below-file-offset.patch
* mm-thp-fix-page_address_in_vma-on-file-thp-tails.patch
* mm-thp-unmap_mapping_page-to-fix-thp-truncate_cleanup_page.patch
* mm-thp-replace-debug_vm-bug-with-vm_warn-when-unmap-fails-for-split.patch
* mm-sparse-fix-check_usemap_section_nr-warnings.patch
* mm-page_vma_mapped_walk-use-page-for-pvmw-page.patch
* mm-page_vma_mapped_walk-settle-pagehuge-on-entry.patch
* mm-page_vma_mapped_walk-use-pmde-for-pvmw-pmd.patch
* mm-page_vma_mapped_walk-prettify-pvmw_migration-block.patch
* mm-page_vma_mapped_walk-crossing-page-table-boundary.patch
* mm-page_vma_mapped_walk-add-a-level-of-indentation.patch
* mm-page_vma_mapped_walk-use-goto-instead-of-while-1.patch
* mm-page_vma_mapped_walk-get-vma_address_end-earlier.patch
* mm-thp-fix-page_vma_mapped_walk-if-thp-mapped-by-ptes.patch
* mm-thp-another-pvmw_sync-fix-in-page_vma_mapped_walk.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_delete_device_group.patch
* mm-vmalloc-add-vmalloc_no_huge.patch
* mm-vmalloc-add-vmalloc_no_huge-fix.patch
* kvm-s390-prepare-for-hugepage-vmalloc.patch
* kthread_worker-split-code-for-canceling-the-delayed-work-timer.patch
* kthread-prevent-deadlock-when-kthread_mod_delayed_work-races-with-kthread_cancel_delayed_work_sync.patch
* mm-futex-fix-shared-futex-pgoff-on-shmem-huge-page.patch
* mm-futex-fix-shared-futex-pgoff-on-shmem-huge-page-fix.patch
* mm-gup-fix-try_grab_compound_head-race-with-split_huge_page.patch
* mm-memory-failure-use-a-mutex-to-avoid-memory_failure-races.patch
* mm-memory-failure-use-a-mutex-to-avoid-memory_failure-races-fix.patch
* mmhwpoison-return-ehwpoison-to-denote-that-the-page-has-already-been-poisoned.patch
* mm-hwpoison-do-not-lock-page-again-when-me_huge_page-successfully-recovers.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* kthread-switch-to-new-kerneldoc-syntax-for-named-variable-macro-argument.patch
* kthread_worker-fix-return-value-when-kthread_mod_delayed_work-races-with-kthread_cancel_delayed_work_sync.patch
* ia64-headers-drop-duplicated-words.patch
* ia64-mca_drv-fix-incorrect-array-size-calculation.patch
* streamline_configpl-make-spacing-consistent.patch
* streamline_configpl-add-softtabstop=4-for-vim-users.patch
* scripts-spellingtxt-add-more-spellings-to-spellingtxt.patch
* squashfs-add-option-to-panic-on-errors.patch
* ocfs2-remove-unnecessary-init_list_head.patch
* ocfs2-fix-snprintf-checking.patch
* ocfs2-remove-redundant-assignment-to-pointer-queue.patch
* ocfs2-remove-repeated-uptodate-check-for-buffer.patch
* ocfs2-replaced-simple_strtoull-with-kstrtoull.patch
* ocfs2-remove-redundant-initialization-of-variable-ret.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* kernel-watchdog-modify-the-explanation-related-to-watchdog-thread.patch
* doc-watchdog-modify-the-explanation-related-to-watchdog-thread.patch
* doc-watchdog-modify-the-doc-related-to-watchdog-%u.patch
  mm.patch
* kunit-make-test-lock-irq-safe.patch
* mm-slub-kunit-add-a-kunit-test-for-slub-debugging-functionality.patch
* mm-slub-kunit-add-a-kunit-test-for-slub-debugging-functionality-fix.patch
* mm-slub-kunit-add-a-kunit-test-for-slub-debugging-functionality-fix-2.patch
* slub-remove-resiliency_test-function.patch
* mm-slub-change-run-time-assertion-in-kmalloc_index-to-compile-time.patch
* mm-slub-change-run-time-assertion-in-kmalloc_index-to-compile-time-fix.patch
* mm-slub-change-run-time-assertion-in-kmalloc_index-to-compile-time-fix-2.patch
* mm-slub-change-run-time-assertion-in-kmalloc_index-to-compile-time-fix-3.patch
* slub-restore-slub_debug=-behavior.patch
* slub-actually-use-message-in-restore_bytes.patch
* slub-indicate-slab_fix-uses-printf-formats.patch
* slub-force-on-no_hash_pointers-when-slub_debug-is-enabled.patch
* slub-force-on-no_hash_pointers-when-slub_debug-is-enabled-fix.patch
* mm-slub-move-sysfs-slab-alloc-free-interfaces-to-debugfs.patch
* mm-kmemleak-fix-the-possible-wrong-memory-scanning-period.patch
* tools-vm-page_owner_sortc-fix-the-potential-stack-overflow-risk.patch
* mm-debug_vm_pgtable-ensure-thp-availability-via-has_transparent_hugepage.patch
* mm-mmap_lock-use-local-locks-instead-of-disabling-preemption.patch
* mm-mark-idle-page-tracking-as-broken.patch
* mm-page-writeback-kill-get_writeback_state-comments.patch
* mm-page-writeback-fix-performance-when-bdis-share-of-ratio-is-0.patch
* mm-page-writeback-update-the-comment-of-dirty-position-control.patch
* mm-page-writeback-use-__this_cpu_inc-in-account_page_dirtied.patch
* writeback-cgroup-do-not-switch-inodes-with-i_will_free-flag.patch
* writeback-cgroup-add-smp_mb-to-cgroup_writeback_umount.patch
* writeback-cgroup-increment-isw_nr_in_flight-before-grabbing-an-inode.patch
* writeback-cgroup-switch-to-rcu_work-api-in-inode_switch_wbs.patch
* writeback-cgroup-keep-list-of-inodes-attached-to-bdi_writeback.patch
* writeback-cgroup-split-out-the-functional-part-of-inode_switch_wbs_work_fn.patch
* writeback-cgroup-support-switching-multiple-inodes-at-once.patch
* writeback-cgroup-release-dying-cgwbs-by-switching-attached-inodes.patch
* writeback-cgroup-release-dying-cgwbs-by-switching-attached-inodes-fix-2.patch
* writeback-cgroup-release-dying-cgwbs-by-switching-attached-inodes-fix.patch
* writeback-cgroup-release-dying-cgwbs-by-switching-attached-inodes-fix-3.patch
* mm-remove-irqsave-restore-locking-from-contexts-with-irqs-enabled.patch
* fs-drop_caches-fix-skipping-over-shadow-cache-inodes.patch
* fs-inode-count-invalidated-shadow-pages-in-pginodesteal.patch
* vfs-keep-inodes-with-page-cache-off-the-inode-shrinker-lru.patch
* fs-unexport-__set_page_dirty.patch
* fs-move-ramfs_aops-to-libfs.patch
* mm-require-set_page_dirty-to-be-explicitly-wire-up.patch
* mm-writeback-move-__set_page_dirty-to-core-mm.patch
* mm-writeback-use-__set_page_dirty-in-__set_page_dirty_nobuffers.patch
* iomap-use-__set_page_dirty_nobuffers.patch
* fs-remove-anon_set_page_dirty.patch
* fs-remove-noop_set_page_dirty.patch
* fs-remove-noop_set_page_dirty-fix.patch
* mm-move-page-dirtying-prototypes-from-mmh.patch
* mm-gup_benchmark-support-threading.patch
* mm-gup-allow-foll_pin-to-scale-in-smp.patch
* mm-gup-pack-has_pinned-in-mmf_has_pinned.patch
* mm-gup-pack-has_pinned-in-mmf_has_pinned-checkpatch-fixes.patch
* mm-gup-pack-has_pinned-in-mmf_has_pinned-fix.patch
* mm-swapfile-use-percpu_ref-to-serialize-against-concurrent-swapoff.patch
* swap-fix-do_swap_page-race-with-swapoff.patch
* mm-swap-remove-confusing-checking-for-non_swap_entry-in-swap_ra_info.patch
* mm-shmem-fix-shmem_swapin-race-with-swapoff.patch
* mm-swapfile-move-get_swap_page_of_type-under-config_hibernation.patch
* mm-swapfile-move-get_swap_page_of_type-under-config_hibernation-fix.patch
* mm-swapfile-move-get_swap_page_of_type-under-config_hibernation-fix-2.patch
* mm-swap-remove-unused-local-variable-nr_shadows.patch
* mm-swap_slotsc-delete-meaningless-forward-declarations.patch
* mm-swap-remove-unnecessary-smp_rmb-in-swap_type_to_swap_info.patch
* mm-free-idle-swap-cache-page-after-cow.patch
* swap-check-mapping_empty-for-swap-cache-before-being-freed.patch
* mm-memcg-move-mod_objcg_state-to-memcontrolc.patch
* mm-memcg-cache-vmstat-data-in-percpu-memcg_stock_pcp.patch
* mm-memcg-improve-refill_obj_stock-performance.patch
* mm-memcg-optimize-user-context-object-stock-access.patch
* mm-memcg-optimize-user-context-object-stock-access-checkpatch-fixes.patch
* mm-memcg-optimize-user-context-object-stock-access-fix.patch
* mm-memcg-slab-properly-set-up-gfp-flags-for-objcg-pointer-array.patch
* mm-memcg-slab-create-a-new-set-of-kmalloc-cg-n-caches.patch
* mm-memcg-slab-create-a-new-set-of-kmalloc-cg-n-caches-fix.patch
* mm-memcg-slab-create-a-new-set-of-kmalloc-cg-n-caches-v5.patch
* mm-memcg-slab-create-a-new-set-of-kmalloc-cg-n-caches-v5-fix.patch
* mm-memcg-slab-disable-cache-merging-for-kmalloc_normal-caches.patch
* mm-memcontrol-fix-root_mem_cgroup-charging.patch
* mm-memcontrol-fix-page-charging-in-page-replacement.patch
* mm-memcontrol-bail-out-early-when-mm-in-get_mem_cgroup_from_mm.patch
* mm-memcontrol-remove-the-pgdata-parameter-of-mem_cgroup_page_lruvec.patch
* mm-memcontrol-simplify-lruvec_holds_page_lru_lock.patch
* mm-memcontrol-rename-lruvec_holds_page_lru_lock-to-page_matches_lruvec.patch
* mm-memcontrol-simplify-the-logic-of-objcg-pinning-memcg.patch
* mm-memcontrol-move-obj_cgroup_uncharge_pages-out-of-css_set_lock.patch
* mm-vmscan-remove-noinline_for_stack.patch
* memcontrol-use-flexible-array-member.patch
* loop-use-worker-per-cgroup-instead-of-kworker.patch
* mm-charge-active-memcg-when-no-mm-is-set.patch
* loop-charge-i-o-to-mem-and-blk-cg.patch
* mm-memcontrol-remove-trailing-semicolon-in-macros.patch
* perf-map_executable-does-not-indicate-vm_mayexec.patch
* binfmt-remove-in-tree-usage-of-map_executable.patch
* binfmt-remove-in-tree-usage-of-map_executable-fix.patch
* mm-ignore-map_executable-in-ksys_mmap_pgoff.patch
* mm-mmapc-logic-of-find_vma_intersection-repeated-in-__do_munmap.patch
* mm-mmap-introduce-unlock_range-for-code-cleanup.patch
* mm-mmap-introduce-unlock_range-for-code-cleanup-fix.patch
* mm-mmap-use-find_vma_intersection-in-do_mmap-for-overlap.patch
* mm-memoryc-fix-comment-of-finish_mkwrite_fault.patch
* mm-add-vma_lookup-update-find_vma_intersection-comments.patch
* drm-i915-selftests-use-vma_lookup-in-__igt_mmap.patch
* arch-arc-kernel-troubleshoot-use-vma_lookup-instead-of-find_vma.patch
* arch-arm64-kvm-use-vma_lookup-instead-of-find_vma_intersection.patch
* arch-powerpc-kvm-book3s_hv_uvmem-use-vma_lookup-instead-of-find_vma_intersection.patch
* arch-powerpc-kvm-book3s-use-vma_lookup-in-kvmppc_hv_setup_htab_rma.patch
* arch-mips-kernel-traps-use-vma_lookup-instead-of-find_vma.patch
* arch-m68k-kernel-sys_m68k-use-vma_lookup-in-sys_cacheflush.patch
* x86-sgx-use-vma_lookup-in-sgx_encl_find.patch
* virt-kvm-use-vma_lookup-instead-of-find_vma_intersection.patch
* vfio-use-vma_lookup-instead-of-find_vma_intersection.patch
* net-ipv5-tcp-use-vma_lookup-in-tcp_zerocopy_receive.patch
* drm-amdgpu-use-vma_lookup-in-amdgpu_ttm_tt_get_user_pages.patch
* media-videobuf2-use-vma_lookup-in-get_vaddr_frames.patch
* misc-sgi-gru-grufault-use-vma_lookup-in-gru_find_vma.patch
* kernel-events-uprobes-use-vma_lookup-in-find_active_uprobe.patch
* lib-test_hmm-use-vma_lookup-in-dmirror_migrate.patch
* mm-ksm-use-vma_lookup-in-find_mergeable_vma.patch
* mm-migrate-use-vma_lookup-in-do_pages_stat_array.patch
* mm-mremap-use-vma_lookup-in-vma_to_resize.patch
* mm-memoryc-use-vma_lookup-in-__access_remote_vm.patch
* mm-mempolicy-use-vma_lookup-in-__access_remote_vm.patch
* mm-update-legacy-flush_tlb_-to-use-vma.patch
* lazy-tlb-introduce-lazy-mm-refcount-helper-functions.patch
* lazy-tlb-introduce-lazy-mm-refcount-helper-functions-fix.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable-fix.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable-fix-2.patch
* lazy-tlb-shoot-lazies-a-non-refcounting-lazy-tlb-option.patch
* lazy-tlb-shoot-lazies-a-non-refcounting-lazy-tlb-option-fix.patch
* powerpc-64s-enable-mmu_lazy_tlb_shootdown.patch
* mm-improve-mprotectrw-efficiency-on-pages-referenced-once.patch
* mm-improve-mprotectrw-efficiency-on-pages-referenced-once-v5.patch
* h8300-remove-unused-variable.patch
* mm-dmapool-use-device_attr_ro-macro.patch
* mm-tracing-unify-pfn-format-strings.patch
* mm-page_alloc-add-an-alloc_pages_bulk_array_node-helper.patch
* mm-vmalloc-switch-to-bulk-allocator-in-__vmalloc_area_node.patch
* mm-vmalloc-print-a-warning-message-first-on-failure.patch
* mm-vmalloc-remove-quoted-string-split-across-lines.patch
* mm-vmalloc-fallback-to-a-single-page-allocator.patch
* printk-introduce-dump_stack_lvl.patch
* printk-introduce-dump_stack_lvl-fix.patch
* kasan-use-dump_stack_lvlkern_err-to-print-stacks.patch
* kasan-test-improve-failure-message-in-kunit_expect_kasan_fail.patch
* mm-report-which-part-of-mem-is-being-freed-on-initmem-case.patch
* mm-page_alloc-__alloc_pages_bulk-do-bounds-check-before-accessing-array.patch
* mm-mmzoneh-simplify-is_highmem_idx.patch
* mm-make-__dump_page-static.patch
* mm-page_alloc-bail-out-on-fatal-signal-during-reclaim-compaction-retry-attempt.patch
* mm-debug-factor-pagepoisoned-out-of-__dump_page.patch
* mm-page_owner-constify-dump_page_owner.patch
* mm-make-compound_head-const-preserving.patch
* mm-constify-get_pfnblock_flags_mask-and-get_pfnblock_migratetype.patch
* mm-constify-page_count-and-page_ref_count.patch
* mm-optimise-nth_page-for-contiguous-memmap.patch
* mm-page_alloc-switch-to-pr_debug.patch
* kbuild-skip-per-cpu-btf-generation-for-pahole-v118-v121.patch
* mm-page_alloc-split-per-cpu-page-lists-and-zone-stats.patch
* mm-page_alloc-split-per-cpu-page-lists-and-zone-stats-fix.patch
* mm-page_alloc-split-per-cpu-page-lists-and-zone-stats-fix-fix.patch
* mm-page_alloc-convert-per-cpu-list-protection-to-local_lock.patch
* mm-page_alloc-convert-per-cpu-list-protection-to-local_lock-fix.patch
* mm-page_alloc-convert-per-cpu-list-protection-to-local_lock-fix-checkpatch-fixes.patch
* mm-vmstat-convert-numa-statistics-to-basic-numa-counters.patch
* mm-vmstat-inline-numa-event-counter-updates.patch
* mm-page_alloc-batch-the-accounting-updates-in-the-bulk-allocator.patch
* mm-page_alloc-reduce-duration-that-irqs-are-disabled-for-vm-counters.patch
* mm-page_alloc-explicitly-acquire-the-zone-lock-in-__free_pages_ok.patch
* mm-page_alloc-avoid-conflating-irqs-disabled-with-zone-lock.patch
* mm-page_alloc-update-pgfree-outside-the-zone-lock-in-__free_pages_ok.patch
* mm-page_alloc-dump-migrate-failed-pages-only-at-ebusy.patch
* mm-page_alloc-delete-vmpercpu_pagelist_fraction.patch
* mm-page_alloc-disassociate-the-pcp-high-from-pcp-batch.patch
* mm-page_alloc-disassociate-the-pcp-high-from-pcp-batch-fix-2.patch
* mm-page_alloc-adjust-pcp-high-after-cpu-hotplug-events.patch
* mm-page_alloc-scale-the-number-of-pages-that-are-batch-freed.patch
* mm-page_alloc-limit-the-number-of-pages-on-pcp-lists-when-reclaim-is-active.patch
* mm-page_alloc-introduce-vmpercpu_pagelist_high_fraction.patch
* mm-page_alloc-introduce-vmpercpu_pagelist_high_fraction-fix.patch
* mm-drop-section_shift-in-code-comments.patch
* mm-page_alloc-improve-memmap_pages-dbg-msg.patch
* mm-page_alloc-fix-counting-of-managed_pages.patch
* mm-page_alloc-move-free_the_page.patch
* alpha-remove-discontigmem-and-numa.patch
* arc-update-comment-about-highmem-implementation.patch
* arc-remove-support-for-discontigmem.patch
* m68k-remove-support-for-discontigmem.patch
* mm-remove-config_discontigmem.patch
* arch-mm-remove-stale-mentions-of-disconigmem.patch
* docs-remove-description-of-discontigmem.patch
* mm-replace-config_need_multiple_nodes-with-config_numa.patch
* mm-replace-config_need_multiple_nodes-with-config_numa-fix.patch
* mm-replace-config_flat_node_mem_map-with-config_flatmem.patch
* mm-page_alloc-allow-high-order-pages-to-be-stored-on-the-per-cpu-lists.patch
* mmhwpoison-send-sigbus-with-error-virutal-address.patch
* mmhwpoison-send-sigbus-with-error-virutal-address-fix.patch
* mmhwpoison-make-get_hwpoison_page-call-get_any_page.patch
* mm-memory_hotplug-factor-out-bootmem-core-functions-to-bootmem_infoc.patch
* mm-hugetlb-introduce-a-new-config-hugetlb_page_free_vmemmap.patch
* mm-hugetlb-gather-discrete-indexes-of-tail-page.patch
* mm-hugetlb-free-the-vmemmap-pages-associated-with-each-hugetlb-page.patch
* mm-hugetlb-free-the-vmemmap-pages-associated-with-each-hugetlb-page-fix.patch
* mm-hugetlb-defer-freeing-of-hugetlb-pages.patch
* mm-hugetlb-alloc-the-vmemmap-pages-associated-with-each-hugetlb-page.patch
* mm-hugetlb-alloc-the-vmemmap-pages-associated-with-each-hugetlb-page-fix.patch
* mm-hugetlb-alloc-the-vmemmap-pages-associated-with-each-hugetlb-page-fix-2.patch
* mm-hugetlb-add-a-kernel-parameter-hugetlb_free_vmemmap.patch
* mm-memory_hotplug-disable-memmap_on_memory-when-hugetlb_free_vmemmap-enabled.patch
* mm-memory_hotplug-disable-memmap_on_memory-when-hugetlb_free_vmemmap-enabled-fix.patch
* mm-hugetlb-introduce-nr_free_vmemmap_pages-in-the-struct-hstate.patch
* mm-debug_vm_pgtable-move-pmd-pud_huge_tests-out-of-config_transparent_hugepage.patch
* mm-debug_vm_pgtable-remove-redundant-pfn_pmd-pte-and-fix-one-comment-mistake.patch
* mm-huge_memoryc-remove-dedicated-macro-hpage_cache_index_mask.patch
* mm-huge_memoryc-use-page-deferred_list.patch
* mm-huge_memoryc-add-missing-read-only-thp-checking-in-transparent_hugepage_enabled.patch
* mm-huge_memoryc-add-missing-read-only-thp-checking-in-transparent_hugepage_enabled-v4.patch
* mm-huge_memoryc-remove-unnecessary-tlb_remove_page_size-for-huge-zero-pmd.patch
* mm-huge_memoryc-dont-discard-hugepage-if-other-processes-are-mapping-it.patch
* mm-hugetlb-change-parameters-of-arch_make_huge_pte.patch
* mm-pgtable-add-stubs-for-pmd-pub_set-clear_huge.patch
* mm-pgtable-add-stubs-for-pmd-pub_set-clear_huge-fix-2.patch
* arm64-define-only-pud-pmd_set-clear_huge-when-usefull.patch
* mm-vmalloc-enable-mapping-of-huge-pages-at-pte-level-in-vmap.patch
* mm-vmalloc-enable-mapping-of-huge-pages-at-pte-level-in-vmalloc.patch
* powerpc-8xx-add-support-for-huge-pages-on-vmap-and-vmalloc.patch
* khugepaged-selftests-remove-debug_cow.patch
* mm-hugetlb-fix-racy-resv_huge_pages-underflow-on-uffdio_copy.patch
* mm-hugetlb-fix-racy-resv_huge_pages-underflow-on-uffdio_copy-fix.patch
* mm-hugetlb-fix-racy-resv_huge_pages-underflow-on-uffdio_copy-fix-2.patch
* userfaultfd-selftests-use-user-mode-only.patch
* userfaultfd-selftests-remove-the-time-check-on-delayed-uffd.patch
* userfaultfd-selftests-dropping-verify-check-in-locking_thread.patch
* userfaultfd-selftests-only-dump-counts-if-mode-enabled.patch
* userfaultfd-selftests-unify-error-handling.patch
* mm-thp-simplify-copying-of-huge-zero-page-pmd-when-fork.patch
* mm-userfaultfd-fix-uffd-wp-special-cases-for-fork.patch
* mm-userfaultfd-fix-a-few-thp-pmd-missing-uffd-wp-bit.patch
* mm-userfaultfd-fail-uffd-wp-registeration-if-not-supported.patch
* mm-pagemap-export-uffd-wp-protection-information.patch
* userfaultfd-selftests-add-pagemap-uffd-wp-test.patch
* userfaultfd-shmem-combine-shmem_mcopy_atomicmfill_zeropage_pte.patch
* userfaultfd-shmem-support-minor-fault-registration-for-shmem.patch
* userfaultfd-shmem-support-uffdio_continue-for-shmem.patch
* userfaultfd-shmem-advertise-shmem-minor-fault-support.patch
* userfaultfd-shmem-modify-shmem_mfill_atomic_pte-to-use-install_pte.patch
* userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
* userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
* userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
* userfaultfd-selftests-reinitialize-test-context-in-each-test-fix.patch
* userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch
* userfaultfd-fix-uffdio_continue-ioctl-request-definition.patch
* mm-vmscanc-fix-potential-deadlock-in-reclaim_pages.patch
* include-trace-events-vmscanh-remove-mm_vmscan_inactive_list_is_low.patch
* mm-move-holes_in_zone-into-mm.patch
* docs-procrst-meminfo-briefly-describe-gaps-in-memory-accounting.patch
* fs-proc-kcore-drop-kcore_remap-and-kcore_other.patch
* fs-proc-kcore-pfn_is_ram-check-only-applies-to-kcore_ram.patch
* fs-proc-kcore-dont-read-offline-sections-logically-offline-pages-and-hwpoisoned-pages.patch
* mm-introduce-page_offline_beginendfreezethaw-to-synchronize-setting-pageoffline.patch
* virtio-mem-use-page_offline_startend-when-setting-pageoffline.patch
* fs-proc-kcore-use-page_offline_freezethaw.patch
* mm-zbud-reuse-unbuddied-as-buddied-in-zbud_pool.patch
* mm-zbud-dont-export-any-zbud-api.patch
* mm-compaction-use-device_attr_wo-macro.patch
* mm-compaction-remove-duplicate-list_emptysublist-check.patch
* mm-mempolicy-cleanup-nodemask-intersection-check-for-oom.patch
* mm-mempolicy-dont-handle-mpol_local-like-a-fake-mpol_preferred-policy.patch
* mm-mempolicy-dont-handle-mpol_local-like-a-fake-mpol_preferred-policy-v4.patch
* mm-mempolicy-dont-handle-mpol_local-like-a-fake-mpol_preferred-policy-v4-fix.patch
* mm-mempolicy-unify-the-parameter-sanity-check-for-mbind-and-set_mempolicy.patch
* mm-mempolicy-unify-the-parameter-sanity-check-for-mbind-and-set_mempolicy-v4.patch
* mm-mempolicy-dont-have-to-split-pmd-for-huge-zero-page.patch
* mm-mempolicy-use-unified-nodes-for-bind-interleave-prefer-policies.patch
* include-linux-mmzoneh-add-documentation-for-pfn_valid.patch
* memblock-update-initialization-of-reserved-pages.patch
* arm64-decouple-check-whether-pfn-is-in-linear-map-from-pfn_valid.patch
* arm64-drop-pfn_valid_within-and-simplify-pfn_valid.patch
* arm64-mm-drop-have_arch_pfn_valid.patch
* mm-migrate-fix-missing-update-page_private-to-hugetlb_page_subpool.patch
* mm-migrate-fix-missing-update-page_private-to-hugetlb_page_subpool-v2.patch
* mm-thp-relax-the-vm_denywrite-constraint-on-file-backed-thps.patch
* mm-memory-add-orig_pmd-to-struct-vm_fault.patch
* mm-memory-make-numa_migrate_prep-non-static.patch
* mm-thp-refactor-numa-fault-handling.patch
* mm-thp-refactor-numa-fault-handling-fix.patch
* mm-migrate-account-thp-numa-migration-counters-correctly.patch
* mm-migrate-dont-split-thp-for-misplaced-numa-page.patch
* mm-migrate-check-mapcount-for-thp-instead-of-refcount.patch
* mm-thp-skip-make-pmd-prot_none-if-thp-migration-is-not-supported.patch
* mm-thp-make-alloc_split_ptlocks-dependent-on-use_split_pte_ptlocks.patch
* mm-thp-make-arch_enable_split_pmd_ptlock-dependent-on-pgtable_levels-2.patch
* mm-rmap-make-try_to_unmap-void-function.patch
* mm-thp-remap_page-is-only-needed-on-anonymous-thp.patch
* mm-hwpoison_user_mappings-try_to_unmap-with-ttu_sync.patch
* mm-thp-fix-strncpy-warning.patch
* nommu-remove-__gfp_highmem-in-vmalloc-vzalloc.patch
* nommu-remove-__gfp_highmem-in-vmalloc-vzalloc-checkpatch-fixes.patch
* mm-nommu-unexport-do_munmap.patch
* mm-generalize-zone_.patch
* mm-make-variable-names-for-populate_vma_page_range-consistent.patch
* mm-madvise-introduce-madv_populate_readwrite-to-prefault-page-tables.patch
* mm-madvise-introduce-madv_populate_readwrite-to-prefault-page-tables-checkpatch-fixes.patch
* maintainers-add-tools-testing-selftests-vm-to-memory-management.patch
* selftests-vm-add-protection_keys_32-protection_keys_64-to-gitignore.patch
* selftests-vm-add-test-for-madv_populate_readwrite.patch
* mm-memory_hotplug-rate-limit-page-migration-warnings.patch
* memory-hotplugrst-complete-admin-guide-overhaul.patch
* mmmemory_hotplug-drop-unneeded-locking.patch
* mmmemory_hotplug-drop-unneeded-locking-fix.patch
* mm-zswapc-remove-unused-function-zswap_debugfs_exit.patch
* mm-zswapc-avoid-unnecessary-copy-in-at-map-time.patch
* mm-zswapc-fix-two-bugs-in-zswap_writeback_entry.patch
* mm-zram-amend-slab_reclaim_account-on-zspage_cachep.patch
* mm-highmem-remove-deprecated-kmap_atomic.patch
* zram-move-backing_dev-under-macro-config_zram_writeback.patch
* mm-fix-typos-and-grammar-error-in-comments.patch
* mm-fix-comments-mentioning-i_mutex.patch
* mm-define-default-value-for-first_user_address.patch
* mm-clear-spelling-mistakes.patch
* mm-vmscan-remove-kerneldoc-like-comment-from-isolate_lru_pages.patch
* mm-vmalloc-include-header-for-prototype-of-set_iounmap_nonlazy.patch
* mm-page_alloc-make-should_fail_alloc_page-a-static-function-should_fail_alloc_page-static.patch
* mm-mapping_dirty_helpers-remove-double-note-in-kerneldoc.patch
* mm-memcontrolc-fix-kerneldoc-comment-for-mem_cgroup_calculate_protection.patch
* mm-memory_hotplug-fix-kerneldoc-comment-for-__try_online_node.patch
* mm-memory_hotplug-fix-kerneldoc-comment-for-__remove_memory.patch
* mm-zbud-add-kerneldoc-fields-for-zbud_pool.patch
* mm-z3fold-add-kerneldoc-fields-for-z3fold_pool.patch
* mm-swap-make-swap_address_space-an-inline-function.patch
* mm-mmap_lock-remove-dead-code-for-config_tracing-configurations.patch
* mm-mmap_lock-remove-dead-code-for-config_tracing-configurations-fix.patch
* mm-page_alloc-move-prototype-for-find_suitable_fallback.patch
* mm-swap-make-node_data-an-inline-function-on-config_flatmem.patch
* mm-thp-define-default-pmd_pgtable.patch
* kfence-unconditionally-use-unbound-work-queue.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-avoid-mixing-integer-types-in-mem_rw.patch
* fs-proc-kcorec-add-mmap-interface.patch
* fs-proc-kcorec-add-mmap-interface-fix.patch
* procfs-allow-reading-fdinfo-with-ptrace_mode_read.patch
* procfs-dmabuf-add-inode-number-to-proc-fdinfo.patch
* sysctl-remove-redundant-assignment-to-first.patch
* proc-sysctl-make-protected_-world-readable.patch
* drm-include-only-needed-headers-in-ascii85h.patch
* kernelh-split-out-panic-and-oops-helpers.patch
* kernelh-split-out-panic-and-oops-helpers-fix.patch
* kernelh-split-out-panic-and-oops-helpers-fix-2.patch
* lib-decompress_bunzip2-remove-an-unneeded-semicolon.patch
* lib-string_helpers-switch-to-use-bit-macro.patch
* lib-string_helpers-move-escape_np-check-inside-else-branch-in-a-loop.patch
* lib-string_helpers-drop-indentation-level-in-string_escape_mem.patch
* lib-string_helpers-introduce-escape_na-for-escaping-non-ascii.patch
* lib-string_helpers-introduce-escape_nap-to-escape-non-ascii-and-non-printable.patch
* lib-string_helpers-allow-to-append-additional-characters-to-be-escaped.patch
* lib-test-string_helpers-print-flags-in-hexadecimal-format.patch
* lib-test-string_helpers-get-rid-of-trailing-comma-in-terminators.patch
* lib-test-string_helpers-add-test-cases-for-new-features.patch
* maintainers-add-myself-as-designated-reviewer-for-generic-string-library.patch
* seq_file-introduce-seq_escape_mem.patch
* seq_file-add-seq_escape_str-as-replica-of-string_escape_str.patch
* seq_file-convert-seq_escape-to-use-seq_escape_str.patch
* nfsd-avoid-non-flexible-api-in-seq_quote_mem.patch
* seq_file-drop-unused-_escape_mem_ascii.patch
* lib-math-rationalc-fix-divide-by-zero.patch
* lib-math-rational-add-kunit-test-cases.patch
* lib-math-rational-add-kunit-test-cases-fix.patch
* lib-math-rational-add-kunit-test-cases-fix-2.patch
* lib-decompressors-fix-spelling-mistakes.patch
* lib-mpi-fix-spelling-mistakes.patch
* lib-memscan-fixlet.patch
* lib-uninline-simple_strtoull.patch
* kernelh-split-out-kstrtox-and-simple_strtox-to-a-separate-header.patch
* kernelh-split-out-kstrtox-and-simple_strtox-to-a-separate-header-fix.patch
* lz4_decompress-declare-lz4_decompress_safe_withprefix64k-static.patch
* lib-decompress_unlz4c-correctly-handle-zero-padding-around-initrds.patch
* checkpatch-scripts-spdxcheckpy-now-requires-python3.patch
* checkpatch-improve-the-indented-label-test.patch
* init-print-out-unknown-kernel-parameters.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* kprobes-remove-duplicated-strong-free_insn_page-in-x86-and-s390.patch
* hfsplus-fix-out-of-bounds-warnings-in-__hfsplus_setxattr.patch
* x86-signal-dont-do-sas_ss_reset-until-we-are-certain-that-sigframe-wont-be-abandoned.patch
* exec-remove-checks-in-__register_bimfmt.patch
* exec-fix-dead-lock-in-de_thread-with-ptrace_attach.patch
* exec-fix-dead-lock-in-de_thread-with-ptrace_attach-v9.patch
* kcov-add-__no_sanitize_coverage-to-fix-noinstr-for-all-architectures.patch
* kcov-add-__no_sanitize_coverage-to-fix-noinstr-for-all-architectures-v2.patch
* kcov-add-__no_sanitize_coverage-to-fix-noinstr-for-all-architectures-v3.patch
* selftests-vm-pkeys-fix-alloc_random_pkey-to-make-it-really-really-random.patch
* selftests-vm-pkeys-handle-negative-sys_pkey_alloc-return-code.patch
* selftests-vm-pkeys-refill-shadow-register-after-implicit-kernel-write.patch
* selftests-vm-pkeys-exercise-x86-xsave-init-state.patch
* lib-decompressors-remove-set-but-not-used-variabled-level.patch
* lib-decompressors-remove-set-but-not-used-variabled-level-fix.patch
* ipc-sem-use-kvmalloc-for-sem_undo-allocation.patch
* ipc-use-kmalloc-for-msg_queue-and-shmid_kernel.patch
* ipc-semc-use-read_once-write_once-for-use_global_lock.patch
* ipc-utilc-use-binary-search-for-max_idx.patch
* ipc-utilc-use-binary-search-for-max_idx-fix.patch
* linux-next-pre.patch
  linux-next.patch
  linux-next-post.patch
  linux-next-rejects.patch
* lib-test-fix-spelling-mistakes.patch
* lib-fix-spelling-mistakes.patch
* lib-fix-spelling-mistakes-in-header-files.patch
* hexagon-handle-softirqentry_text-in-linker-script.patch
* hexagon-use-common-discards-macro.patch
* hexagon-select-arch_want_ld_orphan_warn.patch
* mm-slub-use-stackdepot-to-save-stack-trace-in-objects.patch
* mm-slub-use-stackdepot-to-save-stack-trace-in-objects-fix.patch
* mm-slub-use-stackdepot-to-save-stack-trace-in-objects-fix-2.patch
* mmap-make-mlock_future_check-global.patch
* riscv-kconfig-make-direct-map-manipulation-options-depend-on-mmu.patch
* set_memory-allow-querying-whether-set_direct_map_-is-actually-enabled.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix.patch
* pm-hibernate-disable-when-there-are-active-secretmem-users.patch
* arch-mm-wire-up-memfd_secret-system-call-where-relevant.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2.patch
* mm-fix-spelling-mistakes-in-header-files.patch
* mm-add-setup_initial_init_mm-helper.patch
* arc-convert-to-setup_initial_init_mm.patch
* arm-convert-to-setup_initial_init_mm.patch
* arm64-convert-to-setup_initial_init_mm.patch
* csky-convert-to-setup_initial_init_mm.patch
* h8300-convert-to-setup_initial_init_mm.patch
* m68k-convert-to-setup_initial_init_mm.patch
* nds32-convert-to-setup_initial_init_mm.patch
* nios2-convert-to-setup_initial_init_mm.patch
* openrisc-convert-to-setup_initial_init_mm.patch
* powerpc-convert-to-setup_initial_init_mm.patch
* riscv-convert-to-setup_initial_init_mm.patch
* s390-convert-to-setup_initial_init_mm.patch
* sh-convert-to-setup_initial_init_mm.patch
* x86-convert-to-setup_initial_init_mm.patch
* buildid-only-consider-gnu-notes-for-build-id-parsing.patch
* buildid-add-api-to-parse-build-id-out-of-buffer.patch
* buildid-stash-away-kernels-build-id-on-init.patch
* buildid-stash-away-kernels-build-id-on-init-fix.patch
* dump_stack-add-vmlinux-build-id-to-stack-traces.patch
* module-add-printk-formats-to-add-module-build-id-to-stacktraces.patch
* module-add-printk-formats-to-add-module-build-id-to-stacktraces-fix.patch
* module-add-printk-formats-to-add-module-build-id-to-stacktraces-fix-2.patch
* module-add-printk-formats-to-add-module-build-id-to-stacktraces-fix-fix.patch
* module-add-printk-formats-to-add-module-build-id-to-stacktraces-fix-fix-fix.patch
* arm64-stacktrace-use-%psb-for-backtrace-printing.patch
* x86-dumpstack-use-%psb-%pbb-for-backtrace-printing.patch
* scripts-decode_stacktracesh-support-debuginfod.patch
* scripts-decode_stacktracesh-silence-stderr-messages-from-addr2line-nm.patch
* scripts-decode_stacktracesh-indicate-auto-can-be-used-for-base-path.patch
* buildid-mark-some-arguments-const.patch
* buildid-fix-kernel-doc-notation.patch
* kdump-use-vmlinux_build_id-to-simplify.patch
* mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t.patch
* mm-rename-p4d_page_vaddr-to-p4d_pgtable-and-make-it-return-pud_t.patch
* afs-fix-tracepoint-string-placement-with-built-in-afs.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
