Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA51655DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 04:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBTDwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 22:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbgBTDwA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 22:52:00 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8624A24656;
        Thu, 20 Feb 2020 03:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582170717;
        bh=yfP3fBt+EUuuzgD1hrztBYELxnBUgTVLya2+SgFpUmk=;
        h=Date:From:To:Subject:From;
        b=BG5qd8UxtmX1yN5nNRGnqJcwJpHU5GPPg6I/+HwgFLTlYEfD47a/RMhp1Cd5/amOJ
         f2YsJ7hcNyl0gIJ3sBY26p7ymjwFw5J0RmKILdQ6nImdVfGv0YJilrwAnKQ9N1vhda
         e7KzufDhEH5PsJ0EfXqApqjcWdelBUJa6YOvQCpE=
Date:   Wed, 19 Feb 2020 19:51:55 -0800
From:   akpm@linux-foundation.org
To:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject:  mmotm 2020-02-19-19-51 uploaded
Message-ID: <20200220035155.PempH%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.10
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2020-02-19-19-51 has been uploaded to

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



This mmotm tree contains the following patches against 5.6-rc2:
(patches marked "*" will be included in linux-next)

  origin.patch
* y2038-remove-ktime-to-from-timespec-timeval-conversion.patch
* y2038-remove-unused-time32-interfaces.patch
* y2038-hide-timeval-timespec-itimerval-itimerspec-types.patch
* revert-ipcsem-remove-uneeded-sem_undo_list-lock-usage-in-exit_sem.patch
* uapi-fix-userspace-breakage-use-__bits_per_long-for-swap.patch
* mm-dont-prepare-anon_vma-if-vma-has-vm_wipeonfork.patch
* revert-mm-rmapc-reuse-mergeable-anon_vma-as-parent-when-fork.patch
* mm-set-vm_next-and-vm_prev-to-null-in-vm_area_dup.patch
* selftests-vm-add-missed-tests-in-run_vmtests.patch
* get_maintainer-remove-uses-of-p-for-maintainer-name.patch
* scripts-get_maintainerpl-deprioritize-old-fixes-addresses.patch
* mm-fix-a-comment-in-sys_swapon.patch
* memcg-lost-css_put-in-memcg_expand_shrinker_maps.patch
* lib-string-update-match_string-doc-strings-with-correct-behavior.patch
* mm-vmscan-dont-round-up-scan-size-for-online-memory-cgroup.patch
* mm-sparsemem-pfn_to_page-is-not-valid-yet-on-sparsemem.patch
* lib-stackdepot-fix-global-out-of-bounds-in-stack_slabs.patch
* maintainers-use-tabs-for-safesetid.patch
* mm-numa-fix-bad-pmd-by-atomically-check-for-pmd_trans_huge-when-marking-page-tables-prot_numa.patch
* mm-numa-fix-bad-pmd-by-atomically-check-for-pmd_trans_huge-when-marking-page-tables-prot_numa-fix.patch
* mm-avoid-data-corruption-on-cow-fault-into-pfn-mapped-vma.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* x86-mm-split-vmalloc_sync_all.patch
* kthread-mark-timer-used-by-delayed-kthread-works-as-irq-safe.patch
* asm-generic-make-more-kernel-space-headers-mandatory.patch
* scripts-spellingtxt-add-syfs-sysfs-pattern.patch
* ocfs2-remove-fs_ocfs2_nm.patch
* ocfs2-remove-unused-macros.patch
* ocfs2-use-ocfs2_sec_bits-in-macro.patch
* ocfs2-remove-dlm_lock_is_remote.patch
* ramfs-support-o_tmpfile.patch
* kernel-watchdog-flush-all-printk-nmi-buffers-when-hardlockup-detected.patch
  mm.patch
