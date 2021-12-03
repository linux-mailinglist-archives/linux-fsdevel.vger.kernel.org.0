Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC22466EEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 02:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349900AbhLCBIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 20:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349860AbhLCBIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:08:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6F7C06174A;
        Thu,  2 Dec 2021 17:05:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C9CE62919;
        Fri,  3 Dec 2021 01:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CB5C00446;
        Fri,  3 Dec 2021 01:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638493517;
        bh=UlyW0kOTuPTsykiXZ9DLvoS0KF1/wmSSWOJResJrr0c=;
        h=Date:From:To:Subject:From;
        b=lo7PYhjWxyQB8Z1WkeebSp8xmI/7DpJsr0smI5AbyAcCM1EanSMipQcwyRy26RmJd
         9AiOfviNEjnWmOUYQjUJeOsHmWOmse4KaGaGDSt8hyePQqgAuYq0B3/ivBHIYZPeNr
         uFWtYflgAWXcTSUFm0biQNn7/aybdj2DzkrQS9Sc=
Date:   Thu, 02 Dec 2021 17:05:16 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-12-02-17-04 uploaded
Message-ID: <20211203010516.HJH82Eku8%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-12-02-17-04 has been uploaded to

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



This mmotm tree contains the following patches against 5.16-rc3:
(patches marked "*" will be included in linux-next)

* mm-fix-panic-in-__alloc_pages.patch
* mm-bdi-initialize-bdi_min_ratio-when-bdi-unregister.patch
* mm-bdi-initialize-bdi_min_ratio-when-bdi-unregister-fix.patch
* increase-default-mlock_limit-to-8-mib.patch
* maintainers-update-kdump-maintainers.patch
* mailmap-update-email-address-for-guo-ren.patch
* filemap-remove-pagehwpoison-check-from-next_uptodate_page.patch
* timers-implement-usleep_idle_range.patch
* mm-damon-core-fix-fake-load-reports-due-to-uninterruptible-sleeps.patch
* mm-damon-core-use-better-timer-mechanisms-selection-threshold.patch
* mm-damon-dbgfs-remove-an-unnecessary-error-message.patch
* mm-damon-core-remove-unnecessary-error-messages.patch
* mm-damon-vaddr-remove-an-unnecessary-warning-message.patch
* mm-damon-vaddr-test-split-a-test-function-having-1024-bytes-frame-size.patch
* mm-damon-vaddr-test-remove-unnecessary-variables.patch
* selftests-damon-skip-test-if-damon-is-running.patch
* selftests-damon-test-damon-enabling-with-empty-target_ids-case.patch
* selftests-damon-test-wrong-damos-condition-ranges-input.patch
* selftests-damon-test-debugfs-file-reads-writes-with-huge-count.patch
* selftests-damon-split-test-cases.patch
* mm-slub-fix-endianness-bug-for-alloc-free_traces-attributes.patch
* shmem-fix-a-race-between-shmem_unused_huge_shrink-and-shmem_evict_inode.patch
* shmem-fix-a-race-between-shmem_unused_huge_shrink-and-shmem_evict_inode-checkpatch-fixes.patch
* mm-memcg-relocate-mod_objcg_mlstate-get_obj_stock-and-put_obj_stock.patch
* hugetlbfs-fix-issue-of-preallocation-of-gigantic-pages-cant-work.patch
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
* scripts-spellingtxt-add-oveflow.patch
* squashfs-provides-backing_dev_info-in-order-to-disable-read-ahead.patch
* ocfs2-use-bug_on-instead-of-if-condition-followed-by-bug.patch
* ocfs2-reflink-deadlock-when-clone-file-to-the-same-directory-simultaneously.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* fs-ioctl-remove-unnecessary-__user-annotation.patch
  mm.patch
