Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6491BB210
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 01:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD0Xh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 19:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgD0Xh0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:37:26 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE6F206D4;
        Mon, 27 Apr 2020 23:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588030645;
        bh=G/SbXDZTXqGzfM5RyXqjzlaqciCMeC4HXVSzfk7W/ug=;
        h=Date:From:To:Subject:From;
        b=ahwr2QkU2/JSqROI57FpPgSWjElQrA8T7r0kYUYpGez3kJSi0Zg+KExl+h22ABL9I
         1ooDQ+1tE/PP+YlydVW/OMT0GDshD8x2txOq0TVNNqOajV7AXxRzzIMxs0WYzJkWko
         t/ExkHhMOS6y6krnaTRPWDwetORNy4xNjn1s2MH4=
Date:   Mon, 27 Apr 2020 16:37:24 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-04-27-16-36 uploaded
Message-ID: <20200427233724.dpsDwTVY2%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-04-27-16-36 has been uploaded to

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



This mmotm tree contains the following patches against 5.7-rc3:
(patches marked "*" will be included in linux-next)

* checkpatch-test-git_dir-changes.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* ipc-mqueuec-change-__do_notify-to-bypass-check_kill_permission-v2.patch
* mm-memcg-fix-error-return-value-of-mem_cgroup_css_alloc.patch
* mm-memcg-fix-error-return-value-of-mem_cgroup_css_alloc-fix.patch
* kcov-cleanup-debug-messages.patch
* kcov-fix-potential-use-after-free-in-kcov_remote_start.patch
* kcov-move-t-kcov-assignments-into-kcov_start-stop.patch
* kcov-move-t-kcov_sequence-assignment.patch
* kcov-use-t-kcov_mode-as-enabled-indicator.patch
* kcov-collect-coverage-from-interrupts.patch
* usb-core-kcov-collect-coverage-from-usb-complete-callback.patch
* mm-page_alloc-fix-watchdog-soft-lockups-during-set_zone_contiguous.patch
* kernel-kcovc-fix-typos-in-kcov_remote_start-documentation.patch
* scripts-decodecode-fix-trapping-instruction-formatting.patch
* kvm-svm-change-flag-passed-to-gup-fast-in-sev_pin_memory.patch
* memcg-optimize-memorynuma_stat-like-memorystat.patch
* eventpoll-fix-missing-wakeup-for-ovflist-in-ep_poll_callback.patch
* eventpoll-fix-missing-wakeup-for-ovflist-in-ep_poll_callback-v2.patch
* scripts-gdb-repair-rb_first-and-rb_last.patch
* squashfs-migrate-from-ll_rw_block-usage-to-bio.patch
* squashfs-migrate-from-ll_rw_block-usage-to-bio-fix.patch
* ocfs2-add-missing-annotation-for-dlm_empty_lockres.patch
* ocfs2-mount-shared-volume-without-ha-stack.patch
* drivers-tty-serial-sh-scic-suppress-uninitialized-var-warning.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* usercopy-mark-dma-kmalloc-caches-as-usercopy-caches.patch
* mm-slub-fix-corrupted-freechain-in-deactivate_slab.patch
* mm-slub-fix-corrupted-freechain-in-deactivate_slab-fix.patch
* slub-remove-userspace-notifier-for-cache-add-remove.patch
* slub-remove-kmalloc-under-list_lock-from-list_slab_objects.patch
* mm-dump_page-do-not-crash-with-invalid-mapping-pointer.patch
* mm-move-readahead-prototypes-from-mmh.patch
* mm-return-void-from-various-readahead-functions.patch
* mm-ignore-return-value-of-readpages.patch
* mm-move-readahead-nr_pages-check-into-read_pages.patch
* mm-add-new-readahead_control-api.patch
* mm-use-readahead_control-to-pass-arguments.patch
* mm-rename-various-offset-parameters-to-index.patch
* mm-rename-readahead-loop-variable-to-i.patch
* mm-remove-page_offset-from-readahead-loop.patch
* mm-put-readahead-pages-in-cache-earlier.patch
* mm-add-readahead-address-space-operation.patch
* mm-move-end_index-check-out-of-readahead-loop.patch
* mm-add-page_cache_readahead_unbounded.patch
* mm-document-why-we-dont-set-pagereadahead.patch
* mm-use-memalloc_nofs_save-in-readahead-path.patch
* fs-convert-mpage_readpages-to-mpage_readahead.patch
* btrfs-convert-from-readpages-to-readahead.patch
* erofs-convert-uncompressed-files-from-readpages-to-readahead.patch
* erofs-convert-compressed-files-from-readpages-to-readahead.patch
* ext4-convert-from-readpages-to-readahead.patch
* ext4-pass-the-inode-to-ext4_mpage_readpages.patch
* f2fs-convert-from-readpages-to-readahead.patch
* f2fs-pass-the-inode-to-f2fs_mpage_readpages.patch
* fuse-convert-from-readpages-to-readahead.patch
* fuse-convert-from-readpages-to-readahead-fix.patch
* iomap-convert-from-readpages-to-readahead.patch
* mm-gupc-updating-the-documentation.patch
* mm-gupc-updating-the-documentation-fix.patch
* mm-swapfile-use-list_prevnext_entry-instead-of-open-coding.patch
* mm-swap_state-fix-a-data-race-in-swapin_nr_pages.patch
* mm-swap-properly-update-readahead-statistics-in-unuse_pte_range.patch
* mm-swapfilec-offset-is-only-used-when-there-is-more-slots.patch
* mm-swapfilec-explicitly-show-ssd-non-ssd-is-handled-mutually-exclusive.patch
* mm-swapfilec-remove-the-unnecessary-goto-for-ssd-case.patch
* mm-swapfilec-simplify-the-calculation-of-n_goal.patch
* mm-swapfilec-remove-the-extra-check-in-scan_swap_map_slots.patch
* mm-swapfilec-found_free-could-be-represented-by-tmp-max.patch
* mm-swapfilec-tmp-is-always-smaller-than-max.patch
* mm-swapfilec-omit-a-duplicate-code-by-compare-tmp-and-max-first.patch
* swap-try-to-scan-more-free-slots-even-when-fragmented.patch
* h8300-remove-usage-of-__arch_use_5level_hack.patch
* arm-add-support-for-folded-p4d-page-tables.patch
* arm64-add-support-for-folded-p4d-page-tables.patch
* hexagon-remove-__arch_use_5level_hack.patch
* ia64-add-support-for-folded-p4d-page-tables.patch
* nios2-add-support-for-folded-p4d-page-tables.patch
* openrisc-add-support-for-folded-p4d-page-tables.patch
* powerpc-add-support-for-folded-p4d-page-tables.patch
* powerpc-add-support-for-folded-p4d-page-tables-fix.patch
* sh-fault-modernize-printing-of-kernel-messages.patch
* sh-drop-__pxd_offset-macros-that-duplicate-pxd_index-ones.patch
* sh-add-support-for-folded-p4d-page-tables.patch
* unicore32-remove-__arch_use_5level_hack.patch
* asm-generic-remove-pgtable-nop4d-hackh.patch
* mm-remove-__arch_has_5level_hack-and-include-asm-generic-5level-fixuph.patch
* mm-gupc-further-document-vma_permits_fault.patch
* proc-pid-smaps-add-pmd-migration-entry-parsing.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-memory-remove-unnecessary-pte_devmap-case-in-copy_one_pte.patch
* x86-hyperv-use-vmalloc_exec-for-the-hypercall-page.patch
* x86-fix-vmap-arguments-in-map_irq_stack.patch
* staging-android-ion-use-vmap-instead-of-vm_map_ram.patch
* staging-media-ipu3-use-vmap-instead-of-reimplementing-it.patch
* dma-mapping-use-vmap-insted-of-reimplementing-it.patch
* powerpc-add-an-ioremap_phb-helper.patch
* powerpc-remove-__ioremap_at-and-__iounmap_at.patch
* mm-remove-__get_vm_area.patch
* mm-unexport-unmap_kernel_range_noflush.patch
* mm-rename-config_pgtable_mapping-to-config_zsmalloc_pgtable_mapping.patch
* mm-only-allow-page-table-mappings-for-built-in-zsmalloc.patch
* mm-pass-addr-as-unsigned-long-to-vb_free.patch
* mm-remove-vmap_page_range_noflush-and-vunmap_page_range.patch
* mm-rename-vmap_page_range-to-map_kernel_range.patch
* mm-dont-return-the-number-of-pages-from-map_kernel_range_noflush.patch
* mm-remove-map_vm_range.patch
* mm-remove-unmap_vmap_area.patch
* mm-remove-the-prot-argument-from-vm_map_ram.patch
* mm-enforce-that-vmap-cant-map-pages-executable.patch
* gpu-drm-remove-the-powerpc-hack-in-drm_legacy_sg_alloc.patch
* mm-remove-the-pgprot-argument-to-__vmalloc.patch
* mm-remove-the-prot-argument-to-__vmalloc_node.patch
* mm-remove-both-instances-of-__vmalloc_node_flags.patch
* mm-remove-__vmalloc_node_flags_caller.patch
* mm-remove-__vmalloc_node_flags_caller-fix.patch
* mm-switch-the-test_vmalloc-module-to-use-__vmalloc_node.patch
* mm-switch-the-test_vmalloc-module-to-use-__vmalloc_node-fix.patch
* mm-switch-the-test_vmalloc-module-to-use-__vmalloc_node-fix-fix.patch
* mm-remove-vmalloc_user_node_flags.patch
* mm-remove-vmalloc_user_node_flags-fix.patch
* arm64-use-__vmalloc_node-in-arch_alloc_vmap_stack.patch
* powerpc-use-__vmalloc_node-in-alloc_vm_stack.patch
* s390-use-__vmalloc_node-in-stack_alloc.patch
* mm-init-report-kasan-tag-information-stored-in-page-flags.patch
* kasan-stop-tests-being-eliminated-as-dead-code-with-fortify_source.patch
* kasan-stop-tests-being-eliminated-as-dead-code-with-fortify_source-v4.patch
* stringh-fix-incompatibility-between-fortify_source-and-kasan.patch
* mm-clarify-__gfp_memalloc-usage.patch
* mm-memblock-replace-dereferences-of-memblock_regionnid-with-api-calls.patch
* mm-make-early_pfn_to_nid-and-related-defintions-close-to-each-other.patch
* mm-remove-config_have_memblock_node_map-option.patch
* mm-free_area_init-use-maximal-zone-pfns-rather-than-zone-sizes.patch
* mm-use-free_area_init-instead-of-free_area_init_nodes.patch
* alpha-simplify-detection-of-memory-zone-boundaries.patch
* arm-simplify-detection-of-memory-zone-boundaries.patch
* arm64-simplify-detection-of-memory-zone-boundaries-for-uma-configs.patch
* csky-simplify-detection-of-memory-zone-boundaries.patch
* m68k-mm-simplify-detection-of-memory-zone-boundaries.patch
* parisc-simplify-detection-of-memory-zone-boundaries.patch
* sparc32-simplify-detection-of-memory-zone-boundaries.patch
* unicore32-simplify-detection-of-memory-zone-boundaries.patch
* xtensa-simplify-detection-of-memory-zone-boundaries.patch
* mm-memmap_init-iterate-over-memblock-regions-rather-that-check-each-pfn.patch
* mm-memmap_init-iterate-over-memblock-regions-rather-that-check-each-pfn-fix.patch
* mm-remove-early_pfn_in_nid-and-config_nodes_span_other_nodes.patch
* mm-free_area_init-allow-defining-max_zone_pfn-in-descending-order.patch
* mm-rename-free_area_init_node-to-free_area_init_memoryless_node.patch
* mm-clean-up-free_area_init_node-and-its-helpers.patch
* mm-simplify-find_min_pfn_with_active_regions.patch
* docs-vm-update-memory-models-documentation.patch
* mm-page_allocc-bad_-is-not-necessary-when-pagehwpoison.patch
* mm-page_allocc-bad_flags-is-not-necessary-for-bad_page.patch
* mm-page_allocc-rename-free_pages_check_bad-to-check_free_page_bad.patch
* mm-page_allocc-rename-free_pages_check-to-check_free_page.patch
* mm-page_allocc-extract-check__page_bad-common-part-to-page_bad_reason.patch
* mmpage_alloccma-conditionally-prefer-cma-pageblocks-for-movable-allocations.patch
* mmpage_alloccma-conditionally-prefer-cma-pageblocks-for-movable-allocations-fix.patch
* mm-call-touch_nmi_watchdog-on-max-order-boundaries-in-deferred-init.patch
* mm-initialize-deferred-pages-with-interrupts-enabled.patch
* mm-call-cond_resched-from-deferred_init_memmap.patch
* mm-remove-unused-free_bootmem_with_active_regions.patch
* mm-page_allocc-only-tune-sysctl_lowmem_reserve_ratio-value-once-when-changing-it.patch
* mm-page_allocc-clear-out-zone-lowmem_reserve-if-the-zone-is-empty.patch
* mm-vmstatc-do-not-show-lowmem-reserve-protection-information-of-empty-zone.patch
* mm-page_alloc-use-ac-high_zoneidx-for-classzone_idx.patch
* mm-page_alloc-integrate-classzone_idx-and-high_zoneidx.patch
* mm-page_allocc-use-node_mask_none-in-build_zonelists.patch
* mm-rename-gfpflags_to_migratetype-to-gfp_migratetype-for-same-convention.patch
* mm-vmscanc-use-update_lru_size-in-update_lru_sizes.patch
* mm-vmscan-count-layzfree-pages-and-fix-nr_isolated_-mismatch.patch
* mm-mempolicy-fix-up-gup-usage-in-lookup_node.patch
* hugetlb_cgroup-remove-unused-variable-i.patch
* khugepaged-add-self-test.patch
* khugepaged-add-self-test-fix.patch
* khugepaged-do-not-stop-collapse-if-less-than-half-ptes-are-referenced.patch
* khugepaged-drain-all-lru-caches-before-scanning-pages.patch
* khugepaged-drain-lru-add-pagevec-after-swapin.patch
* khugepaged-allow-to-collapse-a-page-shared-across-fork.patch
* khugepaged-allow-to-collapse-pte-mapped-compound-pages.patch
* thp-change-cow-semantics-for-anon-thp.patch
* khugepaged-introduce-max_ptes_shared-tunable.patch
* khugepaged-introduce-max_ptes_shared-tunable-fix.patch
* hugetlbfs-add-arch_hugetlb_valid_size.patch
* hugetlbfs-move-hugepagesz=-parsing-to-arch-independent-code.patch
* hugetlbfs-remove-hugetlb_add_hstate-warning-for-existing-hstate.patch
* hugetlbfs-remove-hugetlb_add_hstate-warning-for-existing-hstate-fix.patch
* hugetlbfs-clean-up-command-line-processing.patch
* hugetlbfs-move-hugepagesz=-parsing-to-arch-independent-code-fix.patch
* mm-hugetlb-avoid-unnecessary-check-on-pud-and-pmd-entry-in-huge_pte_offset.patch
* mm-thp-dont-need-drain-lru-cache-when-splitting-and-mlocking-thp.patch
* powerpc-mm-drop-platform-defined-pmd_mknotpresent.patch
* mm-thp-rename-pmd_mknotpresent-as-pmd_mknotvalid.patch
* mm-thp-rename-pmd_mknotpresent-as-pmd_mkinvalid-v2.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup-fix.patch
* mm-add-debug_wx-support.patch
* mm-add-debug_wx-support-fixpatch-added-to-mm-tree.patch
* riscv-support-debug_wx.patch
* riscv-support-debug_wx-fix.patch
* x86-mm-use-arch_has_debug_wx-instead-of-arch-defined.patch
* arm64-mm-use-arch_has_debug_wx-instead-of-arch-defined.patch
* mm-memory_hotplug-refrain-from-adding-memory-into-an-impossible-node.patch
* powerpc-pseries-hotplug-memory-stop-checking-is_mem_section_removable.patch
* mm-memory_hotplug-remove-is_mem_section_removable.patch
* mm-memory_hotplug-set-node_start_pfn-of-hotadded-pgdat-to-0.patch
* mm-memory_hotplug-handle-memblocks-only-with-config_arch_keep_memblock.patch
* mm-replace-zero-length-array-with-flexible-array-member.patch
* mm-replace-zero-length-array-with-flexible-array-member-fix.patch
* mm-memory_hotplug-fix-a-typo-in-comment-recoreded-recorded.patch
* mm-ksm-fix-a-typo-in-comment-alreaady-already.patch
* mm-ksm-fix-a-typo-in-comment-alreaady-already-v2.patch
* mm-mmap-fix-a-typo-in-comment-compatbility-compatibility.patch
* mm-hugetlb-fix-a-typo-in-comment-manitained-maintained.patch
* mm-hugetlb-fix-a-typo-in-comment-manitained-maintained-v2.patch
* mm-hugetlb-fix-a-typo-in-comment-manitained-maintained-v2-checkpatch-fixes.patch
* mm-vmsan-fix-some-typos-in-comment.patch
* mm-compaction-fix-a-typo-in-comment-pessemistic-pessimistic.patch
* mm-memblock-fix-a-typo-in-comment-implict-implicit.patch
* mm-list_lru-fix-a-typo-in-comment-numbesr-numbers.patch
* mm-filemap-fix-a-typo-in-comment-unneccssary-unnecessary.patch
* mm-frontswap-fix-some-typos-in-frontswapc.patch
* mm-memcg-fix-some-typos-in-memcontrolc.patch
* mm-fix-a-typo-in-comment-strucure-structure.patch
* mm-slub-fix-a-typo-in-comment-disambiguiation-disambiguation.patch
* mm-sparse-fix-a-typo-in-comment-convienence-convenience.patch
* mm-page-writeback-fix-a-typo-in-comment-effictive-effective.patch
* mm-memory-fix-a-typo-in-comment-attampt-attempt.patch
* mm-use-false-for-bool-variable.patch
* mm-return-true-in-cpupid_pid_unset.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-rename-catch-function-argument.patch
* kernel-sysctl-support-setting-sysctl-parameters-from-kernel-command-line.patch
* kernel-sysctl-support-handling-command-line-aliases.patch
* kernel-hung_task-convert-hung_task_panic-boot-parameter-to-sysctl.patch
* tools-testing-selftests-sysctl-sysctlsh-support-config_test_sysctl=y.patch
* lib-test_sysctl-support-testing-of-sysctl-boot-parameter.patch
* x86-mm-define-mm_p4d_folded.patch
* mm-debug-add-tests-validating-architecture-page-table-helpers.patch
* mm-debug-add-tests-validating-architecture-page-table-helpers-v17.patch
* userc-make-uidhash_table-static.patch
* parisc-add-sysctl-file-interface-panic_on_stackoverflow.patch
* kernel-hung_taskc-introduce-sysctl-to-print-all-traces-when-a-hung-task-is-detected.patch
* dynamic_debug-add-an-option-to-enable-dynamic-debug-for-modules-only.patch
* dynamic_debug-add-an-option-to-enable-dynamic-debug-for-modules-only-v2.patch
* get_maintainer-add-email-addresses-from-yaml-files.patch
* lib-math-avoid-trailing-n-hidden-in-pr_fmt.patch
* lib-add-might_fault-to-strncpy_from_user.patch
* lib-optimize-cpumask_local_spread.patch
* lib-test_lockupc-make-test_inode-static.patch
* checkpatch-additional-maintainer-section-entry-ordering-checks.patch
* checkpatch-look-for-c99-comments-in-ctx_locate_comment.patch
* fs-binfmt_elf-remove-redundant-elf_map-ifndef.patch
* elfnote-mark-all-note-sections-shf_alloc.patch
* fs-binfmt_elfc-allocate-initialized-memory-in-fill_thread_core_info.patch
* fat-dont-allow-to-mount-if-the-fat-length-==-0.patch
* fat-improve-the-readahead-for-fat-entries.patch
* fs-seq_filec-seq_read-update-pr_info_ratelimited.patch
* umh-fix-refcount-underflow-in-fork_usermode_blob.patch
* kexec-prevent-removal-of-memory-in-use-by-a-loaded-kexec-image.patch
* mm-memory_hotplug-allow-arch-override-of-non-boot-memory-resource-names.patch
* arm64-memory-give-hotplug-memory-a-different-resource-name.patch
* rapidio-avoid-data-race-between-file-operation-callbacks-and-mport_cdev_add.patch
* panic-add-sysctl-to-dump-all-cpus-backtraces-on-oops-event.patch
* kernel-relayc-fix-read_pos-error-when-multiple-readers.patch
* aio-simplify-read_events.patch
* add-kernel-config-option-for-twisting-kernel-behavior.patch
* twist-allow-disabling-k_spec-function-in-drivers-tty-vt-keyboardc.patch
* twist-add-option-for-selecting-twist-options-for-syzkallers-testing.patch
* selftests-x86-pkeys-move-selftests-to-arch-neutral-directory.patch
* selftests-vm-pkeys-rename-all-references-to-pkru-to-a-generic-name.patch
* selftests-vm-pkeys-move-generic-definitions-to-header-file.patch
* selftests-vm-pkeys-move-some-definitions-to-arch-specific-header.patch
* selftests-vm-pkeys-make-gcc-check-arguments-of-sigsafe_printf.patch
* selftests-vm-pkeys-use-sane-types-for-pkey-register.patch
* selftests-vm-pkeys-add-helpers-for-pkey-bits.patch
* selftests-vm-pkeys-fix-pkey_disable_clear.patch
* selftests-vm-pkeys-fix-assertion-in-pkey_disable_set-clear.patch
* selftests-vm-pkeys-fix-alloc_random_pkey-to-make-it-really-random.patch
* selftests-vm-pkeys-use-the-correct-huge-page-size.patch
* selftests-vm-pkeys-introduce-generic-pkey-abstractions.patch
* selftests-vm-pkeys-introduce-powerpc-support.patch
* selftests-vm-pkeys-fix-number-of-reserved-powerpc-pkeys.patch
* selftests-vm-pkeys-fix-assertion-in-test_pkey_alloc_exhaust.patch
* selftests-vm-pkeys-improve-checks-to-determine-pkey-support.patch
* selftests-vm-pkeys-associate-key-on-a-mapped-page-and-detect-access-violation.patch
* selftests-vm-pkeys-associate-key-on-a-mapped-page-and-detect-write-violation.patch
* selftests-vm-pkeys-detect-write-violation-on-a-mapped-access-denied-key-page.patch
* selftests-vm-pkeys-introduce-a-sub-page-allocator.patch
* selftests-vm-pkeys-test-correct-behaviour-of-pkey-0.patch
* selftests-vm-pkeys-override-access-right-definitions-on-powerpc.patch
* selftests-vm-pkeys-use-the-correct-page-size-on-powerpc.patch
* selftests-vm-pkeys-fix-multilib-builds-for-x86.patch
* tools-testing-selftests-vm-remove-duplicate-headers.patch
* ipc-msg-add-missing-annotation-for-freeque.patch
* ipc-use-a-work-queue-to-free_ipc.patch
* ipc-convert-ipcs_idr-to-xarray.patch
* ipc-convert-ipcs_idr-to-xarray-update.patch
  linux-next.patch
  linux-next-fix.patch
  linux-next-git-rejects.patch
  linux-next-git-rejects-fix.patch
