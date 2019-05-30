Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20A52F50A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 06:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfE3Enz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 00:43:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36913 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388713AbfE3Enw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 00:43:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so2894785wmo.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 21:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5qPZvgVP8NOMLm06bALUXsuoK8ZT2cPKrJmcqD/IBQ=;
        b=sArDEhzaQUugnv+rg9XrGWlVGGOCUmy9Dfk6vEgN0CJMPlJisfjlDKABToCzbgJ0JI
         OIDQSUjZo5JXwlfcXjZJaCqALoigMQBwYII1myaOo7+7oSWF5ndUwHHSJQyaqjE6IVP4
         Nsehe7MDX1lmaaOct8LVaKdWMDFactOOSJBqJAvLG8Ygmr4zz4qPBIyXTjju8tBAJUNA
         /f9neOAV4nItSb3RDbjRBYepOJLCpARih/5WV0hPLLt1ZQvj1xsI6kuH+DKwYOLK314v
         6Baht+FY1I1GvoQFQsOgkI9G5t+AbFf8SyomAVAynM44la1Yvn7TWRs2fGRsKTN6A9qA
         ZWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5qPZvgVP8NOMLm06bALUXsuoK8ZT2cPKrJmcqD/IBQ=;
        b=XIlOJMJd0G6zP6HTPsgD7WK8jeU/oUzS9q128KwGq6eD0K38kt5zyONITEtTzeQS7h
         Pai0idRRk+Tw0p8o7JHR8+EbSSYF1Ii1QxOiwLD7iBj2Jb3qefAS5PU1w508wfFPrEec
         OwH9bbf+X/m7UuGwbbWInO9WzKnhMEGI0vf0pA9Arq9ZffbPQ96gY4kbYauFSj7Ex3hI
         uB7IfD7FW5vGEslquD6yrBItmBvZEzJaQYnALOMvWAoCmlhsuB9PTwGJWeVEIm2I34w+
         whqfVNQD/hn4OWRZjCSIQrAwrv+fj3Z/j/Y2cX+kEYkIcqvuZ2nL4gHN9UM+wUHJi5ye
         PwTg==
X-Gm-Message-State: APjAAAXkgzJVoXAHkD7YxxX6npDGA/hEaGmnirhHxs8j8jaFN3eDhGJ3
        ucBeP0rfWhv/fbk60dEusZeWihvjPHD5IGhk2ZihbA==
X-Google-Smtp-Source: APXvYqzxjSTf3kMK/zEFjv9OWfD2WSTqc94YNpCG8qkzJpXanDbnmgOMM8pnIzrs8usFnvKxyx4rvBqWH7CUbhc/8t0=
X-Received: by 2002:a1c:ed07:: with SMTP id l7mr799762wmh.148.1559191428248;
 Wed, 29 May 2019 21:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190530035339.hJr4GziBa%akpm@linux-foundation.org>
In-Reply-To: <20190530035339.hJr4GziBa%akpm@linux-foundation.org>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Wed, 29 May 2019 21:43:36 -0700
Message-ID: <CAA25o9RFhS=qm=B_mYAdQeAUAi7pLbXttWJfw7yKMWQQAXhhAw@mail.gmail.com>
Subject: Re: mmotm 2019-05-29-20-52 uploaded
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-next@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My apologies but the patch

mm-smaps-split-pss-into-components.patch

has a bug (does not update private_clean and private_dirty).  Please
do not include it.  I will resubmit a corrected version.

Thanks.




