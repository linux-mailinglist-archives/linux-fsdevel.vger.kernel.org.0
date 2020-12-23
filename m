Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6F72E17FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 05:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgLWEIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 23:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgLWEIk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 23:08:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A55B820684;
        Wed, 23 Dec 2020 04:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1608696478;
        bh=VoYwfOHgwmDRwuDT0OC/ybvsQwdpdMYkfWUCsJ0bPQQ=;
        h=Date:From:To:Subject:From;
        b=iwpTQ9Nc4DKw8qZxmK19mY3tl1eI7CaVdBNksQyuvoAMWRZKRJnVUgeYtEtwZS6wh
         2RwJqX1U9g40UNtjwkxsORI2MGscRnKW6KCl3N7+af+WJIt49iR8Dkuk7xgOL03nBz
         7sxQwj1G9ykhrtdOU7qkVgGgAN5I0psQSyJHhv6Q=
Date:   Tue, 22 Dec 2020 20:07:58 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2020-12-22-20-07 uploaded
Message-ID: <20201223040758.JfBpb%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.10
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-12-22-20-07 has been uploaded to

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



This mmotm tree contains the following patches against 5.10:
(patches marked "*" will be included in linux-next)

  origin.patch
* kasan-drop-unnecessary-gpl-text-from-comment-headers.patch
* kasan-kasan_vmalloc-depends-on-kasan_generic.patch
* kasan-group-vmalloc-code.patch
* kasan-shadow-declarations-only-for-software-modes.patch
* kasan-rename-unpoison_shadow-to-unpoison_range.patch
* kasan-rename-kasan_shadow_-to-kasan_granule_.patch
* kasan-only-build-initc-for-software-modes.patch
* kasan-split-out-shadowc-from-commonc.patch
* kasan-define-kasan_memory_per_shadow_page.patch
* kasan-rename-report-and-tags-files.patch
* kasan-dont-duplicate-config-dependencies.patch
* kasan-hide-invalid-free-check-implementation.patch
* kasan-decode-stack-frame-only-with-kasan_stack_enable.patch
* kasan-arm64-only-init-shadow-for-software-modes.patch
* kasan-arm64-only-use-kasan_depth-for-software-modes.patch
* kasan-arm64-move-initialization-message.patch
* kasan-arm64-rename-kasan_init_tags-and-mark-as-__init.patch
* kasan-rename-addr_has_shadow-to-addr_has_metadata.patch
* kasan-rename-print_shadow_for_address-to-print_memory_metadata.patch
* kasan-rename-shadow-layout-macros-to-meta.patch
* kasan-separate-metadata_fetch_row-for-each-mode.patch
* kasan-introduce-config_kasan_hw_tags.patch
* arm64-enable-armv85-a-asm-arch-option.patch
* arm64-mte-add-in-kernel-mte-helpers.patch
* arm64-mte-reset-the-page-tag-in-page-flags.patch
* arm64-mte-add-in-kernel-tag-fault-handler.patch
* arm64-kasan-allow-enabling-in-kernel-mte.patch
* arm64-mte-convert-gcr_user-into-an-exclude-mask.patch
* arm64-mte-switch-gcr_el1-in-kernel-entry-and-exit.patch
* kasan-mm-untag-page-address-in-free_reserved_area.patch
* arm64-kasan-align-allocations-for-hw_tags.patch
* arm64-kasan-add-arch-layer-for-memory-tagging-helpers.patch
* kasan-define-kasan_granule_size-for-hw_tags.patch
* kasan-x86-s390-update-undef-config_kasan.patch
* kasan-arm64-expand-config_kasan-checks.patch
* kasan-arm64-implement-hw_tags-runtime.patch
* kasan-arm64-print-report-from-tag-fault-handler.patch
* kasan-mm-reset-tags-when-accessing-metadata.patch
* kasan-arm64-enable-config_kasan_hw_tags.patch
* kasan-add-documentation-for-hardware-tag-based-mode.patch
* kselftest-arm64-check-gcr_el1-after-context-switch.patch
* kasan-simplify-quarantine_put-call-site.patch
* kasan-rename-get_alloc-free_info.patch
* kasan-introduce-set_alloc_info.patch
* kasan-arm64-unpoison-stack-only-with-config_kasan_stack.patch
* kasan-allow-vmap_stack-for-hw_tags-mode.patch
* kasan-remove-__kasan_unpoison_stack.patch
* kasan-inline-kasan_reset_tag-for-tag-based-modes.patch
* kasan-inline-random_tag-for-hw_tags.patch
* kasan-open-code-kasan_unpoison_slab.patch
* kasan-inline-unpoison_range-and-check_invalid_free.patch
* kasan-add-and-integrate-kasan-boot-parameters.patch
* kasan-mm-check-kasan_enabled-in-annotations.patch
* kasan-mm-rename-kasan_poison_kfree.patch
* kasan-dont-round_up-too-much.patch
* kasan-simplify-assign_tag-and-set_tag-calls.patch
* kasan-clarify-comment-in-__kasan_kfree_large.patch
* kasan-sanitize-objects-when-metadata-doesnt-fit.patch
* kasan-mm-allow-cache-merging-with-no-metadata.patch
* kasan-update-documentation.patch
* mm-slub-call-account_slab_page-after-slab-page-initialization.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account.patch
* lib-zlib-fix-inflating-zlib-streams-on-s390.patch
* selftests-vm-fix-building-protection-keys-test.patch
* mm-hugetlb-fix-deadlock-in-hugetlb_cow-error-path.patch
* revert-kbuild-avoid-static_assert-for-genksyms.patch
* zlib-move-export_symbol-and-module_license-out-of-dfltcc_symsc.patch
* mm-mremap-fix-extent-calculation.patch
* mm-generalise-cow-smc-tlb-flushing-race-comment.patch
* mm-add-prototype-for-__add_to_page_cache_locked.patch
* mm-add-prototype-for-__add_to_page_cache_locked-fix.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-msync-exit-early-when-the-flags-is-an-ms_async-and-start-vm_start.patch
* mm-dont-setpageworkingset-unconditionally-during-swapin.patch
* mm-memcontrol-fix-nr_anon_thps-accounting-in-charge-moving.patch
* mm-memcontrol-convert-nr_anon_thps-account-to-pages.patch
* mm-memcontrol-convert-nr_file_thps-account-to-pages.patch
* mm-memcontrol-convert-nr_shmem_thps-account-to-pages.patch
* mm-memcontrol-convert-nr_shmem_pmdmapped-account-to-pages.patch
* mm-memcontrol-convert-nr_file_pmdmapped-account-to-pages.patch
* mm-memcontrol-make-the-slab-calculation-consistent.patch
* mm-memcg-revise-the-using-condition-of-lock_page_lruvec-function-series.patch
* mm-memcg-remove-rcu-locking-for-lock_page_lruvec-function-series.patch
* mm-mmap-remove-unnecessary-local-variable.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-page_reporting-use-list_entry_is_head-in-page_reporting_cycle.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* mm-vmscan-__isolate_lru_page_prepare-clean-up.patch
* mm-compaction-remove-rcu_read_lock-during-page-compaction.patch
* mm-memblock-enforce-overlap-of-memorymemblock-and-memoryreserved.patch
* mm-fix-initialization-of-struct-page-for-holes-in-memory-layout.patch
* mm-fix-initialization-of-struct-page-for-holes-in-memory-layout-checkpatch-fixes.patch
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
* memblock-do-not-start-bottom-up-allocations-with-kernel_end.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
* mm-zswap-clean-up-confusing-comment.patch
* mm-remove-arch_remap-and-mm-arch-hooksh.patch
* mm-add-kernel-electric-fence-infrastructure.patch
* mm-add-kernel-electric-fence-infrastructure-fix.patch
* mm-add-kernel-electric-fence-infrastructure-fix-2.patch
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
* maintainers-add-entry-for-kfence.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-wchan-use-printk-format-instead-of-lookup_symbol_name.patch
* proc-wchan-use-printk-format-instead-of-lookup_symbol_name-fix.patch
* proc-sysctl-make-protected_-world-readable.patch
* lib-linear_ranges-fix-repeated-words-one-typo.patch
* lib-optimize-cpumask_local_spread.patch
* aio-simplify-read_events.patch
  linux-next.patch
  linux-next-rejects.patch
* kmap-stupid-hacks-to-make-it-compile.patch
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
