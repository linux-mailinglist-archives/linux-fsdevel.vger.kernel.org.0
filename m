Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB08350E16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 06:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhDAE16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 00:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhDAE1s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 00:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2A6A6101A;
        Thu,  1 Apr 2021 04:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617251268;
        bh=t9OLMn8dGRP6PeLqbcMRnWL1zIwDq1Hy+cyjHNd62/Y=;
        h=Date:From:To:Subject:From;
        b=VWsZosLhnfFi+e5yE0C0bwNQCkcvvS5GahIAWYVD8UoNFPycr9mZQ9UrCOXN4kVFG
         eRnWoeMgzxU6Y594lUFGjUcE3tB7HsFp25jMXG1BwMLTSZzkHc1qlSWwEqJv71qxIi
         +69Xye1H2XH7MjGhwLRRu2NMDjsU9geU2kXNBF3I=
Date:   Wed, 31 Mar 2021 21:27:47 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-03-31-21-27 uploaded
Message-ID: <20210401042747.8lZFGjEre%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-03-31-21-27 has been uploaded to

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



This mmotm tree contains the following patches against 5.12-rc5:
(patches marked "*" will be included in linux-next)

  origin.patch
* maintainers-update-cznics-turris-information.patch
* treewide-change-my-e-mail-address-fix-my-name.patch
* mailmap-update-email-address-for-jordan-crouse.patch
* kasan-fix-hwasan-build-for-gcc.patch
* kasan-remove-redundant-config-option.patch
* kasan-remove-redundant-config-option-fix.patch
* mm-gup-check-page-posion-status-for-coredump.patch
* mm-gup-check-page-posion-status-for-coredump-fix.patch
* mm-gup-check-page-posion-status-for-coredump-v4.patch
* nds32-flush_dcache_page-use-page_mapping_file-to-avoid-races-with-swapoff.patch
* fs-direct-io-fix-missing-sdio-boundary.patch
* kasan-fix-conflict-with-page-poisoning.patch
* kfence-x86-fix-preemptible-warning-on-kpti-enabled-systems.patch
* lib-fix-kconfig-dependency-on-arch_want_frame_pointers.patch
* ocfs2-fix-deadlock-between-setattr-and-dio_end_io_write.patch
* ia64-fix-user_stack_pointer-for-ptrace.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* module-remove-duplicate-include-in-arch-ia64-kernel-heads.patch
* ia64-kernel-few-typos-fixed-in-the-file-fsyss.patch
* ia64-include-asm-minor-typo-fixes-in-the-file-pgtableh.patch
* ia64-ensure-proper-numa-distance-and-possible-map-initialization.patch
* ia64-drop-unused-ia64_fw_emu-ifdef.patch
* ia64-simplify-code-flow-around-swiotlb-init.patch
* ia64-tools-remove-inclusion-of-ia64-specific-version-of-errnoh-header.patch
* ia64-tools-remove-duplicate-definition-of-ia64_mf-on-ia64.patch
* ia64-trivial-spelling-fixes.patch
* ia64-fix-efi_debug-build.patch
* ia64-mca-always-make-ia64_mca_debug-an-expression.patch
* sparse-can-do-constant-folding-of-__builtin_bswap.patch
* scripts-spellingtxt-add-entries-for-recent-discoveries.patch
* sh-remove-duplicate-include-in-tlbh.patch
* ocfs2-replace-define_simple_attribute-with-define_debugfs_attribute.patch
* ocfs2-map-flags-directly-in-flags_to_o2dlm.patch
* ocfs2-fix-a-typo.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* watchdog-rename-__touch_watchdog-to-a-better-descriptive-name.patch
* watchdog-explicitly-update-timestamp-when-reporting-softlockup.patch
* watchdog-softlockup-report-the-overall-time-of-softlockups.patch
* watchdog-softlockup-remove-logic-that-tried-to-prevent-repeated-reports.patch
* watchdog-fix-barriers-when-printing-backtraces-from-all-cpus.patch
* watchdog-fix-barriers-when-printing-backtraces-from-all-cpus-fix.patch
* watchdog-cleanup-handling-of-false-positives.patch
  mm.patch
