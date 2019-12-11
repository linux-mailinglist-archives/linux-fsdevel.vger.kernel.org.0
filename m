Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC411A2E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 04:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfLKDOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 22:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfLKDOe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 22:14:34 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C9142073B;
        Wed, 11 Dec 2019 03:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576034073;
        bh=pmvlsOu0diBAURZbR9jd8MzTlOmfxQW87R1HHSYaVTk=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=FnXCT3qL8jnGyeyjc7GY5eGaLUyEaa92VeU2r7NJyBWBEGbhnOXoRw5MgNtfak1el
         AnWq3zY0AzMVAp7J2JotqYh5O1N5/C7w+zp4qZNqs6O+X/5XxJTbR9ox9TXr0uKku6
         dKiatHS+geNjCfRilRQEm0Ob1YdusUQZdxGVdBfs=
Date:   Tue, 10 Dec 2019 19:14:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2019-12-10-19-14 uploaded
Message-ID: <20191211031432.iyKVQ6m9n%akpm@linux-foundation.org>
In-Reply-To: <20191206170123.cb3ad1f76af2b48505fabb33@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2019-12-10-19-14 has been uploaded to

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



This mmotm tree contains the following patches against 5.5-rc1:
(patches marked "*" will be included in linux-next)

  origin.patch
* kasan-fix-crashes-on-access-to-memory-mapped-by-vm_map_ram.patch
* kasan-fix-crashes-on-access-to-memory-mapped-by-vm_map_ram-v2.patch
* mm-add-apply_to_existing_pages-helper.patch
* mm-add-apply_to_existing_pages-helper-fix.patch
* mm-add-apply_to_existing_pages-helper-fix-fix.patch
* kasan-use-apply_to_existing_pages-for-releasing-vmalloc-shadow.patch
* kasan-use-apply_to_existing_pages-for-releasing-vmalloc-shadow-fix.patch
* kasan-dont-assume-percpu-shadow-allocations-will-succeed.patch
* mm-vmscan-protect-shrinker-idr-replace-with-config_memcg.patch
* lib-kconfigdebug-fix-some-messed-up-configurations.patch
* lib-kconfigdebug-fix-some-messed-up-configurations-checkpatch-fixes.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mm-zsmallocc-fix-the-migrated-zspage-statistics.patch
* mm-thp-tweak-reclaim-compaction-effort-of-local-only-and-all-node-allocations.patch
* x86-mm-split-vmalloc_sync_all.patch
* kcov-fix-struct-layout-for-kcov_remote_arg.patch
* memcg-account-security-cred-as-well-to-kmemcg.patch
* mm-move_pages-return-valid-node-id-in-status-if-the-page-is-already-on-the-target-node.patch
* fs-direct-ioc-include-fs-internalh-for-missing-prototype.patch
* fs-nsfsc-include-headers-for-missing-declarations.patch
* fs-namespacec-make-to_mnt_ns-static.patch
* hexagon-define-ioremap_uc.patch
* hexagon-parenthesize-registers-in-asm-predicates.patch
* hexagon-work-around-compiler-crash.patch
* fs-fix-posix_aclc-kernel-doc-warnings.patch
* init-kconfig-enable-o3-for-all-arches.patch
* ramfs-support-o_tmpfile.patch
  mm.patch
* mm-avoid-slub-allocation-while-holding-list_lock.patch
* mm-cleanup-some-useless-code.patch
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
* mm-early_remap-use-%pa-to-print-resource_size_t-variables.patch
* mm-oom-avoid-printk-iteration-under-rcu.patch
* mm-oom-avoid-printk-iteration-under-rcu-fix.patch
* mm-clean-up-obsolete-check-on-space-in-page-flags.patch
* info-task-hung-in-generic_file_write_iter.patch
* info-task-hung-in-generic_file_write-fix.patch
* kernel-hung_taskc-monitor-killed-tasks.patch
* lib-zlib-add-s390-hardware-support-for-kernel-zlib_deflate.patch
* s390-boot-rename-heap_size-due-to-name-collision.patch
* lib-zlib-add-s390-hardware-support-for-kernel-zlib_inflate.patch
* s390-boot-add-dfltcc=-kernel-command-line-parameter.patch
* lib-zlib-add-zlib_deflate_dfltcc_enabled-function.patch
* btrfs-use-larger-zlib-buffer-for-s390-hardware-compression.patch
* string-add-stracpy-and-stracpy_pad-mechanisms.patch
* documentation-checkpatch-prefer-stracpy-strscpy-over-strcpy-strlcpy-strncpy.patch
* elf-smaller-code-generation-around-auxv-vector-fill.patch
* elf-fix-start_code-calculation.patch
* elf-dont-copy-elf-header-around.patch
* execve-warn-if-process-starts-with-executable-stack.patch
* io-mapping-use-phys_pfn-macro-in-io_mapping_map_atomic_wc.patch
* aio-simplify-read_events.patch
* smp_mb__beforeafter_atomic-update-documentation.patch
* ipc-mqueuec-remove-duplicated-code.patch
* ipc-mqueuec-update-document-memory-barriers.patch
* ipc-msgc-update-and-document-memory-barriers.patch
* ipc-semc-document-and-update-memory-barriers.patch
* ipc-consolidate-all-xxxctl_down-functions.patch
  linux-next.patch
  linux-next-build-fix.patch
* drivers-block-null_blk_mainc-fix-layout.patch
* drivers-block-null_blk_mainc-fix-uninitialized-var-warnings.patch
* pinctrl-fix-pxa2xxc-build-warnings.patch
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
