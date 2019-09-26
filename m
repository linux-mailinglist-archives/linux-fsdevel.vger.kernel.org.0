Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554D3BE9F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 03:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfIZBLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 21:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbfIZBLm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:11:42 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4373222BF;
        Thu, 26 Sep 2019 01:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569460301;
        bh=VfbUgy7HR441Vzwxtjp+G0PyKooJ4CSM0JV6dgtmCJI=;
        h=Date:From:To:Subject:From;
        b=KQSFEKefRqO+zHelNgPBwo9X8pSbB+8a2iLW8ymOJM6xbXihFCOTALAmeFRBAXPtx
         /Vnlvu4nxak0vvsZRfVAzHHbPKs11zs5wwjQGpqrHTUrviChZsvKYTqHwb6fTt6QA1
         gFSkjvKPnuIE+cFOE5upH7LYkNgmrJSuG4ozmv/I=
Date:   Wed, 25 Sep 2019 18:11:40 -0700
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2019-09-25-18-10 uploaded
Message-ID: <20190926011140.kBbRLJHpJ%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2019-09-25-18-10 has been uploaded to

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


This mmotm tree contains the following patches against 5.3:
(patches marked "*" will be included in linux-next)

  origin.patch
* memcg-kmem-do-not-fail-__gfp_nofail-charges.patch
* linux-coffh-add-include-guard.patch
* include-proper-prototypes-for-kernel-elfcorec.patch
* rbtree-sync-up-the-tools-copy-of-the-code-with-the-main-one.patch
* augmented-rbtree-add-comments-for-rb_declare_callbacks-macro.patch
* augmented-rbtree-add-new-rb_declare_callbacks_max-macro.patch
* augmented-rbtree-rework-the-rb_declare_callbacks-macro-definition.patch
* kernel-doc-core-api-include-stringh-into-core-api.patch
* writeback-fix-wstringop-truncation-warnings.patch
* strscpy-reject-buffer-sizes-larger-than-int_max.patch
* lib-generic-radix-treec-make-2-functions-static-inline.patch
* lib-extablec-add-missing-prototypes.patch
* lib-hexdump-make-print_hex_dump_bytes-a-nop-on-debug-builds.patch
* checkpatch-dont-interpret-stack-dumps-as-commit-ids.patch
* checkpatch-improve-spdx-license-checking.patch
* checkpatchpl-warn-on-invalid-commit-id.patch
* checkpatch-exclude-sizeof-sub-expressions-from-macro_arg_reuse.patch
* checkpatch-prefer-__section-over-__attribute__section.patch
* checkpatch-allow-consecutive-close-braces.patch
* checkpatch-remove-obsolete-period-from-ambiguous-sha1-query.patch
* checkpatch-make-git-output-use-language=en_usutf8.patch
* fs-reiserfs-remove-unnecessary-check-of-bh-in-remove_from_transaction.patch
* fs-reiserfs-journalc-remove-set-but-not-used-variables.patch
* fs-reiserfs-streec-remove-set-but-not-used-variables.patch
* fs-reiserfs-lbalancec-remove-set-but-not-used-variables.patch
* fs-reiserfs-objectidc-remove-set-but-not-used-variables.patch
* fs-reiserfs-printsc-remove-set-but-not-used-variables.patch
* fs-reiserfs-fix_nodec-remove-set-but-not-used-variables.patch
* fs-reiserfs-do_balanc-remove-set-but-not-used-variables.patch
* reiserfs-remove-set-but-not-used-variable-in-journalc.patch
* reiserfs-remove-set-but-not-used-variable-in-do_balanc.patch
* fat-delete-an-unnecessary-check-before-brelse.patch
* fork-improve-error-message-for-corrupted-page-tables.patch
* cpumask-nicer-for_each_cpumask_and-signature.patch
* kexec-bail-out-upon-sigkill-when-allocating-memory.patch
* kexec-restore-arch_kexec_kernel_image_probe-declaration.patch
* uaccess-add-missing-__must_check-attributes.patch
* compiler-enable-config_optimize_inlining-forcibly.patch
* kgdb-dont-use-a-notifier-to-enter-kgdb-at-panic-call-directly.patch
* scripts-gdb-handle-split-debug.patch
* bug-refactor-away-warn_slowpath_fmt_taint.patch
* bug-rename-__warn_printf_taint-to-__warn_printf.patch
* bug-consolidate-warn_slowpath_fmt-usage.patch
* bug-lift-cut-here-out-of-__warn.patch
* bug-clean-up-helper-macros-to-remove-__warn_taint.patch
* bug-consolidate-__warn_flags-usage.patch
* bug-move-warn_on-cut-here-into-exception-handler.patch
* ipc-mqueuec-delete-an-unnecessary-check-before-the-macro-call-dev_kfree_skb.patch
* ipc-mqueue-improve-exception-handling-in-do_mq_notify.patch
* ipc-sem-convert-to-use-built-in-rcu-list-checking.patch
* lib-lzo-fix-alignment-bug-in-lzo-rle.patch
* lib-untag-user-pointers-in-strn_user.patch
* mm-untag-user-pointers-passed-to-memory-syscalls.patch
* mm-untag-user-pointers-in-mm-gupc.patch
* mm-untag-user-pointers-in-get_vaddr_frames.patch
* fs-namespace-untag-user-pointers-in-copy_mount_options.patch
* userfaultfd-untag-user-pointers.patch
* drm-amdgpu-untag-user-pointers.patch
* drm-radeon-untag-user-pointers-in-radeon_gem_userptr_ioctl.patch
* media-v4l2-core-untag-user-pointers-in-videobuf_dma_contig_user_get.patch
* tee-shm-untag-user-pointers-in-tee_shm_register.patch
* vfio-type1-untag-user-pointers-in-vaddr_get_pfn.patch
* mm-untag-user-pointers-in-mmap-munmap-mremap-brk.patch
* mm-introduce-madv_cold.patch
* mm-change-pageref_reclaim_clean-with-page_refreclaim.patch
* mm-introduce-madv_pageout.patch
* mm-factor-out-common-parts-between-madv_cold-and-madv_pageout.patch
* hexagon-drop-empty-and-unused-free_initrd_mem.patch
* checkpatch-check-for-nested-unlikely-calls.patch
* xen-events-remove-unlikely-from-warn-condition.patch
* fs-remove-unlikely-from-warn_on-condition.patch
* wimax-i2400m-remove-unlikely-from-warn-condition.patch
* xfs-remove-unlikely-from-warn_on-condition.patch
* ib-hfi1-remove-unlikely-from-is_err-condition.patch
* ntfs-remove-unlikely-from-is_err-conditions.patch
* mm-treewide-clarify-pgtable_page_ctordtor-naming.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mm-memremap-drop-unused-section_size-and-section_mask.patch
* writeback-fix-use-after-free-in-finish_writeback_work.patch
* mm-fix-wmissing-prototypes-warnings.patch
* memcg-only-record-foreign-writebacks-with-dirty-pages-when-memcg-is-not-disabled.patch
* kernel-sysctlc-do-not-override-max_threads-provided-by-userspace.patch
* ocfs2-clear-zero-in-unaligned-direct-io.patch
* ocfs2-clear-zero-in-unaligned-direct-io-checkpatch-fixes.patch
* fs-ocfs2-fix-possible-null-pointer-dereferences-in-ocfs2_xa_prepare_entry.patch
* fs-ocfs2-fix-possible-null-pointer-dereferences-in-ocfs2_xa_prepare_entry-fix.patch
* fs-ocfs2-fix-a-possible-null-pointer-dereference-in-ocfs2_write_end_nolock.patch
* fs-ocfs2-fix-a-possible-null-pointer-dereference-in-ocfs2_info_scan_inode_alloc.patch
* ramfs-support-o_tmpfile.patch
  mm.patch
