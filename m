Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AB7277ED2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 06:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgIYEPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 00:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgIYEPo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 00:15:44 -0400
Received: from localhost.localdomain (c-71-198-47-131.hsd1.ca.comcast.net [71.198.47.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27006206C3;
        Fri, 25 Sep 2020 04:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601007342;
        bh=6KroCFsGGMe25Ef5aXx1scWLASGfTytidiFIqeplQM0=;
        h=Date:From:To:Subject:From;
        b=1FlgvGg+bCjoj/v3WYBQYqf7SgNwZOUQcv0zC51i0Gmq8/dpFRKQzDXUtqeRdSkLB
         wV7XUer6O5YnV6qQXf1Tus+w5zzrMM2kIF2zzcTl+4xWqCTBLLuD6L1AdXxmVY80Oi
         ag/cj0OpMRVVOzzrSXa2qiNEqa5+G1vws5SghIRQ=
Date:   Thu, 24 Sep 2020 21:15:41 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-09-24-21-14 uploaded
Message-ID: <20200925041541.9ikDuTC6D%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-09-24-21-14 has been uploaded to

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



This mmotm tree contains the following patches against 5.9-rc6:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-thp-swap-fix-allocating-cluster-for-swapfile-by-mistake.patch
* mm-memcontrol-fix-missing-suffix-of-workingset_restore.patch
* mm-gup-fix-gup_fast-with-dynamic-page-table-folding.patch
* mm-validate-pmd-after-splitting.patch
* mm-migrate-correct-thp-migration-stats.patch
* mm-swapfile-avoid-split_swap_cluster-null-pointer-dereference.patch
* lib-stringc-implement-stpcpy.patch
* lib-include-memregionh-in-memregionc.patch
* arch-x86-lib-usercopy_64c-fix-__copy_user_flushcache-cache-writeback.patch
* mm-replace-memmap_context-by-meminit_context.patch
* mm-dont-rely-on-system-state-to-detect-hot-plug-operations.patch
* checkpatch-test-git_dir-changes.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mm-khugepaged-recalculate-min_free_kbytes-after-memory-hotplug-as-expected-by-khugepaged.patch
* compiler-clang-add-build-check-for-clang-1001.patch
* revert-kbuild-disable-clangs-default-use-of-fmerge-all-constants.patch
* revert-arm64-bti-require-clang-=-1001-for-in-kernel-bti-support.patch
* revert-arm64-vdso-fix-compilation-with-clang-older-than-8.patch
* partially-revert-arm-8905-1-emit-__gnu_mcount_nc-when-using-clang-1000-or-newer.patch
* kasan-remove-mentions-of-unsupported-clang-versions.patch
* compiler-gcc-improve-version-error.patch
* ntfs-add-check-for-mft-record-size-in-superblock.patch
* fs-ocfs2-delete-repeated-words-in-comments.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* ramfs-support-o_tmpfile.patch
* fs-xattrc-fix-kernel-doc-warnings-for-setxattr-removexattr.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-slabc-clean-code-by-removing-redundant-if-condition.patch
* include-linux-slabh-fix-a-typo-error-in-comment.patch
* mm-slub-branch-optimization-in-free-slowpath.patch
* mm-slub-fix-missing-alloc_slowpath-stat-when-bulk-alloc.patch
* mm-slub-make-add_full-condition-more-explicit.patch
* mm-kmemleak-rely-on-rcu-for-task-stack-scanning.patch
* x86-numa-cleanup-configuration-dependent-command-line-options.patch
* x86-numa-add-nohmat-option.patch
* x86-numa-add-nohmat-option-fix.patch
* efi-fake_mem-arrange-for-a-resource-entry-per-efi_fake_mem-instance.patch
* acpi-hmat-refactor-hmat_register_target_device-to-hmem_register_device.patch
* acpi-hmat-refactor-hmat_register_target_device-to-hmem_register_device-fix.patch
* resource-report-parent-to-walk_iomem_res_desc-callback.patch
* mm-memory_hotplug-introduce-default-phys_to_target_node-implementation.patch
* mm-memory_hotplug-introduce-default-phys_to_target_node-implementation-fix.patch
* acpi-hmat-attach-a-device-for-each-soft-reserved-range.patch
* acpi-hmat-attach-a-device-for-each-soft-reserved-range-fix.patch
* device-dax-drop-the-dax_regionpfn_flags-attribute.patch
* device-dax-move-instance-creation-parameters-to-struct-dev_dax_data.patch
* device-dax-make-pgmap-optional-for-instance-creation.patch
* device-dax-make-pgmap-optional-for-instance-creation-fix.patch
* device-dax-kill-dax_kmem_res.patch
* device-dax-add-an-allocation-interface-for-device-dax-instances.patch
* device-dax-introduce-seed-devices.patch
* drivers-base-make-device_find_child_by_name-compatible-with-sysfs-inputs.patch
* device-dax-add-resize-support.patch
* mm-memremap_pages-convert-to-struct-range.patch
* mm-memremap_pages-support-multiple-ranges-per-invocation.patch
* mm-memremap_pages-support-multiple-ranges-per-invocation-fix.patch
* device-dax-add-dis-contiguous-resource-support.patch
* device-dax-add-dis-contiguous-resource-support-fix.patch
* device-dax-introduce-mapping-devices.patch
* device-dax-make-align-a-per-device-property.patch
* device-dax-make-align-a-per-device-property-fix.patch
* device-dax-add-an-align-attribute.patch
* device-dax-add-an-align-attribute-fixpatch.patch
* dax-hmem-introduce-dax_hmemregion_idle-parameter.patch
* device-dax-add-a-range-mapping-allocation-attribute.patch
* device-dax-make-dev_dax_kmem_probe-static.patch
* mm-debug-do-not-dereference-i_ino-blindly.patch
* mm-dump_page-rename-head_mapcount-head_compound_mapcount.patch
* powerpc-mm-add-debug_vm-warn-for-pmd_clear.patch
* powerpc-mm-move-setting-pte-specific-flags-to-pfn_pte.patch
* powerpc-mm-move-setting-pte-specific-flags-to-pfn_pte-fix.patch
* mm-debug_vm_pgtable-ppc64-avoid-setting-top-bits-in-radom-value.patch
* mm-debug_vm_pgtables-hugevmap-use-the-arch-helper-to-identify-huge-vmap-support.patch
* mm-debug_vm_pgtable-savedwrite-enable-savedwrite-test-with-config_numa_balancing.patch
* mm-debug_vm_pgtable-thp-mark-the-pte-entry-huge-before-using-set_pmd-pud_at.patch
* mm-debug_vm_pgtable-set_pte-pmd-pud-dont-use-set__at-to-update-an-existing-pte-entry.patch
* mm-debug_vm_pgtable-locks-move-non-page-table-modifying-test-together.patch
* mm-debug_vm_pgtable-locks-take-correct-page-table-lock.patch
* mm-debug_vm_pgtable-thp-use-page-table-depost-withdraw-with-thp.patch
* mm-debug_vm_pgtable-pmd_clear-dont-use-pmd-pud_clear-on-pte-entries.patch
* mm-debug_vm_pgtable-hugetlb-disable-hugetlb-test-on-ppc64.patch
* mm-debug_vm_pgtable-hugetlb-disable-hugetlb-test-on-ppc64-fix.patch
* mm-debug_vm_pgtable-avoid-none-pte-in-pte_clear_test.patch
* mm-debug_vm_pgtable-avoid-doing-memory-allocation-with-pgtable_t-mapped.patch
* mm-factor-find_get_incore_page-out-of-mincore_page.patch
* mm-use-find_get_incore_page-in-memcontrol.patch
* mm-optimise-madvise-willneed.patch
* mm-optimise-madvise-willneed-fix.patch
* proc-optimise-smaps-for-shmem-entries.patch
* i915-use-find_lock_page-instead-of-find_lock_entry.patch
* mm-convert-find_get_entry-to-return-the-head-page.patch
* mm-convert-find_get_entry-to-return-the-head-page-fix.patch
* mm-shmem-return-head-page-from-find_lock_entry.patch
* mm-shmem-return-head-page-from-find_lock_entry-fix.patch
* mm-add-find_lock_head.patch
* mm-filemap-fix-filemap_map_pages-for-thp.patch
* mm-gup_benchmark-update-the-documentation-in-kconfig.patch
* mm-gup_benchmark-use-pin_user_pages-for-foll_longterm-flag.patch
* mm-gup-dont-permit-users-to-call-get_user_pages-with-foll_longterm.patch
* mm-gup-dont-permit-users-to-call-get_user_pages-with-foll_longterm-fix.patch
* mm-gup-protect-unpin_user_pages-against-npages==-errno.patch
* swap-rename-swp_fs-to-swap_fs_ops-to-avoid-ambiguity.patch
* mm-remove-activate_page-from-unuse_pte.patch
* mm-remove-superfluous-__clearpageactive.patch
* mm-swap-fix-confusing-comment-in-release_pages.patch
* mm-swap_slotsc-remove-always-zero-and-unused-return-value-of-enable_swap_slots_cache.patch
* memremap-convert-devmap-static-branch-to-incdec.patch
* mm-memcontrol-use-flex_array_size-helper-in-memcpy.patch
* mm-memcontrol-use-the-preferred-form-for-passing-the-size-of-a-structure-type.patch
* mm-memcg-slab-fix-racy-access-to-page-mem_cgroup-in-mem_cgroup_from_obj.patch
* mm-memcontrol-correct-the-comment-of-mem_cgroup_iter.patch
* mm-memcg-clean-up-obsolete-enum-charge_type.patch
* mm-memcg-simplify-mem_cgroup_get_max.patch
* mm-memcg-simplify-mem_cgroup_get_max-v4.patch
* mm-memcg-unify-swap-and-memsw-page-counters.patch
* mm-memcontrol-add-the-missing-numa_stat-interface-for-cgroup-v2.patch
* mm-page_counter-correct-the-obsolete-func-name-in-the-comment-of-page_counter_try_charge.patch
* mm-memcontrol-remove-obsolete-comment-of-mem_cgroup_unmark_under_oom.patch
* selftests-vm-fix-false-build-success-on-the-second-and-later-attempts.patch
* selftests-vm-fix-incorrect-gcc-invocation-in-some-cases.patch
* mm-account-pmd-tables-like-pte-tables.patch
* mm-account-pmd-tables-like-pte-tables-fix.patch
* mm-memory-fix-typo-in-__do_fault-comment.patch
* mm-memoryc-replace-vmf-vma-with-variable-vma.patch
* mm-mmap-rename-__vma_unlink_common-to-__vma_unlink.patch
* mm-mmap-leverage-vma_rb_erase_ignore-to-implement-vma_rb_erase.patch
* mmap-locking-api-add-mmap_lock_is_contended.patch
* mm-smaps-extend-smap_gather_stats-to-support-specified-beginning.patch
* mm-proc-smaps_rollup-do-not-stall-write-attempts-on-mmap_lock.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-move-pagedoublemap-bit.patch
* mm-simplify-pagedoublemap-with-pf_second-policy.patch
* mm-mmap-leave-adjust_next-as-virtual-address-instead-of-page-frame-number.patch
* mm-memoryc-fix-spello-of-function.patch
* mm-mmap-not-necessary-to-check-mapping-separately.patch
* mm-mmap-check-on-file-instead-of-the-rb_root_cached-of-its-address_space.patch
* mm-use-helper-function-mapping_allow_writable.patch
* mm-mmap-use-helper-function-allow_write_access-in-__remove_shared_vm_struct.patch
* mm-mmapc-replace-do_brk-with-do_brk_flags-in-comment-of-insert_vm_struct.patch
* mm-cleanup-mincore_huge_pmd.patch
* mm-test-use-the-new-skip-macro.patch
* hmm-test-remove-unused-dmirror_zero_page.patch
* mm-dmapoolc-replace-open-coded-list_for_each_entry_safe.patch
* mm-dmapoolc-replace-hard-coded-function-name-with-__func__.patch
* mm-memory-failure-do-pgoff-calculation-before-for_each_process.patch
* mm-remove-unused-marco-writeback.patch
* docs-vm-fix-mm_count-vs-mm_users-counter-confusion.patch
* add-kunit-struct-to-current-task.patch
* kunit-kasan-integration.patch
* kasan-port-kasan-tests-to-kunit.patch
* kasan-port-kasan-tests-to-kunit-v14.patch
* kasan-testing-documentation.patch
* mm-kasan-do-not-panic-if-both-panic_on_warn-and-kasan_multishot-set.patch
* mm-page_alloc-tweak-comments-in-has_unmovable_pages.patch
* mm-page_isolation-exit-early-when-pageblock-is-isolated-in-set_migratetype_isolate.patch
* mm-page_isolation-drop-warn_on_once-in-set_migratetype_isolate.patch
* mm-page_isolation-cleanup-set_migratetype_isolate.patch
* virtio-mem-dont-special-case-zone_movable.patch
* mm-document-semantics-of-zone_movable.patch
* mm-isolation-avoid-checking-unmovable-pages-across-pageblock-boundary.patch
* mm-page_allocc-clean-code-by-removing-unnecessary-initialization.patch
* mm-page_allocc-clean-code-by-removing-unnecessary-initialization-fix.patch
* mm-page_allocc-micro-optimization-remove-unnecessary-branch.patch
* mm-page_allocc-fix-early-params-garbage-value-accesses.patch
* mm-page_allocc-clean-code-by-merging-two-functions.patch
* mm-page_allocc-__perform_reclaim-should-return-unsigned-long.patch
* mmzone-clean-code-by-removing-unused-macro-parameter.patch
* mm-move-call-to-compound_head-in-release_pages.patch
* mm-hugetlbc-make-is_hugetlb_entry_hwpoisoned-return-bool.patch
* mm-hugetlbc-remove-the-unnecessary-non_swap_entry.patch
* doc-vm-fix-typo-in-the-hugetlb-admin-documentation.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* mm-hugetlb-not-necessary-to-coalesce-regions-recursively.patch
* mm-hugetlb-remove-vm_bug_onnrg-in-get_file_region_entry_from_cache.patch
* mm-hugetlb-use-list_splice-to-merge-two-list-at-once.patch
* mm-hugetlb-count-file_region-to-be-added-when-regions_needed-=-null.patch
* mm-hugetlb-a-page-from-buddy-is-not-on-any-list.patch
* mm-hugetlb-narrow-the-hugetlb_lock-protection-area-during-preparing-huge-page.patch
* mm-hugetlb-take-the-free-hpage-during-the-iteration-directly.patch
* mm-hugetlb-take-the-free-hpage-during-the-iteration-directly-v4.patch
* hugetlb-add-lockdep-check-for-i_mmap_rwsem-held-in-huge_pmd_share.patch
* mm-vmscan-fix-infinite-loop-in-drop_slab_node.patch
* mm-vmscan-add-a-fatal-signals-check-in-drop_slab_node.patch
* mm-compactionc-micro-optimization-remove-unnecessary-branch.patch
* include-linux-compactionh-clean-code-by-removing-unused-enum-value.patch
* mm-mempolicy-remove-or-narrow-the-lock-on-current.patch
* mm-remove-unused-alloc_page_vma_node.patch
* mm-mempool-add-else-to-split-mutually-exclusive-case.patch
* mm-mempool-add-else-to-split-mutually-exclusive-case-fix.patch
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
* arch-drivers-replace-for_each_membock-with-for_each_mem_range-fix.patch
* arch-drivers-replace-for_each_membock-with-for_each_mem_range-fix-2.patch
* x86-setup-simplify-initrd-relocation-and-reservation.patch
* x86-setup-simplify-reserve_crashkernel.patch
* memblock-remove-unused-memblock_mem_size.patch
* memblock-implement-for_each_reserved_mem_region-using-__next_mem_region.patch
* memblock-use-separate-iterators-for-memory-and-reserved-regions.patch
* mm-oom_adj-dont-loop-through-tasks-in-__set_oom_adj-when-not-necessary.patch
* mm-oom_adj-dont-loop-through-tasks-in-__set_oom_adj-when-not-necessary-v3.patch
* mm-migrate-remove-cpages-in-migrate_vma_finalize.patch
* mm-migrate-remove-obsolete-comment-about-device-public.patch
* xarray-add-xa_get_order.patch
* xarray-add-xa_get_order-fix.patch
* xarray-add-xas_split.patch
* xarray-add-xas_split-fix.patch
* xarray-add-xas_split-fix-2.patch
* mm-filemap-fix-storing-to-a-thp-shadow-entry.patch
* mm-filemap-fix-page-cache-removal-for-arbitrary-sized-thps.patch
* mm-memory-remove-page-fault-assumption-of-compound-page-size.patch
* mm-page_owner-change-split_page_owner-to-take-a-count.patch
* mm-huge_memory-fix-total_mapcount-assumption-of-page-size.patch
* mm-huge_memory-fix-split-assumption-of-page-size.patch
* mm-huge_memory-fix-page_trans_huge_mapcount-assumption-of-thp-size.patch
* mm-huge_memory-fix-can_split_huge_page-assumption-of-thp-size.patch
* mm-rmap-fix-assumptions-of-thp-size.patch
* mm-truncate-fix-truncation-for-pages-of-arbitrary-size.patch
* mm-page-writeback-support-tail-pages-in-wait_for_stable_page.patch
* mm-vmscan-allow-arbitrary-sized-pages-to-be-paged-out.patch
* fs-add-a-filesystem-flag-for-thps.patch
* fs-do-not-update-nr_thps-for-mappings-which-support-thps.patch
* mm-readahead-add-define_readahead.patch
* mm-readahead-make-page_cache_ra_unbounded-take-a-readahead_control.patch
* mm-readahead-make-do_page_cache_ra-take-a-readahead_control.patch
* mm-readahead-make-ondemand_readahead-take-a-readahead_control.patch
* mm-readahead-pass-readahead_control-to-force_page_cache_ra.patch
* mm-readahead-add-page_cache_sync_ra-and-page_cache_async_ra.patch
* mm-filemap-fold-ra_submit-into-do_sync_mmap_readahead.patch
* mm-readahead-pass-a-file_ra_state-into-force_page_cache_ra.patch
* mmhwpoison-cleanup-unused-pagehuge-check.patch
* mm-hwpoison-remove-recalculating-hpage.patch
* mmhwpoison-inject-dont-pin-for-hwpoison_filter.patch
* mmhwpoison-unexport-get_hwpoison_page-and-make-it-static.patch
* mmhwpoison-refactor-madvise_inject_error.patch
* mmhwpoison-kill-put_hwpoison_page.patch
* mmhwpoison-unify-thp-handling-for-hard-and-soft-offline.patch
* mmhwpoison-rework-soft-offline-for-free-pages.patch
* mmhwpoison-rework-soft-offline-for-in-use-pages.patch
* mmhwpoison-refactor-soft_offline_huge_page-and-__soft_offline_page.patch
* mmhwpoison-return-0-if-the-page-is-already-poisoned-in-soft-offline.patch
* mmhwpoison-introduce-mf_msg_unsplit_thp.patch
* mmhwpoison-double-check-page-count-in-__get_any_page.patch
* mmhwpoison-try-to-narrow-window-race-for-free-pages.patch
* mm-page_poisonc-replace-bool-variable-with-static-key.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
* mm-vmstat-use-helper-macro-abs.patch
* mm-util-update-the-kerneldoc-for-kstrdup_const.patch
* mm-mmu_notifier-fix-mmget-assert-in-__mmu_interval_notifier_insert.patch
* mm-memory_hotplug-inline-__offline_pages-into-offline_pages.patch
* mm-memory_hotplug-enforce-section-granularity-when-onlining-offlining.patch
* mm-memory_hotplug-simplify-page-offlining.patch
* mm-memory_hotplug-simplify-page-offlining-fix.patch
* mm-page_alloc-simplify-__offline_isolated_pages.patch
* mm-memory_hotplug-drop-nr_isolate_pageblock-in-offline_pages.patch
* mm-page_isolation-simplify-return-value-of-start_isolate_page_range.patch
* mm-memory_hotplug-simplify-page-onlining.patch
* mm-page_alloc-drop-stale-pageblock-comment-in-memmap_init_zone.patch
* mm-pass-migratetype-into-memmap_init_zone-and-move_pfn_range_to_zone.patch
* mm-memory_hotplug-mark-pageblocks-migrate_isolate-while-onlining-memory.patch
* kernel-resource-make-release_mem_region_adjustable-never-fail.patch
* kernel-resource-make-release_mem_region_adjustable-never-fail-fix.patch
* kernel-resource-move-and-rename-ioresource_mem_driver_managed.patch
* mm-memory_hotplug-guard-more-declarations-by-config_memory_hotplug.patch
* mm-memory_hotplug-prepare-passing-flags-to-add_memory-and-friends.patch
* mm-memory_hotplug-memhp_merge_resource-to-specify-merging-of-system-ram-resources.patch
* virtio-mem-try-to-merge-system-ram-resources.patch
* xen-balloon-try-to-merge-system-ram-resources.patch
* hv_balloon-try-to-merge-system-ram-resources.patch
* kernel-resource-make-iomem_resource-implicit-in-release_mem_region_adjustable.patch
* mm-dont-panic-when-links-cant-be-created-in-sysfs.patch
* zram-failing-to-decompress-is-warn_on-worthy.patch
* mm-slab-remove-duplicate-include.patch
* mm-page_reporting-drop-stale-list-head-check-in-page_reporting_cycle.patch
* mm-highmem-clean-up-endif-comments.patch
* mm-use-add_page_to_lru_list-page_lru-page_off_lru.patch
* mm-use-self-explanatory-macros-rather-than-2.patch
* mm-fix-some-broken-comments.patch
* mm-fix-some-comments-formatting.patch
* mm-fix-some-doc-warnings-in-workingsetc.patch
* mm-use-helper-function-put_write_access.patch
* mm-remove-unused-early_pfn_valid.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-sysctl-make-protected_-world-readable.patch
* fs-configfs-delete-repeated-words-in-comments.patch
* kernelh-split-out-min-max-et-al-helpers.patch
* kernel-sysc-replace-do_brk-with-do_brk_flags-in-comment-of-prctl_set_mm_map.patch
* get_maintainer-add-test-for-file-in-vcs.patch
* get_maintainer-exclude-maintainers-files-from-git-fallback.patch
* lib-bitmap-delete-duplicated-words.patch
* lib-libcrc32c-delete-duplicated-words.patch
* lib-decompress_bunzip2-delete-duplicated-words.patch
* lib-devres-delete-duplicated-words.patch
* lib-dynamic_queue_limits-delete-duplicated-words-fix-typo.patch
* lib-earlycpio-delete-duplicated-words.patch
* lib-radix-tree-delete-duplicated-words.patch
* lib-syscall-delete-duplicated-words.patch
* lib-test_sysctl-delete-duplicated-words.patch
* lib-mpi-fix-spello-of-functions.patch
* idr-document-calling-context-for-ida-apis-mustnt-use-locks.patch
* idr-document-that-ida_simple_getremove-are-deprecated.patch
* lib-scatterlist-avoid-a-double-memset.patch
* lib-crc32c-fix-trivial-typo-in-preprocessor-condition.patch
* bitops-simplify-get_count_order_long.patch
* bitops-use-the-same-mechanism-for-get_count_order.patch
* checkpatch-add-kconfig-prefix.patch
* checkpatch-move-repeated-word-test.patch
* checkpatch-add-test-for-comma-use-that-should-be-semicolon.patch
* const_structscheckpatch-add-phy_ops.patch
* checkpatch-warn-if-trace_printk-and-friends-are-called.patch
* const_structscheckpatch-add-pinctrl_ops-and-pinmux_ops.patch
* checkpatch-warn-on-self-assignments.patch
* checkpatch-warn-on-self-assignments-checkpatch-fixes.patch
* checkpatch-allow-not-using-f-with-files-that-are-in-git.patch
* checkpatch-allow-not-using-f-with-files-that-are-in-git-fix.patch
* checkpatch-extend-author-signed-off-by-check-for-split-from-header.patch
* fs-binfmt_elf-use-pt_load-p_align-values-for-suitable-start-address.patch
* fs-binfmt_elf-use-pt_load-p_align-values-for-suitable-start-address-fix.patch
* fs-binfmt_elf-use-pt_load-p_align-values-for-suitable-start-address-v4.patch
* add-self-test-for-verifying-load-alignment.patch
* binfmt_elf_fdpic-stop-using-dump_emit-on-user-pointers-on-mmu.patch
* coredump-let-dump_emit-bail-out-on-short-writes.patch
* coredump-refactor-page-range-dumping-into-common-helper.patch
* coredump-rework-elf-elf_fdpic-vma_dump_size-into-common-helper.patch
* binfmt_elf-binfmt_elf_fdpic-use-a-vma-list-snapshot.patch
* mm-gup-take-mmap_lock-in-get_dump_page.patch
* mm-remove-the-now-unnecessary-mmget_still_valid-hack.patch
* harden-autofs-ioctl-table.patch
* rapidio-fix-error-handling-path.patch
* rapidio-fix-the-missed-put_device-for-rio_mport_add_riodev.patch
* panic-dump-registers-on-panic_on_warn.patch
* aio-simplify-read_events.patch
* proc-add-struct-mount-struct-super_block-addr-in-lx-mounts-command.patch
* tasks-add-headers-and-improve-spacing-format.patch
* schedh-drop-in_ubsan-field-when-ubsan-is-in-trap-mode.patch
* ubsan-introducing-config_ubsan_local_bounds-for-clang.patch
* romfs-support-inode-blocks-calculation.patch
* lib-include-linux-add-usercopy-failure-capability.patch
* lib-uaccess-add-failure-injection-to-usercopy-functions.patch
* x86-add-failure-injection-to-get-put-clear_user.patch
  linux-next.patch
  linux-next-rejects.patch
* mm-memremap_pages-convert-to-struct-range-fix.patch
* ia64-fix-build-error-with-coredump.patch
* mm-rework-remote-memcg-charging-api-to-support-nesting.patch
* mm-kmem-move-memcg_kmem_bypass-calls-to-get_mem-obj_cgroup_from_current.patch
* mm-kmem-remove-redundant-checks-from-get_obj_cgroup_from_current.patch
* mm-kmem-prepare-remote-memcg-charging-infra-for-interrupt-contexts.patch
* mm-kmem-enable-kernel-memcg-accounting-from-interrupt-contexts.patch
* mm-memory-failure-remove-a-wrapper-for-alloc_migration_target.patch
* mm-memory_hotplug-remove-a-wrapper-for-alloc_migration_target.patch
* mm-migrate-avoid-possible-unnecessary-process-right-check-in-kernel_move_pages.patch
* mm-mmap-add-inline-vma_next-for-readability-of-mmap-code.patch
* mm-mmap-add-inline-munmap_vma_range-for-code-readability.patch
* mm-madvise-pass-mm-to-do_madvise.patch
* pid-move-pidfd_get_pid-to-pidc.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix-fix.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix-fix-fix.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix-fix-fix-fix.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix-fix-fix-fix-fix.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix-fix-fix-fix-fix-fix.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix-fix-fix-fix-fix-fix-fix.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix-fix-fix-fix-fix-fix-fix-fix.patch
* mm-remove-duplicate-include-statement-in-mmuc.patch
* documentation-remove-cmas-dependency-on-architecture.patch
* mm-add-definition-of-pmd_page_order.patch
* mmap-make-mlock_future_check-global.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas.patch
* arch-mm-wire-up-memfd_secret-system-call-were-relevant.patch
* mm-secretmem-use-pmd-size-pages-to-amortize-direct-map-fragmentation.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
