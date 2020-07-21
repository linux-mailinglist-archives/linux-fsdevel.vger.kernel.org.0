Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422DD22755F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 04:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgGUCH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 22:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgGUCHZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:07:25 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC42E20717;
        Tue, 21 Jul 2020 02:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595297243;
        bh=maDB0ntyUCHG/v4FlH6RMS/yWjmkaCH5JDcwbcKC5RQ=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=LJNbqB33tBCGigr7rukXstQIspCmrfcuir/EKZNTJie7r2HjY8f4rtVfrOOJ8aHkD
         aBq4YuiFkvY/kvSjmlXJ/TypCy4kajHK538xGIlDr2THA+Af3wyl/4vjhENIP59V2K
         vR3hSYj9QDvYVsi5oE7OJ2Ftcp7/uCMKx1s0KMYM=
Date:   Mon, 20 Jul 2020 19:07:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-07-20-19-06 uploaded
Message-ID: <20200721020722.6C7YAze1t%akpm@linux-foundation.org>
In-Reply-To: <20200703151445.b6a0cfee402c7c5c4651f1b1@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-07-20-19-06 has been uploaded to

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



This mmotm tree contains the following patches against 5.8-rc6:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-shuffle-dont-move-pages-between-zones-and-dont-read-garbage-memmaps.patch
* mm-avoid-access-flag-update-tlb-flush-for-retried-page-fault.patch
* mm-avoid-access-flag-update-tlb-flush-for-retried-page-fault-v2.patch
* mm-close-race-between-munmap-and-expand_upwards-downwards.patch
* mm-close-race-between-munmap-and-expand_upwards-downwards-fix.patch
* vfs-xattr-mm-shmem-kernfs-release-simple-xattr-entry-in-a-right-way.patch
* mm-initialize-return-of-vm_insert_pages.patch
* mm-memcontrol-fix-oops-inside-mem_cgroup_get_nr_swap_pages.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mm-memcg-fix-refcount-error-while-moving-and-swapping.patch
* mm-memcg-slab-fix-memory-leak-at-non-root-kmem_cache-destroy.patch
* mm-hugetlb-avoid-hardcoding-while-checking-if-cma-is-enabled.patch
* mm-hugetlb-avoid-hardcoding-while-checking-if-cma-is-enabled-fix.patch
* mailmap-add-entry-for-mike-rapoport.patch
* squashfs-fix-length-field-overlap-check-in-metadata-reading.patch
* scripts-decode_stacktrace-strip-basepath-from-all-paths.patch
* checkpatch-test-git_dir-changes.patch
* kthread-remove-incorrect-comment-in-kthread_create_on_cpu.patch
* scripts-tagssh-collect-compiled-source-precisely.patch
* scripts-tagssh-collect-compiled-source-precisely-v2.patch
* bloat-o-meter-support-comparing-library-archives.patch
* scripts-decode_stacktrace-skip-missing-symbols.patch
* scripts-decode_stacktrace-guess-basepath-if-not-specified.patch
* scripts-decode_stacktrace-guess-path-to-modules.patch
* scripts-decode_stacktrace-guess-path-to-vmlinux-by-release-name.patch
* const_structscheckpatch-add-regulator_ops.patch
* scripts-spellingtxt-add-more-spellings-to-spellingtxt.patch
* ntfs-fix-ntfs_test_inode-and-ntfs_init_locked_inode-function-type.patch
* ocfs2-fix-remounting-needed-after-setfacl-command.patch
* ocfs2-suballoch-delete-a-duplicated-word.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* ocfs2-change-slot-number-type-s16-to-u16.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-treewide-rename-kzfree-to-kfree_sensitive.patch
* mm-ksize-should-silently-accept-a-null-pointer.patch
* mm-expand-config_slab_freelist_hardened-to-include-slab.patch
* slab-add-naive-detection-of-double-free.patch
* slab-add-naive-detection-of-double-free-fix.patch
* mm-slab-check-gfp_slab_bug_mask-before-alloc_pages-in-kmalloc_order.patch
* mm-slub-extend-slub_debug-syntax-for-multiple-blocks.patch
* mm-slub-extend-slub_debug-syntax-for-multiple-blocks-fix.patch
* mm-slub-make-some-slub_debug-related-attributes-read-only.patch
* mm-slub-remove-runtime-allocation-order-changes.patch
* mm-slub-make-remaining-slub_debug-related-attributes-read-only.patch
* mm-slub-make-reclaim_account-attribute-read-only.patch
* mm-slub-introduce-static-key-for-slub_debug.patch
* mm-slub-introduce-kmem_cache_debug_flags.patch
* mm-slub-introduce-kmem_cache_debug_flags-fix.patch
* mm-slub-extend-checks-guarded-by-slub_debug-static-key.patch
* mm-slab-slub-move-and-improve-cache_from_obj.patch
* mm-slab-slub-improve-error-reporting-and-overhead-of-cache_from_obj.patch
* mm-slab-slub-improve-error-reporting-and-overhead-of-cache_from_obj-fix.patch
* slub-drop-lockdep_assert_held-from-put_map.patch
* mm-kcsan-instrument-slab-slub-free-with-assert_exclusive_access.patch
* mm-debug_vm_pgtable-add-tests-validating-arch-helpers-for-core-mm-features.patch
* mm-debug_vm_pgtable-add-tests-validating-advanced-arch-page-table-helpers.patch
* mm-debug_vm_pgtable-add-tests-validating-advanced-arch-page-table-helpers-v5.patch
* mm-debug_vm_pgtable-add-debug-prints-for-individual-tests.patch
* documentation-mm-add-descriptions-for-arch-page-table-helpers.patch
* documentation-mm-add-descriptions-for-arch-page-table-helpers-v5.patch
* mm-handle-page-mapping-better-in-dump_page.patch
* mm-handle-page-mapping-better-in-dump_page-fix.patch
* mm-dump-compound-page-information-on-a-second-line.patch
* mm-print-head-flags-in-dump_page.patch
* mm-switch-dump_page-to-get_kernel_nofault.patch
* mm-print-the-inode-number-in-dump_page.patch
* mm-print-hashed-address-of-struct-page.patch
* mm-filemap-clear-idle-flag-for-writes.patch
* mm-filemap-add-missing-fgp_-flags-in-kerneldoc-comment-for-pagecache_get_page.patch
* mm-gupc-fix-the-comment-of-return-value-for-populate_vma_page_range.patch
* mm-swap-simplify-alloc_swap_slot_cache.patch
* mm-swap-simplify-enable_swap_slots_cache.patch
* mm-swap-remove-redundant-check-for-swap_slot_cache_initialized.patch
* tmpfs-per-superblock-i_ino-support.patch
* tmpfs-support-64-bit-inums-per-sb.patch
* mm-kmem-make-memcg_kmem_enabled-irreversible.patch
* mm-memcg-factor-out-memcg-and-lruvec-level-changes-out-of-__mod_lruvec_state.patch
* mm-memcg-prepare-for-byte-sized-vmstat-items.patch
* mm-memcg-convert-vmstat-slab-counters-to-bytes.patch
* mm-slub-implement-slub-version-of-obj_to_index.patch
* mm-memcontrol-decouple-reference-counting-from-page-accounting.patch
* mm-memcg-slab-obj_cgroup-api.patch
* mm-memcg-slab-allocate-obj_cgroups-for-non-root-slab-pages.patch
* mm-memcg-slab-save-obj_cgroup-for-non-root-slab-objects.patch
* mm-memcg-slab-charge-individual-slab-objects-instead-of-pages.patch
* mm-memcg-slab-deprecate-memorykmemslabinfo.patch
* mm-memcg-slab-move-memcg_kmem_bypass-to-memcontrolh.patch
* mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-accounted-allocations.patch
* mm-memcg-slab-simplify-memcg-cache-creation.patch
* mm-memcg-slab-remove-memcg_kmem_get_cache.patch
* mm-memcg-slab-deprecate-slab_root_caches.patch
* mm-memcg-slab-remove-redundant-check-in-memcg_accumulate_slabinfo.patch
* mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations.patch
* mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations-fix.patch
* kselftests-cgroup-add-kernel-memory-accounting-tests.patch
* tools-cgroup-add-memcg_slabinfopy-tool.patch
* percpu-return-number-of-released-bytes-from-pcpu_free_area.patch
* mm-memcg-percpu-account-percpu-memory-to-memory-cgroups.patch
* mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix.patch
* mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix-fix.patch
* mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix-2.patch
* mm-memcg-percpu-per-memcg-percpu-memory-statistics.patch
* mm-memcg-percpu-per-memcg-percpu-memory-statistics-v3.patch
* mm-memcg-charge-memcg-percpu-memory-to-the-parent-cgroup.patch
* kselftests-cgroup-add-perpcu-memory-accounting-test.patch
* mm-memcontrol-account-kernel-stack-per-node.patch
* mm-memcg-slab-remove-unused-argument-by-charge_slab_page.patch
* mm-slab-rename-uncharge_slab_page-to-unaccount_slab_page.patch
* mm-kmem-switch-to-static_branch_likely-in-memcg_kmem_enabled.patch
* mm-memcontrol-avoid-workload-stalls-when-lowering-memoryhigh.patch
* mm-memcg-reclaim-more-aggressively-before-high-allocator-throttling.patch
* mm-memcg-unify-reclaim-retry-limits-with-page-allocator.patch
* mm-memcg-avoid-stale-protection-values-when-cgroup-is-above-protection.patch
* mm-memcg-decouple-elowmin-state-mutations-from-protection-checks.patch
* memcg-oom-check-memcg-margin-for-parallel-oom.patch
* mm-remove-redundant-check-non_swap_entry.patch
* mm-memoryc-make-remap_pfn_range-reject-unaligned-addr.patch
* mm-remove-unneeded-includes-of-asm-pgalloch.patch
* mm-remove-unneeded-includes-of-asm-pgalloch-fix.patch
* opeinrisc-switch-to-generic-version-of-pte-allocation.patch
* xtensa-switch-to-generic-version-of-pte-allocation.patch
* asm-generic-pgalloc-provide-generic-pmd_alloc_one-and-pmd_free_one.patch
* asm-generic-pgalloc-provide-generic-pud_alloc_one-and-pud_free_one.patch
* asm-generic-pgalloc-provide-generic-pgd_free.patch
* mm-move-lib-ioremapc-to-mm.patch
* mm-move-pd_alloc_track-to-separate-header-file.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-mmap-optimize-a-branch-judgment-in-ksys_mmap_pgoff.patch
* proc-meminfo-avoid-open-coded-reading-of-vm_committed_as.patch
* mm-utilc-make-vm_memory_committed-more-accurate.patch
* percpu_counter-add-percpu_counter_sync.patch
* mm-adjust-vm_committed_as_batch-according-to-vm-overcommit-policy.patch
* mm-pgtable-make-generic-pgprot_-macros-available-for-no-mmu.patch
* riscv-use-generic-pgprot_-macros-from-linux-pgtableh.patch
* mm-sparsemem-enable-vmem_altmap-support-in-vmemmap_populate_basepages.patch
* mm-sparsemem-enable-vmem_altmap-support-in-vmemmap_alloc_block_buf.patch
* arm64-mm-enable-vmem_altmap-support-for-vmemmap-mappings.patch
* mm-mremap-it-is-sure-to-have-enough-space-when-extent-meets-requirement.patch
* mm-mremap-calculate-extent-in-one-place.patch
* mm-mremap-start-addresses-are-properly-aligned.patch
* mm-sparse-never-partially-remove-memmap-for-early-section.patch
* mm-sparse-only-sub-section-aligned-range-would-be-populated.patch
* mm-sparse-cleanup-the-code-surrounding-memory_present.patch
* vmalloc-convert-to-xarray.patch
* mm-vmalloc-simplify-merge_or_add_vmap_area-func.patch
* mm-vmalloc-simplify-augment_tree_propagate_check-func.patch
* mm-vmalloc-switch-to-propagate-callback.patch
* mm-vmalloc-update-the-header-about-kva-rework.patch
* mm-vmalloc-remove-redundant-asignmnet-in-unmap_kernel_range_noflush.patch
* mm-vmallocc-remove-bug-from-the-find_va_links.patch
* kasan-improve-and-simplify-kconfigkasan.patch
* kasan-update-required-compiler-versions-in-documentation.patch
* rcu-kasan-record-and-print-call_rcu-call-stack.patch
* rcu-kasan-record-and-print-call_rcu-call-stack-v8.patch
* kasan-record-and-print-the-free-track.patch
* kasan-record-and-print-the-free-track-v8.patch
* kasan-add-tests-for-call_rcu-stack-recording.patch
* kasan-update-documentation-for-generic-kasan.patch
* kasan-remove-kasan_unpoison_stack_above_sp_to.patch
* kasan-fix-kasan-unit-tests-for-tag-based-kasan.patch
* kasan-fix-kasan-unit-tests-for-tag-based-kasan-v4.patch
* mm-page_alloc-use-unlikely-in-task_capc.patch
* page_alloc-consider-highatomic-reserve-in-watermark-fast.patch
* page_alloc-consider-highatomic-reserve-in-watermark-fast-v5.patch
* mm-page_alloc-skip-waternark_boost-for-atomic-order-0-allocations.patch
* mm-page_alloc-skip-watermark_boost-for-atomic-order-0-allocations-fix.patch
* mm-drop-vm_total_pages.patch
* mm-page_alloc-drop-nr_free_pagecache_pages.patch
* mm-memory_hotplug-document-why-shuffle_zone-is-relevant.patch
* mm-shuffle-remove-dynamic-reconfiguration.patch
* powerpc-numa-set-numa_node-for-all-possible-cpus.patch
* powerpc-numa-prefer-node-id-queried-from-vphn.patch
* mm-page_alloc-keep-memoryless-cpuless-node-0-offline.patch
* mm-page_allocc-replace-the-definition-of-nr_migratetype_bits-with-pb_migratetype_bits.patch
* mm-page_allocc-extract-the-common-part-in-pfn_to_bitidx.patch
* mm-page_allocc-simplify-pageblock-bitmap-access.patch
* mm-page_allocc-remove-unnecessary-end_bitidx-for-_pfnblock_flags_mask.patch
* mm-page_alloc-silence-a-kasan-false-positive.patch
* mm-page_alloc-fallbacks-at-most-has-3-elements.patch
* mm-page_alloc-skip-setting-nodemask-when-we-are-in-interrupt.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* mm-hugetlb-split-hugetlb_cma-in-nodes-with-memory.patch
* mm-thp-replace-http-links-with-https-ones.patch
* mm-thp-replace-http-links-with-https-ones-fix.patch
* mm-vmscanc-fixed-typo.patch
* mm-vmscan-consistent-update-to-pgrefill.patch
* mm-proactive-compaction.patch
* mm-proactive-compaction-fix.patch
* mm-use-unsigned-types-for-fragmentation-score.patch
* mm-oom-make-the-calculation-of-oom-badness-more-accurate.patch
* mm-oom-make-the-calculation-of-oom-badness-more-accurate-v3.patch
* doc-mm-sync-up-oom_score_adj-documentation.patch
* doc-mm-clarify-proc-pid-oom_score-value-range.patch
* hugetlbfs-prevent-filesystem-stacking-of-hugetlbfs.patch
* mm-migrate-optimize-migrate_vma_setup-for-holes.patch
* mm-migrate-optimize-migrate_vma_setup-for-holes-v2.patch
* mm-migrate-add-migrate-shared-test-for-migrate_vma_.patch
* mm-thp-remove-debug_cow-switch.patch
* mm-store-compound_nr-as-well-as-compound_order.patch
* mm-move-page-flags-include-to-top-of-file.patch
* mm-add-thp_order.patch
* mm-add-thp_size.patch
* mm-replace-hpage_nr_pages-with-thp_nr_pages.patch
* mm-add-thp_head.patch
* mm-introduce-offset_in_thp.patch
* mm-vmstat-add-events-for-thp-migration-without-split.patch
* mm-vmstat-add-events-for-thp-migration-without-split-fix.patch
* mm-vmstat-add-events-for-thp-migration-without-split-fix-2.patch
* mm-cma-fix-null-pointer-dereference-when-cma-could-not-be-activated.patch
* mm-cma-fix-the-name-of-cma-areas.patch
* mm-cma-fix-the-name-of-cma-areas-fix.patch
* mm-hugetlb-fix-the-name-of-hugetlb-cma.patch
* mmhwpoison-cleanup-unused-pagehuge-check.patch
* mm-hwpoison-remove-recalculating-hpage.patch
* mmmadvise-call-soft_offline_page-without-mf_count_increased.patch
* mmmadvise-refactor-madvise_inject_error.patch
* mmhwpoison-inject-dont-pin-for-hwpoison_filter.patch
* mmhwpoison-un-export-get_hwpoison_page-and-make-it-static.patch
* mmhwpoison-kill-put_hwpoison_page.patch
* mmhwpoison-remove-mf_count_increased.patch
* mmhwpoison-remove-flag-argument-from-soft-offline-functions.patch
* mmhwpoison-unify-thp-handling-for-hard-and-soft-offline.patch
* mmhwpoison-rework-soft-offline-for-free-pages.patch
* mmhwpoison-rework-soft-offline-for-in-use-pages.patch
* mmhwpoison-rework-soft-offline-for-in-use-pages-fix.patch
* mmhwpoison-refactor-soft_offline_huge_page-and-__soft_offline_page.patch
* mmhwpoison-return-0-if-the-page-is-already-poisoned-in-soft-offline.patch
* mmhwpoison-introduce-mf_msg_unsplit_thp.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
* sched-mm-optimize-current_gfp_context.patch
* x86-mm-use-max-memory-block-size-on-bare-metal.patch
* x86-mm-use-max-memory-block-size-on-bare-metal-v3.patch
* mm-memory_hotplug-introduce-default-dummy-memory_add_physaddr_to_nid.patch
* mm-memory_hotplug-fix-unpaired-mem_hotplug_begin-done.patch
* linux-sched-mmh-drop-duplicated-words-in-comments.patch
* mm-drop-duplicated-words-in-linux-pgtableh.patch
* mm-drop-duplicated-words-in-linux-mmh.patch
* highmem-linux-highmemh-fix-duplicated-words-in-a-comment.patch
* frontswap-linux-frontswaph-drop-duplicated-word-in-a-comment.patch
* memcontrol-drop-duplicate-word-and-fix-spello-in-linux-memcontrolh.patch
* syscalls-use-uaccess_kernel-in-addr_limit_user_check.patch
* nds32-use-uaccess_kernel-in-show_regs.patch
* riscv-include-asm-pgtableh-in-asm-uaccessh.patch
* uaccess-remove-segment_eq.patch
* uaccess-add-force_uaccess_beginend-helpers.patch
* uaccess-add-force_uaccess_beginend-helpers-v2.patch
* exec-use-force_uaccess_begin-during-exec-and-exit.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* fix-annotation-of-ioreadwrite1632be.patch
* proc-sysctl-make-protected_-world-readable.patch
* clang-linux-compiler-clangh-drop-duplicated-word-in-a-comment.patch
* linux-exportfsh-drop-duplicated-word-in-a-comment.patch
* linux-async_txh-drop-duplicated-word-in-a-comment.patch
* xz-drop-duplicated-word-in-linux-xzh.patch
* sparse-group-the-defines-by-functionality.patch
* bitmap-fix-bitmap_cut-for-partial-overlapping-case.patch
* bitmap-add-test-for-bitmap_cut.patch
* lib-generic-radix-treec-remove-unneeded-__rcu.patch
* lib-test_bitops-do-the-full-test-during-module-init.patch
* lib-optimize-cpumask_local_spread.patch
* lib-test_lockupc-make-symbol-test_works-static.patch
* iomap-constify-ioreadx-iomem-argument-as-in-generic-implementation.patch
* rtl818x-constify-ioreadx-iomem-argument-as-in-generic-implementation.patch
* ntb-intel-constify-ioreadx-iomem-argument-as-in-generic-implementation.patch
* virtio-pci-constify-ioreadx-iomem-argument-as-in-generic-implementation.patch
* bits-add-tests-of-genmask.patch
* bits-add-tests-of-genmask-fix.patch
* bits-add-tests-of-genmask-fix-2.patch
* checkpatch-add-test-for-possible-misuse-of-is_enabled-without-config_.patch
* checkpatch-support-deprecated-terms-checking.patch
* scripts-deprecated_terms-recommend-denylist-allowlist-instead-of-blacklist-whitelist.patch
* checkpatch-add-fix-option-for-assign_in_if.patch
* checkpatch-fix-const_struct-when-const_structscheckpatch-is-missing.patch
* autofs-fix-doubled-word.patch
* fs-minix-check-return-value-of-sb_getblk.patch
* fs-minix-dont-allow-getting-deleted-inodes.patch
* fs-minix-reject-too-large-maximum-file-size.patch
* fs-minix-set-s_maxbytes-correctly.patch
* fs-minix-fix-block-limit-check-for-v1-filesystems.patch
* fs-minix-remove-expected-error-message-in-block_to_path.patch
* fs-ufs-avoid-potential-u32-multiplication-overflow.patch
* fatfs-switch-write_lock-to-read_lock-in-fat_ioctl_get_attributes.patch
* vfat-fat-msdos-filesystem-replace-http-links-with-https-ones.patch
* fat-fix-fat_ra_init-for-data-clusters-==-0.patch
* fs-signalfdc-fix-inconsistent-return-codes-for-signalfd4.patch
* selftests-kmod-use-variable-name-in-kmod_test_0001.patch
* kmod-remove-redundant-be-an-in-the-comment.patch
* test_kmod-avoid-potential-double-free-in-trigger_config_run_type.patch
* coredump-add-%f-for-executable-filename.patch
* exec-change-uselib2-is_sreg-failure-to-eacces.patch
* exec-move-s_isreg-check-earlier.patch
* exec-move-path_noexec-check-earlier.patch
* kdump-append-kernel-build-id-string-to-vmcoreinfo.patch
* rapidio-rio_mport_cdev-use-struct_size-helper.patch
* rapidio-use-struct_size-helper.patch
* rapidio-rio_mport_cdev-use-array_size-helper-in-copy_fromto_user.patch
* kernel-panicc-make-oops_may_print-return-bool.patch
* lib-kconfigdebug-fix-typo-in-the-help-text-of-config_panic_timeout.patch
* aio-simplify-read_events.patch
* kcov-unconditionally-add-fno-stack-protector-to-compiler-options.patch
* kcov-make-some-symbols-static.patch
* ipc-uninline-functions.patch
* ipc-shmc-remove-the-superfluous-break.patch
  linux-next.patch
  linux-next-rejects.patch