* initrdmem=-option-to-specify-initrd-physical-address.patch
* amdgpu-a-null-mm-does-not-mean-a-thread-is-a-kthread.patch
* i915-gvt-remove-unused-xen-bits.patch
* kernel-move-use_mm-unuse_mm-to-kthreadc.patch
* kernel-move-use_mm-unuse_mm-to-kthreadc-v2.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract-v2.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract-v2-fix.patch
* kernel-set-user_ds-in-kthread_use_mm.patch
* mm-kmemleak-silence-kcsan-splats-in-checksum.patch
* kallsyms-printk-add-loglvl-to-print_ip_sym.patch
* alpha-add-show_stack_loglvl.patch
* arc-add-show_stack_loglvl.patch
* arm-asm-add-loglvl-to-c_backtrace.patch
* arm-add-loglvl-to-unwind_backtrace.patch
* arm-add-loglvl-to-dump_backtrace.patch
* arm-wire-up-dump_backtrace_entrystm.patch
* arm-add-show_stack_loglvl.patch
* arm64-add-loglvl-to-dump_backtrace.patch
* arm64-add-show_stack_loglvl.patch
* c6x-add-show_stack_loglvl.patch
* csky-add-show_stack_loglvl.patch
* h8300-add-show_stack_loglvl.patch
* hexagon-add-show_stack_loglvl.patch
* ia64-pass-log-level-as-arg-into-ia64_do_show_stack.patch
* ia64-add-show_stack_loglvl.patch
* m68k-add-show_stack_loglvl.patch
* microblaze-add-loglvl-to-microblaze_unwind_inner.patch
* microblaze-add-loglvl-to-microblaze_unwind.patch
* microblaze-add-show_stack_loglvl.patch
* mips-add-show_stack_loglvl.patch
* nds32-add-show_stack_loglvl.patch
* nios2-add-show_stack_loglvl.patch
* openrisc-add-show_stack_loglvl.patch
* parisc-add-show_stack_loglvl.patch
* powerpc-add-show_stack_loglvl.patch
* riscv-add-show_stack_loglvl.patch
* s390-add-show_stack_loglvl.patch
* sh-add-loglvl-to-dump_mem.patch
* sh-remove-needless-printk.patch
* sh-add-loglvl-to-printk_address.patch
* sh-add-loglvl-to-show_trace.patch
* sh-add-show_stack_loglvl.patch
* sparc-add-show_stack_loglvl.patch
* um-sysrq-remove-needless-variable-sp.patch
* um-add-show_stack_loglvl.patch
* unicore32-remove-unused-pmode-argument-in-c_backtrace.patch
* unicore32-add-loglvl-to-c_backtrace.patch
* unicore32-add-show_stack_loglvl.patch
* x86-add-missing-const-qualifiers-for-log_lvl.patch
* x86-add-show_stack_loglvl.patch
* xtensa-add-loglvl-to-show_trace.patch
* xtensa-add-show_stack_loglvl.patch
* sysrq-use-show_stack_loglvl.patch
* x86-amd_gart-print-stacktrace-for-a-leak-with-kern_err.patch
* power-use-show_stack_loglvl.patch
* kdb-dont-play-with-console_loglevel.patch
* sched-print-stack-trace-with-kern_info.patch
* kernel-use-show_stack_loglvl.patch
* kernel-rename-show_stack_loglvl-=-show_stack.patch
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
* mm-util-annotate-an-data-race-at-vm_committed_as.patch
* mm-rmap-annotate-a-data-race-at-tlb_flush_batched.patch
* mm-annotate-a-data-race-in-page_zonenum.patch
* mm-swap-annotate-data-races-for-lru_rotate_pvecs.patch
* net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy.patch
* mm-mmapc-add-more-sanity-checks-to-get_unmapped_area.patch
* mm-mmapc-do-not-allow-mappings-outside-of-allowed-limits.patch
* mm-pass-task-and-mm-to-do_madvise.patch
* mm-pass-task-and-mm-to-do_madvise-fix.patch
* mm-pass-task-and-mm-to-do_madvise-fix-fix.patch
* mm-pass-task-and-mm-to-do_madvise-fix-fix-fix.patch
* mm-pass-task-and-mm-to-do_madvise-fix-fix-fix-fix.patch
* mm-introduce-external-memory-hinting-api.patch
* mm-introduce-external-memory-hinting-api-fix.patch
* mm-check-fatal-signal-pending-of-target-process.patch
* pid-move-pidfd_get_pid-function-to-pidc.patch
* mm-support-both-pid-and-pidfd-for-process_madvise.patch
* mm-madvise-allow-ksm-hints-for-remote-api.patch
* mm-support-vector-address-ranges-for-process_madvise.patch
* mm-support-vector-address-ranges-for-process_madvise-fix.patch
* mm-support-vector-address-ranges-for-process_madvise-fix-fix.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
