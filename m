Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B533F581
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 17:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhCQQaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 12:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhCQQ3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:29:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A726C06174A;
        Wed, 17 Mar 2021 09:29:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so5506058pjb.1;
        Wed, 17 Mar 2021 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hS77tjdA+3f1XuSktu47De02hM9SEB7dyKGgmhEfkK8=;
        b=r4sLqcfJR6SIl+mVMMYx4Z8o+0B6Y03/Z990zmaCrNRA+w473MjvokTHX+PsVzuadf
         b+uZbXuH1NJy2Cdp4pNozC+gExt/pzgqDOu2MOHrULxLfW3VMDqbai2nxqmgp575mF5R
         ZDKMlqa8D1FUUL2C3dE+VtNT/Q7epHM9aZ+YNoQs1nZotLX4DacEgvh4+HhEJHBsShBS
         rhVk/CuVOzoHw1CtE6feedoj/8qc+t1ld0wdC13Fs9bOIU6n8RZvY4VnEUntPlsu7E2d
         w9uHbkpyG4lDEGCYhDZyvbGGB9zemxFrNewH6MhkkKqXZC+UouXFaUGehJcBKJSti3qX
         foBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hS77tjdA+3f1XuSktu47De02hM9SEB7dyKGgmhEfkK8=;
        b=as6RJIJSc1N1Ha7hK9OD/95XRO+z+rbfy/hjHkLysXOqJndUGJ5kfGPHXk8YAInhS4
         Ea9XWdarRN5KjIeIY681IWeNBQAonuOQ/vhUX34nQCK1mxFdtlKzG2PvTcHCEM82Ee9O
         gu6VBSiRSEJiDFXkSCbpG4aNoDzAZ0AqKirvq842+xyfl7M3fRcqjeOnVocfmgsZkGJ+
         TSwZ4qzROcTcx0Pg9bbMRFGMnuUxLkVBpmTX16WBdTlIpwPdjHtPaYio+ofYm81SFS5F
         nCXGCCb8w3QfOQ7f7w/5v8d52Rq7TtM83nloPI3ZXDBeoxsSaQoaC9KcRKglfBhLNOD+
         /ZJQ==
X-Gm-Message-State: AOAM532RhCdHpWSskoCaL0oP1o9XIDI4tFWjtLOVTLGviGuz0ufSIqk7
        nUvEesYSHbCbIb4NJ8ATBJw=
X-Google-Smtp-Source: ABdhPJxhWJhMi/2uuyShovt9lBWpy/lRxYtqeeEwGx3JtvcrnVEgG+mbeReJxXucZQkgTvvMFjeoCw==
X-Received: by 2002:a17:90b:1490:: with SMTP id js16mr5311945pjb.131.1615998581500;
        Wed, 17 Mar 2021 09:29:41 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8914:cdf:bafb:bf7b])
        by smtp.gmail.com with ESMTPSA id s28sm20866068pfd.155.2021.03.17.09.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 09:29:40 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Mar 2021 09:29:38 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, joaodias@google.com,
        surenb@google.com, willy@infradead.org, mhocko@suse.com,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [mm]  8fd8d23ab1: WARNING:at_fs/buffer.c:#__brelse
Message-ID: <YFIucgVd7Vu9eE50@google.com>
References: <20210310161429.399432-3-minchan@kernel.org>
 <20210317023756.GA22345@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317023756.GA22345@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:37:57AM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 8fd8d23ab10cc2fceeac25ea7b0e2eaf98e78d64 ("[PATCH v3 3/3] mm: fs: Invalidate BH LRU during page migration")
> url: https://github.com/0day-ci/linux/commits/Minchan-Kim/mm-replace-migrate_prep-with-lru_add_drain_all/20210311-001714
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
> 
> in testcase: blktests
> version: blktests-x86_64-a210761-1_20210124
> with following parameters:
> 
> 	test: nbd-group-01
> 	ucode: 0xe2
> 
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   40.465061] WARNING: CPU: 2 PID: 5207 at fs/buffer.c:1177 __brelse (kbuild/src/consumer/fs/buffer.c:1177 kbuild/src/consumer/fs/buffer.c:1171) 
> [   40.465066] Modules linked in: nbd loop xfs libcrc32c dm_multipath dm_mod ipmi_devintf ipmi_msghandler sd_mod t10_pi sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel rapl i915 mei_wdt intel_cstate wmi_bmof intel_gtt drm_kms_helper syscopyarea ahci intel_uncore sysfillrect sysimgblt libahci fb_sys_fops drm libata mei_me mei intel_pch_thermal wmi video intel_pmc_core acpi_pad ip_tables
> [   40.465086] CPU: 2 PID: 5207 Comm: mount_clear_soc Tainted: G          I       5.12.0-rc2-00062-g8fd8d23ab10c #1
> [   40.465088] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
> [   40.465089] RIP: 0010:__brelse (kbuild/src/consumer/fs/buffer.c:1177 kbuild/src/consumer/fs/buffer.c:1171) 
> [ 40.465091] Code: 00 00 00 00 00 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 47 60 85 c0 74 05 f0 ff 4f 60 c3 48 c7 c7 d8 99 57 82 e8 02 5d 80 00 <0f> 0b c3 0f 1f 44 00 00 55 65 ff 05 13 79 c8 7e 53 48 c7 c3 c0 89

