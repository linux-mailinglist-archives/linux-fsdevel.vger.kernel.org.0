Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE51F337E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 07:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgFIFeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 01:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgFIFet (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:34:49 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C1EC207ED;
        Tue,  9 Jun 2020 05:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591680888;
        bh=/zs/ME9D5R9qnr0nQXb2PED0xJkn98WmJ/5gZDD+ors=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=w4rzkVqzqoNlBWgXhJWc4j+A1jWkM4gob3TyrsNtipSQZm4x1aAgRFNlDutwLM1Ty
         t5j/pIQkQ8reHHO8AfgzE5vwWvr0G3Viz21G6UltznmssKVf3KKEFjL385S893Fb7+
         acI83LVUCzATIlDQ5w6GLlrDZSQHYxcqLiZ3ZXG0=
Date:   Mon, 08 Jun 2020 22:34:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2020-06-08-22-33 uploaded
Message-ID: <20200609053447.B76w0AErG%akpm@linux-foundation.org>
In-Reply-To: <20200608212922.5b7fa74ca3f4e2444441b7f9@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-06-08-22-33 has been uploaded to

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



This mmotm tree contains the following patches against 5.7:
(patches marked "*" will be included in linux-next)

  origin.patch
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
* mm-dont-include-asm-pgtableh-if-linux-mmh-is-already-included.patch
* mm-introduce-include-linux-pgtableh.patch
* mm-reorder-includes-after-introduction-of-linux-pgtableh.patch
* csky-replace-definitions-of-__pxd_offset-with-pxd_index.patch
* m68k-mm-motorola-move-comment-about-page-table-allocation-funcitons.patch
* m68k-mm-move-cachenocahe_page-definitions-close-to-their-user.patch
* x86-mm-simplify-init_trampoline-and-surrounding-logic.patch
* mm-pgtable-add-shortcuts-for-accessing-kernel-pmd-and-pte.patch
* mm-consolidate-pte_index-and-pte_offset_-definitions.patch
* mmap-locking-api-initial-implementation-as-rwsem-wrappers.patch
* mmu-notifier-use-the-new-mmap-locking-api.patch
* dma-reservations-use-the-new-mmap-locking-api.patch
* mmap-locking-api-use-coccinelle-to-convert-mmap_sem-rwsem-call-sites.patch
* mmap-locking-api-convert-mmap_sem-call-sites-missed-by-coccinelle.patch
* mmap-locking-api-convert-nested-write-lock-sites.patch
* mmap-locking-api-add-mmap_read_trylock_non_owner.patch
* mmap-locking-api-add-mmap_lock_initializer.patch
* mmap-locking-api-add-mmap_assert_locked-and-mmap_assert_write_locked.patch
* mmap-locking-api-rename-mmap_sem-to-mmap_lock.patch
* mmap-locking-api-convert-mmap_sem-api-comments.patch
* mmap-locking-api-convert-mmap_sem-comments.patch
* maccess-unexport-probe_kernel_write-and-probe_user_write.patch
* maccess-remove-various-unused-weak-aliases.patch
* maccess-remove-duplicate-kerneldoc-comments.patch
* maccess-clarify-kerneldoc-comments.patch
* maccess-update-the-top-of-file-comment.patch
* maccess-rename-strncpy_from_unsafe_user-to-strncpy_from_user_nofault.patch
* maccess-rename-strncpy_from_unsafe_strict-to-strncpy_from_kernel_nofault.patch
* maccess-rename-strnlen_unsafe_user-to-strnlen_user_nofault.patch
* maccess-remove-probe_read_common-and-probe_write_common.patch
* maccess-unify-the-probe-kernel-arch-hooks.patch
* bpf-factor-out-a-bpf_trace_copy_string-helper.patch
* bpf-handle-the-compat-string-in-bpf_trace_copy_string-better.patch
* bpf-bpf_seq_printf-handle-potentially-unsafe-format-string-better.patch
* bpf-rework-the-compat-kernel-probe-handling.patch
* tracing-kprobes-handle-mixed-kernel-userspace-probes-better.patch
* maccess-remove-strncpy_from_unsafe.patch
* maccess-always-use-strict-semantics-for-probe_kernel_read.patch
* maccess-move-user-access-routines-together.patch
* maccess-allow-architectures-to-provide-kernel-probing-directly.patch
* x86-use-non-set_fs-based-maccess-routines.patch
* maccess-return-erange-when-copy_from_kernel_nofault_allowed-fails.patch
* mm-expand-documentation-over-__read_mostly.patch
* checkpatch-test-git_dir-changes.patch
* khugepaged-selftests-fix-timeout-condition-in-wait_for_scan.patch
* scripts-spelling-add-a-few-more-typos.patch
* kcov-check-kcov_softirq-in-kcov_remote_stop.patch
* lib-lz4-lz4_decompressc-document-deliberate-use-of.patch
* nilfs2-fix-null-pointer-dereference-at-nilfs_segctor_do_construct.patch
* checkpatch-correct-check-for-kernel-parameters-doc.patch
* lib-fix-bitmap_parse-on-64-bit-big-endian-archs.patch
* mm-debug_vm_pgtable-fix-kernel-crash-by-checking-for-thp-support.patch
* mm-memory-failure-prioritize-prctlpr_mce_kill-over-vmmemory_failure_early_kill.patch
* mm-memory-failure-send-sigbusbus_mceerr_ar-only-to-current-thread.patch
* fix-build-failure-of-ocfs2-when-tcp-ip-is-disabled.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* lib-lzo-fix-ambiguous-encoding-bug-in-lzo-rle.patch
* fs-ocfs2-fix-spelling-mistake-and-grammar.patch
* ocfs2-clear-links-count-in-ocfs2_mknod-if-an-error-occurs.patch
* ocfs2-fix-ocfs2-corrupt-when-iputting-an-inode.patch
* drivers-tty-serial-sh-scic-suppress-uninitialized-var-warning.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-page_alloc-skip-waternark_boost-for-atomic-order-0-allocations.patch
* mm-add-comments-on-pglist_data-zones.patch
* mm-vmstat-add-events-for-pmd-based-thp-migration-without-split.patch
* mm-vmstat-add-events-for-pmd-based-thp-migration-without-split-fix.patch
* mm-vmstat-add-events-for-pmd-based-thp-migration-without-split-update.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* lib-optimize-cpumask_local_spread.patch
* lib-test-get_count_order-long-in-test_bitopsc.patch
* lib-test-get_count_order-long-in-test_bitopsc-fix.patch
* lib-test-get_count_order-long-in-test_bitopsc-fix-fix.patch
* checkpatch-add-test-for-possible-misuse-of-is_enabled-without-config_.patch
* exec-change-uselib2-is_sreg-failure-to-eacces.patch
* exec-move-s_isreg-check-earlier.patch
* exec-move-path_noexec-check-earlier.patch
* umh-fix-refcount-underflow-in-fork_usermode_blob.patch
* aio-simplify-read_events.patch
* ipc-convert-ipcs_idr-to-xarray.patch
* ipc-convert-ipcs_idr-to-xarray-update.patch
* ipc-convert-ipcs_idr-to-xarray-update-fix.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
* mm-kmemleak-silence-kcsan-splats-in-checksum.patch
* stacktrace-cleanup-inconsistent-variable-type.patch
* amdgpu-a-null-mm-does-not-mean-a-thread-is-a-kthread.patch
* kernel-move-use_mm-unuse_mm-to-kthreadc.patch
* kernel-move-use_mm-unuse_mm-to-kthreadc-v2.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract-v2.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract-v2-fix.patch
* kernel-better-document-the-use_mm-unuse_mm-api-contract-fix-2.patch
* kernel-set-user_ds-in-kthread_use_mm.patch
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
* mm-annotate-a-data-race-in-page_zonenum.patch
* mm-swap-annotate-data-races-for-lru_rotate_pvecs.patch
* net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy.patch
* mm-pass-task-and-mm-to-do_madvise.patch
* mm-introduce-external-memory-hinting-api.patch
* mm-introduce-external-memory-hinting-api-fix.patch
* mm-introduce-external-memory-hinting-api-fix-2.patch
* mm-introduce-external-memory-hinting-api-fix-2-fix.patch
* mm-check-fatal-signal-pending-of-target-process.patch
* pid-move-pidfd_get_pid-function-to-pidc.patch
* mm-support-both-pid-and-pidfd-for-process_madvise.patch
* mm-madvise-allow-ksm-hints-for-remote-api.patch
* mm-support-vector-address-ranges-for-process_madvise.patch
* mm-support-vector-address-ranges-for-process_madvise-fix.patch
* mm-support-vector-address-ranges-for-process_madvise-fix-fix.patch
* mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix.patch
* mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix-fix.patch
* mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix-fix-fix.patch
* mm-use-only-pidfd-for-process_madvise-syscall.patch
* mm-use-only-pidfd-for-process_madvise-syscall-fix.patch
* mm-remove-duplicated-include-from-madvisec.patch
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
