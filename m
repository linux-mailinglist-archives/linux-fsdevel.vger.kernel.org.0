Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65425413E28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 01:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhIUX4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 19:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhIUX4I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 19:56:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8500E610A1;
        Tue, 21 Sep 2021 23:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632268477;
        bh=rcMcMVou3tsD5zDoDQ84q7losgPrnq29lRr/6GzIb5Q=;
        h=Date:From:To:Subject:From;
        b=QptiPt1LDZXJ1j4ddARAOHewStQ1dXoEQ2Bqg3y8qn53JaDtZPk2DorW6CK2HmJUE
         RJ/3L1LQzkveeHr6XEQmhf0khDlWggcyOqhDvdQodtulUXt6KeEdexAAidqLxKULZ5
         Ogm+CBX0rYgPw7nWffmz3yt9HzzCNFnwbNnYLO0c=
Date:   Tue, 21 Sep 2021 16:54:37 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-09-21-16-54 uploaded
Message-ID: <20210921235437.zcAiZPmxd%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-09-21-16-54 has been uploaded to

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



This mmotm tree contains the following patches against 5.15-rc2:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-hwpoison-add-is_free_buddy_page-in-hwpoisonhandlable.patch
* kasan-fix-kconfig-check-of-cc_has_working_nosanitize_address.patch
* mm-damon-dont-use-strnlen-with-known-bogus-source-length.patch
* xtensa-increase-size-of-gcc-stack-frame-check.patch
* fix-judgment-error-in-shmem_is_huge.patch
* ocfs2-drop-acl-cache-for-directories-too.patch
* scripts-sorttable-riscv-fix-undelcred-identifier-em_riscv-error.patch
* tools-vm-page-types-remove-dependency-on-opt_file-for-idle-page-tracking.patch
* lib-zlib_inflate-inffast-check-config-in-c-to-avoid-unused-function-warning.patch
* mm-fs-invalidate-bh_lrus-for-only-cold-path.patch
* mm-debug-sync-up-mr_contig_range-and-mr_longterm_pin.patch
* mm-debug-sync-up-latest-migrate_reason-to-migrate_reason_names.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
* scripts-spellingtxt-add-more-spellings-to-spellingtxt.patch
* ocfs2-fix-handle-refcount-leak-in-two-exception-handling-paths.patch
* ocfs2-reflink-deadlock-when-clone-file-to-the-same-directory-simultaneously.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
  mm.patch
