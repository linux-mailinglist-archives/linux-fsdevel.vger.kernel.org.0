Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9EE49D9D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 06:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiA0FFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 00:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiA0FFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:05:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64480C06161C;
        Wed, 26 Jan 2022 21:05:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65979B82150;
        Thu, 27 Jan 2022 05:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3A7C340E4;
        Thu, 27 Jan 2022 05:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643259897;
        bh=Pl6AkKtJBXXpfMO6o3YuHSuGHLh+V7i9o7LE/oJPEgk=;
        h=Date:From:To:Subject:From;
        b=fQby7dYIGvkagXrBiKCuWYHpVmO//l39NS6wJLzpR04LLNJpn0V0VP7QSCOMWSMLE
         X4AZ8SvqT3Lj+xxuOeF0JKrPeb4WLT2Wd4wfPcnfNBALmvDQ7HifOwJdV2xaumY/UZ
         xgDunKUr2kuGGHkRKEUzD0AOv2AJG+96NI5RZTzE=
Date:   Wed, 26 Jan 2022 21:04:56 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2022-01-26-21-04 uploaded
Message-ID: <20220127050456.M1eh-ltbc%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2022-01-26-21-04 has been uploaded to

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



This mmotm tree contains the following patches against 5.17-rc1:
(patches marked "*" will be included in linux-next)

  origin.patch
* include-linux-sysctlh-fix-register_sysctl_mount_point-return-type.patch
* binfmt_misc-fix-crash-when-load-unload-module.patch
* ia64-make-ia64_mca_recovery-bool-instead-of-tristate.patch
* memory-failure-fetch-compound_head-after-pgmap_pfn_valid.patch
* mm-page-mapping-folio-mapping-should-have-the-same-offset.patch
* tools-testing-scatterlist-add-missing-defines.patch
* kasan-test-fix-compatibility-with-fortify_source.patch
* mm-use-compare-exchange-operation-to-set-kasan-page-tag.patch
* psi-fix-no-previous-prototype-warnings-when-config_cgroups=n.patch
* psi-fix-defined-but-not-used-warnings-when-config_proc_fs=n.patch
* mm-fix-panic-in-__alloc_pages.patch
* jbd2-export-jbd2_journal__journal_head.patch
* ocfs2-fix-a-deadlock-when-commit-trans.patch
* mm-fix-invalid-page-pointer-returned-with-foll_pin-gups.patch
* fs-proc-task_mmuc-dont-read-mapcount-for-migration-entry.patch
* revert-mm-page_isolation-unset-migratetype-directly-for-non-buddy-page.patch
* mm-debug_vm_pgtable-remove-pte-entry-from-the-page-table.patch
* mm-page_table_check-use-unsigned-long-for-page-counters-and-cleanup.patch
* mm-khugepaged-unify-collapse-pmd-clear-flush-and-free.patch
* mm-page_table_check-check-entries-at-pmd-levels.patch
* coredump-also-dump-first-pages-of-non-executable-elf-libraries.patch
* mm-pgtable-define-pte_index-so-that-preprocessor-could-recognize-it.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* procfs-prevent-unpriveleged-processes-accessing-fdinfo-dir.patch
* ntfs-add-sanity-check-on-allocation-size.patch
* ocfs2-cleanup-some-return-variables.patch
* ocfs2-reflink-deadlock-when-clone-file-to-the-same-directory-simultaneously.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* mount-warn-only-once-about-timestamp-range-expiration.patch
  mm.patch
