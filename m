Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C596B2BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 02:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389045AbfGQAPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 20:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbfGQAPg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:15:36 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A712184E;
        Wed, 17 Jul 2019 00:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563322535;
        bh=VWazqoqxzRcg9+xvQ08CTUhXDgkOfK9yOjMAWZaWwNc=;
        h=Date:From:To:Subject:From;
        b=ZfXxA78hwAdFsushpnuxaKVDTdmfXDS6J8xfa/uYtNrA3sqqb0MtVdKGZTYJshf4I
         NHl4D9KYNCoczL+XZfeGCpN8HmErEzHfOA99K3SXTzb12MAbP61Bo8NNg40jtYyrUf
         PcsS702PZwHntB66gXFmkD4Qj6NwmyQAjL8HrY9I=
Date:   Tue, 16 Jul 2019 17:15:34 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2019-07-16-17-14 uploaded
Message-ID: <20190717001534.83sL1%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.10
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2019-07-16-17-14 has been uploaded to

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


This mmotm tree contains the following patches against 5.2:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-z3foldc-dont-try-to-use-buddy-slots-after-free.patch
* thp-fix-unused-shmem_parse_huge-function-warning.patch
* lib-mpi-fix-building-with-32-bit-x86.patch
* slab-work-around-clang-bug-42570.patch
* mm-cma-fix-a-typo-alloc_cma-cma_alloc-in-cma_release-comments.patch
* mm-z3foldc-allow-__gfp_highmem-in-z3fold_alloc.patch
* mm-memcontrol-keep-local-vm-counters-in-sync-with-the-hierarchical-ones.patch
* mm-vmscan-add-a-new-member-reclaim_state-in-struct-shrink_control.patch
* mm-vmscan-calculate-reclaimed-slab-caches-in-all-reclaim-paths.patch
* mm-vmscanc-add-checks-for-incorrect-handling-of-current-reclaim_state.patch
* mm-z3foldc-remove-z3fold_migration-trylock.patch
* mm-z3foldc-reinitialize-zhdr-structs-after-migration.patch
* cma-fail-if-fixed-declaration-cant-be-honored.patch
* mm-fix-the-map_uninitialized-flag.patch
* mm-provide-a-print_vma_addr-stub-for-config_mmu.patch
* mm-stub-out-all-of-swapopsh-for-config_mmu.patch
* proc-hide-segfault-at-ffffffffff600000-dmesg-spam.patch
* vmcore-add-a-kernel-parameter-novmcoredd.patch
* add-typeof_member-macro.patch
* proc-use-typeof_member-macro.patch
* proc-test-proc-sysvipc-vs-setnsclone_newipc.patch
* fs-fix-the-default-values-of-i_uid-i_gid-on-proc-sys-inodes.patch
* kernel-fix-typos-and-some-coding-style-in-comments.patch
* linux-bitsh-make-bit-genmask-and-friends-available-in-assembly.patch
* arch-replace-_bitul-in-kernel-space-headers-with-bit.patch
* drop-unused-isa_page_to_bus.patch
* asm-generic-fix-a-compilation-warning.patch
* get_maintainer-add-ability-to-skip-moderated-mailing-lists.patch
* tweak-list_poison2-for-better-code-generation-on-x86_64.patch
* lib-string-allow-searching-for-nul-with-strnchr.patch
* lib-test_string-avoid-masking-memset16-32-64-failures.patch
* lib-test_string-add-some-testcases-for-strchr-and-strnchr.patch
* lib-test_overflow-avoid-tainting-the-kernel-and-fix-wrap-size.patch
* lib-introduce-test_meminit-module.patch
* mm-ioremap-check-virtual-address-alignment-while-creating-huge-mappings.patch
* mm-ioremap-probe-platform-for-p4d-huge-map-support.patch
* lib-string_helpers-fix-some-kerneldoc-warnings.patch
* lib-test_meminit-fix-wmaybe-uninitialized-false-positive.patch
* lib-test_meminitc-minor-test-fixes.patch
* rbtree-avoid-generating-code-twice-for-the-cached-versions.patch
* checkpatchpl-warn-on-duplicate-sysctl-local-variable.patch
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
* coda-add-hinting-support-for-partial-file-caching.patch
* hfsplus-replace-strncpy-with-memcpy.patch
* ufs-remove-set-but-not-used-variable-usb3.patch
* fs-reiserfs-journal-change-return-type-of-dirty_one_transaction.patch
* nds32-fix-asm-syscallh.patch
* hexagon-define-syscall_get_error-and-syscall_get_return_value.patch
* mips-define-syscall_get_error.patch
* parisc-define-syscall_get_error.patch
* powerpc-define-syscall_get_error.patch
* ptrace-add-ptrace_get_syscall_info-request.patch
* selftests-ptrace-add-a-test-case-for-ptrace_get_syscall_info.patch
* signal-reorder-struct-sighand_struct.patch
* signal-simplify-set_user_sigmask-restore_user_sigmask.patch
* select-change-do_poll-to-return-erestartnohand-rather-than-eintr.patch
* select-shift-restore_saved_sigmask_unless-into-poll_select_copy_remaining.patch
* rapidio-mport_cdev-nul-terminate-some-strings.patch
* convert-struct-pid-count-to-refcount_t.patch
* pps-clear-offset-flags-in-pps_setparams-ioctl.patch
* scripts-gdb-add-lx-genpd-summary-command.patch
* scripts-gdb-add-helpers-to-find-and-list-devices.patch
* bug-fix-cut-here-for-warn_on-for-__warn_taint-architectures.patch
* ipc-mqueue-only-perform-resource-calculation-if-user-valid.patch
* lz4-fix-spelling-and-copy-paste-errors-in-documentation.patch
* device-dax-fix-memory-and-resource-leak-if-hotplug-fails.patch
* mm-hotplug-make-remove_memory-interface-useable.patch
* device-dax-hotremove-persistent-memory-that-is-used-like-normal-ram.patch
* mm-move-map_sync-to-asm-generic-mman-commonh.patch
* mm-mmap-move-common-defines-to-mman-commonh.patch
* mm-clean-up-is_device__page-definitions.patch
* mm-introduce-arch_has_pte_devmap.patch
* arm64-mm-implement-pte_devmap-support.patch
* mm-add-account_locked_vm-utility-function.patch
* fs-select-use-struct_size-in-kmalloc.patch
* mm-hmm-fix-bad-subpage-pointer-in-try_to_unmap_one.patch
* revert-kmemleak-allow-to-coexist-with-fault-injection.patch
* ocfs2-remove-set-but-not-used-variable-last_hash.patch
* ocfs2-clear-zero-in-unaligned-direct-io.patch
* ocfs2-clear-zero-in-unaligned-direct-io-checkpatch-fixes.patch
* ocfs2-wait-for-recovering-done-after-direct-unlock-request.patch
* ocfs2-checkpoint-appending-truncate-log-transaction-before-flushing.patch
* ramfs-support-o_tmpfile.patch
  mm.patch
