Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCEE2B14F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 05:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKMEC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 23:02:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgKMEC3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 23:02:29 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0583522241;
        Fri, 13 Nov 2020 04:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605240147;
        bh=Nz5krnqxwt6R0yHEtImCY6JbxB0TUDxSUVRCf/ilZHY=;
        h=Date:From:To:Subject:From;
        b=OgqOEEJ5KKZ0CQ7uJZsnShK5GDYqvKkdSa+oFb4dBlIDtFa/vQzeFqiKlKA1I863M
         gb+j4rK5T3+4Tj/VAj17n1TrKAsoHezwOPVgFzoN8q6p7KbFDlTPeM10udILDCG3qB
         YtV43QBhpigydiXMG6smiduqfGRGnA1zMgLKs+YA=
Date:   Thu, 12 Nov 2020 20:02:26 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-11-12-20-01 uploaded
Message-ID: <20201113040226.fZi_OALm7%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-11-12-20-01 has been uploaded to

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



This mmotm tree contains the following patches against 5.10-rc3:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-compaction-count-pages-and-stop-correctly-during-page-isolation.patch
* mm-compaction-stop-isolation-if-too-many-pages-are-isolated-and-we-have-pages-to-migrate.patch
* mm-vmscan-fix-nr_isolated_file-corruption-on-64-bit.patch
* mailmap-fix-entry-for-dmitry-baryshkov-eremin-solenikov.patch
* mm-slub-fix-panic-in-slab_alloc_node.patch
* mm-gup-use-unpin_user_pages-in-__gup_longterm_locked.patch
* compilerh-fix-barrier_data-on-clang.patch
* compilerh-fix-barrier_data-on-clang-fix.patch
* revert-kernel-rebootc-convert-simple_strtoul-to-kstrtoint.patch
* reboot-fix-overflow-parsing-reboot-cpu-number.patch
* kernel-watchdog-fix-watchdog_allowed_mask-not-used-warning.patch
* mm-memcontrol-fix-missing-wakeup-polling-thread.patch
* hugetlbfs-fix-anon-huge-page-migration-race.patch
* panic-dont-dump-stack-twice-on-warn.patch
* mm-fix-phys_to_target_node-and-memory_add_physaddr_to_nid-exports.patch
* mm-fix-phys_to_target_node-and-memory_add_physaddr_to_nid-exports-v4.patch
* mm-fix-readahead_page_batch-for-retry-entries.patch
* mm-filemap-add-static-for-function-__add_to_page_cache_locked.patch
* mm-memcg-slab-fix-root-memcg-vmstats.patch
* mm-userfaultfd-do-not-access-vma-vm_mm-after-calling-handle_userfault.patch
* libfs-fix-error-cast-of-negative-value-in-simple_attr_write.patch
* ocfs2-initialize-ip_next_orphan.patch
* mm-fix-madvise-willneed-performance-problem.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* kthread-add-kthread_work-tracepoints.patch
* kthread_worker-document-cpu-hotplug-handling.patch
* kthread_worker-document-cpu-hotplug-handling-fix.patch
* uapi-move-constants-from-linux-kernelh-to-linux-consth.patch
* fs-ntfs-remove-unused-varibles.patch
* fs-ntfs-remove-unused-varible-attr_len.patch
* fs-ocfs2-remove-unneeded-break.patch
* ocfs2-ratelimit-the-max-lookup-times-reached-notice.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mmslab_common-use-list_for_each_entry-in-dump_unreclaimable_slab.patch
* mm-slab-clarify-kreallocs-behavior-with-__gfp_zero.patch
* mm-slab-provide-krealloc_array.patch
* alsa-pcm-use-krealloc_array.patch
* vhost-vringh-use-krealloc_array.patch
* pinctrl-use-krealloc_array.patch
* edac-ghes-use-krealloc_array.patch
* drm-atomic-use-krealloc_array.patch
* hwtracing-intel-use-krealloc_array.patch
* dma-buf-use-krealloc_array.patch
* mm-slub-use-kmem_cache_debug_flags-in-deactivate_slab.patch
* device-dax-kmem-use-struct_size.patch
* mm-fix-page_owner-initializing-issue-for-arm32.patch
* fs-break-generic_file_buffered_read-up-into-multiple-functions.patch
* fs-generic_file_buffered_read-now-uses-find_get_pages_contig.patch
* mm-msync-exit-early-when-the-flags-is-an-ms_async-and-start-vm_start.patch
* mm-gup_benchmark-rename-to-mm-gup_test.patch
* selftests-vm-use-a-common-gup_testh.patch
* selftests-vm-rename-run_vmtests-run_vmtestssh.patch
* selftests-vm-minor-cleanup-makefile-and-gup_testc.patch
* selftests-vm-only-some-gup_test-items-are-really-benchmarks.patch
* selftests-vm-gup_test-introduce-the-dump_pages-sub-test.patch
* selftests-vm-run_vmtestssh-update-and-clean-up-gup_test-invocation.patch
* selftests-vm-hmm-tests-remove-the-libhugetlbfs-dependency.patch
* selftests-vm-2x-speedup-for-run_vmtestssh.patch
* mm-gup_benchmark-mark-gup_benchmark_init-as-__init-function.patch
* mm-gup_benchmark-gup_benchmark-depends-on-debug_fs.patch
* mm-gup_benchmark-gup_benchmark-depends-on-debug_fs-v2.patch
* mm-reorganize-internal_get_user_pages_fast.patch
* mm-prevent-gup_fast-from-racing-with-cow-during-fork.patch
* mm-prevent-gup_fast-from-racing-with-cow-during-fork-checkpatch-fixes.patch
* mm-handle-zone-device-pages-in-release_pages.patch
* mm-swapfilec-use-helper-function-swap_count-in-add_swap_count_continuation.patch
* mm-swap_state-skip-meaningless-swap-cache-readahead-when-ra_infowin-==-0.patch
* mm-swap_state-skip-meaningless-swap-cache-readahead-when-ra_infowin-==-0-fix.patch
* mm-swapfilec-remove-unnecessary-out-label-in-__swap_duplicate.patch
* mm-swap-use-memset-to-fill-the-swap_map-with-swap_has_cache.patch
* mm-remove-pagevec_lookup_range_nr_tag.patch
* mmthpshmem-limit-shmem-thp-alloc-gfp_mask.patch
* mmthpshm-limit-gfp-mask-to-no-more-than-specified.patch
* mm-memcontrol-add-file_thp-shmem_thp-to-memorystat.patch
* mm-memcontrol-add-file_thp-shmem_thp-to-memorystat-fix.patch
* mm-memcontrol-remove-unused-mod_memcg_obj_state.patch
* mm-memcontrol-eliminate-redundant-check-in-__mem_cgroup_insert_exceeded.patch
* mm-memcontrol-use-helpers-to-read-pages-memcg-data.patch
* mm-memcontrol-slab-use-helpers-to-access-slab-pages-memcg_data.patch
* mm-introduce-page-memcg-flags.patch
* mm-convert-page-kmemcg-type-to-a-page-memcg-flag.patch
* mm-memcg-slab-fix-return-child-memcg-objcg-for-root-memcg.patch
* mm-memcg-slab-fix-use-after-free-in-obj_cgroup_charge.patch
* mm-memcg-bail-early-from-swap-accounting-if-memcg-disabled.patch
* mm-memcg-warning-on-memcg-after-readahead-page-charged.patch
* mm-rmap-always-do-ttu_ignore_access.patch
* mm-kvm-account-kvm_vcpu_mmap-to-kmemcg.patch
* mm-memcg-remove-unused-definitions.patch
* mm-memcg-update-page-struct-member-in-comments.patch
* mm-memcg-fix-obsolete-code-comments.patch
* mm-slub-call-account_slab_page-after-slab-page-initialization.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account-v2.patch
* mm-memcontrol-rewrite-mem_cgroup_page_lruvec.patch
* mm-memcg-deprecate-the-non-hierarchical-mode.patch
* docs-cgroup-v1-reflect-the-deprecation-of-the-non-hierarchical-mode.patch
* cgroup-remove-obsoleted-broken_hierarchy-and-warned_broken_hierarchy.patch
* xen-unpopulated-alloc-consolidate-pgmap-manipulation.patch
* kselftests-vm-add-mremap-tests.patch
* mm-speedup-mremap-on-1gb-or-larger-regions.patch
* arm64-mremap-speedup-enable-have_move_pud.patch
* x86-mremap-speedup-enable-have_move_pud.patch
* mm-cleanup-remove-unused-tsk-arg-from-__access_remote_vm.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-mremap-account-memory-on-do_munmap-failure.patch
* mm-mremap-for-mremap_dontunmap-check-security_vm_enough_memory_mm.patch
* mremap-dont-allow-mremap_dontunmap-on-special_mappings-and-aio.patch
* vm_ops-rename-split-callback-to-may_split.patch
* mremap-check-if-its-possible-to-split-original-vma.patch
* mm-forbid-splitting-special-mappings.patch
* mmhwpoison-drain-pcplists-before-bailing-out-for-non-buddy-zero-refcount-page.patch
* mmhwpoison-take-free-pages-off-the-buddy-freelists.patch
* mmhwpoison-take-free-pages-off-the-buddy-freelists-for-hugetlb.patch
* mmhwpoison-drop-unneeded-pcplist-draining.patch
* mm-vmallocc-__vmalloc_area_node-avoid-32-bit-overflow.patch
* mm-vmalloc-fix-kasan-shadow-poisoning-size.patch
* alpha-switch-from-discontigmem-to-sparsemem.patch
* ia64-remove-custom-__early_pfn_to_nid.patch
* ia64-remove-ifdef-config_zone_dma32-statements.patch
* ia64-discontig-paging_init-remove-local-max_pfn-calculation.patch
* ia64-split-virtual-map-initialization-out-of-paging_init.patch
* ia64-forbid-using-virtual_mem_map-with-flatmem.patch
* ia64-make-sparsemem-default-and-disable-discontigmem.patch
* arm-remove-config_arch_has_holes_memorymodel.patch
* arm-arm64-move-free_unused_memmap-to-generic-mm.patch
* arc-use-flatmem-with-freeing-of-unused-memory-map-instead-of-discontigmem.patch
* m68k-mm-make-node-data-and-node-setup-depend-on-config_discontigmem.patch
* m68k-mm-enable-use-of-generic-memory_modelh-for-discontigmem.patch
* m68k-deprecate-discontigmem.patch
* mm-introduce-debug_pagealloc_mapunmap_pages-helpers.patch
* pm-hibernate-make-direct-map-manipulations-more-explicit.patch
* arch-mm-restore-dependency-of-__kernel_map_pages-on-debug_pagealloc.patch
* arch-mm-make-kernel_page_present-always-available.patch
* mm-page_alloc-clean-up-pageset-high-and-batch-update.patch
* mm-page_alloc-calculate-pageset-high-and-batch-once-per-zone.patch
* mm-page_alloc-remove-setup_pageset.patch
* mm-page_alloc-simplify-pageset_update.patch
* mm-page_alloc-cache-pageset-high-and-batch-in-struct-zone.patch
* mm-page_alloc-move-draining-pcplists-to-page-isolation-users.patch
* mm-page_alloc-disable-pcplists-during-memory-offline.patch
* mm-page_alloc-disable-pcplists-during-memory-offline-fix.patch
* mm-page_alloc-clear-pages-in-alloc_contig_pages-with-init_on_alloc=1-or-__gfp_zero.patch
* page-flags-remove-unused-__pageprivate.patch
* mm-page-flags-fix-comment.patch
* mm-page_alloc-add-__free_pages-documentation.patch
* mm-hugetlbc-just-use-put_page_testzero-instead-of-page_count.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* include-linux-huge_mmh-remove-extern-keyword.patch
* mm-dont-wake-kswapd-prematurely-when-watermark-boosting-is-disabled.patch
* mm-vmscan-drop-unneeded-assignment-in-kswapd.patch
* mm-compaction-rename-start_pfn-to-iteration_start_pfn-in-compact_zone.patch
* mm-oom_kill-change-comment-and-rename-is_dump_unreclaim_slabs.patch
* mm-migrate-fix-comment-spelling.patch
* mm-optimize-migrate_vma_pages-mmu-notifier.patch
* mm-cmac-remove-redundant-cma_mutex-lock.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
* mm-zswap-make-struct-kernel_param_ops-definitions-const.patch
* mm-zswap-fix-passing-zero-to-ptr_err-warning.patch
* mm-zswap-move-to-use-crypto_acomp-api-for-hardware-acceleration.patch
* zsmalloc-rework-the-list_add-code-in-insert_zspage.patch
* mm-process_vm_access-remove-redundant-initialization-of-iov_r.patch
* zram-support-a-page-writeback.patch
* mm-add-kernel-electric-fence-infrastructure.patch
* mm-add-kernel-electric-fence-infrastructure-fix.patch
* mm-add-kernel-electric-fence-infrastructure-fix-2.patch
* x86-kfence-enable-kfence-for-x86.patch
* arm64-kfence-enable-kfence-for-arm64.patch
* kfence-use-pt_regs-to-generate-stack-trace-on-faults.patch
* mm-kfence-insert-kfence-hooks-for-slab.patch
* mm-kfence-insert-kfence-hooks-for-slub.patch
* kfence-kasan-make-kfence-compatible-with-kasan.patch
* kfence-documentation-add-kfence-documentation.patch
* kfence-add-test-suite.patch
* maintainers-add-entry-for-kfence.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* procfs-delete-duplicated-words-other-fixes.patch
* proc-provide-details-on-indirect-branch-speculation.patch
* proc-provide-details-on-indirect-branch-speculation-v2.patch
* proc-sysctl-make-protected_-world-readable.patch
* asm-generic-force-inlining-of-get_order-to-work-around-gcc10-poor-decision.patch
* kernelh-split-out-mathematical-helpers.patch
* kernelh-split-out-mathematical-helpers-fix.patch
* acctc-use-elif-instead-of-end-and-elif.patch
* reboot-refactor-and-comment-the-cpu-selection-code.patch
* bitmap-convert-bitmap_empty-bitmap_full-to-return-boolean.patch
* lib-stackdepot-add-support-to-configure-stack_hash_size.patch
* lib-test_free_pages-add-basic-progress-indicators.patch
* lib-stackdepotc-replace-one-element-array-with-flexible-array-member.patch
* lib-stackdepotc-use-flex_array_size-helper-in-memcpy.patch
* lib-stackdepotc-use-array_size-helper-in-jhash2.patch
* lib-test_lockup-minimum-fix-to-get-it-compiled-on-preempt_rt.patch
* lib-list_kunit-follow-new-file-name-convention-for-kunit-tests.patch
* lib-linear_ranges_kunit-follow-new-file-name-convention-for-kunit-tests.patch
* lib-bits_kunit-follow-new-file-name-convention-for-kunit-tests.patch
* lib-cmdline-fix-get_option-for-strings-starting-with-hyphen.patch
* lib-cmdline-allow-null-to-be-an-output-for-get_option.patch
* lib-cmdline_kunit-add-a-new-test-suite-for-cmdline-api.patch
* lib-cmdline_kunit-add-a-new-test-suite-for-cmdline-api-fix.patch
* lib-optimize-cpumask_local_spread.patch
* bitops-introduce-the-for_each_set_clump-macro.patch
* lib-test_bitmapc-add-for_each_set_clump-test-cases.patch
* lib-test_bitmapc-add-for_each_set_clump-test-cases-checkpatch-fixes.patch
* gpio-thunderx-utilize-for_each_set_clump-macro.patch
* gpio-xilinx-utilize-generic-bitmap_get_value-and-_set_value.patch
* checkpatch-add-new-exception-to-repeated-word-check.patch
* checkpatch-fix-false-positives-in-repeated_word-warning.patch
* checkpatch-ignore-generated-camelcase-defines-and-enum-values.patch
* checkpatch-prefer-static-const-declarations.patch
* checkpatch-allow-fix-removal-of-unnecessary-break-statements.patch
* checkpatch-extend-attributes-check-to-handle-more-patterns.patch
* checkpatch-add-a-fixer-for-missing-newline-at-eof.patch
* checkpatch-update-__attribute__sectionname-quote-removal.patch
* checkpatch-update-__attribute__sectionname-quote-removal-v2.patch
* checkpatch-add-fix-option-for-gerrit_change_id.patch
* checkpatch-add-__alias-and-__weak-to-suggested-__attribute__-conversions.patch
* checkpatch-improve-email-parsing.patch
* reiserfs-add-check-for-an-invalid-ih_entry_count.patch
* kdump-append-uts_namespacename-offset-to-vmcoreinfo.patch
* gcov-remove-support-for-gcc-49.patch
* aio-simplify-read_events.patch
* reboot-allow-to-specify-reboot-mode-via-sysfs.patch
* reboot-fix-variable-assignments-in-type_store.patch
* fault-injection-handle-ei_etype_true.patch
* lib-lzo-make-lzogeneric1x_1_compress-static.patch
  linux-next.patch
  linux-next-rejects.patch
