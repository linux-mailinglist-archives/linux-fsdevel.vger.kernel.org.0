Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B863CB06D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 03:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhGPBcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 21:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhGPBcw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:32:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0422C610C7;
        Fri, 16 Jul 2021 01:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626398997;
        bh=fraHR3YSZshs4PrO9MBTehbRnxUzPy1Tkbyi/avNNFY=;
        h=Date:From:To:Subject:From;
        b=ZANR2MWHg4oh1nLkFSaO57/K3NCN2VYlDgFUguXbhiqMp4DMbDpYHSiYH4u3hivRh
         T/juyX1qWL6C2UKNXLti634Ni1PxjKNnP9jQ4liPXcP2nlqq7G+0zAPJs1NKjXGcrD
         pXljgAdO+kS6kb3QDOMBSGSWhVWr7nYwLDTHSdwY=
Date:   Thu, 15 Jul 2021 18:29:56 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2021-07-15-18-29 uploaded
Message-ID: <20210716012956.QCXYl0cgg%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2021-07-15-18-29 has been uploaded to

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



This mmotm tree contains the following patches against 5.14-rc1:
(patches marked "*" will be included in linux-next)

  origin.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo.patch
* shm-skip-shm_destroy-if-task-ipc-namespace-was-changed.patch
* ipc-warn-if-trying-to-remove-ipc-object-which-is-absent.patch
* userfaultfd-do-not-untag-user-pointers.patch
* selftest-use-mmap-instead-of-posix_memalign-to-allocate-memory.patch
* kfence-defer-kfence_test_init-to-ensure-that-kunit-debugfs-is-created.patch
* kfence-move-the-size-check-to-the-beginning-of-__kfence_alloc.patch
* kfence-skip-all-gfp_zonemask-allocations.patch
* mm-call-flush_dcache_page-in-memcpy_to_page-and-memzero_page.patch
* mm-use-kmap_local_page-in-memzero_page.patch
* mm-page_alloc-fix-page_poison=1-init_on_alloc_default_on-interaction.patch
* memblock-make-for_each_mem_range-traverse-memblock_hotplug-regions.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* decouple-build-from-userspace-headers.patch
* decouple-build-from-userspace-headers-fix.patch
* ocfs2-remove-an-unnecessary-condition.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* lib-fix-bugoncocci-warnings.patch
  mm.patch