* mm-vmscan-expose-cgroup_ino-for-memcg-reclaim-tracepoints.patch
* mm-mmap-fix-the-adjusted-length-error.patch
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
* mm-sparse-set-section-nid-for-hot-add-memory.patch
* mm-sparse-fix-memory-leak-of-sparsemap_buf-in-aliged-memory.patch
* mm-sparse-fix-memory-leak-of-sparsemap_buf-in-aliged-memory-fix.patch
* mm-sparse-fix-align-without-power-of-2-in-sparse_buffer_alloc.patch
* mm-mempolicy-make-the-behavior-consistent-when-mpol_mf_move-and-mpol_mf_strict-were-specified.patch
* mm-mempolicy-handle-vma-with-unmovable-pages-mapped-correctly-in-mbind.patch
* mm-oom_killer-add-task-uid-to-info-message-on-an-oom-kill.patch
* mm-oom_killer-add-task-uid-to-info-message-on-an-oom-kill-fix.patch
* mm-thp-make-transhuge_vma_suitable-available-for-anonymous-thp.patch
* mm-thp-make-transhuge_vma_suitable-available-for-anonymous-thp-fix.patch
* mm-thp-fix-false-negative-of-shmem-vmas-thp-eligibility.patch
* mm-proportional-memorylowmin-reclaim.patch
* mm-make-memoryemin-the-baseline-for-utilisation-determination.patch
* mm-make-memoryemin-the-baseline-for-utilisation-determination-fix.patch
* mm-vmscan-remove-unused-lru_pages-argument.patch
* mm-dont-expose-page-to-fast-gup-before-its-ready.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* lib-genallocc-export-symbol-addr_in_gen_pool.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr-fix.patch
* lib-fix-possible-incorrect-result-from-rational-fractions-helper.patch
* checkpatch-added-warnings-in-favor-of-strscpy.patch
* checkpatch-dont-interpret-stack-dumps-as-commit-ids.patch
* checkpatch-fix-something.patch
* fat-add-nobarrier-to-workaround-the-strange-behavior-of-device.patch
* coredump-split-pipe-command-whitespace-before-expanding-template.patch
* aio-simplify-read_events.patch
* resource-fix-locking-in-find_next_iomem_res.patch
* resource-fix-locking-in-find_next_iomem_res-fix.patch
* resource-avoid-unnecessary-lookups-in-find_next_iomem_res.patch
* ipc-consolidate-all-xxxctl_down-functions.patch
  linux-next.patch
  diff-sucks.patch
