Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5875D2DC72A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 20:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbgLPTdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 14:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388761AbgLPTdE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:33:04 -0500
Date:   Wed, 16 Dec 2020 10:41:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1608144070;
        bh=YTasfjhJKaRBFLMYboviGCuiKGNY3hPGSAsPJMLzCO0=;
        h=From:To:Subject:From;
        b=fIAjAm0MoZSRk/r56GV0C9BRGzQjmzq1Mzg9w1jfy9slwi4p0m7zQ1jUasX/QptIl
         rE122RX/3kbjJw/iBnwfhHxLl6TJ2zF26ZC2rMxHwfTV7nBgZmSRMgKGt+Wd3zsJvl
         udx8nRZbynT6Tj0Uv053yaTzhncppLtprbGUTDWo=
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-12-16-10-40 uploaded
Message-ID: <20201216184109.oAm45ad_O%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-12-16-10-40 has been uploaded to

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
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-msync-exit-early-when-the-flags-is-an-ms_async-and-start-vm_start.patch
* mm-dont-setpageworkingset-unconditionally-during-swapin.patch
* selftests-vm-fix-building-protection-keys-test.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-huge_memoryc-update-tlb-entry-if-pmd-is-changed.patch
* mips-do-not-call-flush_tlb_all-when-setting-pmd-entry.patch
* mm-vmscan-__isolate_lru_page_prepare-clean-up.patch
* mm-memblock-enforce-overlap-of-memorymemblock-and-memoryreserved.patch
* mm-fix-initialization-of-struct-page-for-holes-in-memory-layout.patch
* mm-fix-initialization-of-struct-page-for-holes-in-memory-layout-checkpatch-fixes.patch
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
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
* mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
* mm-add-kernel-electric-fence-infrastructure.patch
* mm-add-kernel-electric-fence-infrastructure-fix.patch
* mm-add-kernel-electric-fence-infrastructure-fix-2.patch
* x86-kfence-enable-kfence-for-x86.patch
* arm64-kfence-enable-kfence-for-arm64.patch
* kfence-use-pt_regs-to-generate-stack-trace-on-faults.patch
* mm-kfence-insert-kfence-hooks-for-slab.patch
* mm-kfence-insert-kfence-hooks-for-slub.patch
* kfence-kasan-make-kfence-compatible-with-kasan.patch
* kfence-documentation-add-kfence-documentation.patch
* kfence-add-test-suite.patch
* maintainers-add-entry-for-kfence.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-sysctl-make-protected_-world-readable.patch
* lib-optimize-cpumask_local_spread.patch
* bitops-introduce-the-for_each_set_clump-macro.patch
* lib-test_bitmapc-add-for_each_set_clump-test-cases.patch
* gpio-thunderx-utilize-for_each_set_clump-macro.patch
* gpio-xilinx-utilize-generic-bitmap_get_value-and-_set_value.patch
* aio-simplify-read_events.patch
  linux-next.patch
  linux-next-git-rejects.patch
* kmap-stupid-hacks-to-make-it-compile.patch
* mm-memcg-bail-early-from-swap-accounting-if-memcg-disabled.patch
* mm-memcg-warning-on-memcg-after-readahead-page-charged.patch
* mm-memcg-remove-unused-definitions.patch
* mm-kvm-account-kvm_vcpu_mmap-to-kmemcg.patch
* mm-slub-call-account_slab_page-after-slab-page-initialization.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account.patch
* mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account-v2.patch
* mm-memcontrol-rewrite-mem_cgroup_page_lruvec.patch
* mm-memcontrol-rewrite-mem_cgroup_page_lruvec-fix.patch
* mm-memcontrol-rewrite-mem_cgroup_page_lruvec-fix-fix.patch
* epoll-check-for-events-when-removing-a-timed-out-thread-from-the-wait-queue.patch
* epoll-simplify-signal-handling.patch
* epoll-pull-fatal-signal-checks-into-ep_send_events.patch
* epoll-move-eavail-next-to-the-list_empty_careful-check.patch
* epoll-simplify-and-optimize-busy-loop-logic.patch
* epoll-pull-all-code-between-fetch_events-and-send_event-into-the-loop.patch
* epoll-replace-gotos-with-a-proper-loop.patch
* epoll-eliminate-unnecessary-lock-for-zero-timeout.patch
* kasan-drop-unnecessary-gpl-text-from-comment-headers.patch
* kasan-kasan_vmalloc-depends-on-kasan_generic.patch
* kasan-group-vmalloc-code.patch
* kasan-shadow-declarations-only-for-software-modes.patch
* kasan-shadow-declarations-only-for-software-modes-fix.patch
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
* arm64-mte-add-in-kernel-tag-fault-handler-fix.patch
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
* kasan-add-and-integrate-kasan-boot-parameters-fix.patch
* kasan-mm-check-kasan_enabled-in-annotations.patch
* kasan-mm-rename-kasan_poison_kfree.patch
* kasan-dont-round_up-too-much.patch
* kasan-simplify-assign_tag-and-set_tag-calls.patch
* kasan-clarify-comment-in-__kasan_kfree_large.patch
* kasan-sanitize-objects-when-metadata-doesnt-fit.patch
* kasan-mm-allow-cache-merging-with-no-metadata.patch
* kasan-update-documentation.patch
* epoll-convert-internal-api-to-timespec64.patch
* epoll-add-syscall-epoll_pwait2.patch
* epoll-wire-up-syscall-epoll_pwait2.patch
* epoll-wire-up-syscall-epoll_pwait2-fix.patch
* selftests-filesystems-expand-epoll-with-epoll_pwait2.patch
* mm-add-definition-of-pmd_page_order.patch
* mmap-make-mlock_future_check-global.patch
* set_memory-allow-set_direct_map__noflush-for-multiple-pages.patch
* set_memory-allow-set_direct_map__noflush-for-multiple-pages-fix.patch
* set_memory-allow-querying-whether-set_direct_map_-is-actually-enabled.patch
* set_memory-allow-querying-whether-set_direct_map_-is-actually-enabled-fix.patch
* mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas.patch
* secretmem-use-pmd-size-pages-to-amortize-direct-map-fragmentation.patch
* secretmem-add-memcg-accounting.patch
* pm-hibernate-disable-when-there-are-active-secretmem-users.patch
* arch-mm-wire-up-memfd_secret-system-call-were-relevant.patch
* arch-mm-wire-up-memfd_secret-system-call-were-relevant-fix.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2.patch
* secretmem-test-add-basic-selftest-for-memfd_secret2-fix.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
