Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3042999C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 23:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394579AbgJZWiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 18:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394570AbgJZWiS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:38:18 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E939820878;
        Mon, 26 Oct 2020 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603751897;
        bh=w0ozyDKFfw9tUy+Sl79f72W0uhm215upVEyOw47pYIc=;
        h=Date:From:To:Subject:From;
        b=rly7FbPoRGeP5aVb/r0O9FaR8kfalpw1kdPsN9yT3k2Ui7WbesJY4oZMnTHHlSqDc
         J+DDbfgI9CtFx8jBw+4f8Pxc+AX2lLv8xAH9EPbah5GAXRnimYFCY7i5dK2+sbGliA
         4mfMrD0Hf/IaHLw/+OZCf/Ws+hOJPRQfyH4t/rD0=
Date:   Mon, 26 Oct 2020 15:38:16 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2020-10-26-15-37 uploaded
Message-ID: <20201026223816.uqTxy%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.10
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-10-26-15-37 has been uploaded to

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
* compilerh-fix-barrier_data-on-clang.patch
* kasan-adopt-kunit-tests-to-sw_tags-mode.patch
* mm-mempolicy-fix-potential-pte_unmap_unlock-pte-error.patch
* ptrace-fix-task_join_group_stop-for-the-case-when-current-is-traced.patch
* lib-crc32test-remove-extra-local_irq_disable-enable.patch
* mm-make-__invalidate_mapping_pages-static.patch
* kthread_worker-prevent-queuing-delayed-work-from-timer_fn-when-it-is-being-canceled.patch
* mm-oom-keep-oom_adj-under-or-at-upper-limit-when-printing.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* kthread-add-kthread_work-tracepoints.patch
* uapi-move-constants-from-linux-kernelh-to-linux-consth.patch
* fs-ocfs2-remove-unneeded-break.patch
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
* mm-page_alloc-do-not-rely-on-the-order-of-page_poison-and-init_on_alloc-free-parameters.patch
* mm-page_poison-use-static-key-more-efficiently.patch
* mm-page_alloc-reduce-static-keys-in-prep_new_page.patch
* mm-hugetlbc-just-use-put_page_testzero-instead-of-page_count.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* mm-dont-wake-kswapd-prematurely-when-watermark-boosting-is-disabled.patch
* mm-vmscan-drop-unneeded-assignment-in-kswapd.patch
* mm-compaction-rename-start_pfn-to-iteration_start_pfn-in-compact_zone.patch
* mmoom_kill-fix-the-comment-of-is_dump_unreclaim_slabs.patch
* mmoom_kill-fix-the-comment-of-is_dump_unreclaim_slabs-fix.patch
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
* proc-sysctl-make-protected_-world-readable.patch
* asm-generic-force-inlining-of-get_order-to-work-around-gcc10-poor-decision.patch
* acctc-use-elif-instead-of-end-and-elif.patch
* lib-stackdepot-add-support-to-configure-stack_hash_size.patch
* lib-test_free_pages-add-basic-progress-indicators.patch
* lib-stackdepotc-replace-one-element-array-with-flexible-array-member.patch
* lib-stackdepotc-use-flex_array_size-helper-in-memcpy.patch
* lib-stackdepotc-use-array_size-helper-in-jhash2.patch
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
