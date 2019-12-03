Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDE111B38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 22:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfLCVz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 16:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbfLCVz7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:55:59 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED952073F;
        Tue,  3 Dec 2019 21:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575410158;
        bh=B8d1q8o/fT9Ce39BJOKVcStdOI9SkKyf+R6OaOGxeR8=;
        h=Date:From:To:Subject:From;
        b=t3rIMqyhZ2/8no5HgGK2M0UT7C7QXknBybJavMvdE0aIpBNj63gk9b9cSB7B9K/91
         5V0dnn6ItbFg6N4n+r4Uf/euj8RgphdxJyfjQs/50Gc/ZBM4XFcPWvCFNMOFfntUBC
         Tv2Bue+Uq7Kfa4SplCa58qqh8GTE2UBmC2UVJ6sg=
Date:   Tue, 03 Dec 2019 13:55:57 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2019-12-03-13-55 uploaded
Message-ID: <20191203215557.2SX9Z%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2019-12-03-13-55 has been uploaded to

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



This mmotm tree contains the following patches against 5.4:
(patches marked "*" will be included in linux-next)

  origin.patch
* mm-kasan-fix-an-compile-error.patch
* mm-memcg-slab-wait-for-root-kmem_cache-refcnt-killing-on-root-kmem_cache-destruction.patch
* mm-vmstat-add-helpers-to-get-vmstat-item-names-for-each-enum-type.patch
* mm-memcontrol-use-vmstat-names-for-printing-statistics.patch
* mm-replace-is_zero_pfn-with-is_huge_zero_pmd-for-thp.patch
* proc-change-nlink-under-proc_subdir_lock.patch
* proc-delete-useless-len-variable.patch
* proc-shuffle-struct-pde_opener.patch
* proc-fix-confusing-macro-arg-name.patch
* proc-fix-kconfig-indentation.patch
* sysctl-inline-braces-for-ctl_table-and-ctl_table_header.patch
* gitattributes-use-dts-diff-driver-for-dts-files.patch
* linux-build_bugh-change-type-to-int.patch
* linux-scch-make-uapi-linux-scch-self-contained.patch
* arch-fix-kconfig-indentation.patch
* get_maintainer-add-signatures-from-fixes-badcommit-lines-in-commit-message.patch
* kernelh-update-comment-about-simple_strtofoo-functions.patch
* auxdisplay-charlcd-deduplicate-simple_strtoul.patch
* kernel-notifierc-intercepting-duplicate-registrations-to-avoid-infinite-loops.patch
* kernel-notifierc-remove-notifier_chain_cond_register.patch
* kernel-notifierc-remove-blocking_notifier_chain_cond_register.patch
* kernel-profile-use-cpumask_available-to-check-for-null-cpumask.patch
* kernel-sysc-avoid-copying-possible-padding-bytes-in-copy_to_user.patch
* bitops-introduce-the-for_each_set_clump8-macro.patch
* lib-test_bitmapc-add-for_each_set_clump8-test-cases.patch
* gpio-104-dio-48e-utilize-for_each_set_clump8-macro.patch
* gpio-104-idi-48-utilize-for_each_set_clump8-macro.patch
* gpio-gpio-mm-utilize-for_each_set_clump8-macro.patch
* gpio-ws16c48-utilize-for_each_set_clump8-macro.patch
* gpio-pci-idio-16-utilize-for_each_set_clump8-macro.patch
* gpio-pcie-idio-24-utilize-for_each_set_clump8-macro.patch
* gpio-uniphier-utilize-for_each_set_clump8-macro.patch
* gpio-74x164-utilize-the-for_each_set_clump8-macro.patch
* thermal-intel-intel_soc_dts_iosf-utilize-for_each_set_clump8-macro.patch
* gpio-pisosr-utilize-the-for_each_set_clump8-macro.patch
* gpio-max3191x-utilize-the-for_each_set_clump8-macro.patch
* gpio-pca953x-utilize-the-for_each_set_clump8-macro.patch
* lib-rbtree-set-successors-parent-unconditionally.patch
* lib-rbtree-get-successors-color-directly.patch
* lib-test_meminitc-add-bulk-alloc-free-tests.patch
* lib-fix-possible-incorrect-result-from-rational-fractions-helper.patch
* lib-genallocc-export-symbol-addr_in_gen_pool.patch
* lib-genallocc-rename-addr_in_gen_pool-to-gen_pool_has_addr.patch
* checkpatch-improve-ignoring-camelcase-si-style-variants-like-ma.patch
* checkpatch-reduce-is_maintained_obsolete-lookup-runtime.patch
* epoll-simplify-ep_poll_safewake-for-config_debug_lock_alloc.patch
* fs-epoll-remove-unnecessary-wakeups-of-nested-epoll.patch
* selftests-add-epoll-selftests.patch
* elf-delete-unused-interp_map_addr-argument.patch
* elf-extract-elf_read-function.patch
* init-fix-kconfig-indentation.patch
* rapidio-fix-missing-include-of-linux-rio_drvh.patch
* drivers-rapidio-rio-accessc-fix-missing-include-of-linux-rio_drvh.patch
* drm-limit-to-int_max-in-create_blob-ioctl.patch
* uaccess-disallow-int_max-copy-sizes.patch
* kcov-remote-coverage-support.patch
* usb-kcov-collect-coverage-from-hub_event.patch
* vhost-kcov-collect-coverage-from-vhost_worker.patch
* lib-ubsan-dont-seralize-ubsan-report.patch
* arch-ipcbufh-make-uapi-asm-ipcbufh-self-contained.patch
* arch-msgbufh-make-uapi-asm-msgbufh-self-contained.patch
* arch-sembufh-make-uapi-asm-sembufh-self-contained.patch
* lib-test_bitmap-force-argument-of-bitmap_parselist_user-to-proper-address-space.patch
* lib-test_bitmap-undefine-macros-after-use.patch
* lib-test_bitmap-name-exp_bytes-properly.patch
* lib-test_bitmap-rename-exp-to-exp1-to-avoid-ambiguous-name.patch
* lib-test_bitmap-move-exp1-and-exp2-upper-for-others-to-use.patch
* lib-test_bitmap-fix-comment-about-this-file.patch
* bitmap-introduce-bitmap_replace-helper.patch
* gpio-pca953x-remove-redundant-variable-and-check-in-irq-handler.patch
* gpio-pca953x-use-input-from-regs-structure-in-pca953x_irq_pending.patch
* gpio-pca953x-convert-to-use-bitmap-api.patch
* gpio-pca953x-tight-up-indentation.patch
* alpha-use-pgtable-nopud-instead-of-4level-fixup.patch
* arm-nommu-use-pgtable-nopud-instead-of-4level-fixup.patch
* c6x-use-pgtable-nopud-instead-of-4level-fixup.patch
* m68k-nommu-use-pgtable-nopud-instead-of-4level-fixup.patch
* m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup.patch
* microblaze-use-pgtable-nopmd-instead-of-4level-fixup.patch
* nds32-use-pgtable-nopmd-instead-of-4level-fixup.patch
* parisc-use-pgtable-nopxd-instead-of-4level-fixup.patch
* parisc-hugetlb-use-pgtable-nopxd-instead-of-4level-fixup.patch
* sparc32-use-pgtable-nopud-instead-of-4level-fixup.patch
* um-remove-unused-pxx_offset_proc-and-addr_pte-functions.patch
* um-add-support-for-folded-p4d-page-tables.patch
* mm-remove-__arch_has_4level_hack-and-include-asm-generic-4level-fixuph.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mm-thp-tweak-reclaim-compaction-effort-of-local-only-and-all-node-allocations.patch
* x86-mm-split-vmalloc_sync_all.patch
* ramfs-support-o_tmpfile.patch
  mm.patch
