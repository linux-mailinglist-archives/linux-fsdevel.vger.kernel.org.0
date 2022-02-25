Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AC44C3E7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 07:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiBYGkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 01:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbiBYGkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:40:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3E7270249;
        Thu, 24 Feb 2022 22:39:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90B55B82B98;
        Fri, 25 Feb 2022 06:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B1CC340E7;
        Fri, 25 Feb 2022 06:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645771167;
        bh=Siy/hbKqPfq6Jap+LFd/pm2qO+qSKwiIaP2Iawl1sZc=;
        h=Date:To:From:Subject:From;
        b=0QnTHvwmNtjYuTK28Fx7plvBZqzpIR6EH3G+3TG9zI2IrCa5Ek70ez+Y4HV4RK46v
         HbJimj9rJBiE0XYG/aMBr6ObLflcKok4PhV6xPR3hw060dIU5oS0I5hjg6k8ECjcOm
         o7UakCzN8jQt7kyycFg59w3yHmryuajxlGB52epY=
Date:   Thu, 24 Feb 2022 22:39:26 -0800
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: mmotm 2022-02-24-22-38 uploaded
Message-Id: <20220225063927.29B1CC340E7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2022-02-24-22-38 has been uploaded to

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



This mmotm tree contains the following patches against 5.17-rc5:
(patches marked "*" will be included in linux-next)

  origin.patch
* maintainers-add-sysctl-next-git-tree.patch
* mm-hugetlb-fix-kernel-crash-with-hugetlb-mremap.patch
* kasan-test-prevent-cache-merging-in-kmem_cache_double_destroy.patch
* hugetlbfs-fix-a-truncation-issue-in-hugepages-parameter.patch
* mm-fix-use-after-free-bug-when-mm-mmap-is-reused-after-being-freed.patch
* selftest-vm-fix-map_fixed_noreplace-test-failure.patch
* maintainers-add-myself-as-a-memcg-co-maintainer.patch
* maintainers-remove-myself-from-memcg-maintainers.patch
* maintainers-slab-add-roman-as-reviewer-git-tree.patch
* mailmap-update-roman-gushchins-email.patch
* selftests-memfd-clean-up-mapping-in-mfd_fail_write.patch
* coredump-also-dump-first-pages-of-non-executable-elf-libraries.patch
* mm-fix-panic-in-__alloc_pages.patch
* selftests-vm-cleanup-hugetlb-file-after-mremap-test.patch
* mm-refactor-vm_area_struct-anon_vma_name-usage-code.patch
* mm-prevent-vm_area_struct-anon_name-refcount-saturation.patch
* mm-fix-use-after-free-when-anon-vma-name-is-used-after-vma-is-freed.patch
* userfaultfd-mark-uffd_wp-regardless-of-vm_write-flag.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
* scripts-spellingtxt-add-more-spellings-to-spellingtxt.patch
* ntfs-add-sanity-check-on-allocation-size.patch
* ocfs2-cleanup-some-return-variables.patch
* fs-ocfs2-fix-comments-mentioning-i_mutex.patch
* ocfs2-reflink-deadlock-when-clone-file-to-the-same-directory-simultaneously.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* doc-convert-subsection-to-section-in-gfph.patch
* mm-document-and-polish-read-ahead-code.patch
* mm-improve-cleanup-when-readpages-doesnt-process-all-pages.patch
* fuse-remove-reliance-on-bdi-congestion.patch
* nfs-remove-reliance-on-bdi-congestion.patch
* ceph-remove-reliance-on-bdi-congestion.patch
* remove-inode_congested.patch
* remove-bdi_congested-and-wb_congested-and-related-functions.patch
* remove-bdi_congested-and-wb_congested-and-related-functions-fix.patch
* f2fs-replace-congestion_wait-calls-with-io_schedule_timeout.patch
* block-bfq-ioschedc-use-false-rather-than-blk_rw_async.patch
* remove-congestion-tracking-framework.patch
* mount-warn-only-once-about-timestamp-range-expiration.patch
  mm.patch