* mm-move-kvmalloc-related-functions-to-slabh.patch
* mm-slub-fix-two-bugs-in-slab_debug_trace_open.patch
* mm-slub-fix-mismatch-between-reconstructed-freelist-depth-and-cnt.patch
* mm-slub-fix-potential-memoryleak-in-kmem_cache_open.patch
* mm-slub-fix-potential-use-after-free-in-slab_debugfs_fops.patch
* mm-slub-fix-incorrect-memcg-slab-count-for-bulk-free.patch
* mm-dont-include-linux-daxh-in-linux-mempolicyh.patch
* compiler-attributes-add-__alloc_size-for-better-bounds-checking.patch
* compiler-attributes-add-__alloc_size-for-better-bounds-checking-fix.patch
* checkpatch-add-__alloc_size-to-known-attribute.patch
* slab-clean-up-function-declarations.patch
* slab-add-__alloc_size-attributes-for-better-bounds-checking.patch
* mm-page_alloc-add-__alloc_size-attributes-for-better-bounds-checking.patch
* percpu-add-__alloc_size-attributes-for-better-bounds-checking.patch
* mm-vmalloc-add-__alloc_size-attributes-for-better-bounds-checking.patch
* rapidio-avoid-bogus-__alloc_size-warning.patch
* mm-smaps-fix-shmem-pte-hole-swap-calculation.patch
* mm-smaps-use-vma-vm_pgoff-directly-when-counting-partial-swap.patch
* mm-smaps-simplify-shmem-handling-of-pte-holes.patch
* mm-remove-bogus-vm_bug_on.patch
* vfs-keep-inodes-with-page-cache-off-the-inode-shrinker-lru.patch
* mm-gup-further-simplify-__gup_device_huge.patch
* mm-swapfile-remove-needless-request_queue-null-pointer-check.patch
* mm-memcg-drop-swp_entry_t-in-mc_handle_file_pte.patch
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
* lazy-tlb-introduce-lazy-mm-refcount-helper-functions.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable.patch
* lazy-tlb-shoot-lazies-a-non-refcounting-lazy-tlb-option.patch
* powerpc-64s-enable-mmu_lazy_tlb_shootdown.patch
* mm-mremap-dont-account-pages-in-vma_to_resize.patch
* mm-vmalloc-repair-warn_allocs-in-__vmalloc_area_node.patch
* mm-vmalloc-dont-allow-vm_no_guard-on-vmap.patch
* kasan-test-add-memcpy-test-that-avoids-out-of-bounds-write.patch
* lib-stackdepot-include-gfph.patch
* lib-stackdepot-remove-unused-function-argument.patch
* lib-stackdepot-introduce-__stack_depot_save.patch
* kasan-common-provide-can_alloc-in-kasan_save_stack.patch
* kasan-generic-introduce-kasan_record_aux_stack_noalloc.patch
* workqueue-kasan-avoid-alloc_pages-when-recording-stack.patch
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
* mm-fix-data-race-in-pagepoisoned.patch
* mm-hugetlb-drop-__unmap_hugepage_range-definition-from-hugetlbh.patch
* userfaultfd-selftests-fix-feature-support-detection.patch
* userfaultfd-selftests-fix-calculation-of-expected-ioctls.patch
* userfaultfd-selftests-dont-rely-on-gnu-extensions-for-random-numbers.patch
* mm-page_isolation-fix-potential-missing-call-to-unset_migratetype_isolate.patch
* mm-page_isolation-guard-against-possible-putback-unisolated-page.patch
* tools-vm-page_owner_sortc-count-and-sort-by-mem.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt-fix.patch
* mm-mark-the-oom-reaper-thread-as-freezable.patch
* oom_kill-oom_score_adj-broken-for-processes-with-small-memory-usage.patch
* mmhugetlb-remove-mlock-ulimit-for-shm_hugetlb.patch
* mm-nommu-kill-arch_get_unmapped_area.patch
* selftest-vm-fix-ksm-selftest-to-run-with-different-numa-topologies.patch
* mm-vmstat-annotate-data-race-for-zone-free_areanr_free.patch
* mm-vmstat-annotate-data-race-for-zone-free_areanr_free-fix.patch
* mm-memory_hotplug-add-static-qualifier-for-online_policy_to_str.patch
* mm-memory_hotplug-make-hwpoisoned-dirty-swapcache-pages-unmovable.patch
* mm-rmap-convert-from-atomic_t-to-refcount_t-on-anon_vma-refcount.patch
* mm-zsmallocc-close-race-window-between-zs_pool_dec_isolated-and-zs_unregister_migration.patch
* mm-zsmallocc-combine-two-atomic-ops-in-zs_pool_dec_isolated.patch
* mm-highmem-remove-deprecated-kmap_atomic.patch
* zram_drv-allow-reclaim-on-bio_alloc.patch
* zram-off-by-one-in-read_block_state.patch
* mm-remove-hardened_usercopy_fallback.patch
* include-linux-mmh-move-nr_free_buffer_pages-from-swaph-to-mmh.patch
* mm-damon-grammar-s-works-work.patch
* documentation-vm-move-user-guides-to-admin-guide-mm.patch
* maintainers-update-seongjaes-email-address.patch
* docs-vm-damon-remove-broken-reference.patch
* include-linux-damonh-fix-kernel-doc-comments-for-damon_callback.patch
* mm-damon-core-print-kdamond-start-log-in-debug-mode-only.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-sysctl-make-protected_-world-readable.patch
* lib-stackdepot-check-stackdepot-handle-before-accessing-slabs.patch
* lib-stackdepot-add-helper-to-print-stack-entries.patch
* lib-stackdepot-add-helper-to-print-stack-entries-into-buffer.patch
* lib-stackdepot-add-helper-to-print-stack-entries-into-buffer-v2.patch
* lib-stackdepot-add-helper-to-print-stack-entries-into-buffer-v3.patch
* binfmt_elf-reintroduce-using-map_fixed_noreplace.patch
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
* hfsplus-fix-out-of-bounds-warnings-in-__hfsplus_setxattr.patch
* unshare-use-swap-to-make-code-cleaner.patch
* kernel-resource-clean-up-and-optimize-iomem_is_exclusive.patch
* kernel-resource-disallow-access-to-exclusive-system-ram-regions.patch
* virtio-mem-disallow-mapping-virtio-mem-memory-via-dev-mem.patch
* ipc-check-checkpoint_restore_ns_capable-to-modify-c-r-proc-files.patch
* ipc-check-checkpoint_restore_ns_capable-to-modify-c-r-proc-files-fix.patch
* ipc-ipc_sysctlc-remove-fallback-for-config_proc_sysctl.patch
  linux-next.patch
* assoc_array-avoid-open-coded-arithmetic-in-allocator-arguments.patch
* mm-migrate-simplify-the-file-backed-pages-validation-when-migrating-its-mapping.patch
* mm-unexport-folio_memcg_unlock.patch
* mm-unexport-unlock_page_memcg.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