* mm-slab_common-use-warn-if-cache-still-has-objects-on-destroy.patch
* mm-slab-make-slab-iterator-functions-static.patch
* kmemleak-fix-kmemleak-false-positive-report-with-hw-tag-based-kasan-enable.patch
* kmemleak-fix-kmemleak-false-positive-report-with-hw-tag-based-kasan-enable-fix.patch
* mm-kmemleak-alloc-gray-object-for-reserved-region-with-direct-map.patch
* mm-defer-kmemleak-object-creation-of-module_alloc.patch
* mm-defer-kmemleak-object-creation-of-module_alloc-v4.patch
* mm-page_alloc-split-prep_compound_page-into-head-and-tail-subparts.patch
* mm-page_alloc-refactor-memmap_init_zone_device-page-init.patch
* mm-memremap-add-zone_device-support-for-compound-pages.patch
* device-dax-use-align-for-determining-pgoff.patch
* device-dax-use-struct_size.patch
* device-dax-ensure-dev_dax-pgmap-is-valid-for-dynamic-devices.patch
* device-dax-factor-out-page-mapping-initialization.patch
* device-dax-set-mapping-prior-to-vmf_insert_pfn_pmdpud.patch
* device-dax-remove-pfn-from-__dev_dax_ptepmdpud_fault.patch
* device-dax-remove-pfn-from-__dev_dax_ptepmdpud_fault-fix.patch
* device-dax-compound-devmap-support.patch
* kasan-test-add-globals-left-out-of-bounds-test.patch
* kasan-add-ability-to-detect-double-kmem_cache_destroy.patch
* kasan-test-add-test-case-for-double-kmem_cache_destroy.patch
* mmfs-split-dump_mapping-out-from-dump_page.patch
* tools-vm-page_owner_sortc-sort-by-stacktrace-before-culling.patch
* tools-vm-page_owner_sortc-sort-by-stacktrace-before-culling-fix.patch
* tools-vm-page_owner_sortc-support-sorting-by-stack-trace.patch
* tools-vm-page_owner_sortc-add-switch-between-culling-by-stacktrace-and-txt.patch
* gup-avoid-multiple-user-access-locking-unlocking-in-fault_in_read-writeable.patch
* mm-shmem-dont-truncate-page-if-memory-failure-happens.patch
* mm-shmem-dont-truncate-page-if-memory-failure-happens-checkpatch-fixes.patch
* mm-mempool-use-non-atomic-__set_bit-when-possible.patch
* mm-memcontrol-make-cgroup_memory_nokmem-static.patch
* mm-page_counter-remove-an-incorrect-call-to-propagate_protected_usage.patch
* memcg-better-bounds-on-the-memcg-stats-updates.patch
* selftests-vm-use-swap-to-make-code-cleaner.patch
* mm-remove-redundant-check-about-fault_flag_allow_retry-bit.patch
* mm-remove-redundant-check-about-fault_flag_allow_retry-bit-checkpatch-fixes.patch
* mm-rearrange-madvise-code-to-allow-for-reuse.patch
* mm-add-a-field-to-store-names-for-private-anonymous-memory.patch
* mm-add-a-field-to-store-names-for-private-anonymous-memory-fix.patch
* mm-add-anonymous-vma-name-refcounting.patch
* mm-ptep_clear-page-table-helper.patch
* mm-page-table-check.patch
* mm-page-table-check-fix.patch
* x86-mm-add-x86_64-support-for-page-table-check.patch
* mm-protect-free_pgtables-with-mmap_lock-write-lock-in-exit_mmap.patch
* mm-oom_kill-allow-process_mrelease-to-run-under-mmap_lock-protection.patch
* mm-vmalloc-alloc-gfp_nofsio-for-vmalloc.patch
* mm-vmalloc-add-support-for-__gfp_nofail.patch
* mm-vmalloc-be-more-explicit-about-supported-gfp-flags.patch
* mm-allow-gfp_kernel-allocations-for-kvmalloc.patch
* mm-make-slab-and-vmalloc-allocators-__gfp_nolockdep-aware.patch
* mm-discard-__gfp_atomic.patch
* mm-introduce-memalloc_retry_wait.patch
* sysctl-change-watermark_scale_factor-max-limit-to-30%.patch
* mm-fix-boolreturncocci-warning.patch
* mm-page_alloc-fix-building-error-on-werror=array-compare.patch
* mm-drop-node-from-alloc_pages_vma.patch
* hugetlb-add-hugetlbnuma_stat-file.patch
* hugetlb-add-hugetlbnuma_stat-file-fix.patch
* mm-hugetlb-free-the-2nd-vmemmap-page-associated-with-each-hugetlb-page.patch
* mm-hugetlb-replace-hugetlb_free_vmemmap_enabled-with-a-static_key.patch
* mm-sparsemem-use-page-table-lock-to-protect-kernel-pmd-operations.patch
* selftests-vm-add-a-hugetlb-test-case.patch
* mm-sparsemem-move-vmemmap-related-to-hugetlb-to-config_hugetlb_page_free_vmemmap.patch
* mm-hugepages-make-memory-size-variable-in-hugepage-mremap-selftest.patch
* selftests-uffd-allow-eintr-eagain.patch
* vmscan-make-drop_slab_node-static.patch
* mm-mempolicy-use-policy_node-helper-with-mpol_preferred_many.patch
* mm-mempolicy-add-set_mempolicy_home_node-syscall.patch
* mm-mempolicy-wire-up-syscall-set_mempolicy_home_node.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt-fix.patch
* mm-migrate-fix-the-return-value-of-migrate_pages.patch
* mm-migrate-correct-the-hugetlb-migration-stats.patch
* mm-migrate-correct-the-hugetlb-migration-stats-fix.patch
* mm-compaction-fix-the-migration-stats-in-trace_mm_compaction_migratepages.patch
* mm-migratec-rework-migration_entry_wait-to-not-take-a-pageref.patch
* mm-migrate-support-multiple-target-nodes-demotion.patch
* mm-migrate-add-more-comments-for-selecting-target-node-randomly.patch
* mm-ksm-fix-use-after-free-kasan-report-in-ksm_might_need_to_copy.patch
* mm-hwpoison-mf_mutex-for-soft-offline-and-unpoison.patch
* mm-hwpoison-remove-mf_msg_buddy_2nd-and-mf_msg_poisoned_huge.patch
* mm-hwpoison-fix-unpoison_memory.patch
* mm-memcg-percpu-account-extra-objcg-space-to-memory-cgroups.patch
* mm-memcg-percpu-account-extra-objcg-space-to-memory-cgroups-fix.patch
* mm-rmap-convert-from-atomic_t-to-refcount_t-on-anon_vma-refcount.patch
* mm-rmap-fix-potential-batched-tlb-flush-race.patch
* mm-rmap-fix-potential-batched-tlb-flush-race-fix.patch
* zsmalloc-introduce-some-helper-functions.patch
* zsmalloc-rename-zs_stat_type-to-class_stat_type.patch
* zsmalloc-decouple-class-actions-from-zspage-works.patch
* zsmalloc-introduce-obj_allocated.patch
* zsmalloc-move-huge-compressed-obj-from-page-to-zspage.patch
* zsmalloc-remove-zspage-isolation-for-migration.patch
* locking-rwlocks-introduce-write_lock_nested.patch
* locking-rwlocks-introduce-write_lock_nested-fix.patch
* locking-rwlocks-introduce-write_lock_nested-fix-2.patch
* zsmalloc-replace-per-zpage-lock-with-pool-migrate_lock.patch
* zsmalloc-replace-get_cpu_var-with-local_lock.patch
* mm-introduce-fault_in_exact_writeable-to-probe-for-sub-page-faults.patch
* arm64-add-support-for-sub-page-faults-user-probing.patch
* btrfs-avoid-live-lock-in-search_ioctl-on-hardware-with-sub-page-faults.patch
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
* mm-damon-move-damon_rand-definition-into-damonh.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-vmcore-dont-fake-reading-zeroes-on-surprise-vmcore_cb-unregistration.patch
* proc-make-the-proc_create-stubs-static-inlines.patch
* proc-make-the-proc_create-stubs-static-inlines-fix.patch
* proc-make-the-proc_create-stubs-static-inlines-fix2.patch
* proc-sysctl-make-protected_-world-readable.patch
* fs-exec-replace-strlcpy-with-strscpy_pad-in-__set_task_comm.patch
* fs-exec-replace-strncpy-with-strscpy_pad-in-__get_task_comm.patch
* drivers-infiniband-replace-open-coded-string-copy-with-get_task_comm.patch
* fs-binfmt_elf-replace-open-coded-string-copy-with-get_task_comm.patch
* samples-bpf-test_overhead_kprobe_kern-replace-bpf_probe_read_kernel-with-bpf_probe_read_kernel_str-to-get-task-comm.patch
* tools-bpf-bpftool-skeleton-replace-bpf_probe_read_kernel-with-bpf_probe_read_kernel_str-to-get-task-comm.patch
* tools-testing-selftests-bpf-replace-open-coded-16-with-task_comm_len.patch
* kthread-dynamically-allocate-memory-to-store-kthreads-full-name.patch
* kstrtox-uninline-everything.patch
* list-introduce-list_is_head-helper-and-re-use-it-in-listh.patch
* lz4-fix-lz4_decompress_safe_partial-read-out-of-bound.patch
* checkpatch-relax-regexp-for-commit_log_long_line.patch
* checkpatch-improve-kconfig-help-test.patch
* const_structscheckpatch-add-frequently-used-ops-structs.patch
* fs-binfmt_elf-fix-at_phdr-for-unusual-elf-files.patch
* elf-fix-overflow-in-total-mapping-size-calculation.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* hfsplus-use-struct_group_attr-for-memcpy-region.patch
* panic-use-error_report_end-tracepoint-on-warnings.patch
* panic-use-error_report_end-tracepoint-on-warnings-fix.patch
* delayacct-support-swapin-delay-accounting-for-swapping-without-blkio.patch
* delayacct-fix-incomplete-disable-operation-when-switch-enable-to-disable.patch
* delayacct-cleanup-flags-in-struct-task_delay_info-and-functions-use-it.patch
* configs-introduce-debugconfig-for-ci-like-setup.patch
* arch-kconfig-split-page_size_less_than_256kb-from-page_size_less_than_64kb.patch
* btrfs-use-generic-kconfig-option-for-256kb-page-size-limit.patch
* lib-kconfigdebug-make-test_kmod-depend-on-page_size_less_than_256kb.patch
  linux-next.patch
