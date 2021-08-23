Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031703F53B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhHWXoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 19:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233317AbhHWXoO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:44:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E526760F4A;
        Mon, 23 Aug 2021 23:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629762210;
        bh=2ltl3r6DoyVKs2nH1wOO4rz0Tx+oA6NK1AXnHkwVPx0=;
        h=Date:From:To:Subject:From;
        b=y3TnpTqhsyRHpkSdxB62d+gBzkdZOnyWkm3DGS/dsBK0cw7GLcdvzaR/YozUZ8a4Y
         Ovug+bnYcN0HAI8/RHT/0SzVPZlm9HPa+c3h+0WaqZW4ksDUD2f1/SJYkxWTT/U6g3
         +qJjdhWUA4T9GowiiSt+XunEmalaOu4EqtUDIn9A=
Date:   Mon, 23 Aug 2021 16:43:29 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-08-23-16-42 uploaded
Message-ID: <20210823234329.H9WD-du1K%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-08-23-16-42 has been uploaded to

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



This mmotm tree contains the following patches against 5.14-rc7:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-memory_hotplug-fix-potential-permanent-lru-cache-disable.patch
* mm-remove-bogus-vm_bug_on.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
* ia64-fix-typo-in-a-comment.patch
* ocfs2-remove-an-unnecessary-condition.patch
* ocfs2-quota_local-fix-possible-uninitialized-variable-access-in-ocfs2_local_read_info.patch
* ocfs2-reflink-deadlock-when-clone-file-to-the-same-directory-simultaneously.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* lib-fix-bugoncocci-warnings.patch
  mm.patch