* mm-page_isolation-prefer-the-node-of-the-source-page.patch
* mm-migrate-move-migration-helper-from-h-to-c.patch
* mm-hugetlb-unify-migration-callbacks.patch
* mm-migrate-clear-__gfp_reclaim-to-make-the-migration-callback-consistent-with-regular-thp-allocations.patch
* mm-migrate-clear-__gfp_reclaim-to-make-the-migration-callback-consistent-with-regular-thp-allocations-fix.patch
* mm-migrate-make-a-standard-migration-target-allocation-function.patch
* mm-mempolicy-use-a-standard-migration-target-allocation-callback.patch
* mm-page_alloc-remove-a-wrapper-for-alloc_migration_target.patch
* mm-memory-failure-remove-a-wrapper-for-alloc_migration_target.patch
* mm-memory_hotplug-remove-a-wrapper-for-alloc_migration_target.patch
* scripts-deprecated_terms-sync-with-inclusive-terms.patch
* mm-do-page-fault-accounting-in-handle_mm_fault.patch
* mm-alpha-use-general-page-fault-accounting.patch
* mm-arc-use-general-page-fault-accounting.patch
* mm-arm-use-general-page-fault-accounting.patch
* mm-arm64-use-general-page-fault-accounting.patch
* mm-csky-use-general-page-fault-accounting.patch
* mm-hexagon-use-general-page-fault-accounting.patch
* mm-ia64-use-general-page-fault-accounting.patch
* mm-m68k-use-general-page-fault-accounting.patch
* mm-microblaze-use-general-page-fault-accounting.patch
* mm-mips-use-general-page-fault-accounting.patch
* mm-nds32-use-general-page-fault-accounting.patch
* mm-nios2-use-general-page-fault-accounting.patch
* mm-openrisc-use-general-page-fault-accounting.patch
* mm-parisc-use-general-page-fault-accounting.patch
* mm-powerpc-use-general-page-fault-accounting.patch
* mm-riscv-use-general-page-fault-accounting.patch
* mm-s390-use-general-page-fault-accounting.patch
* mm-sh-use-general-page-fault-accounting.patch
* mm-sparc32-use-general-page-fault-accounting.patch
* mm-sparc64-use-general-page-fault-accounting.patch
* mm-x86-use-general-page-fault-accounting.patch
* mm-xtensa-use-general-page-fault-accounting.patch
* mm-clean-up-the-last-pieces-of-page-fault-accountings.patch
* mm-gup-remove-task_struct-pointer-for-all-gup-code.patch
* mm-gup-remove-task_struct-pointer-for-all-gup-code-fix.patch
* mm-madvise-pass-task-and-mm-to-do_madvise.patch
* pid-move-pidfd_get_pid-to-pidc.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix.patch
* mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-api-fix-2.patch
* mm-madvise-check-fatal-signal-pending-of-target-process.patch
* all-arch-remove-system-call-sys_sysctl.patch
* all-arch-remove-system-call-sys_sysctl-fix.patch
* mm-kmemleak-silence-kcsan-splats-in-checksum.patch
* mm-frontswap-mark-various-intentional-data-races.patch
* mm-page_io-mark-various-intentional-data-races.patch
* mm-page_io-mark-various-intentional-data-races-v2.patch
* mm-swap_state-mark-various-intentional-data-races.patch
* mm-filemap-fix-a-data-race-in-filemap_fault.patch
* mm-swapfile-fix-and-annotate-various-data-races.patch
* mm-swapfile-fix-and-annotate-various-data-races-v2.patch
* mm-page_counter-fix-various-data-races-at-memsw.patch
* mm-memcontrol-fix-a-data-race-in-scan-count.patch
* mm-list_lru-fix-a-data-race-in-list_lru_count_one.patch
* mm-mempool-fix-a-data-race-in-mempool_free.patch
* mm-rmap-annotate-a-data-race-at-tlb_flush_batched.patch
* mm-swap-annotate-data-races-for-lru_rotate_pvecs.patch
* mm-annotate-a-data-race-in-page_zonenum.patch
* include-asm-generic-vmlinuxldsh-align-ro_after_init.patch
* sh-clkfwk-remove-r8-r16-r32.patch
* sh-use-generic-strncpy.patch
* sh-add-missing-export_symbol-for-__delay.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