* mm-avoid-slub-allocation-while-holding-list_lock.patch
* mm-vmscan-expose-cgroup_ino-for-memcg-reclaim-tracepoints.patch
* mm-pgmap-use-correct-alignment-when-looking-at-first-pfn-from-a-region.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-memmap_init-update-variable-name-in-memmap_init_zone.patch
* mm-memory_hotplug-shrink-zones-when-offlining-memory.patch
* mm-memory_hotplug-poison-memmap-in-remove_pfn_range_from_zone.patch
* mm-memory_hotplug-we-always-have-a-zone-in-find_smallestbiggest_section_pfn.patch
* mm-memory_hotplug-dont-check-for-all-holes-in-shrink_zone_span.patch
* mm-memory_hotplug-drop-local-variables-in-shrink_zone_span.patch
* mm-memory_hotplug-cleanup-__remove_pages.patch
* mm-oom-avoid-printk-iteration-under-rcu.patch
* mm-oom-avoid-printk-iteration-under-rcu-fix.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* string-add-stracpy-and-stracpy_pad-mechanisms.patch
* documentation-checkpatch-prefer-stracpy-strscpy-over-strcpy-strlcpy-strncpy.patch
* aio-simplify-read_events.patch
* smp_mb__beforeafter_atomic-update-documentation.patch
* ipc-mqueuec-remove-duplicated-code.patch
* ipc-mqueuec-update-document-memory-barriers.patch
* ipc-msgc-update-and-document-memory-barriers.patch
* ipc-semc-document-and-update-memory-barriers.patch
* ipc-consolidate-all-xxxctl_down-functions.patch
  linux-next.patch
  linux-next-git-rejects.patch
* drivers-block-null_blk_mainc-fix-layout.patch
* drivers-block-null_blk_mainc-fix-uninitialized-var-warnings.patch
* pinctrl-fix-pxa2xxc-build-warnings.patch
* hacking-group-sysrq-kgdb-ubsan-into-generic-kernel-debugging-instruments.patch
* hacking-create-submenu-for-arch-special-debugging-options.patch
* hacking-group-kernel-data-structures-debugging-together.patch
* hacking-move-kernel-testing-and-coverage-options-to-same-submenu.patch
* hacking-move-oops-into-lockups-and-hangs.patch
* hacking-move-sched_stack_end_check-after-debug_stack_usage.patch
* hacking-create-a-submenu-for-scheduler-debugging-options.patch
* hacking-move-debug_bugverbose-to-printk-and-dmesg-options.patch
* hacking-move-debug_fs-to-generic-kernel-debugging-instruments.patch
* lib-fix-kconfig-indentation.patch
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
* mm-pagewalk-allow-walking-without-vma.patch
* mm-pagewalk-add-test_pd-callbacks.patch
* mm-pagewalk-add-depth-parameter-to-pte_hole.patch
* x86-mm-point-to-struct-seq_file-from-struct-pg_state.patch
* x86-mmefi-convert-ptdump_walk_pgd_level-to-take-a-mm_struct.patch
* x86-mm-convert-ptdump_walk_pgd_level_debugfs-to-take-an-mm_struct.patch
* x86-mm-convert-ptdump_walk_pgd_level_core-to-take-an-mm_struct.patch
* mm-add-generic-ptdump.patch
* x86-mm-convert-dump_pagetables-to-use-walk_page_range.patch
* arm64-mm-convert-mm-dumpc-to-use-walk_page_range.patch
* arm64-mm-display-non-present-entries-in-ptdump.patch
* mm-ptdump-reduce-level-numbers-by-1-in-note_page.patch
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
