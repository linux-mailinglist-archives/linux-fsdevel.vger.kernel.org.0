Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A925945050
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 01:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfFMXrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 19:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfFMXrO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:47:14 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A62021721;
        Thu, 13 Jun 2019 23:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560469632;
        bh=2b4X40rkyNH3lif/GSoA5mbxCyn0RCmljqDnIyDIJxI=;
        h=Date:From:To:Subject:From;
        b=lnsyQPVRZo9LQjfOuoesbWGHHba8kZcW5kvvojzNHpkp1WZRnnGy6U0zmKkoZg+3C
         Lt0lA11p8mRVJx8b1sAxw2zKI3IdbFRk8wc3Eop3c+8rtYDvBG5HKojAuBBYcr/tiE
         v8UwmmwtXhfppwscV5P1+VDaeRGBcYGorDTUmSBw=
Date:   Thu, 13 Jun 2019 16:47:12 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2019-06-13-16-46 uploaded
Message-ID: <20190613234712.AE0Qq%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.10
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2019-06-13-16-46 has been uploaded to

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

http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/



The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
contains daily snapshots of the -mm tree.  It is updated more frequently
than mmotm, and is untested.

A git copy of this tree is available at

	http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/

and use of this tree is similar to
http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/, described above.


This mmotm tree contains the following patches against 5.2-rc4:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-memcontrol-dont-batch-updates-of-local-vm-stats-and-events.patch
* list_lru-fix-memory-leak-in-__memcg_init_list_lru_node.patch
* scripts-decode_stacktracesh-prefix-addr2line-with-cross_compile.patch
* mm-mlockall-error-for-flag-mcl_onfault.patch
* mm-fix-recent_rotated-history.patch
* fs-ocfs2-fix-race-in-ocfs2_dentry_attach_lock.patch
* mm-mmu_gather-remove-__tlb_reset_range-for-force-flush.patch
* mm-change-count_mm_mlocked_page_nr-return-type.patch
* coredump-fix-race-condition-between-collapse_huge_page-and-core-dumping.patch
* mm-fix-trying-to-reclaim-unevicable-lru-page.patch
* drivers-base-devres-introduce-devm_release_action.patch
* mm-devm_memremap_pages-introduce-devm_memunmap_pages.patch
* pci-p2pdma-fix-the-gen_pool_add_virt-failure-path.patch
* lib-genalloc-introduce-chunk-owners.patch
* pci-p2pdma-track-pgmap-references-per-resource-not-globally.patch
* mm-devm_memremap_pages-fix-final-page-put-race.patch
* mm-dev_pfn-exclude-memory_device_private-while-computing-virtual-address.patch
* fs-proc-allow-reporting-eip-esp-for-all-coredumping-threads.patch
* mm-mempolicy-fix-an-incorrect-rebind-node-in-mpol_rebind_nodemask.patch
* binfmt_flat-make-load_flat_shared_library-work.patch
* signal-remove-the-wrong-signal_pending-check-in-restore_user_sigmask.patch
* mm-soft-offline-return-ebusy-if-set_hwpoison_free_buddy_page-fails.patch
* mm-hugetlb-soft-offline-dissolve_free_huge_page-return-zero-on-pagehuge.patch
* iommu-replace-single-char-identifiers-in-macros.patch
* scripts-decode_stacktrace-match-basepath-using-shell-prefix-operator-not-regex.patch
* scripts-decode_stacktrace-look-for-modules-with-kodebug-extension.patch
* scripts-decode_stacktrace-look-for-modules-with-kodebug-extension-v2.patch
* scripts-spellingtxt-drop-sepc-from-the-misspelling-list.patch
* scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix.patch
* scripts-spellingtxt-add-spelling-fix-for-prohibited.patch
* scripts-decode_stacktrace-accept-dash-underscore-in-modules.patch
* sh-configs-remove-config_logfs-from-defconfig.patch
* sh-config-remove-left-over-backlight_lcd_support.patch
* debugobjects-move-printk-out-of-db-lock-critical-sections.patch
* fs-ocfs-fix-spelling-mistake-hearbeating-heartbeat.patch
* ocfs2-dlm-use-struct_size-helper.patch
* ocfs2-add-last-unlock-times-in-locking_state.patch
* ocfs2-add-locking-filter-debugfs-file.patch
* ocfs2-add-locking-filter-debugfs-file-fix.patch
* ocfs2-add-first-lock-wait-time-in-locking_state.patch
* ocfs-no-need-to-check-return-value-of-debugfs_create-functions.patch
* ocfs-no-need-to-check-return-value-of-debugfs_create-functions-v2.patch
* ocfs2-clear-zero-in-unaligned-direct-io.patch
* ocfs2-clear-zero-in-unaligned-direct-io-checkpatch-fixes.patch
* ocfs2-wait-for-recovering-done-after-direct-unlock-request.patch
* ocfs2-checkpoint-appending-truncate-log-transaction-before-flushing.patch
* ramfs-support-o_tmpfile.patch
  mm.patch
