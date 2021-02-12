Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE89A3199DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 07:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhBLGHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 01:07:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhBLGHB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 01:07:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9291A600EF;
        Fri, 12 Feb 2021 06:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1613109979;
        bh=GLw2PVEMmLVFzmnGF8QpWKNXDIe0fYbqhRDCPYdfc5I=;
        h=Date:From:To:Subject:From;
        b=tp91mDNWzQhblrJq1OJRA55fHKggIDnJBDIFZJ9MONd6dc+mM89Gxht7x4h6QkJBM
         AuAaJbhy8QYPCtuvd3/rSZWpzCVkL1RRP12zXT+OOdcVS0Ba/5c8EdgZJ2B18VZoAU
         p8y0ALqAVP8/++ae4G3eGKfdRNhreNmccjTVCKqs=
Date:   Thu, 11 Feb 2021 22:06:18 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2021-02-11-22-05 uploaded
Message-ID: <20210212060618.aROYT%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.10
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-02-11-22-05 has been uploaded to

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



This mmotm tree contains the following patches against 5.11-rc7:
(patches marked "*" will be included in linux-next)

  origin.patch
* m68k-make-__pfn_to_phys-and-__phys_to_pfn-available-for-mmu.patch
* scripts-recordmcountpl-support-big-endian-for-arch-sh.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* hexagon-remove-config_experimental-from-defconfigs.patch
* scripts-spellingtxt-increase-error-prone-spell-checking.patch
* scripts-spellingtxt-increase-error-prone-spell-checking-2.patch
* scripts-spellingtxt-add-allocted-and-exeeds-typo.patch
* scripts-spellingtxt-add-more-spellings-to-spellingtxt.patch
* ntfs-layouth-delete-duplicated-words.patch
* ocfs2-remove-redundant-conditional-before-iput.patch
* ocfs2-cleanup-some-definitions-which-is-not-used-anymore.patch
* ocfs2-fix-a-use-after-free-on-error.patch
* ocfs2-simplify-the-calculation-of-variables.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* fs-delete-repeated-words-in-comments.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-tracing-record-slab-name-for-kmem_cache_free.patch
* mm-remove-ctor-argument-from-kmem_cache_flags.patch
* mm-slab-minor-coding-style-tweaks.patch
* mm-slub-disable-user-tracing-for-kmemleak-caches-by-default.patch
* mm-slub-stop-freeing-kmem_cache_node-structures-on-node-offline.patch
* mm-slab-slub-stop-taking-memory-hotplug-lock.patch
* mm-slab-slub-stop-taking-cpu-hotplug-lock.patch
* mm-slub-splice-cpu-and-page-freelists-in-deactivate_slab.patch
* mm-slub-remove-slub_memcg_sysfs-boot-param-and-config_slub_memcg_sysfs_on.patch
* mm-slub-minor-coding-style-tweaks.patch
* mm-debug-improve-memcg-debugging.patch
* mm-debug_vm_pgtable-basic-add-validation-for-dirtiness-after-write-protect.patch
* mm-debug_vm_pgtable-basic-iterate-over-entire-protection_map.patch
* mm-page_owner-use-helper-function-zone_end_pfn-to-get-end_pfn.patch
* mm-msync-exit-early-when-the-flags-is-an-ms_async-and-start-vm_start.patch
* mm-filemap-remove-unused-parameter-and-change-to-void-type-for-replace_page_cache_page.patch
* mm-filemap-dont-revert-iter-on-eiocbqueued.patch
* mm-filemap-rename-generic_file_buffered_read-subfunctions.patch
* mm-filemap-remove-dynamically-allocated-array-from-filemap_read.patch
* mm-filemap-convert-filemap_get_pages-to-take-a-pagevec.patch
* mm-filemap-use-head-pages-in-generic_file_buffered_read.patch
* mm-filemap-pass-a-sleep-state-to-put_and_wait_on_page_locked.patch
* mm-filemap-support-readpage-splitting-a-page.patch
* mm-filemap-inline-__wait_on_page_locked_async-into-caller.patch
* mm-filemap-dont-call-readpage-if-iocb_waitq-is-set.patch
* mm-filemap-change-filemap_read_page-calling-conventions.patch
* mm-filemap-change-filemap_create_page-calling-conventions.patch
* mm-filemap-convert-filemap_update_page-to-return-an-errno.patch
* mm-filemap-move-the-iocb-checks-into-filemap_update_page.patch
* mm-filemap-add-filemap_range_uptodate.patch
* mm-filemap-add-filemap_range_uptodate-fix.patch
* mm-filemap-split-filemap_readahead-out-of-filemap_get_pages.patch
* mm-filemap-restructure-filemap_get_pages.patch
* mm-filemap-dont-relock-the-page-after-calling-readpage.patch
* mm-filemap-rename-generic_file_buffered_read-to-filemap_read.patch
* mm-filemap-simplify-generic_file_read_iter.patch
* fs-bufferc-add-checking-buffer-head-stat-before-clear.patch
* mm-backing-dev-remove-duplicated-macro-definition.patch
* mm-swap_slotsc-remove-redundant-null-check.patch
* mm-swapfilec-fix-debugging-information-problem.patch
* mm-page_io-use-pr_alert_ratelimited-for-swap-read-write-errors.patch
* mm-swap_state-constify-static-struct-attribute_group.patch
* mm-swap-dont-setpageworkingset-unconditionally-during-swapin.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account-fix.patch
* mm-memcontrol-optimize-per-lruvec-stats-counter-memory-usage.patch
* mm-memcontrol-optimize-per-lruvec-stats-counter-memory-usage-checkpatch-fixes.patch
* mm-memcontrol-fix-nr_anon_thps-accounting-in-charge-moving.patch
* mm-memcontrol-convert-nr_anon_thps-account-to-pages.patch
* mm-memcontrol-convert-nr_file_thps-account-to-pages.patch
* mm-memcontrol-convert-nr_shmem_thps-account-to-pages.patch
* mm-memcontrol-convert-nr_shmem_pmdmapped-account-to-pages.patch
* mm-memcontrol-convert-nr_file_pmdmapped-account-to-pages.patch
* mm-memcontrol-make-the-slab-calculation-consistent.patch
* mm-memcg-revise-the-using-condition-of-lock_page_lruvec-function-series.patch
* mm-memcg-remove-rcu-locking-for-lock_page_lruvec-function-series.patch
* mm-memcg-add-swapcache-stat-for-memcg-v2.patch
* mm-memcg-add-swapcache-stat-for-memcg-v2-fix.patch
* mm-kmem-make-__memcg_kmem_uncharge-static.patch
* mm-page_counter-relayout-structure-to-reduce-false-sharing.patch
* mm-memcontrol-remove-redundant-null-check.patch
* mm-memcontrol-replace-the-loop-with-a-list_for_each_entry.patch
* mm-list_lruc-remove-kvfree_rcu_local.patch
* fs-buffer-use-raw-page_memcg-on-locked-page.patch
* mm-mmap-remove-unnecessary-local-variable.patch
* mm-fix-potential-pte_unmap_unlock-pte-error.patch
* mm-simplify-the-vm_bug_on-condition-in-pmdp_huge_clear_flush.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-pgtable-genericc-optimize-the-vm_bug_on-condition-in-pmdp_huge_clear_flush.patch
* mm-memoryc-fix-potential-pte_unmap_unlock-pte-error.patch
* mm-optimizing-error-condition-detection-in-do_mprotect_pkey.patch
* mm-rmap-explicitly-reset-vma-anon_vma-in-unlink_anon_vmas.patch
* mm-mremap-unlink-anon_vmas-when-mremap-with-mremap_dontunmap-success.patch
* mm-mremap-unlink-anon_vmas-when-mremap-with-mremap_dontunmap-success-v2.patch
* mm-page_reporting-use-list_entry_is_head-in-page_reporting_cycle.patch
* vmalloc-remove-redundant-null-check.patch
* kasan-prefix-global-functions-with-kasan_.patch
* kasan-clarify-hw_tags-impact-on-tbi.patch
* kasan-clean-up-comments-in-tests.patch
* kasan-add-macros-to-simplify-checking-test-constraints.patch
* kasan-add-match-all-tag-tests.patch
* kasan-add-match-all-tag-tests-fix.patch
* kasan-add-match-all-tag-tests-fix-fix.patch
* kasan-arm64-allow-using-kunit-tests-with-hw_tags-mode.patch
* kasan-rename-config_test_kasan_module.patch
* kasan-add-compiler-barriers-to-kunit_expect_kasan_fail.patch
* kasan-adapt-kmalloc_uaf2-test-to-hw_tags-mode.patch
* kasan-fix-memory-corruption-in-kasan_bitops_tags-test.patch
* kasan-move-_ret_ip_-to-inline-wrappers.patch
* kasan-fix-bug-detection-via-ksize-for-hw_tags-mode.patch
* kasan-add-proper-page-allocator-tests.patch
* kasan-add-a-test-for-kmem_cache_alloc-free_bulk.patch
* kasan-dont-run-tests-when-kasan-is-not-enabled.patch
* kasan-remove-redundant-config-option.patch
* kasan-remove-redundant-config-option-v3.patch
* mm-fix-prototype-warning-from-kernel-test-robot.patch
* mm-rename-memmap_init-and-memmap_init_zone.patch
* mm-simplify-parater-of-function-memmap_init_zone.patch
* mm-simplify-parameter-of-setup_usemap.patch
* mm-remove-unneeded-local-variable-in-free_area_init_core.patch
* video-fbdev-acornfb-remove-free_unused_pages.patch
* mm-simplify-free_highmem_page-and-free_reserved_page.patch
* mm-refactor-initialization-of-struct-page-for-holes-in-memory-layout.patch
* mmhwpoison-send-sigbus-to-pf_mce_early-processes-on-action-required-events.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* mm-hugetlb-fix-potential-double-free-in-hugetlb_register_node-error-path.patch
* mm-hugetlbc-fix-unnecessary-address-expansion-of-pmd-sharing.patch
* mm-hugetlb-avoid-unnecessary-hugetlb_acct_memory-call.patch
* mm-hugetlb-use-helper-huge_page_order-and-pages_per_huge_page.patch
* mm-hugetlb-fix-use-after-free-when-subpool-max_hpages-accounting-is-not-enabled.patch
* mm-hugetlb-simplify-the-calculation-of-variables.patch
* mm-hugetlb-grab-head-page-refcount-once-for-group-of-subpages.patch
* mm-hugetlb-refactor-subpage-recording.patch
* mm-hugetlb-fix-some-comment-typos.patch
* mm-hugetlb-remove-redundant-check-in-preparing-and-destroying-gigantic-page.patch
* mm-hugetlbc-fix-typos-in-comments.patch
* mm-remove-unused-return-value-of-set_huge_zero_page.patch
* mm-pmem-avoid-inserting-hugepage-pte-entry-with-fsdax-if-hugepage-support-is-disabled.patch
* hugetlb_cgroup-use-helper-pages_per_huge_page-in-hugetlb_cgroup.patch
* mm-hugetlb-use-helper-function-range_in_vma-in-page_table_shareable.patch
* mm-hugetlb-remove-unnecessary-vm_bug_on_page-on-putback_active_hugepage.patch
* mm-hugetlb-use-helper-huge_page_size-to-get-hugepage-size.patch
* mm-hugetlb-use-helper-huge_page_size-to-get-hugepage-size-v2.patch
* mm-vmscan-__isolate_lru_page_prepare-clean-up.patch
* mm-workingsetc-avoid-unnecessary-max_nodes-estimation-in-count_shadow_nodes.patch
* mm-use-add_page_to_lru_list.patch
* mm-shuffle-lru-list-addition-and-deletion-functions.patch
* mm-dont-pass-enum-lru_list-to-lru-list-addition-functions.patch
* mm-dont-pass-enum-lru_list-to-trace_mm_lru_insertion.patch
* mm-dont-pass-enum-lru_list-to-del_page_from_lru_list.patch
* mm-add-__clear_page_lru_flags-to-replace-page_off_lru.patch
* mm-vm_bug_on-lru-page-flags.patch
* mm-fold-page_lru_base_type-into-its-sole-caller.patch
* mm-fold-__update_lru_size-into-its-sole-caller.patch
* mm-make-lruvec_lru_size-static.patch
* mm-workingset-clarify-eviction-order-and-distance-calculation.patch
* hugetlb-use-pageprivate-for-hugetlb-specific-page-flags.patch
* hugetlb-convert-page_huge_active-hpagemigratable-flag.patch
* hugetlb-convert-page_huge_active-hpagemigratable-flag-fix.patch
* hugetlb-convert-pagehugetemporary-to-hpagetemporary-flag.patch
* hugetlb-convert-pagehugefreed-to-hpagefreed-flag.patch
* z3fold-remove-unused-attribute-for-release_z3fold_page.patch
* z3fold-simplify-the-zhdr-initialization-code-in-init_z3fold_page.patch
* mm-compaction-remove-rcu_read_lock-during-page-compaction.patch
* mm-compaction-remove-duplicated-vm_bug_on_page-pagelocked.patch
* mm-compaction-correct-deferral-logic-for-proactive-compaction.patch
* mm-compactoin-fix-misbehaviors-of-fast_find_migrateblock.patch
* numa-balancing-migrate-on-fault-among-multiple-bound-nodes.patch
* mm-mempolicy-use-helper-range_in_vma-in-queue_pages_test_walk.patch
* mm-oom-fix-a-comment-in-dump_task.patch
* mm-hugetlb-change-hugetlb_reserve_pages-to-type-bool.patch
* hugetlbfs-remove-special-hugetlbfs_set_page_dirty.patch
* hugetlbfs-remove-useless-bug_oninode-in-hugetlbfs_setattr.patch
* hugetlbfs-use-helper-macro-default_hstate-in-init_hugetlbfs_fs.patch
* hugetlbfs-correct-obsolete-function-name-in-hugetlbfs_read_iter.patch
* hugetlbfs-remove-meaningless-variable-avoid_reserve.patch
* hugetlbfs-make-hugepage-size-conversion-more-readable.patch
* hugetlbfs-correct-some-obsolete-comments-about-inode-i_mutex.patch
* hugetlbfs-fix-some-comment-typos.patch
* hugetlbfs-remove-unneeded-return-value-of-hugetlb_vmtruncate.patch
* mm-migrate-remove-unneeded-semicolons.patch
* mm-make-pagecache-tagged-lookups-return-only-head-pages.patch
* mm-shmem-use-pagevec_lookup-in-shmem_unlock_mapping.patch
* mm-swap-optimise-get_shadow_from_swap_cache.patch
* mm-add-fgp_entry.patch
* mm-filemap-rename-find_get_entry-to-mapping_get_entry.patch
* mm-filemap-add-helper-for-finding-pages.patch
* mm-filemap-add-helper-for-finding-pages-fix.patch
* mm-filemap-add-mapping_seek_hole_data.patch
* mm-filemap-add-mapping_seek_hole_data-fix.patch
* iomap-use-mapping_seek_hole_data.patch
* mm-add-and-use-find_lock_entries.patch
* mm-add-and-use-find_lock_entries-fix.patch
* mm-add-an-end-parameter-to-find_get_entries.patch
* mm-add-an-end-parameter-to-pagevec_lookup_entries.patch
* mm-remove-nr_entries-parameter-from-pagevec_lookup_entries.patch
* mm-pass-pvec-directly-to-find_get_entries.patch
* mm-remove-pagevec_lookup_entries.patch
* mmthpshmem-limit-shmem-thp-alloc-gfp_mask.patch
* mmthpshm-limit-gfp-mask-to-no-more-than-specified.patch
* mmthpshmem-make-khugepaged-obey-tmpfs-mount-flags.patch
* mm-cma-allocate-cma-areas-bottom-up.patch
* mm-cma-allocate-cma-areas-bottom-up-fix.patch
* mm-cma-allocate-cma-areas-bottom-up-fix-2.patch
* mm-cma-allocate-cma-areas-bottom-up-fix-3.patch
* mm-cma-allocate-cma-areas-bottom-up-fix-3-fix.patch
* mm-cma-expose-all-pages-to-the-buddy-if-activation-of-an-area-fails.patch
* mm-page_alloc-count-cma-pages-per-zone-and-print-them-in-proc-zoneinfo.patch
* mm-page_alloc-count-cma-pages-per-zone-and-print-them-in-proc-zoneinfo-v2.patch
* mm-page_alloc-count-cma-pages-per-zone-and-print-them-in-proc-zoneinfo-v3.patch
* mm-cma-print-region-name-on-failure.patch
* mm-cma-print-region-name-on-failure-v2.patch
* mm-vmstat-fix-nohz-wakeups-for-node-stat-changes.patch
* mm-vmstat-add-some-comments-on-internal-storage-of-byte-items.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
* mm-vmstatc-erase-latency-in-vmstat_shepherd.patch
* mm-move-pfn_to_online_page-out-of-line.patch
* mm-teach-pfn_to_online_page-to-consider-subsection-validity.patch
* mm-teach-pfn_to_online_page-about-zone_device-section-collisions.patch
* mm-teach-pfn_to_online_page-about-zone_device-section-collisions-fix.patch
* mm-fix-memory_failure-handling-of-dax-namespace-metadata.patch
* mm-memory_hotplug-rename-all-existing-memhp-into-mhp.patch
* mm-memory_hotplug-memhp_merge_resource-mhp_merge_resource.patch
* mm-memory_hotplug-use-helper-function-zone_end_pfn-to-get-end_pfn.patch
* drivers-base-memory-dont-store-phys_device-in-memory-blocks.patch
* documentation-sysfs-memory-clarify-some-memory-block-device-properties.patch
* mm-memory_hotplug-prevalidate-the-address-range-being-added-with-platform.patch
* arm64-mm-define-arch_get_mappable_range.patch
* s390-mm-define-arch_get_mappable_range.patch
* virtio-mem-check-against-mhp_get_pluggable_range-which-memory-we-can-hotplug.patch
* mm-mlock-stop-counting-mlocked-pages-when-none-vma-is-found.patch
* mm-rmap-correct-some-obsolete-comments-of-anon_vma.patch
* mm-rmap-remove-unneeded-semicolon-in-page_not_mapped.patch
* mm-rmap-fix-obsolete-comment-in-__page_check_anon_rmap.patch
* mm-rmap-use-page_not_mapped-in-try_to_unmap.patch
* mm-rmap-correct-obsolete-comment-of-page_get_anon_vma.patch
* mm-rmap-fix-potential-pte_unmap-on-an-not-mapped-pte.patch
* mm-zswap-clean-up-confusing-comment.patch
* mm-zswap-add-the-flag-can_sleep_mapped.patch
* mm-zswap-add-the-flag-can_sleep_mapped-fix.patch
* mm-zswap-add-the-flag-can_sleep_mapped-fix-2.patch
* mm-zswap-add-the-flag-can_sleep_mapped-fix-3.patch
* mm-zswap-fix-variable-entry-is-uninitialized-when-used.patch
* mm-set-the-sleep_mapped-to-true-for-zbud-and-z3fold.patch
* mm-zsmallocc-convert-to-use-kmem_cache_zalloc-in-cache_alloc_zspage.patch
* zsmalloc-account-the-number-of-compacted-pages-correctly.patch
* mm-zsmallocc-use-page_private-to-access-page-private.patch
* mm-highmem-remove-deprecated-kmap_atomic.patch
* mm-remove-arch_remap-and-mm-arch-hooksh.patch
* mm-page-flagsh-typo-fix-it-if.patch
* mm-dmapool-use-might_alloc.patch
* bdi-use-might_alloc.patch
* bdi-use-might_alloc-fix.patch
* mm-early_ioremapc-use-__func__-instead-of-function-name.patch
* mm-add-kernel-electric-fence-infrastructure.patch
* mm-add-kernel-electric-fence-infrastructure-fix.patch
* mm-add-kernel-electric-fence-infrastructure-fix-2.patch
* mm-add-kernel-electric-fence-infrastructure-fix-3.patch
* mm-add-kernel-electric-fence-infrastructure-fix-4.patch
* mm-add-kernel-electric-fence-infrastructure-fix-5.patch
* x86-kfence-enable-kfence-for-x86.patch
* x86-kfence-enable-kfence-for-x86-fix.patch
* arm64-kfence-enable-kfence-for-arm64.patch
* arm64-kfence-enable-kfence-for-arm64-fix.patch
* kfence-use-pt_regs-to-generate-stack-trace-on-faults.patch
* mm-kfence-insert-kfence-hooks-for-slab.patch
* mm-kfence-insert-kfence-hooks-for-slub.patch
* kfence-kasan-make-kfence-compatible-with-kasan.patch
* kfence-kasan-make-kfence-compatible-with-kasan-fix.patch
* kfence-kasan-make-kfence-compatible-with-kasan-fix-2.patch
* kfence-documentation-add-kfence-documentation.patch
* kfence-documentation-add-kfence-documentation-fix.patch
* kfence-add-test-suite.patch
* kfence-add-test-suite-fix.patch
* kfence-add-test-suite-fix-2.patch
* maintainers-add-entry-for-kfence.patch
* tracing-add-error_report_end-trace-point.patch
* kfence-use-error_report_end-tracepoint.patch
* kasan-use-error_report_end-tracepoint.patch
* kasan-mm-dont-save-alloc-stacks-twice.patch
* kasan-mm-optimize-kmalloc-poisoning.patch
* kasan-optimize-large-kmalloc-poisoning.patch
* kasan-clean-up-setting-free-info-in-kasan_slab_free.patch
* kasan-unify-large-kfree-checks.patch
* kasan-rework-krealloc-tests.patch
* kasan-mm-fail-krealloc-on-freed-objects.patch
* kasan-mm-optimize-krealloc-poisoning.patch
* kasan-ensure-poisoning-size-alignment.patch
* arm64-kasan-simplify-and-inline-mte-functions.patch
* arm64-kasan-simplify-and-inline-mte-functions-fix.patch
* kasan-inline-hw_tags-helper-functions.patch
* kasan-clarify-that-only-first-bug-is-reported-in-hw_tags.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* alpha-remove-config_experimental-from-defconfigs.patch
* proc-wchan-use-printk-format-instead-of-lookup_symbol_name.patch
* proc-use-vmalloc-for-our-kernel-buffer.patch
* sysctlc-fix-underflow-value-setting-risk-in-vm_table.patch
* proc-sysctl-make-protected_-world-readable.patch
* include-linux-remove-repeated-words.patch
* treewide-update-my-contact-info.patch
* groups-use-flexible-array-member-in-struct-group_info.patch
* groups-simplify-struct-group_info-allocation.patch
* kernel-delete-repeated-words-in-comments.patch
* lib-genalloc-change-return-type-to-unsigned-long-for-bitmap_set_ll.patch
* stringh-move-fortified-functions-definitions-in-a-dedicated-header.patch
* lib-stackdepot-add-support-to-configure-stack_hash_size.patch
* lib-stackdepot-add-support-to-disable-stack-depot.patch
* lib-stackdepot-add-support-to-disable-stack-depot-fix.patch
* lib-stackdepot-add-support-to-disable-stack-depot-fix-2.patch
* lib-cmdline-remove-an-unneeded-local-variable-in-next_arg.patch
* lib-hexdump-introduce-dump_prefix_unhashed-for-unhashed-addresses.patch
* mm-page_poison-use-unhashed-address-in-hexdump-for-check_poison_mem.patch
* bitops-spelling-s-synomyn-synonym.patch
* checkpatch-improve-blank-line-after-declaration-test.patch
* checkpatch-ignore-warning-designated-initializers-using-nr_cpus.patch
* checkpatch-trivial-style-fixes.patch
* checkpatch-prefer-ftrace-over-function-entry-exit-printks.patch
* checkpatch-improve-typecast_int_constant-test-message.patch
* checkpatch-add-warning-for-avoiding-l-prefix-symbols-in-assembly-files.patch
* checkpatch-add-kmalloc_array_node-to-unnecessary-oom-message-check.patch
* checkpatch-dont-warn-about-colon-termination-in-linker-scripts.patch
* checkpatch-do-not-apply-initialise-globals-to-0-check-to-bpf-progs.patch
* init-versionc-remove-version_linux_version_code-symbol.patch
* init-clean-up-early_param_on_off-macro.patch
* fs-coredump-use-kmap_local_page.patch
* seq_file-document-how-per-entry-resources-are-managed.patch
* seq_file-document-how-per-entry-resources-are-managed-fix.patch
* x86-fix-seq_file-iteration-for-pat-memtypec.patch
* aio-simplify-read_events.patch
* scripts-gdb-fix-list_for_each.patch
* ubsan-remove-overflow-checks.patch
* initramfs-panic-with-memory-information.patch
* initramfs-panic-with-memory-information-fix.patch
  linux-next.patch
  linux-next-rejects.patch
* fs-ramfs-inodec-update-inode_operationstmpfile.patch
* mips-make-userspace-mapping-young-by-default.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
