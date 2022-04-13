Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252874FEE11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 06:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiDMEId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 00:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiDMEIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D94651E5D;
        Tue, 12 Apr 2022 21:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B898A61B89;
        Wed, 13 Apr 2022 04:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AAAC385A4;
        Wed, 13 Apr 2022 04:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649822770;
        bh=jbRdzeBkAgl24V9Nxk1hK4usxLcy9Ruqm8plt/afHi4=;
        h=Date:To:From:Subject:From;
        b=VVSvVzUjVO4HGcDNy8FCNN9E+5dUmSLVK8YvoU+0Tz4EnbArQph/GCFVC49sb9g0u
         swKiF03jUITu2ENyBhnPBu4wFboQDHwMA08ocnPtXMiOejaBmcZZdWx/dDIx58tA84
         vcPwD40q3VZEf7OD+vr/Gx8h/fbD1vXPPH2D5ROY=
Date:   Tue, 12 Apr 2022 21:06:09 -0700
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: mmotm 2022-04-12-21-05 uploaded
Message-Id: <20220413040610.06AAAC385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2022-04-12-21-05 has been uploaded to

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



This mmotm tree contains the following patches against 5.18-rc2:
(patches marked "*" will be included in linux-next)

  origin.patch
* maintainers-broadcom-internal-lists-arent-maintainers.patch
* tmpfs-fix-regressions-from-wider-use-of-zero_page.patch
* mm-secretmem-fix-panic-when-growing-a-memfd_secret.patch
* mm-secretmem-fix-panic-when-growing-a-memfd_secret-fix.patch
* mm-secretmem-fix-panic-when-growing-a-memfd_secret-v2.patch
* mm-hwpoison-fix-race-between-hugetlb-free-demotion-and-memory_failure_hugetlb.patch
* irq_work-use-kasan_record_aux_stack_noalloc-record-callstack.patch
* kasan-fix-hw-tags-enablement-when-kunit-tests-are-disabled.patch
* mm-kfence-support-kmem_dump_obj-for-kfence-objects.patch
* mm-page_alloc-fix-build_zonerefs_node.patch
* mm-fix-unexpected-zeroed-page-mapping-with-zram-swap.patch
* mm-compaction-fix-compiler-warning-when-config_compaction=n.patch
* hugetlb-do-not-demote-poisoned-hugetlb-pages.patch
* revert-fs-binfmt_elf-fix-pt_load-p_align-values-for-loaders.patch
* revert-fs-binfmt_elf-use-pt_load-p_align-values-for-static-pie.patch
* mm-page_alloc-check-pfn-is-valid-before-moving-to-freelist.patch
* mm-page_alloc-check-pfn-is-valid-before-moving-to-freelist-fix.patch
* mm-memory-failurec-skip-huge_zero_page-in-memory_failure.patch
* memcg-sync-flush-only-if-periodic-flush-is-delayed.patch
* mm-munlock-remove-fields-to-fix-htmldocs-warnings.patch
* mm-vmalloc-fix-spinning-drain_vmap_work-after-reading-from-proc-vmcore.patch
* userfaultfd-mark-uffd_wp-regardless-of-vm_write-flag.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
  mm.patch
