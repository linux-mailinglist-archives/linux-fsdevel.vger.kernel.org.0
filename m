Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8135389E88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 08:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhETHAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 03:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhETHAk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 03:00:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85B2A6100A;
        Thu, 20 May 2021 06:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621493959;
        bh=0oGW6JS2fjfBMQPZ2pGvL/6K+7eI08k3utQj1Fxc3DI=;
        h=Date:From:To:Subject:From;
        b=vexuG0HBa4uWaRaB2+NSj/FqIbKmUl/A3k7s07U7rbqfqwrhBB/n4/CUM6ydoWe0M
         nGqUPHFdrqqiG72MMO83YciQtcsIG6W+OnCZcYXc8IGMleFRbuF6CP7wH1SYmGKND2
         yW8SpK8ux7BqkCiOdKKHBoywZL/LFj0UArYsTM+4=
Date:   Wed, 19 May 2021 23:59:18 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-05-19-23-58 uploaded
Message-ID: <20210520065918.KsmugQp47%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-05-19-23-58 has been uploaded to

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



This mmotm tree contains the following patches against 5.13-rc2:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-shuffle-fix-section-mismatch-warning.patch
* revert-mm-gup-check-page-posion-status-for-coredump.patch
* ipc-mqueue-msg-sem-avoid-relying-on-a-stack-reference-past-its-expiry.patch
* tools-testing-selftests-exec-fix-link-error.patch
* kasan-slab-always-reset-the-tag-in-get_freepointer_safe.patch
* watchdog-reliable-handling-of-timestamps.patch
* mmhwpoison-fix-race-with-hugetlb-page-allocation.patch
* lib-kunit-suppress-a-compilation-warning-of-frame-size.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* kthread-switch-to-new-kerneldoc-syntax-for-named-variable-macro-argument.patch
* ia64-headers-drop-duplicated-words.patch
* ia64-mca_drv-fix-incorrect-array-size-calculation.patch
* streamline_configpl-make-spacing-consistent.patch
* streamline_configpl-add-softtabstop=4-for-vim-users.patch
* scripts-spellingtxt-add-more-spellings-to-spellingtxt.patch
* ocfs2-remove-unnecessary-init_list_head.patch
* ocfs2-fix-snprintf-checking.patch
* ocfs2-remove-redundant-assignment-to-pointer-queue.patch
* ocfs2-remove-repeated-uptodate-check-for-buffer.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* kernel-watchdog-modify-the-explanation-related-to-watchdog-thread.patch
* doc-watchdog-modify-the-explanation-related-to-watchdog-thread.patch
* doc-watchdog-modify-the-doc-related-to-watchdog-%u.patch
  mm.patch
