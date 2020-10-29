Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D567D29DF04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgJ2A5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgJ2A5c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:57:32 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE58120719;
        Thu, 29 Oct 2020 00:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603933050;
        bh=je+aU0HymNQdfvcQvbKAL3eNphA+mRrqIms1RycLyUU=;
        h=Date:From:To:Subject:From;
        b=fUNshvEnrb024L9bkDbOy/ZOrufYWMiQs1Dk5pgtW3i5fXxKPiE8sPgDYBiMmAF+N
         mXXxUm7MDgykneuc1nzGUuUi04ngj5TLhA4pInZbc10mSWwN4VClnblHdnThGDBXvo
         3nbcag6MvYyX6P1nhgvLbvJFIupUfygF1zld5VRI=
Date:   Wed, 28 Oct 2020 17:57:29 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-10-28-17-56 uploaded
Message-ID: <20201029005729.w34EOeDF2%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-10-28-17-56 has been uploaded to

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



This mmotm tree contains the following patches against 5.10-rc1:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-mremap_pages-fix-static-key-devmap_managed_key-updates.patch
* hugetlb_cgroup-fix-reservation-accounting.patch
* mm-memcontrol-correct-the-nr_anon_thps-counter-of-hierarchical-memcg.patch
* mm-memcontrol-correct-the-nr_anon_thps-counter-of-hierarchical-memcg-fix.patch
* mm-memcontrol-correct-the-nr_anon_thps-counter-of-hierarchical-memcg-fix-fix.patch
* mm-memcg-link-page-counters-to-root-if-use_hierarchy-is-false.patch
* compilerh-fix-barrier_data-on-clang.patch
* kasan-adopt-kunit-tests-to-sw_tags-mode.patch
* mm-mempolicy-fix-potential-pte_unmap_unlock-pte-error.patch
* ptrace-fix-task_join_group_stop-for-the-case-when-current-is-traced.patch
* lib-crc32test-remove-extra-local_irq_disable-enable.patch
* mm-make-__invalidate_mapping_pages-static.patch
* kthread_worker-prevent-queuing-delayed-work-from-timer_fn-when-it-is-being-canceled.patch
* mm-oom-keep-oom_adj-under-or-at-upper-limit-when-printing.patch
* mm-always-have-io_remap_pfn_range-set-pgprot_decrypted.patch
* epoll-check-ep_events_available-upon-timeout.patch
* epoll-add-a-selftest-for-epoll-timeout-race.patch
* kernel-hung_taskc-make-type-annotations-consistent.patch
* mm-slub-fix-panic-in-slab_alloc_node.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* kthread-add-kthread_work-tracepoints.patch
* uapi-move-constants-from-linux-kernelh-to-linux-consth.patch
* fs-ocfs2-remove-unneeded-break.patch
* ocfs2-ratelimit-the-max-lookup-times-reached-notice.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mmslab_common-use-list_for_each_entry-in-dump_unreclaimable_slab.patch
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
* mm-handle-zone-device-pages-in-release_pages.patch
* mm-swapfilec-use-helper-function-swap_count-in-add_swap_count_continuation.patch
* mm-swap_state-skip-meaningless-swap-cache-readahead-when-ra_infowin-==-0.patch
* mm-swap_state-skip-meaningless-swap-cache-readahead-when-ra_infowin-==-0-fix.patch
* mm-swapfilec-remove-unnecessary-out-label-in-__swap_duplicate.patch
* mm-swap-use-memset-to-fill-the-swap_map-with-swap_has_cache.patch
* mm-memcontrol-add-file_thp-shmem_thp-to-memorystat.patch
* mm-memcontrol-add-file_thp-shmem_thp-to-memorystat-fix.patch
* mm-memcontrol-remove-unused-mod_memcg_obj_state.patch
* mm-memcontrol-eliminate-redundant-check-in-__mem_cgroup_insert_exceeded.patch
* mm-memcontrol-use-helpers-to-read-pages-memcg-data.patch
* mm-memcontrol-slab-use-helpers-to-access-slab-pages-memcg_data.patch
* mm-introduce-page-memcg-flags.patch
* mm-convert-page-kmemcg-type-to-a-page-memcg-flag.patch
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
* mm-vmalloc-fix-kasan-shadow-poisoning-size.patch
* mm-page_alloc-do-not-rely-on-the-order-of-page_poison-and-init_on_alloc-free-parameters.patch
* mm-page_alloc-do-not-rely-on-the-order-of-page_poison-and-init_on_alloc-free-parameters-fix.patch
* mm-page_poison-use-static-key-more-efficiently.patch
* mm-page_alloc-reduce-static-keys-in-prep_new_page.patch
* mm-hugetlbc-just-use-put_page_testzero-instead-of-page_count.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* mm-dont-wake-kswapd-prematurely-when-watermark-boosting-is-disabled.patch
* mm-vmscan-drop-unneeded-assignment-in-kswapd.patch
* mm-compaction-rename-start_pfn-to-iteration_start_pfn-in-compact_zone.patch
* mm-migrate-fix-comment-spelling.patch
* mm-optimize-migrate_vma_pages-mmu-notifier.patch
* mm-cmac-remove-redundant-cma_mutex-lock.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
* mm-zswap-make-struct-kernel_param_ops-definitions-const.patch
* zsmalloc-rework-the-list_add-code-in-insert_zspage.patch
* zram-support-a-page-writeback.patch
* page-flags-remove-unused-__pageprivate.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* procfs-delete-duplicated-words-other-fixes.patch
* proc-sysctl-make-protected_-world-readable.patch
* asm-generic-force-inlining-of-get_order-to-work-around-gcc10-poor-decision.patch
* kernelh-split-out-mathematical-helpers.patch
* acctc-use-elif-instead-of-end-and-elif.patch
* bitmap-convert-bitmap_empty-bitmap_full-to-return-boolean.patch
* lib-stackdepot-add-support-to-configure-stack_hash_size.patch
* lib-test_free_pages-add-basic-progress-indicators.patch
* lib-stackdepotc-replace-one-element-array-with-flexible-array-member.patch
* lib-stackdepotc-use-flex_array_size-helper-in-memcpy.patch
* lib-stackdepotc-use-array_size-helper-in-jhash2.patch
* lib-test_lockup-minimum-fix-to-get-it-compiled-on-preempt_rt.patch
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
* kdump-append-uts_namespacename-offset-to-vmcoreinfo.patch
* aio-simplify-read_events.patch
* fault-injection-handle-ei_etype_true.patch
* lib-lzo-make-lzogeneric1x_1_compress-static.patch
  linux-next.patch
* mmap-locking-api-dont-check-locking-if-the-mm-isnt-live-yet.patch
* mm-gup-assert-that-the-mmap-lock-is-held-in-__get_user_pages.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