Hi,

Unfortunately, I couldn't set the lkp test in my local mahcine
since installation failed(I guess my linux distribution is
very minor)

Do you mind testing this patch? (Please replace the original
patch with this one)

From 23cfe5a8e939e2c077223e009887af8a0b5d6381 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Tue, 2 Mar 2021 12:05:08 -0800
Subject: [PATCH] mm: fs: Invalidate BH LRU during page migration

Pages containing buffer_heads that are in one of the per-CPU
buffer_head LRU caches will be pinned and thus cannot be migrated.
This can prevent CMA allocations from succeeding, which are often used
on platforms with co-processors (such as a DSP) that can only use
physically contiguous memory. It can also prevent memory
hot-unplugging from succeeding, which involves migrating at least
MIN_MEMORY_BLOCK_SIZE bytes of memory, which ranges from 8 MiB to 1
GiB based on the architecture in use.

Correspondingly, invalidate the BH LRU caches before a migration
starts and stop any buffer_head from being cached in the LRU caches,
until migration has finished.

Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/buffer.c                 | 36 ++++++++++++++++++++++++++++++------
 include/linux/buffer_head.h |  4 ++++
 mm/swap.c                   |  5 ++++-
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 0cb7ffd4977c..e9872d0dcbf1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1264,6 +1264,15 @@ static void bh_lru_install(struct buffer_head *bh)
 	int i;
 
 	check_irqs_on();
+	/*
+	 * the refcount of buffer_head in bh_lru prevents dropping the
+	 * attached page(i.e., try_to_free_buffers) so it could cause
+	 * failing page migration.
+	 * Skip putting upcoming bh into bh_lru until migration is done.
+	 */
+	if (lru_cache_disabled())
+		return;
+
 	bh_lru_lock();
 
 	b = this_cpu_ptr(&bh_lrus);
@@ -1404,6 +1413,15 @@ __bread_gfp(struct block_device *bdev, sector_t block,
 }
 EXPORT_SYMBOL(__bread_gfp);
 
+static void __invalidate_bh_lrus(struct bh_lru *b)
+{
+	int i;
+
+	for (i = 0; i < BH_LRU_SIZE; i++) {
+		brelse(b->bhs[i]);
+		b->bhs[i] = NULL;
+	}
+}
 /*
  * invalidate_bh_lrus() is called rarely - but not only at unmount.
  * This doesn't race because it runs in each cpu either in irq
@@ -1412,16 +1430,12 @@ EXPORT_SYMBOL(__bread_gfp);
 static void invalidate_bh_lru(void *arg)
 {
 	struct bh_lru *b = &get_cpu_var(bh_lrus);
-	int i;
 
-	for (i = 0; i < BH_LRU_SIZE; i++) {
-		brelse(b->bhs[i]);
-		b->bhs[i] = NULL;
-	}
+	__invalidate_bh_lrus(b);
 	put_cpu_var(bh_lrus);
 }
 
-static bool has_bh_in_lru(int cpu, void *dummy)
+bool has_bh_in_lru(int cpu, void *dummy)
 {
 	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
 	int i;
@@ -1440,6 +1454,16 @@ void invalidate_bh_lrus(void)
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
+void invalidate_bh_lrus_cpu(int cpu)
+{
+	struct bh_lru *b;
+
+	bh_lru_lock();
+	b = per_cpu_ptr(&bh_lrus, cpu);
+	__invalidate_bh_lrus(b);
+	bh_lru_unlock();
+}
+
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset)
 {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94378c5..e7e99da31349 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -194,6 +194,8 @@ void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
 void invalidate_bh_lrus(void);
+void invalidate_bh_lrus_cpu(int cpu);
+bool has_bh_in_lru(int cpu, void *dummy);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
@@ -406,6 +408,8 @@ static inline int inode_has_buffers(struct inode *inode) { return 0; }
 static inline void invalidate_inode_buffers(struct inode *inode) {}
 static inline int remove_inode_buffers(struct inode *inode) { return 1; }
 static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
+static inline void invalidate_bh_lrus_cpu(int cpu) {}
+static inline bool has_bh_in_lru(int cpu, void *dummy) { return 0; }
 #define buffer_heads_over_limit 0
 
 #endif /* CONFIG_BLOCK */
diff --git a/mm/swap.c b/mm/swap.c
index fbdf6ac05aec..b962fe45bc02 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -36,6 +36,7 @@
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
+#include <linux/buffer_head.h>
 
 #include "internal.h"
 
@@ -641,6 +642,7 @@ void lru_add_drain_cpu(int cpu)
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 
 	activate_page_drain(cpu);
+	invalidate_bh_lrus_cpu(cpu);
 }
 
 /**
@@ -828,7 +830,8 @@ static void __lru_add_drain_all(bool force_all_cpus)
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_lazyfree, cpu)) ||
-		    need_activate_page_drain(cpu)) {
+		    need_activate_page_drain(cpu) ||
+		    has_bh_in_lru(cpu, NULL)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
 			queue_work_on(cpu, mm_percpu_wq, work);
 			__cpumask_set_cpu(cpu, &has_work);
-- 
2.31.0.rc2.261.g7f71774620-goog


