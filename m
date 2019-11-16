Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C381FFEA41
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2019 03:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKPCg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 21:36:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbfKPCg0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 21:36:26 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 670222073C;
        Sat, 16 Nov 2019 02:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573871784;
        bh=93P6fGOh42jrXYopZNAvg9e6zy6KAKSSSPtELP9Fc1A=;
        h=Date:From:To:Subject:From;
        b=oz/mWnOliZT/h1oGH9Ko2Pdab4Q1qtjYw9hnRgPVw6fBhbECOLMKBmHd+4ryC1LlB
         M/mm+4Nhp7NimYkIpWdlD+qBiSTT0I+b35mNPauovDiVJKV44olyxHFL3IS+rHuMkw
         y38SS8vjMrwvvxEpR7qWRMLloyVGbZGI/zbAJ1Ow=
Date:   Fri, 15 Nov 2019 18:36:23 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2019-11-15-18-35 uploaded
Message-ID: <20191116023623.Hc7zE6e8-%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2019-11-15-18-35 has been uploaded to

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



This mmotm tree contains the following patches against 5.4-rc7:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-mempolicy-fix-the-wrong-return-value-and-potential-pages-leak-of-mbind.patch
* mm-fix-trying-to-reclaim-unevictable-lru-page-when-calling-madvise_pageout.patch
* lib-xz-fix-xz_dynalloc-to-avoid-useless-memory-reallocations.patch
* mm-memcg-switch-to-css_tryget-in-get_mem_cgroup_from_mm.patch
* mm-hugetlb-switch-to-css_tryget-in-hugetlb_cgroup_charge_cgroup.patch
* mm-slub-really-fix-slab-walking-for-init_on_free.patch
* mmthp-recheck-each-page-before-collapsing-file-thp.patch
* mm-memory_hotplug-fix-try_offline_node.patch
* mm-do-not-free-shared-swap-slots.patch
* mm-debug-__dump_page-prints-an-extra-line.patch
* mm-debug-pageanon-is-true-for-pageksm-pages.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mm-thp-tweak-reclaim-compaction-effort-of-local-only-and-all-node-allocations.patch
* mm-sparse-consistently-do-not-zero-memmap.patch
* x86-mm-split-vmalloc_sync_all.patch
* revert-fs-ocfs2-fix-possible-null-pointer-dereferences-in-ocfs2_xa_prepare_entry.patch
* scripts-spellingtxt-add-more-spellings-to-spellingtxt.patch
* ocfs2-fix-passing-zero-to-ptr_err-warning.patch
* ramfs-support-o_tmpfile.patch
* fs-bufferc-fix-use-true-false-for-bool-type.patch
* fs-include-internalh-for-missing-declarations.patch
  mm.patch