* mm-slub-dont-call-flush_all-from-slab_debug_trace_open.patch
* mm-slub-allocate-private-object-map-for-debugfs-listings.patch
* mm-slub-allocate-private-object-map-for-validate_slab_cache.patch
* mm-slub-dont-disable-irq-for-debug_check_no_locks_freed.patch
* mm-slub-remove-redundant-unfreeze_partials-from-put_cpu_partial.patch
* mm-slub-unify-cmpxchg_double_slab-and-__cmpxchg_double_slab.patch
* mm-slub-extract-get_partial-from-new_slab_objects.patch
* mm-slub-dissolve-new_slab_objects-into-___slab_alloc.patch
* mm-slub-return-slab-page-from-get_partial-and-set-c-page-afterwards.patch
* mm-slub-restructure-new-page-checks-in-___slab_alloc.patch
* mm-slub-simplify-kmem_cache_cpu-and-tid-setup.patch
* mm-slub-move-disabling-enabling-irqs-to-___slab_alloc.patch
* mm-slub-do-initial-checks-in-___slab_alloc-with-irqs-enabled.patch
* mm-slub-do-initial-checks-in-___slab_alloc-with-irqs-enabled-fix.patch
* mm-slub-do-initial-checks-in-___slab_alloc-with-irqs-enabled-fix-fix.patch
* mm-slub-move-disabling-irqs-closer-to-get_partial-in-___slab_alloc.patch
* mm-slub-restore-irqs-around-calling-new_slab.patch
* mm-slub-validate-slab-from-partial-list-or-page-allocator-before-making-it-cpu-slab.patch
* mm-slub-check-new-pages-with-restored-irqs.patch
* mm-slub-stop-disabling-irqs-around-get_partial.patch
* mm-slub-move-reset-of-c-page-and-freelist-out-of-deactivate_slab.patch
* mm-slub-make-locking-in-deactivate_slab-irq-safe.patch
* mm-slub-call-deactivate_slab-without-disabling-irqs.patch
* mm-slub-move-irq-control-into-unfreeze_partials.patch
* mm-slub-discard-slabs-in-unfreeze_partials-without-irqs-disabled.patch
* mm-slub-detach-whole-partial-list-at-once-in-unfreeze_partials.patch
* mm-slub-separate-detaching-of-partial-list-in-unfreeze_partials-from-unfreezing.patch
* mm-slub-only-disable-irq-with-spin_lock-in-__unfreeze_partials.patch
* mm-slub-dont-disable-irqs-in-slub_cpu_dead.patch
* mm-slab-make-flush_slab-possible-to-call-with-irqs-enabled.patch
* mm-slub-move-flush_cpu_slab-invocations-__free_slab-invocations-out-of-irq-context.patch
* mm-slub-move-flush_cpu_slab-invocations-__free_slab-invocations-out-of-irq-context-fix.patch
* mm-slub-move-flush_cpu_slab-invocations-__free_slab-invocations-out-of-irq-context-fix-2.patch
* mm-slub-make-object_map_lock-a-raw_spinlock_t.patch
* mm-slub-optionally-save-restore-irqs-in-slab_lock.patch
* mm-slub-make-slab_lock-disable-irqs-with-preempt_rt.patch
* mm-slub-protect-put_cpu_partial-with-disabled-irqs-instead-of-cmpxchg.patch
* mm-slub-use-migrate_disable-on-preempt_rt.patch
* mm-slub-convert-kmem_cpu_slab-protection-to-local_lock.patch
* mm-slub-convert-kmem_cpu_slab-protection-to-local_lock-fix.patch
* mm-slub-convert-kmem_cpu_slab-protection-to-local_lock-fix-2.patch
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
* mm-add-kernel_misc_reclaimable-in-show_free_areas.patch
* mm-mark-idle-page-tracking-as-broken.patch
* writeback-track-number-of-inodes-under-writeback.patch
* writeback-reliably-update-bandwidth-estimation.patch
* writeback-fix-bandwidth-estimate-for-spiky-workload.patch
* writeback-fix-bandwidth-estimate-for-spiky-workload-fix.patch
* writeback-rename-domain_update_bandwidth.patch
* writeback-use-read_once-for-unlocked-reads-of-writeback-stats.patch
* mm-remove-irqsave-restore-locking-from-contexts-with-irqs-enabled.patch
* fs-drop_caches-fix-skipping-over-shadow-cache-inodes.patch
* fs-inode-count-invalidated-shadow-pages-in-pginodesteal.patch
* vfs-keep-inodes-with-page-cache-off-the-inode-shrinker-lru.patch
* writeback-memcg-simplify-cgroup_writeback_by_id.patch
* mm-gup-remove-set-but-unused-local-variable-major.patch
* mm-gup-remove-unneed-local-variable-orig_refs.patch
* mm-gup-remove-useless-bug_on-in-__get_user_pages.patch
* mm-gup-fix-potential-pgmap-refcnt-leak-in-__gup_device_huge.patch
* mm-gup-fix-potential-pgmap-refcnt-leak-in-__gup_device_huge-fix.patch
* mm-gup-fix-potential-pgmap-refcnt-leak-in-__gup_device_huge-fix-fix.patch
* mm-gup-use-helper-page_aligned-in-populate_vma_page_range.patch
* mm-gup-documentation-corrections-for-gup-pup.patch
* mm-gup-small-refactoring-simplify-try_grab_page.patch
* mm-gup-remove-try_get_page-call-try_get_compound_head-directly.patch
* fs-mm-fix-race-in-unlinking-swapfile.patch
* mm-delete-unused-get_kernel_page.patch
* shmem-use-raw_spinlock_t-for-stat_lock.patch
* shmem-remove-unneeded-variable-ret.patch
* shmem-remove-unneeded-header-file.patch
* shmem-remove-unneeded-function-forward-declaration.patch
* shmem-include-header-file-to-declare-swap_info.patch
* huge-tmpfs-fix-fallocatevanilla-advance-over-huge-pages.patch
* huge-tmpfs-fix-split_huge_page-after-falloc_fl_keep_size.patch
* huge-tmpfs-remove-shrinklist-addition-from-shmem_setattr.patch
* huge-tmpfs-revert-shmems-use-of-transhuge_vma_enabled.patch
* huge-tmpfs-move-shmem_huge_enabled-upwards.patch
* huge-tmpfs-sgp_noalloc-to-stop-collapse_file-on-race.patch
* huge-tmpfs-shmem_is_hugevma-inode-index.patch
* huge-tmpfs-decide-statst_blksize-by-shmem_is_huge.patch
* shmem-shmem_writepage-split-unlikely-i915-thp.patch
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
* mm-memcg-remove-unused-functions.patch
* mm-memcg-save-some-atomic-ops-when-flush-is-already-true.patch
* memcg-fix-up-drain_local_stock-comment.patch
* selftests-vm-use-kselftest-skip-code-for-skipped-tests.patch
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
* add-mmap_assert_locked-annotations-to-find_vma-fix.patch
* remap_file_pages-use-vma_lookup-instead-of-find_vma.patch
* mm-mremap-fix-memory-account-on-do_munmap-failure.patch
* mm-mremap-dont-account-pages-in-vma_to_resize.patch
* mm-bootmem_info-mark-__init-on-register_page_bootmem_info_section.patch
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
* kasan-test-rework-kmalloc_oob_right.patch
* kasan-test-avoid-writing-invalid-memory.patch
* kasan-test-avoid-corrupting-memory-via-memset.patch
* kasan-test-disable-kmalloc_memmove_invalid_size-for-hw_tags.patch
* kasan-test-only-do-kmalloc_uaf_memset-for-generic-mode.patch
* kasan-test-clean-up-ksize_uaf.patch
* kasan-test-avoid-corrupting-memory-in-copy_user_test.patch
* kasan-test-avoid-corrupting-memory-in-kasan_rcu_uaf.patch
* mm-page_alloc-always-initialize-memory-map-for-the-holes.patch
* mm-page_alloc-always-initialize-memory-map-for-the-holes-fix.patch
* microblaze-simplify-pte_alloc_one_kernel.patch
* mm-introduce-memmap_alloc-to-unify-memory-map-allocation.patch
* memblock-stop-poisoning-raw-allocations.patch
* fix-zone_id-may-be-used-uninitialized-in-this-function-warning.patch
* mm-page_alloc-make-alloc_node_mem_map-__init-rather-than-__ref.patch
* mm-use-in_task-in-mm-page_allocc.patch
* mm-hwpoison-remove-unneeded-variable-unmap_success.patch
* mm-hwpoison-fix-potential-pte_unmap_unlock-pte-error.patch
* mm-hwpoison-change-argument-struct-page-hpagep-to-hpage.patch
* mm-hwpoison-fix-some-obsolete-comments.patch
* mm-hwpoison-dont-drop-slab-caches-for-offlining-non-lru-page.patch
* doc-hwpoison-correct-the-support-for-hugepage.patch
* mm-hwpoison-dump-page-for-unhandlable-page.patch
* hugetlb-simplify-prep_compound_gigantic_page-ref-count-racing-code.patch
* hugetlb-drop-ref-count-earlier-after-page-allocation.patch
* hugetlb-before-freeing-hugetlb-page-set-dtor-to-appropriate-value.patch
* userfaultfd-change-mmap_changing-to-atomic.patch
* userfaultfd-prevent-concurrent-api-initialization.patch
* selftests-vm-userfaultfd-wake-after-copy-failure.patch
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
* mm-vmscan-guarantee-drop_slab_node-termination.patch
* mm-compaction-optimize-proactive-compaction-deferrals.patch
* mm-compaction-optimize-proactive-compaction-deferrals-fix.patch
* mm-compaction-support-triggering-of-proactive-compaction-by-user.patch
* mm-compaction-support-triggering-of-proactive-compaction-by-user-fix.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt-fix.patch
* mm-mempolicy-use-readable-numa_no_node-macro-instead-of-magic-numer.patch
* mm-mempolicy-add-mpol_preferred_many-for-multiple-preferred-nodes.patch
* mm-memplicy-add-page-allocation-function-for-mpol_preferred_many-policy.patch
* mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many.patch
* mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many-fix.patch
* mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many-fix-fix.patch
* mm-mempolicy-advertise-new-mpol_preferred_many.patch
* mm-mempolicy-unify-the-create-func-for-bind-interleave-prefer-many-policies.patch
* mm-use-in_task-in-mempolicy_slab_node.patch
* memblock-make-memblock_find_in_range-method-private.patch
* mm-introduce-process_mrelease-system-call.patch
* mm-wire-up-syscall-process_mrelease.patch
* oom_kill-oom_score_adj-broken-for-processes-with-small-memory-usage.patch
* mm-migrate-correct-kernel-doc-notation.patch
* mm-thp-make-alloc_split_ptlocks-dependent-on-use_split_pte_ptlocks.patch
* selftests-vm-add-ksm-merge-test.patch
* selftests-vm-add-ksm-unmerge-test.patch
* selftests-vm-add-ksm-zero-page-merging-test.patch
* selftests-vm-add-ksm-merging-across-nodes-test.patch
* mm-ksm-fix-data-type.patch
* selftests-vm-add-ksm-merging-time-test.patch
* selftests-vm-add-cow-time-test-for-ksm-pages.patch
* mm-vmstat-correct-some-wrong-comments.patch
* mm-vmstat-simplify-the-array-size-calculation.patch
* mm-vmstat-remove-unneeded-return-value.patch
* mm-vmstat-protect-per-cpu-variables-with-preempt-disable-on-rt.patch
* mm-madvise-add-madv_willneed-to-process_madvise.patch
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
* mm-memory_hotplug-improved-dynamic-memory-group-aware-auto-movable-online-policy.patch
* mm-memory_hotplug-use-helper-zone_is_zone_device-to-simplify-the-code.patch
* mm-memory_hotplug-make-hwpoisoned-dirty-swapcache-pages-unmovable.patch
* mm-remove-redundant-compound_head-calling.patch
* mm-rmap-convert-from-atomic_t-to-refcount_t-on-anon_vma-refcount.patch
* mm-zsmallocc-close-race-window-between-zs_pool_dec_isolated-and-zs_unregister_migration.patch
* mm-zsmallocc-combine-two-atomic-ops-in-zs_pool_dec_isolated.patch
* highmem-dont-disable-preemption-on-rt-in-kmap_atomic.patch
* mm-highmem-remove-deprecated-kmap_atomic.patch
* mm-in_irq-cleanup.patch
* mm-introduce-pageflags_mask-to-replace-1ul-nr_pageflags-1.patch
* mm-secretmem-use-refcount_t-instead-of-atomic_t.patch
* kfence-show-cpu-and-timestamp-in-alloc-free-info.patch
* mm-introduce-data-access-monitor-damon.patch
* mm-damon-core-implement-region-based-sampling.patch
* mm-damon-adaptively-adjust-regions.patch
* mm-idle_page_tracking-make-pg_idle-reusable.patch
* mm-idle_page_tracking-make-pg_idle-reusable-fix.patch
* mm-idle_page_tracking-make-pg_idle-reusable-fix-fix.patch
* mm-idle_page_tracking-make-pg_idle-reusable-fix-2.patch
* mm-damon-implement-primitives-for-the-virtual-memory-address-spaces.patch
* mm-damon-implement-primitives-for-the-virtual-memory-address-spaces-fix.patch
* mm-damon-implement-primitives-for-the-virtual-memory-address-spaces-fix-2.patch
* mm-damon-add-a-tracepoint.patch
* mm-damon-implement-a-debugfs-based-user-space-interface.patch
* mm-damon-implement-a-debugfs-based-user-space-interface-fix.patch
* mm-damon-implement-a-debugfs-based-user-space-interface-fix-fix.patch
* mm-damon-dbgfs-export-kdamond-pid-to-the-user-space.patch
* mm-damon-dbgfs-support-multiple-contexts.patch
* documentation-add-documents-for-damon.patch
* mm-damon-add-kunit-tests.patch
* mm-damon-add-user-space-selftests.patch
* maintainers-update-for-damon.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* alpha-agp-make-empty-macros-use-do-while-0-style.patch
* alpha-pci-sysfs-fix-all-kernel-doc-warnings.patch
* percpu-remove-export-of-pcpu_base_addr.patch
* fs-proc-kcorec-add-mmap-interface.patch
* proc-stop-using-seq_get_buf-in-proc_task_name.patch
* connector-send-event-on-write-to-proc-comm.patch
* proc-sysctl-make-protected_-world-readable.patch
* arch-kconfig-fix-spelling-mistake-seperate-separate.patch
* once-fix-trivia-typo-not-note.patch
* units-change-from-l-to-ul.patch
* units-add-the-hz-macros.patch
* thermal-drivers-devfreq_cooling-use-hz-macros.patch
* devfreq-use-hz-macros.patch
* iio-drivers-as73211-use-hz-macros.patch
* hwmon-drivers-mr75203-use-hz-macros.patch
* iio-drivers-hid-sensor-use-hz-macros.patch
* i2c-drivers-ov02q10-use-hz-macros.patch
* mtd-drivers-nand-use-hz-macros.patch
* phy-drivers-stm32-use-hz-macros.patch
* acct-use-dedicated-helper-to-access-rlimit-values.patch
* math-make-rational-tristate.patch
* math-rational_kunit_test-should-depend-on-rational-instead-of-selecting-it.patch
* lib-string-optimized-memcpy.patch
* lib-string-optimized-memmove.patch
* lib-string-optimized-memset.patch
* lib-test-convert-test_sortc-to-use-kunit.patch
* lib-dump_stack-correct-kernel-doc-notation.patch
* lib-iov_iterc-fix-kernel-doc-warnings.patch
* bitops-protect-find_first_zero_bit-properly.patch
* bitops-move-find_bit__le-functions-from-leh-to-findh.patch
* include-move-findh-from-asm_generic-to-linux.patch
* arch-remove-generic_find_first_bit-entirely.patch
* lib-add-find_first_and_bit.patch
* cpumask-use-find_first_and_bit.patch
* all-replace-find_next_zero_bit-with-find_first_zero_bit-where-appropriate.patch
* tools-sync-tools-bitmap-with-mother-linux.patch
* cpumask-replace-cpumask_next_-with-cpumask_first_-where-appropriate.patch
* include-linux-move-for_each_bit-macros-from-bitopsh-to-findh.patch
* find-micro-optimize-for_each_setclear_bit.patch
* replace-for_each__bit_from-with-for_each__bit-where-appropriate.patch
* tools-rename-bitmap_alloc-to-bitmap_zalloc.patch
* mm-percpu-micro-optimize-pcpu_is_populated.patch
* bitmap-unify-find_bit-operations.patch
* lib-bitmap-add-performance-test-for-bitmap_print_to_pagebuf.patch
* vsprintf-rework-bitmap_list_string.patch
* vsprintf-rework-bitmap_list_string-fix.patch
* checkpatch-support-wide-strings.patch
* checkpatch-make-email-address-check-case-insensitive.patch
* checkpatch-improve-git_commit_id-test.patch
* checkpatch-improve-git_commit_id-test-fix.patch
* fs-epoll-use-a-per-cpu-counter-for-users-watches-count.patch
* fs-epoll-use-a-per-cpu-counter-for-users-watches-count-fix.patch
* fs-epoll-use-a-per-cpu-counter-for-users-watches-count-fix-fix.patch
* ramfs-fix-mount-source-show-for-ramfs.patch
* init-move-usermodehelper_enable-to-populate_rootfs.patch
* trap-cleanup-trap_init.patch
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
* coredump-fix-memleak-in-dump_vma_snapshot.patch
* kernel-unexport-get_mmtask_exe_file.patch
* pid-cleanup-the-stale-comment-mentioning-pidmap_init.patch
* prctl-allow-to-setup-brk-for-et_dyn-executables.patch
* configs-remove-the-obsolete-config_input_polldev.patch
* kconfigdebug-drop-selecting-non-existing-hardlockup_detector_arch.patch
* selftests-memfd-remove-unused-variable.patch
* ipc-replace-costly-bailout-check-in-sysvipc_find_ipc.patch
  linux-next.patch
  linux-next-rejects.patch
* mm-workingset-correct-kernel-doc-notations.patch
* mm-move-kvmalloc-related-functions-to-slabh.patch
* mm-migrate-simplify-the-file-backed-pages-validation-when-migrating-its-mapping.patch
* mm-migrate-introduce-a-local-variable-to-get-the-number-of-pages.patch
* mm-migrate-fix-the-incorrect-function-name-in-comments.patch
* mm-migrate-change-to-use-bool-type-for-page_was_mapped.patch
* mm-unexport-folio_memcg_unlock.patch
* mm-unexport-unlock_page_memcg.patch
* compiler-attributes-add-__alloc_size-for-better-bounds-checking.patch
* compiler-attributes-add-__alloc_size-for-better-bounds-checking-fix.patch
* checkpatch-add-__alloc_size-to-known-attribute.patch
* slab-clean-up-function-declarations.patch
* slab-add-__alloc_size-attributes-for-better-bounds-checking.patch
* mm-page_alloc-add-__alloc_size-attributes-for-better-bounds-checking.patch
* percpu-add-__alloc_size-attributes-for-better-bounds-checking.patch
* mm-vmalloc-add-__alloc_size-attributes-for-better-bounds-checking.patch
* scripts-check_extable-fix-typo-in-user-error-message.patch
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
