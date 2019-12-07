Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C477115ADE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 04:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLGDr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 22:47:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfLGDr0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 22:47:26 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCA820637;
        Sat,  7 Dec 2019 03:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575690444;
        bh=50Udh4adKV8I9YKDKPNTiQTkFH0xxlkJSgD7ELObhwQ=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=I36LUghQAY0MVvRC2SKNUFCGcJPJPAHaQpvMxY4kjdoDtJJ8440wDCdFoH2Ev/Wwr
         y+aAFl7LnYI8Yp2vez6zM2qnZEDv3MlgGFghjVTBB0+IXdJyadeJ9az3do51QEoh/r
         qBB2mXts+VeC1E/olfLdoPN5VGizqQZqVtJS0SWI=
Date:   Fri, 06 Dec 2019 19:47:23 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject:  mmotm 2019-12-06-19-46 uploaded
Message-ID: <20191207034723.OPvz2A9wZ%akpm@linux-foundation.org>
In-Reply-To: <20191206170123.cb3ad1f76af2b48505fabb33@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mm-of-the-moment snapshot 2019-12-06-19-46 has been uploaded to

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
* kasan-fix-crashes-on-access-to-memory-mapped-by-vm_map_ram.patch
* kasan-fix-crashes-on-access-to-memory-mapped-by-vm_map_ram-v2.patch
* mm-add-apply_to_existing_pages-helper.patch
* mm-add-apply_to_existing_pages-helper-fix.patch
* mm-add-apply_to_existing_pages-helper-fix-fix.patch
* kasan-use-apply_to_existing_pages-for-releasing-vmalloc-shadow.patch
* kasan-use-apply_to_existing_pages-for-releasing-vmalloc-shadow-fix.patch
* kasan-dont-assume-percpu-shadow-allocations-will-succeed.patch
* mm-vmscan-protect-shrinker-idr-replace-with-config_memcg.patch
* proc-kpageflags-prevent-an-integer-overflow-in-stable_page_flags.patch
* proc-kpageflags-do-not-use-uninitialized-struct-pages.patch
* mm-zsmallocc-fix-the-migrated-zspage-statistics.patch
* mm-thp-tweak-reclaim-compaction-effort-of-local-only-and-all-node-allocations.patch
* x86-mm-split-vmalloc_sync_all.patch
* kcov-fix-struct-layout-for-kcov_remote_arg.patch
* memcg-account-security-cred-as-well-to-kmemcg.patch
* mm-move_pages-return-valid-node-id-in-status-if-the-page-is-already-on-the-target-node.patch
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
* drivers-tty-serial-sh-scic-suppress-warning.patch
* fix-read-buffer-overflow-in-delta-ipc.patch
  make-sure-nobodys-leaking-resources.patch
  releasing-resources-with-children.patch
  mutex-subsystem-synchro-test-module.patch
  kernel-forkc-export-kernel_thread-to-modules.patch
  workaround-for-a-pci-restoring-bug.patch