* mm-slab-validate-cache-membership-under-freelist-hardening.patch
* mm-slab-sanity-check-page-type-when-looking-up-cache.patch
* mm-slab-sanity-check-page-type-when-looking-up-cache-fix.patch
* lkdtm-heap-add-tests-for-freelist-hardening.patch
* mm-slub-avoid-double-string-traverse-in-kmem_cache_flags.patch
* kmemleak-fix-check-for-softirq-context.patch
* mm-kmemleak-change-error-at-_write-when-kmemleak-is-disabled.patch
* docs-kmemleak-add-more-documentation-details.patch
* mm-kasan-print-frame-description-for-stack-bugs.patch
* device-dax-fix-memory-and-resource-leak-if-hotplug-fails.patch
* mm-hotplug-make-remove_memory-interface-useable.patch
* device-dax-hotremove-persistent-memory-that-is-used-like-normal-ram.patch
* mm-move-map_sync-to-asm-generic-mman-commonh.patch
* include-linux-pfn_th-remove-pfn_t_to_virt.patch
* arm-remove-arch_select_memory_model.patch
* s390-remove-arch_select_memory_model.patch
* sparc-remove-arch_select_memory_model.patch
* mm-gupc-make-follow_page_mask-static.patch
* mm-migrate-remove-unused-mode-argument.patch
* mm-trivial-clean-up-in-insert_page.patch
* mm-make-config_huge_page-wrappers-into-static-inlines.patch
* swap-ifdef-struct-vm_area_struct-swap_readahead_info.patch
* mm-remove-the-account_page_dirtied-export.patch
* mm-failslab-by-default-do-not-fail-allocations-with-direct-reclaim-only.patch
* mm-debug_pagelloc-use-static-keys-to-enable-debugging.patch
* mm-page_alloc-more-extensive-free-page-checking-with-debug_pagealloc.patch
* mm-debug_pagealloc-use-a-page-type-instead-of-page_ext-flag.patch
* mm-page_owner-store-page_owners-gfp_mask-in-stackdepot-itself.patch
* mm-fix-an-overly-long-line-in-read_cache_page.patch
* mm-dont-cast-readpage-to-filler_t-for-do_read_cache_page.patch
* jffs2-pass-the-correct-prototype-to-read_cache_page.patch
* 9p-pass-the-correct-prototype-to-read_cache_page.patch
* mm-filemap-correct-the-comment-about-vm_fault_retry.patch
* mm-swap-fix-race-between-swapoff-and-some-swap-operations.patch
* mm-swap-simplify-total_swapcache_pages-with-get_swap_device.patch
* mm-swap-simplify-total_swapcache_pages-with-get_swap_device-fix.patch
* mm-swap-use-rbtree-for-swap_extent.patch
* mm-swap-use-rbtree-for-swap_extent-fix.patch
* mm-fix-race-between-swapoff-and-mincore.patch
* memcg-oom-no-oom-kill-for-__gfp_retry_mayfail.patch
* memcg-fsnotify-no-oom-kill-for-remote-memcg-charging.patch
* mm-vmscan-expose-cgroup_ino-for-memcg-reclaim-tracepoints.patch
* mm-memcg-introduce-memoryeventslocal.patch
* mm-memcontrol-dump-memorystat-during-cgroup-oom.patch
* mm-memcontrol-dump-memorystat-during-cgroup-oom-fix.patch
* mm-postpone-kmem_cache-memcg-pointer-initialization-to-memcg_link_cache.patch
* mm-rename-slab-delayed-deactivation-functions-and-fields.patch
* mm-generalize-postponed-non-root-kmem_cache-deactivation.patch
* mm-introduce-__memcg_kmem_uncharge_memcg.patch
* mm-unify-slab-and-slub-page-accounting.patch
* mm-dont-check-the-dying-flag-on-kmem_cache-creation.patch
* mm-synchronize-access-to-kmem_cache-dying-flag-using-a-spinlock.patch
* mm-rework-non-root-kmem_cache-lifecycle-management.patch
* mm-stop-setting-page-mem_cgroup-pointer-for-slab-pages.patch
* mm-reparent-memcg-kmem_caches-on-cgroup-removal.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* asm-generic-x86-introduce-generic-pte_allocfree_one.patch
* alpha-switch-to-generic-version-of-pte-allocation.patch
* arm-switch-to-generic-version-of-pte-allocation.patch
* arm64-switch-to-generic-version-of-pte-allocation.patch
* arm64-switch-to-generic-version-of-pte-allocation-fix.patch
* csky-switch-to-generic-version-of-pte-allocation.patch
* m68k-sun3-switch-to-generic-version-of-pte-allocation.patch
* mips-switch-to-generic-version-of-pte-allocation.patch
* nds32-switch-to-generic-version-of-pte-allocation.patch
* nios2-switch-to-generic-version-of-pte-allocation.patch
* parisc-switch-to-generic-version-of-pte-allocation.patch
* riscv-switch-to-generic-version-of-pte-allocation.patch
* um-switch-to-generic-version-of-pte-allocation.patch
* unicore32-switch-to-generic-version-of-pte-allocation.patch
* mm-memremap-rename-and-consolidate-section_size.patch
* mm-clean-up-is_device__page-definitions.patch
* mm-introduce-arch_has_pte_devmap.patch
* arm64-mm-implement-pte_devmap-support.patch
* arm64-mm-implement-pte_devmap-support-fix.patch
* mm-pgtable-drop-pgtable_t-variable-from-pte_fn_t-functions.patch
* mm-fail-when-offset-==-num-in-first-check-of-vm_map_pages_zero.patch
* mm-mmap-move-common-defines-to-mman-commonh.patch
* mm-swap-fix-release_pages-when-releasing-devmap-pages.patch
* mm-swap-fix-release_pages-when-releasing-devmap-pages-v2.patch
* mm-swap-fix-release_pages-when-releasing-devmap-pages-v3.patch
* mm-swap-fix-release_pages-when-releasing-devmap-pages-v4.patch
* mm-mmu_notifier-use-hlist_add_head_rcu.patch
* mm-add-account_locked_vm-utility-function.patch
* mm-add-account_locked_vm-utility-function-v3.patch
* mm-memory_hotplug-simplify-and-fix-check_hotplug_memory_range.patch
* s390x-mm-fail-when-an-altmap-is-used-for-arch_add_memory.patch
* s390x-mm-implement-arch_remove_memory.patch
* arm64-mm-add-temporary-arch_remove_memory-implementation.patch
* drivers-base-memory-pass-a-block_id-to-init_memory_block.patch
* drivers-base-memory-pass-a-block_id-to-init_memory_block-fix.patch
* mm-memory_hotplug-allow-arch_remove_pages-without-config_memory_hotremove.patch
* mm-memory_hotplug-create-memory-block-devices-after-arch_add_memory.patch
* mm-memory_hotplug-drop-mhp_memblock_api.patch
* mm-memory_hotplug-remove-memory-block-devices-before-arch_remove_memory.patch
* mm-memory_hotplug-make-unregister_memory_block_under_nodes-never-fail.patch
* mm-memory_hotplug-remove-zone-parameter-from-sparse_remove_one_section.patch
* mm-vmallocc-remove-node-argument.patch
* mm-vmallocc-preload-a-cpu-with-one-object-for-split-purpose.patch
* mm-vmallocc-get-rid-of-one-single-unlink_va-when-merge.patch
* mm-vmallocc-switch-to-warn_on-and-move-it-under-unlink_va.patch
* mm-vmalloc-spelling-s-configuraion-configuration.patch
* mm-large-system-hash-use-vmalloc-for-size-max_order-when-hashdist.patch
* mm-large-system-hash-clear-hashdist-when-only-one-node-with-memory-is-booted.patch
* mm-vmscan-remove-double-slab-pressure-by-incing-sc-nr_scanned.patch
* mm-vmscan-correct-some-vmscan-counters-for-thp-swapout.patch
* tools-vm-slabinfo-order-command-line-options.patch
* tools-vm-slabinfo-add-partial-slab-listing-to-x.patch
* tools-vm-slabinfo-add-option-to-sort-by-partial-slabs.patch
* tools-vm-slabinfo-add-sorting-info-to-help-menu.patch
* proc-use-down_read_killable-mmap_sem-for-proc-pid-maps.patch
* proc-use-down_read_killable-mmap_sem-for-proc-pid-smaps_rollup.patch
* proc-use-down_read_killable-mmap_sem-for-proc-pid-pagemap.patch
* proc-use-down_read_killable-mmap_sem-for-proc-pid-clear_refs.patch
* proc-use-down_read_killable-mmap_sem-for-proc-pid-map_files.patch
* proc-use-down_read_killable-mmap_sem-for-proc-pid-map_files-fix.patch
* mm-use-down_read_killable-for-locking-mmap_sem-in-access_remote_vm.patch
* z3fold-add-inter-page-compaction.patch
* z3fold-add-inter-page-compaction-fix.patch
* z3fold-add-inter-page-compaction-fix-2.patch
* mm-memory-failure-clarify-error-message.patch
* mm-oom_killer-add-task-uid-to-info-message-on-an-oom-kill.patch
* mm-oom_killer-add-task-uid-to-info-message-on-an-oom-kill-fix.patch
* x86-numa-always-initialize-all-possible-nodes.patch
* mm-be-more-verbose-about-zonelist-initialization.patch
* mm-gup-rename-nr-as-nr_pinned-in-get_user_pages_fast.patch
* mm-gup-fix-omission-of-check-on-foll_longterm-in-gup-fast-path.patch
* mm-gup_benchemark-add-longterm_benchmark-test-in-gup-fast-path.patch
* mm-proportional-memorylowmin-reclaim.patch
* mm-make-memoryemin-the-baseline-for-utilisation-determination.patch
* mm-make-memoryemin-the-baseline-for-utilisation-determination-fix.patch
* mm-vmscan-remove-unused-lru_pages-argument.patch
* mm-dont-expose-page-to-fast-gup-before-its-ready.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-hide-segfault-at-ffffffffff600000-dmesg-spam.patch
* vmcore-add-a-kernel-parameter-novmcoredd.patch
* vmcore-add-a-kernel-parameter-novmcoredd-fix.patch
* vmcore-add-a-kernel-parameter-novmcoredd-fix-fix.patch
* add-typeof_member-macro.patch
* proc-use-typeof_member-macro.patch
* kernel-fix-typos-and-some-coding-style-in-comments.patch
* linux-bitsh-make-bit-genmask-and-friends-available-in-assembly.patch
* arch-replace-_bitul-in-kernel-space-headers-with-bit.patch
* byteorder-sanity-check-toolchain-vs-kernel-endianess.patch
* byteorder-sanity-check-toolchain-vs-kernel-endianess-checkpatch-fixes.patch
* lib-genallocc-export-symbol-addr_in_gen_pool.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr-fix.patch
* lib-fix-possible-incorrect-result-from-rational-fractions-helper.patch
* tweak-list_poison2-for-better-code-generation-on-x86_64.patch
* lib-string-allow-searching-for-nul-with-strnchr.patch
* lib-test_string-avoid-masking-memset16-32-64-failures.patch
* lib-test_string-add-some-testcases-for-strchr-and-strnchr.patch
* lib-test_overflow-avoid-tainting-the-kernel-and-fix-wrap-size.patch
* lib-introduce-test_meminit-module.patch
* mm-ioremap-check-virtual-address-alignment-while-creating-huge-mappings.patch
* lib-string_helpers-fix-some-kerneldoc-warnings.patch
* lib-debugobjects-no-need-to-check-return-value-of-debugfs_create-functions.patch
* checkpatchpl-warn-on-duplicate-sysctl-local-variable.patch
* checkpatch-dont-interpret-stack-dumps-as-commit-ids.patch
* checkpatch-fix-something.patch
* binfmt_flat-remove-set-but-not-used-variable-inode.patch
* elf-delete-stale-comment.patch
* mm-kconfig-fix-neighboring-typos.patch
* mm-generalize-and-rename-notify_page_fault-as-kprobe_page_fault.patch
* coda-pass-the-host-file-in-vma-vm_file-on-mmap.patch
* uapi-linux-codah-use-__kernel_pid_t-for-userspace.patch
* uapi-linux-coda_psdevh-move-upc_req-definition-from-uapi-to-kernel-side-headers.patch
* coda-add-error-handling-for-fget.patch
* coda-potential-buffer-overflow-in-coda_psdev_write.patch
* coda-fix-build-using-bare-metal-toolchain.patch
* coda-dont-try-to-print-names-that-were-considered-too-long.patch
* uapi-linux-coda_psdevh-move-coda_req_-from-uapi-to-kernel-side-headers.patch
* coda-clean-up-indentation-replace-spaces-with-tab.patch
* coda-stop-using-struct-timespec-in-user-api.patch
* coda-change-codas-user-api-to-use-64-bit-time_t-in-timespec.patch
* coda-get-rid-of-coda_alloc.patch
* coda-get-rid-of-coda_free.patch
* coda-bump-module-version.patch
* coda-move-internal-defs-out-of-include-linux.patch
* coda-remove-uapi-linux-coda_psdevh.patch
* coda-destroy-mutex-in-put_super.patch
* coda-use-size-for-stat.patch
* coda-add-__init-to-init_coda_psdev.patch
* coda-remove-sysctl-object-from-module-when-unused.patch
* coda-remove-sb-test-in-coda_fid_to_inode.patch
* coda-ftoc-validity-check-integration.patch
* hfsplus-replace-strncpy-with-memcpy.patch
* ufs-remove-set-but-not-used-variable-usb3.patch
* nds32-fix-asm-syscallh.patch
* hexagon-define-syscall_get_error-and-syscall_get_return_value.patch
* mips-define-syscall_get_error.patch
* parisc-define-syscall_get_error.patch
* powerpc-define-syscall_get_error.patch
* ptrace-add-ptrace_get_syscall_info-request.patch
* selftests-ptrace-add-a-test-case-for-ptrace_get_syscall_info.patch
* selftests-ptrace-add-a-test-case-for-ptrace_get_syscall_info-checkpatch-fixes.patch
* signal-reorder-struct-sighand_struct.patch
* signal-simplify-set_user_sigmask-restore_user_sigmask.patch
* select-change-do_poll-to-return-erestartnohand-rather-than-eintr.patch
* select-shift-restore_saved_sigmask_unless-into-poll_select_copy_remaining.patch
* coredump-split-pipe-command-whitespace-before-expanding-template.patch
* rapidio-mport_cdev-nul-terminate-some-strings.patch
* convert-struct-pid-count-to-refcount_t.patch
* aio-simplify-read_events.patch
* ipc-mqueue-only-perform-resource-calculation-if-user-valid.patch
* ipc-consolidate-all-xxxctl_down-functions.patch
* lz4-fix-spelling-and-copy-paste-errors-in-documentation.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
* pinctrl-fix-pxa2xxc-build-warnings.patch
* proc-sysctl-add-shared-variables-for-range-check.patch
* proc-sysctl-add-shared-variables-for-range-check-fix.patch
* proc-sysctl-add-shared-variables-for-range-check-fix-2.patch
* proc-sysctl-add-shared-variables-for-range-check-fix-2-fix.patch
* fs-select-use-struct_size-in-kmalloc.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