* kasan-fix-sleeping-function-called-from-invalid-context-on-rt-kernel.patch
* kasan-mark-kasan_vmalloc-flags-as-kasan_vmalloc_flags_t.patch
* tools-vm-page_owner_sortc-use-fprintf-to-send-error-messages-to-stderr.patch
* tools-vm-page_owner_sortc-support-for-multi-value-selection-in-single-argument.patch
* tools-vm-page_owner_sortc-support-sorting-blocks-by-multiple-keys.patch
* tools-vm-page_owner-support-debug-log-to-avoid-huge-log-print.patch
* tools-vm-page_owner_sortc-provide-allocator-labelling-and-update-cull-and-sort-options.patch
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
* mm-use-mmap_assert_write_locked-instead-of-open-coding-it.patch
* mm-mmu_gather-limit-free-batch-count-and-add-schedule-point-in-tlb_batch_pages_flush.patch
* mm-debug_vm_pgtable-drop-protection_map-usage.patch
* mm-mmap-clarify-protection_map-indices.patch
* mm-modify-the-method-to-search-addr-in-unmapped_area_topdown.patch
* mm-mmapc-use-helper-mlock_future_check.patch
* mm-mmap-add-new-config-arch_has_vm_get_page_prot.patch
* powerpc-mm-enable-arch_has_vm_get_page_prot.patch
* arm64-mm-enable-arch_has_vm_get_page_prot.patch
* sparc-mm-enable-arch_has_vm_get_page_prot.patch
* x86-mm-enable-arch_has_vm_get_page_prot.patch
* mm-mmap-drop-arch_filter_pgprot.patch
* mm-mmap-drop-arch_vm_get_page_pgprot.patch
* mm-fix-align-error-when-get_addr-in-unmapped_area_topdown.patch
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
* mm-remove-unnecessary-void-conversions.patch
* mm-hwpoison-put-page-in-already-hwpoisoned-case-with-mf_count_increased.patch
* revert-mm-memory-failurec-fix-race-with-changing-page-compound-again.patch
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
* mm-introduce-pte_marker-swap-entry.patch
* mm-introduce-pte_marker-swap-entry-fix.patch
* mm-teach-core-mm-about-pte-markers.patch
* mm-check-against-orig_pte-for-finish_fault.patch
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
* mm-hugetlb-handle-uffd-wp-during-fork.patch
* mm-khugepaged-dont-recycle-vma-pgtable-if-uffd-wp-registered.patch
* mm-pagemap-recognize-uffd-wp-bit-for-shmem-hugetlbfs.patch
* mm-uffd-enable-write-protection-for-shmem-hugetlbfs.patch
* mm-enable-pte-markers-by-default.patch
* selftests-uffd-enable-uffd-wp-for-shmem-hugetlbfs.patch
* userfaultfd-selftests-use-swap-instead-of-open-coding-it.patch
* mm-vmscan-reclaim-only-affects-managed_zones.patch
* mm-vmscan-make-sure-wakeup_kswapd-with-managed-zone.patch
* mm-vmscan-make-sure-wakeup_kswapd-with-managed-zone-v2.patch
* mm-vmscan-sc-reclaim_idx-must-be-a-valid-zone-index.patch
* mm-vmscan-remove-obsolete-comment-in-get_scan_count.patch
* mm-x86-arm64-add-arch_has_hw_pte_young.patch
* mm-x86-add-config_arch_has_nonleaf_pmd_young.patch
* mm-vmscanc-refactor-shrink_node.patch
* revert-include-linux-mm_inlineh-fold-__update_lru_size-into-its-sole-caller.patch
* mm-multi-gen-lru-groundwork.patch
* mm-multi-gen-lru-minimal-implementation.patch
* mm-multi-gen-lru-exploit-locality-in-rmap.patch
* mm-multi-gen-lru-support-page-table-walks.patch
* mm-multi-gen-lru-optimize-multiple-memcgs.patch
* mm-multi-gen-lru-kill-switch.patch
* mm-multi-gen-lru-thrashing-prevention.patch
* mm-multi-gen-lru-debugfs-interface.patch
* mm-multi-gen-lru-admin-guide.patch
* mm-multi-gen-lru-design-doc.patch
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
* lib-irq_poll-add-local_bh_disable-in-irq_poll_cpu_dead.patch
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
* ipc-mqueue-use-get_tree_nodev-in-mqueue_get_tree.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
* mm-oom_killc-fix-vm_oom_kill_table-ifdeffery.patch
* selftests-vm-add-test-for-soft-dirty-pte-bit.patch
* kselftest-vm-override-targets-from-arguments.patch
