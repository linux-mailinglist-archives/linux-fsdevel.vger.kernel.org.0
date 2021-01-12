Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD792F2C0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 10:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390224AbhALJ6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 04:58:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbhALJ6s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:58:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D4BD225AC;
        Tue, 12 Jan 2021 09:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610445487;
        bh=JxyPXiHLhuqdhf0kVrDG4ltxg+FDjMx75OjPSZAh0BA=;
        h=Date:From:To:Subject:From;
        b=WB9uKiF9Lzz4USZbgiwZ2bJbDdmxxg4KvqluLmpwtBGDcypBbZZAZviA/csyeW5jC
         MprcZUfaq9y5ZYwtbm3eHyIm/BTk1KkveDeCi69H35NQ1AoqXafRwmXS5WfI1P+5AI
         CRgK/mGzFc/m5GO/bEvPSfraaywnhOobHiUbVwu0=
Date:   Tue, 12 Jan 2021 01:58:06 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-01-12-01-57 uploaded
Message-ID: <20210112095806.I2Z6as5al%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-01-12-01-57 has been uploaded to

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



This mmotm tree contains the following patches against 5.11-rc3:
(patches marked "*" will be included in linux-next)

* mm-slub-consider-rest-of-partial-list-if-acquire_slab-fails.patch
* mm-page_alloc-add-a-missing-mm_page_alloc_zone_locked-tracepoint.patch
* mm-page_alloc-add-a-missing-mm_page_alloc_zone_locked-tracepoint-fix.patch
* x86-setup-dont-remove-e820_type_ram-for-pfn-0.patch
* mm-fix-initialization-of-struct-page-for-holes-in-memory-layout.patch
* mm-memcontrol-fix-warning-in-mem_cgroup_page_lruvec.patch
* mm-memcg-slab-optimize-objcg-stock-draining.patch
* mm-memcg-fix-memcg-file_dirty-numa-stat.patch
* mm-fix-numa-stats-for-thp-migration.patch
* kasan-fix-unaligned-address-is-unhandled-in-kasan_remove_zero_shadow.patch
* kasan-fix-incorrect-arguments-passing-in-kasan_add_zero_shadow.patch
* arm-kasan-fix-the-arry-size-of-kasan_early_shadow_pte.patch
* mm-vmallocc-fix-potential-memory-leak.patch
* mm-migrate-initialize-err-in-do_migrate_pages.patch
* mm-hugetlb-fix-potential-missing-huge-page-size-info.patch
* maintainers-add-myself-as-slab-allocators-maintainer.patch
* mmhwpoison-fix-printing-of-page-flags.patch
* mm-process_vm_accessc-include-compath.patch
* mm-hugetlbfs-fix-cannot-migrate-the-fallocated-hugetlb-page.patch
* mm-hugetlb-fix-a-race-between-freeing-and-dissolving-the-page.patch
* mm-hugetlb-fix-a-race-between-isolating-and-freeing-page.patch
* mm-hugetlb-remove-vm_bug_on_page-from-page_huge_active.patch
* proc_sysctl-fix-oops-caused-by-incorrect-command-parameters.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* ocfs2-remove-redundant-conditional-before-iput.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* ramfs-support-o_tmpfile.patch
* fs-delete-repeated-words-in-comments.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-tracing-record-slab-name-for-kmem_cache_free.patch
* mm-msync-exit-early-when-the-flags-is-an-ms_async-and-start-vm_start.patch
* mm-filemap-remove-unused-parameter-and-change-to-void-type-for-replace_page_cache_page.patch
* mm-filemap-dont-revert-iter-on-eiocbqueued.patch
* mm-swap-dont-setpageworkingset-unconditionally-during-swapin.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account-fix.patch
* mm-memcontrol-optimize-per-lruvec-stats-counter-memory-usage.patch
* mm-memcontrol-optimize-per-lruvec-stats-counter-memory-usage-checkpatch-fixes.patch
* mm-memcontrol-fix-nr_anon_thps-accounting-in-charge-moving.patch
* mm-memcontrol-convert-nr_anon_thps-account-to-pages.patch
* mm-memcontrol-convert-nr_file_thps-account-to-pages.patch
* mm-memcontrol-convert-nr_shmem_thps-account-to-pages.patch
* mm-memcontrol-convert-nr_shmem_pmdmapped-account-to-pages.patch
* mm-memcontrol-convert-nr_file_pmdmapped-account-to-pages.patch
* mm-memcontrol-make-the-slab-calculation-consistent.patch
* mm-memcg-revise-the-using-condition-of-lock_page_lruvec-function-series.patch
* mm-memcg-remove-rcu-locking-for-lock_page_lruvec-function-series.patch
* mm-memcg-add-swapcache-stat-for-memcg-v2.patch
* mm-kmem-make-__memcg_kmem_uncharge-static.patch
* mm-mmap-remove-unnecessary-local-variable.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-improve-mprotectrw-efficiency-on-pages-referenced-once.patch
* mm-page_reporting-use-list_entry_is_head-in-page_reporting_cycle.patch
* kasan-prefix-exported-functions-with-kasan_.patch
* kasan-clarify-hw_tags-impact-on-tbi.patch
* kasan-clean-up-comments-in-tests.patch
* kasan-add-match-all-tag-tests.patch
* kasan-arm64-allow-using-kunit-tests-with-hw_tags-mode.patch
* kasan-rename-config_test_kasan_module.patch
* kasan-add-compiler-barriers-to-kunit_expect_kasan_fail.patch
* kasan-adopt-kmalloc_uaf2-test-to-hw_tags-mode.patch
* kasan-fix-memory-corruption-in-kasan_bitops_tags-test.patch
* kasan-fix-bug-detection-via-ksize-for-hw_tags-mode.patch
* kasan-fix-bug-detection-via-ksize-for-hw_tags-mode-fix.patch
* kasan-add-proper-page-allocator-tests.patch
* kasan-remove-redundant-config-option.patch
* kasan-remove-redundant-config-option-v3.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* mm-hugetlb-fix-potential-double-free-in-hugetlb_register_node-error-path.patch
* mm-hugetlbc-fix-unnecessary-address-expansion-of-pmd-sharing.patch
* mm-migrate-do-not-migrate-hugetlb-page-whose-refcount-is-one.patch
* mm-hugetlb-add-return-eagain-for-dissolve_free_huge_page.patch
* mm-vmscan-__isolate_lru_page_prepare-clean-up.patch
* mm-compaction-remove-rcu_read_lock-during-page-compaction.patch
* mm-compaction-remove-duplicated-vm_bug_on_page-pagelocked.patch
* mm-hugetlb-change-hugetlb_reserve_pages-to-type-bool.patch
* hugetlbfs-remove-special-hugetlbfs_set_page_dirty.patch
* mm-make-pagecache-tagged-lookups-return-only-head-pages.patch
* mm-shmem-use-pagevec_lookup-in-shmem_unlock_mapping.patch
* mm-swap-optimise-get_shadow_from_swap_cache.patch
* mm-add-fgp_entry.patch
* mm-filemap-rename-find_get_entry-to-mapping_get_entry.patch
* mm-filemap-add-helper-for-finding-pages.patch
* mm-filemap-add-helper-for-finding-pages-fix.patch
* mm-filemap-add-mapping_seek_hole_data.patch
* mm-filemap-add-mapping_seek_hole_data-fix.patch
* iomap-use-mapping_seek_hole_data.patch
* mm-add-and-use-find_lock_entries.patch
* mm-add-and-use-find_lock_entries-fix.patch
* mm-add-an-end-parameter-to-find_get_entries.patch
* mm-add-an-end-parameter-to-pagevec_lookup_entries.patch
* mm-remove-nr_entries-parameter-from-pagevec_lookup_entries.patch
* mm-pass-pvec-directly-to-find_get_entries.patch
* mm-remove-pagevec_lookup_entries.patch
* mmthpshmem-limit-shmem-thp-alloc-gfp_mask.patch
* mmthpshm-limit-gfp-mask-to-no-more-than-specified.patch
* mmthpshmem-make-khugepaged-obey-tmpfs-mount-flags.patch
* mm-cma-allocate-cma-areas-bottom-up.patch
* mm-cma-allocate-cma-areas-bottom-up-fix.patch
* mm-cma-allocate-cma-areas-bottom-up-fix-2.patch
* mm-cma-allocate-cma-areas-bottom-up-fix-3.patch
* mm-cma-allocate-cma-areas-bottom-up-fix-3-fix.patch
* memblock-do-not-start-bottom-up-allocations-with-kernel_end.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
* mm-vmstatc-erase-latency-in-vmstat_shepherd.patch
* mm-zswap-clean-up-confusing-comment.patch
* mm-remove-arch_remap-and-mm-arch-hooksh.patch
* mm-page-flagsh-typo-fix-it-if.patch
* mm-add-kernel-electric-fence-infrastructure.patch
* mm-add-kernel-electric-fence-infrastructure-fix.patch
* mm-add-kernel-electric-fence-infrastructure-fix-2.patch
* mm-add-kernel-electric-fence-infrastructure-fix-3.patch
* mm-add-kernel-electric-fence-infrastructure-fix-4.patch
* x86-kfence-enable-kfence-for-x86.patch
* arm64-kfence-enable-kfence-for-arm64.patch
* kfence-use-pt_regs-to-generate-stack-trace-on-faults.patch
* mm-kfence-insert-kfence-hooks-for-slab.patch
* mm-kfence-insert-kfence-hooks-for-slub.patch
* kfence-kasan-make-kfence-compatible-with-kasan.patch
* kfence-kasan-make-kfence-compatible-with-kasan-fix.patch
* kfence-documentation-add-kfence-documentation.patch
* kfence-add-test-suite.patch
* kfence-add-test-suite-fix.patch
* kfence-add-test-suite-fix-2.patch
* maintainers-add-entry-for-kfence.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-wchan-use-printk-format-instead-of-lookup_symbol_name.patch
* sysctlc-fix-underflow-value-setting-risk-in-vm_table.patch
* proc-sysctl-make-protected_-world-readable.patch
* lib-genalloc-change-return-type-to-unsigned-long-for-bitmap_set_ll.patch
* lib-optimize-cpumask_local_spread.patch
* lib-optimize-cpumask_local_spread-v8.patch
* stringh-move-fortified-functions-definitions-in-a-dedicated-header.patch
* bitops-spelling-s-synomyn-synonym.patch
* checkpatch-improve-blank-line-after-declaration-test.patch
* checkpatch-ignore-warning-designated-initializers-using-nr_cpus.patch
* checkpatch-trivial-style-fixes.patch
* checkpatch-prefer-ftrace-over-function-entry-exit-printks.patch
* aio-simplify-read_events.patch
* scripts-gdb-fix-list_for_each.patch
  linux-next.patch
  linux-next-git-rejects.patch
* mm-add-definition-of-pmd_page_order.patch
* mmap-make-mlock_future_check-global.patch
* set_memory-allow-set_direct_map__noflush-for-multiple-pages.patch
* set_memory-allow-set_direct_map__noflush-for-multiple-pages-fix.patch
* set_memory-allow-querying-whether-set_direct_map_-is-actually-enabled.patch
* set_memory-allow-querying-whether-set_direct_map_-is-actually-enabled-fix.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix.patch
* secretmem-use-pmd-size-pages-to-amortize-direct-map-fragmentation.patch
* secretmem-add-memcg-accounting.patch
* pm-hibernate-disable-when-there-are-active-secretmem-users.patch
* arch-mm-wire-up-memfd_secret-system-call-were-relevant.patch
* arch-mm-wire-up-memfd_secret-system-call-were-relevant-fix.patch
* arch-mm-wire-up-memfd_secret-system-call-were-relevant-fix-fix.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2-fix.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
