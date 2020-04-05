Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F57C19EEA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 01:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgDEXqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Apr 2020 19:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbgDEXqm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Apr 2020 19:46:42 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B8A20675;
        Sun,  5 Apr 2020 23:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586130400;
        bh=QhREp0JLF1j1xzR2E32ETcxd7I6WE9Y9ZjRMq3WRMNg=;
        h=Date:From:To:Subject:From;
        b=gewRttUC/2ai7ZXAAZWrhTHNL1KwCgvcAANINu8/xqhFt6dfU+z02t04zPfvBkzUK
         6Zp4cfR4xrkVhnU3Zn2QxAtDeiQpU+xUrR61UpCcl41l7C14sk192Z4pZsuBfoP/Gi
         fi1ALW4OmaHulVhCVTqPtJ366wd+uN2V4RoIJKXY=
Date:   Sun, 05 Apr 2020 16:46:39 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-04-05-16-45 uploaded
Message-ID: <20200405234639.AU1f3x3Xg%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-04-05-16-45 has been uploaded to

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



This mmotm tree contains the following patches against 5.6:
(patches marked "*" will be included in linux-next)

  origin.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* ipc-mqueuec-change-__do_notify-to-bypass-check_kill_permission-v2.patch
* hfsplus-fix-crash-and-filesystem-corruption-when-deleting-files.patch
* mm-memcg-do-not-high-throttle-allocators-based-on-wraparound.patch
* drivers-tty-serial-sh-scic-suppress-uninitialized-var-warning.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-slab_common-fix-a-typo-in-comment-eariler-earlier.patch
* memcg-optimize-memorynuma_stat-like-memorystat.patch
* memcg-optimize-memorynuma_stat-like-memorystat-fix.patch
* mm-memcg-bypass-high-reclaim-iteration-for-cgroup-hierarchy-root.patch
* mm-dont-prepare-anon_vma-if-vma-has-vm_wipeonfork.patch
* revert-mm-rmapc-reuse-mergeable-anon_vma-as-parent-when-fork.patch
* mm-set-vm_next-and-vm_prev-to-null-in-vm_area_dup.patch
* mm-vma-add-missing-vma-flag-readable-name-for-vm_sync.patch
* mm-vma-make-vma_is_accessible-available-for-general-use.patch
* mm-vma-replace-all-remaining-open-encodings-with-is_vm_hugetlb_page.patch
* mm-vma-replace-all-remaining-open-encodings-with-vma_is_anonymous.patch
* mm-vma-append-unlikely-while-testing-vma-access-permissions.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-vmalloc-fix-a-typo-in-comment.patch
* mm-clarify-__gfp_memalloc-usage.patch
* mm-clarify-__gfp_memalloc-usage-checkpatch-fixes.patch
* mm-make-it-clear-that-gfp-reclaim-modifiers-are-valid-only-for-sleepable-allocations.patch
* mmpage_alloccma-conditionally-prefer-cma-pageblocks-for-movable-allocations.patch
* mmpage_alloccma-conditionally-prefer-cma-pageblocks-for-movable-allocations-fix.patch
* mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma.patch
* mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma-fix.patch
* mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma-fix-2.patch
* mm-hugetlbc-fix-printk-format-warning-for-32-bit-phys_addr_t.patch
* mm-hugetlbc-fix-printk-format-warning-for-32-bit-phys_addr_t-fix.patch
* mm-migratec-no-need-to-check-for-i-start-in-do_pages_move.patch
* mm-migratec-wrap-do_move_pages_to_node-and-store_status.patch
* mm-migratec-check-pagelist-in-move_pages_and_store_status.patch
* mm-migratec-unify-not-queued-for-migration-handling-in-do_pages_move.patch
* mm-migratec-migrate-pg_readahead-flag.patch
* mm-migratec-migrate-pg_readahead-flag-fix.patch
* mm-shmem-add-vmstat-for-hugepage-fallback.patch
* mm-thp-track-fallbacks-due-to-failed-memcg-charges-separately.patch
* mm-optimise-find_subpage-for-thp.patch
* mm-remove-config_transparent_huge_pagecache.patch
* mm-ksmc-update-get_user_pages-in-comment.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup-fix.patch
* mm-code-cleanup-for-madv_free.patch
* mm-adjust-shuffle-code-to-allow-for-future-coalescing.patch
* mm-use-zone-and-order-instead-of-free-area-in-free_list-manipulators.patch
* mm-add-function-__putback_isolated_page.patch
* mm-introduce-reported-pages.patch
* virtio-balloon-pull-page-poisoning-config-out-of-free-page-hinting.patch
* virtio-balloon-add-support-for-providing-free-page-reports-to-host.patch
* mm-page_reporting-rotate-reported-pages-to-the-tail-of-the-list.patch
* mm-page_reporting-add-budget-limit-on-how-many-pages-can-be-reported-per-pass.patch
* mm-page_reporting-add-free-page-reporting-documentation.patch
* virtio-balloon-switch-back-to-oom-handler-for-virtio_balloon_f_deflate_on_oom.patch
* userfaultfd-wp-add-helper-for-writeprotect-check.patch
* userfaultfd-wp-hook-userfault-handler-to-write-protection-fault.patch
* userfaultfd-wp-add-wp-pagetable-tracking-to-x86.patch
* userfaultfd-wp-userfaultfd_pte-huge_pmd_wp-helpers.patch
* userfaultfd-wp-add-uffdio_copy_mode_wp.patch
* mm-merge-parameters-for-change_protection.patch
* userfaultfd-wp-apply-_page_uffd_wp-bit.patch
* userfaultfd-wp-drop-_page_uffd_wp-properly-when-fork.patch
* userfaultfd-wp-add-pmd_swp_uffd_wp-helpers.patch
* userfaultfd-wp-support-swap-and-page-migration.patch
* khugepaged-skip-collapse-if-uffd-wp-detected.patch
* userfaultfd-wp-support-write-protection-for-userfault-vma-range.patch
* userfaultfd-wp-add-the-writeprotect-api-to-userfaultfd-ioctl.patch
* userfaultfd-wp-enabled-write-protection-in-userfaultfd-api.patch
* userfaultfd-wp-dont-wake-up-when-doing-write-protect.patch
* userfaultfd-wp-uffdio_register_mode_wp-documentation-update.patch
* userfaultfd-wp-declare-_uffdio_writeprotect-conditionally.patch
* userfaultfd-selftests-refactor-statistics.patch
* userfaultfd-selftests-add-write-protect-test.patch
* drivers-base-memoryc-drop-section_count.patch
* drivers-base-memoryc-drop-pages_correctly_probed.patch
* mm-page_extc-drop-pfn_present-check-when-onlining.patch
* mm-hotplug-only-respect-mem=-parameter-during-boot-stage.patch
* mm-memory_hotplug-simplify-calculation-of-number-of-pages-in-__remove_pages.patch
* mm-memory_hotplug-cleanup-__add_pages.patch
* mm-sparsec-introduce-new-function-fill_subsection_map.patch
* mm-sparsec-introduce-a-new-function-clear_subsection_map.patch
* mm-sparsec-only-use-subsection-map-in-vmemmap-case.patch
* mm-sparsec-add-note-about-only-vmemmap-supporting-sub-section-hotplug.patch
* mm-sparsec-move-subsection_map-related-functions-together.patch
* mm-sparsec-move-subsection_map-related-functions-together-fix.patch
* drivers-base-memory-rename-mmop_online_keep-to-mmop_online.patch
* drivers-base-memory-map-mmop_offline-to-0.patch
* drivers-base-memory-store-mapping-between-mmop_-and-string-in-an-array.patch
* powernv-memtrace-always-online-added-memory-blocks.patch
* hv_balloon-dont-check-for-memhp_auto_online-manually.patch
* hv_balloon-dont-check-for-memhp_auto_online-manually-fix.patch
* mm-memory_hotplug-unexport-memhp_auto_online.patch
* mm-memory_hotplug-convert-memhp_auto_online-to-store-an-online_type.patch
* mm-memory_hotplug-allow-to-specify-a-default-online_type.patch
* mm-memory_hotplug-use-__pfn_to_section-instead-of-open-coding.patch
* shmem-distribute-switch-variables-for-initialization.patch
* mm-shmemc-clean-code-by-removing-unnecessary-assignment.patch
* huge-tmpfs-try-to-split_huge_page-when-punching-hole.patch
* mm-elide-a-warning-when-casting-void-enum.patch
* zswap-allow-setting-default-status-compressor-and-allocator-in-kconfig.patch
* mm-compaction-add-missing-annotation-for-compact_lock_irqsave.patch
* mm-hugetlb-add-missing-annotation-for-gather_surplus_pages.patch
* mm-mempolicy-add-missing-annotation-for-queue_pages_pmd.patch
* mm-slub-add-missing-annotation-for-get_map.patch
* mm-slub-add-missing-annotation-for-put_map.patch
* mm-zsmalloc-add-missing-annotation-for-migrate_read_lock.patch
* mm-zsmalloc-add-missing-annotation-for-migrate_read_unlock.patch
* mm-zsmalloc-add-missing-annotation-for-pin_tag.patch
* mm-zsmalloc-add-missing-annotation-for-unpin_tag.patch
* mm-fix-ambiguous-comments-for-better-code-readability.patch
* mm-mm_initc-clean-code-use-build_bug_on-when-comparing-compile-time-constant.patch
* mm-use-fallthrough.patch
* mm-correct-guards-for-non_swap_entry.patch
* memremap-remove-stale-comments.patch
* mm-dmapoolc-micro-optimisation-remove-unnecessary-branch.patch
* mm-remove-dummy-struct-bootmem_data-bootmem_data_t.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-annotate-close_pdeo-for-sparse.patch
* proc-faster-open-read-close-with-permanent-files.patch
* proc-faster-open-read-close-with-permanent-files-checkpatch-fixes.patch
* proc-speed-up-proc-statm.patch
* proc-inline-vma_stop-into-m_stop.patch
* proc-remove-m_cache_vma.patch
* proc-use-ppos-instead-of-m-version.patch
* seq_file-remove-m-version.patch
* proc-inline-m_next_vma-into-m_next.patch
* asm-generic-fix-unistd_32h-generation-format.patch
* kernel-extable-use-address-of-operator-on-section-symbols.patch
* sparcx86-vdso-remove-meaningless-undefining-config_optimize_inlining.patch
* compiler-remove-config_optimize_inlining-entirely.patch
* compilerh-fix-error-in-build_bug_on-reporting.patch
* maintainers-add-an-entry-for-kfifo.patch
* maintainers-list-the-section-entries-in-the-preferred-order.patch
* bitops-always-inline-sign-extension-helpers.patch
* lib-test_lockup-test-module-to-generate-lockups.patch
* lib-test_lockup-test-module-to-generate-lockups-fix.patch
* lib-test_lockup-fix-spelling-mistake-iteraions-iterations.patch
* lib-test_lockup-add-parameters-for-locking-generic-vfs-locks.patch
* lib-bch-replace-zero-length-array-with-flexible-array-member.patch
* lib-ts_bm-replace-zero-length-array-with-flexible-array-member.patch
* lib-ts_fsm-replace-zero-length-array-with-flexible-array-member.patch
* lib-ts_kmp-replace-zero-length-array-with-flexible-array-member.patch
* lib-scatterlist-fix-sg_copy_buffer-kerneldoc.patch
* lib-test_stackinitc-xfail-switch-variable-init-tests.patch
* stackdepot-check-depot_index-before-accessing-the-stack-slab.patch
* stackdepot-check-depot_index-before-accessing-the-stack-slab-fix.patch
* stackdepot-build-with-fno-builtin.patch
* kasan-stackdepot-move-filter_irq_stacks-to-stackdepotc.patch
* kasan-stackdepot-move-filter_irq_stacks-to-stackdepotc-fix-1.patch
* kasan-stackdepot-move-filter_irq_stacks-to-stackdepotc-fix-2.patch
* percpu_counter-fix-a-data-race-at-vm_committed_as.patch
* lib-test_bitmap-make-use-of-exp2_in_bits.patch
* lib-rbtree-fix-coding-style-of-assignments.patch
* lib-test_kmod-remove-a-null-test.patch
* linux-bitsh-add-compile-time-sanity-check-of-genmask-inputs.patch
* lib-optimize-cpumask_local_spread.patch
* list-prevent-compiler-reloads-inside-safe-list-iteration.patch
* dynamic_debug-use-address-of-operator-on-section-symbols.patch
* checkpatch-remove-email-address-comment-from-email-address-comparisons.patch
* checkpatch-check-spdx-tags-in-yaml-files.patch
* checkpatch-support-base-commit-format.patch
* checkpatch-prefer-fallthrough-over-fallthrough-comments.patch
* checkpatch-fix-minor-typo-and-mixed-spacetab-in-indentation.patch
* checkpatch-fix-multiple-const-types.patch
* checkpatch-add-command-line-option-for-tab-size.patch
* checkpatch-improve-gerrit-change-id-test.patch
* checkpatch-check-proper-licensing-of-devicetree-bindings.patch
* checkpatch-avoid-warning-about-uninitialized_var.patch
* kselftest-introduce-new-epoll-test-case.patch
* fs-epoll-make-nesting-accounting-safe-for-rt-kernel.patch
* elf-delete-loc-variable.patch
* elf-allocate-less-for-static-executable.patch
* elf-dont-free-interpreters-elf-pheaders-on-common-path.patch
* samples-hw_breakpoint-drop-hw_breakpoint_r-when-reporting-writes.patch
* samples-hw_breakpoint-drop-use-of-kallsyms_lookup_name.patch
* kallsyms-unexport-kallsyms_lookup_name-and-kallsyms_on_each_symbol.patch
* reiserfs-clean-up-several-indentation-issues.patch
* kmod-fix-a-typo-assuems-assumes.patch
* umh-fix-refcount-underflow-in-fork_usermode_blob.patch
* gcov-gcc_4_7-replace-zero-length-array-with-flexible-array-member.patch
* gcov-gcc_3_4-replace-zero-length-array-with-flexible-array-member.patch
* gcov-fs-replace-zero-length-array-with-flexible-array-member.patch
* kernel-relayc-fix-read_pos-error-when-multiple-readers.patch
* aio-simplify-read_events.patch
* init-cleanup-anon_inodes-and-old-io-schedulers-options.patch
* kcov-cleanup-debug-messages.patch
* kcov-fix-potential-use-after-free-in-kcov_remote_start.patch
* kcov-move-t-kcov-assignments-into-kcov_start-stop.patch
* kcov-move-t-kcov_sequence-assignment.patch
* kcov-use-t-kcov_mode-as-enabled-indicator.patch
* kcov-collect-coverage-from-interrupts.patch
* kcov-collect-coverage-from-interrupts-v4.patch
* usb-core-kcov-collect-coverage-from-usb-complete-callback.patch
* ubsan-add-trap-instrumentation-option.patch
* ubsan-split-bounds-checker-from-other-options.patch
* lkdtm-bugs-add-arithmetic-overflow-and-array-bounds-checks.patch
* ubsan-check-panic_on_warn.patch
* kasan-unset-panic_on_warn-before-calling-panic.patch
* ubsan-include-bug-type-in-report-header.patch
* lib-kconfigdebug-fix-a-typo-capabilitiy-capability.patch
* ipc-mqueuec-fixed-a-brace-coding-style-issue.patch
* ipc-shm-make-compat_ksys_shmctl-static.patch
  linux-next.patch
  linux-next-fix.patch
