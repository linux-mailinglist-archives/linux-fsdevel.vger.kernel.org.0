Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E7AE0EE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 02:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfJWAH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 20:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfJWAH4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:07:56 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF7D32084B;
        Wed, 23 Oct 2019 00:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571789275;
        bh=iWTiPNGy+UUhaAxufA2FQEzKoDPYx/bdR41aBLqfImo=;
        h=Date:From:To:Subject:From;
        b=zPVqh/RxADCB5UcG5acNZna1TJPQyOAt3cMimje8OtUYeHzhXyJ/hy84BrAw6c4WE
         /yxj0JcHe2JFf+BDsIdw6gt2Zblge1DBFYGbcPbFGr+YSryov2FkDaf1DiiH91W5Px
         joCiqXH35dx+MPAMzgpETZk9MWWDpbEo8EKhdmrE=
Date:   Tue, 22 Oct 2019 17:07:54 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2019-10-22-17-07 uploaded
Message-ID: <20191023000754.2M2KY%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2019-10-22-17-07 has been uploaded to

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



This mmotm tree contains the following patches against 5.4-rc4:
(patches marked "*" will be included in linux-next)

  origin.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mmthp-recheck-each-page-before-collapsing-file-thp.patch
* mmthp-recheck-each-page-before-collapsing-file-thp-v4.patch
* mm-memcontrol-fix-null-ptr-deref-in-percpu-stats-flush.patch
* mm-gup_benchmark-fix-map_hugetlb-case.patch
* mm-meminit-recalculate-pcpu-batch-and-high-limits-after-init-completes.patch
* mm-thp-handle-page-cache-thp-correctly-in-pagetranscompoundmap.patch
* ocfs2-protect-extent-tree-in-the-ocfs2_prepare_inode_for_write.patch
* ocfs2-protect-extent-tree-in-the-ocfs2_prepare_inode_for_write-checkpatch-fixes.patch
* ocfs2-remove-unused-function-ocfs2_prepare_inode_for_refcount.patch
* ocfs2-fix-passing-zero-to-ptr_err-warning.patch
* ramfs-support-o_tmpfile.patch
  mm.patch
