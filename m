Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED55338584
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 06:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCLFrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 00:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhCLFrZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 00:47:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F6EB64EF6;
        Fri, 12 Mar 2021 05:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615528045;
        bh=C9CyP5igT4+/1+NW5G6Sua4uzxt6Oh1wQpHWoXj4AXE=;
        h=Date:From:To:Subject:From;
        b=duNFM3DbvSlu06ttvHi5y0j+aa9WZ6hJiGjoPygrVW/hBIZs73YkLf3vB4i7b6OVL
         RDrNaXYZzugVgtKaMHLQD3P+UmntY+U5a0L503AlbXs5XK5zUVvVbEvxb58W6eZ1wy
         Oz6jDH6gK/0/raYmqLTcAwJOskKJG3DoWRRhddDE=
Date:   Thu, 11 Mar 2021 21:47:23 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-03-11-21-46 uploaded
Message-ID: <20210312054723.MFl9RDDIt%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-03-11-21-46 has been uploaded to

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



This mmotm tree contains the following patches against 5.12-rc2:
(patches marked "*" will be included in linux-next)

  origin.patch
* memblock-fix-section-mismatch-warning.patch
* stop_machine-mark-helpers-__always_inline.patch
* init-kconfig-make-compile_test-depend-on-has_iomem.patch
* mm-page_allocc-refactor-initialization-of-struct-page-for-holes-in-memory-layout.patch
* mm-page_allocc-refactor-initialization-of-struct-page-for-holes-in-memory-layout-fix.patch
* mm-fork-clear-pasid-for-new-mm.patch
* hugetlb_cgroup-fix-imbalanced-css_get-and-css_put-pair-for-shared-mappings.patch
* fix-zero_user_segments-with-start-end.patch
* binfmt_misc-fix-possible-deadlock-in-bm_register_write.patch
* maintainers-exclude-uapi-directories-in-api-abi-section.patch
* linux-compiler-clangh-define-have_builtin_bswap.patch
* kfence-fix-printk-format-for-ptrdiff_t.patch
* kfence-slab-fix-cache_alloc_debugcheck_after-for-bulk-allocations.patch
* kfence-fix-reports-if-constant-function-prefixes-exist.patch
* mm-use-rcu_dereference-in-in_vfork.patch
* mm-madvise-replace-ptrace-attach-requirement-for-process_madvise.patch
* ia64-fix-ia64_syscall_get_set_arguments-for-break-based-syscalls.patch
* ia64-fix-ptraceptrace_syscall_info_exit-sign.patch
* kasan-mm-fix-crash-with-hw_tags-and-debug_pagealloc.patch
* kasan-fix-kasan_stack-dependency-for-hw_tags.patch
* kasan-fix-per-page-tags-for-non-page_alloc-pages.patch
* mm-userfaultfd-fix-memory-corruption-due-to-writeprotect.patch
* mm-hwpoison-do-not-lock-page-again-when-me_huge_page-successfully-recovers.patch
* hugetlb-dedup-the-code-to-add-a-new-file_region.patch
* hugetlg-break-earlier-in-add_reservation_in_range-when-we-can.patch
* mm-introduce-page_needs_cow_for_dma-for-deciding-whether-cow.patch
* mm-use-is_cow_mapping-across-tree-where-proper.patch
* hugetlb-do-early-cow-when-page-pinned-on-src-mm.patch
* mm-memcg-rename-mem_cgroup_split_huge_fixup-to-split_page_memcg.patch
* mm-memcg-set-memcg-when-split-page.patch
* mm-mmu_notifiers-esnure-range_end-is-paired-with-range_start.patch
* z3fold-prevent-reclaim-free-race-for-headless-pages.patch
* squashfs-fix-inode-lookup-sanity-checks.patch
* squashfs-fix-xattr-id-and-id-lookup-sanity-checks.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* module-remove-duplicate-include-in-arch-ia64-kernel-heads.patch
* ia64-kernel-few-typos-fixed-in-the-file-fsyss.patch
* sparse-can-do-constant-folding-of-__builtin_bswap.patch
* scripts-spellingtxt-add-overlfow.patch
* scripts-spellingtxt-add-diabled-typo.patch
* scripts-spellingtxt-add-overflw.patch
* sh-remove-duplicate-include-in-tlbh.patch
* ocfs2-replace-define_simple_attribute-with-define_debugfs_attribute.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* watchdog-rename-__touch_watchdog-to-a-better-descriptive-name.patch
* watchdog-explicitly-update-timestamp-when-reporting-softlockup.patch
* watchdog-softlockup-report-the-overall-time-of-softlockups.patch
* watchdog-softlockup-remove-logic-that-tried-to-prevent-repeated-reports.patch
* watchdog-fix-barriers-when-printing-backtraces-from-all-cpus.patch
* watchdog-cleanup-handling-of-false-positives.patch
  mm.patch
