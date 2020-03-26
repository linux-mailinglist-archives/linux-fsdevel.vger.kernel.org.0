Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD6194A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 22:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCZVRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 17:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbgCZVRK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:17:10 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF9420714;
        Thu, 26 Mar 2020 21:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585257427;
        bh=vksf0+a2jcYsRZHNlqfAjp/5SL6Kfl2tGVOWKbnxhjg=;
        h=Date:From:To:Subject:From;
        b=zadGsAgMdk6sdbhB8fj8T4Ps2BrNVVltJIB0pYdLlobxyG45m8yEmm2kqLZ3TKOlR
         7PGs8OaW2TSXC9SyJvf5A42lOI9moFHs1AMdZeRdI2ZCKpwpCwOy2daa+ayDd9SMZE
         kIx8HbCqIOAZcHmffzcnrX4Ci/n+ma26f/uwwrvQ=
Date:   Thu, 26 Mar 2020 14:17:07 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-03-26-14-16 uploaded
Message-ID: <20200326211707.4pYXqY9rU%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-03-26-14-16 has been uploaded to

   http://www.ozlabs.org/~akpm/mmotm/

mmotm-readme.txt says

README for mm-of-the-moment:

http://www.ozlabs.org/~akpm/mmotm/

This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
more than once a week.

You will need quilt to apply these patches to the latest Linus release (5.x
or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
http://ozlabs.org/~akpm/mmotm/series

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

The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
contains daily snapshots of the -mm tree.  It is updated more frequently
than mmotm, and is untested.

A git copy of this tree is also available at

	https://github.com/hnaz/linux-mm



This mmotm tree contains the following patches against 5.6-rc7:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-swap-move-inode_lock-out-of-claim_swapfile.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* hugetlb_cgroup-fix-illegal-access-to-memory.patch
* mm-fork-fix-kernel_stack-memcg-stats-for-various-stack-implementations.patch
* mm-fork-fix-kernel_stack-memcg-stats-for-various-stack-implementations-v2.patch
* mm-sparse-fix-kernel-crash-with-pfn_section_valid-check.patch
* mm-sparse-fix-kernel-crash-with-pfn_section_valid-check-v2.patch
* ipc-mqueuec-change-__do_notify-to-bypass-check_kill_permission.patch
* kthread-mark-timer-used-by-delayed-kthread-works-as-irq-safe.patch
* drivers-infiniband-sw-siw-siw_qp_rxc-suppress-uninitialized-var-warning.patch
* asm-generic-make-more-kernel-space-headers-mandatory.patch
* scripts-spellingtxt-add-syfs-sysfs-pattern.patch
* scripts-spellingtxt-add-more-spellings-to-spellingtxt.patch
* ocfs2-remove-fs_ocfs2_nm.patch
* ocfs2-remove-unused-macros.patch
* ocfs2-use-ocfs2_sec_bits-in-macro.patch
* ocfs2-remove-dlm_lock_is_remote.patch
* ocfs2-there-is-no-need-to-log-twice-in-several-functions.patch
* ocfs2-correct-annotation-from-l_next_rec-to-l_next_free_rec.patch
* ocfs2-remove-useless-err.patch
* ocfs2-add-missing-annotations-for-ocfs2_refcount_cache_lock-and-ocfs2_refcount_cache_unlock.patch
* ocfs2-replace-zero-length-array-with-flexible-array-member.patch
* ocfs2-cluster-replace-zero-length-array-with-flexible-array-member.patch
* ocfs2-dlm-replace-zero-length-array-with-flexible-array-member.patch
* ocfs2-ocfs2_fsh-replace-zero-length-array-with-flexible-array-member.patch
* ocfs2-roll-back-the-reference-count-modification-of-the-parent-directory-if-an-error-occurs.patch
* ocfs2-use-scnprintf-for-avoiding-potential-buffer-overflow.patch
* drivers-tty-serial-sh-scic-suppress-uninitialized-var-warning.patch
* ramfs-support-o_tmpfile.patch
* fs_parse-remove-pr_notice-about-each-validation.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-slubc-replace-cpu_slab-partial-with-wrapped-apis.patch
* mm-slubc-replace-kmem_cache-cpu_partial-with-wrapped-apis.patch
* slub-improve-bit-diffusion-for-freelist-ptr-obfuscation.patch
* slub-relocate-freelist-pointer-to-middle-of-object.patch
* revert-topology-add-support-for-node_to_mem_node-to-determine-the-fallback-node.patch
* mm-kmemleak-use-address-of-operator-on-section-symbols.patch
* mm-disable-kcsan-for-kmemleak.patch
* mm-dont-bother-dropping-mmap_sem-for-zero-size-readahead.patch
* mm-page-writebackc-write_cache_pages-deduplicate-identical-checks.patch
* mm-filemapc-clear-page-error-before-actual-read.patch
* mm-filemapc-remove-unused-argument-from-shrink_readahead_size_eio.patch
* mm-use-vm_fault-error-code-directly.patch
* mm-rename-arguments-to-find_subpage.patch
* mm-use-vm_bug_on_page-in-clear_page_dirty_for_io.patch
* mm-unexport-find_get_entry.patch
* mm-rewrite-pagecache_get_page-documentation.patch
* mm-gup-split-get_user_pages_remote-into-two-routines.patch
* mm-gup-pass-a-flags-arg-to-__gup_device_-functions.patch
* mm-introduce-page_ref_sub_return.patch
* mm-gup-pass-gup-flags-to-two-more-routines.patch
* mm-gup-require-foll_get-for-get_user_pages_fast.patch
* mm-gup-track-foll_pin-pages.patch
* mm-gup-track-foll_pin-pages-fix.patch
* mm-gup-track-foll_pin-pages-fix-2.patch
* mm-gup-track-foll_pin-pages-fix-2-fix.patch
* mm-gup-page-hpage_pinned_refcount-exact-pin-counts-for-huge-pages.patch
* mm-gup-proc-vmstat-pin_user_pages-foll_pin-reporting.patch
* mm-gup_benchmark-support-pin_user_pages-and-related-calls.patch
* selftests-vm-run_vmtests-invoke-gup_benchmark-with-basic-foll_pin-coverage.patch
* mm-improve-dump_page-for-compound-pages.patch
* mm-dump_page-additional-diagnostics-for-huge-pinned-pages.patch
* mm-gup-writeback-add-callbacks-for-inaccessible-pages.patch
* mm-gup-rename-nr-as-nr_pinned-in-get_user_pages_fast.patch
* mm-gup-fix-omission-of-check-on-foll_longterm-in-gup-fast-path.patch
* mm-swapfilec-fix-comments-for-swapcache_prepare.patch
* mm-swapc-not-necessary-to-export-__pagevec_lru_add.patch
* mm-swapfile-fix-data-races-in-try_to_unuse.patch
* mm-swap_slotsc-assignreset-cache-slot-by-value-directly.patch
* mm-swap-make-page_evictable-inline.patch
* mm-swap-make-page_evictable-inline-fix.patch
* mm-swap-use-smp_mb__after_atomic-to-order-lru-bit-set.patch
* mm-swap_statec-use-the-same-way-to-count-page-in-_swap_cache.patch
* mm-memcg-fix-build-error-around-the-usage-of-kmem_caches.patch
* mm-allocate-shrinker_map-on-appropriate-numa-node.patch
* mm-memcg-slab-introduce-mem_cgroup_from_obj.patch
* mm-kmem-cleanup-__memcg_kmem_charge_memcg-arguments.patch
* mm-kmem-cleanup-memcg_kmem_uncharge_memcg-arguments.patch
* mm-kmem-rename-memcg_kmem_uncharge-into-memcg_kmem_uncharge_page.patch
* mm-kmem-switch-to-nr_pages-in-__memcg_kmem_charge_memcg.patch
* mm-memcg-slab-cache-page-number-in-memcg_uncharge_slab.patch
* mm-kmem-rename-__memcg_kmem_uncharge_memcg-to-__memcg_kmem_uncharge.patch
* mm-memcontrol-fix-memorylow-proportional-distribution.patch
* mm-memcontrol-clean-up-and-document-effective-low-min-calculations.patch
* mm-memcontrol-recursive-memorylow-protection.patch
* memcg-css_tryget_online-cleanups.patch
* mm-make-mem_cgroup_id_get_many-__maybe_unused.patch
* memcg-optimize-memorynuma_stat-like-memorystat.patch
* memcg-optimize-memorynuma_stat-like-memorystat-fix.patch
* mm-memcg-prevent-memoryhigh-load-store-tearing.patch
* mm-memcg-prevent-memorymax-load-tearing.patch
* mm-memcg-prevent-memorylow-load-store-tearing.patch
* mm-memcg-prevent-memorymin-load-store-tearing.patch
* mm-memcg-prevent-memoryswapmax-load-tearing.patch
* mm-memcg-prevent-mem_cgroup_protected-store-tearing.patch
* mm-memcg-bypass-high-reclaim-iteration-for-cgroup-hierarchy-root.patch
* mm-memcg-make-memoryoomgroup-tolerable-to-task-migration.patch
* mm-mapping_dirty_helpers-update-huge-page-table-entry-callbacks.patch
* mm-dont-prepare-anon_vma-if-vma-has-vm_wipeonfork.patch
* revert-mm-rmapc-reuse-mergeable-anon_vma-as-parent-when-fork.patch
* mm-set-vm_next-and-vm_prev-to-null-in-vm_area_dup.patch
* mm-vma-add-missing-vma-flag-readable-name-for-vm_sync.patch
* mm-vma-make-vma_is_accessible-available-for-general-use.patch
* mm-vma-replace-all-remaining-open-encodings-with-is_vm_hugetlb_page.patch
* mm-vma-replace-all-remaining-open-encodings-with-vma_is_anonymous.patch
* mm-vma-append-unlikely-while-testing-vma-access-permissions.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-vma-move-vm_no_khugepaged-into-generic-header.patch
* mm-vma-make-vma_is_foreign-available-for-general-use.patch
* mm-vma-make-is_vma_temporary_stack-available-for-general-use.patch
* mm-add-pagemaph-to-the-fine-documentation.patch
* mm-gup-rename-nonblocking-to-locked-where-proper.patch
* mm-gup-fix-__get_user_pages-on-fault-retry-of-hugetlb.patch
* mm-introduce-fault_signal_pending.patch
* mm-introduce-fault_signal_pending-fix.patch
* x86-mm-use-helper-fault_signal_pending.patch
* arc-mm-use-helper-fault_signal_pending.patch
* arm64-mm-use-helper-fault_signal_pending.patch
* powerpc-mm-use-helper-fault_signal_pending.patch
* sh-mm-use-helper-fault_signal_pending.patch
* mm-return-faster-for-non-fatal-signals-in-user-mode-faults.patch
* userfaultfd-dont-retake-mmap_sem-to-emulate-nopage.patch
* mm-introduce-fault_flag_default.patch
* mm-introduce-fault_flag_interruptible.patch
* mm-allow-vm_fault_retry-for-multiple-times.patch
* mm-gup-allow-vm_fault_retry-for-multiple-times.patch
* mm-gup-allow-to-react-to-fatal-signals.patch
* mm-userfaultfd-honor-fault_flag_killable-in-fault-path.patch
* mm-clarify-a-confusing-comment-of-remap_pfn_range.patch
* mm-clarify-a-confusing-comment-for-vm_iomap_memory.patch
* mmap-remove-inline-of-vm_unmapped_area.patch
* mm-mmap-add-trace-point-of-vm_unmapped_area.patch
* mm-add-mremap_dontunmap-to-mremap.patch
* mm-add-mremap_dontunmap-to-mremap-v6.patch
* mm-add-mremap_dontunmap-to-mremap-v7.patch
* selftest-add-mremap_dontunmap-selftest.patch
* selftest-add-mremap_dontunmap-selftest-fix.patch
* selftest-add-mremap_dontunmap-selftest-v7.patch
* selftest-add-mremap_dontunmap-selftest-v7-checkpatch-fixes.patch
* mm-sparsemem-get-address-to-page-struct-instead-of-address-to-pfn.patch
* mm-sparse-rename-pfn_present-as-pfn_in_present_section.patch
* mm-sparsec-use-kvmalloc-kvfree-to-alloc-free-memmap-for-the-classic-sparse.patch
* mm-sparsec-allocate-memmap-preferring-the-given-node.patch
* kasan-detect-negative-size-in-memory-operation-function.patch
* kasan-detect-negative-size-in-memory-operation-function-fix.patch
* kasan-detect-negative-size-in-memory-operation-function-fix-2.patch
* kasan-add-test-for-invalid-size-in-memmove.patch
* kasan-fix-wstringop-overflow-warning.patch
* mm-page_alloc-increase-default-min_free_kbytes-bound.patch
* mm-micro-optimisation-save-two-branches-on-hot-page-allocation-path.patch
* mmpage_alloccma-conditionally-prefer-cma-pageblocks-for-movable-allocations.patch
* mmpage_alloccma-conditionally-prefer-cma-pageblocks-for-movable-allocations-fix.patch
* mm-page_alloc-use-free_area_empty-instead-of-open-coding.patch
* mm-page_allocc-micro-optimisation-remove-unnecessary-branch.patch
* mm-fix-tick-timer-stall-during-deferred-page-init.patch
* mm-page_alloc-simplify-page_is_buddy-for-better-code-readability.patch
* mm-vmpressure-dont-need-call-kfree-if-kstrndup-fails.patch
* mm-vmpressure-use-mem_cgroup_is_root-api.patch
* mm-vmscan-replace-open-codings-to-numa_no_node.patch
* mm-vmscanc-remove-cpu-online-notification-for-now.patch
* mm-vmscan-fix-data-races-at-kswapd_classzone_idx.patch
* mm-vmscanc-clean-code-by-removing-unnecessary-assignment.patch
* mm-make-may_enter_fs-bool-in-shrink_page_list.patch
* mm-vmscanc-do_try_to_free_pages-clean-code-by-removing-unnecessary-assignment.patch
* selftests-vm-drop-dependencies-on-page-flags-from-mlock2-tests.patch
* mmcompactioncma-add-alloc_contig-flag-to-compact_control.patch
* mmthpcompactioncma-allow-thp-migration-for-cma-allocations.patch
* mmthpcompactioncma-allow-thp-migration-for-cma-allocations-fix.patch
* mm-compaction-fully-assume-capture-is-not-null-in-compact_zone_order.patch
* really-limit-compact_unevictable_allowed-to-0-and-1.patch
* mm-compaction-disable-compact_unevictable_allowed-on-rt.patch
* mm-compaction-disable-compact_unevictable_allowed-on-rt-v5.patch
* mm-compactionc-clean-code-by-removing-unnecessary-assignment.patch
* mm-mempolicy-support-mpol_mf_strict-for-huge-page-mapping.patch
* mm-mempolicy-checking-hugepage-migration-is-supported-by-arch-in-vma_migratable.patch
* mm-mempolicy-use-vm_bug_on_vma-in-queue_pages_test_walk.patch
* mm-mempolicy-require-at-least-one-nodeid-for-mpol_preferred.patch
* mm-memblock-remove-redundant-assignment-to-variable-max_addr.patch
* hugetlbfs-use-i_mmap_rwsem-for-more-pmd-sharing-synchronization.patch
* hugetlbfs-use-i_mmap_rwsem-to-address-page-fault-truncate-race.patch
* hugetlb_cgroup-add-hugetlb_cgroup-reservation-counter.patch
* hugetlb_cgroup-add-interface-for-charge-uncharge-hugetlb-reservations.patch
* mm-hugetlb_cgroup-fix-hugetlb_cgroup-migration.patch
* hugetlb_cgroup-add-reservation-accounting-for-private-mappings.patch
* hugetlb_cgroup-add-reservation-accounting-for-private-mappings-fix.patch
* hugetlb-disable-region_add-file_region-coalescing.patch
* hugetlb-disable-region_add-file_region-coalescing-fix.patch
* hugetlb_cgroup-add-accounting-for-shared-mappings.patch
* hugetlb_cgroup-add-accounting-for-shared-mappings-fix.patch
* hugetlb_cgroup-support-noreserve-mappings.patch
* hugetlb-support-file_region-coalescing-again.patch
* hugetlb-support-file_region-coalescing-again-fix.patch
* hugetlb-support-file_region-coalescing-again-fix-2.patch
* hugetlb_cgroup-add-hugetlb_cgroup-reservation-tests.patch
* hugetlb_cgroup-add-hugetlb_cgroup-reservation-docs.patch
* mm-hugetlbc-clean-code-by-removing-unnecessary-initialization.patch
* mm-hugetlb-remove-unnecessary-memory-fetch-in-pageheadhuge.patch
* mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma.patch
* mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma-fix.patch
* mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma-fix-2.patch
* selftests-vm-fix-map_hugetlb-length-used-for-testing-read-and-write.patch
* mm-hugetlb-fix-build-failure-with-hugetlb_page-but-not-hugebtlbfs.patch
* mm-hugetlb-fix-hugetlb_cma_reserve-if-config_numa-isnt-set.patch
* mm-hugetlbc-fix-printk-format-warning-for-32-bit-phys_addr_t.patch
* mm-hugetlbc-fix-printk-format-warning-for-32-bit-phys_addr_t-fix.patch
* mm-check-pagetail-in-hpage_nr_pages-even-when-thp.patch
* mm-migratec-no-need-to-check-for-i-start-in-do_pages_move.patch
* mm-migratec-wrap-do_move_pages_to_node-and-store_status.patch
* mm-migratec-check-pagelist-in-move_pages_and_store_status.patch
* mm-migratec-unify-not-queued-for-migration-handling-in-do_pages_move.patch
* mm-migratec-migrate-pg_readahead-flag.patch
* mm-migratec-migrate-pg_readahead-flag-fix.patch
* mm-shmem-add-vmstat-for-hugepage-fallback.patch
* mm-thp-track-fallbacks-due-to-failed-memcg-charges-separately.patch
* mm-optimise-find_subpage-for-thp.patch
* mm-remove-config_transparent_huge_pagecache.patch
* mm-ksmc-update-get_user_pages-in-comment.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup-fix.patch
* mm-code-cleanup-for-madv_free.patch
* mm-adjust-shuffle-code-to-allow-for-future-coalescing.patch
* mm-use-zone-and-order-instead-of-free-area-in-free_list-manipulators.patch
* mm-add-function-__putback_isolated_page.patch
* mm-introduce-reported-pages.patch
* virtio-balloon-pull-page-poisoning-config-out-of-free-page-hinting.patch
* virtio-balloon-add-support-for-providing-free-page-reports-to-host.patch
* mm-page_reporting-rotate-reported-pages-to-the-tail-of-the-list.patch
* mm-page_reporting-add-budget-limit-on-how-many-pages-can-be-reported-per-pass.patch
* mm-page_reporting-add-free-page-reporting-documentation.patch
* virtio-balloon-switch-back-to-oom-handler-for-virtio_balloon_f_deflate_on_oom.patch
* userfaultfd-wp-add-helper-for-writeprotect-check.patch
* userfaultfd-wp-hook-userfault-handler-to-write-protection-fault.patch
* userfaultfd-wp-add-wp-pagetable-tracking-to-x86.patch
* userfaultfd-wp-userfaultfd_pte-huge_pmd_wp-helpers.patch
* userfaultfd-wp-add-uffdio_copy_mode_wp.patch
* mm-merge-parameters-for-change_protection.patch
* userfaultfd-wp-apply-_page_uffd_wp-bit.patch
* userfaultfd-wp-drop-_page_uffd_wp-properly-when-fork.patch
* userfaultfd-wp-add-pmd_swp_uffd_wp-helpers.patch
* userfaultfd-wp-support-swap-and-page-migration.patch
* khugepaged-skip-collapse-if-uffd-wp-detected.patch
* userfaultfd-wp-support-write-protection-for-userfault-vma-range.patch
* userfaultfd-wp-add-the-writeprotect-api-to-userfaultfd-ioctl.patch
* userfaultfd-wp-enabled-write-protection-in-userfaultfd-api.patch
* userfaultfd-wp-dont-wake-up-when-doing-write-protect.patch
* userfaultfd-wp-uffdio_register_mode_wp-documentation-update.patch
* userfaultfd-wp-declare-_uffdio_writeprotect-conditionally.patch
* userfaultfd-selftests-refactor-statistics.patch
* userfaultfd-selftests-add-write-protect-test.patch
* drivers-base-memoryc-indicate-all-memory-blocks-as-removable.patch
* drivers-base-memoryc-drop-section_count.patch
* drivers-base-memoryc-drop-pages_correctly_probed.patch
* mm-page_extc-drop-pfn_present-check-when-onlining.patch
* mm-hotplug-only-respect-mem=-parameter-during-boot-stage.patch
* mm-memory_hotplug-simplify-calculation-of-number-of-pages-in-__remove_pages.patch
* mm-memory_hotplug-cleanup-__add_pages.patch
* mm-sparsec-introduce-new-function-fill_subsection_map.patch
* mm-sparsec-introduce-a-new-function-clear_subsection_map.patch
* mm-sparsec-only-use-subsection-map-in-vmemmap-case.patch
* mm-sparsec-add-note-about-only-vmemmap-supporting-sub-section-hotplug.patch
* mm-sparsec-move-subsection_map-related-functions-together.patch
* mm-sparsec-move-subsection_map-related-functions-together-fix.patch
* drivers-base-memory-rename-mmop_online_keep-to-mmop_online.patch
* drivers-base-memory-map-mmop_offline-to-0.patch
* drivers-base-memory-store-mapping-between-mmop_-and-string-in-an-array.patch
* powernv-memtrace-always-online-added-memory-blocks.patch
* hv_balloon-dont-check-for-memhp_auto_online-manually.patch
* hv_balloon-dont-check-for-memhp_auto_online-manually-fix.patch
* mm-memory_hotplug-unexport-memhp_auto_online.patch
* mm-memory_hotplug-convert-memhp_auto_online-to-store-an-online_type.patch
* mm-memory_hotplug-allow-to-specify-a-default-online_type.patch
* mm-memory_hotplug-use-__pfn_to_section-instead-of-open-coding.patch
* shmem-distribute-switch-variables-for-initialization.patch
* mm-shmemc-clean-code-by-removing-unnecessary-assignment.patch
* huge-tmpfs-try-to-split_huge_page-when-punching-hole.patch
* mm-elide-a-warning-when-casting-void-enum.patch
* zswap-allow-setting-default-status-compressor-and-allocator-in-kconfig.patch
* mm-compaction-add-missing-annotation-for-compact_lock_irqsave.patch
* mm-hugetlb-add-missing-annotation-for-gather_surplus_pages.patch
* mm-mempolicy-add-missing-annotation-for-queue_pages_pmd.patch
* mm-slub-add-missing-annotation-for-get_map.patch
* mm-slub-add-missing-annotation-for-put_map.patch
* mm-zsmalloc-add-missing-annotation-for-migrate_read_lock.patch
* mm-zsmalloc-add-missing-annotation-for-migrate_read_unlock.patch
* mm-zsmalloc-add-missing-annotation-for-pin_tag.patch
* mm-zsmalloc-add-missing-annotation-for-unpin_tag.patch
* mm-fix-ambiguous-comments-for-better-code-readability.patch
* mm-mm_initc-clean-code-use-build_bug_on-when-comparing-compile-time-constant.patch
* mm-use-fallthrough.patch
* mm-correct-guards-for-non_swap_entry.patch
* memremap-remove-stale-comments.patch
* mm-dmapoolc-micro-optimisation-remove-unnecessary-branch.patch
* mm-remove-dummy-struct-bootmem_data-bootmem_data_t.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-annotate-close_pdeo-for-sparse.patch
* proc-faster-open-read-close-with-permanent-files.patch
* proc-faster-open-read-close-with-permanent-files-checkpatch-fixes.patch
* proc-speed-up-proc-statm.patch
* proc-inline-vma_stop-into-m_stop.patch
* proc-remove-m_cache_vma.patch
* proc-use-ppos-instead-of-m-version.patch
* seq_file-remove-m-version.patch
* proc-inline-m_next_vma-into-m_next.patch
* asm-generic-fix-unistd_32h-generation-format.patch
* kernel-extable-use-address-of-operator-on-section-symbols.patch
* sparcx86-vdso-remove-meaningless-undefining-config_optimize_inlining.patch
* compiler-remove-config_optimize_inlining-entirely.patch
* maintainers-add-an-entry-for-kfifo.patch
* bitops-always-inline-sign-extension-helpers.patch
* lib-test_lockup-test-module-to-generate-lockups.patch
* lib-test_lockup-test-module-to-generate-lockups-fix.patch
* lib-test_lockup-fix-spelling-mistake-iteraions-iterations.patch
* lib-test_lockup-add-parameters-for-locking-generic-vfs-locks.patch
* lib-bch-replace-zero-length-array-with-flexible-array-member.patch
* lib-ts_bm-replace-zero-length-array-with-flexible-array-member.patch
* lib-ts_fsm-replace-zero-length-array-with-flexible-array-member.patch
* lib-ts_kmp-replace-zero-length-array-with-flexible-array-member.patch
* lib-scatterlist-fix-sg_copy_buffer-kerneldoc.patch
* lib-test_stackinitc-xfail-switch-variable-init-tests.patch
* stackdepot-check-depot_index-before-accessing-the-stack-slab.patch
* stackdepot-check-depot_index-before-accessing-the-stack-slab-fix.patch
* stackdepot-build-with-fno-builtin.patch
* kasan-stackdepot-move-filter_irq_stacks-to-stackdepotc.patch
* kasan-stackdepot-move-filter_irq_stacks-to-stackdepotc-fix-1.patch
* kasan-stackdepot-move-filter_irq_stacks-to-stackdepotc-fix-2.patch
* percpu_counter-fix-a-data-race-at-vm_committed_as.patch
* lib-test_bitmap-make-use-of-exp2_in_bits.patch
* lib-rbtree-fix-coding-style-of-assignments.patch
* lib-test_kmod-remove-a-null-test.patch
* linux-bitsh-add-compile-time-sanity-check-of-genmask-inputs.patch
* lib-optimize-cpumask_local_spread.patch
* list-prevent-compiler-reloads-inside-safe-list-iteration.patch
* dynamic_debug-use-address-of-operator-on-section-symbols.patch
* checkpatch-remove-email-address-comment-from-email-address-comparisons.patch
* checkpatch-check-spdx-tags-in-yaml-files.patch
* checkpatch-support-base-commit-format.patch
* checkpatch-prefer-fallthrough-over-fallthrough-comments.patch
* checkpatch-fix-minor-typo-and-mixed-spacetab-in-indentation.patch
* checkpatch-fix-multiple-const-types.patch
* checkpatch-add-command-line-option-for-tab-size.patch
* checkpatch-improve-gerrit-change-id-test.patch
* checkpatch-check-proper-licensing-of-devicetree-bindings.patch
* checkpatch-avoid-warning-about-uninitialized_var.patch
* kselftest-introduce-new-epoll-test-case.patch
* fs-epoll-make-nesting-accounting-safe-for-rt-kernel.patch
* elf-delete-loc-variable.patch
* elf-allocate-less-for-static-executable.patch
* elf-dont-free-interpreters-elf-pheaders-on-common-path.patch
* samples-hw_breakpoint-drop-hw_breakpoint_r-when-reporting-writes.patch
* samples-hw_breakpoint-drop-use-of-kallsyms_lookup_name.patch
* kallsyms-unexport-kallsyms_lookup_name-and-kallsyms_on_each_symbol.patch
* reiserfs-clean-up-several-indentation-issues.patch
* gcov-gcc_4_7-replace-zero-length-array-with-flexible-array-member.patch
* gcov-gcc_3_4-replace-zero-length-array-with-flexible-array-member.patch
* gcov-fs-replace-zero-length-array-with-flexible-array-member.patch
* kernel-relayc-fix-read_pos-error-when-multiple-readers.patch
* aio-simplify-read_events.patch
* init-cleanup-anon_inodes-and-old-io-schedulers-options.patch
* kcov-cleanup-debug-messages.patch
* kcov-fix-potential-use-after-free-in-kcov_remote_start.patch
* kcov-move-t-kcov-assignments-into-kcov_start-stop.patch
* kcov-move-t-kcov_sequence-assignment.patch
* kcov-use-t-kcov_mode-as-enabled-indicator.patch
* kcov-collect-coverage-from-interrupts.patch
* kcov-collect-coverage-from-interrupts-v4.patch
* usb-core-kcov-collect-coverage-from-usb-complete-callback.patch
* ubsan-add-trap-instrumentation-option.patch
* ubsan-split-bounds-checker-from-other-options.patch
* lkdtm-bugs-add-arithmetic-overflow-and-array-bounds-checks.patch
* ubsan-check-panic_on_warn.patch
* kasan-unset-panic_on_warn-before-calling-panic.patch
* ubsan-include-bug-type-in-report-header.patch
* ipc-mqueuec-fixed-a-brace-coding-style-issue.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-fix.patch
  linux-next-git-rejects.patch
* change-email-address-for-pali-rohar.patch
* mm-kmemleak-silence-kcsan-splats-in-checksum.patch
* dmaengine-tegra-apb-fix-platform_get_irqcocci-warnings.patch
* mm-frontswap-mark-various-intentional-data-races.patch
* mm-page_io-mark-various-intentional-data-races.patch
* mm-page_io-mark-various-intentional-data-races-v2.patch
* mm-swap_state-mark-various-intentional-data-races.patch
* mm-filemap-fix-a-data-race-in-filemap_fault.patch
* mm-swapfile-fix-and-annotate-various-data-races.patch
* mm-swapfile-fix-and-annotate-various-data-races-v2.patch
* mm-page_counter-fix-various-data-races-at-memsw.patch
* mm-memcontrol-fix-a-data-race-in-scan-count.patch
* mm-list_lru-fix-a-data-race-in-list_lru_count_one.patch
* mm-mempool-fix-a-data-race-in-mempool_free.patch
* mm-util-annotate-an-data-race-at-vm_committed_as.patch
* mm-rmap-annotate-a-data-race-at-tlb_flush_batched.patch
* mm-annotate-a-data-race-in-page_zonenum.patch
* mm-swap-annotate-data-races-for-lru_rotate_pvecs.patch
* mm-refactor-insert_page-to-prepare-for-batched-lock-insert.patch
* mm-bring-sparc-pte_index-semantics-inline-with-other-platforms.patch
* mm-define-pte_index-as-macro-for-x86.patch
* mm-add-vm_insert_pages.patch
* mm-add-vm_insert_pages-fix.patch
* mm-add-vm_insert_pages-2.patch
* mm-add-vm_insert_pages-2-fix.patch
* net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy.patch
* net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy-fix.patch
* mm-vma-define-a-default-value-for-vm_data_default_flags.patch
* mm-vma-introduce-vm_access_flags.patch
* mm-special-create-generic-fallbacks-for-pte_special-and-pte_mkspecial.patch
* mm-special-create-generic-fallbacks-for-pte_special-and-pte_mkspecial-v3.patch
* mm-debug-add-tests-validating-architecture-page-table-helpers.patch
* mm-memory_hotplug-drop-the-flags-field-from-struct-mhp_restrictions.patch
* mm-memory_hotplug-rename-mhp_restrictions-to-mhp_params.patch
* x86-mm-thread-pgprot_t-through-init_memory_mapping.patch
* x86-mm-introduce-__set_memory_prot.patch
* powerpc-mm-thread-pgprot_t-through-create_section_mapping.patch
* mm-memory_hotplug-add-pgprot_t-to-mhp_params.patch
* mm-memremap-set-caching-mode-for-pci-p2pdma-memory-to-wc.patch
* mm-pass-task-and-mm-to-do_madvise.patch
* mm-introduce-external-memory-hinting-api.patch
* mm-introduce-external-memory-hinting-api-fix.patch
* mm-check-fatal-signal-pending-of-target-process.patch
* pid-move-pidfd_get_pid-function-to-pidc.patch
* mm-support-both-pid-and-pidfd-for-process_madvise.patch
* mm-madvise-employ-mmget_still_valid-for-write-lock.patch
* mm-madvise-allow-ksm-hints-for-remote-api.patch
* kmod-make-request_module-return-an-error-when-autoloading-is-disabled.patch
* fs-filesystemsc-downgrade-user-reachable-warn_once-to-pr_warn_once.patch
* docs-admin-guide-document-the-kernelmodprobe-sysctl.patch
* selftests-kmod-fix-handling-test-numbers-above-9.patch
* selftests-kmod-test-disabling-module-autoloading.patch
* kexec-prevent-removal-of-memory-in-use-by-a-loaded-kexec-image.patch
* mm-memory_hotplug-allow-arch-override-of-non-boot-memory-resource-names.patch
* arm64-memory-give-hotplug-memory-a-different-resource-name.patch
* seq_read-info-message-about-buggy-next-functions.patch
* seq_read-info-message-about-buggy-next-functions-fix.patch
* gcov_seq_next-should-increase-position-index.patch
* sysvipc_find_ipc-should-increase-position-index.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