* mm-slubc-replace-cpu_slab-partial-with-wrapped-apis.patch
* mm-slubc-replace-kmem_cache-cpu_partial-with-wrapped-apis.patch
* mm-dont-bother-dropping-mmap_sem-for-zero-size-readahead.patch
* mm-page-writebackc-write_cache_pages-deduplicate-identical-checks.patch
* mm-gup-split-get_user_pages_remote-into-two-routines.patch
* mm-gup-pass-a-flags-arg-to-__gup_device_-functions.patch
* mm-introduce-page_ref_sub_return.patch
* mm-gup-pass-gup-flags-to-two-more-routines.patch
* mm-gup-require-foll_get-for-get_user_pages_fast.patch
* mm-gup-track-foll_pin-pages.patch
* mm-gup-page-hpage_pinned_refcount-exact-pin-counts-for-huge-pages.patch
* mm-gup-proc-vmstat-pin_user_pages-foll_pin-reporting.patch
* mm-gup_benchmark-support-pin_user_pages-and-related-calls.patch
* selftests-vm-run_vmtests-invoke-gup_benchmark-with-basic-foll_pin-coverage.patch
* mm-improve-dump_page-for-compound-pages.patch
* mm-dump_page-additional-diagnostics-for-huge-pinned-pages.patch
* mm-swap-move-inode_lock-out-of-claim_swapfile.patch
* mm-swapfilec-fix-comments-for-swapcache_prepare.patch
* mm-swapc-not-necessary-to-export-__pagevec_lru_add.patch
* mm-memcg-fix-build-error-around-the-usage-of-kmem_caches.patch
* mm-allocate-shrinker_map-on-appropriate-numa-node.patch
* mm-mapping_dirty_helpers-update-huge-page-table-entry-callbacks.patch
* mm-refactor-insert_page-to-prepare-for-batched-lock-insert.patch
* mm-add-vm_insert_pages.patch
* mm-add-vm_insert_pages-fix.patch
* mm-add-vm_insert_pages-2.patch
* net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy.patch
* net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy-fix.patch
* mm-mmap-fix-the-adjusted-length-error.patch
* mm-add-mremap_dontunmap-to-mremap.patch
* mm-add-mremap_dontunmap-to-mremap-v6.patch
* selftest-add-mremap_dontunmap-selftest.patch
* selftest-add-mremap_dontunmap-selftest-fix.patch
* mm-sparsemem-get-address-to-page-struct-instead-of-address-to-pfn.patch
* mm-sparse-rename-pfn_present-as-pfn_in_present_section.patch
* mm-vmpressure-dont-need-call-kfree-if-kstrndup-fails.patch
* mm-vmpressure-use-mem_cgroup_is_root-api.patch
* mm-vmscan-replace-open-codings-to-numa_no_node.patch
* mm-vmscanc-remove-cpu-online-notification-for-now.patch
* mm-mempolicy-support-mpol_mf_strict-for-huge-page-mapping.patch
* mm-mempolicy-use-vm_bug_on_vma-in-queue_pages_test_walk.patch
* hugetlb_cgroup-add-hugetlb_cgroup-reservation-counter.patch
* hugetlb_cgroup-add-interface-for-charge-uncharge-hugetlb-reservations.patch
* mm-hugetlb_cgroup-fix-hugetlb_cgroup-migration.patch
* hugetlb_cgroup-add-reservation-accounting-for-private-mappings.patch
* hugetlb_cgroup-add-reservation-accounting-for-private-mappings-fix.patch
* hugetlb-disable-region_add-file_region-coalescing.patch
* hugetlb-disable-region_add-file_region-coalescing-fix.patch
* hugetlb_cgroup-add-accounting-for-shared-mappings.patch
* hugetlb_cgroup-add-accounting-for-shared-mappings-fix.patch
* hugetlb_cgroup-support-noreserve-mappings.patch
* hugetlb-support-file_region-coalescing-again.patch
* hugetlb-support-file_region-coalescing-again-fix.patch
* hugetlb_cgroup-add-hugetlb_cgroup-reservation-tests.patch
* hugetlb_cgroup-add-hugetlb_cgroup-reservation-docs.patch
* mm-migratec-no-need-to-check-for-i-start-in-do_pages_move.patch
* mm-migratec-wrap-do_move_pages_to_node-and-store_status.patch
* mm-migratec-check-pagelist-in-move_pages_and_store_status.patch
* mm-migratec-unify-not-queued-for-migration-handling-in-do_pages_move.patch
* mm-migratec-migrate-pg_readahead-flag.patch
* mm-migratec-migrate-pg_readahead-flag-fix.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup.patch
* drivers-base-memoryc-cache-memory-blocks-in-xarray-to-accelerate-lookup-fix.patch
* mm-adjust-shuffle-code-to-allow-for-future-coalescing.patch
* mm-use-zone-and-order-instead-of-free-area-in-free_list-manipulators.patch
* mm-add-function-__putback_isolated_page.patch
* mm-introduce-reported-pages.patch
* virtio-balloon-pull-page-poisoning-config-out-of-free-page-hinting.patch
* virtio-balloon-add-support-for-providing-free-page-reports-to-host.patch
* mm-page_reporting-rotate-reported-pages-to-the-tail-of-the-list.patch
* mm-page_reporting-add-budget-limit-on-how-many-pages-can-be-reported-per-pass.patch
* mm-page_reporting-add-free-page-reporting-documentation.patch
* drivers-base-memoryc-indicate-all-memory-blocks-as-removable.patch
* drivers-base-memoryc-drop-section_count.patch
* drivers-base-memoryc-drop-pages_correctly_probed.patch
* mm-page_extc-drop-pfn_present-check-when-onlining.patch
* mm-hotplug-only-respect-mem=-parameter-during-boot-stage.patch
* zswap-allow-setting-default-status-compressor-and-allocator-in-kconfig.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* asm-generic-fix-unistd_32h-generation-format.patch
* kernel-extable-use-address-of-operator-on-section-symbols.patch
* maintainers-add-an-entry-for-kfifo.patch
* lib-test_lockup-test-module-to-generate-lockups.patch
* lib-bch-replace-zero-length-array-with-flexible-array-member.patch
* lib-ts_bm-replace-zero-length-array-with-flexible-array-member.patch
* lib-ts_fsm-replace-zero-length-array-with-flexible-array-member.patch
* lib-ts_kmp-replace-zero-length-array-with-flexible-array-member.patch
* lib-scatterlist-fix-sg_copy_buffer-kerneldoc.patch
* lib-test_stackinitc-xfail-switch-variable-init-tests.patch
* string-add-stracpy-and-stracpy_pad-mechanisms.patch
* documentation-checkpatch-prefer-stracpy-strscpy-over-strcpy-strlcpy-strncpy.patch
* checkpatch-remove-email-address-comment-from-email-address-comparisons.patch
* checkpatch-check-spdx-tags-in-yaml-files.patch
* checkpatch-support-base-commit-format.patch
* checkpatch-prefer-fallthrough-over-fallthrough-comments.patch
* epoll-fix-possible-lost-wakeup-on-epoll_ctl-path.patch
* kselftest-introduce-new-epoll-test-case.patch
* elf-delete-loc-variable.patch
* elf-allocate-less-for-static-executable.patch
* elf-dont-free-interpreters-elf-pheaders-on-common-path.patch
* init-mainc-mark-boot_config_checksum-static.patch
* kernel-relayc-fix-read_pos-error-when-multiple-readers.patch
* aio-simplify-read_events.patch
* init-cleanup-anon_inodes-and-old-io-schedulers-options.patch
  linux-next.patch
  linux-next-rejects.patch
  linux-next-git-rejects.patch
  linux-next-fix.patch
* mm-frontswap-mark-various-intentional-data-races.patch
* mm-page_io-mark-various-intentional-data-races.patch
* mm-page_io-mark-various-intentional-data-races-v2.patch
* mm-swap_state-mark-various-intentional-data-races.patch
* mm-kmemleak-annotate-various-data-races-obj-ptr.patch
* mm-filemap-fix-a-data-race-in-filemap_fault.patch
* mm-swapfile-fix-and-annotate-various-data-races.patch
* mm-swapfile-fix-and-annotate-various-data-races-v2.patch
* mm-page_counter-fix-various-data-races-at-memsw.patch
* mm-memcontrol-fix-a-data-race-in-scan-count.patch
* mm-list_lru-fix-a-data-race-in-list_lru_count_one.patch
* mm-mempool-fix-a-data-race-in-mempool_free.patch
* mm-util-annotate-an-data-race-at-vm_committed_as.patch
* mm-rmap-annotate-a-data-race-at-tlb_flush_batched.patch
* fork-annotate-a-data-race-in-vm_area_dup.patch
* mm-annotate-a-data-race-in-page_zonenum.patch
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