* kasan-page_alloc-deduplicate-should_skip_kasan_poison.patch
* kasan-page_alloc-move-tag_clear_highpage-out-of-kernel_init_free_pages.patch
* kasan-page_alloc-merge-kasan_free_pages-into-free_pages_prepare.patch
* kasan-page_alloc-simplify-kasan_poison_pages-call-site.patch
* kasan-page_alloc-init-memory-of-skipped-pages-on-free.patch
* kasan-drop-skip_kasan_poison-variable-in-free_pages_prepare.patch
* mm-clarify-__gfp_zerotags-comment.patch
* kasan-only-apply-__gfp_zerotags-when-memory-is-zeroed.patch
* kasan-page_alloc-refactor-init-checks-in-post_alloc_hook.patch
* kasan-page_alloc-merge-kasan_alloc_pages-into-post_alloc_hook.patch
* kasan-page_alloc-combine-tag_clear_highpage-calls-in-post_alloc_hook.patch
* kasan-page_alloc-move-setpageskipkasanpoison-in-post_alloc_hook.patch
* kasan-page_alloc-move-kernel_init_free_pages-in-post_alloc_hook.patch
* kasan-page_alloc-rework-kasan_unpoison_pages-call-site.patch
* kasan-clean-up-metadata-byte-definitions.patch
* kasan-define-kasan_vmalloc_invalid-for-sw_tags.patch
* kasan-x86-arm64-s390-rename-functions-for-modules-shadow.patch
* kasan-vmalloc-drop-outdated-vm_kasan-comment.patch
* kasan-reorder-vmalloc-hooks.patch
* kasan-add-wrappers-for-vmalloc-hooks.patch
* kasan-vmalloc-reset-tags-in-vmalloc-functions.patch
* kasan-fork-reset-pointer-tags-of-vmapped-stacks.patch
* kasan-arm64-reset-pointer-tags-of-vmapped-stacks.patch
* kasan-vmalloc-add-vmalloc-tagging-for-sw_tags.patch
* kasan-vmalloc-arm64-mark-vmalloc-mappings-as-pgprot_tagged.patch
* kasan-vmalloc-unpoison-vm_alloc-pages-after-mapping.patch
* kasan-mm-only-define-___gfp_skip_kasan_poison-with-hw_tags.patch
* kasan-page_alloc-allow-skipping-unpoisoning-for-hw_tags.patch
* kasan-page_alloc-allow-skipping-memory-init-for-hw_tags.patch
* kasan-vmalloc-add-vmalloc-tagging-for-hw_tags.patch
* kasan-vmalloc-only-tag-normal-vmalloc-allocations.patch
* kasan-arm64-dont-tag-executable-vmalloc-allocations.patch
* kasan-mark-kasan_arg_stacktrace-as-__initdata.patch
* kasan-clean-up-feature-flags-for-hw_tags-mode.patch
* kasan-add-kasanvmalloc-command-line-flag.patch
* kasan-allow-enabling-kasan_vmalloc-and-sw-hw_tags.patch
* arm64-select-kasan_vmalloc-for-sw-hw_tags-modes.patch
* kasan-documentation-updates.patch
* kasan-improve-vmalloc-tests.patch
* mm-memremap-avoid-calling-kasan_remove_zero_shadow-for-device-private-memory.patch
* tools-vm-page_owner_sortc-sort-by-stacktrace-before-culling.patch
* tools-vm-page_owner_sortc-sort-by-stacktrace-before-culling-fix.patch
* tools-vm-page_owner_sortc-support-sorting-by-stack-trace.patch
* tools-vm-page_owner_sortc-add-switch-between-culling-by-stacktrace-and-txt.patch
* tools-vm-page_owner_sortc-support-sorting-pid-and-time.patch
* tools-vm-page_owner_sortc-two-trivial-fixes.patch
* tools-vm-page_owner_sortc-delete-invalid-duplicate-code.patch
* documentation-vm-page_ownerrst-update-the-documentation.patch
* documentation-vm-page_ownerrst-update-the-documentation-fix.patch
* docs-vm-fix-unexpected-indentation-warns-in-page_owner.patch
* mm-generalize-arch_has_filter_pgprot.patch
* mm-vmalloc-remove-unneeded-function-forward-declaration.patch
* vmap-dont-allow-invalid-pages.patch
* mm-utilc-make-kvfree-safe-for-calling-while-holding-spinlocks.patch
* mm-page_alloc-avoid-merging-non-fallbackable-pageblocks-with-others.patch
* mm-page_alloc-add-same-penalty-is-enough-to-get-round-robin-order.patch
* mm-page_alloc-add-penalty-to-local_node.patch
* mm-mmzonec-use-try_cmpxchg-in-page_cpupid_xchg_last.patch
* mm-discard-__gfp_atomic.patch
* mm-hwpoison-remove-obsolete-comment.patch
* mm-hwpoison-fix-error-page-recovered-but-reported-not-recovered.patch
* mm-hugetlb-free-the-2nd-vmemmap-page-associated-with-each-hugetlb-page.patch
* mm-hugetlb-replace-hugetlb_free_vmemmap_enabled-with-a-static_key.patch
* mm-sparsemem-use-page-table-lock-to-protect-kernel-pmd-operations.patch
* selftests-vm-add-a-hugetlb-test-case.patch
* mm-sparsemem-move-vmemmap-related-to-hugetlb-to-config_hugetlb_page_free_vmemmap.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt.patch
* mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt-fix.patch
* mm-cma-provide-option-to-opt-out-from-exposing-pages-on-activation-failure.patch
* powerpc-fadump-opt-out-from-freeing-pages-on-cma-activation-failure.patch
* mm-vmstat-add-event-for-ksm-swapping-in-copy.patch
* mm-balloon_compaction-make-balloon-page-compaction-callbacks-static.patch
* mm-fix-race-between-madv_free-reclaim-and-blkdev-direct-io-read.patch
* mm-rmap-convert-from-atomic_t-to-refcount_t-on-anon_vma-refcount.patch
* mm-zswapc-allow-handling-just-same-value-filled-pages.patch
* highmem-document-kunmap_local.patch
* highmem-document-kunmap_local-v2.patch
* mm-highmem-remove-unnecessary-done-label.patch
* mm-hmmc-remove-unneeded-local-variable-ret.patch
* mm-damon-dbgfs-init_regions-use-target-index-instead-of-target-id.patch
* docs-admin-guide-mm-damon-usage-update-for-changed-initail_regions-file-input.patch
* mm-damon-core-move-damon_set_targets-into-dbgfs.patch
* mm-damon-remove-the-target-id-concept.patch
* mm-damon-remove-redundant-page-validation.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* proc-alloc-path_max-bytes-for-proc-pid-fd-symlinks.patch
* proc-alloc-path_max-bytes-for-proc-pid-fd-symlinks-fix.patch
* proc-vmcore-fix-possible-deadlock-on-concurrent-mmap-and-read.patch
* proc-sysctl-make-protected_-world-readable.patch
* kconfigdebug-make-debug_info-selectable-from-a-choice.patch
* lz4-fix-lz4_decompress_safe_partial-read-out-of-bound.patch
* fs-binfmt_elf-fix-at_phdr-for-unusual-elf-files.patch
* fs-binfmt_elf-refactor-load_elf_binary-function.patch
* elf-fix-overflow-in-total-mapping-size-calculation.patch
* init-mainc-silence-some-wunused-parameter-warnings.patch
* fs-pipe-use-kvcalloc-to-allocate-a-pipe_buffer-array.patch
* fs-pipe-local-vars-has-to-match-types-of-proper-pipe_inode_info-fields.patch
* minix-fix-bug-when-opening-a-file-with-o_direct.patch
* fs-exec-require-argv-presence-in-do_execveat_common.patch
* kexec-make-crashk_res-crashk_low_res-and-crash_notes-symbols-always-visible.patch
* riscv-mm-init-use-is_enabledconfig_kexec_core-instead-of-ifdef.patch
* x86-setup-use-is_enabledconfig_kexec_core-instead-of-ifdef.patch
* arm64-mm-use-is_enabledconfig_kexec_core-instead-of-ifdef.patch
* arm-use-is_enabledconfig_kexec_core-instead-of-ifdef.patch
* docs-sysctl-kernel-add-missing-bit-to-panic_print.patch
* panic-add-option-to-dump-all-cpus-backtraces-in-panic_print.patch
* panic-allow-printing-extra-panic-information-on-kdump.patch
* kcov-split-ioctl-handling-into-locked-and-unlocked-parts.patch
* kcov-properly-handle-subsequent-mmap-calls.patch
* selftests-set-the-build-variable-to-absolute-path.patch
* selftests-add-and-export-a-kernel-uapi-headers-path.patch
* selftests-correct-the-headers-install-path.patch
* selftests-futex-add-the-uapi-headers-include-variable.patch
* selftests-kvm-add-the-uapi-headers-include-variable.patch
* selftests-landlock-add-the-uapi-headers-include-variable.patch
* selftests-net-add-the-uapi-headers-include-variable.patch
* selftests-mptcp-add-the-uapi-headers-include-variable.patch
* selftests-vm-add-the-uapi-headers-include-variable.patch
* selftests-vm-remove-dependecy-from-internal-kernel-macros.patch
* ipc-mqueue-use-get_tree_nodev-in-mqueue_get_tree.patch
* ipc-sem-do-not-sleep-with-a-spin-lock-held.patch
  linux-next.patch
* sysctl-documentation-fix-table-format-warning.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  mutex-subsystem-synchro-test-module-fix.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
