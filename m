Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E65F45668A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 00:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhKRXup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 18:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhKRXuo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:50:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 977FD615E3;
        Thu, 18 Nov 2021 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637279263;
        bh=/PpTA8Ztzws1iG2KXKvOte1u98F6v8LSb2XI+pEpruc=;
        h=Date:From:To:Subject:From;
        b=qZPOqQW1xAex6LcpNyN+DDe+ZVGa8kuD5UKNoNT3GFRnknSpdXNbMzE4ThxV6LuJI
         lo/43byxEpj4GHRynJe2GH77PyPGGCCIyi3UcaVZFnJNbkn+RD6V35RcXNd/oJvkso
         KugtK96Sb5tdLdH104DYmCRoHwsYKAPCfAq9W2KE=
Date:   Thu, 18 Nov 2021 15:47:43 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-11-18-15-47 uploaded
Message-ID: <20211118234743.-bgoWMQfK%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-11-18-15-47 has been uploaded to

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



This mmotm tree contains the following patches against 5.16-rc1:
(patches marked "*" will be included in linux-next)

  origin.patch
* hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list.patch
* ipc-warn-if-trying-to-remove-ipc-object-which-is-absent.patch
* shm-extend-forced-shm-destroy-to-support-objects-from-several-ipc-nses-simplified.patch
* mm-emit-the-free-trace-report-before-freeing-memory-in-kmem_cache_free.patch
* hexagon-export-raw-i-o-routines-for-modules.patch
* hexagon-clean-up-timer-regsh.patch
* hexagon-ignore-vmlinuxlds.patch
* mm-kmemleak-slob-respect-slab_noleaktrace-flag.patch
* hugetlb-fix-hugetlb-cgroup-refcounting-during-mremap.patch
* kasan-test-silence-intentional-read-overflow-warnings.patch
* mm-damon-dbgfs-use-__gfp_nowarn-for-user-specified-size-buffer-allocation.patch
* mm-damon-dbgfs-fix-missed-use-of-damon_dbgfs_lock.patch
* kmap_local-dont-assume-kmap-ptes-are-linear-arrays-in-memory.patch
* proc-vmcore-fix-clearing-user-buffer-by-properly-using-clear_user.patch
* mm-fix-panic-in-__alloc_pages.patch
* hugetlb-userfaultfd-fix-reservation-restore-on-userfaultfd-error.patch
* mm-bdi-initialize-bdi_min_ratio-when-bdi-unregister.patch
* mm-bdi-initialize-bdi_min_ratio-when-bdi-unregister-fix.patch
* increase-default-mlock_limit-to-8-mib.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
* kthread-add-the-helper-function-kthread_run_on_cpu.patch
* kthread-add-the-helper-function-kthread_run_on_cpu-fix.patch
* rdma-siw-make-use-of-the-helper-function-kthread_run_on_cpu.patch
* ring-buffer-make-use-of-the-helper-function-kthread_run_on_cpu.patch
* rcutorture-make-use-of-the-helper-function-kthread_run_on_cpu.patch
* trace-osnoise-make-use-of-the-helper-function-kthread_run_on_cpu.patch
* trace-hwlat-make-use-of-the-helper-function-kthread_run_on_cpu.patch
* ia64-module-use-swap-to-make-code-cleaner.patch
* ia64-use-swap-to-make-code-cleaner.patch
* ia64-fix-typo-in-a-comment.patch
* squashfs-provides-backing_dev_info-in-order-to-disable-read-ahead.patch
* ocfs2-use-bug_on-instead-of-if-condition-followed-by-bug.patch
* ocfs2-reflink-deadlock-when-clone-file-to-the-same-directory-simultaneously.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
  mm.patch