* kunit-make-test-lock-irq-safe.patch
* mm-slub-kunit-add-a-kunit-test-for-slub-debugging-functionality.patch
* mm-slub-kunit-add-a-kunit-test-for-slub-debugging-functionality-fix.patch
* mm-slub-kunit-add-a-kunit-test-for-slub-debugging-functionality-fix-2.patch
* slub-remove-resiliency_test-function.patch
* mm-slub-change-run-time-assertion-in-kmalloc_index-to-compile-time.patch
* mm-slub-change-run-time-assertion-in-kmalloc_index-to-compile-time-fix.patch
* mm-slub-change-run-time-assertion-in-kmalloc_index-to-compile-time-fix-2.patch
* lib-hexdump-add-a-raw-pointer-printing-format-for-slub-debugging.patch
* slub-print-raw-pointer-addresses-when-debugging.patch
* slub-actually-use-message-in-restore_bytes.patch
* tools-vm-page_owner_sortc-fix-the-potential-stack-overflow-risk.patch
* mm-debug_vm_pgtable-ensure-thp-availability-via-has_transparent_hugepage.patch
* mm-page-writeback-kill-get_writeback_state-comments.patch
* mm-page-writeback-fix-performance-when-bdis-share-of-ratio-is-0.patch
* mm-page-writeback-update-the-comment-of-dirty-position-control.patch
* mm-page-writeback-use-__this_cpu_inc-in-account_page_dirtied.patch
* mm-gup_benchmark-support-threading.patch
* mm-gup-allow-foll_pin-to-scale-in-smp.patch
* mm-gup-pack-has_pinned-in-mmf_has_pinned.patch
* mm-gup-pack-has_pinned-in-mmf_has_pinned-checkpatch-fixes.patch
* mm-gup-pack-has_pinned-in-mmf_has_pinned-fix.patch
* mm-swapfile-use-percpu_ref-to-serialize-against-concurrent-swapoff.patch
* swap-fix-do_swap_page-race-with-swapoff.patch
* mm-swap-remove-confusing-checking-for-non_swap_entry-in-swap_ra_info.patch
* mm-shmem-fix-shmem_swapin-race-with-swapoff.patch
* mm-memcg-move-mod_objcg_state-to-memcontrolc.patch
* mm-memcg-cache-vmstat-data-in-percpu-memcg_stock_pcp.patch
* mm-memcg-improve-refill_obj_stock-performance.patch
* mm-memcg-optimize-user-context-object-stock-access.patch
* mm-memcg-optimize-user-context-object-stock-access-checkpatch-fixes.patch
* mm-memcg-slab-properly-set-up-gfp-flags-for-objcg-pointer-array.patch
* mm-memcg-slab-create-a-new-set-of-kmalloc-cg-n-caches.patch
* mm-memcg-slab-create-a-new-set-of-kmalloc-cg-n-caches-fix.patch
* mm-memcg-slab-create-a-new-set-of-kmalloc-cg-n-caches-v5.patch
* mm-memcg-slab-create-a-new-set-of-kmalloc-cg-n-caches-v5-fix.patch
* mm-memcg-slab-disable-cache-merging-for-kmalloc_normal-caches.patch
* mm-memcontrol-fix-root_mem_cgroup-charging.patch
* mm-memcontrol-fix-page-charging-in-page-replacement.patch
* mm-memcontrol-bail-out-early-when-mm-in-get_mem_cgroup_from_mm.patch
* mm-memcontrol-remove-the-pgdata-parameter-of-mem_cgroup_page_lruvec.patch
* mm-memcontrol-simplify-lruvec_holds_page_lru_lock.patch
* mm-memcontrol-rename-lruvec_holds_page_lru_lock-to-page_matches_lruvec.patch
* mm-memcontrol-simplify-the-logic-of-objcg-pinning-memcg.patch
* mm-memcontrol-move-obj_cgroup_uncharge_pages-out-of-css_set_lock.patch
* mm-vmscan-remove-noinline_for_stack.patch
* memcontrol-use-flexible-array-member.patch
* mm-improve-mprotectrw-efficiency-on-pages-referenced-once.patch
* mm-improve-mprotectrw-efficiency-on-pages-referenced-once-fix.patch
* perf-map_executable-does-not-indicate-vm_mayexec.patch
* binfmt-remove-in-tree-usage-of-map_executable.patch
* binfmt-remove-in-tree-usage-of-map_executable-fix.patch
* mm-ignore-map_executable-in-ksys_mmap_pgoff.patch
* mm-mmapc-logic-of-find_vma_intersection-repeated-in-__do_munmap.patch
* mm-mmap-introduce-unlock_range-for-code-cleanup.patch
* mm-mmap-introduce-unlock_range-for-code-cleanup-fix.patch
* mm-mmap-use-find_vma_intersection-in-do_mmap-for-overlap.patch
* mm-memoryc-fix-comment-of-finish_mkwrite_fault.patch
* selftest-mremap_test-update-the-test-to-handle-pagesize-other-than-4k.patch
* selftest-mremap_test-avoid-crash-with-static-build.patch
* mm-mremap-use-pmd-pud_poplulate-to-update-page-table-entries.patch
* mm-mremap-use-pmd-pud_poplulate-to-update-page-table-entries-fix.patch
* powerpc-mm-book3s64-fix-possible-build-error.patch
* powerpc-mm-book3s64-update-tlb-flush-routines-to-take-a-page-walk-cache-flush-argument.patch
* powerpc-mm-book3s64-update-tlb-flush-routines-to-take-a-page-walk-cache-flush-argument-fix.patch
* mm-mremap-use-range-flush-that-does-tlb-and-page-walk-cache-flush.patch
* mm-mremap-use-range-flush-that-does-tlb-and-page-walk-cache-flush-fix.patch
* mm-mremap-move-tlb-flush-outside-page-table-lock.patch
* mm-mremap-allow-arch-runtime-override.patch
* powerpc-mm-enable-move-pmd-pud.patch
* mm-page_alloc-add-an-alloc_pages_bulk_array_node-helper.patch
* mm-vmalloc-switch-to-bulk-allocator-in-__vmalloc_area_node.patch
* mm-vmalloc-print-a-warning-message-first-on-failure.patch
* printk-introduce-dump_stack_lvl.patch
* printk-introduce-dump_stack_lvl-fix.patch
* kasan-use-dump_stack_lvlkern_err-to-print-stacks.patch
* mm-page_alloc-__alloc_pages_bulk-do-bounds-check-before-accessing-array.patch
* mm-mmzoneh-simplify-is_highmem_idx.patch
* mm-make-__dump_page-static.patch
* mm-debug-factor-pagepoisoned-out-of-__dump_page.patch
* mm-page_owner-constify-dump_page_owner.patch
* mm-make-compound_head-const-preserving.patch
* mm-constify-get_pfnblock_flags_mask-and-get_pfnblock_migratetype.patch
* mm-constify-page_count-and-page_ref_count.patch
* mm-optimise-nth_page-for-contiguous-memmap.patch
* mm-page_alloc-switch-to-pr_debug.patch
* mm-page_alloc-split-per-cpu-page-lists-and-zone-stats.patch
* mm-page_alloc-split-per-cpu-page-lists-and-zone-stats-fix.patch
* mm-page_alloc-split-per-cpu-page-lists-and-zone-stats-fix-fix.patch
* mm-page_alloc-convert-per-cpu-list-protection-to-local_lock.patch
* mm-vmstat-convert-numa-statistics-to-basic-numa-counters.patch
* mm-vmstat-inline-numa-event-counter-updates.patch
* mm-page_alloc-batch-the-accounting-updates-in-the-bulk-allocator.patch
* mm-page_alloc-reduce-duration-that-irqs-are-disabled-for-vm-counters.patch
* mm-page_alloc-explicitly-acquire-the-zone-lock-in-__free_pages_ok.patch
* mm-page_alloc-avoid-conflating-irqs-disabled-with-zone-lock.patch
* mm-page_alloc-update-pgfree-outside-the-zone-lock-in-__free_pages_ok.patch
* mmhwpoison-make-get_hwpoison_page-call-get_any_page.patch
* mm-memory_hotplug-factor-out-bootmem-core-functions-to-bootmem_infoc.patch
* mm-hugetlb-introduce-a-new-config-hugetlb_page_free_vmemmap.patch
* mm-hugetlb-gather-discrete-indexes-of-tail-page.patch
* mm-hugetlb-free-the-vmemmap-pages-associated-with-each-hugetlb-page.patch
* mm-hugetlb-defer-freeing-of-hugetlb-pages.patch
* mm-hugetlb-alloc-the-vmemmap-pages-associated-with-each-hugetlb-page.patch
* mm-hugetlb-add-a-kernel-parameter-hugetlb_free_vmemmap.patch
* mm-memory_hotplug-disable-memmap_on_memory-when-hugetlb_free_vmemmap-enabled.patch
* mm-memory_hotplug-disable-memmap_on_memory-when-hugetlb_free_vmemmap-enabled-fix.patch
* mm-hugetlb-introduce-nr_free_vmemmap_pages-in-the-struct-hstate.patch
* mm-debug_vm_pgtable-move-pmd-pud_huge_tests-out-of-config_transparent_hugepage.patch
* mm-debug_vm_pgtable-remove-redundant-pfn_pmd-pte-and-fix-one-comment-mistake.patch
* mm-huge_memoryc-remove-dedicated-macro-hpage_cache_index_mask.patch
* mm-huge_memoryc-use-page-deferred_list.patch
* mm-huge_memoryc-add-missing-read-only-thp-checking-in-transparent_hugepage_enabled.patch
* mm-huge_memoryc-add-missing-read-only-thp-checking-in-transparent_hugepage_enabled-v4.patch
* mm-huge_memoryc-remove-unnecessary-tlb_remove_page_size-for-huge-zero-pmd.patch
* mm-huge_memoryc-dont-discard-hugepage-if-other-processes-are-mapping-it.patch
* mm-hugetlb-change-parameters-of-arch_make_huge_pte.patch
* mm-pgtable-add-stubs-for-pmd-pub_set-clear_huge.patch
* mm-pgtable-add-stubs-for-pmd-pub_set-clear_huge-fix-2.patch
* arm64-define-only-pud-pmd_set-clear_huge-when-usefull.patch
* mm-vmalloc-enable-mapping-of-huge-pages-at-pte-level-in-vmap.patch
* mm-vmalloc-enable-mapping-of-huge-pages-at-pte-level-in-vmalloc.patch
* powerpc-8xx-add-support-for-huge-pages-on-vmap-and-vmalloc.patch
* userfaultfd-selftests-use-user-mode-only.patch
* userfaultfd-selftests-remove-the-time-check-on-delayed-uffd.patch
* userfaultfd-selftests-dropping-verify-check-in-locking_thread.patch
* userfaultfd-selftests-only-dump-counts-if-mode-enabled.patch
* userfaultfd-selftests-unify-error-handling.patch
* mm-thp-simplify-copying-of-huge-zero-page-pmd-when-fork.patch
* mm-userfaultfd-fix-uffd-wp-special-cases-for-fork.patch
* mm-userfaultfd-fix-a-few-thp-pmd-missing-uffd-wp-bit.patch
* mm-userfaultfd-fail-uffd-wp-registeration-if-not-supported.patch
* mm-pagemap-export-uffd-wp-protection-information.patch
* userfaultfd-selftests-add-pagemap-uffd-wp-test.patch
* userfaultfd-shmem-combine-shmem_mcopy_atomicmfill_zeropage_pte.patch
* userfaultfd-shmem-support-minor-fault-registration-for-shmem.patch
* userfaultfd-shmem-support-uffdio_continue-for-shmem.patch
* userfaultfd-shmem-advertise-shmem-minor-fault-support.patch
* userfaultfd-shmem-modify-shmem_mfill_atomic_pte-to-use-install_pte.patch
* userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
* userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
* userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
* userfaultfd-selftests-reinitialize-test-context-in-each-test-fix.patch
* userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch
* mm-move-holes_in_zone-into-mm.patch
* docs-procrst-meminfo-briefly-describe-gaps-in-memory-accounting.patch
* include-linux-mmzoneh-add-documentation-for-pfn_valid.patch
* memblock-update-initialization-of-reserved-pages.patch
* arm64-decouple-check-whether-pfn-is-in-linear-map-from-pfn_valid.patch
* arm64-drop-pfn_valid_within-and-simplify-pfn_valid.patch
* arm64-drop-pfn_valid_within-and-simplify-pfn_valid-fix.patch
* mm-migrate-fix-missing-update-page_private-to-hugetlb_page_subpool.patch
* mm-thp-relax-the-vm_denywrite-constraint-on-file-backed-thps.patch
* mm-thp-check-total_mapcount-instead-of-page_mapcount.patch
* mm-thp-check-total_mapcount-instead-of-page_mapcount-fix.patch
* mm-thp-check-total_mapcount-instead-of-page_mapcount-fix-fix.patch
* mm-memory-add-orig_pmd-to-struct-vm_fault.patch
* mm-memory-make-numa_migrate_prep-non-static.patch
* mm-thp-refactor-numa-fault-handling.patch
* mm-migrate-account-thp-numa-migration-counters-correctly.patch
* mm-migrate-dont-split-thp-for-misplaced-numa-page.patch
* mm-migrate-check-mapcount-for-thp-instead-of-refcount.patch
* mm-thp-skip-make-pmd-prot_none-if-thp-migration-is-not-supported.patch
* mm-thp-update-mm_structs-mm_anonpages-stat-for-huge-zero-pages.patch
* mm-thp-make-alloc_split_ptlocks-dependent-on-use_split_pte_ptlocks.patch
* nommu-remove-__gfp_highmem-in-vmalloc-vzalloc.patch
* nommu-remove-__gfp_highmem-in-vmalloc-vzalloc-checkpatch-fixes.patch
* mm-make-variable-names-for-populate_vma_page_range-consistent.patch
* mm-madvise-introduce-madv_populate_readwrite-to-prefault-page-tables.patch
* mm-madvise-introduce-madv_populate_readwrite-to-prefault-page-tables-checkpatch-fixes.patch
* maintainers-add-tools-testing-selftests-vm-to-memory-management.patch
* selftests-vm-add-protection_keys_32-protection_keys_64-to-gitignore.patch
* selftests-vm-add-test-for-madv_populate_readwrite.patch
* mm-memory_hotplug-rate-limit-page-migration-warnings.patch
* mm-highmem-remove-deprecated-kmap_atomic.patch
* mm-fix-typos-and-grammar-error-in-comments.patch
* mm-fix-comments-mentioning-i_mutex.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-avoid-mixing-integer-types-in-mem_rw.patch
* fs-proc-kcore-drop-kcore_remap-and-kcore_other.patch
* fs-proc-kcore-pfn_is_ram-check-only-applies-to-kcore_ram.patch
* fs-proc-kcore-dont-read-offline-sections-logically-offline-pages-and-hwpoisoned-pages.patch
* mm-introduce-page_offline_beginendfreezethaw-to-synchronize-setting-pageoffline.patch
* virtio-mem-use-page_offline_startend-when-setting-pageoffline.patch
* fs-proc-kcore-use-page_offline_freezethaw.patch
* procfs-allow-reading-fdinfo-with-ptrace_mode_read.patch
* procfs-dmabuf-add-inode-number-to-proc-fdinfo.patch
* sysctl-remove-redundant-assignment-to-first.patch
* proc-sysctl-make-protected_-world-readable.patch
* kernelh-split-out-panic-and-oops-helpers.patch
* kernelh-split-out-panic-and-oops-helpers-fix.patch
* lib-decompress_bunzip2-remove-an-unneeded-semicolon.patch
* lib-string_helpers-switch-to-use-bit-macro.patch
* lib-string_helpers-move-escape_np-check-inside-else-branch-in-a-loop.patch
* lib-string_helpers-drop-indentation-level-in-string_escape_mem.patch
* lib-string_helpers-introduce-escape_na-for-escaping-non-ascii.patch
* lib-string_helpers-introduce-escape_nap-to-escape-non-ascii-and-non-printable.patch
* lib-string_helpers-allow-to-append-additional-characters-to-be-escaped.patch
* lib-test-string_helpers-print-flags-in-hexadecimal-format.patch
* lib-test-string_helpers-get-rid-of-trailing-comma-in-terminators.patch
* lib-test-string_helpers-add-test-cases-for-new-features.patch
* maintainers-add-myself-as-designated-reviewer-for-generic-string-library.patch
* seq_file-introduce-seq_escape_mem.patch
* seq_file-add-seq_escape_str-as-replica-of-string_escape_str.patch
* seq_file-convert-seq_escape-to-use-seq_escape_str.patch
* nfsd-avoid-non-flexible-api-in-seq_quote_mem.patch
* seq_file-drop-unused-_escape_mem_ascii.patch
* lz4_decompress-declare-lz4_decompress_safe_withprefix64k-static.patch
* lib-decompress_unlz4c-correctly-handle-zero-padding-around-initrds.patch
* checkpatch-scripts-spdxcheckpy-now-requires-python3.patch
* init-print-out-unknown-kernel-parameters.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* hfsplus-fix-out-of-bounds-warnings-in-__hfsplus_setxattr.patch
* x86-signal-dont-do-sas_ss_reset-until-we-are-certain-that-sigframe-wont-be-abandoned.patch
* samples-kprobes-fix-typo-in-handler_fault.patch
* samples-kprobes-fix-typo-in-handler_post.patch
* aio-simplify-read_events.patch
* lib-decompressors-remove-set-but-not-used-variabled-level.patch
* lib-decompressors-remove-set-but-not-used-variabled-level-fix.patch
* ipc-sem-use-kvmalloc-for-sem_undo-allocation.patch
* ipc-use-kmalloc-for-msg_queue-and-shmid_kernel.patch
* ipc-semc-use-read_once-write_once-for-use_global_lock.patch
  linux-next.patch
  linux-next-git-rejects.patch
