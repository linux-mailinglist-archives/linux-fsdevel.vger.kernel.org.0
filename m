Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA49C5594FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiFXIE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiFXIEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:04:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8576DB21;
        Fri, 24 Jun 2022 01:04:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eo8so2390796edb.0;
        Fri, 24 Jun 2022 01:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L5yGqzzqrexdqI+R/PrE1Mdxo3qJEBrMBxvOId5dYac=;
        b=ZFpcJ7bvOxDeoKsD9BSu/DxMgNBu0hFRZLpPD7H8Fycd+7tSFvQFmizj3ywr0jzQq1
         RkmWSN6e5/pg9bL1XB9hzGeR8093OZYGPUC1VX+qdANm04kbOdINANUaSr8NgFtMu/Hg
         S45PN9KwSxrjbZrDs/0J9vao+7RX5SaEiDjzAEM/leu8JhfBoxI41HP181Zf6KMSE/Fm
         okg8/IZK989tO7X6nINgpZg+gCf89iLArC3DLvGvtKCEh5a3lg9AQAQTzCwnNJJjsuVY
         Qbpff4o19u7sF6PEYo7AgFemk0vj1/sz2hNghcnALHaM/9bNwI7G4YVqTXOgFT/zKotW
         1lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5yGqzzqrexdqI+R/PrE1Mdxo3qJEBrMBxvOId5dYac=;
        b=MnaFcoER9d7C8xY9YDTgLhQ5qF1jZebhQ6MTpmLbQTxbba2gteLgPGWgDfzU/u+TIV
         NtmI392wOXNCGuL093Fqo7NBbi9rF5qxyLK4S1K9XG/YujDoqnPCVb4cW099+5flWuzz
         /CiqPx3C+sMXQHCyyLhfx9YISZWaIyX2zlR5ZG6M0291YW0218s4RBE26LdBnwimEj+E
         brmlspX2KqVsDp89VETuxCirYzXPSHMXOqaDJ/icBHmJzqnVzdHddzR3LhgS/3qd1phY
         0jhhiN8EfjPRDJp5uVigDiZt1mYTqjc310WMbHmRH+6ou2my44ah/SnW6jOrvj5X/bjF
         mAtA==
X-Gm-Message-State: AJIora8XO3KrP7deoWp+pB3irU1ANie+mKh00gHLOSVCei+LtuT7gvN3
        db9LJzh2HpLRoyVAT4FYvtK5TKJDzDE=
X-Google-Smtp-Source: AGRyM1v9WvX+EG4ooIeBZBCJi3ju+tuSkjouIG1NrE30YmCwfmias9TA1ULdOZTofk7OgF27mN/vJA==
X-Received: by 2002:a50:ef0d:0:b0:435:6829:e980 with SMTP id m13-20020a50ef0d000000b004356829e980mr15867707eds.192.1656057891610;
        Fri, 24 Jun 2022 01:04:51 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:04:51 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org
Cc:     mhocko@suse.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 03/14] proc: expose per file RSS
Date:   Fri, 24 Jun 2022 10:04:33 +0200
Message-Id: <20220624080444.7619-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624080444.7619-1-christian.koenig@amd.com>
References: <20220624080444.7619-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the per file RSS to the memory management accounting.

This allows to see the per file RSS in tools like top as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 fs/proc/array.c      | 7 +++++--
 fs/proc/internal.h   | 3 ++-
 fs/proc/task_mmu.c   | 6 ++++--
 fs/proc/task_nommu.c | 3 ++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index eb815759842c..a3aabe4ac7c8 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -437,7 +437,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_state(m, ns, pid, task);
 
 	if (mm) {
-		task_mem(m, mm);
+		task_mem(m, mm, task->files);
 		task_core_dumping(m, task);
 		task_thp_status(m, mm);
 		mmput(mm);
@@ -589,7 +589,8 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	seq_put_decimal_ull(m, " ", 0);
 	seq_put_decimal_ull(m, " ", start_time);
 	seq_put_decimal_ull(m, " ", vsize);
-	seq_put_decimal_ull(m, " ", mm ? get_mm_rss(mm) : 0);
+	seq_put_decimal_ull(m, " ", (mm ? get_mm_rss(mm) : 0) +
+			    files_rss(task->files));
 	seq_put_decimal_ull(m, " ", rsslim);
 	seq_put_decimal_ull(m, " ", mm ? (permitted ? mm->start_code : 1) : 0);
 	seq_put_decimal_ull(m, " ", mm ? (permitted ? mm->end_code : 1) : 0);
@@ -673,6 +674,8 @@ int proc_pid_statm(struct seq_file *m, struct pid_namespace *ns,
 		size = task_statm(mm, &shared, &text, &data, &resident);
 		mmput(mm);
 
+		shared += files_rss(task->files);
+
 		/*
 		 * For quick read, open code by putting numbers directly
 		 * expected format is
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..1b123893f7ae 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -305,7 +305,8 @@ extern unsigned long task_vsize(struct mm_struct *);
 extern unsigned long task_statm(struct mm_struct *,
 				unsigned long *, unsigned long *,
 				unsigned long *, unsigned long *);
-extern void task_mem(struct seq_file *, struct mm_struct *);
+extern void task_mem(struct seq_file *, struct mm_struct *,
+		     struct files_struct *);
 
 extern const struct dentry_operations proc_net_dentry_ops;
 static inline void pde_force_lookup(struct proc_dir_entry *pde)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2d04e3470d4c..a4adc6fc13d3 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -20,6 +20,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
+#include <linux/fdtable.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -28,13 +29,14 @@
 
 #define SEQ_PUT_DEC(str, val) \
 		seq_put_decimal_ull_width(m, str, (val) << (PAGE_SHIFT-10), 8)
-void task_mem(struct seq_file *m, struct mm_struct *mm)
+void task_mem(struct seq_file *m, struct mm_struct *mm,
+	      struct files_struct *files)
 {
 	unsigned long text, lib, swap, anon, file, shmem;
 	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
 
 	anon = get_mm_counter(mm, MM_ANONPAGES);
-	file = get_mm_counter(mm, MM_FILEPAGES);
+	file = get_mm_counter(mm, MM_FILEPAGES) + files_rss(files);
 	shmem = get_mm_counter(mm, MM_SHMEMPAGES);
 
 	/*
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..5b6b9c5ed9ec 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -18,7 +18,8 @@
  * each process that owns it. Non-shared memory is counted
  * accurately.
  */
-void task_mem(struct seq_file *m, struct mm_struct *mm)
+void task_mem(struct seq_file *m, struct mm_struct *mm,
+	      struct files_struct *files)
 {
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-- 
2.25.1

