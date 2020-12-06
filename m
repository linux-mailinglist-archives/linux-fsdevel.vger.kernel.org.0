Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6624E2D01D6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgLFIcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFIcI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:32:08 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63195C0613D0
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:31:22 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id z12so5597194pjn.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OffO4J0XNbKZKsjRiAzQ4jXTCwqv9VY0gL30Fq4+1Jk=;
        b=TT7+K+1nRTgpAuR6NuDugZ2v05TPgDWKZHs2Li/yPUAEEUo8Cht5NFg9H+LJ+3hKGj
         zMenSaZF7+z5va1V11ZGUx7xrCq3qns92bZp3V30+fwNSrARjKZYFzpvf49RgHrsYbCh
         DxrEIrOcuhLYmVd5re4RS0UK+p7GU/ZUK03iUhCo9VY1E95WJTL4SXgNzo/GvVrbodPg
         kqYlZLzqO/pxrE055y1DHdwoavQ2grMfe2Dt1W/H9xZTilQQqjTLSqMnRSSi4dV8cGsd
         ULW6LOt+wgmHyN3AMigBmdW9g7BgLWCUX0Y8VDaTYcMS1kdaOlfX7OrApEQTQyM4QbzZ
         1wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OffO4J0XNbKZKsjRiAzQ4jXTCwqv9VY0gL30Fq4+1Jk=;
        b=pPZRO9PLvmDvgvQst4QQmiu+mIvm01ykQWlp14694A3puUEeAjSC2SZHHzddbHc5vc
         OxRdQKtmB7xxg7aX/cZAliBqQaNQFU3/YgtFJGpsBEN1jA9sbcE9oCe5m+NkHxTmVidV
         e9LvqMoUdxxVRgDfeycc62sH2dDh9RniTrF1WLsKKgKfQuynIWDWzXl2qoEE2oLVNLnn
         cadD+eVK1siQYw9jNr5Xooi5kxwjLEExk7BilpHQi3QAyFaLu90JMBncemITez/uq+ee
         SFP2f13T1lp7vTxjJuLsi9xsVTYENE8T7iXo+Gf9cXDUUSecVSfPsiz8RSbvhewZTpVx
         JYKg==
X-Gm-Message-State: AOAM5316zxCnihs31AZRFdpKLSyV1PvBmfscKJ3Zv+mp8WGYybZ5pcWk
        HOI2X+GSCp36IQT4B0L5QpyEng==
X-Google-Smtp-Source: ABdhPJxJ0PIrT/1KnctdSa8KJHvOTFN6Sq6NrbQoXJzEPP2nt5Nr+b+oKu79Z4xx013lCL/hx6OPvQ==
X-Received: by 2002:a17:90a:c505:: with SMTP id k5mr11879203pjt.53.1607243481862;
        Sun, 06 Dec 2020 00:31:21 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id c2sm10229107pfa.59.2020.12.06.00.31.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:31:21 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 07/12] mm: memcontrol: convert kernel stack account to bytes
Date:   Sun,  6 Dec 2020 16:29:43 +0800
Message-Id: <20201206082948.11812-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel stack account is the one that counts in KiB. This patch
convert it from KiB to byte.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 2 +-
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 2 +-
 kernel/fork.c          | 8 ++++----
 mm/memcontrol.c        | 2 +-
 mm/page_alloc.c        | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f77652e6339f..92a75bad35c9 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -446,7 +446,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
 			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
 			     nid, K(i.sharedram),
-			     nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
+			     nid, node_page_state(pgdat, NR_KERNEL_STACK_B) / SZ_1K,
 #ifdef CONFIG_SHADOW_CALL_STACK
 			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 5a83012d8b72..799a537d4218 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -101,7 +101,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "SReclaimable:   ", sreclaimable);
 	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
 	seq_printf(m, "KernelStack:    %8lu kB\n",
-		   global_node_page_state(NR_KERNEL_STACK_KB));
+		   global_node_page_state(NR_KERNEL_STACK_B) / SZ_1K);
 #ifdef CONFIG_SHADOW_CALL_STACK
 	seq_printf(m, "ShadowCallStack:%8lu kB\n",
 		   global_node_page_state(NR_KERNEL_SCS_KB));
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 15132adaa233..bd34416293ec 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -202,7 +202,7 @@ enum node_stat_item {
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
-	NR_KERNEL_STACK_KB,	/* measured in KiB */
+	NR_KERNEL_STACK_B,	/* measured in byte */
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 345f378e104d..2913d7c43dcb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -382,11 +382,11 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 
 	/* All stack pages are in the same node. */
 	if (vm)
-		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
+		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_B,
+				      account * THREAD_SIZE);
 	else
-		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
+		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_B,
+				      account * THREAD_SIZE);
 }
 
 static int memcg_charge_kernel_stack(struct task_struct *tsk)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6d4365d2fd1c..48d70c1ad301 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1500,7 +1500,7 @@ struct memory_stat {
 static const struct memory_stat memory_stats[] = {
 	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
 	{ "file", PAGE_SIZE, NR_FILE_PAGES },
-	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
+	{ "kernel_stack", 1, NR_KERNEL_STACK_B },
 	{ "percpu", 1, MEMCG_PERCPU_B },
 	{ "sock", PAGE_SIZE, MEMCG_SOCK },
 	{ "shmem", PAGE_SIZE, NR_SHMEM },
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d103513b3e4f..d2821ba7f682 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5572,7 +5572,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
-			node_page_state(pgdat, NR_KERNEL_STACK_KB),
+			node_page_state(pgdat, NR_KERNEL_STACK_B) / SZ_1K,
 #ifdef CONFIG_SHADOW_CALL_STACK
 			node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
-- 
2.11.0

