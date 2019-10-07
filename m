Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF8CDAE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 06:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfJGEMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 00:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfJGEMt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 00:12:49 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B995320656;
        Mon,  7 Oct 2019 04:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570421568;
        bh=NvJ8bTWepqmevLrYGwD+hBTZmbey9o2QVAaex2Uvh7Q=;
        h=Date:From:To:Subject:From;
        b=FQSAYS/n7lGIYqvc1rGIO8KTEiZlP1u+4kPIaSVIQyGm8h+RJ3GTWuLUC7SLWwji+
         Mmi3Sufr7j8kBinzl8+PkgwQySpW+iNHNQGytNH2xN4xM2GeadgJFrQMHxTFrbO16c
         vDB1wurBTQIzzpZoecxBaRBqTHFYMtbXTIdZeHJQ=
Date:   Sun, 06 Oct 2019 21:12:47 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2019-10-06-21-12 uploaded
Message-ID: <20191007041247.SC6Ovr6OU%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2019-10-06-21-12 has been uploaded to

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


This mmotm tree contains the following patches against 5.4-rc2:
(patches marked "*" will be included in linux-next)

* ocfs2-clear-zero-in-unaligned-direct-io.patch
* fs-ocfs2-fix-possible-null-pointer-dereferences-in-ocfs2_xa_prepare_entry.patch
* fs-ocfs2-fix-a-possible-null-pointer-dereference-in-ocfs2_write_end_nolock.patch
* fs-ocfs2-fix-a-possible-null-pointer-dereference-in-ocfs2_info_scan_inode_alloc.patch
* panic-ensure-preemption-is-disabled-during-panic.patch
* mm-memremap-drop-unused-section_size-and-section_mask.patch
* writeback-fix-use-after-free-in-finish_writeback_work.patch
* mm-fix-wmissing-prototypes-warnings.patch
* memcg-only-record-foreign-writebacks-with-dirty-pages-when-memcg-is-not-disabled.patch
* kernel-sysctlc-do-not-override-max_threads-provided-by-userspace.patch
* z3fold-claim-page-in-the-beginning-of-free.patch
* mm-page_alloc-fix-a-crash-in-free_pages_prepare.patch
* mm-vmpressure-fix-a-signedness-bug-in-vmpressure_register_event.patch
* mm-proportional-memorylowmin-reclaim.patch
* mm-make-memoryemin-the-baseline-for-utilisation-determination.patch
* mm-make-memoryemin-the-baseline-for-utilisation-determination-fix.patch
* mm-slb-improve-memory-accounting.patch
* mm-slb-guarantee-natural-alignment-for-kmallocpower-of-two.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mm-page_owner-fix-off-by-one-error-in-__set_page_owner_handle.patch
* mm-page_owner-decouple-freeing-stack-trace-from-debug_pagealloc.patch
* mm-page_owner-rename-flag-indicating-that-page-is-allocated.patch
* kmemleak-do-not-corrupt-the-object_list-during-clean-up.patch
* mm-slub-fix-a-deadlock-in-show_slab_objects.patch
* lib-generic-radix-treec-add-kmemleak-annotations.patch
* genalloc-fix-a-set-of-docs-build-warnings.patch
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
* mm-memcg-clean-up-reclaim-iter-array.patch
* mm-vmscan-get-number-of-pages-on-the-lru-list-in-memcgroup-base-on-lru_zone_size.patch
* mm-vmscan-expose-cgroup_ino-for-memcg-reclaim-tracepoints.patch
* mm-drop-mmap_sem-before-calling-balance_dirty_pages-in-write-fault.patch
* shmem-pin-the-file-in-shmem_fault-if-mmap_sem-is-dropped.patch
* mm-emit-tracepoint-when-rss-changes.patch
* mm-mmapc-remove-a-never-trigger-warning-in-__vma_adjust.patch
* mm-pgmap-use-correct-alignment-when-looking-at-first-pfn-from-a-region.patch
* mm-pgmap-use-correct-alignment-when-looking-at-first-pfn-from-a-region-checkpatch-fixes.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-rmapc-reuse-mergeable-anon_vma-as-parent-when-fork.patch
* mm-rmapc-reuse-mergeable-anon_vma-as-parent-when-fork-fix.patch
* mm-swap-piggyback-lru_add_drain_all-calls.patch
* mm-mmapc-prev-could-be-retrieved-from-vma-vm_prev.patch
* mm-mmapc-__vma_unlink_prev-is-not-necessary-now.patch
* mm-mmapc-extract-__vma_unlink_list-as-counter-part-for-__vma_link_list.patch
* mm-hotplug-reorder-memblock_-calls-in-try_remove_memory.patch
* memory_hotplug-add-a-bounds-check-to-__add_pages.patch
* mm-memory_hotplug-export-generic_online_page.patch
* hv_balloon-use-generic_online_page.patch
* mm-memory_hotplug-remove-__online_page_free-and-__online_page_increment_counters.patch
* mm-memunmap-dont-access-uninitialized-memmap-in-memunmap_pages.patch
* mm-memmap_init-update-variable-name-in-memmap_init_zone.patch
* mm-memory_hotplug-dont-access-uninitialized-memmaps-in-shrink_pgdat_span.patch
* mm-memory_hotplug-dont-access-uninitialized-memmaps-in-shrink_zone_span.patch
* mm-memory_hotplug-shrink-zones-when-offlining-memory.patch
* mm-memory_hotplug-poison-memmap-in-remove_pfn_range_from_zone.patch
* mm-memory_hotplug-we-always-have-a-zone-in-find_smallestbiggest_section_pfn.patch
* mm-memory_hotplug-dont-check-for-all-holes-in-shrink_zone_span.patch
* mm-memory_hotplug-drop-local-variables-in-shrink_zone_span.patch
* mm-memory_hotplug-cleanup-__remove_pages.patch
* mm-vmalloc-remove-unnecessary-highmem_mask-from-parameter-of-gfpflags_allow_blocking.patch
* selftests-vm-add-fragment-config_test_vmalloc.patch
* mm-vmscan-remove-unused-scan_control-parameter-from-pageout.patch
* z3fold-add-inter-page-compaction.patch
* mm-support-memblock-alloc-on-the-exact-node-for-sparse_buffer_init.patch
* mm-oom-avoid-printk-iteration-under-rcu.patch
* mm-oom-avoid-printk-iteration-under-rcu-fix.patch
* hugetlbfs-hugetlb_fault_mutex_hash-cleanup.patch
* hugetlb-region_chg-provides-only-cache-entry.patch
* hugetlb-remove-duplicated-code.patch
* hugetlb-remove-duplicated-code-checkpatch-fixes.patch
* hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash.patch
* hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash-fix.patch
* mm-hugetlb-avoid-looping-to-the-same-hugepage-if-pages-and-vmas.patch
* mm-thp-do-not-queue-fully-unmapped-pages-for-deferred-split.patch
* mm-thp-make-set_huge_zero_page-return-void.patch
* mm-cmac-switch-to-bitmap_zalloc-for-cma-bitmap-allocation.patch
* mm-export-cma-alloc-and-release.patch
* userfaultfd-use-vma_pagesize-for-all-huge-page-size-calculation.patch
* userfaultfd-remove-unnecessary-warn_on-in-__mcopy_atomic_hugetlb.patch
* userfaultfd-wrap-the-common-dst_vma-check-into-an-inlined-function.patch
* uffd-wp-clear-vm_uffd_missing-or-vm_uffd_wp-during-userfaultfd_register.patch
* mm-shmemc-make-array-values-static-const-makes-object-smaller.patch
* mm-fix-struct-member-name-in-function-comments.patch
* mm-fix-typo-in-the-comment-when-calling-function-__setpageuptodate.patch
* mm-memory_hotplugc-remove-__online_page_set_limits.patch
* mm-vmscan-remove-unused-lru_pages-argument.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-change-nlink-under-proc_subdir_lock.patch
* proc-delete-useless-len-variable.patch
* proc-shuffle-struct-pde_opener.patch
* proc-fix-confusing-macro-arg-name.patch
* gitattributes-use-dts-diff-driver-for-dts-files.patch
* linux-build_bugh-change-type-to-int.patch
* linux-bitsh-add-compile-time-sanity-check-of-genmask-inputs.patch
* kernel-notifierc-intercepting-duplicate-registrations-to-avoid-infinite-loops.patch
* kernel-notifierc-remove-notifier_chain_cond_register.patch
* kernel-notifierc-remove-blocking_notifier_chain_cond_register.patch
* hung_task-allow-printing-warnings-every-check-interval.patch
* printf-add-support-for-printing-symbolic-error-codes.patch
* printf-add-support-for-printing-symbolic-error-codes-fix.patch
* get_maintainer-add-signatures-from-fixes-badcommit-lines-in-commit-message.patch
* lib-genallocc-export-symbol-addr_in_gen_pool.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr-fix.patch
* string-add-stracpy-and-stracpy_pad-mechanisms.patch
* documentation-checkpatch-prefer-stracpy-strscpy-over-strcpy-strlcpy-strncpy.patch
* lib-fix-possible-incorrect-result-from-rational-fractions-helper.patch
* epoll-simplify-ep_poll_safewake-for-config_debug_lock_alloc.patch
* elf-delete-unused-interp_map_addr-argument.patch
* elf-extract-elf_read-function.patch
* uaccess-disallow-int_max-copy-sizes.patch
* aio-simplify-read_events.patch
* lib-ubsan-dont-seralize-ubsan-report.patch
* ipc-consolidate-all-xxxctl_down-functions.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
  diff-sucks.patch
* samples-watch_queue-watch_test-fix-build.patch
* pinctrl-fix-pxa2xxc-build-warnings.patch
* hacking-group-sysrq-kgdb-ubsan-into-generic-kernel-debugging-instruments.patch
* hacking-create-submenu-for-arch-special-debugging-options.patch
* hacking-group-kernel-data-structures-debugging-together.patch
* hacking-move-kernel-testing-and-coverage-options-to-same-submenu.patch
* hacking-move-oops-into-lockups-and-hangs.patch
* hacking-move-sched_stack_end_check-after-debug_stack_usage.patch
* hacking-create-a-submenu-for-scheduler-debugging-options.patch
* hacking-move-debug_bugverbose-to-printk-and-dmesg-options.patch
* hacking-move-debug_fs-to-generic-kernel-debugging-instruments.patch
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