* mm-define-default-value-for-first_user_address.patch
* mm-clear-spelling-mistakes.patch
* mm-slub-use-stackdepot-to-save-stack-trace-in-objects.patch
* mm-slub-use-stackdepot-to-save-stack-trace-in-objects-fix.patch
* mm-slub-use-stackdepot-to-save-stack-trace-in-objects-fix-2.patch
* mmap-make-mlock_future_check-global.patch
* riscv-kconfig-make-direct-map-manipulation-options-depend-on-mmu.patch
* set_memory-allow-querying-whether-set_direct_map_-is-actually-enabled.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix.patch
* pm-hibernate-disable-when-there-are-active-secretmem-users.patch
* arch-mm-wire-up-memfd_secret-system-call-where-relevant.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2.patch
* buildid-only-consider-gnu-notes-for-build-id-parsing.patch
* buildid-add-api-to-parse-build-id-out-of-buffer.patch
* buildid-stash-away-kernels-build-id-on-init.patch
* buildid-stash-away-kernels-build-id-on-init-fix.patch
* dump_stack-add-vmlinux-build-id-to-stack-traces.patch
* module-add-printk-formats-to-add-module-build-id-to-stacktraces.patch
* module-add-printk-formats-to-add-module-build-id-to-stacktraces-fix.patch
* module-add-printk-formats-to-add-module-build-id-to-stacktraces-fix-2.patch
* arm64-stacktrace-use-%psb-for-backtrace-printing.patch
* x86-dumpstack-use-%psb-%pbb-for-backtrace-printing.patch
* scripts-decode_stacktracesh-support-debuginfod.patch
* scripts-decode_stacktracesh-silence-stderr-messages-from-addr2line-nm.patch
* scripts-decode_stacktracesh-indicate-auto-can-be-used-for-base-path.patch
* buildid-mark-some-arguments-const.patch
* buildid-fix-kernel-doc-notation.patch
* kdump-use-vmlinux_build_id-to-simplify.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
