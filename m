Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF03D1EDA31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 02:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgFDAzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 20:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbgFDAzB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:55:01 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6282A20674;
        Thu,  4 Jun 2020 00:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591232098;
        bh=1aN+9+eIKkS1M99rZQPdIAIMVpBoUtGIrWD6KgqCehg=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=CW7/QjQtGJjP3QP3utPu9cKRpHjFEhXtAFlNTFTWxvMh93meEq3YckIm6esQzxzpy
         b07IJ97ATMuUy0Ys4na/DO+7sJYHAZDVyoIjJWIzmXKMOtN/D+Egrdq6RbKXDP6jdn
         pFrZhvCaYjBro5hmeHejdicQt6H77hT2c7MmXlTA=
Date:   Wed, 03 Jun 2020 17:54:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-06-03-17-54 uploaded
Message-ID: <20200604005457.AiZmy4LLi%akpm@linux-foundation.org>
In-Reply-To: <20200603155549.e041363450869eaae4c7f05b@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-06-03-17-54 has been uploaded to

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



This mmotm tree contains the following patches against 5.7:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-slub-fix-a-memory-leak-in-sysfs_slab_add.patch
* memcg-optimize-memorynuma_stat-like-memorystat.patch
* mm-gup-move-__get_user_pages_fast-down-a-few-lines-in-gupc.patch
* mm-gup-refactor-and-de-duplicate-gup_fast-code.patch
* mm-gup-introduce-pin_user_pages_fast_only.patch
* drm-i915-convert-get_user_pages-pin_user_pages.patch
* mm-gup-might_lock_readmmap_sem-in-get_user_pages_fast.patch
* kasan-stop-tests-being-eliminated-as-dead-code-with-fortify_source.patch
* stringh-fix-incompatibility-between-fortify_source-and-kasan.patch
* mm-clarify-__gfp_memalloc-usage.patch
* mm-memblock-replace-dereferences-of-memblock_regionnid-with-api-calls.patch
* mm-make-early_pfn_to_nid-and-related-defintions-close-to-each-other.patch
* mm-remove-config_have_memblock_node_map-option.patch
* mm-free_area_init-use-maximal-zone-pfns-rather-than-zone-sizes.patch
* mm-use-free_area_init-instead-of-free_area_init_nodes.patch
* alpha-simplify-detection-of-memory-zone-boundaries.patch
* arm-simplify-detection-of-memory-zone-boundaries.patch
* arm64-simplify-detection-of-memory-zone-boundaries-for-uma-configs.patch
* csky-simplify-detection-of-memory-zone-boundaries.patch
* m68k-mm-simplify-detection-of-memory-zone-boundaries.patch
* parisc-simplify-detection-of-memory-zone-boundaries.patch
* sparc32-simplify-detection-of-memory-zone-boundaries.patch
* unicore32-simplify-detection-of-memory-zone-boundaries.patch
* xtensa-simplify-detection-of-memory-zone-boundaries.patch
* mm-memmap_init-iterate-over-memblock-regions-rather-that-check-each-pfn.patch
* mm-remove-early_pfn_in_nid-and-config_nodes_span_other_nodes.patch
* mm-free_area_init-allow-defining-max_zone_pfn-in-descending-order.patch
* mm-rename-free_area_init_node-to-free_area_init_memoryless_node.patch
* mm-clean-up-free_area_init_node-and-its-helpers.patch
* mm-simplify-find_min_pfn_with_active_regions.patch
* docs-vm-update-memory-models-documentation.patch
* mm-page_allocc-bad_-is-not-necessary-when-pagehwpoison.patch
* mm-page_allocc-bad_flags-is-not-necessary-for-bad_page.patch
* mm-page_allocc-rename-free_pages_check_bad-to-check_free_page_bad.patch
* mm-page_allocc-rename-free_pages_check-to-check_free_page.patch
* mm-page_allocc-extract-check__page_bad-common-part-to-page_bad_reason.patch
* mmpage_alloccma-conditionally-prefer-cma-pageblocks-for-movable-allocations.patch
* mm-remove-unused-free_bootmem_with_active_regions.patch
* mm-page_allocc-only-tune-sysctl_lowmem_reserve_ratio-value-once-when-changing-it.patch
* mm-page_allocc-clear-out-zone-lowmem_reserve-if-the-zone-is-empty.patch
* mm-vmstatc-do-not-show-lowmem-reserve-protection-information-of-empty-zone.patch
* mm-page_alloc-use-ac-high_zoneidx-for-classzone_idx.patch
* mm-page_alloc-integrate-classzone_idx-and-high_zoneidx.patch
* mm-page_allocc-use-node_mask_none-in-build_zonelists.patch
* mm-rename-gfpflags_to_migratetype-to-gfp_migratetype-for-same-convention.patch
* mm-reset-numa-stats-for-boot-pagesets.patch
* mm-page_alloc-reset-the-zone-watermark_boost-early.patch
* mm-page_alloc-restrict-and-formalize-compound_page_dtors.patch
* mm-call-touch_nmi_watchdog-on-max-order-boundaries-in-deferred-init.patch
* mm-initialize-deferred-pages-with-interrupts-enabled.patch
* mm-call-cond_resched-from-deferred_init_memmap.patch
* padata-remove-exit-routine.patch
* padata-initialize-earlier.patch
* padata-allocate-work-structures-for-parallel-jobs-from-a-pool.patch
* padata-add-basic-support-for-multithreaded-jobs.patch
* mm-dont-track-number-of-pages-during-deferred-initialization.patch
* mm-parallelize-deferred_init_memmap.patch
* mm-make-deferred-inits-max-threads-arch-specific.patch
* padata-document-multithreaded-jobs.patch
* mm-page_allocc-add-missing-line-breaks.patch
* khugepaged-add-self-test.patch
* khugepaged-do-not-stop-collapse-if-less-than-half-ptes-are-referenced.patch
* khugepaged-drain-all-lru-caches-before-scanning-pages.patch
* khugepaged-drain-lru-add-pagevec-after-swapin.patch
* khugepaged-allow-to-collapse-a-page-shared-across-fork.patch
* khugepaged-allow-to-collapse-pte-mapped-compound-pages.patch
* thp-change-cow-semantics-for-anon-thp.patch
* khugepaged-introduce-max_ptes_shared-tunable.patch
* hugetlbfs-add-arch_hugetlb_valid_size.patch
* hugetlbfs-move-hugepagesz=-parsing-to-arch-independent-code.patch
* hugetlbfs-remove-hugetlb_add_hstate-warning-for-existing-hstate.patch
* hugetlbfs-clean-up-command-line-processing.patch
* hugetlbfs-move-hugepagesz=-parsing-to-arch-independent-code-fix.patch
* mm-hugetlb-avoid-unnecessary-check-on-pud-and-pmd-entry-in-huge_pte_offset.patch
* arm64-mm-drop-__have_arch_huge_ptep_get.patch
* mm-hugetlb-define-a-generic-fallback-for-is_hugepage_only_range.patch
* mm-hugetlb-define-a-generic-fallback-for-arch_clear_hugepage_flags.patch
* mm-simplify-calling-a-compound-page-destructor.patch
* mm-vmscanc-use-update_lru_size-in-update_lru_sizes.patch
* mm-vmscan-count-layzfree-pages-and-fix-nr_isolated_-mismatch.patch
* mm-vmscanc-change-prototype-for-shrink_page_list.patch
* mm-vmscan-update-the-comment-of-should_continue_reclaim.patch
* mm-fix-numa-node-file-count-error-in-replace_page_cache.patch
* mm-memcontrol-fix-stat-corrupting-race-in-charge-moving.patch
* mm-memcontrol-drop-compound-parameter-from-memcg-charging-api.patch
* mm-shmem-remove-rare-optimization-when-swapin-races-with-hole-punching.patch
* mm-memcontrol-move-out-cgroup-swaprate-throttling.patch
* mm-memcontrol-convert-page-cache-to-a-new-mem_cgroup_charge-api.patch
* mm-memcontrol-prepare-uncharging-for-removal-of-private-page-type-counters.patch
* mm-memcontrol-prepare-move_account-for-removal-of-private-page-type-counters.patch
* mm-memcontrol-prepare-cgroup-vmstat-infrastructure-for-native-anon-counters.patch
* mm-memcontrol-switch-to-native-nr_file_pages-and-nr_shmem-counters.patch
* mm-memcontrol-switch-to-native-nr_anon_mapped-counter.patch
* mm-memcontrol-switch-to-native-nr_anon_thps-counter.patch
* mm-memcontrol-convert-anon-and-file-thp-to-new-mem_cgroup_charge-api.patch
* mm-memcontrol-drop-unused-try-commit-cancel-charge-api.patch
* mm-memcontrol-prepare-swap-controller-setup-for-integration.patch
* mm-memcontrol-make-swap-tracking-an-integral-part-of-memory-control.patch
* mm-memcontrol-charge-swapin-pages-on-instantiation.patch
* mm-memcontrol-document-the-new-swap-control-behavior.patch
* mm-memcontrol-delete-unused-lrucare-handling.patch
* mm-memcontrol-update-page-mem_cgroup-stability-rules.patch
* mm-fix-lru-balancing-effect-of-new-transparent-huge-pages.patch
* mm-keep-separate-anon-and-file-statistics-on-page-reclaim-activity.patch
* mm-allow-swappiness-that-prefers-reclaiming-anon-over-the-file-workingset.patch
* mm-fold-and-remove-lru_cache_add_anon-and-lru_cache_add_file.patch
* mm-workingset-let-cache-workingset-challenge-anon.patch
* mm-remove-use-once-cache-bias-from-lru-balancing.patch
* mm-vmscan-drop-unnecessary-div0-avoidance-rounding-in-get_scan_count.patch
* mm-base-lru-balancing-on-an-explicit-cost-model.patch
* mm-deactivations-shouldnt-bias-the-lru-balance.patch
* mm-only-count-actual-rotations-as-lru-reclaim-cost.patch
* mm-balance-lru-lists-based-on-relative-thrashing.patch
* mm-vmscan-determine-anon-file-pressure-balance-at-the-reclaim-root.patch
* mm-vmscan-reclaim-writepage-is-io-cost.patch
* mm-vmscan-limit-the-range-of-lru-type-balancing.patch
* mm-swap-fix-vmstats-for-huge-pages.patch
* mm-swap-memcg-fix-memcg-stats-for-huge-pages.patch
* tools-vm-page_owner_sort-filter-out-unneeded-line.patch
* mm-mempolicy-fix-up-gup-usage-in-lookup_node.patch
* mm-memblock-fix-minor-typo-and-unclear-comment.patch
* sparc32-register-memory-occupied-by-kernel-as-memblockmemory.patch
* hugetlbfs-get-unmapped-area-below-task_unmapped_base-for-hugetlbfs.patch
* mm-thp-dont-need-drain-lru-cache-when-splitting-and-mlocking-thp.patch
* powerpc-mm-drop-platform-defined-pmd_mknotpresent.patch
* mm-thp-rename-pmd_mknotpresent-as-pmd_mknotvalid.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup.patch
* mm-add-debug_wx-support.patch
* riscv-support-debug_wx.patch
* x86-mm-use-arch_has_debug_wx-instead-of-arch-defined.patch
* arm64-mm-use-arch_has_debug_wx-instead-of-arch-defined.patch
* checkpatch-test-git_dir-changes.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* kcov-cleanup-debug-messages.patch
* kcov-fix-potential-use-after-free-in-kcov_remote_start.patch
* kcov-move-t-kcov-assignments-into-kcov_start-stop.patch
* kcov-move-t-kcov_sequence-assignment.patch
* kcov-use-t-kcov_mode-as-enabled-indicator.patch
* kcov-collect-coverage-from-interrupts.patch
* usb-core-kcov-collect-coverage-from-usb-complete-callback.patch
* lib-lzo-fix-ambiguous-encoding-bug-in-lzo-rle.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* drivers-tty-serial-sh-scic-suppress-uninitialized-var-warning.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-page_alloc-skip-waternark_boost-for-atomic-order-0-allocations.patch
* mm-page_alloc-skip-waternark_boost-for-atomic-order-0-allocations-fix.patch
* mm-add-comments-on-pglist_data-zones.patch
* arch-kmap-remove-bug_on.patch
* arch-xtensa-move-kmap-build-bug-out-of-the-way.patch
* arch-kmap-remove-redundant-arch-specific-kmaps.patch
* arch-kunmap-remove-duplicate-kunmap-implementations.patch
* arch-kunmap-remove-duplicate-kunmap-implementations-fix.patch
* x86powerpcmicroblaze-kmap-move-preempt-disable.patch
* arch-kmap_atomic-consolidate-duplicate-code.patch
* arch-kmap_atomic-consolidate-duplicate-code-checkpatch-fixes.patch
* arch-kunmap_atomic-consolidate-duplicate-code.patch
* arch-kunmap_atomic-consolidate-duplicate-code-fix.patch
* arch-kunmap_atomic-consolidate-duplicate-code-checkpatch-fixes.patch
* arch-kmap-ensure-kmap_prot-visibility.patch
* arch-kmap-dont-hard-code-kmap_prot-values.patch
* arch-kmap-define-kmap_atomic_prot-for-all-archs.patch
* drm-remove-drm-specific-kmap_atomic-code.patch
* drm-remove-drm-specific-kmap_atomic-code-fix.patch
* kmap-remove-kmap_atomic_to_page.patch
* parisc-kmap-remove-duplicate-kmap-code.patch
* sparc-remove-unnecessary-includes.patch
* kmap-consolidate-kmap_prot-definitions.patch
* kmap-consolidate-kmap_prot-definitions-checkpatch-fixes.patch
* mm-vmstat-add-events-for-pmd-based-thp-migration-without-split.patch
* mm-vmstat-add-events-for-pmd-based-thp-migration-without-split-fix.patch
* mm-vmstat-add-events-for-pmd-based-thp-migration-without-split-update.patch
* mm-add-kvfree_sensitive-for-freeing-sensitive-data-objects.patch
* mm-memory_hotplug-refrain-from-adding-memory-into-an-impossible-node.patch
* powerpc-pseries-hotplug-memory-stop-checking-is_mem_section_removable.patch
* mm-memory_hotplug-remove-is_mem_section_removable.patch
* mm-memory_hotplug-set-node_start_pfn-of-hotadded-pgdat-to-0.patch
* mm-memory_hotplug-handle-memblocks-only-with-config_arch_keep_memblock.patch
* mm-memory_hotplug-introduce-add_memory_driver_managed.patch
* kexec_file-dont-place-kexec-images-on-ioresource_mem_driver_managed.patch
* device-dax-add-memory-via-add_memory_driver_managed.patch
* mm-replace-zero-length-array-with-flexible-array-member.patch
* mm-replace-zero-length-array-with-flexible-array-member-fix.patch
* mm-memory_hotplug-fix-a-typo-in-comment-recoreded-recorded.patch
* mm-ksm-fix-a-typo-in-comment-alreaady-already.patch
* mm-ksm-fix-a-typo-in-comment-alreaady-already-v2.patch
* mm-mmap-fix-a-typo-in-comment-compatbility-compatibility.patch
* mm-hugetlb-fix-a-typo-in-comment-manitained-maintained.patch
* mm-hugetlb-fix-a-typo-in-comment-manitained-maintained-v2.patch
* mm-hugetlb-fix-a-typo-in-comment-manitained-maintained-v2-checkpatch-fixes.patch
* mm-vmsan-fix-some-typos-in-comment.patch
* mm-compaction-fix-a-typo-in-comment-pessemistic-pessimistic.patch
* mm-memblock-fix-a-typo-in-comment-implict-implicit.patch
* mm-list_lru-fix-a-typo-in-comment-numbesr-numbers.patch
* mm-filemap-fix-a-typo-in-comment-unneccssary-unnecessary.patch
* mm-frontswap-fix-some-typos-in-frontswapc.patch
* mm-memcg-fix-some-typos-in-memcontrolc.patch
* mm-fix-a-typo-in-comment-strucure-structure.patch
* mm-slub-fix-a-typo-in-comment-disambiguiation-disambiguation.patch
* mm-sparse-fix-a-typo-in-comment-convienence-convenience.patch
* mm-page-writeback-fix-a-typo-in-comment-effictive-effective.patch
* mm-memory-fix-a-typo-in-comment-attampt-attempt.patch
* mm-use-false-for-bool-variable.patch
* mm-return-true-in-cpupid_pid_unset.patch
* zcomp-use-array_size-for-backends-list.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-rename-catch-function-argument.patch
* x86-mm-define-mm_p4d_folded.patch
* mm-debug-add-tests-validating-architecture-page-table-helpers.patch
* mm-debug-add-tests-validating-architecture-page-table-helpers-v17.patch
* mm-debug-add-tests-validating-architecture-page-table-helpers-v18.patch
* userc-make-uidhash_table-static.patch
* get_maintainer-add-email-addresses-from-yaml-files.patch
* get_maintainer-fix-unexpected-behavior-for-path-to-file-double-slashes.patch
* lib-math-avoid-trailing-n-hidden-in-pr_fmt.patch
* lib-add-might_fault-to-strncpy_from_user.patch
* lib-optimize-cpumask_local_spread.patch
* lib-test_lockupc-make-test_inode-static.patch
* lib-zlib-remove-outdated-and-incorrect-pre-increment-optimization.patch
* percpu_ref-use-a-more-common-logging-style.patch
* lib-flex_proportionsc-cleanup-__fprop_inc_percpu_max.patch
* lib-make-a-test-module-with-set-clear-bit.patch
* bitops-avoid-clang-shift-count-overflow-warnings.patch
* bitops-simplify-get_count_order_long.patch
* bitops-use-the-same-mechanism-for-get_count_order.patch
* lib-test-get_count_order-long-in-test_bitopsc.patch
* lib-test-get_count_order-long-in-test_bitopsc-fix.patch
* checkpatch-additional-maintainer-section-entry-ordering-checks.patch
* checkpatch-look-for-c99-comments-in-ctx_locate_comment.patch
* checkpatch-disallow-git-and-file-fix.patch
* checkpatch-use-patch-subject-when-reading-from-stdin.patch
* checkpatch-use-patch-subject-when-reading-from-stdin-fix.patch
* fs-binfmt_elf-remove-redundant-elf_map-ifndef.patch
* elfnote-mark-all-note-sections-shf_alloc.patch
* init-allow-distribution-configuration-of-default-init.patch
* fat-dont-allow-to-mount-if-the-fat-length-==-0.patch
* fat-improve-the-readahead-for-fat-entries.patch
* fs-seq_filec-seq_read-update-pr_info_ratelimited.patch
* seq_file-introduce-define_seq_attribute-helper-macro.patch
* seq_file-introduce-define_seq_attribute-helper-macro-checkpatch-fixes.patch
* mm-vmstat-convert-to-use-define_seq_attribute-macro.patch
* kernel-kprobes-convert-to-use-define_seq_attribute-macro.patch
* exec-simplify-the-copy_strings_kernel-calling-convention.patch
* exec-open-code-copy_string_kernel.patch
* exec-change-uselib2-is_sreg-failure-to-eacces.patch
* exec-relocate-s_isreg-check.patch
* exec-relocate-path_noexec-check.patch
* fs-include-fmode_exec-when-converting-flags-to-f_mode.patch
* umh-fix-refcount-underflow-in-fork_usermode_blob.patch
* rapidio-avoid-data-race-between-file-operation-callbacks-and-mport_cdev_add.patch
* rapidio-convert-get_user_pages-pin_user_pages.patch
* relay-handle-alloc_percpu-returning-null-in-relay_open.patch
* kernel-relayc-fix-read_pos-error-when-multiple-readers.patch
* aio-simplify-read_events.patch
* selftests-x86-pkeys-move-selftests-to-arch-neutral-directory.patch
* selftests-vm-pkeys-rename-all-references-to-pkru-to-a-generic-name.patch
* selftests-vm-pkeys-move-generic-definitions-to-header-file.patch
* selftests-vm-pkeys-move-some-definitions-to-arch-specific-header.patch
* selftests-vm-pkeys-make-gcc-check-arguments-of-sigsafe_printf.patch
* selftests-vm-pkeys-use-sane-types-for-pkey-register.patch
* selftests-vm-pkeys-add-helpers-for-pkey-bits.patch
* selftests-vm-pkeys-fix-pkey_disable_clear.patch
* selftests-vm-pkeys-fix-assertion-in-pkey_disable_set-clear.patch
* selftests-vm-pkeys-fix-alloc_random_pkey-to-make-it-really-random.patch
* selftests-vm-pkeys-use-the-correct-huge-page-size.patch
* selftests-vm-pkeys-introduce-generic-pkey-abstractions.patch
* selftests-vm-pkeys-introduce-powerpc-support.patch
* selftests-vm-pkeys-introduce-powerpc-support-fix.patch
* selftests-vm-pkeys-fix-number-of-reserved-powerpc-pkeys.patch
* selftests-vm-pkeys-fix-assertion-in-test_pkey_alloc_exhaust.patch
* selftests-vm-pkeys-improve-checks-to-determine-pkey-support.patch
* selftests-vm-pkeys-associate-key-on-a-mapped-page-and-detect-access-violation.patch
* selftests-vm-pkeys-associate-key-on-a-mapped-page-and-detect-write-violation.patch
* selftests-vm-pkeys-detect-write-violation-on-a-mapped-access-denied-key-page.patch
* selftests-vm-pkeys-introduce-a-sub-page-allocator.patch
* selftests-vm-pkeys-test-correct-behaviour-of-pkey-0.patch
* selftests-vm-pkeys-override-access-right-definitions-on-powerpc.patch
* selftests-vm-pkeys-override-access-right-definitions-on-powerpc-fix.patch
* selftests-vm-pkeys-use-the-correct-page-size-on-powerpc.patch
* selftests-vm-pkeys-fix-multilib-builds-for-x86.patch
* tools-testing-selftests-vm-remove-duplicate-headers.patch
* ubsan-fix-gcc-10-warnings.patch
* ipc-msg-add-missing-annotation-for-freeque.patch
* ipc-use-a-work-queue-to-free_ipc.patch
* ipc-convert-ipcs_idr-to-xarray.patch
* ipc-convert-ipcs_idr-to-xarray-update.patch
* ipc-convert-ipcs_idr-to-xarray-update-fix.patch
* linux-next-pre.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
* linux-next-post.patch
* dynamic_debug-add-an-option-to-enable-dynamic-debug-for-modules-only.patch
* dynamic_debug-add-an-option-to-enable-dynamic-debug-for-modules-only-v2.patch
* kernel-add-panic_on_taint.patch
* kernel-add-panic_on_taint-fix.patch
* xarrayh-correct-return-code-for-xa_store_bhirq.patch
* kernel-sysctl-support-setting-sysctl-parameters-from-kernel-command-line.patch
* kernel-sysctl-support-handling-command-line-aliases.patch
* kernel-hung_task-convert-hung_task_panic-boot-parameter-to-sysctl.patch
* tools-testing-selftests-sysctl-sysctlsh-support-config_test_sysctl=y.patch
* lib-test_sysctl-support-testing-of-sysctl-boot-parameter.patch
* lib-test_sysctl-support-testing-of-sysctl-boot-parameter-fix.patch
* kernel-watchdogc-convert-soft-hardlockup-boot-parameters-to-sysctl-aliases.patch
* kernel-hung_taskc-introduce-sysctl-to-print-all-traces-when-a-hung-task-is-detected.patch
* panic-add-sysctl-to-dump-all-cpus-backtraces-on-oops-event.patch
* kernel-sysctl-ignore-out-of-range-taint-bits-introduced-via-kerneltainted.patch
* stacktrace-cleanup-inconsistent-variable-type.patch
* amdgpu-a-null-mm-does-not-mean-a-thread-is-a-kthread.patch
* kernel-move-use_mm-unuse_mm-to-kthreadc.patch
* kernel-move-use_mm-unuse_mm-to-kthreadc-v2.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract-v2.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract-v2-fix.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract-fix-2.patch
* kernel-set-user_ds-in-kthread_use_mm.patch
* mm-kmemleak-silence-kcsan-splats-in-checksum.patch
* kallsyms-printk-add-loglvl-to-print_ip_sym.patch
* alpha-add-show_stack_loglvl.patch
* arc-add-show_stack_loglvl.patch
* arm-asm-add-loglvl-to-c_backtrace.patch
* arm-add-loglvl-to-unwind_backtrace.patch
* arm-add-loglvl-to-dump_backtrace.patch
* arm-wire-up-dump_backtrace_entrystm.patch
* arm-add-show_stack_loglvl.patch
* arm64-add-loglvl-to-dump_backtrace.patch
* arm64-add-show_stack_loglvl.patch
* c6x-add-show_stack_loglvl.patch
* csky-add-show_stack_loglvl.patch
* h8300-add-show_stack_loglvl.patch
* hexagon-add-show_stack_loglvl.patch
* ia64-pass-log-level-as-arg-into-ia64_do_show_stack.patch
* ia64-add-show_stack_loglvl.patch
* m68k-add-show_stack_loglvl.patch
* microblaze-add-loglvl-to-microblaze_unwind_inner.patch
* microblaze-add-loglvl-to-microblaze_unwind.patch
* microblaze-add-show_stack_loglvl.patch
* mips-add-show_stack_loglvl.patch
* nds32-add-show_stack_loglvl.patch
* nios2-add-show_stack_loglvl.patch
* openrisc-add-show_stack_loglvl.patch
* parisc-add-show_stack_loglvl.patch
* powerpc-add-show_stack_loglvl.patch
* riscv-add-show_stack_loglvl.patch
* s390-add-show_stack_loglvl.patch
* sh-add-loglvl-to-dump_mem.patch
* sh-remove-needless-printk.patch
* sh-add-loglvl-to-printk_address.patch
* sh-add-loglvl-to-show_trace.patch
* sh-add-show_stack_loglvl.patch
* sparc-add-show_stack_loglvl.patch
* um-sysrq-remove-needless-variable-sp.patch
* um-add-show_stack_loglvl.patch
* unicore32-remove-unused-pmode-argument-in-c_backtrace.patch
* unicore32-add-loglvl-to-c_backtrace.patch
* unicore32-add-show_stack_loglvl.patch
* x86-add-missing-const-qualifiers-for-log_lvl.patch
* x86-add-show_stack_loglvl.patch
* xtensa-add-loglvl-to-show_trace.patch
* xtensa-add-loglvl-to-show_trace-fix.patch
* xtensa-add-show_stack_loglvl.patch
* sysrq-use-show_stack_loglvl.patch
* x86-amd_gart-print-stacktrace-for-a-leak-with-kern_err.patch
* power-use-show_stack_loglvl.patch
* kdb-dont-play-with-console_loglevel.patch
* sched-print-stack-trace-with-kern_info.patch
* kernel-use-show_stack_loglvl.patch
* kernel-rename-show_stack_loglvl-=-show_stack.patch
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
* mm-util-annotate-an-data-race-at-vm_committed_as.patch
* mm-rmap-annotate-a-data-race-at-tlb_flush_batched.patch
* mm-annotate-a-data-race-in-page_zonenum.patch
* mm-swap-annotate-data-races-for-lru_rotate_pvecs.patch
* mm-gupc-convert-to-use-get_user_pagepages_fast_only.patch
* mm-gup-update-pin_user_pagesrst-for-case-3-mmu-notifiers.patch
* mm-gup-introduce-pin_user_pages_locked.patch
* mm-gup-introduce-pin_user_pages_locked-v2.patch
* mm-gup-frame_vector-convert-get_user_pages-pin_user_pages.patch
* mm-gup-documentation-fix-for-pin_user_pages-apis.patch
* docs-mm-gup-pin_user_pagesrst-add-a-case-5.patch
* vhost-convert-get_user_pages-pin_user_pages.patch
* h8300-remove-usage-of-__arch_use_5level_hack.patch
* arm-add-support-for-folded-p4d-page-tables.patch
* arm-add-support-for-folded-p4d-page-tables-fix.patch
* arm64-add-support-for-folded-p4d-page-tables.patch
* arm64-add-support-for-folded-p4d-page-tables-fix.patch
* hexagon-remove-__arch_use_5level_hack.patch
* ia64-add-support-for-folded-p4d-page-tables.patch
* nios2-add-support-for-folded-p4d-page-tables.patch
* openrisc-add-support-for-folded-p4d-page-tables.patch
* powerpc-add-support-for-folded-p4d-page-tables.patch
* powerpc-add-support-for-folded-p4d-page-tables-fix-2.patch
* sh-fault-modernize-printing-of-kernel-messages.patch
* sh-drop-__pxd_offset-macros-that-duplicate-pxd_index-ones.patch
* sh-add-support-for-folded-p4d-page-tables.patch
* unicore32-remove-__arch_use_5level_hack.patch
* asm-generic-remove-pgtable-nop4d-hackh.patch
* mm-remove-__arch_has_5level_hack-and-include-asm-generic-5level-fixuph.patch
* net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy.patch
* mm-mmapc-add-more-sanity-checks-to-get_unmapped_area.patch
* mm-mmapc-do-not-allow-mappings-outside-of-allowed-limits.patch
* mm-dont-include-asm-pgtableh-if-linux-mmh-is-already-included.patch
* mm-introduce-include-linux-pgtableh.patch
* mm-reorder-includes-after-introduction-of-linux-pgtableh.patch
* csky-replace-definitions-of-__pxd_offset-with-pxd_index.patch
* m68k-mm-motorola-move-comment-about-page-table-allocation-funcitons.patch
* m68k-mm-move-cachenocahe_page-definitions-close-to-their-user.patch
* x86-mm-simplify-init_trampoline-and-surrounding-logic.patch
* x86-mm-simplify-init_trampoline-and-surrounding-logic-fix.patch
* mm-pgtable-add-shortcuts-for-accessing-kernel-pmd-and-pte.patch
* mm-pgtable-add-shortcuts-for-accessing-kernel-pmd-and-pte-fix.patch
* mm-consolidate-pte_index-and-pte_offset_-definitions.patch
* mm-consolidate-pmd_index-and-pmd_offset-definitions.patch
* mm-consolidate-pud_index-and-pud_offset-definitions.patch
* mm-consolidate-pgd_index-and-pgd_offset_k-definitions.patch
* mm-consolidate-pgd_index-and-pgd_offset_k-definitions-fix.patch
* arm-fix-the-flush_icache_range-arguments-in-set_fiq_handler.patch
* nds32-unexport-flush_icache_page.patch
* powerpc-unexport-flush_icache_user_range.patch
* unicore32-remove-flush_cache_user_range.patch
* asm-generic-fix-the-inclusion-guards-for-cacheflushh.patch
* asm-generic-dont-include-linux-mmh-in-cacheflushh.patch
* asm-generic-dont-include-linux-mmh-in-cacheflushh-fix.patch
* asm-generic-improve-the-flush_dcache_page-stub.patch
* alpha-use-asm-generic-cacheflushh.patch
* arm64-use-asm-generic-cacheflushh.patch
* c6x-use-asm-generic-cacheflushh.patch
* hexagon-use-asm-generic-cacheflushh.patch
* ia64-use-asm-generic-cacheflushh.patch
* microblaze-use-asm-generic-cacheflushh.patch
* m68knommu-use-asm-generic-cacheflushh.patch
* openrisc-use-asm-generic-cacheflushh.patch
* powerpc-use-asm-generic-cacheflushh.patch
* riscv-use-asm-generic-cacheflushh.patch
* armsparcunicore32-remove-flush_icache_user_range.patch
* mm-rename-flush_icache_user_range-to-flush_icache_user_page.patch
* asm-generic-add-a-flush_icache_user_range-stub.patch
* sh-implement-flush_icache_user_range.patch
* xtensa-implement-flush_icache_user_range.patch
* xtensa-implement-flush_icache_user_range-fix.patch
* arm-rename-flush_cache_user_range-to-flush_icache_user_range.patch
* m68k-implement-flush_icache_user_range.patch
* exec-only-build-read_code-when-needed.patch
* exec-use-flush_icache_user_range-in-read_code.patch
* binfmt_flat-use-flush_icache_user_range.patch
* nommu-use-flush_icache_user_range-in-brk-and-mmap.patch
* module-move-the-set_fs-hack-for-flush_icache_range-to-m68k.patch
* mmap-locking-api-initial-implementation-as-rwsem-wrappers.patch
* mmu-notifier-use-the-new-mmap-locking-api.patch
* dma-reservations-use-the-new-mmap-locking-api.patch
* mmap-locking-api-use-coccinelle-to-convert-mmap_sem-rwsem-call-sites.patch
* mmap-locking-api-convert-mmap_sem-call-sites-missed-by-coccinelle.patch
* mmap-locking-api-convert-mmap_sem-call-sites-missed-by-coccinelle-fix.patch
* mmap-locking-api-convert-mmap_sem-call-sites-missed-by-coccinelle-fix-fix.patch
* mmap-locking-api-convert-mmap_sem-call-sites-missed-by-coccinelle-fix-fix-fix.patch
* mmap-locking-api-convert-nested-write-lock-sites.patch
* mmap-locking-api-add-mmap_read_trylock_non_owner.patch
* mmap-locking-api-add-mmap_lock_initializer.patch
* mmap-locking-api-add-mmap_assert_locked-and-mmap_assert_write_locked.patch
* mmap-locking-api-rename-mmap_sem-to-mmap_lock.patch
* mmap-locking-api-rename-mmap_sem-to-mmap_lock-fix.patch
* mmap-locking-api-convert-mmap_sem-api-comments.patch
* mmap-locking-api-convert-mmap_sem-comments.patch
* mmap-locking-api-convert-mmap_sem-comments-fix.patch
* mmap-locking-api-convert-mmap_sem-comments-fix-fix.patch
* mmap-locking-api-convert-mmap_sem-comments-fix-fix-fix.patch
* mm-pass-task-and-mm-to-do_madvise.patch
* mm-introduce-external-memory-hinting-api.patch
* mm-introduce-external-memory-hinting-api-fix.patch
* mm-introduce-external-memory-hinting-api-fix-2.patch
* mm-introduce-external-memory-hinting-api-fix-2-fix.patch
* mm-check-fatal-signal-pending-of-target-process.patch
* pid-move-pidfd_get_pid-function-to-pidc.patch
* mm-support-both-pid-and-pidfd-for-process_madvise.patch
* mm-madvise-allow-ksm-hints-for-remote-api.patch
* mm-support-vector-address-ranges-for-process_madvise.patch
* mm-support-vector-address-ranges-for-process_madvise-fix.patch
* mm-support-vector-address-ranges-for-process_madvise-fix-fix.patch
* mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix.patch
* mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix-fix.patch
* mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix-fix-fix.patch
* mm-use-only-pidfd-for-process_madvise-syscall.patch
* mm-use-only-pidfd-for-process_madvise-syscall-fix.patch
* mm-remove-duplicated-include-from-madvisec.patch
* maccess-unexport-probe_kernel_write-and-probe_user_write.patch
* maccess-unexport-probe_kernel_write-and-probe_user_write-fix.patch
* maccess-remove-various-unused-weak-aliases.patch
* maccess-remove-duplicate-kerneldoc-comments.patch
* maccess-clarify-kerneldoc-comments.patch
* maccess-update-the-top-of-file-comment.patch
* maccess-rename-strncpy_from_unsafe_user-to-strncpy_from_user_nofault.patch
* maccess-rename-strncpy_from_unsafe_strict-to-strncpy_from_kernel_nofault.patch
* maccess-rename-strnlen_unsafe_user-to-strnlen_user_nofault.patch
* maccess-remove-probe_read_common-and-probe_write_common.patch
* maccess-unify-the-probe-kernel-arch-hooks.patch
* maccess-unify-the-probe-kernel-arch-hooks-fix.patch
* bpf-factor-out-a-bpf_trace_copy_string-helper.patch
* bpf-handle-the-compat-string-in-bpf_trace_copy_string-better.patch
* bpf-bpf_seq_printf-handle-potentially-unsafe-format-string-better.patch
* bpf-rework-the-compat-kernel-probe-handling.patch
* tracing-kprobes-handle-mixed-kernel-userspace-probes-better.patch
* maccess-remove-strncpy_from_unsafe.patch
* maccess-always-use-strict-semantics-for-probe_kernel_read.patch
* maccess-always-use-strict-semantics-for-probe_kernel_read-fix.patch
* maccess-move-user-access-routines-together.patch
* maccess-allow-architectures-to-provide-kernel-probing-directly.patch
* x86-use-non-set_fs-based-maccess-routines.patch
* x86-use-non-set_fs-based-maccess-routines-checkpatch-fixes.patch
* maccess-return-erange-when-copy_from_kernel_nofault_allowed-fails.patch
* mm-expand-documentation-over-__read_mostly.patch
* doc-cgroup-update-note-about-conditions-when-oom-killer-is-invoked.patch
* doc-cgroup-update-note-about-conditions-when-oom-killer-is-invoked-fix.patch
* sh-sh4a-bring-back-tmu3_device-early-device.patch
* arch-sh-vmlinuxscr-align-rodata.patch
* include-asm-generic-vmlinuxldsh-align-ro_after_init.patch
* sh-clkfwk-remove-r8-r16-r32.patch
* sh-remove-call-to-memset-after-dma_alloc_coherent.patch
* sh-use-generic-strncpy.patch
* sh-convert-ins-outs-macros-to-inline-functions.patch
* sh-convert-ins-outs-macros-to-inline-functions-checkpatch-fixes.patch
* sh-convert-iounmap-macros-to-inline-functions.patch
* sh-add-missing-export_symbol-for-__delay.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
