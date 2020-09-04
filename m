Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C64825E3AB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgIDWY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 18:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgIDWY6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 18:24:58 -0400
Received: from localhost.localdomain (c-71-198-47-131.hsd1.ca.comcast.net [71.198.47.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231CB2083B;
        Fri,  4 Sep 2020 22:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599258296;
        bh=NshJ8NyLn/yzZdUHM/W4/mdo/Xk15yQ7Vs7+LZ08tPs=;
        h=Date:From:To:Subject:From;
        b=yZaGGALAqOVvngMicFtLDh/UGAOHlEHhvGT1kyB6//LIWXqUgNVmz34hISqEMlo46
         JJba9nWRnMMdRWsuWIC7PeJh0HuLha3oc+kGWhtqzHD1xiObbS1y2f0THiJKw8AeLq
         fX23ZP1F/JjaGHfW5X6CdytwFiGjv+AnEfZa9bq8=
Date:   Fri, 04 Sep 2020 15:24:55 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-09-04-15-24 uploaded
Message-ID: <20200904222455.x8co7x95S%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-09-04-15-24 has been uploaded to

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



This mmotm tree contains the following patches against 5.9-rc3:
(patches marked "*" will be included in linux-next)

  origin.patch
* memcg-fix-use-after-free-in-uncharge_batch.patch
* mm-memcg-fix-memcg-reclaim-soft-lockup.patch
* mm-slub-fix-conversion-of-freelist_corrupted.patch
* maintainers-update-cavium-marvell-entries.patch
* maintainers-add-llvm-maintainers.patch
* maintainers-ia64-mark-status-as-odd-fixes-only.patch
* lib-stringc-implement-stpcpy.patch
* mm-track-page-table-modifications-in-__apply_to_page_range.patch
* mm-track-page-table-modifications-in-__apply_to_page_range-fix.patch
* ipc-adjust-proc_ipc_sem_dointvec-definition-to-match-prototype.patch
* fork-adjust-sysctl_max_threads-definition-to-match-prototype.patch
* checkpatch-fix-the-usage-of-capture-group.patch
* mm-gup_benchmark-update-the-documentation-in-kconfig.patch
* mm-madvise-fix-vma-user-after-free.patch
* mm-migrate-fixup-setting-uffd_wp-flag.patch
* mm-rmap-fixup-copying-of-soft-dirty-and-uffd-ptes.patch
* mm-migrate-remove-unnecessary-is_zone_device_page-check.patch
* mm-migrate-preserve-soft-dirty-in-remove_migration_pte.patch
* mm-hugetlb-try-preferred-node-first-when-alloc-gigantic-page-from-cma.patch
* mm-hugetlb-fix-a-race-between-hugetlb-sysctl-handlers.patch
* fix-khugepageds-request-size-in-collapse_file.patch
* log2-add-missing-around-n-in-roundup_pow_of_two.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* fork-silence-a-false-postive-warning-in-__mmdrop.patch
* mm-slub-re-initialize-randomized-freelist-sequence-in-calculate_sizes.patch
* mm-slub-re-initialize-randomized-freelist-sequence-in-calculate_sizes-fix.patch
* mm-thp-swap-fix-allocating-cluster-for-swapfile-by-mistake.patch
* ksm-reinstate-memcg-charge-on-copied-pages.patch
* mm-migration-of-hugetlbfs-page-skip-memcg.patch
* shmem-shmem_writepage-split-unlikely-i915-thp.patch
* mm-fix-check_move_unevictable_pages-on-thp.patch
* mlock-fix-unevictable_pgs-event-counts-on-thp.patch
* tmpfs-restore-functionality-of-nr_inodes=0.patch
* kprobes-fix-kill-kprobe-which-has-been-marked-as-gone.patch
* mm-thp-fix-__split_huge_pmd_locked-for-migration-pmd.patch
* selftests-vm-fix-display-of-page-size-in-map_hugetlb.patch
* mm-memory_hotplug-drain-per-cpu-pages-again-during-memory-offline.patch
* gcov-disable-gcov-build-with-gcc-10.patch
* kcsan-kconfig-move-to-menu-generic-kernel-debugging-instruments.patch
* checkpatch-test-git_dir-changes.patch
* compiler-clang-add-build-check-for-clang-1001.patch
* revert-kbuild-disable-clangs-default-use-of-fmerge-all-constants.patch
* revert-arm64-bti-require-clang-=-1001-for-in-kernel-bti-support.patch
* revert-arm64-vdso-fix-compilation-with-clang-older-than-8.patch
* partially-revert-arm-8905-1-emit-__gnu_mcount_nc-when-using-clang-1000-or-newer.patch
* kasan-remove-mentions-of-unsupported-clang-versions.patch
* compiler-gcc-improve-version-error.patch
* scripts-tagssh-exclude-tools-directory-from-tags-generation.patch
* ntfs-add-check-for-mft-record-size-in-superblock.patch
* fs-ocfs2-delete-repeated-words-in-comments.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* ramfs-support-o_tmpfile.patch
* fs-xattrc-fix-kernel-doc-warnings-for-setxattr-removexattr.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
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
* device-dax-kill-dax_kmem_res.patch
* device-dax-add-an-allocation-interface-for-device-dax-instances.patch
* device-dax-introduce-seed-devices.patch
* drivers-base-make-device_find_child_by_name-compatible-with-sysfs-inputs.patch
* device-dax-add-resize-support.patch
* mm-memremap_pages-convert-to-struct-range.patch
* mm-memremap_pages-support-multiple-ranges-per-invocation.patch
* device-dax-add-dis-contiguous-resource-support.patch
* device-dax-add-dis-contiguous-resource-support-fix.patch
* device-dax-introduce-mapping-devices.patch
* device-dax-make-align-a-per-device-property.patch
* device-dax-make-align-a-per-device-property-fix.patch
* device-dax-add-an-align-attribute.patch
* device-dax-add-an-align-attribute-fixpatch.patch
* dax-hmem-introduce-dax_hmemregion_idle-parameter.patch
* device-dax-add-a-range-mapping-allocation-attribute.patch
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
* mm-debug_vm_pgtable-avoid-none-pte-in-pte_clear_test.patch
* mm-gup_benchmark-use-pin_user_pages-for-foll_longterm-flag.patch
* mm-gup-dont-permit-users-to-call-get_user_pages-with-foll_longterm.patch
* mm-gup-dont-permit-users-to-call-get_user_pages-with-foll_longterm-fix.patch
* swap-rename-swp_fs-to-swap_fs_ops-to-avoid-ambiguity.patch
* mm-remove-activate_page-from-unuse_pte.patch
* mm-remove-superfluous-__clearpageactive.patch
* memremap-convert-devmap-static-branch-to-incdec.patch
* mm-memcontrol-use-flex_array_size-helper-in-memcpy.patch
* mm-memcontrol-use-the-preferred-form-for-passing-the-size-of-a-structure-type.patch
* mm-workingset-ignore-slab-memory-size-when-calculating-shadows-pressure.patch
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
* mm-test-use-the-new-skip-macro.patch
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
* mm-isolation-avoid-checking-unmovable-pages-across-pageblock-boundary.patch
* mm-page_allocc-clean-code-by-removing-unnecessary-initialization.patch
* mm-page_allocc-clean-code-by-removing-unnecessary-initialization-fix.patch
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
* mm-filemap-fix-storing-to-a-thp-shadow-entry.patch
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
* mmhwpoison-un-export-get_hwpoison_page-and-make-it-static.patch
* mmhwpoison-kill-put_hwpoison_page.patch
* mmhwpoison-unify-thp-handling-for-hard-and-soft-offline.patch
* mmhwpoison-rework-soft-offline-for-free-pages.patch
* mmhwpoison-rework-soft-offline-for-in-use-pages.patch
* mmhwpoison-refactor-soft_offline_huge_page-and-__soft_offline_page.patch
* mmhwpoison-refactor-soft_offline_huge_page-and-__soft_offline_page-fix.patch
* mmhwpoison-refactor-soft_offline_huge_page-and-__soft_offline_page-fix-2.patch
* mmhwpoison-return-0-if-the-page-is-already-poisoned-in-soft-offline.patch
* mmhwpoison-introduce-mf_msg_unsplit_thp.patch
* mmhwpoison-double-check-page-count-in-__get_any_page.patch
* mmhwpoison-take-free-pages-off-the-buddy-freelists.patch
* mmhwpoison-refactor-madvise_inject_error.patch
* mmhwpoison-drain-pcplists-before-bailing-out-for-non-buddy-zero-refcount-page.patch
* mmhwpoison-drop-unneeded-pcplist-draining.patch
* mmhwpoison-drop-unneeded-pcplist-draining-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
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
* mm-slab-remove-duplicate-include.patch
* mm-page_reporting-drop-stale-list-head-check-in-page_reporting_cycle.patch
* mm-highmem-clean-up-endif-comments.patch
* mm-use-add_page_to_lru_list-page_lru-page_off_lru.patch
* mm-use-self-explanatory-macros-rather-than-2.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-sysctl-make-protected_-world-readable.patch
* fs-configfs-delete-repeated-words-in-comments.patch
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
* bitops-simplify-get_count_order_long.patch
* bitops-use-the-same-mechanism-for-get_count_order.patch
* checkpatch-add-kconfig-prefix.patch
* checkpatch-move-repeated-word-test.patch
* checkpatch-add-test-for-comma-use-that-should-be-semicolon.patch
* const_structscheckpatch-add-phy_ops.patch
* checkpatch-warn-if-trace_printk-and-friends-are-called.patch
* const_structscheckpatch-add-pinctrl_ops-and-pinmux_ops.patch
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
* panic-dump-registers-on-panic_on_warn.patch
* aio-simplify-read_events.patch
* proc-add-struct-mount-struct-super_block-addr-in-lx-mounts-command.patch
* tasks-add-headers-and-improve-spacing-format.patch
* romfs-support-inode-blocks-calculation.patch
* lib-include-linux-add-usercopy-failure-capability.patch
* lib-uaccess-add-failure-injection-to-usercopy-functions.patch
* x86-add-failure-injection-to-get-put-clear_user.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
* x86-defconfigs-explicitly-unset-config_64bit-in-i386_defconfig.patch
* arch-x86-makefile-use-config_shell.patch
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
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