* mm-slb-improve-memory-accounting.patch
* mm-slb-guarantee-natural-alignment-for-kmallocpower-of-two.patch
* mm-slb-guarantee-natural-alignment-for-kmallocpower-of-two-fix.patch
* mm-vmscan-expose-cgroup_ino-for-memcg-reclaim-tracepoints.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-hotplug-reorder-memblock_-calls-in-try_remove_memory.patch
* memory_hotplug-add-a-bounds-check-to-check_hotplug_memory_range.patch
* mm-add-a-bounds-check-in-devm_memremap_pages.patch
* mm-oom-avoid-printk-iteration-under-rcu.patch
* mm-oom-avoid-printk-iteration-under-rcu-fix.patch
* mm-proportional-memorylowmin-reclaim.patch
* mm-make-memoryemin-the-baseline-for-utilisation-determination.patch
* mm-make-memoryemin-the-baseline-for-utilisation-determination-fix.patch
* mm-vmscan-remove-unused-lru_pages-argument.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* hung_task-allow-printing-warnings-every-check-interval.patch
* lib-genallocc-export-symbol-addr_in_gen_pool.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr-fix.patch
* string-add-stracpy-and-stracpy_pad-mechanisms.patch
* documentation-checkpatch-prefer-stracpy-strscpy-over-strcpy-strlcpy-strncpy.patch
* lib-fix-possible-incorrect-result-from-rational-fractions-helper.patch
* fat-add-nobarrier-to-workaround-the-strange-behavior-of-device.patch
* aio-simplify-read_events.patch
* ipc-consolidate-all-xxxctl_down-functions.patch
  linux-next.patch
  linux-next-git-rejects.patch
  diff-sucks.patch
* pinctrl-fix-pxa2xxc-build-warnings.patch
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