* pinctrl-fix-pxa2xxc-build-warnings.patch
* mm-section-numbers-use-the-type-unsigned-long.patch
* mm-section-numbers-use-the-type-unsigned-long-fix.patch
* mm-section-numbers-use-the-type-unsigned-long-v3.patch
* drivers-base-memory-use-unsigned-long-for-block-ids.patch
* mm-make-register_mem_sect_under_node-static.patch
* mm-memory_hotplug-rename-walk_memory_range-and-pass-startsize-instead-of-pfns.patch
* mm-memory_hotplug-move-and-simplify-walk_memory_blocks.patch
* drivers-base-memoryc-get-rid-of-find_memory_block_hinted.patch
* drivers-base-memoryc-get-rid-of-find_memory_block_hinted-v3.patch
* drivers-base-memoryc-get-rid-of-find_memory_block_hinted-v3-fix.patch
* mm-sparsemem-introduce-struct-mem_section_usage.patch
* mm-sparsemem-introduce-a-section_is_early-flag.patch
* mm-sparsemem-add-helpers-track-active-portions-of-a-section-at-boot.patch
* mm-hotplug-prepare-shrink_zone-pgdat_span-for-sub-section-removal.patch
* mm-sparsemem-convert-kmalloc_section_memmap-to-populate_section_memmap.patch
* mm-hotplug-kill-is_dev_zone-usage-in-__remove_pages.patch
* mm-kill-is_dev_zone-helper.patch
* mm-sparsemem-prepare-for-sub-section-ranges.patch
* mm-sparsemem-support-sub-section-hotplug.patch
* mm-sparsemem-support-sub-section-hotplug-fix.patch
* mm-sparsemem-support-sub-section-hotplug-fix-fix.patch
* mm-document-zone_device-memory-model-implications.patch
* mm-document-zone_device-memory-model-implications-fix.patch
* mm-devm_memremap_pages-enable-sub-section-remap.patch
* libnvdimm-pfn-fix-fsdax-mode-namespace-info-block-zero-fields.patch
* libnvdimm-pfn-stop-padding-pmem-namespaces-to-section-alignment.patch
* mm-sparsemem-cleanup-section-number-data-types.patch
* mm-sparsemem-cleanup-section-number-data-types-fix.patch
* mm-migrate-remove-unused-mode-argument.patch
* proc-sysctl-add-shared-variables-for-range-check.patch
* proc-sysctl-add-shared-variables-for-range-check-fix-2.patch
* proc-sysctl-add-shared-variables-for-range-check-fix-2-fix.patch
* proc-sysctl-add-shared-variables-for-range-check-fix-3.patch
* proc-sysctl-add-shared-variables-for-range-check-fix-4.patch
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