On Wed, May 29, 2019 at 8:53 PM <akpm@linux-foundation.org> wrote:
>
> The mm-of-the-moment snapshot 2019-05-29-20-52 has been uploaded to
>
>    http://www.ozlabs.org/~akpm/mmotm/
>
> mmotm-readme.txt says
>
> README for mm-of-the-moment:
>
> http://www.ozlabs.org/~akpm/mmotm/
>
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
>
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
>
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
>
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.
>
>
> A full copy of the full kernel tree with the linux-next and mmotm patches
> already applied is available through git within an hour of the mmotm
> release.  Individual mmotm releases are tagged.  The master branch always
> points to the latest release, so it's constantly rebasing.
>
> http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/
>
>
>
> The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> contains daily snapshots of the -mm tree.  It is updated more frequently
> than mmotm, and is untested.
>
> A git copy of this tree is available at
>
>         http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/
>
> and use of this tree is similar to
> http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/, described above.
>
>
> This mmotm tree contains the following patches against 5.2-rc2:
> (patches marked "*" will be included in linux-next)
>
>   origin.patch
> * mm-fix-documentation-vm-hmmrst-sphinx-warnings.patch
> * lib-sortc-fix-kernel-doc-notation-warnings.patch
> * mm-vmallocc-fix-typo-in-comment.patch
> * mm-slab-remove-obsoleted-config_debug_slab_leak.patch
> * arch-arm-boot-compressed-decompressc-fix-build-error-due-to-lz4-changes.patch
> * mm-mmu_gather-remove-__tlb_reset_range-for-force-flush.patch
> * mm-mmu_gather-remove-__tlb_reset_range-for-force-flush-checkpatch-fixes.patch
> * kernel-fork-make-max_threads-symbol-static.patch
> * prctl_set_mm-refactor-checks-from-validate_prctl_map.patch
> * prctl_set_mm-refactor-checks-from-validate_prctl_map-checkpatch-fixes.patch
> * prctl_set_mm-downgrade-mmap_sem-to-read-lock.patch
> * prctl_set_mm-downgrade-mmap_sem-to-read-lock-checkpatch-fixes.patch
> * mm-consider-subtrees-in-memoryevents.patch
> * memcg-make-it-work-on-sparse-non-0-node-systems.patch
> * ocfs2-fix-error-path-kobject-memory-leak.patch
> * mm-gup-continue-vm_fault_retry-processing-event-for-pre-faults.patch
> * scripts-gdb-fix-invocation-when-config_common_clk-is-not-set.patch
> * z3fold-fix-sheduling-while-atomic.patch
> * kasan-initialize-tag-to-0xff-in-__kasan_kmalloc.patch
> * spdxcheckpy-fix-directory-structures-v3.patch
> * iommu-intel-fix-variable-iommu-set-but-not-used.patch
> * signal-trace_signal_deliver-when-signal_group_exit.patch
> * generic-radix-trees-fix-kerneldoc-comment.patch
> * mm-compaction-make-sure-we-isolate-a-valid-pfn.patch
> * convert-struct-pid-count-to-refcount_t.patch
> * mm-dev_pfn-exclude-memory_device_private-while-computing-virtual-address.patch
> * fs-proc-allow-reporting-eip-esp-for-all-coredumping-threads.patch
> * mm-mempolicy-fix-an-incorrect-rebind-node-in-mpol_rebind_nodemask.patch
> * binfmt_flat-make-load_flat_shared_library-work.patch
> * mm-fix-trying-to-reclaim-unevicable-lru-page.patch
> * mm-memcontrol-dont-batch-updates-of-local-vm-stats-and-events.patch
> * list_lru-fix-memory-leak-in-__memcg_init_list_lru_node.patch
> * userfaultfd-selftest-fix-compiler-warning.patch
> * scripts-decode_stacktracesh-prefix-addr2line-with-cross_compile.patch
> * mm-mlockall-error-for-flag-mcl_onfault.patch
> * mm-fix-recent_rotated-history.patch
> * fs-ocfs2-fix-race-in-ocfs2_dentry_attach_lock.patch
> * scripts-decode_stacktrace-match-basepath-using-shell-prefix-operator-not-regex.patch
> * scripts-decode_stacktrace-look-for-modules-with-kodebug-extension.patch
> * scripts-decode_stacktrace-look-for-modules-with-kodebug-extension-v2.patch
> * scripts-spellingtxt-drop-sepc-from-the-misspelling-list.patch
> * scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix.patch
> * scripts-spellingtxt-add-spelling-fix-for-prohibited.patch
> * debugobjects-move-printk-out-of-db-lock-critical-sections.patch
> * ocfs2-add-last-unlock-times-in-locking_state.patch
> * ocfs2-add-locking-filter-debugfs-file.patch
> * fs-ocfs-fix-spelling-mistake-hearbeating-heartbeat.patch
> * ocfs2-clear-zero-in-unaligned-direct-io.patch
> * ocfs2-clear-zero-in-unaligned-direct-io-checkpatch-fixes.patch
> * ocfs2-wait-for-recovering-done-after-direct-unlock-request.patch
> * ocfs2-checkpoint-appending-truncate-log-transaction-before-flushing.patch
> * ramfs-support-o_tmpfile.patch
>   mm.patch
> * mm-slub-avoid-double-string-traverse-in-kmem_cache_flags.patch
> * kmemleak-fix-check-for-softirq-context.patch
> * mm-kasan-print-frame-description-for-stack-bugs.patch
> * device-dax-fix-memory-and-resource-leak-if-hotplug-fails.patch
> * mm-hotplug-make-remove_memory-interface-useable.patch
> * device-dax-hotremove-persistent-memory-that-is-used-like-normal-ram.patch
> * mm-move-map_sync-to-asm-generic-mman-commonh.patch
> * include-linux-pfn_th-remove-pfn_t_to_virt.patch
> * arm-remove-arch_select_memory_model.patch
> * s390-remove-arch_select_memory_model.patch
> * sparc-remove-arch_select_memory_model.patch
> * mm-gupc-make-follow_page_mask-static.patch
> * mm-migrate-remove-unused-mode-argument.patch
> * mm-trivial-clean-up-in-insert_page.patch
> * mm-make-config_huge_page-wrappers-into-static-inlines.patch
> * swap-ifdef-struct-vm_area_struct-swap_readahead_info.patch
> * mm-failslab-by-default-do-not-fail-allocations-with-direct-reclaim-only.patch
> * mm-fix-an-overly-long-line-in-read_cache_page.patch
> * mm-dont-cast-readpage-to-filler_t-for-do_read_cache_page.patch
> * jffs2-pass-the-correct-prototype-to-read_cache_page.patch
> * 9p-pass-the-correct-prototype-to-read_cache_page.patch
> * mm-filemap-correct-the-comment-about-vm_fault_retry.patch
> * mm-swap-fix-race-between-swapoff-and-some-swap-operations.patch
> * mm-swap-simplify-total_swapcache_pages-with-get_swap_device.patch
> * mm-swap-use-rbtree-for-swap_extent.patch
> * mm-swap-use-rbtree-for-swap_extent-fix.patch
> * memcg-oom-no-oom-kill-for-__gfp_retry_mayfail.patch
> * memcg-fsnotify-no-oom-kill-for-remote-memcg-charging.patch
> * mm-vmscan-expose-cgroup_ino-for-memcg-reclaim-tracepoints.patch
> * mm-memcg-introduce-memoryeventslocal.patch
> * mm-mmap-fix-the-adjusted-length-error.patch
> * asm-generic-x86-introduce-generic-pte_allocfree_one.patch
> * alpha-switch-to-generic-version-of-pte-allocation.patch
> * arm-switch-to-generic-version-of-pte-allocation.patch
> * arm64-switch-to-generic-version-of-pte-allocation.patch
> * csky-switch-to-generic-version-of-pte-allocation.patch
> * m68k-sun3-switch-to-generic-version-of-pte-allocation.patch
> * mips-switch-to-generic-version-of-pte-allocation.patch
> * nds32-switch-to-generic-version-of-pte-allocation.patch
> * nios2-switch-to-generic-version-of-pte-allocation.patch
> * parisc-switch-to-generic-version-of-pte-allocation.patch
> * riscv-switch-to-generic-version-of-pte-allocation.patch
> * um-switch-to-generic-version-of-pte-allocation.patch
> * unicore32-switch-to-generic-version-of-pte-allocation.patch
> * mm-memremap-rename-and-consolidate-section_size.patch
> * mm-clean-up-is_device__page-definitions.patch
> * mm-introduce-arch_has_pte_devmap.patch
> * arm64-mm-implement-pte_devmap-support.patch
> * arm64-mm-implement-pte_devmap-support-fix.patch
> * mm-pgtable-drop-pgtable_t-variable-from-pte_fn_t-functions.patch
> * mm-swap-fix-release_pages-when-releasing-devmap-pages.patch
> * mm-swap-fix-release_pages-when-releasing-devmap-pages-v2.patch
> * mm-mmu_notifier-use-hlist_add_head_rcu.patch
> * mm-add-account_locked_vm-utility-function.patch
> * mm-add-account_locked_vm-utility-function-v3.patch
> * mm-memory_hotplug-simplify-and-fix-check_hotplug_memory_range.patch
> * s390x-mm-fail-when-an-altmap-is-used-for-arch_add_memory.patch
> * s390x-mm-implement-arch_remove_memory.patch
> * arm64-mm-add-temporary-arch_remove_memory-implementation.patch
> * drivers-base-memory-pass-a-block_id-to-init_memory_block.patch
> * mm-memory_hotplug-allow-arch_remove_pages-without-config_memory_hotremove.patch
> * mm-memory_hotplug-create-memory-block-devices-after-arch_add_memory.patch
> * mm-memory_hotplug-drop-mhp_memblock_api.patch
> * mm-memory_hotplug-remove-memory-block-devices-before-arch_remove_memory.patch
> * mm-memory_hotplug-make-unregister_memory_block_under_nodes-never-fail.patch
> * mm-memory_hotplug-remove-zone-parameter-from-sparse_remove_one_section.patch
> * mm-large-system-hash-use-vmalloc-for-size-max_order-when-hashdist.patch
> * mm-large-system-hash-avoid-vmap-for-non-numa-machines-when-hashdist.patch
> * mm-move-ioremap-page-table-mapping-function-to-mm.patch
> * mm-vmalloc-hugepage-vmalloc-mappings.patch
> * mm-vmap-remove-node-argument.patch
> * mm-vmap-preload-a-cpu-with-one-object-for-split-purpose.patch
> * mm-vmap-get-rid-of-one-single-unlink_va-when-merge.patch
> * mm-vmap-switch-to-warn_on-and-move-it-under-unlink_va.patch
> * mm-vmscan-remove-double-slab-pressure-by-incing-sc-nr_scanned.patch
> * mm-vmscan-correct-some-vmscan-counters-for-thp-swapout.patch
> * tools-vm-slabinfo-order-command-line-options.patch
> * tools-vm-slabinfo-add-partial-slab-listing-to-x.patch
> * tools-vm-slabinfo-add-option-to-sort-by-partial-slabs.patch
> * tools-vm-slabinfo-add-sorting-info-to-help-menu.patch
> * mm-smaps-split-pss-into-components.patch
> * mm-hmm-support-automatic-numa-balancing.patch
> * mm-hmm-only-set-fault_flag_allow_retry-for-non-blocking.patch
> * z3fold-add-inter-page-compaction.patch
> * x86-numa-always-initialize-all-possible-nodes.patch
> * mm-be-more-verbose-about-zonelist-initialization.patch
> * mm-proportional-memorylowmin-reclaim.patch
> * mm-make-memoryemin-the-baseline-for-utilisation-determination.patch
> * mm-make-memoryemin-the-baseline-for-utilisation-determination-fix.patch
> * mm-vmscan-remove-unused-lru_pages-argument.patch
> * mm-dont-expose-page-to-fast-gup-before-its-ready.patch
> * info-task-hung-in-generic_file_write_iter.patch
> * info-task-hung-in-generic_file_write-fix.patch
> * kernel-hung_taskc-monitor-killed-tasks.patch
> * proc-sysctl-add-shared-variables-for-range-check.patch
> * proc-sysctl-add-shared-variables-for-range-check-fix.patch
> * proc-hide-segfault-at-ffffffffff600000-dmesg-spam.patch
> * vmcore-add-a-kernel-parameter-novmcoredd.patch
> * vmcore-add-a-kernel-parameter-novmcoredd-fix.patch
> * add-typeof_member-macro.patch
> * proc-use-typeof_member-macro.patch
> * kernel-fix-typos-and-some-coding-style-in-comments.patch
> * byteorder-sanity-check-toolchain-vs-kernel-endianess.patch
> * byteorder-sanity-check-toolchain-vs-kernel-endianess-checkpatch-fixes.patch
> * linux-deviceh-use-unique-identifier-for-each-struct-_ddebug.patch
> * linux-neth-use-unique-identifier-for-each-struct-_ddebug.patch
> * linux-printkh-use-unique-identifier-for-each-struct-_ddebug.patch
> * dynamic_debug-introduce-accessors-for-string-members-of-struct-_ddebug.patch
> * dynamic_debug-drop-use-of-bitfields-in-struct-_ddebug.patch
> * lib-genallocc-export-symbol-addr_in_gen_pool.patch
> * lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr.patch
> * lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr-fix.patch
> * lib-fix-possible-incorrect-result-from-rational-fractions-helper.patch
> * tweak-list_poison2-for-better-code-generation-on-x86_64.patch
> * lib-string-allow-searching-for-nul-with-strnchr.patch
> * lib-test_string-avoid-masking-memset16-32-64-failures.patch
> * lib-test_string-add-some-testcases-for-strchr-and-strnchr.patch
> * lib-string-add-strnchrnul.patch
> * bitops-more-bits_to_-macros.patch
> * bitops-more-bits_to_-macros-fix.patch
> * bitops-more-bits_to_-macros-fix-fix.patch
> * lib-add-test-for-bitmap_parse.patch
> * lib-make-bitmap_parse_user-a-wrapper-on-bitmap_parse.patch
> * lib-rework-bitmap_parse.patch
> * lib-rework-bitmap_parse-fix.patch
> * lib-new-testcases-for-bitmap_parse_user.patch
> * cpumask-dont-calculate-length-of-the-input-string.patch
> * lib-test_overflow-avoid-tainting-the-kernel-and-fix-wrap-size.patch
> * lib-introduce-test_meminit-module.patch
> * checkpatch-dont-interpret-stack-dumps-as-commit-ids.patch
> * checkpatch-fix-something.patch
> * binfmt_flat-remove-set-but-not-used-variable-inode.patch
> * elf-delete-stale-comment.patch
> * coda-pass-the-host-file-in-vma-vm_file-on-mmap.patch
> * uapi-linux-codah-use-__kernel_pid_t-for-userspace.patch
> * uapi-linux-coda_psdevh-move-upc_req-definition-from-uapi-to-kernel-side-headers.patch
> * coda-add-error-handling-for-fget.patch
> * coda-potential-buffer-overflow-in-coda_psdev_write.patch
> * coda-fix-build-using-bare-metal-toolchain.patch
> * coda-dont-try-to-print-names-that-were-considered-too-long.patch
> * uapi-linux-coda_psdevh-move-coda_req_-from-uapi-to-kernel-side-headers.patch
> * coda-clean-up-indentation-replace-spaces-with-tab.patch
> * coda-stop-using-struct-timespec-in-user-api.patch
> * coda-change-codas-user-api-to-use-64-bit-time_t-in-timespec.patch
> * coda-get-rid-of-coda_alloc.patch
> * coda-get-rid-of-coda_free.patch
> * coda-bump-module-version.patch
> * coda-move-internal-defs-out-of-include-linux.patch
> * coda-remove-uapi-linux-coda_psdevh.patch
> * coda-destroy-mutex-in-put_super.patch
> * coda-use-size-for-stat.patch
> * coda-add-__init-to-init_coda_psdev.patch
> * coda-remove-sysctl-object-from-module-when-unused.patch
> * coda-remove-sb-test-in-coda_fid_to_inode.patch
> * coda-ftoc-validity-check-integration.patch
> * hfsplus-replace-strncpy-with-memcpy.patch
> * ufs-remove-set-but-not-used-variable-usb3.patch
> * nds32-fix-asm-syscallh.patch
> * hexagon-define-syscall_get_error-and-syscall_get_return_value.patch
> * mips-define-syscall_get_error.patch
> * parisc-define-syscall_get_error.patch
> * powerpc-define-syscall_get_error.patch
> * ptrace-add-ptrace_get_syscall_info-request.patch
> * selftests-ptrace-add-a-test-case-for-ptrace_get_syscall_info.patch
> * selftests-ptrace-add-a-test-case-for-ptrace_get_syscall_info-checkpatch-fixes.patch
> * signal-reorder-struct-sighand_struct.patch
> * coredump-split-pipe-command-whitespace-before-expanding-template.patch
> * rapidio-mport_cdev-nul-terminate-some-strings.patch
> * lz4-fix-spelling-and-copy-paste-errors-in-documentation.patch
>   linux-next.patch
>   linux-next-rejects.patch
> * pinctrl-fix-pxa2xxc-build-warnings.patch
> * hmm-suppress-compilation-warnings-when-config_hugetlb_page-is-not-set.patch
> * dma-contiguous-fix-config_dma_cma-version-of-dma_allocfree_contiguous.patch
> * fix-read-buffer-overflow-in-delta-ipc.patch
>   make-sure-nobodys-leaking-resources.patch
>   releasing-resources-with-children.patch
>   mutex-subsystem-synchro-test-module.patch
>   kernel-forkc-export-kernel_thread-to-modules.patch
>   workaround-for-a-pci-restoring-bug.patch
>
