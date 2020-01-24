Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F31F1477DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 06:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgAXFNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 00:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgAXFNe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:13:34 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFEA12071A;
        Fri, 24 Jan 2020 05:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579842813;
        bh=vbaLPnnk3F6q1M3Nl3it6g50lbygfcTBN1EtCqmbY2k=;
        h=Date:From:To:Subject:From;
        b=jc4KcjLRLjO7m+3cKcnMMDPvnrR2kycD2mcdyqVuWxltjIfQVZDYEO0TKCEUKdaL7
         /m2h61SEfLNvUTqzC6EGGxCeLXujWWlKMfylmfyuviGlaHNgELRFyIxXmzPrnWJsba
         70FhC1ikP7o8h4zCsScOp+GbZHNC1t1DOVTZQsjw=
Date:   Thu, 23 Jan 2020 21:13:32 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-01-23-21-12 uploaded
Message-ID: <20200124051332.DoQFo8kO9%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-01-23-21-12 has been uploaded to

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



This mmotm tree contains the following patches against 5.5-rc7:
(patches marked "*" will be included in linux-next)

  origin.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* x86-mm-split-vmalloc_sync_all.patch
* revert-ipcsem-remove-uneeded-sem_undo_list-lock-usage-in-exit_sem.patch
* mm-fix-uninitialized-memmaps-on-a-partially-populated-last-section.patch
* fs-proc-pagec-allow-inspection-of-last-section-and-fix-end-detection.patch
* mm-initialize-memmap-of-unavailable-memory-directly.patch
* mm-thp-remove-the-defer-list-related-code-since-this-will-not-happen.patch
* lib-test_bitmap-correct-test-data-offsets-for-32-bit.patch
* watchdog-fix-uaf-in-reboot-notifier-handling-in-watchdog-core-code.patch
* memcg-fix-a-crash-in-wb_workfn-when-a-device-disappears.patch
* mm-mempolicyc-fix-out-of-bounds-write-in-mpol_parse_str.patch
* ocfs2-fix-the-oops-problem-when-write-cloned-file.patch
* mm-sparse-reset-sections-mem_map-when-fully-deactivated.patch
* mm-migratec-also-overwrite-error-when-it-is-bigger-than-zero.patch
* scripts-spellingtxt-add-more-spellings-to-spellingtxt.patch
* scripts-spellingtxt-add-issus-typo.patch
* fs-ocfs-remove-unnecessary-assertion-in-dlm_migrate_lockres.patch
* ocfs2-remove-unneeded-semicolon.patch
* ocfs2-make-local-header-paths-relative-to-c-files.patch
* ocfs2-dlm-remove-redundant-assignment-to-ret.patch
* ocfs2-dlm-move-bits_to_bytes-to-bitopsh-for-wider-use.patch
* ocfs2-fix-a-null-pointer-dereference-when-call-ocfs2_update_inode_fsync_trans.patch
* ocfs2-use-ocfs2_update_inode_fsync_trans-to-access-t_tid-in-handle-h_transaction.patch
* ramfs-support-o_tmpfile.patch
  mm.patch