* mm-slab-make-kmalloc_info-contain-all-types-of-names.patch
* mm-slab-remove-unused-kmalloc_size.patch
* mm-slab_common-use-enum-kmalloc_cache_type-to-iterate-over-kmalloc-caches.patch
* mm-slub-print-the-offset-of-fault-addresses.patch
* mm-update-comments-in-slubc.patch
* mm-clean-up-validate_slab.patch
* mm-avoid-slub-allocation-while-holding-list_lock.patch
* fs-remove-redundant-cache-invalidation-after-async-direct-io-write.patch
* fs-keep-dio_warn_stale_pagecache-when-config_block=n.patch
* fs-warn-if-stale-pagecache-is-left-after-direct-write.patch
* mm-gup-allow-cma-migration-to-propagate-errors-back-to-caller.patch
* mm-gup-fix-comments-of-__get_user_pages-and-get_user_pages_remote.patch
* mm-swap-disallow-swapon-on-zoned-block-devices.patch
* mm-swap-disallow-swapon-on-zoned-block-devices-fix.patch
* mm-trivial-mark_page_accessed-cleanup.patch
* mm-memcg-clean-up-reclaim-iter-array.patch
* mm-vmscan-expose-cgroup_ino-for-memcg-reclaim-tracepoints.patch
* mm-memcontrol-remove-dead-code-from-memory_max_write.patch
* mm-memcontrol-try-harder-to-set-a-new-memoryhigh.patch
* mm-fix-comments-based-on-per-node-memcg.patch
* mm-vmscan-memcontrol-remove-mem_cgroup_select_victim_node.patch
* mm-vmscan-memcontrol-remove-mem_cgroup_select_victim_node-v2.patch
* docs-cgroup-mm-document-why-inactive_x-active_x-may-not-equal-x.patch
* docs-cgroup-mm-fix-spelling-of-list.patch
* mm-drop-mmap_sem-before-calling-balance_dirty_pages-in-write-fault.patch
* shmem-pin-the-file-in-shmem_fault-if-mmap_sem-is-dropped.patch
* mm-emit-tracepoint-when-rss-changes.patch
* rss_stat-add-support-to-detect-rss-updates-of-external-mm.patch
* rss_stat-add-support-to-detect-rss-updates-of-external-mm-fix.patch
* rss_stat-add-support-to-detect-rss-updates-of-external-mm-fix-2.patch
* mm-mmapc-remove-a-never-trigger-warning-in-__vma_adjust.patch
* mm-pgmap-use-correct-alignment-when-looking-at-first-pfn-from-a-region.patch
* mm-pgmap-use-correct-alignment-when-looking-at-first-pfn-from-a-region-checkpatch-fixes.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-swap-piggyback-lru_add_drain_all-calls.patch
* mm-mmapc-prev-could-be-retrieved-from-vma-vm_prev.patch
* mm-mmapc-__vma_unlink_prev-is-not-necessary-now.patch
* mm-mmapc-extract-__vma_unlink_list-as-counter-part-for-__vma_link_list.patch
* mm-mmapc-rb_parent-is-not-necessary-in-__vma_link_list.patch
* mm-rmapc-dont-reuse-anon_vma-if-we-just-want-a-copy.patch
* mm-rmapc-reuse-mergeable-anon_vma-as-parent-when-fork.patch
* mm-mmapc-use-is_err_value-to-check-return-value-of-get_unmapped_area.patch
* mm-mmapc-use-is_err_value-to-check-return-value-of-get_unmapped_area-fix.patch
* arc-mm-remove-__arch_use_5level_hack.patch
* asm-generic-tlb-stub-out-pud_free_tlb-if-nopud.patch
* asm-generic-tlb-stub-out-p4d_free_tlb-if-nop4d.patch
* asm-generic-tlb-stub-out-pmd_free_tlb-if-nopmd.patch
* asm-generic-mm-stub-out-p4ud_clear_bad-if-__pagetable_p4ud_folded.patch
* mm-fix-outdated-comment-in-page_get_anon_vma.patch
* mm-rmap-use-vm_bug_on_page-in-__page_check_anon_rmap.patch
* mm-move-the-backup-x_devmap-functions-to-asm-generic-pgtableh.patch
* mm-fix-a-huge-pud-insertion-race-during-faulting.patch
* memfd-fix-cow-issue-on-map_private-and-f_seal_future_write-mappings.patch
* memfd-fix-cow-issue-on-map_private-and-f_seal_future_write-mappings-fix.patch
* memfd-add-test-for-cow-on-map_private-and-f_seal_future_write-mappings.patch
* mm-memory-failurec-clean-up-around-tk-pre-allocation.patch
* mm-soft-offline-convert-parameter-to-pfn.patch
* mm-memory-failurec-replace-with-page_shift-in-add_to_kill.patch
* mm-hotplug-reorder-memblock_-calls-in-try_remove_memory.patch
* memory_hotplug-add-a-bounds-check-to-__add_pages.patch
* mm-memory_hotplug-export-generic_online_page.patch
* hv_balloon-use-generic_online_page.patch
* mm-memory_hotplug-remove-__online_page_free-and-__online_page_increment_counters.patch
* mm-memmap_init-update-variable-name-in-memmap_init_zone.patch
* mm-memory_hotplug-dont-access-uninitialized-memmaps-in-shrink_zone_span.patch
* mm-memory_hotplug-shrink-zones-when-offlining-memory.patch
* mm-memory_hotplug-poison-memmap-in-remove_pfn_range_from_zone.patch
* mm-memory_hotplug-we-always-have-a-zone-in-find_smallestbiggest_section_pfn.patch
* mm-memory_hotplug-dont-check-for-all-holes-in-shrink_zone_span.patch
* mm-memory_hotplug-drop-local-variables-in-shrink_zone_span.patch
* mm-memory_hotplug-cleanup-__remove_pages.patch
* mm-page_allocc-dont-set-pages-pagereserved-when-offlining.patch
* mm-page_isolationc-convert-skip_hwpoison-to-memory_offline.patch
* mm-memory_hotplug-move-definitions-of-setclear_zone_contiguous.patch
* drivers-base-memoryc-drop-the-mem_sysfs_mutex.patch
* mm-sparsec-mark-populate_section_memmap-as-__meminit.patch
* mm-sparsec-mark-populate_section_memmap-as-__meminit-v2.patch
* mm-vmalloc-remove-unnecessary-highmem_mask-from-parameter-of-gfpflags_allow_blocking.patch
* mm-vmalloc-remove-preempt_disable-enable-when-do-preloading.patch
* mm-vmalloc-respect-passed-gfp_mask-when-do-preloading.patch
* mm-vmalloc-add-more-comments-to-the-adjust_va_to_fit_type.patch
* selftests-vm-add-fragment-config_test_vmalloc.patch
* mm-vmalloc-rework-vmap_area_lock.patch
* kasan-support-backing-vmalloc-space-with-real-shadow-memory.patch
* kasan-add-test-for-vmalloc.patch
* fork-support-vmap_stack-with-kasan_vmalloc.patch
* x86-kasan-support-kasan_vmalloc.patch
* mm-page_alloc-add-alloc_contig_pages.patch
* mm-pcp-share-common-code-between-memory-hotplug-and-percpu-sysctl-handler.patch
* mm-pcpu-make-zone-pcp-updates-and-reset-internal-to-the-mm.patch
* mm-fix-comment-for-isolate_unmapped-macro.patch
* mm-page_alloc-print-reserved_highatomic-info.patch
* mm-vmscan-remove-unused-lru_pages-argument.patch
* mm-vmscan-remove-unused-scan_control-parameter-from-pageout.patch
* mm-vmscan-simplify-lruvec_lru_size.patch
* mm-vmscan-simplify-lruvec_lru_size-fix.patch
* mm-vmscan-simplify-lruvec_lru_size-fix-fix.patch
* mm-clean-up-and-clarify-lruvec-lookup-procedure.patch
* mm-vmscan-move-inactive_list_is_low-swap-check-to-the-caller.patch
* mm-vmscan-naming-fixes-global_reclaim-and-sane_reclaim.patch
* mm-vmscan-replace-shrink_node-loop-with-a-retry-jump.patch
* mm-vmscan-turn-shrink_node_memcg-into-shrink_lruvec.patch
* mm-vmscan-split-shrink_node-into-node-part-and-memcgs-part.patch
* mm-vmscan-split-shrink_node-into-node-part-and-memcgs-part-fix.patch
* mm-vmscan-harmonize-writeback-congestion-tracking-for-nodes-memcgs.patch
* mm-vmscan-move-file-exhaustion-detection-to-the-node-level.patch
* mm-vmscan-detect-file-thrashing-at-the-reclaim-root.patch
* mm-vmscan-enforce-inactive-active-ratio-at-the-reclaim-root.patch
* mm-vmscan-detect-file-thrashing-at-the-reclaim-root-fix.patch
* mm-vmscan-detect-file-thrashing-at-the-reclaim-root-fix-2.patch
* mm-vmscanc-fix-typo-in-comment.patch
* kernel-sysctl-make-drop_caches-write-only.patch
* z3fold-add-inter-page-compaction.patch
* z3fold-add-inter-page-compaction-fix.patch
* mm-check-range-first-in-queue_pages_test_walk.patch
* mm-fix-checking-unmapped-holes-for-mbind.patch
* mm-memblock-cleanup-doc.patch
* mm-memblock-correct-doc-for-function.patch
* mm-support-memblock-alloc-on-the-exact-node-for-sparse_buffer_init.patch
* mm-oom-avoid-printk-iteration-under-rcu.patch
* mm-oom-avoid-printk-iteration-under-rcu-fix.patch
* hugetlbfs-hugetlb_fault_mutex_hash-cleanup.patch
* mm-hugetlbfs-fix-error-handling-when-setting-up-mounts.patch
* powerpc-mm-remove-pmd_huge-pud_huge-stubs-and-include-hugetlbh.patch
* hugetlbfs-convert-macros-to-static-inline-fix-sparse-warning.patch
* hugetlbfs-add-o_tmpfile-support.patch
* hugetlbfs-take-read_lock-on-i_mmap-for-pmd-sharing.patch
* hugetlb-region_chg-provides-only-cache-entry.patch
* hugetlb-remove-duplicated-code.patch
* hugetlb-remove-duplicated-code-checkpatch-fixes.patch
* hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash.patch
* hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash-fix.patch
* hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash-fix-fix.patch
* mm-hugetlb-avoid-looping-to-the-same-hugepage-if-pages-and-vmas.patch
* mm-split_huge_pages_fops-should-be-defined-with-define_debugfs_attribute.patch
* mm-migrate-handle-freed-page-at-the-first-place.patch
* mm-thp-do-not-queue-fully-unmapped-pages-for-deferred-split.patch
* mm-thp-make-set_huge_zero_page-return-void.patch
* mm-thp-flush-file-for-is_shmem-pagedirty-case-in-collapse_file.patch
* mm-cmac-switch-to-bitmap_zalloc-for-cma-bitmap-allocation.patch
* mm-cma_debug-use-define_debugfs_attribute-to-define-debugfs-fops.patch
* autonuma-fix-watermark-checking-in-migrate_balanced_pgdat.patch
* autonuma-reduce-cache-footprint-when-scanning-page-tables.patch
* mm-hwpoison-inject-use-define_debugfs_attribute-to-define-debugfs-fops.patch
* mm-vmstat-add-helpers-to-get-vmstat-item-names-for-each-enum-type.patch
* mm-vmstat-do-not-use-size-of-vmstat_text-as-count-of-proc-vmstat-items.patch
* mm-memcontrol-use-vmstat-names-for-printing-statistics.patch
* mm-mmapc-make-vma_merge-comment-more-easy-to-understand.patch
* mm-replace-is_zero_pfn-with-is_huge_zero_pmd-for-thp.patch
* mm-madvise-replace-with-page_size-in-madvise_inject_error.patch
* mm-madvise-replace-with-page_size-in-madvise_inject_error-fix.patch
* userfaultfd-use-vma_pagesize-for-all-huge-page-size-calculation.patch
* userfaultfd-remove-unnecessary-warn_on-in-__mcopy_atomic_hugetlb.patch
* userfaultfd-wrap-the-common-dst_vma-check-into-an-inlined-function.patch
* uffd-wp-clear-vm_uffd_missing-or-vm_uffd_wp-during-userfaultfd_register.patch
* userfaultfd-require-cap_sys_ptrace-for-uffd_feature_event_fork.patch
* mm-shmemc-make-array-values-static-const-makes-object-smaller.patch
* mm-shmem-use-proper-gfp-flags-for-shmem_writepage.patch
* mm-cast-the-type-of-unmap_start-to-u64.patch
* mm-fix-struct-member-name-in-function-comments.patch
* mm-fix-typo-in-the-comment-when-calling-function-__setpageuptodate.patch
* mm-memory_hotplugc-remove-__online_page_set_limits.patch
* mm-annotate-refault-stalls-from-swap_readpage.patch
* mm-annotate-refault-stalls-from-swap_readpage-fix.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-change-nlink-under-proc_subdir_lock.patch
* proc-delete-useless-len-variable.patch
* proc-shuffle-struct-pde_opener.patch
* proc-fix-confusing-macro-arg-name.patch
* sysctl-inline-braces-for-ctl_table-and-ctl_table_header.patch
* gitattributes-use-dts-diff-driver-for-dts-files.patch
* linux-build_bugh-change-type-to-int.patch
* linux-scch-make-uapi-linux-scch-self-contained.patch
* syscalls-fix-references-to-filenames-containing-syscall-defs.patch
* kernel-notifierc-intercepting-duplicate-registrations-to-avoid-infinite-loops.patch
* kernel-notifierc-remove-notifier_chain_cond_register.patch
* kernel-notifierc-remove-blocking_notifier_chain_cond_register.patch
* kernel-profile-use-cpumask_available-to-check-for-null-cpumask.patch
* kernel-sysc-avoid-copying-possible-padding-bytes-in-copy_to_user.patch
* hung_task-allow-printing-warnings-every-check-interval.patch
* get_maintainer-add-signatures-from-fixes-badcommit-lines-in-commit-message.patch
* lib-rbtree-set-successors-parent-unconditionally.patch
* lib-rbtree-get-successors-color-directly.patch
* string-add-stracpy-and-stracpy_pad-mechanisms.patch
* documentation-checkpatch-prefer-stracpy-strscpy-over-strcpy-strlcpy-strncpy.patch
* lib-optimize-cpumask_local_spread.patch
* lib-optimize-cpumask_local_spread-v3.patch
* lib-optimize-cpumask_local_spread-v3-fix.patch
* lib-test_meminitc-add-bulk-alloc-free-tests.patch
* lib-fix-possible-incorrect-result-from-rational-fractions-helper.patch
* checkpatch-improve-ignoring-camelcase-si-style-variants-like-ma.patch
* checkpatch-reduce-is_maintained_obsolete-lookup-runtime.patch
* epoll-simplify-ep_poll_safewake-for-config_debug_lock_alloc.patch
* fs-epoll-remove-unnecessary-wakeups-of-nested-epoll.patch
* selftests-add-epoll-selftests.patch
* elf-delete-unused-interp_map_addr-argument.patch
* elf-extract-elf_read-function.patch
* rapidio-fix-missing-include-of-linux-rio_drvh.patch
* drivers-rapidio-rio-accessc-fix-missing-include-of-linux-rio_drvh.patch
* drm-limit-to-int_max-in-create_blob-ioctl.patch
* uaccess-disallow-int_max-copy-sizes.patch
* aio-simplify-read_events.patch
* kcov-remote-coverage-support.patch
* usb-kcov-collect-coverage-from-hub_event.patch
* usb-kcov-collect-coverage-from-hub_event-fix.patch
* vhost-kcov-collect-coverage-from-vhost_worker.patch
* lib-ubsan-dont-seralize-ubsan-report.patch
* smp_mb__beforeafter_atomic-update-documentation.patch
* ipc-mqueuec-remove-duplicated-code.patch
* ipc-mqueuec-update-document-memory-barriers.patch
* ipc-msgc-update-and-document-memory-barriers.patch
* ipc-semc-document-and-update-memory-barriers.patch
* arch-ipcbufh-make-uapi-asm-ipcbufh-self-contained.patch
* arch-msgbufh-make-uapi-asm-msgbufh-self-contained.patch
* arch-sembufh-make-uapi-asm-sembufh-self-contained.patch
* ipc-consolidate-all-xxxctl_down-functions.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
  diff-sucks.patch