* mm-slab_common-use-warn-if-cache-still-has-objects-on-destroy.patch
* mm-slab-make-slab-iterator-functions-static.patch
* kmemleak-fix-kmemleak-false-positive-report-with-hw-tag-based-kasan-enable.patch
* kasan-test-add-globals-left-out-of-bounds-test.patch
* gup-avoid-multiple-user-access-locking-unlocking-in-fault_in_read-writeable.patch
* mm-shmem-dont-truncate-page-if-memory-failure-happens.patch
* mm-memcontrol-make-cgroup_memory_nokmem-static.patch
* mm-page_counter-remove-an-incorrect-call-to-propagate_protected_usage.patch
* memcg-better-bounds-on-the-memcg-stats-updates.patch
* mm-remove-redundant-check-about-fault_flag_allow_retry-bit.patch
* mm-remove-redundant-check-about-fault_flag_allow_retry-bit-checkpatch-fixes.patch
* mm-rearrange-madvise-code-to-allow-for-reuse.patch
* mm-add-a-field-to-store-names-for-private-anonymous-memory.patch
* mm-add-anonymous-vma-name-refcounting.patch
* mm-discard-__gfp_atomic.patch
* selftests-uffd-allow-eintr-eagain.patch
* vmscan-make-drop_slab_node-static.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt-fix.patch
* mm-migrate-fix-the-return-value-of-migrate_pages.patch
* mm-migrate-correct-the-hugetlb-migration-stats.patch
* mm-compaction-fix-the-migration-stats-in-trace_mm_compaction_migratepages.patch
* mm-migratec-rework-migration_entry_wait-to-not-take-a-pageref.patch
* mm-migrate-support-multiple-target-nodes-demotion.patch
* mm-hwpoison-mf_mutex-for-soft-offline-and-unpoison.patch
* mm-hwpoison-remove-mf_msg_buddy_2nd-and-mf_msg_poisoned_huge.patch
* mm-hwpoison-fix-unpoison_memory.patch
* mm-rmap-convert-from-atomic_t-to-refcount_t-on-anon_vma-refcount.patch
* zsmalloc-introduce-some-helper-functions.patch
* zsmalloc-rename-zs_stat_type-to-class_stat_type.patch
* zsmalloc-decouple-class-actions-from-zspage-works.patch
* zsmalloc-introduce-obj_allocated.patch
* zsmalloc-move-huge-compressed-obj-from-page-to-zspage.patch
* zsmalloc-remove-zspage-isolation-for-migration.patch
* locking-rwlocks-introduce-write_lock_nested.patch
* zsmalloc-replace-per-zpage-lock-with-pool-migrate_lock.patch
* zsmalloc-replace-get_cpu_var-with-local_lock.patch
* zram-use-attribute_groups.patch
* writeback-fix-some-comment-errors.patch
* mm-hmmc-allow-vm_mixedmap-to-work-with-hmm_range_fault.patch
* mm-damon-unified-access_check-function-naming-rules.patch
* mm-damon-add-age-of-region-tracepoint-support.patch
* mm-damon-core-using-function-abs-instead-of-diff_of.patch
* mm-damon-remove-some-no-need-func-definitions-in-damonh-file.patch
* mm-damon-remove-some-no-need-func-definitions-in-damonh-file-fix.patch
* mm-damon-vaddr-remove-swap_ranges-and-replace-it-with-swap.patch
* mm-damon-schemes-add-the-validity-judgment-of-thresholds.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-vmcore-dont-fake-reading-zeroes-on-surprise-vmcore_cb-unregistration.patch
* proc-make-the-proc_create-stubs-static-inlines.patch
* proc-sysctl-make-protected_-world-readable.patch
* kstrtox-uninline-everything.patch
* lz4-fix-lz4_decompress_safe_partial-read-out-of-bound.patch
* checkpatch-relax-regexp-for-commit_log_long_line.patch
* elf-fix-overflow-in-total-mapping-size-calculation.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* hfsplus-fix-out-of-bounds-warnings-in-__hfsplus_setxattr.patch
* panic-use-error_report_end-tracepoint-on-warnings.patch
* panic-use-error_report_end-tracepoint-on-warnings-fix.patch
* delayacct-support-swapin-delay-accounting-for-swapping-without-blkio.patch
* configs-introduce-debugconfig-for-ci-like-setup.patch
  linux-next.patch
  linux-next-git-rejects.patch
* fs-proc-store-pde-data-into-inode-i_private.patch
* fs-proc-replace-pde_datainode-with-inode-i_private.patch
* fs-proc-remove-pde_data.patch
* fs-proc-use-define_proc_show_attribute-to-simplify-the-code.patch
* lib-stackdepot-allow-optional-init-and-stack_table-allocation-by-kvmalloc.patch
* lib-stackdepot-allow-optional-init-and-stack_table-allocation-by-kvmalloc-fix.patch
* lib-stackdepot-allow-optional-init-and-stack_table-allocation-by-kvmalloc-fix-2.patch
* lib-stackdepot-allow-optional-init-and-stack_table-allocation-by-kvmalloc-fixup3.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
