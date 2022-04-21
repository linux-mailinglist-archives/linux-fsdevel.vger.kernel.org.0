Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACB150941B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 02:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383386AbiDUAPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 20:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348283AbiDUAPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 20:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FEC193F3;
        Wed, 20 Apr 2022 17:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F7761B76;
        Thu, 21 Apr 2022 00:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4E0C385A0;
        Thu, 21 Apr 2022 00:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650499955;
        bh=7zmGDM2CW4JGzPCl7aKyXEOYSZjzqdzrGRovFnVq25c=;
        h=Date:To:From:Subject:From;
        b=UqLWU7JqxhlZeKDYatvrqtxghWyi362gFNaOD+1osZ/+5jMSkbkSvlm2KtAUD5mmz
         8D8MMNqiEBFgcM49G4T5MjBHx5HwkQzCfyJKIUxF+PF38vREZXCk8pDoFeqLYIDEZd
         S1A6RHEEYOROC68nzJtvxuxrl2RlqjCNEp9bIQ9U=
Date:   Wed, 20 Apr 2022 17:12:34 -0700
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: mmotm 2022-04-20-17-12 uploaded
Message-Id: <20220421001235.5F4E0C385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2022-04-20-17-12 has been uploaded to

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



This mmotm tree contains the following patches against 5.18-rc3:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-hwpoison-fix-race-between-hugetlb-free-demotion-and-memory_failure_hugetlb.patch
* mm-memory-failurec-skip-huge_zero_page-in-memory_failure.patch
* memcg-sync-flush-only-if-periodic-flush-is-delayed.patch
* mm-munlock-remove-fields-to-fix-htmldocs-warnings.patch
* userfaultfd-mark-uffd_wp-regardless-of-vm_write-flag.patch
* mm-hugetlbfs-allow-for-high-userspace-addresses.patch
* selftest-vm-verify-mmap-addr-in-mremap_test.patch
* selftest-vm-verify-remap-destination-address-in-mremap_test.patch
* selftest-vm-support-xfail-in-mremap_test.patch
* selftest-vm-add-skip-support-to-mremap_test.patch
* oom_killc-futex-delay-the-oom-reaper-to-allow-time-for-proper-futex-cleanup.patch
* kasan-prevent-cpu_quarantine-corruption-when-cpu-offline-and-cache-shrink-occur-at-same-time.patch
* maintainers-add-vincenzo-frascino-to-kasan-reviewers.patch
* kcov-dont-generate-a-warning-on-vm_insert_pages-failure.patch
* mm-highmem-fix-kernel-doc-warnings-in-highmemh.patch
* mm-mmu_notifierc-fix-race-in-mmu_interval_notifier_remove.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
  mm.patch