* mm-avoid-slub-allocation-while-holding-list_lock.patch
* kmemleak-turn-kmemleak_lock-and-object-lock-to-raw_spinlock_t.patch
* mm-debug-always-print-flags-in-dump_page.patch
* mm-clean-up-filemap_write_and_wait.patch
* mm-fix-gup_pud_range.patch
* mm-gupc-use-is_vm_hugetlb_page-to-check-whether-to-follow-huge.patch
* mm-gup-factor-out-duplicate-code-from-four-routines.patch
* mm-gup-move-try_get_compound_head-to-top-fix-minor-issues.patch
* mm-cleanup-__put_devmap_managed_page-vs-page_free.patch
* mm-devmap-refactor-1-based-refcounting-for-zone_device-pages.patch
* goldish_pipe-rename-local-pin_user_pages-routine.patch
* mm-fix-get_user_pages_remotes-handling-of-foll_longterm.patch
* vfio-fix-foll_longterm-use-simplify-get_user_pages_remote-call.patch
* mm-gup-allow-foll_force-for-get_user_pages_fast.patch
* ib-umem-use-get_user_pages_fast-to-pin-dma-pages.patch
* media-v4l2-core-set-pages-dirty-upon-releasing-dma-buffers.patch
* mm-gup-introduce-pin_user_pages-and-foll_pin.patch
* goldish_pipe-convert-to-pin_user_pages-and-put_user_page.patch
* ib-corehwumem-set-foll_pin-via-pin_user_pages-fix-up-odp.patch
* mm-process_vm_access-set-foll_pin-via-pin_user_pages_remote.patch
* drm-via-set-foll_pin-via-pin_user_pages_fast.patch
* fs-io_uring-set-foll_pin-via-pin_user_pages.patch
* net-xdp-set-foll_pin-via-pin_user_pages.patch
* media-v4l2-core-pin_user_pages-foll_pin-and-put_user_page-conversion.patch
* vfio-mm-pin_user_pages-foll_pin-and-put_user_page-conversion.patch
* powerpc-book3s64-convert-to-pin_user_pages-and-put_user_page.patch
* mm-gup_benchmark-use-proper-foll_write-flags-instead-of-hard-coding-1.patch
* mm-tree-wide-rename-put_user_page-to-unpin_user_page.patch
* mm-cleanup-some-useless-code.patch
* mm-vmscan-expose-cgroup_ino-for-memcg-reclaim-tracepoints.patch
* mm-pgmap-use-correct-alignment-when-looking-at-first-pfn-from-a-region.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-page_vma_mappedc-explicitly-compare-pfn-for-normal-hugetlbfs-and-thp-page.patch
* mm-mremap-format-the-check-in-move_normal_pmd-same-as-move_huge_pmd.patch
* mm-mremap-it-is-sure-to-have-enough-space-when-extent-meets-requirement.patch
* mm-mremap-use-pmd_addr_end-to-calculate-next-in-move_page_tables.patch
* mm-mremap-calculate-extent-in-one-place.patch
* mm-mremap-start-addresses-are-properly-aligned.patch
* mm-tracing-print-symbol-name-for-kmem_alloc_node-call_site-events.patch
* lib-test_kasanc-fix-memory-leak-in-kmalloc_oob_krealloc_more.patch
* mm-early_remap-use-%pa-to-print-resource_size_t-variables.patch
* mm-page_alloc-skip-non-present-sections-on-zone-initialization.patch
* mm-page_alloc-fix-and-rework-pfn-handling-in-memmap_init_zone.patch
* mm-factor-out-next_present_section_nr.patch
* mm-remove-the-memory-isolate-notifier.patch
* mm-remove-count-parameter-from-has_unmovable_pages.patch
* mm-vmscanc-remove-unused-return-value-of-shrink_node.patch
* mm-vmscan-remove-prefetch_prev_lru_page.patch
* mm-vmscan-remove-unused-reclaim_off-reclaim_zone.patch
* mm-vmscan-remove-unused-reclaim_off-reclaim_zone-fix.patch
* tools-vm-slabinfo-fix-sanity-checks-enabling.patch
* mm-memblock-define-memblock_physmem_add.patch
* memblock-use-__func__-in-remaining-memblock_dbg-call-sites.patch
* mm-oom-avoid-printk-iteration-under-rcu.patch
* mm-oom-avoid-printk-iteration-under-rcu-fix.patch
* mm-oom-dump-stack-of-victim-when-reaping-failed.patch
* mm-huge_memoryc-use-head-to-check-huge-zero-page.patch
* mm-huge_memoryc-use-head-to-emphasize-the-purpose-of-page.patch
* mm-huge_memoryc-reduce-critical-section-protected-by-split_queue_lock.patch
* mm-migrate-remove-useless-mask-of-start-address.patch
* mm-migrate-clean-up-some-minor-coding-style.patch
* mm-migrate-add-stable-check-in-migrate_vma_insert_page.patch
* mm-thp-fix-defrag-setting-if-newline-is-not-used.patch
* mm-get-rid-of-odd-jump-labels-in-find_mergeable_anon_vma.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup-fix.patch
* mm-memmap_init-update-variable-name-in-memmap_init_zone.patch
* mm-memory_hotplug-poison-memmap-in-remove_pfn_range_from_zone.patch
* mm-memory_hotplug-we-always-have-a-zone-in-find_smallestbiggest_section_pfn.patch
* mm-memory_hotplug-dont-check-for-all-holes-in-shrink_zone_span.patch
* mm-memory_hotplug-drop-local-variables-in-shrink_zone_span.patch
* mm-memory_hotplug-cleanup-__remove_pages.patch
* mm-memory_hotplug-drop-valid_start-valid_end-from-test_pages_in_a_zone.patch
* mm-memory_hotplug-pass-in-nid-to-online_pages.patch
* mm-hotplug-silence-a-lockdep-splat-with-printk.patch
* mm-page_isolation-fix-potential-warning-from-user.patch
* zswap-add-allocation-hysteresis-if-pool-limit-is-hit.patch
* zswap-potential-null-dereference-on-error-in-init_zswap.patch
* mm-clean-up-obsolete-check-on-space-in-page-flags.patch
* mm-remove-dead-code-totalram_pages_set.patch
* mm-drop-elements-hw-and-phys_callback-from-struct-memory_block.patch
* mm-fix-comments-related-to-node-reclaim.patch
* zram-try-to-avoid-worst-case-scenario-on-same-element-pages.patch
* zram-try-to-avoid-worst-case-scenario-on-same-element-pages-update.patch
* zram-fix-error-return-codes-not-being-returned-in-writeback_store.patch
* documentation-zram-various-fixes-in-zramrst.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* y2038-remove-ktime-to-from-timespec-timeval-conversion.patch
* y2038-remove-unused-time32-interfaces.patch
* y2038-hide-timeval-timespec-itimerval-itimerspec-types.patch
* add-helpers-for-kelvin-to-from-celsius-conversion.patch
* acpi-thermal-switch-to-use-linux-unitsh-helpers.patch
* platform-x86-asus-wmi-switch-to-use-linux-unitsh-helpers.patch
* platform-x86-intel_menlow-switch-to-use-linux-unitsh-helpers.patch
* thermal-int340x-switch-to-use-linux-unitsh-helpers.patch
* thermal-intel_pch-switch-to-use-linux-unitsh-helpers.patch
* nvme-hwmon-switch-to-use-linux-unitsh-helpers.patch
* thermal-remove-kelvin-to-from-celsius-conversion-helpers-from-linux-thermalh.patch
* iwlegacy-use-linux-unitsh-helpers.patch
* iwlegacy-use-linux-unitsh-helpers-fix.patch
* iwlwifi-use-linux-unitsh-helpers.patch
* thermal-armada-remove-unused-to_mcelsius-macro.patch
* iio-adc-qcom-vadc-common-use-linux-unitsh-helpers.patch
* lib-zlib-add-s390-hardware-support-for-kernel-zlib_deflate.patch
* s390-boot-rename-heap_size-due-to-name-collision.patch
* lib-zlib-add-s390-hardware-support-for-kernel-zlib_inflate.patch
* s390-boot-add-dfltcc=-kernel-command-line-parameter.patch
* lib-zlib-add-zlib_deflate_dfltcc_enabled-function.patch
* btrfs-use-larger-zlib-buffer-for-s390-hardware-compression.patch
* lib-scatterlist-adjust-indentation-in-__sg_alloc_table.patch
* uapi-rename-ext2_swab-to-swab-and-share-globally-in-swabh.patch
* lib-find_bitc-join-_find_next_bit_le.patch
* lib-find_bitc-uninline-helper-_find_next_bit.patch
* lib-reduce-user_access_begin-boundaries-in-strncpy_from_user-and-strnlen_user.patch
* string-add-stracpy-and-stracpy_pad-mechanisms.patch
* documentation-checkpatch-prefer-stracpy-strscpy-over-strcpy-strlcpy-strncpy.patch
* elf-smaller-code-generation-around-auxv-vector-fill.patch
* elf-fix-start_code-calculation.patch
* elf-dont-copy-elf-header-around.patch
* elf-better-codegen-around-current-mm.patch
* elf-make-bad_addr-unlikely.patch
* elf-coredump-allocate-core-elf-header-on-stack.patch
* elf-coredump-delete-duplicated-overflow-check.patch
* elf-coredump-allow-process-with-empty-address-space-to-coredump.patch
* init-mainc-log-arguments-and-environment-passed-to-init.patch
* init-mainc-remove-unnecessary-repair_env_string-in-do_initcall_level.patch
* init-mainc-fix-quoted-value-handling-in-unknown_bootoption.patch
* init-fix-misleading-this-architecture-does-not-have-kernel-memory-protection-message.patch
* reiserfs-prevent-null-pointer-dereference-in-reiserfs_insert_item.patch
* execve-warn-if-process-starts-with-executable-stack.patch
* io-mapping-use-phys_pfn-macro-in-io_mapping_map_atomic_wc.patch
* kernel-relayc-fix-read_pos-error-when-multiple-readers.patch
* aio-simplify-read_events.patch
* kcov-ignore-fault-inject-and-stacktrace.patch
* smp_mb__beforeafter_atomic-update-documentation.patch
* ipc-mqueuec-remove-duplicated-code.patch
* ipc-mqueuec-update-document-memory-barriers.patch
* ipc-msgc-update-and-document-memory-barriers.patch
* ipc-semc-document-and-update-memory-barriers.patch
* ipc-consolidate-all-xxxctl_down-functions.patch
* ipc-consolidate-all-xxxctl_down-functions-fix.patch
  linux-next.patch
  linux-next-fix.patch
