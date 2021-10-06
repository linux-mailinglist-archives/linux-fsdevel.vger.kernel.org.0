Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6428542361B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 04:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhJFCzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 22:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhJFCzm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:55:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0602C611CA;
        Wed,  6 Oct 2021 02:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633488831;
        bh=OSI3//1rrsUBvYzpx+LB+OZwFNHNhVZtA246OYLmsy0=;
        h=Date:From:To:Subject:From;
        b=K7sT92jz/1JnHEvpc07v4FcEQV3k9F8aknP9MbfqLlOcB4P1djbSsKOrfl7xN97//
         zq+oglZwq41N9zv3MQ3rXQhgJ22S57ltvbqEdPtrPqnORIKsl6crEidkxCZmtVck7A
         57BTAvbzlhyAjetplpnXweuakJjmI5DlYx6EIHA8=
Date:   Tue, 05 Oct 2021 19:53:50 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-10-05-19-53 uploaded
Message-ID: <20211006025350.a5PczFZP4%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-10-05-19-53 has been uploaded to

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



This mmotm tree contains the following patches against 5.15-rc4:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-userfaultfd-selftests-fix-memory-corruption-with-thp-enabled.patch
* userfaultfd-fix-a-race-between-writeprotect-and-exit_mmap.patch
* mm-migrate-optimize-hotplug-time-demotion-order-updates.patch
* mm-migrate-add-cpu-hotplug-to-demotion-ifdef.patch
* mm-migrate-fix-cpuhp-state-to-update-node-demotion-order.patch
* mm-vmalloc-fix-numa-spreading-for-large-hash-tables.patch
* ocfs2-fix-data-corruption-after-conversion-from-inline-format.patch
* ocfs2-mount-fails-with-buffer-overflow-in-strlen.patch
* memblock-check-memory-total_size.patch
* mm-mempolicy-do-not-allow-illegal-mpol_f_numa_balancing-mpol_local-in-mbind.patch
* mm-slub-fix-two-bugs-in-slab_debug_trace_open.patch
* mm-slub-fix-mismatch-between-reconstructed-freelist-depth-and-cnt.patch
* mm-slub-fix-potential-memoryleak-in-kmem_cache_open.patch
* mm-slub-fix-potential-use-after-free-in-slab_debugfs_fops.patch
* mm-slub-fix-incorrect-memcg-slab-count-for-bulk-free.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
* scripts-spellingtxt-add-more-spellings-to-spellingtxt.patch
* scripts-spellingtxt-fix-mistake-version-of-synchronization.patch
* ocfs2-fix-handle-refcount-leak-in-two-exception-handling-paths.patch
* ocfs2-reflink-deadlock-when-clone-file-to-the-same-directory-simultaneously.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* posix-acl-avoid-wempty-body-warning.patch
  mm.patch
