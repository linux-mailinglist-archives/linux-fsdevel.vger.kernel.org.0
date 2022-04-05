Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9CE4F54BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 07:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378633AbiDFFQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 01:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837369AbiDFApn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 20:45:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B72F3A189;
        Tue,  5 Apr 2022 15:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B859B81FEC;
        Tue,  5 Apr 2022 22:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE86C385A0;
        Tue,  5 Apr 2022 22:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649199276;
        bh=05SjG2DRAYPxpqeIRii9i15IeCtg0I60d3w6NprEXE4=;
        h=Date:To:From:Subject:From;
        b=ZkEG9SsCgkC0fsLUFTrZdbYfpYYIvfzSbEf4azq2CNEwcapt47tIgORTz+xblTcWJ
         7+jIf0Og68CH666Mbfn0hydmi+zF/KekN1BNKkbdCaoyrDZIPve08fTeKM7t7M4bR9
         tnSjL8s6w0ZpkAIaADoK/HliC8m2iUiIcEgdRQYM=
Date:   Tue, 05 Apr 2022 15:54:35 -0700
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: mmotm 2022-04-05-15-54 uploaded
Message-Id: <20220405225436.AFE86C385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2022-04-05-15-54 has been uploaded to

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



This mmotm tree contains the following patches against 5.18-rc1:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-migrate-use-thp_order-instead-of-hpage_pmd_order-for-new-page-allocation.patch
* highmem-fix-checks-in-__kmap_local_sched_inout.patch
* lz4-fix-lz4_decompress_safe_partial-read-out-of-bound.patch
* mm-secretmem-fix-panic-when-growing-a-memfd_secret.patch
* mm-secretmem-fix-panic-when-growing-a-memfd_secret-fix.patch
* mailmap-update-vasily-averins-email-address.patch
* memcg-sync-flush-only-if-periodic-flush-is-delayed.patch
* mm-list_lruc-revert-mm-list_lru-optimize-memcg_reparent_list_lru_node.patch
* mm-sparsemem-fix-mem_section-will-never-be-null-gcc-12-warning.patch
* mm-avoid-pointless-invalidate_range_start-end-on-mremapold_size=0.patch
* mm-mempolicy-fix-mpol_new-leak-in-shared_policy_replace.patch
* mm-munlock-remove-fields-to-fix-htmldocs-warnings.patch
* mm-hwpoison-fix-race-between-hugetlb-free-demotion-and-memory_failure_hugetlb.patch
* irq_work-use-kasan_record_aux_stack_noalloc-record-callstack.patch
* mm-vmalloc-fix-spinning-drain_vmap_work-after-reading-from-proc-vmcore.patch
* userfaultfd-mark-uffd_wp-regardless-of-vm_write-flag.patch
* mm-fix-unexpected-zeroed-page-mapping-with-zram-swap.patch
* mm-compaction-fix-compiler-warning-when-config_compaction=n.patch
* hugetlb-do-not-demote-poisoned-hugetlb-pages.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
  mm.patch
