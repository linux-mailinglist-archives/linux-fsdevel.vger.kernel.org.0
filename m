Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E57E20288D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 06:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgFUEhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 00:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgFUEhk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 00:37:40 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC61247FB;
        Sun, 21 Jun 2020 04:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592714258;
        bh=2ydMS+5mftPQjxQ6TiKD/OcDptDir8lxk7BpVnywRNA=;
        h=Date:From:To:Subject:From;
        b=tmarhI03TEL4zzBKOeQVoi5lL8UHxdefS7iAgx9BQeJOr1rbrrsyOJdwJEkT/Pray
         t6Ku9Xb/Y2bkiUpW/SEdIAyP7lvzCvOh4/9o79898Bw/RsZTcrx5RKiSDPPa0S7wBt
         j84bS2xax7graKzxWq01X3DSrEHW/eHpzLDK9ItQ=
Date:   Sat, 20 Jun 2020 21:37:37 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2020-06-20-21-36 uploaded
Message-ID: <20200621043737.pb6JV%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.10
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-06-20-21-36 has been uploaded to

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



This mmotm tree contains the following patches against 5.8-rc1:
(patches marked "*" will be included in linux-next)

  origin.patch
* openrisc-fix-boot-oops-when-debug_vm-is-enabled.patch
* mm-do_swap_page-fix-up-the-error-code-instantiation.patch
* mm-slab-use-memzero_explicit-in-kzfree.patch
* slub-cure-list_slab_objects-from-double-fix.patch
* mm-workingset-age-nonresident-information-alongside-anonymous-pages.patch
* mm-swap-fix-for-mm-workingset-age-nonresident-information-alongside-anonymous-pages.patch
* mm-memory-fix-io-cost-for-anonymous-page.patch
* mm-fix-swap-cache-node-allocation-mask.patch
* mm-memoryc-properly-pte_offset_map_lock-unlock-in-vm_insert_pages.patch
* mm-debug_vm_pgtable-fix-build-failure-with-powerpc-8xx.patch
* mm-memcontrol-handle-div0-crash-race-condition-in-memorylow.patch
* mm-memcontrol-fix-do-not-put-the-css-reference.patch
* mm-memcg-prevent-missed-memorylow-load-tears.patch
* mm-fix-false-softlockup-during-pfn-range-removal.patch
* docs-mm-gup-minor-documentation-update.patch
* doc-thp-cow-fault-no-longer-allocate-thp.patch
* mm-compaction-make-capture-control-handling-safe-wrt-interrupts.patch
* kexec-do-not-verify-the-signature-without-the-lockdown-or-mandatory-signature.patch
* ocfs2-avoid-inode-removed-while-nfsd-access-it.patch
* ocfs2-load-global_inode_alloc.patch
* ocfs2-fix-panic-on-nfs-server-over-ocfs2.patch
* ocfs2-fix-value-of-ocfs2_invalid_slot.patch
* lib-fix-test_hmmc-reference-after-free.patch
* linux-bitsh-fix-unsigned-less-than-zero-warnings.patch
* mm-slab-fix-sign-conversion-problem-in-memcg_uncharge_slab.patch
* x86-hyperv-allocate-the-hypercall-page-with-only-read-and-execute-bits.patch
* arm64-use-page_kernel_rox-directly-in-alloc_insn_page.patch
* mm-remove-vmalloc_exec.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* checkpatch-test-git_dir-changes.patch
* scripts-tagssh-collect-compiled-source-precisely.patch
* bloat-o-meter-support-comparing-library-archives.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* drivers-tty-serial-sh-scic-suppress-uninitialized-var-warning.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-treewide-rename-kzfree-to-kfree_sensitive.patch
* mm-ksize-should-silently-accept-a-null-pointer.patch
* mm-slub-extend-slub_debug-syntax-for-multiple-blocks.patch
* mm-slub-make-some-slub_debug-related-attributes-read-only.patch
* mm-slub-remove-runtime-allocation-order-changes.patch
* mm-slub-make-remaining-slub_debug-related-attributes-read-only.patch
* mm-slub-make-reclaim_account-attribute-read-only.patch
* mm-slub-introduce-static-key-for-slub_debug.patch
* mm-slub-introduce-kmem_cache_debug_flags.patch
* mm-slub-introduce-kmem_cache_debug_flags-fix.patch
* mm-slub-extend-checks-guarded-by-slub_debug-static-key.patch
* mm-slab-slub-move-and-improve-cache_from_obj.patch
* mm-slab-slub-improve-error-reporting-and-overhead-of-cache_from_obj.patch
* slub-drop-lockdep_assert_held-from-put_map.patch
* mm-kcsan-instrument-slab-slub-free-with-assert_exclusive_access.patch
* mm-memcg-factor-out-memcg-and-lruvec-level-changes-out-of-__mod_lruvec_state.patch
* mm-memcg-prepare-for-byte-sized-vmstat-items.patch
* mm-memcg-convert-vmstat-slab-counters-to-bytes.patch
* mm-slub-implement-slub-version-of-obj_to_index.patch
* mm-memcontrol-decouple-reference-counting-from-page-accounting.patch
* mm-memcg-slab-obj_cgroup-api.patch
* mm-memcg-slab-obj_cgroup-api-fix.patch
* mm-memcg-slab-allocate-obj_cgroups-for-non-root-slab-pages.patch
* mm-memcg-slab-allocate-obj_cgroups-for-non-root-slab-pages-fix.patch
* mm-memcg-slab-save-obj_cgroup-for-non-root-slab-objects.patch
* mm-memcg-slab-charge-individual-slab-objects-instead-of-pages.patch
* mm-memcg-slab-deprecate-memorykmemslabinfo.patch
* mm-memcg-slab-move-memcg_kmem_bypass-to-memcontrolh.patch
* mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-accounted-allocations.patch
* mm-memcg-slab-simplify-memcg-cache-creation.patch
* mm-memcg-slab-remove-memcg_kmem_get_cache.patch
* mm-memcg-slab-deprecate-slab_root_caches.patch
* mm-memcg-slab-remove-redundant-check-in-memcg_accumulate_slabinfo.patch
* mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations.patch
* mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations-fix.patch
* kselftests-cgroup-add-kernel-memory-accounting-tests.patch
* tools-cgroup-add-memcg_slabinfopy-tool.patch
* percpu-return-number-of-released-bytes-from-pcpu_free_area.patch
* mm-memcg-percpu-account-percpu-memory-to-memory-cgroups.patch
* mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix.patch
* mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix-fix.patch
* mm-memcg-percpu-per-memcg-percpu-memory-statistics.patch
* mm-memcg-charge-memcg-percpu-memory-to-the-parent-cgroup.patch
* kselftests-cgroup-add-perpcu-memory-accounting-test.patch
* mm-remove-redundant-check-non_swap_entry.patch
* mm-memoryc-make-remap_pfn_range-reject-unaligned-addr.patch
* mm-move-pd_alloc_track-to-separate-header-file.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* vmalloc-convert-to-xarray.patch
* mm-vmalloc-simplify-merge_or_add_vmap_area-func.patch
* mm-vmalloc-simplify-augment_tree_propagate_check-func.patch
* mm-vmalloc-switch-to-propagate-callback.patch
* mm-page_alloc-use-unlikely-in-task_capc.patch
* mm-track-mmu-notifiers-in-fs_reclaim_acquire-release.patch
* page_alloc-consider-highatomic-reserve-in-watermark-fast.patch
* mm-page_alloc-skip-waternark_boost-for-atomic-order-0-allocations.patch
* mm-page_alloc-skip-watermark_boost-for-atomic-order-0-allocations-fix.patch
* mm-drop-vm_total_pages.patch
* mm-page_alloc-drop-nr_free_pagecache_pages.patch
* mm-vmscanc-fixed-typo.patch
* mm-proactive-compaction.patch
* mm-use-unsigned-types-for-fragmentation-score.patch
* hugetlbfs-prevent-filesystem-stacking-of-hugetlbfs.patch
* mm-thp-remove-debug_cow-switch.patch
* mm-vmstat-add-events-for-pmd-based-thp-migration-without-split.patch
* mm-vmstat-add-events-for-pmd-based-thp-migration-without-split-fix.patch
* mm-vmstat-add-events-for-pmd-based-thp-migration-without-split-update.patch
* mm-cma-fix-null-pointer-dereference-when-cma-could-not-be-activated.patch
* mm-cma-fix-the-name-of-cma-areas.patch
* mm-hugetlb-fix-the-name-of-hugetlb-cma.patch
* sched-mm-optimize-current_gfp_context.patch
* x86-mm-use-max-memory-block-size-on-bare-metal.patch
* mm-zswap-move-to-use-crypto_acomp-api-for-hardware-acceleration.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* bitmap-fix-bitmap_cut-for-partial-overlapping-case.patch
* bitmap-add-test-for-bitmap_cut.patch
* lib-optimize-cpumask_local_spread.patch
* bits-add-tests-of-genmask.patch
* checkpatch-add-test-for-possible-misuse-of-is_enabled-without-config_.patch
* checkpatch-support-deprecated-terms-checking.patch
* scripts-deprecated_terms-recommend-denylist-allowlist-instead-of-blacklist-whitelist.patch
* fs-signalfdc-fix-inconsistent-return-codes-for-signalfd4.patch
* selftests-kmod-use-variable-name-in-kmod_test_0001.patch
* kmod-remove-redundant-be-an-in-the-comment.patch
* test_kmod-avoid-potential-double-free-in-trigger_config_run_type.patch
* umh-fix-processed-error-when-umh_wait_proc-is-used.patch
* selftests-simplify-kmod-failure-value.patch
* exec-change-uselib2-is_sreg-failure-to-eacces.patch
* exec-move-s_isreg-check-earlier.patch
* exec-move-path_noexec-check-earlier.patch
* umh-fix-refcount-underflow-in-fork_usermode_blob.patch
* kdump-append-kernel-build-id-string-to-vmcoreinfo.patch
* rapidio-rio_mport_cdev-use-struct_size-helper.patch
* rapidio-use-struct_size-helper.patch
* kernel-panicc-make-oops_may_print-return-bool.patch
* lib-kconfigdebug-fix-typo-in-the-help-text-of-config_panic_timeout.patch
* aio-simplify-read_events.patch
* kcov-unconditionally-add-fno-stack-protector-to-compiler-options.patch
  linux-next.patch
  linux-next-git-rejects.patch