* mm-move-kvmalloc-related-functions-to-slabh.patch
* mm-dont-call-should_failslab-for-config_failslab.patch
* mm-dont-call-should_failslab-for-config_failslab-fix.patch
* mm-remove-useless-lines-in-enable_cpucache.patch
* slub-add-back-check-for-free-nonslab-objects.patch
* mm-dont-include-linux-daxh-in-linux-mempolicyh.patch
* mm-smaps-fix-shmem-pte-hole-swap-calculation.patch
* mm-smaps-use-vma-vm_pgoff-directly-when-counting-partial-swap.patch
* mm-smaps-simplify-shmem-handling-of-pte-holes.patch
* mm-debug_vm_pgtable-dont-use-__p000-directly.patch
* mm-remove-bogus-vm_bug_on.patch
* vfs-keep-inodes-with-page-cache-off-the-inode-shrinker-lru.patch
* mm-gup-further-simplify-__gup_device_huge.patch
* mm-swapfile-remove-needless-request_queue-null-pointer-check.patch
* mm-memcg-drop-swp_entry_t-in-mc_handle_file_pte.patch
* memcg-flush-stats-only-if-updated.patch
* memcg-unify-memcg-stat-flushing.patch
* mm-memcg-remove-obsolete-memcg_free_kmem.patch
* memcg-prohibit-unconditional-exceeding-the-limit-of-dying-tasks.patch
* mm-mmapc-fix-a-data-race-of-mm-total_vm.patch
* mm-use-__pfn_to_section-instead-of-open-coding-it.patch
* mm-memory-avoid-unnecessary-kernel-user-pointer-conversion.patch
* mm-shmem-unconditionally-set-pte-dirty-in-mfill_atomic_install_pte.patch
* mm-clear-vmf-pte-after-pte_unmap_same-returns.patch
* mm-drop-first_index-last_index-in-zap_details.patch
* mm-add-zap_skip_check_mapping-helper.patch
* mm-introduce-pmd_install-helper.patch
* mm-remove-redundant-smp_wmb.patch
* documentation-update-pagemap-with-shmem-exceptions.patch
* lazy-tlb-introduce-lazy-mm-refcount-helper-functions.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable.patch
* lazy-tlb-shoot-lazies-a-non-refcounting-lazy-tlb-option.patch
* powerpc-64s-enable-mmu_lazy_tlb_shootdown.patch
* mm-mremap-dont-account-pages-in-vma_to_resize.patch
* mm-vmalloc-repair-warn_allocs-in-__vmalloc_area_node.patch
* mm-vmalloc-dont-allow-vm_no_guard-on-vmap.patch
* mm-vmalloc-make-show_numa_info-aware-of-hugepage-mappings.patch
* mm-vmalloc-make-sure-to-dump-unpurged-areas-in-proc-vmallocinfo.patch
* mm-vmalloc-do-not-adjust-the-search-size-for-alignment-overhead.patch
* mm-vmalloc-check-various-alignments-when-debugging.patch
* kasan-test-add-memcpy-test-that-avoids-out-of-bounds-write.patch
* lib-stackdepot-include-gfph.patch
* lib-stackdepot-remove-unused-function-argument.patch
* lib-stackdepot-introduce-__stack_depot_save.patch
* kasan-common-provide-can_alloc-in-kasan_save_stack.patch
* kasan-generic-introduce-kasan_record_aux_stack_noalloc.patch
* workqueue-kasan-avoid-alloc_pages-when-recording-stack.patch
* kasan-fix-tag-for-large-allocations-when-using-config_slab.patch
* kasan-remove-duplicate-of-kasan_flag_async.patch
* arm64-mte-bitfield-definitions-for-asymm-mte.patch
* arm64-mte-cpu-feature-detection-for-asymm-mte.patch
* arm64-mte-add-asymmetric-mode-support.patch
* kasan-extend-kasan-mode-kernel-parameter.patch
* mm-large-system-hash-avoid-possible-null-deref-in-alloc_large_system_hash.patch
* mm-page_allocc-remove-meaningless-vm_bug_on-in-pindex_to_order.patch
* mm-page_allocc-simplify-the-code-by-using-macro-k.patch
* mm-page_allocc-fix-obsolete-comment-in-free_pcppages_bulk.patch
* mm-page_allocc-use-helper-function-zone_spans_pfn.patch
* mm-page_allocc-avoid-allocating-highmem-pages-via-alloc_pages_exact.patch
* mm-page_alloc-print-node-fallback-order.patch
* mm-page_alloc-use-accumulated-load-when-building-node-fallback-list.patch
* mm-move-node_reclaim_distance-to-fix-numa-without-smp.patch
* mm-move-fold_vm_numa_events-to-fix-numa-without-smp.patch
* mm-do-not-acquire-zone-lock-in-is_free_buddy_page.patch
* mm-page_alloc-detect-allocation-forbidden-by-cpuset-and-bail-out-early.patch
* mm-show-watermark_boost-of-zone-in-zoneinfo.patch
* mm-create-a-new-system-state-and-fix-core_kernel_text.patch
* mm-make-generic-arch_is_kernel_initmem_freed-do-what-it-says.patch
* powerpc-use-generic-version-of-arch_is_kernel_initmem_freed.patch
* s390-use-generic-version-of-arch_is_kernel_initmem_freed.patch
* mm-fix-data-race-in-pagepoisoned.patch
* mm-hugetlb-drop-__unmap_hugepage_range-definition-from-hugetlbh.patch
* hugetlb-add-demote-hugetlb-page-sysfs-interfaces.patch
* mm-cma-add-cma_pages_valid-to-determine-if-pages-are-in-cma.patch
* hugetlb-be-sure-to-free-demoted-cma-pages-to-cma.patch
* hugetlb-add-demote-bool-to-gigantic-page-routines.patch
* hugetlb-add-hugetlb-demote-page-support.patch
* userfaultfd-selftests-dont-rely-on-gnu-extensions-for-random-numbers.patch
* userfaultfd-selftests-fix-feature-support-detection.patch
* userfaultfd-selftests-fix-calculation-of-expected-ioctls.patch
* mm-page_isolation-fix-potential-missing-call-to-unset_migratetype_isolate.patch
* mm-page_isolation-guard-against-possible-putback-unisolated-page.patch
* mm-vmscanc-fix-wunused-but-set-variable-warning.patch
* tools-vm-page_owner_sortc-count-and-sort-by-mem.patch
* tools-vm-page-typesc-make-walk_file-aware-of-address-range-option.patch
* tools-vm-page-typesc-move-show_file-to-summary-output.patch
* tools-vm-page-typesc-print-file-offset-in-hexadecimal.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt-fix.patch
* arch_numa-simplify-numa_distance-allocation.patch
* xen-x86-free_p2m_page-use-memblock_free_ptr-to-free-a-virtual-pointer.patch
* memblock-drop-memblock_free_early_nid-and-memblock_free_early.patch
* memblock-stop-aliasing-__memblock_free_late-with-memblock_free_late.patch
* memblock-rename-memblock_free-to-memblock_phys_free.patch
* memblock-use-memblock_free-for-freeing-virtual-pointers.patch
* mm-mark-the-oom-reaper-thread-as-freezable.patch
* oom_kill-oom_score_adj-broken-for-processes-with-small-memory-usage.patch
* hugetlbfs-extend-the-definition-of-hugepages-parameter-to-support-node-allocation.patch
* mmhugetlb-remove-mlock-ulimit-for-shm_hugetlb.patch
* mm-migrate-de-duplicate-migrate_reason-strings.patch
* mm-nommu-kill-arch_get_unmapped_area.patch
* selftest-vm-fix-ksm-selftest-to-run-with-different-numa-topologies.patch
* mm-vmstat-annotate-data-race-for-zone-free_areanr_free.patch
* mm-vmstat-annotate-data-race-for-zone-free_areanr_free-fix.patch
* mm-memory_hotplug-add-static-qualifier-for-online_policy_to_str.patch
* memory-hotplugrst-fix-two-instances-of-movablecore-that-should-be-movable_node.patch
* memory-hotplugrst-fix-wrong-sys-module-memory_hotplug-parameters-path.patch
* memory-hotplugrst-document-the-auto-movable-online-policy.patch
* mm-memory_hotplug-remove-config_x86_64_acpi_numa-dependency-from-config_memory_hotplug.patch
* mm-memory_hotplug-remove-config_memory_hotplug_sparse.patch
* mm-memory_hotplug-restrict-config_memory_hotplug-to-64-bit.patch
* mm-memory_hotplug-remove-highmem-leftovers.patch
* mm-memory_hotplug-remove-stale-function-declarations.patch
* x86-remove-memory-hotplug-support-on-x86_32.patch
* mm-memory_hotplug-handle-memblock_add_node-failures-in-add_memory_resource.patch
* memblock-improve-memblock_hotplug-documentation.patch
* memblock-allow-to-specify-flags-with-memblock_add_node.patch
* memblock-add-memblock_driver_managed-to-mimic-ioresource_sysram_driver_managed.patch
* mm-memory_hotplug-indicate-memblock_driver_managed-with-ioresource_sysram_driver_managed.patch
* mm-memory_hotplug-make-hwpoisoned-dirty-swapcache-pages-unmovable.patch
* mm-rmap-convert-from-atomic_t-to-refcount_t-on-anon_vma-refcount.patch
* mm-disable-zsmalloc-on-preempt_rt.patch
* mm-zsmallocc-close-race-window-between-zs_pool_dec_isolated-and-zs_unregister_migration.patch
* mm-zsmallocc-combine-two-atomic-ops-in-zs_pool_dec_isolated.patch
* mm-highmem-remove-deprecated-kmap_atomic.patch
* zram_drv-allow-reclaim-on-bio_alloc.patch
* zram-off-by-one-in-read_block_state.patch
* zram-introduce-an-aged-idle-interface.patch
* zram-introduce-an-aged-idle-interface-v5.patch
* zram-introduce-an-aged-idle-interface-v6.patch
* mm-remove-hardened_usercopy_fallback.patch
* include-linux-mmh-move-nr_free_buffer_pages-from-swaph-to-mmh.patch
* stacktrace-move-filter_irq_stacks-to-kernel-stacktracec.patch
* kfence-count-unexpectedly-skipped-allocations.patch
* kfence-move-saving-stack-trace-of-allocations-into-__kfence_alloc.patch
* kfence-limit-currently-covered-allocations-when-pool-nearly-full.patch
* kfence-limit-currently-covered-allocations-when-pool-nearly-full-fix.patch
* kfence-limit-currently-covered-allocations-when-pool-nearly-full-fix-fix.patch
* kfence-add-note-to-documentation-about-skipping-covered-allocations.patch
* kfence-test-use-kunit_skip-to-skip-tests.patch
* kfence-shorten-critical-sections-of-alloc-free.patch
* mm-damon-grammar-s-works-work.patch
* documentation-vm-move-user-guides-to-admin-guide-mm.patch
* maintainers-update-seongjaes-email-address.patch
* docs-vm-damon-remove-broken-reference.patch
* include-linux-damonh-fix-kernel-doc-comments-for-damon_callback.patch
* mm-damon-core-print-kdamond-start-log-in-debug-mode-only.patch
* mm-damon-remove-unnecessary-do_exit-from-kdamond.patch
* mm-damon-neednt-hold-kdamond_lock-to-print-pid-of-kdamond.patch
* mm-damon-core-nullify-pointer-ctx-kdamond-with-a-null.patch
* mm-damon-core-account-age-of-target-regions.patch
* mm-damon-core-implement-damon-based-operation-schemes-damos.patch
* mm-damon-vaddr-support-damon-based-operation-schemes.patch
* mm-damon-dbgfs-support-damon-based-operation-schemes.patch
* mm-damon-schemes-implement-statistics-feature.patch
* selftests-damon-add-schemes-debugfs-tests.patch
* docs-admin-guide-mm-damon-document-damon-based-operation-schemes.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* procfs-do-not-list-tid-0-in-proc-pid-task.patch
* procfs-do-not-list-tid-0-in-proc-pid-task-fix.patch
* x86-xen-update-xen_oldmem_pfn_is_ram-documentation.patch
* x86-xen-simplify-xen_oldmem_pfn_is_ram.patch
* x86-xen-print-a-warning-when-hvmop_get_mem_type-fails.patch
* proc-vmcore-let-pfn_is_ram-return-a-bool.patch
* proc-vmcore-convert-oldmem_pfn_is_ram-callback-to-more-generic-vmcore-callbacks.patch
* virtio-mem-factor-out-hotplug-specifics-from-virtio_mem_init-into-virtio_mem_init_hotplug.patch
* virtio-mem-factor-out-hotplug-specifics-from-virtio_mem_probe-into-virtio_mem_init_hotplug.patch
* virtio-mem-factor-out-hotplug-specifics-from-virtio_mem_remove-into-virtio_mem_deinit_hotplug.patch
* virtio-mem-kdump-mode-to-sanitize-proc-vmcore-access.patch
* proc-allow-pid_revalidate-during-lookup_rcu.patch
* proc-sysctl-make-protected_-world-readable.patch
* lib-stackdepot-check-stackdepot-handle-before-accessing-slabs.patch
* lib-stackdepot-add-helper-to-print-stack-entries.patch
* lib-stackdepot-add-helper-to-print-stack-entries-into-buffer.patch
* lib-stackdepot-add-helper-to-print-stack-entries-into-buffer-v2.patch
* lib-stackdepot-add-helper-to-print-stack-entries-into-buffer-v3.patch
* lib-string_helpers-add-linux-stringh-for-strlen.patch
* lib-uninline-simple_strntoull-as-well.patch
* const_structscheckpatch-add-a-few-sound-ops-structs.patch
* binfmt_elf-reintroduce-using-map_fixed_noreplace.patch
* elf-fix-overflow-in-total-mapping-size-calculation.patch
* elf-simplify-stack_alloc-macro.patch
* kallsyms-remove-arch-specific-text-and-data-check.patch
* kallsyms-fix-address-checks-for-kernel-related-range.patch
* sections-move-and-rename-core_kernel_data-to-is_kernel_core_data.patch
* sections-move-is_kernel_inittext-into-sectionsh.patch
* x86-mm-rename-__is_kernel_text-to-is_x86_32_kernel_text.patch
* sections-provide-internal-__is_kernel-and-__is_kernel_text-helper.patch
* mm-kasan-use-is_kernel-helper.patch
* extable-use-is_kernel_text-helper.patch
* powerpc-mm-use-core_kernel_text-helper.patch
* microblaze-use-is_kernel_text-helper.patch
* alpha-use-is_kernel_text-helper.patch
* ramfs-fix-mount-source-show-for-ramfs.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* coda-avoid-null-pointer-dereference-from-a-bad-inode.patch
* coda-check-for-async-upcall-request-using-local-state.patch
* coda-remove-err-which-no-one-care.patch
* coda-avoid-flagging-null-inodes.patch
* coda-avoid-hidden-code-duplication-in-rename.patch
* coda-avoid-doing-bad-things-on-inode-type-changes-during-revalidation.patch
* coda-convert-from-atomic_t-to-refcount_t-on-coda_vm_ops-refcnt.patch
* coda-use-vmemdup_user-to-replace-the-open-code.patch
* coda-bump-module-version-to-72.patch
* hfs-hfsplus-use-warn_on-for-sanity-check.patch
* hfsplus-fix-out-of-bounds-warnings-in-__hfsplus_setxattr.patch
* seq_file-move-seq_escape-to-a-header.patch
* unshare-use-swap-to-make-code-cleaner.patch
* sysv-use-build_bug_on-instead-of-runtime-check.patch
* documentation-kcov-include-typesh-in-the-example.patch
* documentation-kcov-define-ip-in-the-example.patch
* kcov-allocate-per-cpu-memory-on-the-relevant-node.patch
* kcov-avoid-enabledisable-interrupts-if-in_task.patch
* kcov-replace-local_irq_save-with-a-local_lock_t.patch
* kernel-resource-clean-up-and-optimize-iomem_is_exclusive.patch
* kernel-resource-disallow-access-to-exclusive-system-ram-regions.patch
* virtio-mem-disallow-mapping-virtio-mem-memory-via-dev-mem.patch
* ipc-check-checkpoint_restore_ns_capable-to-modify-c-r-proc-files.patch
* ipc-check-checkpoint_restore_ns_capable-to-modify-c-r-proc-files-fix.patch
* ipc-ipc_sysctlc-remove-fallback-for-config_proc_sysctl.patch
  linux-next.patch
  linux-next-git-rejects.patch
* mm-migrate-simplify-the-file-backed-pages-validation-when-migrating-its-mapping.patch
* mm-unexport-folio_memcg_unlock.patch
* mm-unexport-unlock_page_memcg.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
