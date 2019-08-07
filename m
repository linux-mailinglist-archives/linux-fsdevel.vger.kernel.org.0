Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63983E96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 03:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfHGBMQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 21:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbfHGBMQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:12:16 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6327E214C6;
        Wed,  7 Aug 2019 01:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565140334;
        bh=8sGcRubh7pOJ3yj30hfObaM3CNBlhlDnEhkMu1r2d7k=;
        h=Date:From:To:Subject:From;
        b=OdvxSIVxASGJu8VugIFP7w61NFOljj/KPM80spgid+T00wM9xjfNvAiZael7OqTa/
         NBnsoLsbaMvtl3vMUPHPi/Sybqr8z0aWQcoFNeGfkSPwcaW9XcBAFCdYzqHJ9PdCWB
         wfOBg5J2BUuh10LpDJoI9B5im6VHj8siMEWMhbIA=
Date:   Tue, 06 Aug 2019 18:12:13 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2019-08-06-18-11 uploaded
Message-ID: <20190807011213.B-aq50pvQ%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2019-08-06-18-11 has been uploaded to

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

http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/



The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
contains daily snapshots of the -mm tree.  It is updated more frequently
than mmotm, and is untested.

A git copy of this tree is available at

	http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/

and use of this tree is similar to
http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/, described above.


This mmotm tree contains the following patches against 5.3-rc3:
(patches marked "*" will be included in linux-next)

  origin.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mm-document-zone-device-struct-page-field-usage.patch
* mm-hmm-fix-zone_device-anon-page-mapping-reuse.patch
* mm-hmm-fix-bad-subpage-pointer-in-try_to_unmap_one.patch
* mm-hmm-fix-bad-subpage-pointer-in-try_to_unmap_one-v3.patch
* mm-mempolicy-make-the-behavior-consistent-when-mpol_mf_move-and-mpol_mf_strict-were-specified.patch
* mm-mempolicy-make-the-behavior-consistent-when-mpol_mf_move-and-mpol_mf_strict-were-specified-v4.patch
* mm-mempolicy-handle-vma-with-unmovable-pages-mapped-correctly-in-mbind.patch
* mm-mempolicy-handle-vma-with-unmovable-pages-mapped-correctly-in-mbind-v4.patch
* mm-z3foldc-fix-z3fold_destroy_pool-ordering.patch
* mm-z3foldc-fix-z3fold_destroy_pool-race-condition.patch
* mm-memcontrol-fix-use-after-free-in-mem_cgroup_iter.patch
* mm-memcontrol-fix-use-after-free-in-mem_cgroup_iter-fix.patch
* mm-vmallocc-fix-percpu-free-vm-area-search-criteria.patch
* mm-kmemleak-disable-early-logging-in-case-of-error.patch
* mm-usercopy-use-memory-range-to-be-accessed-for-wraparound-check.patch
* asm-generic-fix-variable-p4d-set-but-not-used.patch
* mm-workingset-fix-vmstat-counters-for-shadow-nodes.patch
* seq_file-fix-problem-when-seeking-mid-record.patch
* kbuild-clean-compressed-initramfs-image.patch
* ocfs2-use-jbd2_inode-dirty-range-scoping.patch
* jbd2-remove-jbd2_journal_inode_add_.patch
* ocfs-further-debugfs-cleanups.patch
* ocfs2-clear-zero-in-unaligned-direct-io.patch
* ocfs2-clear-zero-in-unaligned-direct-io-checkpatch-fixes.patch
* ocfs2-wait-for-recovering-done-after-direct-unlock-request.patch
* ocfs2-checkpoint-appending-truncate-log-transaction-before-flushing.patch
* fs-ocfs2-fix-possible-null-pointer-dereferences-in-ocfs2_xa_prepare_entry.patch
* fs-ocfs2-fix-possible-null-pointer-dereferences-in-ocfs2_xa_prepare_entry-fix.patch
* fs-ocfs2-fix-a-possible-null-pointer-dereference-in-ocfs2_write_end_nolock.patch
* fs-ocfs2-fix-a-possible-null-pointer-dereference-in-ocfs2_info_scan_inode_alloc.patch
* ramfs-support-o_tmpfile.patch
  mm.patch
