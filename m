Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A92B55DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 01:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbgKQAsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 19:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgKQAsj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 19:48:39 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC6B2467A;
        Tue, 17 Nov 2020 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605574118;
        bh=JldAWLRXge+Sa3JVWZv7AwgmFCx2+nkM2ot3z2QIErA=;
        h=Date:From:To:Subject:From;
        b=wo0cErAzUe1AQNTJq+nOXZ23tTxQcbc8BiXhClOr7JyB/1OzmlPtPRZjgNMIczutn
         /L13nQC/Uy05LcZaD25V0VjiLf/RwdZAKPcVhy8zFJ+KcJui9wDbNil4PsJXSM/+Ay
         4MVo7CPNprtyyBtGM2F5q+VCf4kkUbK0UdQy3BUo=
Date:   Mon, 16 Nov 2020 16:48:37 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-11-16-16-47 uploaded
Message-ID: <20201117004837.VMxSd_ozW%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-11-16-16-47 has been uploaded to

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



This mmotm tree contains the following patches against 5.10-rc4:
(patches marked "*" will be included in linux-next)

* mm-madvise-fix-memory-leak-from-process_madvise.patch
* mm-fix-phys_to_target_node-and-memory_add_physaddr_to_nid-exports.patch
* mm-fix-phys_to_target_node-and-memory_add_physaddr_to_nid-exports-v4.patch
* mm-fix-readahead_page_batch-for-retry-entries.patch
* mm-filemap-add-static-for-function-__add_to_page_cache_locked.patch
* mm-memcg-slab-fix-root-memcg-vmstats.patch
* mm-userfaultfd-do-not-access-vma-vm_mm-after-calling-handle_userfault.patch
* libfs-fix-error-cast-of-negative-value-in-simple_attr_write.patch
* mm-fix-madvise-willneed-performance-problem.patch
* page_frag-recover-from-memory-pressure.patch
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
* mm-shmem-use-kmem_cache_zalloc-in-shmem_alloc_inode.patch
* mm-shmemc-make-shmem_mapping-inline.patch
* mm-memcontrol-add-file_thp-shmem_thp-to-memorystat.patch
* mm-memcontrol-add-file_thp-shmem_thp-to-memorystat-fix.patch
* mm-memcontrol-remove-unused-mod_memcg_obj_state.patch
* mm-memcontrol-eliminate-redundant-check-in-__mem_cgroup_insert_exceeded.patch
* mm-memcg-slab-fix-return-child-memcg-objcg-for-root-memcg.patch
* mm-memcg-slab-fix-use-after-free-in-obj_cgroup_charge.patch
* mm-rmap-always-do-ttu_ignore_access.patch
* mm-memcg-update-page-struct-member-in-comments.patch
* mm-memcg-fix-obsolete-code-comments.patch
* mm-memcg-deprecate-the-non-hierarchical-mode.patch
* docs-cgroup-v1-reflect-the-deprecation-of-the-non-hierarchical-mode.patch
* cgroup-remove-obsoleted-broken_hierarchy-and-warned_broken_hierarchy.patch
* mm-page_counter-use-page_counter_read-in-page_counter_set_max.patch
* mm-memcg-remove-obsolete-memcg_has_children.patch
* mm-thp-move-lru_add_page_tail-func-to-huge_memoryc.patch
* mm-thp-use-head-for-head-page-in-lru_add_page_tail.patch
* mm-thp-simplify-lru_add_page_tail.patch
* mm-thp-narrow-lru-locking.patch
* mm-vmscan-remove-unnecessary-lruvec-adding.patch
* mm-rmap-stop-store-reordering-issue-on-page-mapping.patch
* mm-rmap-stop-store-reordering-issue-on-page-mapping-fix.patch
* mm-page_idle_get_page-does-not-need-lru_lock.patch
* mm-memcg-add-debug-checking-in-lock_page_memcg.patch
* mm-swapc-fold-vm-event-pgrotated-into-pagevec_move_tail_fn.patch
* mm-lru-move-lock-into-lru_note_cost.patch
* mm-vmscan-remove-lruvec-reget-in-move_pages_to_lru.patch
* mm-mlock-remove-lru_lock-on-testclearpagemlocked.patch
* mm-mlock-remove-__munlock_isolate_lru_page.patch
* mm-lru-introduce-testclearpagelru.patch
* mm-compaction-do-page-isolation-first-in-compaction.patch
* mm-swapc-serialize-memcg-changes-in-pagevec_lru_move_fn.patch
* mm-lru-replace-pgdat-lru_lock-with-lruvec-lock.patch
* mm-lru-replace-pgdat-lru_lock-with-lruvec-lock-fix.patch
* mm-lru-replace-pgdat-lru_lock-with-lruvec-lock-fix-2.patch
* mm-lru-introduce-the-relock_page_lruvec-function.patch
* mm-lru-introduce-the-relock_page_lruvec-function-fix.patch
* mm-lru-revise-the-comments-of-lru_lock.patch
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
* mm-vmalloc-use-free_vm_area-if-an-allocation-fails.patch
* mm-vmalloc-rework-the-drain-logic.patch
* docs-vm-remove-unused-3-items-explanation-for-proc-vmstat.patch
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
* mm-page_alloc-mark-some-symbols-with-static-keyword.patch
* mm-hugetlbc-just-use-put_page_testzero-instead-of-page_count.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* include-linux-huge_mmh-remove-extern-keyword.patch
* mm-dont-wake-kswapd-prematurely-when-watermark-boosting-is-disabled.patch
* mm-vmscan-drop-unneeded-assignment-in-kswapd.patch
* mm-remove-the-filename-in-the-top-of-file-comment-in-vmscanc.patch
* mm-compaction-rename-start_pfn-to-iteration_start_pfn-in-compact_zone.patch
* mm-compaction-move-compaction_suitables-comment-to-right-place.patch
* mm-oom_kill-change-comment-and-rename-is_dump_unreclaim_slabs.patch
* mm-migrate-fix-comment-spelling.patch
* mm-optimize-migrate_vma_pages-mmu-notifier.patch
* mm-truncate_complete_page-is-not-existed-anymore.patch
* mm-migrate-simplify-the-logic-for-handling-permanent-failure.patch
* mm-migrate-skip-shared-exec-thp-for-numa-balancing.patch
* mm-migrate-clean-up-migrate_prep_local.patch
* mm-migrate-return-enosys-if-thp-migration-is-unsupported.patch
* mm-make-pagecache-tagged-lookups-return-only-head-pages.patch
* mm-shmem-use-pagevec_lookup-in-shmem_unlock_mapping.patch
* mm-swap-optimise-get_shadow_from_swap_cache.patch
* mm-add-fgp_entry.patch
* mm-filemap-rename-find_get_entry-to-mapping_get_entry.patch
* mm-filemap-add-helper-for-finding-pages.patch
* mm-filemap-add-mapping_seek_hole_data.patch
* iomap-use-mapping_seek_hole_data.patch
* mm-add-and-use-find_lock_entries.patch
* mm-add-an-end-parameter-to-find_get_entries.patch
* mm-add-an-end-parameter-to-pagevec_lookup_entries.patch
* mm-remove-nr_entries-parameter-from-pagevec_lookup_entries.patch
* mm-pass-pvec-directly-to-find_get_entries.patch
* mm-remove-pagevec_lookup_entries.patch
* mm-truncateshmem-handle-truncates-that-split-thps.patch
* mm-filemap-return-only-head-pages-from-find_get_entries.patch
* mm-cmac-remove-redundant-cma_mutex-lock.patch
* mm-page_alloc-do-not-rely-on-the-order-of-page_poison-and-init_on_alloc-free-parameters.patch
* mm-page_poison-use-static-key-more-efficiently.patch
* kernel-power-allow-hibernation-with-page_poison-sanity-checking.patch
* mm-page_poison-remove-config_page_poisoning_no_sanity.patch
* mm-page_poison-remove-config_page_poisoning_zero.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
* mm-zswap-make-struct-kernel_param_ops-definitions-const.patch
* mm-zswap-fix-passing-zero-to-ptr_err-warning.patch
* mm-zswap-move-to-use-crypto_acomp-api-for-hardware-acceleration.patch
* zsmalloc-rework-the-list_add-code-in-insert_zspage.patch
* mm-process_vm_access-remove-redundant-initialization-of-iov_r.patch
* zram-support-a-page-writeback.patch
* mm-fix-kernel-doc-markups.patch
* mm-use-sysfs_emit-for-struct-kobject-uses.patch
* mm-huge_memory-convert-remaining-use-of-sprintf-to-sysfs_emit-and-neatening.patch
* mm-backing-dev-use-sysfs_emit-in-macro-defining-functions.patch
* mm-shmem-convert-shmem_enabled_show-to-use-sysfs_emit_at.patch
* mm-slub-convert-sysfs-sprintf-family-to-sysfs_emit-sysfs_emit_at.patch
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
* alpha-replace-bogus-in_interrupt.patch
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
* bitmap-remove-unused-function-declaration.patch
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
* lib-cmdline_kunit-add-a-new-test-suite-for-cmdline-api-fix-2.patch
* lib-cmdline_kunit-add-a-new-test-suite-for-cmdline-api-fix-3.patch
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
* checkpatch-fix-spelling-errors-and-remove-repeated-word.patch
* checkpatch-avoid-commit_log_long_line-warning-for-signature-tags.patch
* checkpatch-fix-unescaped-left-brace.patch
* reiserfs-add-check-for-an-invalid-ih_entry_count.patch
* kdump-append-uts_namespacename-offset-to-vmcoreinfo.patch
* rapidio-remove-unused-rio_get_asm-and-rio_get_device.patch
* gcov-remove-support-for-gcc-49.patch
* aio-simplify-read_events.patch
* resource-fix-kernel-doc-markups.patch
* resource-fix-kernel-doc-markups-checkpatch-fixes.patch
* reboot-allow-to-specify-reboot-mode-via-sysfs.patch
* reboot-fix-variable-assignments-in-type_store.patch
* reboot-remove-cf9_safe-from-allowed-types-and-rename-cf9_force.patch
* fault-injection-handle-ei_etype_true.patch
* lib-lzo-make-lzogeneric1x_1_compress-static.patch
  linux-next.patch
  linux-next-rejects.patch
* mm-memcontrol-use-helpers-to-read-pages-memcg-data.patch
* mm-memcontrol-slab-use-helpers-to-access-slab-pages-memcg_data.patch
* mm-introduce-page-memcg-flags.patch
* mm-convert-page-kmemcg-type-to-a-page-memcg-flag.patch
* mm-memcg-bail-early-from-swap-accounting-if-memcg-disabled.patch
* mm-memcg-warning-on-memcg-after-readahead-page-charged.patch
* mm-memcg-remove-unused-definitions.patch
* mm-kvm-account-kvm_vcpu_mmap-to-kmemcg.patch
* mm-slub-call-account_slab_page-after-slab-page-initialization.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account-v2.patch
* mm-memcontrol-rewrite-mem_cgroup_page_lruvec.patch
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
* mm-add-definition-of-pmd_page_order.patch
* mmap-make-mlock_future_check-global.patch
* set_memory-allow-set_direct_map__noflush-for-multiple-pages.patch
* set_memory-allow-set_direct_map__noflush-for-multiple-pages-fix.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix.patch
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
