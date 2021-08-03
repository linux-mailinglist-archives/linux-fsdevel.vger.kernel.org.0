Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B9F3DE426
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 03:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhHCBwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 21:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233178AbhHCBwO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 21:52:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6012F60F41;
        Tue,  3 Aug 2021 01:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627955523;
        bh=fr3w/gn3PbvFnasNKS5acr58OF6O/FP3m7tsTZLPbY4=;
        h=Date:From:To:Subject:From;
        b=NPbMBjBQY6XJpaFA20SJw4R2jHlhqOlCrNxWVTRdq3j5NVK+7X6YVk5vD9V87I6r/
         Oy0A0jR83h4EJCrZ+2N7Iaiab4AA9Rl309TyBybGo6br+UCTFGRwerKNM7N+Lp/LF9
         mpHzcVpR23BnhCWTwMrzNeQ0hEC21UfUsmukb/fU=
Date:   Mon, 02 Aug 2021 18:52:02 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-08-02-18-51 uploaded
Message-ID: <20210803015202.vA3c5O7uP%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-08-02-18-51 has been uploaded to

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



This mmotm tree contains the following patches against 5.14-rc4:
(patches marked "*" will be included in linux-next)

* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
* mmshmem-fix-a-typo-in-shmem_swapin_page.patch
* slub-fix-kmalloc_pagealloc_invalid_free-unit-test.patch
* mm-slub-fix-slub_debug-disablement-for-list-of-slabs.patch
* mm-madvise-report-sigbus-as-efault-for-madv_populate_readwrite.patch
* mm-memcg-fix-incorrect-flushing-of-lruvec-data-in-obj_stock.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* init-move-usermodehelper_enable-to-populate_rootfs.patch
* scripts-check_extable-fix-typo-in-user-error-message.patch
* scripts-checkversion-modernize-linux-versionh-search-strings.patch
* scripts-recordmcountpl-remove-check_objcopy-and-can_use_local.patch
* ocfs2-remove-an-unnecessary-condition.patch
* ocfs2-reflink-deadlock-when-clone-file-to-the-same-directory-simultaneously.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* lib-fix-bugoncocci-warnings.patch
  mm.patch