* drivers-block-null_blk_mainc-fix-layout.patch
* drivers-block-null_blk_mainc-fix-uninitialized-var-warnings.patch
* pinctrl-fix-pxa2xxc-build-warnings.patch
* lib-genallocc-export-symbol-addr_in_gen_pool.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr-fix.patch
* hacking-group-sysrq-kgdb-ubsan-into-generic-kernel-debugging-instruments.patch
* hacking-create-submenu-for-arch-special-debugging-options.patch
* hacking-group-kernel-data-structures-debugging-together.patch
* hacking-move-kernel-testing-and-coverage-options-to-same-submenu.patch
* hacking-move-oops-into-lockups-and-hangs.patch
* hacking-move-sched_stack_end_check-after-debug_stack_usage.patch
* hacking-create-a-submenu-for-scheduler-debugging-options.patch
* hacking-move-debug_bugverbose-to-printk-and-dmesg-options.patch
* hacking-move-debug_fs-to-generic-kernel-debugging-instruments.patch
* bitops-introduce-the-for_each_set_clump8-macro.patch
* bitops-introduce-the-for_each_set_clump8-macro-fix.patch
* bitops-introduce-the-for_each_set_clump8-macro-fix-fix.patch
* bitops-introduce-the-for_each_set_clump8-macro-fix-fix-fix.patch
* lib-test_bitmapc-add-for_each_set_clump8-test-cases.patch
* gpio-104-dio-48e-utilize-for_each_set_clump8-macro.patch
* gpio-104-idi-48-utilize-for_each_set_clump8-macro.patch
* gpio-gpio-mm-utilize-for_each_set_clump8-macro.patch
* gpio-ws16c48-utilize-for_each_set_clump8-macro.patch
* gpio-pci-idio-16-utilize-for_each_set_clump8-macro.patch
* gpio-pcie-idio-24-utilize-for_each_set_clump8-macro.patch
* gpio-uniphier-utilize-for_each_set_clump8-macro.patch
* gpio-74x164-utilize-the-for_each_set_clump8-macro.patch
* thermal-intel-intel_soc_dts_iosf-utilize-for_each_set_clump8-macro.patch
* gpio-pisosr-utilize-the-for_each_set_clump8-macro.patch
* gpio-max3191x-utilize-the-for_each_set_clump8-macro.patch
* gpio-pca953x-utilize-the-for_each_set_clump8-macro.patch
* lib-test_bitmap-force-argument-of-bitmap_parselist_user-to-proper-address-space.patch
* lib-test_bitmap-undefine-macros-after-use.patch
* lib-test_bitmap-name-exp_bytes-properly.patch
* lib-test_bitmap-rename-exp-to-exp1-to-avoid-ambiguous-name.patch
* lib-test_bitmap-move-exp1-and-exp2-upper-for-others-to-use.patch
* lib-test_bitmap-fix-comment-about-this-file.patch
* bitmap-introduce-bitmap_replace-helper.patch
* gpio-pca953x-remove-redundant-variable-and-check-in-irq-handler.patch
* gpio-pca953x-use-input-from-regs-structure-in-pca953x_irq_pending.patch
* gpio-pca953x-convert-to-use-bitmap-api.patch
* gpio-pca953x-convert-to-use-bitmap-api-fix.patch
* gpio-pca953x-tight-up-indentation.patch
* mm-add-generic-pd_leaf-macros.patch
* arc-mm-add-pd_leaf-definitions.patch
* arm-mm-add-pd_leaf-definitions.patch
* arm64-mm-add-pd_leaf-definitions.patch
* mips-mm-add-pd_leaf-definitions.patch
* powerpc-mm-add-pd_leaf-definitions.patch
* riscv-mm-add-pd_leaf-definitions.patch
* s390-mm-add-pd_leaf-definitions.patch
* sparc-mm-add-pd_leaf-definitions.patch
* x86-mm-add-pd_leaf-definitions.patch
* mm-pagewalk-add-p4d_entry-and-pgd_entry.patch
* mm-pagewalk-allow-walking-without-vma.patch
* mm-pagewalk-allow-walking-without-vma-v15.patch
* mm-pagewalk-allow-walking-without-vma-fix.patch
* mm-pagewalk-add-test_pd-callbacks.patch
* mm-pagewalk-add-depth-parameter-to-pte_hole.patch
* x86-mm-point-to-struct-seq_file-from-struct-pg_state.patch
* x86-mmefi-convert-ptdump_walk_pgd_level-to-take-a-mm_struct.patch
* x86-mm-convert-ptdump_walk_pgd_level_debugfs-to-take-an-mm_struct.patch
* x86-mm-convert-ptdump_walk_pgd_level_core-to-take-an-mm_struct.patch
* mm-add-generic-ptdump.patch
* mm-add-generic-ptdump-v15.patch
* mm-add-generic-ptdump-v15-fix.patch
* x86-mm-convert-dump_pagetables-to-use-walk_page_range.patch
* arm64-mm-convert-mm-dumpc-to-use-walk_page_range.patch
* arm64-mm-display-non-present-entries-in-ptdump.patch
* mm-ptdump-reduce-level-numbers-by-1-in-note_page.patch
* alpha-use-pgtable-nopud-instead-of-4level-fixup.patch
* arm-nommu-use-pgtable-nopud-instead-of-4level-fixup.patch
* c6x-use-pgtable-nopud-instead-of-4level-fixup.patch
* m68k-nommu-use-pgtable-nopud-instead-of-4level-fixup.patch
* m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup.patch
* microblaze-use-pgtable-nopmd-instead-of-4level-fixup.patch
* nds32-use-pgtable-nopmd-instead-of-4level-fixup.patch
* parisc-use-pgtable-nopxd-instead-of-4level-fixup.patch
* parisc-hugetlb-use-pgtable-nopxd-instead-of-4level-fixup.patch
* sparc32-use-pgtable-nopud-instead-of-4level-fixup.patch
* um-remove-unused-pxx_offset_proc-and-addr_pte-functions.patch
* um-add-support-for-folded-p4d-page-tables.patch
* mm-remove-__arch_has_4level_hack-and-include-asm-generic-4level-fixuph.patch
* kernelh-update-comment-about-simple_strtofoo-functions.patch
* auxdisplay-charlcd-deduplicate-simple_strtoul.patch
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