* mm-slab_common-provide-slab_merge-option-for-is_enabledconfig_slab_merge_default-builds.patch
* mm-slub-enable-slub_debug-static-key-when-creating-cache-with-explicit-debug-flags.patch
* kunit-add-a-kunit-test-for-slub-debugging-functionality.patch
* slub-remove-resiliency_test-function.patch
* mm-slubc-trivial-typo-fixes.patch
* mm-kmemleak-fix-a-typo.patch
* mm-page_owner-record-the-timestamp-of-all-pages-during-free.patch
* mm-page_owner-remove-unused-parameter-in-__set_page_owner_handle.patch
* mm-provide-filemap_range_needs_writeback-helper.patch
* mm-use-filemap_range_needs_writeback-for-o_direct-reads.patch
* iomap-use-filemap_range_needs_writeback-for-o_direct-reads.patch
* mm-filemap-use-filemap_read_page-in-filemap_fault.patch
* mm-filemap-drop-check-for-truncated-page-after-i-o.patch
* mm-page-writeback-simplify-memcg-handling-in-test_clear_page_writeback.patch
* mm-introduce-and-use-mapping_empty.patch
* mm-stop-accounting-shadow-entries.patch
* dax-account-dax-entries-as-nrpages.patch
* mm-remove-nrexceptional-from-inode.patch
* mm-move-page_mapping_file-to-pagemaph.patch
* mm-msync-exit-early-when-the-flags-is-an-ms_async-and-start-vm_start.patch
* mm-gup-add-compound-page-list-iterator.patch
* mm-gup-decrement-head-page-once-for-group-of-subpages.patch
* mm-gup-add-a-range-variant-of-unpin_user_pages_dirty_lock.patch
* rdma-umem-batch-page-unpin-in-__ib_umem_release.patch
* mm-gup-remove-foll_split.patch
* mm-memremap-fixes-improper-spdx-comment-style.patch
* mm-memcontrol-fix-kernel-stack-account.patch
* memcg-cleanup-root-memcg-checks.patch
* memcg-enable-memcg-oom-kill-for-__gfp_nofail.patch
* mm-memcontrol-fix-cpuhotplug-statistics-flushing.patch
* mm-memcontrol-kill-mem_cgroup_nodeinfo.patch
* mm-memcontrol-privatize-memcg_page_state-query-functions.patch
* cgroup-rstat-support-cgroup1.patch
* cgroup-rstat-punt-root-level-optimization-to-individual-controllers.patch
* mm-memcontrol-switch-to-rstat.patch
* mm-memcontrol-switch-to-rstat-fix.patch
* mm-memcontrol-switch-to-rstat-fix-2.patch
* mm-memcontrol-consolidate-lruvec-stat-flushing.patch
* kselftests-cgroup-update-kmem-test-for-new-vmstat-implementation.patch
* memcg-charge-before-adding-to-swapcache-on-swapin.patch
* memcg-charge-before-adding-to-swapcache-on-swapin-fix.patch
* mm-memcontrol-slab-fix-obtain-a-reference-to-a-freeing-memcg.patch
* mm-memcontrol-introduce-obj_cgroup_uncharge_pages.patch
* mm-memcontrol-directly-access-page-memcg_data-in-mm-page_allocc.patch
* mm-memcontrol-change-ug-dummy_page-only-if-memcg-changed.patch
* mm-memcontrol-use-obj_cgroup-apis-to-charge-kmem-pages.patch
* mm-memcontrol-inline-__memcg_kmem_uncharge-into-obj_cgroup_uncharge_pages.patch
* mm-memcontrol-move-pagememcgkmem-to-the-scope-of-config_memcg_kmem.patch
* linux-memcontrolh-remove-duplicate-struct-declaration.patch
* mm-delete-bool-migrated.patch
* mm-interval_tree-add-comments-to-improve-code-reading.patch
* x86-vmemmap-drop-handling-of-4k-unaligned-vmemmap-range.patch
* x86-vmemmap-drop-handling-of-1gb-vmemmap-ranges.patch
* x86-vmemmap-handle-unpopulated-sub-pmd-ranges.patch
* x86-vmemmap-optimize-for-consecutive-sections-in-partial-populated-pmds.patch
* mm-tracing-improve-rss_stat-tracepoint-message.patch
* mm-add-remap_pfn_range_notrack.patch
* mm-add-a-io_mapping_map_user-helper.patch
* i915-use-io_mapping_map_user.patch
* i915-fix-remap_io_sg-to-verify-the-pgprot.patch
* mm-extend-mremap_dontunmap-to-non-anonymous-mappings.patch
* revert-mremap-dont-allow-mremap_dontunmap-on-special_mappings-and-aio.patch
* selftests-add-a-mremap_dontunmap-selftest-for-shmem.patch
* mm-dmapool-switch-from-strlcpy-to-strscpy.patch
* mm-sparse-add-the-missing-sparse_buffer_fini-in-error-branch.patch
* samples-vfio-mdev-mdpy-use-remap_vmalloc_range.patch
* mm-unexport-remap_vmalloc_range_partial.patch
* mm-vmalloc-use-rb_tree-instead-of-list-for-vread-lookups.patch
* arm-mm-add-missing-pud_page-define-to-2-level-page-tables.patch
* mm-vmalloc-fix-huge_vmap-regression-by-enabling-huge-pages-in-vmalloc_to_page.patch
* mm-vmalloc-fix-huge_vmap-regression-by-enabling-huge-pages-in-vmalloc_to_page-fix.patch
* mm-apply_to_pte_range-warn-and-fail-if-a-large-pte-is-encountered.patch
* mm-vmalloc-rename-vmap__range-vmap_pages__range.patch
* mm-ioremap-rename-ioremap__range-to-vmap__range.patch
* mm-huge_vmap-arch-support-cleanup.patch
* powerpc-inline-huge-vmap-supported-functions.patch
* arm64-inline-huge-vmap-supported-functions.patch
* x86-inline-huge-vmap-supported-functions.patch
* mm-vmalloc-provide-fallback-arch-huge-vmap-support-functions.patch
* mm-move-vmap_range-from-mm-ioremapc-to-mm-vmallocc.patch
* mm-vmalloc-add-vmap_range_noflush-variant.patch
* mm-vmalloc-hugepage-vmalloc-mappings.patch
* mm-vmalloc-hugepage-vmalloc-mappings-fix.patch
* powerpc-64s-radix-enable-huge-vmalloc-mappings.patch
* mm-vmalloc-remove-map_kernel_range.patch
* kernel-dma-remove-unnecessary-unmap_kernel_range.patch
* powerpc-xive-remove-unnecessary-unmap_kernel_range.patch
* mm-vmalloc-remove-unmap_kernel_range.patch
* mm-vmalloc-improve-allocation-failure-error-messages.patch
* mm-vmalloc-improve-allocation-failure-error-messages-fix.patch
* mm-vmalloc-prevent-use-after-free-in-_vm_unmap_aliases.patch
* mm-doc-fix-fault_flag_allow_retry_first-kerneldoc.patch
* mm-doc-fix-page_maybe_dma_pinned-kerneldoc.patch
* mm-doc-turn-fault-flags-into-an-enum.patch
* mm-doc-add-mmh-and-mm_typesh-to-the-mm-api-document.patch
* maintainers-assign-pagewalkh-to-memory-management.patch
* pagewalk-prefix-struct-kernel-doc-descriptions.patch
* mm-kasan-switch-from-strlcpy-to-strscpy.patch
* kasan-initialize-shadow-to-tag_invalid-for-sw_tags.patch
* mm-kasan-dont-poison-boot-memory-with-tag-based-modes.patch
* arm64-kasan-allow-to-init-memory-when-setting-tags.patch
* kasan-init-memory-in-kasan_unpoison-for-hw_tags.patch
* kasan-mm-integrate-page_alloc-init-with-hw_tags.patch
* kasan-mm-integrate-page_alloc-init-with-hw_tags-fix.patch
* kasan-mm-integrate-slab-init_on_alloc-with-hw_tags.patch
* kasan-mm-integrate-slab-init_on_free-with-hw_tags.patch
* kasan-docs-clean-up-sections.patch
* kasan-docs-update-overview-section.patch
* kasan-docs-update-usage-section.patch
* kasan-docs-update-error-reports-section.patch
* kasan-docs-update-boot-parameters-section.patch
* kasan-docs-update-generic-implementation-details-section.patch
* kasan-docs-update-sw_tags-implementation-details-section.patch
* kasan-docs-update-hw_tags-implementation-details-section.patch
* kasan-docs-update-shadow-memory-section.patch
* kasan-docs-update-ignoring-accesses-section.patch
* kasan-docs-update-tests-section.patch
* task_work-kasan-record-task_work_add-call-stack.patch
* kasan-detect-false-positives-in-tests.patch
* mm-move-mem_init_print_info-into-mm_init.patch
* mm-page_alloc-drop-pr_info_ratelimited-in-alloc_contig_range.patch
* mm-remove-lru_add_drain_all-in-alloc_contig_range.patch
* mm-correctly-determine-last_cpupid_width.patch
* mm-clean-up-include-linux-page-flags-layouth.patch
* mm-page_alloc-rename-alloc_mask-to-alloc_gfp.patch
* mm-page_alloc-rename-gfp_mask-to-gfp.patch
* mm-page_alloc-combine-__alloc_pages-and-__alloc_pages_nodemask.patch
* mm-mempolicy-rename-alloc_pages_current-to-alloc_pages.patch
* mm-mempolicy-rewrite-alloc_pages-documentation.patch
* mm-mempolicy-rewrite-alloc_pages_vma-documentation.patch
* mm-mempolicy-fix-mpol_misplaced-kernel-doc.patch
* mm-page_alloc-dump-migrate-failed-pages.patch
* mm-remove-default-discontigmem_manual.patch
* mm-page_alloc-avoid-page_to_pfn-in-move_freepages.patch
* mm-page_alloc-duplicate-include-linux-vmalloch.patch
* mm-page_alloc-rename-alloced-to-allocated.patch
* mm-page_alloc-add-a-bulk-page-allocator.patch
* mm-page_alloc-add-a-bulk-page-allocator-fix.patch
* mm-page_alloc-add-a-bulk-page-allocator-fix-fix.patch
* mm-page_alloc-add-an-array-based-interface-to-the-bulk-page-allocator.patch
* mm-page_alloc-add-an-array-based-interface-to-the-bulk-page-allocator-fix.patch
* mm-page_alloc-optimize-code-layout-for-__alloc_pages_bulk.patch
* mm-page_alloc-inline-__rmqueue_pcplist.patch
* sunrpc-set-rq_page_end-differently.patch
* sunrpc-refresh-rq_pages-using-a-bulk-page-allocator.patch
* net-page_pool-refactor-dma_map-into-own-function-page_pool_dma_map.patch
* net-page_pool-use-alloc_pages_bulk-in-refill-code-path.patch
* mm-page_alloc-ignore-init_on_free=1-for-debug_pagealloc=1.patch
* hugetlb-pass-vma-into-huge_pte_alloc-and-huge_pmd_share.patch
* hugetlb-pass-vma-into-huge_pte_alloc-and-huge_pmd_share-fix.patch
* hugetlb-userfaultfd-forbid-huge-pmd-sharing-when-uffd-enabled.patch
* hugetlb-userfaultfd-forbid-huge-pmd-sharing-when-uffd-enabled-fix.patch
* mm-hugetlb-move-flush_hugetlb_tlb_range-into-hugetlbh.patch
* hugetlb-userfaultfd-unshare-all-pmds-for-hugetlbfs-when-register-wp.patch
* mm-hugetlb-remove-redundant-reservation-check-condition-in-alloc_huge_page.patch
* mm-generalize-hugetlb_page_size_variable.patch
* mm-hugetlb-use-some-helper-functions-to-cleanup-code.patch
* mm-hugetlb-optimize-the-surplus-state-transfer-code-in-move_hugetlb_state.patch
* hugetlb_cgroup-remove-unnecessary-vm_bug_on_page-in-hugetlb_cgroup_migrate.patch
* mm-hugetlb-simplify-the-code-when-alloc_huge_page-failed-in-hugetlb_no_page.patch
* mm-hugetlb-avoid-calculating-fault_mutex_hash-in-truncate_op-case.patch
* khugepaged-remove-unneeded-return-value-of-khugepaged_collapse_pte_mapped_thps.patch
* khugepaged-reuse-the-smp_wmb-inside-__setpageuptodate.patch
* khugepaged-use-helper-khugepaged_test_exit-in-__khugepaged_enter.patch
* khugepaged-fix-wrong-result-value-for-trace_mm_collapse_huge_page_isolate.patch
* mm-huge_memoryc-remove-unnecessary-local-variable-ret2.patch
* mmpage_alloc-bail-out-earlier-on-enomem-in-alloc_contig_migrate_range.patch
* mmcompaction-let-isolate_migratepages_rangeblock-return-error-codes.patch
* mmcompaction-let-isolate_migratepages_rangeblock-return-error-codes-fix.patch
* mm-make-alloc_contig_range-handle-free-hugetlb-pages.patch
* mm-make-alloc_contig_range-handle-in-use-hugetlb-pages.patch
* mmpage_alloc-drop-unnecessary-checks-from-pfn_range_valid_contig.patch
* mm-huge_memoryc-rework-the-function-vma_adjust_trans_huge.patch
* mm-huge_memoryc-make-get_huge_zero_page-return-bool.patch
* mm-huge_memoryc-rework-the-function-do_huge_pmd_numa_page-slightly.patch
* mm-huge_memoryc-remove-redundant-pagecompound-check.patch
* mm-huge_memoryc-remove-unused-macro-transparent_hugepage_debug_cow_flag.patch
* mm-huge_memoryc-use-helper-function-migration_entry_to_page.patch
* khugepaged-raplace-barrier-with-read_once-for-a-selective-variable.patch
* khugepaged-use-helper-function-range_in_vma-in-collapse_pte_mapped_thp.patch
* khugepaged-remove-unnecessary-out-label-in-collapse_huge_page.patch
* khugepaged-remove-meaningless-pte_present-check-in-khugepaged_scan_pmd.patch
* mm-cma-change-cma-mutex-to-irq-safe-spinlock.patch
* hugetlb-no-need-to-drop-hugetlb_lock-to-call-cma_release.patch
* hugetlb-add-per-hstate-mutex-to-synchronize-user-adjustments.patch
* hugetlb-create-remove_hugetlb_page-to-separate-functionality.patch
* hugetlb-call-update_and_free_page-without-hugetlb_lock.patch
* hugetlb-change-free_pool_huge_page-to-remove_pool_huge_page.patch
* hugetlb-make-free_huge_page-irq-safe.patch
* hugetlb-add-lockdep_assert_held-calls-for-hugetlb_lock.patch
* userfaultfd-add-minor-fault-registration-mode.patch
* userfaultfd-add-minor-fault-registration-mode-fix.patch
* userfaultfd-disable-huge-pmd-sharing-for-minor-registered-vmas.patch
* userfaultfd-hugetlbfs-only-compile-uffd-helpers-if-config-enabled.patch
* userfaultfd-add-uffdio_continue-ioctl.patch
* userfaultfd-update-documentation-to-describe-minor-fault-handling.patch
* userfaultfd-selftests-add-test-exercising-minor-fault-handling.patch
* userfaultfd-support-minor-fault-handling-for-shmem.patch
* userfaultfd-support-minor-fault-handling-for-shmem-fix.patch
* userfaultfd-support-minor-fault-handling-for-shmem-fix-2.patch
* userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
* userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
* userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
* userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch
* userfaultfd-selftests-use-user-mode-only.patch
* userfaultfd-selftests-remove-the-time-check-on-delayed-uffd.patch
* userfaultfd-selftests-dropping-verify-check-in-locking_thread.patch
* userfaultfd-selftests-only-dump-counts-if-mode-enabled.patch
* userfaultfd-selftests-unify-error-handling.patch
* mm-vmscan-move-reclaim-bits-to-uapi-header.patch
* mm-vmscan-replace-implicit-reclaim_zone-checks-with-explicit-checks.patch
* mm-vmscan-use-nid-from-shrink_control-for-tracepoint.patch
* mm-vmscan-consolidate-shrinker_maps-handling-code.patch
* mm-vmscan-use-shrinker_rwsem-to-protect-shrinker_maps-allocation.patch
* mm-vmscan-remove-memcg_shrinker_map_size.patch
* mm-vmscan-use-kvfree_rcu-instead-of-call_rcu.patch
* mm-memcontrol-rename-shrinker_map-to-shrinker_info.patch
* mm-vmscan-add-shrinker_info_protected-helper.patch
* mm-vmscan-add-shrinker_info_protected-helper-fix.patch
* mm-vmscan-use-a-new-flag-to-indicate-shrinker-is-registered.patch
* mm-vmscan-add-per-memcg-shrinker-nr_deferred.patch
* mm-vmscan-use-per-memcg-nr_deferred-of-shrinker.patch
* mm-vmscan-dont-need-allocate-shrinker-nr_deferred-for-memcg-aware-shrinkers.patch
* mm-memcontrol-reparent-nr_deferred-when-memcg-offline.patch
* mm-vmscan-shrink-deferred-objects-proportional-to-priority.patch
* mm-compaction-remove-unused-variable-sysctl_compact_memory.patch
* mm-compaction-update-the-compact-events-properly.patch
* mm-disable-lru-pagevec-during-the-migration-temporarily.patch
* mm-replace-migrate_-with-lru_cache_.patch
* mm-fs-invalidate-bh-lru-during-page-migration.patch
* mm-migratec-make-putback_movable_page-static.patch
* mm-migratec-remove-unnecessary-rc-=-migratepage_success-check-in-else-case.patch
* mm-migratec-fix-potential-indeterminate-pte-entry-in-migrate_vma_insert_page.patch
* mm-migratec-use-helper-migrate_vma_collect_skip-in-migrate_vma_collect_hole.patch
* revert-mm-migrate-skip-shared-exec-thp-for-numa-balancing.patch
* mm-vmstat-add-cma-statistics.patch
* mm-cma-use-pr_err_ratelimited-for-cma-warning.patch
* mm-cma-add-trace-events-for-cma-alloc-perf-testing.patch
* mm-cma-add-trace-events-for-cma-alloc-perf-testing-fix.patch
* mm-cma-support-sysfs.patch
* mm-cma-add-the-cma-instance-name-to-cma-trace-events.patch
* mm-use-proper-type-for-cma_.patch
* ksm-remove-redundant-vm_bug_on_page-on-stable_tree_search.patch
* ksm-use-get_ksm_page_nolock-to-get-ksm-page-in-remove_rmap_item_from_tree.patch
* ksm-remove-dedicated-macro-ksm_flag_mask.patch
* ksm-fix-potential-missing-rmap_item-for-stable_node.patch
* mm-ksm-remove-unused-parameter-from-remove_trailing_rmap_items.patch
* mm-restore-node-stat-checking-in-proc-sys-vm-stat_refresh.patch
* mm-no-more-einval-from-proc-sys-vm-stat_refresh.patch
* mm-proc-sys-vm-stat_refresh-skip-checking-known-negative-stats.patch
* mm-proc-sys-vm-stat_refresh-stop-checking-monotonic-numa-stats.patch
* x86-mm-tracking-linear-mapping-split-events.patch
* mm-mmap-dont-unlock-vmas-in-remap_file_pages.patch
* mm-reduce-mem_dump_obj-object-size.patch
* mm-typo-fix-in-the-file-utilc.patch
* mm-gup-dont-pin-migrated-cma-pages-in-movable-zone.patch
* mm-gup-check-every-subpage-of-a-compound-page-during-isolation.patch
* mm-gup-return-an-error-on-migration-failure.patch
* mm-gup-check-for-isolation-errors.patch
* mm-cma-rename-pf_memalloc_nocma-to-pf_memalloc_pin.patch
* mm-cma-rename-pf_memalloc_nocma-to-pf_memalloc_pin-fix.patch
* mm-apply-per-task-gfp-constraints-in-fast-path.patch
* mm-honor-pf_memalloc_pin-for-all-movable-pages.patch
* mm-gup-do-not-migrate-zero-page.patch
* mm-gup-migrate-pinned-pages-out-of-movable-zone.patch
* memory-hotplugrst-add-a-note-about-zone_movable-and-page-pinning.patch
* mm-gup-change-index-type-to-long-as-it-counts-pages.patch
* mm-gup-longterm-pin-migration-cleanup.patch
* selftests-vm-gup_test-fix-test-flag.patch
* selftests-vm-gup_test-test-faulting-in-kernel-and-verify-pinnable-pages.patch
* mmmemory_hotplug-allocate-memmap-from-the-added-memory-range.patch
* mmmemory_hotplug-allocate-memmap-from-the-added-memory-range-fix.patch
* acpimemhotplug-enable-mhp_memmap_on_memory-when-supported.patch
* mmmemory_hotplug-add-kernel-boot-option-to-enable-memmap_on_memory.patch
* x86-kconfig-introduce-arch_mhp_memmap_on_memory_enable.patch
* arm64-kconfig-introduce-arch_mhp_memmap_on_memory_enable.patch
* mm-zswap-switch-from-strlcpy-to-strscpy.patch
* mm-zsmalloc-use-bug_on-instead-of-if-condition-followed-by-bug.patch
* iov_iter-lift-memzero_page-to-highmemh.patch
* btrfs-use-memzero_page-instead-of-open-coded-kmap-pattern.patch
* mm-highmemc-fix-coding-style-issue.patch
* mm-highmem-remove-deprecated-kmap_atomic.patch
* mm-mempool-minor-coding-style-tweaks.patch
* mm-swapfile-minor-coding-style-tweaks.patch
* mm-sparse-minor-coding-style-tweaks.patch
* mm-vmscan-minor-coding-style-tweaks.patch
* mm-compaction-minor-coding-style-tweaks.patch
* mm-oom_kill-minor-coding-style-tweaks.patch
* mm-shmem-minor-coding-style-tweaks.patch
* mm-page_alloc-minor-coding-style-tweaks.patch
* mm-filemap-minor-coding-style-tweaks.patch
* mm-mlock-minor-coding-style-tweaks.patch
* mm-frontswap-minor-coding-style-tweaks.patch
* mm-vmalloc-minor-coding-style-tweaks.patch
* mm-memory_hotplug-minor-coding-style-tweaks.patch
* mm-mempolicy-minor-coding-style-tweaks.patch
* mm-process_vm_access-remove-duplicate-include.patch
* kfence-zero-guard-page-after-out-of-bounds-access.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-fix-incorrect-pde_is_permanent-check.patch
* proc-save-loc-in-__xlate_proc_name.patch
* proc-mandate-proc_lseek-in-struct-proc_ops.patch
* proc-delete-redundant-subset=pid-check.patch
* proc-test-subset=pid.patch
* procfs-allow-reading-fdinfo-with-ptrace_mode_read.patch
* procfs-dmabuf-add-inode-number-to-proc-fdinfo.patch
* proc-sysctl-fix-function-name-error-in-comments.patch
* proc-sysctl-make-protected_-world-readable.patch
* include-remove-pagemaph-from-blkdevh.patch
* kernelh-drop-inclusion-in-bitmaph.patch
* kernel-asyncc-fix-pr_debug-statement.patch
* kernel-credc-make-init_groups-static.patch
* tools-disable-wno-type-limits.patch
* tools-bitmap-sync-function-declarations-with-the-kernel.patch
* tools-sync-bitmap_last_word_mask-macro-with-the-kernel.patch
* arch-rearrange-headers-inclusion-order-in-asm-bitops-for-m68k-and-sh.patch
* lib-extend-the-scope-of-small_const_nbits-macro.patch
* tools-sync-small_const_nbits-macro-with-the-kernel.patch
* lib-inline-_find_next_bit-wrappers.patch
* tools-sync-find_next_bit-implementation.patch
* lib-add-fast-path-for-find_next__bit.patch
* lib-add-fast-path-for-find_first__bit-and-find_last_bit.patch
* tools-sync-lib-find_bit-implementation.patch
* maintainers-add-entry-for-the-bitmap-api.patch
* lib-fix-a-typo-in-the-file-bchc.patch
* lib-fix-inconsistent-indenting-in-process_bit1.patch
* lib-fix-typo-in-function-description.patch
* lib-genallocc-fix-a-typo.patch
* lib-crc8-pointer-to-data-block-should-be-const.patch
* lib-stackdepot-turn-depot_lock-spinlock-to-raw_spinlock.patch
* compat-remove-unneeded-declaration-from-compat_syscall_definex.patch
* checkpatch-warn-when-missing-newline-in-return-sysfs_emit-formats.patch
* init-add-support-for-zstd-compressed-modules.patch
* hfsplus-fix-out-of-bounds-warnings-in-__hfsplus_setxattr.patch
* do_wait-make-pidtype_pid-case-o1-instead-of-on.patch
* simplify-copy_mm.patch
* kernel-fork-fix-typo-issue.patch
* kernel-crash_core-add-crashkernel=auto-for-vmcore-creation.patch
* kexec-add-kexec-reboot-string.patch
* kernel-kexec_file-fix-error-return-code-of-kexec_calculate_store_digests.patch
* kexec-dump-kmessage-before-machine_kexec.patch
* gcov-clang-drop-support-for-clang-10-and-older.patch
* gcov-combine-common-code.patch
* gcov-simplify-buffer-allocation.patch
* gcov-use-kvmalloc.patch
* smp-kernel-panicc-silence-warnings.patch
* aio-simplify-read_events.patch
* gdb-lx-symbols-store-the-abspath.patch
* scripts-gdb-document-lx_current-is-only-supported-by-x86.patch
* scripts-gdb-add-lx_current-support-for-arm64.patch
* kernel-resource-make-walk_system_ram_res-find-all-busy-ioresource_system_ram-resources.patch
* kernel-resource-make-walk_mem_res-find-all-busy-ioresource_mem-resources.patch
* kernel-resource-remove-first_lvl-siblings_only-logic.patch
* selftests-remove-duplicate-include.patch
* kernel-asyncc-stop-guarding-pr_debug-statements.patch
* kernel-asyncc-remove-async_unregister_domain.patch
* init-initramfsc-do-unpacking-asynchronously.patch
* modules-add-config_modprobe_path.patch
* ipc-semc-mundane-typo-fixes.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
* drivers-char-remove-dev-kmem-for-good.patch
* mm-remove-xlate_dev_kmem_ptr.patch
* mm-vmalloc-remove-vwrite.patch
* arm-print-alloc-free-paths-for-address-in-registers.patch
* scripts-spellingtxt-add-overlfow.patch
* scripts-spellingtxt-add-diabled-typo.patch
* scripts-spellingtxt-add-overflw.patch
* mm-slab-fix-spelling-mistake-disired-desired.patch
* mm-few-spelling-fixes.patch
* umh-fix-some-spelling-mistakes.patch
* kernel-user_namespace-fix-typo-issue.patch
* kernel-fix-a-typo-in-the-file-upc.patch
* kernel-sys-fix-typo-issue.patch
* fs-fat-fix-spelling-typo-of-values.patch
* ipc-semc-couple-of-spelling-fixes.patch
* treewide-remove-editor-modelines-and-cruft.patch
* mm-fix-typos-in-comments.patch
* mmap-make-mlock_future_check-global.patch
* riscv-kconfig-make-direct-map-manipulation-options-depend-on-mmu.patch
* set_memory-allow-set_direct_map__noflush-for-multiple-pages.patch
* set_memory-allow-querying-whether-set_direct_map_-is-actually-enabled.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix.patch
* pm-hibernate-disable-when-there-are-active-secretmem-users.patch
* arch-mm-wire-up-memfd_secret-system-call-where-relevant.patch
* arch-mm-wire-up-memfd_secret-system-call-where-relevant-fix.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2-fix.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