* mm-slab-extend-slab-shrink-to-shrink-all-memcg-caches.patch
* mm-slab-move-memcg_cache_params-structure-to-mm-slabh.patch
* kmemleak-increase-debug_kmemleak_early_log_size-default-to-16k.patch
* mm-kmemleak-use-mempool-allocations-for-kmemleak-objects.patch
* mm-page_poison-fix-a-typo-in-a-comment.patch
* mm-rmapc-remove-set-but-not-used-variable-cstart.patch
* mm-introduce-page_size.patch
* mm-introduce-page_shift.patch
* mm-introduce-page_shift-fix.patch
* mm-introduce-compound_nr.patch
* mm-replace-list_move_tail-with-add_page_to_lru_list_tail.patch
* mm-filemap-dont-initiate-writeback-if-mapping-has-no-dirty-pages.patch
* mm-filemap-rewrite-mapping_needs_writeback-in-less-fancy-manner.patch
* mm-page-cache-store-only-head-pages-in-i_pages.patch
* mm-page-cache-store-only-head-pages-in-i_pages-fix.patch
* mm-throttle-allocators-when-failing-reclaim-over-memoryhigh.patch
* mm-throttle-allocators-when-failing-reclaim-over-memoryhigh-fix.patch
* mm-throttle-allocators-when-failing-reclaim-over-memoryhigh-fix-fix.patch
* mm-throttle-allocators-when-failing-reclaim-over-memoryhigh-fix-fix-fix.patch
* mm-throttle-allocators-when-failing-reclaim-over-memoryhigh-fix-fix-fix-fix.patch
* mm-vmscan-expose-cgroup_ino-for-memcg-reclaim-tracepoints.patch
* mm-memcontrol-switch-to-rcu-protection-in-drain_all_stock.patch
* mm-gup-add-make_dirty-arg-to-put_user_pages_dirty_lock.patch
* mm-gup-add-make_dirty-arg-to-put_user_pages_dirty_lock-fix.patch
* drivers-gpu-drm-via-convert-put_page-to-put_user_page.patch
* net-xdp-convert-put_page-to-put_user_page.patch
* mm-remove-redundant-assignment-of-entry.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-release-the-spinlock-on-zap_pte_range.patch
* mm-memory_hotplug-remove-move_pfn_range.patch
* mm-memory_hotplug-remove-move_pfn_range-fix.patch
* drivers-base-nodec-simplify-unregister_memory_block_under_nodes.patch
* drivers-base-memoryc-fixup-documentation-of-removable-phys_index-block_size_bytes.patch
* driver-base-memoryc-validate-memory-block-size-early.patch
* mm-sparse-fix-memory-leak-of-sparsemap_buf-in-aliged-memory.patch
* mm-sparse-fix-memory-leak-of-sparsemap_buf-in-aliged-memory-fix.patch
* mm-sparse-fix-align-without-power-of-2-in-sparse_buffer_alloc.patch
* mm-vmalloc-do-not-keep-unpurged-areas-in-the-busy-tree.patch
* mm-vmalloc-modify-struct-vmap_area-to-reduce-its-size.patch
* mm-compaction-clear-total_migratefree_scanned-before-scanning-a-new-zone.patch
* mm-compaction-clear-total_migratefree_scanned-before-scanning-a-new-zone-fix.patch
* mm-compaction-clear-total_migratefree_scanned-before-scanning-a-new-zone-fix-fix.patch
* mm-compaction-clear-total_migratefree_scanned-before-scanning-a-new-zone-fix-2.patch
* mm-compaction-clear-total_migratefree_scanned-before-scanning-a-new-zone-fix-2-fix.patch
* mm-compaction-remove-unnecessary-zone-parameter-in-isolate_migratepages.patch
* mm-mempolicyc-remove-unnecessary-nodemask-check-in-kernel_migrate_pages.patch
* mm-oom-avoid-printk-iteration-under-rcu.patch
* mm-oom-avoid-printk-iteration-under-rcu-fix.patch
* mm-oom_killer-add-task-uid-to-info-message-on-an-oom-kill.patch
* mm-oom_killer-add-task-uid-to-info-message-on-an-oom-kill-fix.patch
* memcg-oom-dont-require-__gfp_fs-when-invoking-memcg-oom-killer.patch
* mm-reclaim-make-should_continue_reclaim-perform-dryrun-detection.patch
* mm-reclaim-cleanup-should_continue_reclaim.patch
* mm-compaction-raise-compaction-priority-after-it-withdrawns.patch
* hugetlbfs-dont-retry-when-pool-page-allocations-start-to-fail.patch
* mm-move-memcmp_pages-and-pages_identical.patch
* uprobe-use-original-page-when-all-uprobes-are-removed.patch
* uprobe-use-original-page-when-all-uprobes-are-removed-v2.patch
* mm-thp-introduce-foll_split_pmd.patch
* mm-thp-introduce-foll_split_pmd-v11.patch
* uprobe-use-foll_split_pmd-instead-of-foll_split.patch
* khugepaged-enable-collapse-pmd-for-pte-mapped-thp.patch
* uprobe-collapse-thp-pmd-after-removing-all-uprobes.patch
* thp-update-split_huge_page_pmd-commnet.patch
* filemap-check-compound_headpage-mapping-in-filemap_fault.patch
* filemap-check-compound_headpage-mapping-in-pagecache_get_page.patch
* filemap-update-offset-check-in-filemap_fault.patch
* mmthp-stats-for-file-backed-thp.patch
* khugepaged-rename-collapse_shmem-and-khugepaged_scan_shmem.patch
* mmthp-add-read-only-thp-support-for-non-shmem-fs.patch
* mmthp-avoid-writes-to-file-with-thp-in-pagecache.patch
* psi-annotate-refault-stalls-from-io-submission.patch
* psi-annotate-refault-stalls-from-io-submission-fix.patch
* psi-annotate-refault-stalls-from-io-submission-fix-2.patch
* riscv-kbuild-add-virtual-memory-system-selection.patch
* mm-fs-move-randomize_stack_top-from-fs-to-mm.patch
* arm64-make-use-of-is_compat_task-instead-of-hardcoding-this-test.patch
* arm64-consider-stack-randomization-for-mmap-base-only-when-necessary.patch
* arm64-mm-move-generic-mmap-layout-functions-to-mm.patch
* arm64-mm-make-randomization-selected-by-generic-topdown-mmap-layout.patch
* arm-properly-account-for-stack-randomization-and-stack-guard-gap.patch
* arm-use-stack_top-when-computing-mmap-base-address.patch
* arm-use-generic-mmap-top-down-layout-and-brk-randomization.patch
* mips-properly-account-for-stack-randomization-and-stack-guard-gap.patch
* mips-use-stack_top-when-computing-mmap-base-address.patch
* mips-adjust-brk-randomization-offset-to-fit-generic-version.patch
* mips-replace-arch-specific-way-to-determine-32bit-task-with-generic-version.patch
* mips-use-generic-mmap-top-down-layout-and-brk-randomization.patch
* riscv-make-mmap-allocation-top-down-by-default.patch
* mm-introduce-madv_cold.patch
* mm-change-pageref_reclaim_clean-with-page_refreclaim.patch
* mm-introduce-madv_pageout.patch
* mm-introduce-madv_pageout-fix.patch
* mm-factor-out-common-parts-between-madv_cold-and-madv_pageout.patch
* mm-madvise-reduce-code-duplication-in-error-handling-paths.patch
* zpool-add-malloc_support_movable-to-zpool_driver.patch
* zswap-use-movable-memory-if-zpool-support-allocate-movable-memory.patch
* mm-proportional-memorylowmin-reclaim.patch
* mm-make-memoryemin-the-baseline-for-utilisation-determination.patch
* mm-make-memoryemin-the-baseline-for-utilisation-determination-fix.patch
* mm-vmscan-remove-unused-lru_pages-argument.patch
* mm-dont-expose-page-to-fast-gup-before-its-ready.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* linux-coffh-add-include-guard.patch
* hung_task-allow-printing-warnings-every-check-interval.patch
* linux-bitsh-clarify-macro-argument-names.patch
* linux-bitsh-add-compile-time-sanity-check-of-genmask-inputs.patch
* rbtree-sync-up-the-tools-copy-of-the-code-with-the-main-one.patch
* augmented-rbtree-add-comments-for-rb_declare_callbacks-macro.patch
* augmented-rbtree-add-new-rb_declare_callbacks_max-macro.patch
* augmented-rbtree-add-new-rb_declare_callbacks_max-macro-fix.patch
* augmented-rbtree-add-new-rb_declare_callbacks_max-macro-fix-3.patch
* augmented-rbtree-rework-the-rb_declare_callbacks-macro-definition.patch
* lib-genallocc-export-symbol-addr_in_gen_pool.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr-fix.patch
* string-add-stracpy-and-stracpy_pad-mechanisms.patch
* documentation-checkpatch-prefer-stracpy-strscpy-over-strcpy-strlcpy-strncpy.patch
* kernel-doc-core-api-include-stringh-into-core-api.patch
* kernel-doc-core-api-include-stringh-into-core-api-v2.patch
* writeback-fix-wstringop-truncation-warnings.patch
* strscpy-reject-buffer-sizes-larger-than-int_max.patch
* lib-fix-possible-incorrect-result-from-rational-fractions-helper.patch
* checkpatch-dont-interpret-stack-dumps-as-commit-ids.patch
* checkpatch-improve-spdx-license-checking.patch
* checkpatchpl-warn-on-invalid-commit-id.patch
* checkpatch-add-_notifier_head-as-var-definition.patch
* checkpatch-exclude-sizeof-sub-expressions-from-macro_arg_reuse.patch
* fs-reiserfs-remove-unnecessary-check-of-bh-in-remove_from_transaction.patch
* fat-add-nobarrier-to-workaround-the-strange-behavior-of-device.patch
* fork-improve-error-message-for-corrupted-page-tables.patch
* cpumask-nicer-for_each_cpumask_and-signature.patch
* kexec-bail-out-upon-sigkill-when-allocating-memory.patch
* kexec-restore-arch_kexec_kernel_image_probe-declaration.patch
* aio-simplify-read_events.patch
* kgdb-dont-use-a-notifier-to-enter-kgdb-at-panic-call-directly.patch
* scripts-gdb-handle-split-debug.patch
* ipc-consolidate-all-xxxctl_down-functions.patch
  linux-next.patch
  diff-sucks.patch
* pinctrl-fix-pxa2xxc-build-warnings.patch
* mips-add-support-for-generic-vdso-fix.patch
* mm-treewide-clarify-pgtable_page_ctordtor-naming.patch
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