* mm-slub-introduce-two-counters-for-partial-objects.patch
* mm-slub-get-rid-of-count_partial.patch
* percpu-export-per_cpu_sum.patch
* mm-slub-use-percpu-partial-free-counter.patch
* mm-page_owner-record-the-timestamp-of-all-pages-during-free.patch
* mm-provide-filemap_range_needs_writeback-helper.patch
* mm-use-filemap_range_needs_writeback-for-o_direct-reads.patch
* iomap-use-filemap_range_needs_writeback-for-o_direct-reads.patch
* mm-filemap-use-filemap_read_page-in-filemap_fault.patch
* mm-filemap-drop-check-for-truncated-page-after-i-o.patch
* mm-page-writeback-simplify-memcg-handling-in-test_clear_page_writeback.patch
* mm-msync-exit-early-when-the-flags-is-an-ms_async-and-start-vm_start.patch
* mm-memremap-fixes-improper-spdx-comment-style.patch
* mm-memcontrol-fix-kernel-stack-account.patch
* memcg-cleanup-root-memcg-checks.patch
* memcg-enable-memcg-oom-kill-for-__gfp_nofail.patch
* memcg-charge-before-adding-to-swapcache-on-swapin.patch
* mm-memcontrol-fix-cpuhotplug-statistics-flushing.patch
* mm-memcontrol-kill-mem_cgroup_nodeinfo.patch
* mm-memcontrol-privatize-memcg_page_state-query-functions.patch
* cgroup-rstat-support-cgroup1.patch
* cgroup-rstat-punt-root-level-optimization-to-individual-controllers.patch
* mm-memcontrol-switch-to-rstat.patch
* mm-memcontrol-switch-to-rstat-fix.patch
* mm-memcontrol-consolidate-lruvec-stat-flushing.patch
* kselftests-cgroup-update-kmem-test-for-new-vmstat-implementation.patch
* mm-delete-bool-migrated.patch
* mm-interval_tree-add-comments-to-improve-code-reading.patch
* x86-vmemmap-drop-handling-of-4k-unaligned-vmemmap-range.patch
* x86-vmemmap-drop-handling-of-1gb-vmemmap-ranges.patch
* x86-vmemmap-handle-unpopulated-sub-pmd-ranges.patch
* x86-vmemmap-optimize-for-consecutive-sections-in-partial-populated-pmds.patch
* mm-tracing-improve-rss_stat-tracepoint-message.patch
* mm-allow-shmem-mappings-with-mremap_dontunmap.patch
* mm-dmapool-switch-from-strlcpy-to-strscpy.patch
* samples-vfio-mdev-mdpy-use-remap_vmalloc_range.patch
* mm-unexport-remap_vmalloc_range_partial.patch
* mm-vmalloc-use-rb_tree-instead-of-list-for-vread-lookups.patch
* kasan-remove-redundant-config-option.patch
* mm-kasan-switch-from-strlcpy-to-strscpy.patch
* kasan-initialize-shadow-to-tag_invalid-for-sw_tags.patch
* mm-kasan-dont-poison-boot-memory-with-tag-based-modes.patch
* arm64-kasan-allow-to-init-memory-when-setting-tags.patch
* kasan-init-memory-in-kasan_unpoison-for-hw_tags.patch
* kasan-mm-integrate-page_alloc-init-with-hw_tags.patch
* kasan-mm-integrate-slab-init_on_alloc-with-hw_tags.patch
* kasan-mm-integrate-slab-init_on_free-with-hw_tags.patch
* mm-page_alloc-drop-pr_info_ratelimited-in-alloc_contig_range.patch
* mm-remove-lru_add_drain_all-in-alloc_contig_range.patch
* mm-correctly-determine-last_cpupid_width.patch
* mm-clean-up-include-linux-page-flags-layouth.patch
* mm-page_alloc-rename-alloc_mask-to-alloc_gfp.patch
* mm-page_alloc-rename-gfp_mask-to-gfp.patch
* mm-page_alloc-combine-__alloc_pages-and-__alloc_pages_nodemask.patch
* mm-mempolicy-rename-alloc_pages_current-to-alloc_pages.patch
* mm-mempolicy-rewrite-alloc_pages-documentation.patch
* mm-mempolicy-rewrite-alloc_pages_vma-documentation.patch
* mm-mempolicy-fix-mpol_misplaced-kernel-doc.patch
* mm-page_alloc-dump-migrate-failed-pages.patch
* hugetlb-pass-vma-into-huge_pte_alloc-and-huge_pmd_share.patch
* hugetlb-pass-vma-into-huge_pte_alloc-and-huge_pmd_share-fix.patch
* hugetlb-userfaultfd-forbid-huge-pmd-sharing-when-uffd-enabled.patch
* hugetlb-userfaultfd-forbid-huge-pmd-sharing-when-uffd-enabled-fix.patch
* mm-hugetlb-move-flush_hugetlb_tlb_range-into-hugetlbh.patch
* hugetlb-userfaultfd-unshare-all-pmds-for-hugetlbfs-when-register-wp.patch
* mm-hugetlb-remove-redundant-reservation-check-condition-in-alloc_huge_page.patch
* mm-generalize-hugetlb_page_size_variable.patch
* mm-hugetlb-use-some-helper-functions-to-cleanup-code.patch
* mm-hugetlb-optimize-the-surplus-state-transfer-code-in-move_hugetlb_state.patch
* hugetlb_cgroup-remove-unnecessary-vm_bug_on_page-in-hugetlb_cgroup_migrate.patch
* mm-hugetlb-simplify-the-code-when-alloc_huge_page-failed-in-hugetlb_no_page.patch
* mm-hugetlb-avoid-calculating-fault_mutex_hash-in-truncate_op-case.patch
* khugepaged-remove-unneeded-return-value-of-khugepaged_collapse_pte_mapped_thps.patch
* khugepaged-reuse-the-smp_wmb-inside-__setpageuptodate.patch
* khugepaged-use-helper-khugepaged_test_exit-in-__khugepaged_enter.patch
* khugepaged-fix-wrong-result-value-for-trace_mm_collapse_huge_page_isolate.patch
* mm-huge_memoryc-remove-unnecessary-local-variable-ret2.patch
* mm-huge_memory-a-new-debugfs-interface-for-splitting-thp-tests.patch
* userfaultfd-add-minor-fault-registration-mode.patch
* userfaultfd-disable-huge-pmd-sharing-for-minor-registered-vmas.patch
* userfaultfd-hugetlbfs-only-compile-uffd-helpers-if-config-enabled.patch
* userfaultfd-add-uffdio_continue-ioctl.patch
* userfaultfd-update-documentation-to-describe-minor-fault-handling.patch
* userfaultfd-selftests-add-test-exercising-minor-fault-handling.patch
* userfaultfd-support-minor-fault-handling-for-shmem.patch
* userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
* userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
* userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
* userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch
* userfaultfd-selftests-use-user-mode-only.patch
* userfaultfd-selftests-remove-the-time-check-on-delayed-uffd.patch
* userfaultfd-selftests-dropping-verify-check-in-locking_thread.patch
* userfaultfd-selftests-only-dump-counts-if-mode-enabled.patch
* userfaultfd-selftests-unify-error-handling.patch
* mm-vmscan-move-reclaim-bits-to-uapi-header.patch
* mm-vmscan-replace-implicit-reclaim_zone-checks-with-explicit-checks.patch
* mm-vmscan-use-nid-from-shrink_control-for-tracepoint.patch
* mm-vmscan-consolidate-shrinker_maps-handling-code.patch
* mm-vmscan-use-shrinker_rwsem-to-protect-shrinker_maps-allocation.patch
* mm-vmscan-remove-memcg_shrinker_map_size.patch
* mm-vmscan-use-kvfree_rcu-instead-of-call_rcu.patch
* mm-memcontrol-rename-shrinker_map-to-shrinker_info.patch
* mm-vmscan-add-shrinker_info_protected-helper.patch
* mm-vmscan-use-a-new-flag-to-indicate-shrinker-is-registered.patch
* mm-vmscan-add-per-memcg-shrinker-nr_deferred.patch
* mm-vmscan-use-per-memcg-nr_deferred-of-shrinker.patch
* mm-vmscan-dont-need-allocate-shrinker-nr_deferred-for-memcg-aware-shrinkers.patch
* mm-memcontrol-reparent-nr_deferred-when-memcg-offline.patch
* mm-vmscan-shrink-deferred-objects-proportional-to-priority.patch
* mm-compaction-remove-unused-variable-sysctl_compact_memory.patch
* mm-compaction-update-the-compact-events-properly.patch
* mm-vmstat-add-cma-statistics.patch
* mm-cma-use-pr_err_ratelimited-for-cma-warning.patch
* mm-cma-support-sysfs.patch
* mm-restore-node-stat-checking-in-proc-sys-vm-stat_refresh.patch
* mm-no-more-einval-from-proc-sys-vm-stat_refresh.patch
* mm-proc-sys-vm-stat_refresh-skip-checking-known-negative-stats.patch
* mm-proc-sys-vm-stat_refresh-stop-checking-monotonic-numa-stats.patch
* x86-mm-tracking-linear-mapping-split-events.patch
* mm-mmap-dont-unlock-vmas-in-remap_file_pages.patch
* mm-reduce-mem_dump_obj-object-size.patch
* mm-gup-dont-pin-migrated-cma-pages-in-movable-zone.patch
* mm-gup-check-every-subpage-of-a-compound-page-during-isolation.patch
* mm-gup-return-an-error-on-migration-failure.patch
* mm-gup-check-for-isolation-errors.patch
* mm-cma-rename-pf_memalloc_nocma-to-pf_memalloc_pin.patch
* mm-apply-per-task-gfp-constraints-in-fast-path.patch
* mm-honor-pf_memalloc_pin-for-all-movable-pages.patch
* mm-gup-do-not-migrate-zero-page.patch
* mm-gup-migrate-pinned-pages-out-of-movable-zone.patch
* memory-hotplugrst-add-a-note-about-zone_movable-and-page-pinning.patch
* mm-gup-change-index-type-to-long-as-it-counts-pages.patch
* mm-gup-longterm-pin-migration-cleanup.patch
* selftests-vm-gup_test-fix-test-flag.patch
* selftests-vm-gup_test-test-faulting-in-kernel-and-verify-pinnable-pages.patch
* mmmemory_hotplug-allocate-memmap-from-the-added-memory-range.patch
* mmmemory_hotplug-allocate-memmap-from-the-added-memory-range-fix.patch
* acpimemhotplug-enable-mhp_memmap_on_memory-when-supported.patch
* mmmemory_hotplug-add-kernel-boot-option-to-enable-memmap_on_memory.patch
* x86-kconfig-introduce-arch_mhp_memmap_on_memory_enable.patch
* arm64-kconfig-introduce-arch_mhp_memmap_on_memory_enable.patch
* mm-zswap-switch-from-strlcpy-to-strscpy.patch
* iov_iter-lift-memzero_page-to-highmemh.patch
* mm-highmem-convert-memzero_page-to-kmap_local_page.patch
* btrfs-use-memzero_page-instead-of-open-coded-kmap-pattern.patch
* mm-highmemc-fix-coding-style-issue.patch
* mm-highmem-remove-deprecated-kmap_atomic.patch
* mm-mempool-minor-coding-style-tweaks.patch
* mm-swapfile-minor-coding-style-tweaks.patch
* mm-sparse-minor-coding-style-tweaks.patch
* mm-vmscan-minor-coding-style-tweaks.patch
* mm-compaction-minor-coding-style-tweaks.patch
* mm-oom_kill-minor-coding-style-tweaks.patch
* mm-shmem-minor-coding-style-tweaks.patch
* mm-page_alloc-minor-coding-style-tweaks.patch
* mm-filemap-minor-coding-style-tweaks.patch
* mm-mlock-minor-coding-style-tweaks.patch
* mm-frontswap-minor-coding-style-tweaks.patch
* mm-vmalloc-minor-coding-style-tweaks.patch
* mm-memory_hotplug-minor-coding-style-tweaks.patch
* mm-mempolicy-minor-coding-style-tweaks.patch
* mm-process_vm_access-remove-duplicate-include.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* procfs-allow-reading-fdinfo-with-ptrace_mode_read.patch
* procfs-dmabuf-add-inode-number-to-proc-fdinfo.patch
* proc-sysctl-make-protected_-world-readable.patch
* include-remove-pagemaph-from-blkdevh.patch
* kernel-asyncc-fix-pr_debug-statement.patch
* kernel-credc-make-init_groups-static.patch
* lib-fix-a-typo-in-the-file-bchc.patch
* lib-fix-inconsistent-indenting-in-process_bit1.patch
* compat-remove-unneeded-declaration-from-compat_syscall_definex.patch
* fs-fat-fix-spelling-typo-of-values.patch
* simplify-copy_mm.patch
* kernel-crash_core-add-crashkernel=auto-for-vmcore-creation.patch
* kexec-add-kexec-reboot-string.patch
* kernel-kexec_file-fix-error-return-code-of-kexec_calculate_store_digests.patch
* aio-simplify-read_events.patch
* gdb-lx-symbols-store-the-abspath.patch
* kernel-asyncc-stop-guarding-pr_debug-statements.patch
* kernel-asyncc-remove-async_unregister_domain.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