* mm-slab-make-kmalloc_info-contain-all-types-of-names.patch
* mm-slab-remove-unused-kmalloc_size.patch
* mm-slab_common-use-enum-kmalloc_cache_type-to-iterate-over-kmalloc-caches.patch
* mm-slub-print-the-offset-of-fault-addresses.patch
* mm-update-comments-in-slubc.patch
* mm-gup-allow-cma-migration-to-propagate-errors-back-to-caller.patch
* mm-swap-disallow-swapon-on-zoned-block-devices.patch
* mm-swap-disallow-swapon-on-zoned-block-devices-fix.patch
* mm-trivial-mark_page_accessed-cleanup.patch
* mm-memcg-clean-up-reclaim-iter-array.patch
* mm-vmscan-expose-cgroup_ino-for-memcg-reclaim-tracepoints.patch
* mm-memcontrol-remove-dead-code-from-memory_max_write.patch
* mm-memcontrol-try-harder-to-set-a-new-memoryhigh.patch
* mm-fix-comments-based-on-per-node-memcg.patch
* mm-drop-mmap_sem-before-calling-balance_dirty_pages-in-write-fault.patch
* shmem-pin-the-file-in-shmem_fault-if-mmap_sem-is-dropped.patch
* mm-emit-tracepoint-when-rss-changes.patch
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
* mm-memory-failurec-clean-up-around-tk-pre-allocation.patch
* mm-soft-offline-convert-parameter-to-pfn.patch
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
* mm-vmalloc-remove-unnecessary-highmem_mask-from-parameter-of-gfpflags_allow_blocking.patch
* mm-vmalloc-remove-preempt_disable-enable-when-do-preloading.patch
* mm-vmalloc-respect-passed-gfp_mask-when-do-preloading.patch
* mm-vmalloc-add-more-comments-to-the-adjust_va_to_fit_type.patch
* selftests-vm-add-fragment-config_test_vmalloc.patch
* mm-vmalloc-rework-vmap_area_lock.patch
* mm-page_alloc-add-alloc_contig_pages.patch
* mm-pcp-share-common-code-between-memory-hotplug-and-percpu-sysctl-handler.patch
* mm-pcpu-make-zone-pcp-updates-and-reset-internal-to-the-mm.patch
* mm-vmscan-remove-unused-scan_control-parameter-from-pageout.patch
* z3fold-add-inter-page-compaction.patch
* z3fold-add-inter-page-compaction-fix.patch
* mm-support-memblock-alloc-on-the-exact-node-for-sparse_buffer_init.patch
* mm-oom-avoid-printk-iteration-under-rcu.patch
* mm-oom-avoid-printk-iteration-under-rcu-fix.patch
* hugetlbfs-hugetlb_fault_mutex_hash-cleanup.patch
* hugetlb-region_chg-provides-only-cache-entry.patch
* hugetlb-remove-duplicated-code.patch
* hugetlb-remove-duplicated-code-checkpatch-fixes.patch
* hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash.patch
* hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash-fix.patch
* hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash-fix-fix.patch
* mm-hugetlb-avoid-looping-to-the-same-hugepage-if-pages-and-vmas.patch
* mm-thp-do-not-queue-fully-unmapped-pages-for-deferred-split.patch
* mm-thp-make-set_huge_zero_page-return-void.patch
* mm-cmac-switch-to-bitmap_zalloc-for-cma-bitmap-allocation.patch
* mm-vmstat-add-helpers-to-get-vmstat-item-names-for-each-enum-type.patch
* mm-vmstat-do-not-use-size-of-vmstat_text-as-count-of-proc-vmstat-items.patch
* mm-memcontrol-use-vmstat-names-for-printing-statistics.patch
* mm-vmstat-reduce-zone-lock-hold-time-when-reading-proc-pagetypeinfo.patch
* userfaultfd-use-vma_pagesize-for-all-huge-page-size-calculation.patch
* userfaultfd-remove-unnecessary-warn_on-in-__mcopy_atomic_hugetlb.patch
* userfaultfd-wrap-the-common-dst_vma-check-into-an-inlined-function.patch
* uffd-wp-clear-vm_uffd_missing-or-vm_uffd_wp-during-userfaultfd_register.patch
* mm-shmemc-make-array-values-static-const-makes-object-smaller.patch
* mm-fix-struct-member-name-in-function-comments.patch
* mm-fix-typo-in-the-comment-when-calling-function-__setpageuptodate.patch
* mm-memory_hotplugc-remove-__online_page_set_limits.patch
* mm-annotate-refault-stalls-from-swap_readpage.patch
* mm-annotate-refault-stalls-from-swap_readpage-fix.patch
* mm-vmscan-remove-unused-lru_pages-argument.patch
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
* kernel-notifierc-intercepting-duplicate-registrations-to-avoid-infinite-loops.patch
* kernel-notifierc-remove-notifier_chain_cond_register.patch
* kernel-notifierc-remove-blocking_notifier_chain_cond_register.patch
* kernel-profile-use-cpumask_available-to-check-for-null-cpumask.patch
* hung_task-allow-printing-warnings-every-check-interval.patch
* get_maintainer-add-signatures-from-fixes-badcommit-lines-in-commit-message.patch
* string-add-stracpy-and-stracpy_pad-mechanisms.patch
* documentation-checkpatch-prefer-stracpy-strscpy-over-strcpy-strlcpy-strncpy.patch
* lib-fix-possible-incorrect-result-from-rational-fractions-helper.patch
* checkpatch-improve-ignoring-camelcase-si-style-variants-like-ma.patch
* epoll-simplify-ep_poll_safewake-for-config_debug_lock_alloc.patch
* fs-epoll-remove-unnecessary-wakeups-of-nested-epoll.patch
* selftests-add-epoll-selftests.patch
* elf-delete-unused-interp_map_addr-argument.patch
* elf-extract-elf_read-function.patch
* uaccess-disallow-int_max-copy-sizes.patch
* aio-simplify-read_events.patch
* lib-ubsan-dont-seralize-ubsan-report.patch
* smp_mb__beforeafter_atomic-update-documentation.patch
* ipc-mqueuec-remove-duplicated-code.patch
* ipc-mqueuec-update-document-memory-barriers.patch
* ipc-msgc-update-and-document-memory-barriers.patch
* ipc-semc-document-and-update-memory-barriers.patch
* ipc-consolidate-all-xxxctl_down-functions.patch
  linux-next.patch
  diff-sucks.patch
* drivers-block-null_blk_mainc-fix-layout.patch
* drivers-block-null_blk_mainc-fix-uninitialized-var-warnings.patch
* pinctrl-fix-pxa2xxc-build-warnings.patch
* lib-list-test-add-a-test-for-the-list-doubly-linked-list.patch
* lib-list-test-add-a-test-for-the-list-doubly-linked-list-v3.patch
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
* gpio-pca953x-tight-up-indentation.patch
* cleanup-replace-prefered-with-preferred.patch
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
