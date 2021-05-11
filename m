Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13017379ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 06:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhEKEsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 00:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhEKEs3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 00:48:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20938615FF;
        Tue, 11 May 2021 04:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620708440;
        bh=7PD/+lewf30TWjOAsDn+eLvEuQOgrPvTE/ZPLtvme6Q=;
        h=Date:From:To:Subject:From;
        b=RjjZO/nTSeLdZCsOosVKGYBQvreha8XcHPAChW0vtNy/9Qe40Bp3mVWNlFblsAyiw
         9TP3WowlVyWfA83lW28nDtuFE2D8aFokz8SUsAYi5S9PgY6ZPDwXB9OatDE39yyo66
         ppkADKYDjC1AT0ZX1IWntnQkURtmtkGuDu2QNsqc=
Date:   Mon, 10 May 2021 21:47:19 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-05-10-21-46 uploaded
Message-ID: <20210511044719.tWGZA2U3A%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-05-10-21-46 has been uploaded to

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



This mmotm tree contains the following patches against 5.13-rc1:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-hugetlb-fix-f_seal_future_write.patch
* mm-hugetlb-fix-cow-where-page-writtable-in-child.patch
* mm-slub-move-slub_debug-static-key-enabling-outside-slab_mutex.patch
* revert-mm-gup-check-page-posion-status-for-coredump.patch
* squashfs-fix-divide-error-in-calculate_skip.patch
* userfaultfd-release-page-in-error-path-to-avoid-bug_on.patch
* ksm-revert-use-get_ksm_page_nolock-to-get-ksm-page-in-remove_rmap_item_from_tree.patch
* mm-ioremap-fix-iomap_max_page_shift.patch
* mm-fix-struct-page-layout-on-32-bit-systems.patch
* kasan-fix-unit-tests-with-config_ubsan_local_bounds-enabled.patch
* mm-filemap-fix-readahead-return-types.patch
* hfsplus-prevent-corruption-in-shrinking-truncate.patch
* ipc-mqueue-msg-sem-avoid-relying-on-a-stack-reference-past-its-expiry.patch
* docs-admin-guide-update-description-for-kernelmodprobe-sysctl.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* ia64-headers-drop-duplicated-words.patch
* makefile-extend-32b-aligned-debug-option-to-64b-aligned.patch
* streamline_configpl-make-spacing-consistent.patch
* streamline_configpl-add-softtabstop=4-for-vim-users.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* kernel-watchdog-modify-the-explanation-related-to-watchdog-thread.patch
* doc-watchdog-modify-the-explanation-related-to-watchdog-thread.patch
* doc-watchdog-modify-the-doc-related-to-watchdog-%u.patch
  mm.patch
* tools-vm-page_owner_sortc-fix-the-potential-stack-overflow-risk.patch
* mm-page-writeback-kill-get_writeback_state-comments.patch
* mm-page-writeback-fix-performance-when-bdis-share-of-ratio-is-0.patch
* mm-gup_benchmark-support-threading.patch
* mm-gup-allow-foll_pin-to-scale-in-smp.patch
* mm-gup-pack-has_pinned-in-mmf_has_pinned.patch
* mm-gup-pack-has_pinned-in-mmf_has_pinned-checkpatch-fixes.patch
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
* mm-improve-mprotectrw-efficiency-on-pages-referenced-once.patch
* mm-improve-mprotectrw-efficiency-on-pages-referenced-once-fix.patch
* perf-map_executable-does-not-indicate-vm_mayexec.patch
* binfmt-remove-in-tree-usage-of-map_executable.patch
* mm-ignore-map_executable-in-ksys_mmap_pgoff.patch
* mm-mmapc-logic-of-find_vma_intersection-repeated-in-__do_munmap.patch
* mm-mmap-introduce-unlock_range-for-code-cleanup.patch
* mm-mmap-introduce-unlock_range-for-code-cleanup-fix.patch
* mm-mmap-use-find_vma_intersection-in-do_mmap-for-overlap.patch
* mm-vmalloc-switch-to-bulk-allocator-in-__vmalloc_area_node.patch
* mm-vmalloc-print-a-warning-message-first-on-failure.patch
* printk-introduce-dump_stack_lvl.patch
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
* userfaultfd-hugetlbfs-avoid-including-userfaultfd_kh-in-hugetlbh.patch
* userfaultfd-shmem-combine-shmem_mcopy_atomicmfill_zeropage_pte.patch
* userfaultfd-shmem-support-minor-fault-registration-for-shmem.patch
* userfaultfd-shmem-support-uffdio_continue-for-shmem.patch
* userfaultfd-shmem-advertise-shmem-minor-fault-support.patch
* userfaultfd-shmem-modify-shmem_mfill_atomic_pte-to-use-install_pte.patch
* userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
* userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
* userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
* userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch
* mm-move-holes_in_zone-into-mm.patch
* docs-procrst-meminfo-briefly-describe-gaps-in-memory-accounting.patch
* mm-thp-make-alloc_split_ptlocks-dependent-on-use_split_pte_ptlocks.patch
* mm-thp-relax-the-vm_denywrite-constraint-on-file-backed-thps.patch
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
* procfs-allow-reading-fdinfo-with-ptrace_mode_read.patch
* procfs-dmabuf-add-inode-number-to-proc-fdinfo.patch
* proc-sysctl-make-protected_-world-readable.patch
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
* bitmap_parse-support-all-semantics.patch
* rcu-tree_plugin-dont-handle-the-case-of-all-cpu-range.patch
* checkpatch-scripts-spdxcheckpy-now-requires-python3.patch
* hfsplus-fix-out-of-bounds-warnings-in-__hfsplus_setxattr.patch
* x86-signal-dont-do-sas_ss_reset-until-we-are-certain-that-sigframe-wont-be-abandoned.patch
* aio-simplify-read_events.patch
* ipc-sem-use-kvmalloc-for-sem_undo-allocation.patch
* ipc-use-kmalloc-for-msg_queue-and-shmid_kernel.patch
  linux-next.patch
* mm-define-default-value-for-first_user_address.patch
* mmap-make-mlock_future_check-global.patch
* riscv-kconfig-make-direct-map-manipulation-options-depend-on-mmu.patch
* set_memory-allow-set_direct_map__noflush-for-multiple-pages.patch
* set_memory-allow-querying-whether-set_direct_map_-is-actually-enabled.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix-2.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix-3.patch
* pm-hibernate-disable-when-there-are-active-secretmem-users.patch
* arch-mm-wire-up-memfd_secret-system-call-where-relevant.patch
* arch-mm-wire-up-memfd_secret-system-call-where-relevant-fix.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2-fix.patch
* buildid-only-consider-gnu-notes-for-build-id-parsing.patch
* buildid-add-api-to-parse-build-id-out-of-buffer.patch
* buildid-stash-away-kernels-build-id-on-init.patch
* dump_stack-add-vmlinux-build-id-to-stack-traces.patch
* module-add-printk-formats-to-add-module-build-id-to-stacktraces.patch
* module-add-printk-formats-to-add-module-build-id-to-stacktraces-fix.patch
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