* mm-sparse-vmemmap-add-a-pgmap-argument-to-section-activation.patch
* mm-sparse-vmemmap-refactor-core-of-vmemmap_populate_basepages-to-helper.patch
* mm-hugetlb_vmemmap-move-comment-block-to-documentation-vm.patch
* mm-sparse-vmemmap-improve-memory-savings-for-compound-devmaps.patch
* mm-page_alloc-reuse-tail-struct-pages-for-compound-devmaps.patch
* mm-memremap-avoid-calling-kasan_remove_zero_shadow-for-device-private-memory.patch
* tools-vm-page_owner_sortc-sort-by-stacktrace-before-culling.patch
* tools-vm-page_owner_sortc-sort-by-stacktrace-before-culling-fix.patch
* tools-vm-page_owner_sortc-support-sorting-by-stack-trace.patch
* tools-vm-page_owner_sortc-add-switch-between-culling-by-stacktrace-and-txt.patch
* tools-vm-page_owner_sortc-support-sorting-pid-and-time.patch
* tools-vm-page_owner_sortc-two-trivial-fixes.patch
* tools-vm-page_owner_sortc-delete-invalid-duplicate-code.patch
* documentation-vm-page_ownerrst-update-the-documentation.patch
* documentation-vm-page_ownerrst-update-the-documentation-fix.patch
* docs-vm-fix-unexpected-indentation-warns-in-page_owner.patch
* documentation-vm-page_ownerrst-fix-commends.patch
* lib-vsprintf-avoid-redundant-work-with-0-size.patch
* mm-page_owner-use-scnprintf-to-avoid-excessive-buffer-overrun-check.patch
* mm-page_owner-print-memcg-information.patch
* mm-page_owner-record-task-command-name.patch
* mm-page_ownerc-record-tgid.patch
* tools-vm-page_owner_sortc-fix-the-instructions-for-use.patch
* mm-unexport-page_init_poison.patch
* filemap-remove-find_get_pages.patch
* mm-fix-invalid-page-pointer-returned-with-foll_pin-gups.patch
* mm-gup-follow_pfn_pte-eexist-cleanup.patch
* mm-gup-remove-unused-pin_user_pages_locked.patch
* mm-change-lookup_node-to-use-get_user_pages_fast.patch
* mm-gup-remove-unused-get_user_pages_locked.patch
* tmpfs-support-for-file-creation-time.patch
* memcg-replace-in_interrupt-with-in_task.patch
* memcg-add-per-memcg-total-kernel-memory-stat.patch
* mm-memcg-mem_cgroup_per_node-is-already-set-to-0-on-allocation.patch
* mm-memcg-retrieve-parent-memcg-from-cssparent.patch
* memcg-refactor-mem_cgroup_oom.patch
* memcg-unify-force-charging-conditions.patch
* selftests-memcg-test-high-limit-for-single-entry-allocation.patch
* memcg-synchronously-enforce-memoryhigh-for-large-overcharges.patch
* mm-memcg-revert-mm-memcg-optimize-user-context-object-stock-access.patch
* mm-memcg-disable-threshold-event-handlers-on-preempt_rt.patch
* mm-memcg-protect-per-cpu-counter-by-disabling-preemption-on-preempt_rt-where-needed.patch
* mm-memcg-opencode-the-inner-part-of-obj_cgroup_uncharge_pages-in-drain_obj_stock.patch
* mm-memcg-protect-memcg_stock-with-a-local_lock_t.patch
* mm-memcg-disable-migration-instead-of-preemption-in-drain_all_stock.patch
* mm-memcontrol-return-1-from-cgroupmemory-__setup-handler.patch
* mm-memcg-set-memcg-after-css-verified-and-got-reference.patch
* mm-memcg-set-pos-to-prev-unconditionally.patch
* mm-memcg-move-generation-assignment-and-comparison-together.patch
* mm-generalize-arch_has_filter_pgprot.patch
* mm-merge-pte_mkhuge-call-into-arch_make_huge_pte.patch
* mm-remove-mmu_gathers-storage-from-remaining-architectures.patch
* mm-thp-fix-wrong-cache-flush-in-remove_migration_pmd.patch
* mm-fix-missing-cache-flush-for-all-tail-pages-of-compound-page.patch
* mm-hugetlb-fix-missing-cache-flush-in-copy_huge_page_from_user.patch
* mm-hugetlb-fix-missing-cache-flush-in-hugetlb_mcopy_atomic_pte.patch
* mm-shmem-fix-missing-cache-flush-in-shmem_mfill_atomic_pte.patch
* mm-userfaultfd-fix-missing-cache-flush-in-mcopy_atomic_pte-and-__mcopy_atomic.patch
* mm-replace-multiple-dcache-flush-with-flush_dcache_folio.patch
* mm-dont-skip-swap-entry-even-if-zap_details-specified.patch
* mm-dont-skip-swap-entry-even-if-zap_details-specified-v5.patch
* mm-rename-zap_skip_check_mapping-to-should_zap_page.patch
* mm-change-zap_detailszap_mapping-into-even_cows.patch
* mm-rework-swap-handling-of-zap_pte_range.patch
* mm-mmap-return-1-from-stack_guard_gap-__setup-handler.patch
* mm-debug_vm_pgtable-drop-protection_map-usage.patch
* mm-mmap-clarify-protection_map-indices.patch
* mm-mmap-add-new-config-arch_has_vm_get_page_prot.patch
* powerpc-mm-enable-arch_has_vm_get_page_prot.patch
* arm64-mm-enable-arch_has_vm_get_page_prot.patch
* sparc-mm-enable-arch_has_vm_get_page_prot.patch
* mips-mm-enable-arch_has_vm_get_page_prot.patch
* m68k-mm-enable-arch_has_vm_get_page_prot.patch
* arm-mm-enable-arch_has_vm_get_page_prot.patch
* x86-mm-enable-arch_has_vm_get_page_prot.patch
* x86-mm-enable-arch_has_vm_get_page_prot-fix.patch
* mm-mmap-drop-protection_map.patch
* mm-mmap-drop-arch_filter_pgprot.patch
* mm-mmap-drop-arch_vm_get_page_pgprot.patch
* s390-mm-enable-arch_has_vm_get_page_prot.patch
* riscv-mm-enable-arch_has_vm_get_page_prot.patch
* alpha-mm-enable-arch_has_vm_get_page_prot.patch
* sh-mm-enable-arch_has_vm_get_page_prot.patch
* arc-mm-enable-arch_has_vm_get_page_prot.patch
* csky-mm-enable-arch_has_vm_get_page_prot.patch
* extensa-mm-enable-arch_has_vm_get_page_prot.patch
* parisc-mm-enable-arch_has_vm_get_page_prot.patch
* openrisc-mm-enable-arch_has_vm_get_page_prot.patch
* um-mm-enable-arch_has_vm_get_page_prot.patch
* microblaze-mm-enable-arch_has_vm_get_page_prot.patch
* nios2-mm-enable-arch_has_vm_get_page_prot.patch
* hexagon-mm-enable-arch_has_vm_get_page_prot.patch
* nds32-mm-enable-arch_has_vm_get_page_prot.patch
* ia64-mm-enable-arch_has_vm_get_page_prot.patch
* mm-mmap-drop-generic-vm_get_page_prot.patch
* mm-mmap-drop-arch_has_vm_get_page_prot.patch
* mm-use-helper-function-range_in_vma.patch
* fix-shmem-huge-page-failed-to-set-f_seal_write-attribute-problem.patch
* mm-sparse-make-mminit_validate_memmodel_limits-static.patch
* mm-vmalloc-remove-unneeded-function-forward-declaration.patch
* mm-vmalloc-move-draining-areas-out-of-caller-context.patch
* mm-vmalloc-add-adjust_search_size-parameter.patch
* mm-vmalloc-eliminate-an-extra-orig_gfp_mask.patch
* mm-vmallocc-fix-unused-function-warning.patch
* vmap-dont-allow-invalid-pages.patch
* mm-page_alloc-avoid-merging-non-fallbackable-pageblocks-with-others.patch
* mm-page_alloc-add-same-penalty-is-enough-to-get-round-robin-order.patch
* mm-page_alloc-add-penalty-to-local_node.patch
* mm-mmzonec-use-try_cmpxchg-in-page_cpupid_xchg_last.patch
* mm-discard-__gfp_atomic.patch
* mm-mmzoneh-remove-unused-macros.patch
* mm-page_alloc-dont-pass-pfn-to-free_unref_page_commit.patch
* cma-factor-out-minimum-alignment-requirement.patch
* mm-enforce-pageblock_order-max_order.patch
* mm-page_alloc-mark-pagesets-as-__maybe_unused.patch
* mm-pages_allocc-dont-create-zone_movable-beyond-the-end-of-a-node.patch
* mm-page_alloc-fetch-the-correct-pcp-buddy-during-bulk-free.patch
* mm-page_alloc-track-range-of-active-pcp-lists-during-bulk-free.patch
* mm-page_alloc-simplify-how-many-pages-are-selected-per-pcp-list-during-bulk-free.patch
* mm-page_alloc-drain-the-requested-list-first-during-bulk-free.patch
* mm-page_alloc-free-pages-in-a-single-pass-during-bulk-free.patch
* mm-page_alloc-limit-number-of-high-order-pages-on-pcp-during-bulk-free.patch
* mm-page_alloc-do-not-prefetch-buddies-during-bulk-free.patch
* arch-x86-mm-numa-do-not-initialize-nodes-twice.patch
* arch-x86-mm-numa-do-not-initialize-nodes-twice-v2.patch
* mm-count-time-in-drain_all_pages-during-direct-reclaim-as-memory-pressure.patch
* mm-hwpoison-remove-obsolete-comment.patch
* mm-hwpoison-fix-error-page-recovered-but-reported-not-recovered.patch
* mm-clean-up-hwpoison-page-cache-page-in-fault-path.patch
* mm-memory-failurec-minor-clean-up-for-memory_failure_dev_pagemap.patch
* mm-memory-failurec-catch-unexpected-efault-from-vma_address.patch
* mm-memory-failurec-rework-the-signaling-logic-in-kill_proc.patch
* mm-memory-failurec-fix-race-with-changing-page-more-robustly.patch
* mm-memory-failurec-remove-pageslab-check-in-hwpoison_filter_dev.patch
* mm-memory-failurec-rework-the-try_to_unmap-logic-in-hwpoison_user_mappings.patch
* mm-memory-failurec-remove-obsolete-comment-in-__soft_offline_page.patch
* mm-memory-failurec-remove-unnecessary-pagetranstail-check.patch
* mm-hwpoison-inject-support-injecting-hwpoison-to-free-page.patch
* mm-hwpoison-inject-support-injecting-hwpoison-to-free-page-fix.patch
* mm-hwpoison-avoid-the-impact-of-hwpoison_filter-return-value-on-mce-handler.patch
* mm-hwpoison-add-in-use-hugepage-hwpoison-filter-judgement.patch
* mm-hugetlb-free-the-2nd-vmemmap-page-associated-with-each-hugetlb-page.patch
* mm-hugetlb-replace-hugetlb_free_vmemmap_enabled-with-a-static_key.patch
* mm-sparsemem-use-page-table-lock-to-protect-kernel-pmd-operations.patch
* selftests-vm-add-a-hugetlb-test-case.patch
* mm-sparsemem-move-vmemmap-related-to-hugetlb-to-config_hugetlb_page_free_vmemmap.patch
* mm-hugetlb-generalize-arch_want_general_hugetlb.patch
* hugetlb-clean-up-potential-spectre-issue-warnings.patch
* hugetlb-clean-up-potential-spectre-issue-warnings-v2.patch
* mm-hugetlb-use-helper-macro-__attr_rw.patch
* userfaultfd-provide-unmasked-address-on-page-fault.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt-fix.patch
* mm-migration-add-trace-events-for-thp-migrations.patch
* mm-migration-add-trace-events-for-base-page-and-hugetlb-migrations.patch
* mmmigrate-fix-establishing-demotion-target.patch
* mm-cma-provide-option-to-opt-out-from-exposing-pages-on-activation-failure.patch
* powerpc-fadump-opt-out-from-freeing-pages-on-cma-activation-failure.patch
* numa-balancing-add-page-promotion-counter.patch
* numa-balancing-optimize-page-placement-for-memory-tiering-system.patch
* memory-tiering-skip-to-scan-fast-memory.patch
* mm-page_io-fix-psi-memory-pressure-error-on-cold-swapins.patch
* mm-vmstat-add-event-for-ksm-swapping-in-copy.patch
* mm-ksm-use-helper-macro-__attr_rw.patch
* mm-hwpoison-check-the-subpage-not-the-head-page.patch
* mm-balloon_compaction-make-balloon-page-compaction-callbacks-static.patch
* mm-fix-race-between-madv_free-reclaim-and-blkdev-direct-io-read.patch
* mm-memory_hotplug-make-arch_alloc_nodedata-independent-on-config_memory_hotplug.patch
* mm-handle-uninitialized-numa-nodes-gracefully.patch
* mm-handle-uninitialized-numa-nodes-gracefully-fix.patch
* mm-memory_hotplug-drop-arch_free_nodedata.patch
* mm-memory_hotplug-reorganize-new-pgdat-initialization.patch
* mm-make-free_area_init_node-aware-of-memory-less-nodes.patch
* memcg-do-not-tweak-node-in-alloc_mem_cgroup_per_node_info.patch
* drivers-base-memory-add-memory-block-to-memory-group-after-registration-succeeded.patch
* drivers-base-node-consolidate-node-device-subsystem-initialization-in-node_dev_init.patch
* mm-memory_hotplug-remove-obsolete-comment-of-__add_pages.patch
* mm-memory_hotplug-remove-obsolete-comment-of-__add_pages-fix.patch
* mm-memory_hotplug-avoid-calling-zone_intersects-for-zone_normal.patch
* mm-memory_hotplug-clean-up-try_offline_node.patch
* mm-memory_hotplug-fix-misplaced-comment-in-offline_pages.patch
* drivers-base-node-rename-link_mem_sections-to-register_memory_block_under_node.patch
* drivers-base-memory-determine-and-store-zone-for-single-zone-memory-blocks.patch
* drivers-base-memory-clarify-adding-and-removing-of-memory-blocks.patch
* mm-rmap-convert-from-atomic_t-to-refcount_t-on-anon_vma-refcount.patch
* mm-zswapc-allow-handling-just-same-value-filled-pages.patch
* mm-remove-usercopy_warn.patch
* mm-uninline-copy_overflow.patch
* mm-usercopy-return-1-from-hardened_usercopy-__setup-handler.patch
* highmem-document-kunmap_local.patch
* highmem-document-kunmap_local-v2.patch
* mm-highmem-remove-unnecessary-done-label.patch
* mm-kfence-remove-unnecessary-config_kfence-option.patch
* mm-hmmc-remove-unneeded-local-variable-ret.patch
* mm-damon-dbgfs-init_regions-use-target-index-instead-of-target-id.patch
* docs-admin-guide-mm-damon-usage-update-for-changed-initail_regions-file-input.patch
* mm-damon-core-move-damon_set_targets-into-dbgfs.patch
* mm-damon-remove-the-target-id-concept.patch
* mm-damon-remove-redundant-page-validation.patch
* mm-damon-rename-damon_primitives-to-damon_operations.patch
* mm-damon-let-monitoring-operations-can-be-registered-and-selected.patch
* mm-damon-paddrvaddr-register-themselves-to-damon-in-subsys_initcall.patch
* mm-damon-reclaim-use-damon_select_ops-instead-of-damon_vpa_set_operations.patch
* mm-damon-dbgfs-use-damon_select_ops-instead-of-damon_vpa_set_operations.patch
* mm-damon-dbgfs-use-operations-id-for-knowing-if-the-target-has-pid.patch
* mm-damon-dbgfs-test-fix-is_target_id-change.patch
* mm-damon-paddrvaddr-remove-damon_pva_target_validset_operations.patch
* mm-damon-remove-unnecessary-config_damon-option.patch
* docs-vm-damon-call-low-level-monitoring-primitives-the-operations.patch
* docs-vm-damon-design-update-damon-idle-page-tracking-interference-handling.patch
* docs-damon-update-outdated-term-regions-update-interval.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-alloc-path_max-bytes-for-proc-pid-fd-symlinks.patch
* proc-alloc-path_max-bytes-for-proc-pid-fd-symlinks-fix.patch
* proc-vmcore-fix-possible-deadlock-on-concurrent-mmap-and-read.patch
* proc-vmcore-fix-vmcore_alloc_buf-kernel-doc-comment.patch
* proc-sysctl-make-protected_-world-readable.patch
* kernel-ksysfsc-use-helper-macro-__attr_rw.patch
* kconfigdebug-make-debug_info-selectable-from-a-choice.patch
* kconfigdebug-make-debug_info-selectable-from-a-choice-fix.patch
* include-drop-pointless-__compiler_offsetof-indirection.patch
* ilog2-force-inlining-of-__ilog2_u32-and-__ilog2_u64.patch
* bitfield-add-explicit-inclusions-to-the-example.patch
* lz4-fix-lz4_decompress_safe_partial-read-out-of-bound.patch
* checkpatch-prefer-module_licensegpl-over-module_licensegpl-v2.patch
* checkpatch-add-fix-option-for-some-trailing_statements.patch
* checkpatch-add-early_param-exception-to-blank-line-after-struct-function-test.patch
* fs-binfmt_elf-fix-at_phdr-for-unusual-elf-files.patch
* fs-binfmt_elf-fix-at_phdr-for-unusual-elf-files-v5.patch
* fs-binfmt_elf-refactor-load_elf_binary-function.patch
* elf-fix-overflow-in-total-mapping-size-calculation.patch
* binfmt-move-more-stuff-undef-config_coredump.patch
* kallsyms-print-module-name-in-%ps-s-case-when-kallsyms-is-disabled.patch
* init-use-ktime_us_delta-to-make-initcall_debug-log-more-precise.patch
* inith-improve-__setup-and-early_param-documentation.patch
* init-mainc-return-1-from-handled-__setup-functions.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* fs-pipe-use-kvcalloc-to-allocate-a-pipe_buffer-array.patch
* fs-pipe-local-vars-has-to-match-types-of-proper-pipe_inode_info-fields.patch
* minix-fix-bug-when-opening-a-file-with-o_direct.patch
* fat-use-pointer-to-simple-type-in-put_user.patch
* exec-force-single-empty-string-when-argv-is-empty.patch
* exec-force-single-empty-string-when-argv-is-empty-fix.patch
* selftests-exec-test-for-empty-string-on-null-argv.patch
* kexec-make-crashk_res-crashk_low_res-and-crash_notes-symbols-always-visible.patch
* riscv-mm-init-use-is_enabledconfig_kexec_core-instead-of-ifdef.patch
* x86-setup-use-is_enabledconfig_kexec_core-instead-of-ifdef.patch
* arm64-mm-use-is_enabledconfig_kexec_core-instead-of-ifdef.patch
* docs-kdump-update-description-about-sysfs-file-system-support.patch
* docs-kdump-add-scp-example-to-write-out-the-dump-file.patch
* panic-unset-panic_on_warn-inside-panic.patch
* ubsan-no-need-to-unset-panic_on_warn-in-ubsan_epilogue.patch
* kasan-no-need-to-unset-panic_on_warn-in-end_report.patch
* docs-sysctl-kernel-add-missing-bit-to-panic_print.patch
* docs-sysctl-kernel-add-missing-bit-to-panic_print-fix.patch
* panic-add-option-to-dump-all-cpus-backtraces-in-panic_print.patch
* kcov-split-ioctl-handling-into-locked-and-unlocked-parts.patch
* kcov-properly-handle-subsequent-mmap-calls.patch
* kernel-resource-fix-kfree-of-bootmem-memory-again.patch
* revert-ubsan-kcsan-dont-combine-sanitizer-with-kcov-on-clang.patch
* ipc-mqueue-use-get_tree_nodev-in-mqueue_get_tree.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
  drivers-gpu-drm-dp-drm_dpc-fix-build.patch