* mm-move-kvmalloc-related-functions-to-slabh.patch
* mm-debug_vm_pgtable-introduce-struct-pgtable_debug_args.patch
* mm-debug_vm_pgtable-use-struct-pgtable_debug_args-in-basic-tests.patch
* mm-debug_vm_pgtable-use-struct-pgtable_debug_args-in-leaf-and-savewrite-tests.patch
* mm-debug_vm_pgtable-use-struct-pgtable_debug_args-in-protnone-and-devmap-tests.patch
* mm-debug_vm_pgtable-use-struct-pgtable_debug_args-in-soft_dirty-and-swap-tests.patch
* mm-debug_vm_pgtable-use-struct-pgtable_debug_args-in-migration-and-thp-tests.patch
* mm-debug_vm_pgtable-use-struct-pgtable_debug_args-in-pte-modifying-tests.patch
* mm-debug_vm_pgtable-use-struct-pgtable_debug_args-in-pmd-modifying-tests.patch
* mm-debug_vm_pgtable-use-struct-pgtable_debug_args-in-pud-modifying-tests.patch
* mm-debug_vm_pgtable-use-struct-pgtable_debug_args-in-pgd-and-p4d-modifying-tests.patch
* mm-debug_vm_pgtable-remove-unused-code.patch
* mm-debug_vm_pgtable-fix-corrupted-page-flag.patch
* mm-report-a-more-useful-address-for-reclaim-acquisition.patch
* mm-mark-idle-page-tracking-as-broken.patch
* writeback-track-number-of-inodes-under-writeback.patch
* writeback-reliably-update-bandwidth-estimation.patch
* writeback-fix-bandwidth-estimate-for-spiky-workload.patch
* writeback-rename-domain_update_bandwidth.patch
* writeback-use-read_once-for-unlocked-reads-of-writeback-stats.patch
* mm-remove-irqsave-restore-locking-from-contexts-with-irqs-enabled.patch
* fs-drop_caches-fix-skipping-over-shadow-cache-inodes.patch
* fs-inode-count-invalidated-shadow-pages-in-pginodesteal.patch
* vfs-keep-inodes-with-page-cache-off-the-inode-shrinker-lru.patch
* writeback-memcg-simplify-cgroup_writeback_by_id.patch
* fs-mm-fix-race-in-unlinking-swapfile.patch
* mm-delete-unused-get_kernel_page.patch
* mm-memcg-add-mem_cgroup_disabled-checks-in-vmpressure-and-swap-related-functions.patch
* mm-memcg-inline-mem_cgroup_charge-uncharge-to-improve-disabled-memcg-config.patch
* mm-memcg-inline-swap-related-functions-to-improve-disabled-memcg-config.patch
* memcg-enable-accounting-for-pids-in-nested-pid-namespaces.patch
* memcg-switch-lruvec-stats-to-rstat.patch
* memcg-infrastructure-to-flush-memcg-stats.patch
* memcg-infrastructure-to-flush-memcg-stats-v5.patch
* memcg-charge-fs_context-and-legacy_fs_context.patch
* memcg-enable-accounting-for-mnt_cache-entries.patch
* memcg-enable-accounting-for-pollfd-and-select-bits-arrays.patch
* memcg-enable-accounting-for-file-lock-caches.patch
* memcg-enable-accounting-for-fasync_cache.patch
* memcg-enable-accounting-for-new-namesapces-and-struct-nsproxy.patch
* memcg-enable-accounting-of-ipc-resources.patch
* memcg-enable-accounting-for-signals.patch
* memcg-enable-accounting-for-posix_timers_cache-slab.patch
* memcg-enable-accounting-for-ldt_struct-objects.patch
* memcg-cleanup-racy-sum-avoidance-code.patch
* memcg-replace-in_interrupt-by-in_task-in-active_memcg.patch
* mm-memcontrol-set-the-correct-memcg-swappiness-restriction.patch
* lazy-tlb-introduce-lazy-mm-refcount-helper-functions.patch
* lazy-tlb-introduce-lazy-mm-refcount-helper-functions-fix.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable-fix.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable-fix-2.patch
* lazy-tlb-shoot-lazies-a-non-refcounting-lazy-tlb-option.patch
* lazy-tlb-shoot-lazies-a-non-refcounting-lazy-tlb-option-fix.patch
* powerpc-64s-enable-mmu_lazy_tlb_shootdown.patch
* mmc-jz4740-remove-the-flush_kernel_dcache_page-call-in-jz4740_mmc_read_data.patch
* mmc-mmc_spi-replace-flush_kernel_dcache_page-with-flush_dcache_page.patch
* scatterlist-replace-flush_kernel_dcache_page-with-flush_dcache_page.patch
* mm-remove-flush_kernel_dcache_page.patch
* mmdo_huge_pmd_numa_page-remove-unnecessary-tlb-flushing-code.patch
* mm-change-fault_in_pages_-to-have-an-unsigned-size-parameter.patch
* add-mmap_assert_locked-annotations-to-find_vma.patch
* mm-mremap-fix-memory-account-on-do_munmap-failure.patch
* mm-mremap-dont-account-pages-in-vma_to_resize.patch
* mm-sparse-pass-section_nr-to-section_mark_present.patch
* mm-sparse-pass-section_nr-to-find_memory_block.patch
* mm-sparse-remove-__section_nr-function.patch
* mm-sparse-set-section_nid_shift-to-6.patch
* avoid-a-warning-in-sparse-memory-support.patch
* mm-sparse-clarify-pgdat_to_phys.patch
* mm-vmalloc-use-batched-page-requests-in-bulk-allocator.patch
* mm-vmalloc-remove-gfpflags_allow_blocking-check.patch
* lib-test_vmallocc-add-a-new-nr_pages-parameter.patch
* mm-vmalloc-fix-wrong-behavior-in-vread.patch
* mm-kasan-move-kasanfault-to-mm-kasan-reportc.patch
* mm-page_alloc-always-initialize-memory-map-for-the-holes.patch
* mm-page_alloc-always-initialize-memory-map-for-the-holes-fix.patch
* microblaze-simplify-pte_alloc_one_kernel.patch
* mm-introduce-memmap_alloc-to-unify-memory-map-allocation.patch
* memblock-stop-poisoning-raw-allocations.patch
* fix-zone_id-may-be-used-uninitialized-in-this-function-warning.patch
* mm-page_alloc-make-alloc_node_mem_map-__init-rather-than-__ref.patch
* hugetlb-simplify-prep_compound_gigantic_page-ref-count-racing-code.patch
* hugetlb-drop-ref-count-earlier-after-page-allocation.patch
* hugetlb-before-freeing-hugetlb-page-set-dtor-to-appropriate-value.patch
* mm-numa-automatically-generate-node-migration-order.patch
* mm-migrate-update-node-demotion-order-on-hotplug-events.patch
* mm-migrate-enable-returning-precise-migrate_pages-success-count.patch
* mm-migrate-demote-pages-during-reclaim.patch
* mm-migrate-demote-pages-during-reclaim-v11.patch
* mm-vmscan-add-page-demotion-counter.patch
* mm-vmscan-add-helper-for-querying-ability-to-age-anonymous-pages.patch
* mm-vmscan-add-helper-for-querying-ability-to-age-anonymous-pages-v11.patch
* mm-vmscan-consider-anonymous-pages-without-swap.patch
* mm-vmscan-consider-anonymous-pages-without-swap-v11.patch
* mm-vmscan-never-demote-for-memcg-reclaim.patch
* mm-migrate-add-sysfs-interface-to-enable-reclaim-migration.patch
* mm-vmpressure-replace-vmpressure_to_css-with-vmpressure_to_memcg.patch
* mm-vmscan-remove-the-pagedirty-check-after-madv_free-pages-are-page_ref_freezed.patch
* mm-vmscan-remove-misleading-setting-to-sc-priority.patch
* mm-vmscan-remove-unneeded-return-value-of-kswapd_run.patch
* mm-vmscan-add-else-to-remove-check_pending-label.patch
* mm-compaction-optimize-proactive-compaction-deferrals.patch
* mm-compaction-optimize-proactive-compaction-deferrals-fix.patch
* mm-compaction-support-triggering-of-proactive-compaction-by-user.patch
* mm-compaction-support-triggering-of-proactive-compaction-by-user-fix.patch
* mm-mempolicy-add-mpol_preferred_many-for-multiple-preferred-nodes.patch
* mm-memplicy-add-page-allocation-function-for-mpol_preferred_many-policy.patch
* mm-mempolicy-enable-page-allocation-for-mpol_preferred_many-for-general-cases.patch
* mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many.patch
* mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many-fix.patch
* mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many-fix-2.patch
* mm-mempolicy-advertise-new-mpol_preferred_many.patch
* mm-mempolicy-unify-the-create-func-for-bind-interleave-prefer-many-policies.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt-fix.patch
* mm-mempolicy-use-readable-numa_no_node-macro-instead-of-magic-numer.patch
* oom_kill-oom_score_adj-broken-for-processes-with-small-memory-usage.patch
* mm-thp-make-alloc_split_ptlocks-dependent-on-use_split_pte_ptlocks.patch
* selftests-vm-add-ksm-merge-test.patch
* selftests-vm-add-ksm-unmerge-test.patch
* selftests-vm-add-ksm-zero-page-merging-test.patch
* selftests-vm-add-ksm-merging-across-nodes-test.patch
* selftests-vm-add-ksm-merging-time-test.patch
* selftests-vm-add-cow-time-test-for-ksm-pages.patch
* mm-vmstat-correct-some-wrong-comments.patch
* mm-vmstat-simplify-the-array-size-calculation.patch
* mm-vmstat-remove-unneeded-return-value.patch
* preempt-provide-preempt__nort-variants.patch
* mm-vmstat-protect-per-cpu-variables-with-preempt-disable-on-rt.patch
* memory-hotplugrst-remove-locking-details-from-admin-guide.patch
* memory-hotplugrst-complete-admin-guide-overhaul.patch
* mm-remove-pfn_valid_within-and-config_holes_in_zone.patch
* mm-memory_hotplug-cleanup-after-removal-of-pfn_valid_within.patch
* mm-memory_hotplug-use-unsigned-long-for-pfn-in-zone_for_pfn_range.patch
* mm-memory_hotplug-remove-nid-parameter-from-arch_remove_memory.patch
* mm-memory_hotplug-remove-nid-parameter-from-remove_memory-and-friends.patch
* acpi-memhotplug-memory-resources-cannot-be-enabled-yet.patch
* mm-track-present-early-pages-per-zone.patch
* mm-memory_hotplug-introduce-auto-movable-online-policy.patch
* drivers-base-memory-introduce-memory-groups-to-logically-group-memory-blocks.patch
* mm-memory_hotplug-track-present-pages-in-memory-groups.patch
* acpi-memhotplug-use-a-single-static-memory-group-for-a-single-memory-device.patch
* dax-kmem-use-a-single-static-memory-group-for-a-single-probed-unit.patch
* virtio-mem-use-a-single-dynamic-memory-group-for-a-single-virtio-mem-device.patch
* mm-memory_hotplug-memory-group-aware-auto-movable-online-policy.patch
* mm-memory_hotplug-memory-group-aware-auto-movable-online-policy-fix.patch
* mm-memory_hotplug-improved-dynamic-memory-group-aware-auto-movable-online-policy.patch
* mm-rmap-convert-from-atomic_t-to-refcount_t-on-anon_vma-refcount.patch
* mm-zsmallocc-close-race-window-between-zs_pool_dec_isolated-and-zs_unregister_migration.patch
* mm-zsmallocc-combine-two-atomic-ops-in-zs_pool_dec_isolated.patch
* mm-highmem-remove-deprecated-kmap_atomic.patch
* kfence-show-cpu-and-timestamp-in-alloc-free-info.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* percpu-remove-export-of-pcpu_base_addr.patch
* fs-proc-kcorec-add-mmap-interface.patch
* connector-send-event-on-write-to-proc-comm.patch
* proc-sysctl-make-protected_-world-readable.patch
* arch-kconfig-fix-spelling-mistake-seperate-separate.patch
* once-fix-trivia-typo-not-note.patch
* acct-use-dedicated-helper-to-access-rlimit-values.patch
* math-make-rational-tristate.patch
* math-rational_kunit_test-should-depend-on-rational-instead-of-selecting-it.patch
* lib-string-optimized-memcpy.patch
* lib-string-optimized-memmove.patch
* lib-string-optimized-memset.patch
* lib-test-convert-test_sortc-to-use-kunit.patch
* checkpatch-support-wide-strings.patch
* fs-epoll-use-a-per-cpu-counter-for-users-watches-count.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_create_device_group.patch
* nilfs2-fix-null-pointer-in-nilfs_name_attr_release.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_create_name_group.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_delete_name_group.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_create_snapshot_group.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_delete_snapshot_group.patch
* hfsplus-fix-out-of-bounds-warnings-in-__hfsplus_setxattr.patch
* log-if-a-core-dump-is-aborted-due-to-changed-file-permissions.patch
* log-if-a-core-dump-is-aborted-due-to-changed-file-permissions-fix.patch
* pid-cleanup-the-stale-comment-mentioning-pidmap_init.patch
* prctl-allow-to-setup-brk-for-et_dyn-executables.patch
* configs-remove-the-obsolete-config_input_polldev.patch
* selftests-memfd-remove-unused-variable.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
* kexec-move-locking-into-do_kexec_load.patch
* kexec-avoid-compat_alloc_user_space.patch
* mm-simplify-compat_sys_move_pages.patch
* mm-simplify-compat-numa-syscalls.patch
* mm-simplify-compat-numa-syscalls-fix.patch
* compat-remove-some-compat-entry-points.patch
* arch-remove-compat_alloc_user_space.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