* sysctl-add-a-new-register_sysctl_init-interface.patch
* sysctl-move-some-boundary-constants-from-sysctlc-to-sysctl_vals.patch
* sysctl-move-some-boundary-constants-from-sysctlc-to-sysctl_vals-fix.patch
* hung_task-move-hung_task-sysctl-interface-to-hung_taskc.patch
* watchdog-move-watchdog-sysctl-interface-to-watchdogc.patch
* sysctl-make-ngroups_max-const.patch
* sysctl-use-const-for-typically-used-max-min-proc-sysctls.patch
* sysctl-use-sysctl_zero-to-replace-some-static-int-zero-uses.patch
* aio-move-aio-sysctl-to-aioc.patch
* dnotify-move-dnotify-sysctl-to-dnotifyc.patch
* hpet-simplify-subdirectory-registration-with-register_sysctl.patch
* i915-simplify-subdirectory-registration-with-register_sysctl.patch
* macintosh-mac_hidc-simplify-subdirectory-registration-with-register_sysctl.patch
* ocfs2-simplify-subdirectory-registration-with-register_sysctl.patch
* test_sysctl-simplify-subdirectory-registration-with-register_sysctl.patch
* inotify-simplify-subdirectory-registration-with-register_sysctl.patch
* inotify-simplify-subdirectory-registration-with-register_sysctl-fix.patch
* cdrom-simplify-subdirectory-registration-with-register_sysctl.patch
* eventpoll-simplify-sysctl-declaration-with-register_sysctl.patch
* firmware_loader-move-firmware-sysctl-to-its-own-files.patch
* firmware_loader-move-firmware-sysctl-to-its-own-files-fix.patch
* firmware_loader-move-firmware-sysctl-to-its-own-files-fix-fix.patch
* firmware_loader-move-firmware-sysctl-to-its-own-files-fix-3.patch
* random-move-the-random-sysctl-declarations-to-its-own-file.patch
* sysctl-add-helper-to-register-a-sysctl-mount-point.patch
* sysctl-add-helper-to-register-a-sysctl-mount-point-fix.patch
* fs-move-binfmt_misc-sysctl-to-its-own-file.patch
* printk-move-printk-sysctl-to-printk-sysctlc.patch
* scsi-sg-move-sg-big-buff-sysctl-to-scsi-sgc.patch
* stackleak-move-stack_erasing-sysctl-to-stackleakc.patch
* sysctl-share-unsigned-long-const-values.patch
* fs-move-inode-sysctls-to-its-own-file.patch
* fs-move-fs-stat-sysctls-to-file_tablec.patch
* fs-move-dcache-sysctls-to-its-own-file.patch
* sysctl-move-maxolduid-as-a-sysctl-specific-const.patch
* fs-move-shared-sysctls-to-fs-sysctlsc.patch
* fs-move-locking-sysctls-where-they-are-used.patch
* fs-move-namei-sysctls-to-its-own-file.patch
* fs-move-fs-execc-sysctls-into-its-own-file.patch
* fs-move-pipe-sysctls-to-is-own-file.patch
* sysctl-add-and-use-base-directory-declarer-and-registration-helper.patch
* sysctl-add-and-use-base-directory-declarer-and-registration-helper-fix.patch
* fs-move-namespace-sysctls-and-declare-fs-base-directory.patch
* kernel-sysctlc-rename-sysctl_init-to-sysctl_init_bases.patch
* printk-fix-build-warning-when-config_printk=n.patch
* fs-coredump-move-coredump-sysctls-into-its-own-file.patch
* kprobe-move-sysctl_kprobes_optimization-to-kprobesc.patch
* fs-proc-store-pde-data-into-inode-i_private.patch
* proc-remove-pde_data-completely.patch
* proc-remove-pde_data-completely-fix.patch
* lib-stackdepot-allow-optional-init-and-stack_table-allocation-by-kvmalloc.patch
* lib-stackdepot-allow-optional-init-and-stack_table-allocation-by-kvmalloc-fix.patch
* lib-stackdepot-allow-optional-init-and-stack_table-allocation-by-kvmalloc-fix-2.patch
* lib-stackdepot-allow-optional-init-and-stack_table-allocation-by-kvmalloc-fixup3.patch
* lib-stackdepot-always-do-filter_irq_stacks-in-stack_depot_save.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