* drivers-block-null_blk_mainc-fix-layout.patch
* drivers-block-null_blk_mainc-fix-uninitialized-var-warnings.patch
* pinctrl-fix-pxa2xxc-build-warnings.patch
* mm-remove-__krealloc.patch
* mm-add-generic-pd_leaf-macros.patch
* arc-mm-add-pd_leaf-definitions.patch
* arm-mm-add-pd_leaf-definitions.patch
* arm64-mm-add-pd_leaf-definitions.patch
* mips-mm-add-pd_leaf-definitions.patch
* powerpc-mm-add-pd_leaf-definitions.patch
* riscv-mm-add-pd_leaf-definitions.patch
* s390-mm-add-pd_leaf-definitions.patch
* sparc-mm-add-pd_leaf-definitions.patch
* x86-mm-add-pd_leaf-definitions.patch
* mm-pagewalk-add-p4d_entry-and-pgd_entry.patch
* mm-pagewalk-add-p4d_entry-and-pgd_entry-fix.patch
* mm-pagewalk-allow-walking-without-vma.patch
* mm-pagewalk-dont-lock-ptes-for-walk_page_range_novma.patch
* mm-pagewalk-fix-termination-condition-in-walk_pte_range.patch
* mm-pagewalk-add-depth-parameter-to-pte_hole.patch
* x86-mm-point-to-struct-seq_file-from-struct-pg_state.patch
* x86-mmefi-convert-ptdump_walk_pgd_level-to-take-a-mm_struct.patch
* x86-mm-convert-ptdump_walk_pgd_level_debugfs-to-take-an-mm_struct.patch
* mm-add-generic-ptdump.patch
* x86-mm-convert-dump_pagetables-to-use-walk_page_range.patch
* arm64-mm-convert-mm-dumpc-to-use-walk_page_range.patch
* arm64-mm-display-non-present-entries-in-ptdump.patch
* mm-ptdump-reduce-level-numbers-by-1-in-note_page.patch
* x86-mm-avoid-allocating-struct-mm_struct-on-the-stack.patch
* x86-mm-avoid-allocating-struct-mm_struct-on-the-stack-fix.patch
* powerpc-mmu_gather-enable-rcu_table_free-even-for-smp-case.patch
* mm-mmu_gather-invalidate-tlb-correctly-on-batch-allocation-failure-and-flush.patch
* asm-generic-tlb-avoid-potential-double-flush.patch
* asm-gemeric-tlb-remove-stray-function-declarations.patch
* asm-generic-tlb-add-missing-config-symbol.patch
* asm-generic-tlb-rename-have_rcu_table_free.patch
* asm-generic-tlb-rename-have_mmu_gather_page_size.patch
* asm-generic-tlb-rename-have_mmu_gather_no_gather.patch
* asm-generic-tlb-provide-mmu_gather_table_free.patch
* proc-decouple-proc-from-vfs-with-struct-proc_ops.patch
* proc-convert-everything-to-struct-proc_ops.patch
* proc-convert-everything-to-struct-proc_ops-fix.patch
* proc-convert-everything-to-struct-proc_ops-fix-2.patch
* lib-string-add-strnchrnul.patch
* bitops-more-bits_to_-macros.patch
* lib-add-test-for-bitmap_parse.patch
* lib-add-test-for-bitmap_parse-fix.patch
* lib-add-test-for-bitmap_parse-fix-2.patch
* lib-make-bitmap_parse_user-a-wrapper-on-bitmap_parse.patch
* lib-rework-bitmap_parse.patch
* lib-new-testcases-for-bitmap_parse_user.patch
* cpumask-dont-calculate-length-of-the-input-string.patch
* treewide-remove-redundent-is_err-before-error-code-check.patch
* arm-dma-api-fix-max_pfn-off-by-one-error-in-__dma_supported.patch
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