* change-email-address-for-pali-rohar.patch
* mm-kmemleak-silence-kcsan-splats-in-checksum.patch
* dmaengine-tegra-apb-fix-platform_get_irqcocci-warnings.patch
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
* mm-refactor-insert_page-to-prepare-for-batched-lock-insert.patch
* mm-bring-sparc-pte_index-semantics-inline-with-other-platforms.patch
* mm-define-pte_index-as-macro-for-x86.patch
* mm-add-vm_insert_pages.patch
* mm-add-vm_insert_pages-fix.patch
* mm-add-vm_insert_pages-2.patch
* mm-add-vm_insert_pages-2-fix.patch
* net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy.patch
* net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy-fix.patch
* mm-vma-define-a-default-value-for-vm_data_default_flags.patch
* mm-vma-introduce-vm_access_flags.patch
* mm-special-create-generic-fallbacks-for-pte_special-and-pte_mkspecial.patch
* mm-special-create-generic-fallbacks-for-pte_special-and-pte_mkspecial-v3.patch
* mm-debug-add-tests-validating-architecture-page-table-helpers.patch
* mm-memory_hotplug-drop-the-flags-field-from-struct-mhp_restrictions.patch
* mm-memory_hotplug-rename-mhp_restrictions-to-mhp_params.patch
* x86-mm-thread-pgprot_t-through-init_memory_mapping.patch
* x86-mm-introduce-__set_memory_prot.patch
* powerpc-mm-thread-pgprot_t-through-create_section_mapping.patch
* mm-memory_hotplug-add-pgprot_t-to-mhp_params.patch
* mm-memremap-set-caching-mode-for-pci-p2pdma-memory-to-wc.patch
* mm-pass-task-and-mm-to-do_madvise.patch
* mm-introduce-external-memory-hinting-api.patch
* mm-introduce-external-memory-hinting-api-fix.patch
* mm-check-fatal-signal-pending-of-target-process.patch
* pid-move-pidfd_get_pid-function-to-pidc.patch
* mm-support-both-pid-and-pidfd-for-process_madvise.patch
* mm-madvise-employ-mmget_still_valid-for-write-lock.patch
* mm-madvise-allow-ksm-hints-for-remote-api.patch
* kmod-make-request_module-return-an-error-when-autoloading-is-disabled.patch
* fs-filesystemsc-downgrade-user-reachable-warn_once-to-pr_warn_once.patch
* docs-admin-guide-document-the-kernelmodprobe-sysctl.patch
* docs-admin-guide-document-the-kernelmodprobe-sysctl-v5.patch
* selftests-kmod-fix-handling-test-numbers-above-9.patch
* selftests-kmod-test-disabling-module-autoloading.patch
* kexec-prevent-removal-of-memory-in-use-by-a-loaded-kexec-image.patch
* mm-memory_hotplug-allow-arch-override-of-non-boot-memory-resource-names.patch
* arm64-memory-give-hotplug-memory-a-different-resource-name.patch
* seq_read-info-message-about-buggy-next-functions.patch
* seq_read-info-message-about-buggy-next-functions-fix.patch
* gcov_seq_next-should-increase-position-index.patch
* sysvipc_find_ipc-should-increase-position-index.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