* kasan-fix-sleeping-function-called-from-invalid-context-on-rt-kernel.patch
* kasan-fix-sleeping-function-called-from-invalid-context-on-rt-kernel-fix.patch
* kasan-mark-kasan_vmalloc-flags-as-kasan_vmalloc_flags_t.patch
* tools-vm-page_owner_sortc-use-fprintf-to-send-error-messages-to-stderr.patch
* tools-vm-page_owner_sortc-support-for-multi-value-selection-in-single-argument.patch
* tools-vm-page_owner_sortc-support-sorting-blocks-by-multiple-keys.patch
* tools-vm-page_owner-support-debug-log-to-avoid-huge-log-print.patch
* tools-vm-page_owner_sortc-provide-allocator-labelling-and-update-cull-and-sort-options.patch
* tools-vm-page_owner_sortc-avoid-repeated-judgments.patch
* mm-page_ownerc-use-get_task_comm-to-record-task-command-name-with-the-protection-of-task_lock.patch
* mm-smaps_rollup-return-empty-file-for-kthreads-instead-of-esrch.patch
* mm-rmap-fix-missing-swap_free-in-try_to_unmap-after-arch_unmap_one-failed.patch
* mm-hugetlb-take-src_mm-write_protect_seq-in-copy_hugetlb_page_range.patch
* mm-memory-slightly-simplify-copy_present_pte.patch
* mm-rmap-split-page_dup_rmap-into-page_dup_file_rmap-and-page_try_dup_anon_rmap.patch
* mm-rmap-convert-rmap-flags-to-a-proper-distinct-rmap_t-type.patch
* mm-rmap-remove-do_page_add_anon_rmap.patch
* mm-rmap-pass-rmap-flags-to-hugepage_add_anon_rmap.patch
* mm-rmap-drop-compound-parameter-from-page_add_new_anon_rmap.patch
* mm-rmap-use-page_move_anon_rmap-when-reusing-a-mapped-pageanon-page-exclusively.patch
* mm-huge_memory-remove-outdated-vm_warn_on_once_page-from-unmap_page.patch
* mm-page-flags-reuse-pg_mappedtodisk-as-pg_anon_exclusive-for-pageanon-pages.patch
* mm-remember-exclusively-mapped-anonymous-pages-with-pg_anon_exclusive.patch
* mm-gup-disallow-follow_pagefoll_pin.patch
* mm-support-gup-triggered-unsharing-of-anonymous-pages.patch
* mm-support-gup-triggered-unsharing-of-anonymous-pages-fix.patch
* mm-gup-trigger-fault_flag_unshare-when-r-o-pinning-a-possibly-shared-anonymous-page.patch
* mm-gup-sanity-check-with-config_debug_vm-that-anonymous-pages-are-exclusive-when-unpinning.patch
* mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit.patch
* mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix.patch
* mm-debug_vm_pgtable-add-tests-for-__have_arch_pte_swp_exclusive.patch
* x86-pgtable-support-__have_arch_pte_swp_exclusive.patch
* x86-pgtable-support-__have_arch_pte_swp_exclusive-fix.patch
* arm64-pgtable-support-__have_arch_pte_swp_exclusive.patch
* s390-pgtable-cleanup-description-of-swp-pte-layout.patch
* s390-pgtable-support-__have_arch_pte_swp_exclusive.patch
* powerpc-pgtable-remove-_page_bit_swap_type-for-book3s.patch
* powerpc-pgtable-support-__have_arch_pte_swp_exclusive-for-book3s.patch
* selftest-vm-clarify-error-statement-in-gup_test.patch
* mm-create-new-mm-swaph-header-file.patch
* mm-create-new-mm-swaph-header-file-fix.patch
* mm-drop-swap_dirty_folio.patch
* mm-move-responsibility-for-setting-swp_fs_ops-to-swap_activate.patch
* mm-reclaim-mustnt-enter-fs-for-swp_fs_ops-swap-space.patch
* mm-introduce-swap_rw-and-use-it-for-reads-from-swp_fs_ops-swap-space.patch
* mm-perform-async-writes-to-swp_fs_ops-swap-space-using-swap_rw.patch
* doc-update-documentation-for-swap_activate-and-swap_rw.patch
* mm-submit-multipage-reads-for-swp_fs_ops-swap-space.patch
* mm-submit-multipage-write-for-swp_fs_ops-swap-space.patch
* vfs-add-fmode_can_odirect-file-flag.patch
* mm-shmem-make-shmem_init-return-void.patch
* mm-shmem-make-shmem_init-return-void-fix.patch
* mm-memcg-remove-unneeded-nr_scanned.patch
* mm-memcg-mz-already-removed-from-rb_tree-if-not-null.patch
* mm-memcg-set-memcg-after-css-verified-and-got-reference.patch
* mm-memcg-set-pos-explicitly-for-reclaim-and-reclaim.patch
* mm-memcg-move-generation-assignment-and-comparison-together.patch
* mm-memcg-non-hierarchical-mode-is-deprecated.patch
* kselftests-memcg-update-the-oom-group-leaf-events-test.patch
* kselftests-memcg-speed-up-the-memoryhigh-test.patch
* maintainers-add-corresponding-kselftests-to-cgroup-entry.patch
* maintainers-add-corresponding-kselftests-to-memcg-entry.patch
* selftests-vm-bring-common-functions-to-a-new-file.patch
* selftests-vm-add-test-for-soft-dirty-pte-bit.patch
* mm-use-mmap_assert_write_locked-instead-of-open-coding-it.patch
* mm-mmu_gather-limit-free-batch-count-and-add-schedule-point-in-tlb_batch_pages_flush.patch
* mm-debug_vm_pgtable-drop-protection_map-usage.patch
* mm-mmap-clarify-protection_map-indices.patch
* mm-mmapc-use-helper-mlock_future_check.patch
* mm-mmap-add-new-config-arch_has_vm_get_page_prot.patch
* powerpc-mm-enable-arch_has_vm_get_page_prot.patch
* arm64-mm-enable-arch_has_vm_get_page_prot.patch
* sparc-mm-enable-arch_has_vm_get_page_prot.patch
* x86-mm-enable-arch_has_vm_get_page_prot.patch
* mm-mmap-drop-arch_filter_pgprot.patch
* mm-mmap-drop-arch_vm_get_page_pgprot.patch
* mm-mprotect-use-mmu_gather.patch
* mm-mprotect-do-not-flush-when-not-required-architecturally.patch
* mm-avoid-unnecessary-flush-on-change_huge_pmd.patch
* mm-mremap-use-helper-mlock_future_check.patch
* mm-mremap-avoid-unneeded-do_munmap-call.patch
* mm-vmalloc-fix-a-comment.patch
* documentation-sysctl-document-page_lock_unfairness.patch
* mm-page_alloc-simplify-update-of-pgdat-in-wake_all_kswapds.patch
* mm-page_alloc-add-same-penalty-is-enough-to-get-round-robin-order.patch
* mm-page_alloc-add-same-penalty-is-enough-to-get-round-robin-order-v3.patch
* mm-discard-__gfp_atomic.patch
* mm-page_alloc-simplify-pageblock-migratetype-check-in-__free_one_page.patch
* mm-wrap-__find_buddy_pfn-with-a-necessary-buddy-page-validation.patch
* mm-wrap-__find_buddy_pfn-with-a-necessary-buddy-page-validation-v4.patch
* mm-calc-the-right-pfn-if-page-size-is-not-4k.patch
* mm-remove-unnecessary-void-conversions.patch
* mm-hwpoison-put-page-in-already-hwpoisoned-case-with-mf_count_increased.patch
* revert-mm-memory-failurec-fix-race-with-changing-page-compound-again.patch
* mm-memory-failurec-minor-cleanup-for-hwpoisonhandlable.patch
* mm-memory-failurec-dissolve-truncated-hugetlb-page.patch
* mm-hugetlb-hwpoison-separate-branch-for-free-and-in-use-hugepage.patch
* mm-khugepaged-sched-to-numa-node-when-collapse-huge-page.patch
* hugetlb-remove-use-of-list-iterator-variable-after-loop.patch
* mm-hugetlb_vmemmap-introduce-arch_want_hugetlb_page_free_vmemmap.patch
* arm64-mm-hugetlb-enable-hugetlb_page_free_vmemmap-for-arm64.patch
* arm64-mm-hugetlb-enable-hugetlb_page_free_vmemmap-for-arm64-fix.patch
* mm-hugetlb_vmemmap-cleanup-hugetlb_vmemmap-related-functions.patch
* mm-hugetlb_vmemmap-cleanup-hugetlb_free_vmemmap_enabled.patch
* mm-hugetlb_vmemmap-cleanup-config_hugetlb_page_free_vmemmap.patch
* sched-coredumph-clarify-the-use-of-mmf_vm_hugepage.patch
* mm-khugepaged-remove-redundant-check-for-vm_no_khugepaged.patch
* mm-khugepaged-skip-dax-vma.patch
* mm-thp-only-regular-file-could-be-thp-eligible.patch
* mm-khugepaged-make-khugepaged_enter-void-function.patch
* mm-khugepaged-move-some-khugepaged_-functions-to-khugepagedc.patch
* mm-khugepaged-introduce-khugepaged_enter_vma-helper.patch
* mm-mmap-register-suitable-readonly-file-vmas-for-khugepaged.patch
* hugetlb-fix-wrong-use-of-nr_online_nodes.patch
* hugetlb-fix-wrong-use-of-nr_online_nodes-v4.patch
* hugetlb-fix-hugepages_setup-when-deal-with-pernode.patch
* hugetlb-fix-return-value-of-__setup-handlers.patch
* hugetlb-clean-up-hugetlb_cma_reserve.patch
* mm-sparse-vmemmap-add-a-pgmap-argument-to-section-activation.patch
* mm-sparse-vmemmap-refactor-core-of-vmemmap_populate_basepages-to-helper.patch
* mm-hugetlb_vmemmap-move-comment-block-to-documentation-vm.patch
* mm-sparse-vmemmap-improve-memory-savings-for-compound-devmaps.patch
* mm-page_alloc-reuse-tail-struct-pages-for-compound-devmaps.patch
* mm-remove-stub-for-non_swap_entry.patch
* mm-introduce-pte_marker-swap-entry.patch
* mm-introduce-pte_marker-swap-entry-fix.patch
* mm-teach-core-mm-about-pte-markers.patch
* mm-check-against-orig_pte-for-finish_fault.patch
* mm-check-against-orig_pte-for-finish_fault-fix.patch
* mm-check-against-orig_pte-for-finish_fault-fix-checkpatch-fixes.patch
* mm-uffd-pte_marker_uffd_wp.patch
* mm-uffd-pte_marker_uffd_wp-fix.patch
* mm-shmem-take-care-of-uffdio_copy_mode_wp.patch
* mm-shmem-handle-uffd-wp-special-pte-in-page-fault-handler.patch
* mm-shmem-persist-uffd-wp-bit-across-zapping-for-file-backed.patch
* mm-shmem-allow-uffd-wr-protect-none-pte-for-file-backed-mem.patch
* mm-shmem-allows-file-back-mem-to-be-uffd-wr-protected-on-thps.patch
* mm-shmem-handle-uffd-wp-during-fork.patch
* mm-hugetlb-introduce-huge-pte-version-of-uffd-wp-helpers.patch
* mm-hugetlb-hook-page-faults-for-uffd-write-protection.patch
* mm-hugetlb-take-care-of-uffdio_copy_mode_wp.patch
* mm-hugetlb-handle-uffdio_writeprotect.patch
* mm-hugetlb-handle-pte-markers-in-page-faults.patch
* mm-hugetlb-allow-uffd-wr-protect-none-ptes.patch
* mm-hugetlb-only-drop-uffd-wp-special-pte-if-required.patch
* mm-hugetlb-only-drop-uffd-wp-special-pte-if-required-fix.patch
* mm-hugetlb-handle-uffd-wp-during-fork.patch
* mm-shmem-handle-uffd-wp-during-fork-fix.patch
* mm-khugepaged-dont-recycle-vma-pgtable-if-uffd-wp-registered.patch
* mm-pagemap-recognize-uffd-wp-bit-for-shmem-hugetlbfs.patch
* mm-uffd-enable-write-protection-for-shmem-hugetlbfs.patch
* mm-enable-pte-markers-by-default.patch
* mm-enable-pte-markers-by-default-fix.patch
* selftests-uffd-enable-uffd-wp-for-shmem-hugetlbfs.patch
* userfaultfd-selftests-use-swap-instead-of-open-coding-it.patch
* mm-uffd-move-userfaultfd-configs-into-mm.patch
* mm-vmscan-reclaim-only-affects-managed_zones.patch
* mm-vmscan-make-sure-wakeup_kswapd-with-managed-zone.patch
* mm-vmscan-make-sure-wakeup_kswapd-with-managed-zone-v2.patch
* mm-vmscan-sc-reclaim_idx-must-be-a-valid-zone-index.patch
* mm-vmscan-remove-obsolete-comment-in-get_scan_count.patch
* mm-vmscan-fix-comment-for-current_may_throttle.patch
* mm-vmscan-fix-comment-for-current_may_throttle-fix.patch
* mm-vmscan-fix-comment-for-isolate_lru_pages.patch
* mm-do-not-call-add_nr_deferred-with-zero-deferred.patch
* mm-proc-remove-redundant-page-validation-of-pte_page.patch
* mm-z3fold-declare-z3fold_mount-with-__init.patch
* mm-z3fold-remove-obsolete-comment-in-z3fold_alloc.patch
* mm-z3fold-minor-clean-up-for-z3fold_free.patch
* mm-z3fold-remove-unneeded-page_mapcount_reset-and-clearpageprivate.patch
* mm-z3fold-remove-confusing-local-variable-l-reassignment.patch
* mm-z3fold-move-decrement-of-pool-pages_nr-into-__release_z3fold_page.patch
* mm-z3fold-remove-redundant-list_del_init-of-zhdr-buddy-in-z3fold_free.patch
* mm-z3fold-remove-unneeded-page_headless-check-in-free_handle.patch
* mm-compaction-use-helper-isolation_suitable.patch
* drivers-base-nodec-fix-compaction-sysfs-file-leak.patch
* mm-mempolicy-clean-up-the-code-logic-in-queue_pages_pte_range.patch
* mm-add-selftests-for-migration-entries.patch
* mm-migration-remove-unneeded-local-variable-mapping_locked.patch
* mm-migration-remove-unneeded-local-variable-page_lru.patch
* mm-migration-use-helper-function-vma_lookup-in-add_page_for_migration.patch
* mm-migration-use-helper-macro-min-in-do_pages_stat.patch
* mm-migration-avoid-unneeded-nodemask_t-initialization.patch
* mm-migration-remove-some-duplicated-codes-in-migrate_pages.patch
* mm-migration-fix-potential-page-refcounts-leak-in-migrate_pages.patch
* mm-migration-fix-potential-invalid-node-access-for-reclaim-based-migration.patch
* mm-migration-fix-possible-do_pages_stat_array-racing-with-memory-offline.patch
* mm-migrate-simplify-the-refcount-validation-when-migrating-hugetlb-mapping.patch
* ksm-count-ksm-merging-pages-for-each-process.patch
* ksm-count-ksm-merging-pages-for-each-process-fix.patch
* mm-vmstat-add-events-for-ksm-cow.patch
* mm-untangle-config-dependencies-for-demote-on-reclaim.patch
* mm-madvise-fix-potential-pte_unmap_unlock-pte-error.patch
* mm-page_alloc-do-not-calculate-nodes-total-pages-and-memmap-pages-when-empty.patch
* mm-memory_hotplug-reset-nodes-state-when-empty-during-offline.patch
* mm-memory_hotplug-reset-nodes-state-when-empty-during-offline-fix.patch
* mm-memory_hotplug-refactor-hotadd_init_pgdat-and-try_online_node.patch
* mm-memory_hotplug-refactor-hotadd_init_pgdat-and-try_online_node-checkpatch-fixes.patch
* mm-compaction-remove-unneeded-return-value-of-kcompactd_run.patch
* mm-compaction-remove-unneeded-pfn-update.patch
* mm-compaction-remove-unneeded-assignment-to-isolate_start_pfn.patch
* mm-compaction-clean-up-comment-for-sched-contention.patch
* mm-compaction-clean-up-comment-about-suitable-migration-target-recheck.patch
* mm-compaction-use-compact_cluster_max-in-compactionc.patch
* mm-compaction-use-helper-compound_nr-in-isolate_migratepages_block.patch
* mm-compaction-clean-up-comment-about-async-compaction-in-isolate_migratepages.patch
* mm-compaction-avoid-possible-null-pointer-dereference-in-kcompactd_cpu_online.patch
* mm-compaction-make-compaction_zonelist_suitable-return-false-when-compact_success.patch
* mm-compaction-simplify-the-code-in-__compact_finished.patch
* mm-compaction-make-sure-highest-is-above-the-min_pfn.patch
* mm-rmap-fix-cache-flush-on-thp-pages.patch
* dax-fix-cache-flush-on-pmd-mapped-pages.patch
* mm-rmap-introduce-pfn_mkclean_range-to-cleans-ptes.patch
* mm-pvmw-add-support-for-walking-devmap-pages.patch
* dax-fix-missing-writeprotect-the-pte-entry.patch
* mm-simplify-follow_invalidate_pte.patch
* zram-add-a-huge_idle-writeback-mode.patch
* damon-vaddr-test-tweak-code-to-make-the-logic-clearer.patch
* selftests-damon-add-damon-to-selftests-root-makefile.patch
* mm-damon-core-test-add-a-kunit-test-case-for-ops-registration.patch
* mm-swapfile-unuse_pte-can-map-random-data-if-swap-read-fails.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* ia64-fix-typos-in-comments.patch
* ia64-ptrace-fix-typos-in-comments.patch
* ia64-replace-comments-with-c99-initializers.patch
* scripts-decode_stacktracesh-support-old-bash-version.patch
* ocfs2-replace-usage-of-found-with-dedicated-list-iterator-variable.patch
* ocfs2-remove-usage-of-list-iterator-variable-after-the-loop-body.patch
* ocfs2-reflink-deadlock-when-clone-file-to-the-same-directory-simultaneously.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* proc-fix-dentry-inode-overinstantiating-under-proc-pid-net.patch
* proc-fix-dentry-inode-overinstantiating-under-proc-pid-net-checkpatch-fixes.patch
* fs-proc-kcorec-remove-check-of-list-iterator-against-head-past-the-loop-body.patch
* fs-proc-kcorec-remove-check-of-list-iterator-against-head-past-the-loop-body-fix.patch
* proc-sysctl-make-protected_-world-readable.patch
* kernel-pid_namespace-use-null-instead-of-using-plain-integer-as-pointer.patch
* get_maintainer-honor-mailmap-for-in-file-emails.patch
* lib-test_meminit-optimize-do_kmem_cache_rcu_persistent-test.patch
* lib-kconfigdebug-remove-more-config__value-indirections.patch
* lib-test_stringc-add-strspn-and-strcspn-tests.patch
* lib-stringc-simplify-strspn.patch
* lib-remove-back_str-initialization.patch
* pipe-make-poll_usage-boolean-and-annotate-its-access.patch
* list-fix-a-data-race-around-ep-rdllist.patch
* init-kconfig-remove-uselib-syscall-by-default.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* fatfs-remove-redundant-judgment.patch
* add-fat-messages-to-printk-index.patch
* add-fat-messages-to-printk-index-checkpatch-fixes.patch
* fat-add-ratelimit-to-fat_ent_bread.patch
* ptrace-remove-redudant-check-of-ifdef-ptrace_singlestep.patch
* ptrace-fix-wrong-comment-of-pt_dtrace.patch
* maintainers-remove-redundant-file-of-ptrace-support-entry.patch
* kexec-remove-redundant-assignments.patch
* rapidio-remove-unnecessary-use-of-list-iterator.patch
* taskstats-version-12-with-thread-group-and-exe-info.patch
* taskstats-version-12-with-thread-group-and-exe-info-fix.patch
* kernel-make-taskstats-available-from-all-net-namespaces.patch
* delayacct-track-delays-from-write-protect-copy.patch
* fs-sysv-check-sbi-s_firstdatazone-in-complete_read_super.patch
* ipc-sem-remove-redundant-assignments.patch
* ipc-update-semtimedop-to-use-hrtimer.patch
* ipc-mqueue-use-get_tree_nodev-in-mqueue_get_tree.patch
  linux-next.patch
  linux-next-rejects.patch
* mm-oom_killc-fix-vm_oom_kill_table-ifdeffery.patch
* kselftest-vm-override-targets-from-arguments.patch