* treewide-remove-stringification-from-__alias-macro-definition.patch
* treewide-remove-stringification-from-__alias-macro-definition-fix.patch
* compiler-clang-remove-version-check-for-bpf-tracing.patch
* epoll-check-for-events-when-removing-a-timed-out-thread-from-the-wait-queue.patch
* epoll-simplify-signal-handling.patch
* epoll-pull-fatal-signal-checks-into-ep_send_events.patch
* epoll-move-eavail-next-to-the-list_empty_careful-check.patch
* epoll-simplify-and-optimize-busy-loop-logic.patch
* epoll-pull-all-code-between-fetch_events-and-send_event-into-the-loop.patch
* epoll-replace-gotos-with-a-proper-loop.patch
* epoll-eliminate-unnecessary-lock-for-zero-timeout.patch
* mm-unexport-follow_pte_pmd.patch
* mm-simplify-follow_ptepmd.patch
* mm-simplify-follow_ptepmd-fix.patch
* kasan-drop-unnecessary-gpl-text-from-comment-headers.patch
* kasan-kasan_vmalloc-depends-on-kasan_generic.patch
* kasan-group-vmalloc-code.patch
* s390-kasan-include-asm-pageh-from-asm-kasanh.patch
* kasan-shadow-declarations-only-for-software-modes.patch
* kasan-rename-unpoison_shadow-to-unpoison_memory.patch
* kasan-rename-kasan_shadow_-to-kasan_granule_.patch
* kasan-only-build-initc-for-software-modes.patch
* kasan-split-out-shadowc-from-commonc.patch
* kasan-split-out-shadowc-from-commonc-fix.patch
* kasan-split-out-shadowc-from-commonc-fix2.patch
* kasan-define-kasan_granule_page.patch
* kasan-rename-report-and-tags-files.patch
* kasan-dont-duplicate-config-dependencies.patch
* kasan-hide-invalid-free-check-implementation.patch
* kasan-decode-stack-frame-only-with-kasan_stack_enable.patch
* kasan-arm64-only-init-shadow-for-software-modes.patch
* kasan-arm64-only-use-kasan_depth-for-software-modes.patch
* kasan-arm64-move-initialization-message.patch
* kasan-arm64-rename-kasan_init_tags-and-mark-as-__init.patch
* kasan-rename-addr_has_shadow-to-addr_has_metadata.patch
* kasan-rename-print_shadow_for_address-to-print_memory_metadata.patch
* kasan-kasan_non_canonical_hook-only-for-software-modes.patch
* kasan-rename-shadow-layout-macros-to-meta.patch
* kasan-separate-metadata_fetch_row-for-each-mode.patch
* kasan-arm64-dont-allow-sw_tags-with-arm64_mte.patch
* kasan-introduce-config_kasan_hw_tags.patch
* arm64-enable-armv85-a-asm-arch-option.patch
* arm64-mte-add-in-kernel-mte-helpers.patch
* arm64-mte-reset-the-page-tag-in-page-flags.patch
* arm64-mte-add-in-kernel-tag-fault-handler.patch
* arm64-kasan-allow-enabling-in-kernel-mte.patch
* arm64-mte-convert-gcr_user-into-an-exclude-mask.patch
* arm64-mte-switch-gcr_el1-in-kernel-entry-and-exit.patch
* kasan-mm-untag-page-address-in-free_reserved_area.patch
* arm64-kasan-align-allocations-for-hw_tags.patch
* arm64-kasan-add-arch-layer-for-memory-tagging-helpers.patch
* kasan-define-kasan_granule_size-for-hw_tags.patch
* kasan-x86-s390-update-undef-config_kasan.patch
* kasan-arm64-expand-config_kasan-checks.patch
* kasan-arm64-implement-hw_tags-runtime.patch
* kasan-arm64-print-report-from-tag-fault-handler.patch
* kasan-mm-reset-tags-when-accessing-metadata.patch
* kasan-arm64-enable-config_kasan_hw_tags.patch
* kasan-add-documentation-for-hardware-tag-based-mode.patch
* kselftest-arm64-check-gcr_el1-after-context-switch.patch
* kasan-simplify-quarantine_put-call-site.patch
* kasan-rename-get_alloc-free_info.patch
* kasan-introduce-set_alloc_info.patch
* kasan-arm64-unpoison-stack-only-with-config_kasan_stack.patch
* kasan-allow-vmap_stack-for-hw_tags-mode.patch
* kasan-remove-__kasan_unpoison_stack.patch
* kasan-inline-kasan_reset_tag-for-tag-based-modes.patch
* kasan-inline-random_tag-for-hw_tags.patch
* kasan-inline-kasan_poison_memory-and-check_invalid_free.patch
* kasan-inline-and-rename-kasan_unpoison_memory.patch
* kasan-add-and-integrate-kasan-boot-parameters.patch
* kasan-mm-check-kasan_enabled-in-annotations.patch
* kasan-mm-check-kasan_enabled-in-annotations-fix.patch
* kasan-simplify-kasan_poison_kfree.patch
* kasan-simplify-kasan_poison_kfree-temp-fix.patch
* kasan-mm-rename-kasan_poison_kfree.patch
* kasan-mm-rename-kasan_poison_kfree-temp-fix.patch
* kasan-dont-round_up-too-much.patch
* kasan-simplify-assign_tag-and-set_tag-calls.patch
* kasan-clarify-comment-in-__kasan_kfree_large.patch
* kasan-clean-up-metadata-allocation-and-usage.patch
* kasan-mm-allow-cache-merging-with-no-metadata.patch
* kasan-update-documentation.patch
* mm-add-definition-of-pmd_page_order.patch
* mmap-make-mlock_future_check-global.patch
* set_memory-allow-set_direct_map__noflush-for-multiple-pages.patch
* set_memory-allow-set_direct_map__noflush-for-multiple-pages-fix.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas.patch
* secretmem-use-pmd-size-pages-to-amortize-direct-map-fragmentation.patch
* secretmem-add-memcg-accounting.patch
* secretmem-add-memcg-accounting-fix.patch
* pm-hibernate-disable-when-there-are-active-secretmem-users.patch
* arch-mm-wire-up-memfd_secret-system-call-were-relevant.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2.patch
* mmap-locking-api-dont-check-locking-if-the-mm-isnt-live-yet.patch
* mm-gup-assert-that-the-mmap-lock-is-held-in-__get_user_pages.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