* mm-slub-fix-slub_debug-disablement-for-list-of-slabs.patch
* mm-debug_vm_pgtable-introduce-struct-vm_pgtable_debug.patch
* mm-debug_vm_pgtable-use-struct-vm_pgtable_debug-in-basic-tests.patch
* mm-debug_vm_pgtable-use-struct-vm_pgtable_debug-in-leaf-and-savewrite-tests.patch
* mm-debug_vm_pgtable-use-struct-vm_pgtable_debug-in-protnone-and-devmap-tests.patch
* mm-vm_debug_pgtable-use-struct-vm_pgtable_debug-in-soft_dirty-and-swap-tests.patch
* mm-debug_vm_pgtable-use-struct-vm_pgtable_debug-in-migration-and-thp-tests.patch
* mm-debug_vm_pgtable-use-struct-vm_pgtable_debug-in-pte-modifying-tests.patch
* mm-debug_vm_pgtable-use-struct-vm_pgtable_debug-in-pmd-modifying-tests.patch
* mm-vm_debug_pgtable-use-struct-vm_pgtable_debug-in-pud-modifying-tests.patch
* mm-debug_vm_pgtable-use-struct-vm_pgtable_debug-in-pgd-and-p4d-modifying-tests.patch
* mm-debug_vm_pgtable-remove-unused-code.patch
* mm-debug_vm_pgtable-fix-corrupted-page-flag.patch
* mm-mark-idle-page-tracking-as-broken.patch
* writeback-track-number-of-inodes-under-writeback.patch
* writeback-reliably-update-bandwidth-estimation.patch
* writeback-fix-bandwidth-estimate-for-spiky-workload.patch
* writeback-rename-domain_update_bandwidth.patch
* writeback-use-read_once-for-unlocked-reads-of-writeback-stats.patch
* mm-remove-irqsave-restore-locking-from-contexts-with-irqs-enabled.patch
* fs-drop_caches-fix-skipping-over-shadow-cache-inodes.patch
* fs-inode-count-invalidated-shadow-pages-in-pginodesteal.patch
* vfs-keep-inodes-with-page-cache-off-the-inode-shrinker-lru.patch
* fs-mm-fix-race-in-unlinking-swapfile.patch
* mm-memcg-add-mem_cgroup_disabled-checks-in-vmpressure-and-swap-related-functions.patch
* mm-memcg-inline-mem_cgroup_charge-uncharge-to-improve-disabled-memcg-config.patch
* mm-memcg-inline-swap-related-functions-to-improve-disabled-memcg-config.patch
* memcg-enable-accounting-for-pids-in-nested-pid-namespaces.patch
* memcg-switch-lruvec-stats-to-rstat.patch
* memcg-infrastructure-to-flush-memcg-stats.patch
* lazy-tlb-introduce-lazy-mm-refcount-helper-functions.patch
* lazy-tlb-introduce-lazy-mm-refcount-helper-functions-fix.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable-fix.patch
* lazy-tlb-allow-lazy-tlb-mm-refcounting-to-be-configurable-fix-2.patch
* lazy-tlb-shoot-lazies-a-non-refcounting-lazy-tlb-option.patch
* lazy-tlb-shoot-lazies-a-non-refcounting-lazy-tlb-option-fix.patch
* powerpc-64s-enable-mmu_lazy_tlb_shootdown.patch
* mmc-jz4740-remove-the-flush_kernel_dcache_page-call-in-jz4740_mmc_read_data.patch
* mmc-mmc_spi-replace-flush_kernel_dcache_page-with-flush_dcache_page.patch
* ps3disk-replace-flush_kernel_dcache_page-with-flush_dcache_page.patch
* scatterlist-replace-flush_kernel_dcache_page-with-flush_dcache_page.patch
* aacraid-remove-an-unused-include.patch
* mm-remove-flush_kernel_dcache_page.patch
* mm-sparse-pass-section_nr-to-section_mark_present.patch
* mm-sparse-pass-section_nr-to-find_memory_block.patch
* mm-sparse-remove-__section_nr-function.patch
* mm-sparse-set-section_nid_shift-to-6.patch
* avoid-a-warning-in-sparse-memory-support.patch
* mm-vmalloc-use-batched-page-requests-in-bulk-allocator.patch
* mm-vmalloc-remove-gfpflags_allow_blocking-check.patch
* lib-test_vmallocc-add-a-new-nr_pages-parameter.patch
* mm-vmalloc-fix-wrong-behavior-in-vread.patch
* mm-kasan-move-kasanfault-to-mm-kasan-reportc.patch
* mm-page_alloc-always-initialize-memory-map-for-the-holes.patch
* microblaze-simplify-pte_alloc_one_kernel.patch
* mm-introduce-memmap_alloc-to-unify-memory-map-allocation.patch
* memblock-stop-poisoning-raw-allocations.patch
* hugetlb-simplify-prep_compound_gigantic_page-ref-count-racing-code.patch
* hugetlb-drop-ref-count-earlier-after-page-allocation.patch
* hugetlb-before-freeing-hugetlb-page-set-dtor-to-appropriate-value.patch
* mm-vmscan-put-the-redirtied-madv_free-pages-back-to-anonymous-lru-list.patch
* mm-vmscan-remove-misleading-setting-to-sc-priority.patch
* mm-vmscan-remove-unneeded-return-value-of-kswapd_run.patch
* mm-vmscan-add-else-to-remove-check_pending-label.patch
* mm-numa-automatically-generate-node-migration-order.patch
* mm-migrate-update-node-demotion-order-on-hotplug-events.patch
* mm-migrate-enable-returning-precise-migrate_pages-success-count.patch
* mm-migrate-demote-pages-during-reclaim.patch
* mm-vmscan-add-page-demotion-counter.patch
* mm-vmscan-add-helper-for-querying-ability-to-age-anonymous-pages.patch
* mm-vmscan-consider-anonymous-pages-without-swap.patch
* mm-vmscan-never-demote-for-memcg-reclaim.patch
* mm-migrate-add-sysfs-interface-to-enable-reclaim-migration.patch
* mm-mempolicy-add-mpol_preferred_many-for-multiple-preferred-nodes.patch
* mm-memplicy-add-page-allocation-function-for-mpol_preferred_many-policy.patch
* mm-mempolicy-enable-page-allocation-for-mpol_preferred_many-for-general-cases.patch
* mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many.patch
* mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many-fix.patch
* mm-mempolicy-advertise-new-mpol_preferred_many.patch
* mm-mempolicy-unify-the-create-func-for-bind-interleave-prefer-many-policies.patch
* mm-thp-make-alloc_split_ptlocks-dependent-on-use_split_pte_ptlocks.patch
* selftests-vm-add-ksm-merge-test.patch
* selftests-vm-add-ksm-unmerge-test.patch
* selftests-vm-add-ksm-zero-page-merging-test.patch
* selftests-vm-add-ksm-merging-across-nodes-test.patch
* mm-vmstat-correct-some-wrong-comments.patch
* mm-vmstat-simplify-the-array-size-calculation.patch
* mm-vmstat-remove-unneeded-return-value.patch
* memory-hotplugrst-remove-locking-details-from-admin-guide.patch
* memory-hotplugrst-complete-admin-guide-overhaul.patch
* mm-remove-pfn_valid_within-and-config_holes_in_zone.patch
* mm-memory_hotplug-cleanup-after-removal-of-pfn_valid_within.patch
* mm-memory_hotplug-use-unsigned-long-for-pfn-in-zone_for_pfn_range.patch
* mm-memory_hotplug-remove-nid-parameter-from-arch_remove_memory.patch
* mm-memory_hotplug-remove-nid-parameter-from-remove_memory-and-friends.patch
* acpi-memhotplug-memory-resources-cannot-be-enabled-yet.patch
* mm-zsmallocc-close-race-window-between-zs_pool_dec_isolated-and-zs_unregister_migration.patch
* mm-zsmallocc-combine-two-atomic-ops-in-zs_pool_dec_isolated.patch
* mm-highmem-remove-deprecated-kmap_atomic.patch
* kfence-show-cpu-and-timestamp-in-alloc-free-info.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* fs-proc-kcorec-add-mmap-interface.patch
* proc-sysctl-make-protected_-world-readable.patch
* arch-kconfig-fix-spelling-mistake-seperate-separate.patch
* math-make-rational-tristate.patch
* math-rational_kunit_test-should-depend-on-rational-instead-of-selecting-it.patch
* lib-string-optimized-memcpy.patch
* lib-string-optimized-memmove.patch
* lib-string-optimized-memset.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_create_device_group.patch
* nilfs2-fix-null-pointer-in-nilfs_name_attr_release.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_create_name_group.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_delete_name_group.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_create_snapshot_group.patch
* nilfs2-fix-memory-leak-in-nilfs_sysfs_delete_snapshot_group.patch
* hfsplus-fix-out-of-bounds-warnings-in-__hfsplus_setxattr.patch
* pid-cleanup-the-stale-comment-mentioning-pidmap_init.patch
* selftests-memfd-remove-unused-variable.patch
  linux-next.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