* tools-vm-page_owner_sortc-use-fprintf-to-send-error-messages-to-stderr.patch
* tools-vm-page_owner_sortc-support-for-multi-value-selection-in-single-argument.patch
* tools-vm-page_owner_sortc-support-sorting-blocks-by-multiple-keys.patch
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
* mm-gup-trigger-fault_flag_unshare-when-r-o-pinning-a-possibly-shared-anonymous-page.patch
* mm-gup-sanity-check-with-config_debug_vm-that-anonymous-pages-are-exclusive-when-unpinning.patch
* mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit.patch
* mm-debug_vm_pgtable-add-tests-for-__have_arch_pte_swp_exclusive.patch
* x86-pgtable-support-__have_arch_pte_swp_exclusive.patch
* arm64-pgtable-support-__have_arch_pte_swp_exclusive.patch
* s390-pgtable-cleanup-description-of-swp-pte-layout.patch
* s390-pgtable-support-__have_arch_pte_swp_exclusive.patch
* powerpc-pgtable-remove-_page_bit_swap_type-for-book3s.patch
* powerpc-pgtable-support-__have_arch_pte_swp_exclusive-for-book3s.patch
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
* mm-use-mmap_assert_write_locked-instead-of-open-coding-it.patch
* mm-mmu_gather-limit-free-batch-count-and-add-schedule-point-in-tlb_batch_pages_flush.patch
* mm-debug_vm_pgtable-drop-protection_map-usage.patch
* mm-mmap-clarify-protection_map-indices.patch
* mm-modify-the-method-to-search-addr-in-unmapped_area_topdown.patch
* mm-mmapc-use-helper-mlock_future_check.patch
* mm-mprotect-use-mmu_gather.patch
* mm-mprotect-do-not-flush-when-not-required-architecturally.patch
* mm-avoid-unnecessary-flush-on-change_huge_pmd.patch
* mm-mremap-use-helper-mlock_future_check.patch
* mm-mremap-avoid-unneeded-do_munmap-call.patch
* mm-vmalloc-fix-a-comment.patch
* documentation-sysctl-document-page_lock_unfairness.patch
* mm-page_alloc-simplify-update-of-pgdat-in-wake_all_kswapds.patch
* mm-page_alloc-add-same-penalty-is-enough-to-get-round-robin-order.patch
* mm-discard-__gfp_atomic.patch
* mm-page_alloc-simplify-pageblock-migratetype-check-in-__free_one_page.patch
* mm-wrap-__find_buddy_pfn-with-a-necessary-buddy-page-validation.patch
* mm-wrap-__find_buddy_pfn-with-a-necessary-buddy-page-validation-v4.patch
* mm-remove-unnecessary-void-conversions.patch
* mm-khugepaged-sched-to-numa-node-when-collapse-huge-page.patch
* hugetlb-remove-use-of-list-iterator-variable-after-loop.patch
* mm-hugetlb_vmemmap-introduce-arch_want_hugetlb_page_free_vmemmap.patch
* arm64-mm-hugetlb-enable-hugetlb_page_free_vmemmap-for-arm64.patch
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
* mm-vmscan-reclaim-only-affects-managed_zones.patch
* mm-vmscan-make-sure-wakeup_kswapd-with-managed-zone.patch
* mm-vmscan-make-sure-wakeup_kswapd-with-managed-zone-v2.patch
* mm-vmscan-sc-reclaim_idx-must-be-a-valid-zone-index.patch
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
* mm-add-selftests-for-migration-entries.patch
* mm-migration-remove-unneeded-local-variable-mapping_locked.patch
* mm-migration-remove-unneeded-out-label.patch
* mm-migration-remove-unneeded-local-variable-page_lru.patch
* mm-migration-fix-the-confusing-pagetranshuge-check.patch
* mm-migration-use-helper-function-vma_lookup-in-add_page_for_migration.patch
* mm-migration-use-helper-macro-min-in-do_pages_stat.patch
* mm-migration-avoid-unneeded-nodemask_t-initialization.patch
* mm-migration-remove-some-duplicated-codes-in-migrate_pages.patch
* mm-migration-fix-potential-page-refcounts-leak-in-migrate_pages.patch
* mm-migration-fix-potential-invalid-node-access-for-reclaim-based-migration.patch
* mm-migration-fix-possible-do_pages_stat_array-racing-with-memory-offline.patch
* ksm-count-ksm-merging-pages-for-each-process.patch
* ksm-count-ksm-merging-pages-for-each-process-fix.patch
* mm-vmstat-add-events-for-ksm-cow.patch
* mm-untangle-config-dependencies-for-demote-on-reclaim.patch
* mm-page_alloc-do-not-calculate-nodes-total-pages-and-memmap-pages-when-empty.patch
* mm-memory_hotplug-reset-nodes-state-when-empty-during-offline.patch
* mm-memory_hotplug-refactor-hotadd_init_pgdat-and-try_online_node.patch
* mm-memory_hotplug-refactor-hotadd_init_pgdat-and-try_online_node-checkpatch-fixes.patch
* mm-rmap-fix-cache-flush-on-thp-pages.patch
* dax-fix-cache-flush-on-pmd-mapped-pages.patch
* mm-rmap-introduce-pfn_mkclean_range-to-cleans-ptes.patch
* mm-pvmw-add-support-for-walking-devmap-pages.patch
* dax-fix-missing-writeprotect-the-pte-entry.patch
* mm-simplify-follow_invalidate_pte.patch
* zram-add-a-huge_idle-writeback-mode.patch
* damon-vaddr-test-tweak-code-to-make-the-logic-clearer.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* ia64-fix-typos-in-comments.patch
* ia64-ptrace-fix-typos-in-comments.patch
* ia64-replace-comments-with-c99-initializers.patch
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
* init-mainc-silence-some-wunused-parameter-warnings.patch
* fatfs-remove-redundant-judgment.patch
* add-fat-messages-to-printk-index.patch
* add-fat-messages-to-printk-index-checkpatch-fixes.patch
* fat-add-ratelimit-to-fat_ent_bread.patch
* kexec-remove-redundant-assignments.patch
* rapidio-remove-unnecessary-use-of-list-iterator.patch
* taskstats-version-12-with-thread-group-and-exe-info.patch
* taskstats-version-12-with-thread-group-and-exe-info-fix.patch
* fs-sysv-check-sbi-s_firstdatazone-in-complete_read_super.patch
* ipc-mqueue-use-get_tree_nodev-in-mqueue_get_tree.patch
  linux-next.patch
  linux-next-git-rejects.patch
* mm-oom_killc-fix-vm_oom_kill_table-ifdeffery.patch
* selftests-vm-add-test-for-soft-dirty-pte-bit.patch
* kselftest-vm-override-targets-from-arguments.patch