* all-arch-remove-system-call-sys_sysctl.patch
* all-arch-remove-system-call-sys_sysctl-fix.patch
* mm-kmemleak-silence-kcsan-splats-in-checksum.patch
* mm-frontswap-mark-various-intentional-data-races.patch
* mm-page_io-mark-various-intentional-data-races.patch
* mm-page_io-mark-various-intentional-data-races-v2.patch
* mm-swap_state-mark-various-intentional-data-races.patch
* mm-filemap-fix-a-data-race-in-filemap_fault.patch
* mm-swapfile-fix-and-annotate-various-data-races.patch
* mm-swapfile-fix-and-annotate-various-data-races-v2.patch
* mm-page_counter-fix-various-data-races-at-memsw.patch
* mm-memcontrol-fix-a-data-race-in-scan-count.patch
* mm-list_lru-fix-a-data-race-in-list_lru_count_one.patch
* mm-mempool-fix-a-data-race-in-mempool_free.patch
* mm-rmap-annotate-a-data-race-at-tlb_flush_batched.patch
* mm-swap-annotate-data-races-for-lru_rotate_pvecs.patch
* mm-annotate-a-data-race-in-page_zonenum.patch
* include-asm-generic-vmlinuxldsh-align-ro_after_init.patch
* sh-clkfwk-remove-r8-r16-r32.patch
* sh-remove-call-to-memset-after-dma_alloc_coherent.patch
* sh-use-generic-strncpy.patch
* sh-add-missing-export_symbol-for-__delay.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