* kasan-page_alloc-deduplicate-should_skip_kasan_poison.patch
* kasan-page_alloc-move-tag_clear_highpage-out-of-kernel_init_free_pages.patch
* kasan-page_alloc-merge-kasan_free_pages-into-free_pages_prepare.patch
* kasan-page_alloc-simplify-kasan_poison_pages-call-site.patch
* kasan-page_alloc-init-memory-of-skipped-pages-on-free.patch
* kasan-drop-skip_kasan_poison-variable-in-free_pages_prepare.patch
* mm-clarify-__gfp_zerotags-comment.patch
* kasan-only-apply-__gfp_zerotags-when-memory-is-zeroed.patch
* kasan-page_alloc-refactor-init-checks-in-post_alloc_hook.patch
* kasan-page_alloc-merge-kasan_alloc_pages-into-post_alloc_hook.patch
* kasan-page_alloc-combine-tag_clear_highpage-calls-in-post_alloc_hook.patch
* kasan-page_alloc-move-setpageskipkasanpoison-in-post_alloc_hook.patch
* kasan-page_alloc-move-kernel_init_free_pages-in-post_alloc_hook.patch
* kasan-page_alloc-rework-kasan_unpoison_pages-call-site.patch
* kasan-clean-up-metadata-byte-definitions.patch
* kasan-define-kasan_vmalloc_invalid-for-sw_tags.patch
* kasan-x86-arm64-s390-rename-functions-for-modules-shadow.patch
* kasan-vmalloc-drop-outdated-vm_kasan-comment.patch
* kasan-reorder-vmalloc-hooks.patch
* kasan-add-wrappers-for-vmalloc-hooks.patch
* kasan-vmalloc-reset-tags-in-vmalloc-functions.patch
* kasan-fork-reset-pointer-tags-of-vmapped-stacks.patch
* kasan-arm64-reset-pointer-tags-of-vmapped-stacks.patch
* kasan-fork-reset-pointer-tags-of-vmapped-stacks-fix.patch
* kasan-vmalloc-add-vmalloc-tagging-for-sw_tags.patch
* kasan-vmalloc-arm64-mark-vmalloc-mappings-as-pgprot_tagged.patch
* kasan-vmalloc-unpoison-vm_alloc-pages-after-mapping.patch
* kasan-mm-only-define-___gfp_skip_kasan_poison-with-hw_tags.patch
* kasan-page_alloc-allow-skipping-unpoisoning-for-hw_tags.patch
* kasan-page_alloc-allow-skipping-memory-init-for-hw_tags.patch
* kasan-vmalloc-add-vmalloc-tagging-for-hw_tags.patch
* kasan-vmalloc-only-tag-normal-vmalloc-allocations.patch
* kasan-arm64-dont-tag-executable-vmalloc-allocations.patch
* kasan-mark-kasan_arg_stacktrace-as-__initdata.patch
* kasan-clean-up-feature-flags-for-hw_tags-mode.patch
* kasan-add-kasanvmalloc-command-line-flag.patch
* kasan-allow-enabling-kasan_vmalloc-and-sw-hw_tags.patch
* arm64-select-kasan_vmalloc-for-sw-hw_tags-modes.patch
* kasan-documentation-updates.patch
* kasan-improve-vmalloc-tests.patch
* kasan-improve-vmalloc-tests-fix.patch
* kasan-improve-vmalloc-tests-fix-2.patch
* kasan-improve-vmalloc-tests-fix-3.patch
* kasan-improve-vmalloc-tests-fix-3-fix.patch
* kasan-test-support-async-again-and-asymm-modes-for-hw_tags.patch
* mm-kasan-remove-unnecessary-config_kasan-option.patch
* kasan-update-function-name-in-comments.patch
* kasan-print-virtual-mapping-info-in-reports.patch
* mm-rmap-fix-argument-list-that-the-kdoc-format-and-script-verified.patch
* mm-enable-madv_dontneed-for-hugetlb-mappings.patch
* selftests-vm-add-hugetlb-madvise-madv_dontneed-madv_remove-test.patch
* userfaultfd-selftests-enable-hugetlb-remap-and-remove-event-testing.patch
* mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
* mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
* mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
* mm-streamline-cow-logic-in-do_swap_page.patch
* mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
* mm-khugepaged-remove-reuse_swap_page-usage.patch
* mm-swapfile-remove-stale-reuse_swap_page.patch
* mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
* selftests-vm-remove-dependecy-from-internal-kernel-macros.patch
* selftests-kselftest-framework-provide-finished-helper.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  mutex-subsystem-synchro-test-module-fix.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
