Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5551E483
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 07:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354936AbiEGFuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 01:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiEGFux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 01:50:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C3CB2E;
        Fri,  6 May 2022 22:47:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so8805025pjb.1;
        Fri, 06 May 2022 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V4XZHagSWEnKC6Qw3MYHzFuq9+VP2v5ZnQJxJGUJwXc=;
        b=f9mfNMSz0YiO0lOZNfj7RfhvtB+tTUz3ixNSX2fdaxeBrYi2ldyoNAewrefY0DC8vT
         iNtIPbW4YK1B11PUAZLFfqhVAjT3VnZ+6P5rA3j4d24GUE8fhVxbpiTMQ9HL0iwv9k3j
         jgQl5oSK4tDrS4+btUN2eFNqXzDzk8nXsiY8R9mTEG6o4f5YxCviLE+Mnc3eJco1q5+r
         u0CeEpmvGgt5NX6HqCaUnbMsIJrSFVLcoG105bFjxRKYPyrmMPq4idq77NTiVtr1iLqg
         iMW5XNugh5JHWO9lmJPgujRCZlElTSC33NksH8k7e7g/ejh4v/R8sUFxFpjzKWyhJ2p7
         pNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V4XZHagSWEnKC6Qw3MYHzFuq9+VP2v5ZnQJxJGUJwXc=;
        b=pNb//38awUCOuqpaqi55RTltxMic3jO3s1CF1lAY+LrurZdT41kGnHIP3xad8w+tFJ
         Ngeybrwplfn9yfMfDxyWp5tZn3SAeKf3quEFCXWOuDkIqlRLS0mBbyc3t0xb7nLE/0xA
         pg6iYRF3OubrZERsG2jUEDK2gnwp8Rr6wPlwB9siaGc/voQdCUXbxUc+iSPa0TIG9E/4
         BFnKfWEH7/+XgEP+SF2HzyfeVNsyLjU1gltBp72WVpm8aPGBCw0FgP/fkuyTX2IrA5ip
         Pdz5hrCg7bWz1cD84xuatUHvY2FJb8G6G9S7d/7lHR7t1u/ME9opFJLRHOIrcAbQ5VXw
         JbhQ==
X-Gm-Message-State: AOAM533GwS4P41G1zHUCtlSIgO5uLfpIrja23ypIHAQJAvzmBX9Xe8IW
        x0bgSY3ANk6qn7Hn4YpNWOcmzCsNnJI=
X-Google-Smtp-Source: ABdhPJyOdTkOi3E0xzeZNk0WXxLeCOZtbpjnSDBxnGkRwJyz2wfP8U6lcQwrS/p9VyyZCBTyB1/zSQ==
X-Received: by 2002:a17:903:283:b0:152:157:eb7 with SMTP id j3-20020a170903028300b0015201570eb7mr7026554plr.109.1651902427135;
        Fri, 06 May 2022 22:47:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902788100b0015e8d4eb1dfsm2746669pll.41.2022.05.06.22.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 22:47:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>
Subject: [PATCH v3] mm/ksm: introduce ksm_force for each process
Date:   Sat,  7 May 2022 05:47:02 +0000
Message-Id: <20220507054702.687958-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: xu xin <xu.xin16@zte.com.cn>

To use KSM, we must explicitly call madvise() in application code,
which means installed apps on OS needs to be uninstall and source
code needs to be modified. It is inconvenient.

In order to change this situation, We add a new proc 'ksm_force'
under /proc/<pid>/ to support turning on/off KSM scanning of a
process's mm dynamically.

If ksm_force is set as 1, force all anonymous and 'qualified' vma
of this mm to be involved in KSM scanning without explicitly
calling madvise to make vma MADV_MERGEABLE. But It is effctive only
when the klob of '/sys/kernel/mm/ksm/run' is set as 1.

If ksm_enale is set as 0, cancel the feature of ksm_force of this
process and unmerge those merged pages which is not madvised as
MERGEABLE of this process, but leave MERGEABLE areas merged.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: wangyong <wang.yong12@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
---
v3:
- fix compile error of mm/ksm.c
v2:
- fix a spelling error in commit log.
- remove a redundant condition check in ksm_force_write().
---
 fs/proc/base.c           | 99 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h |  9 ++++
 mm/ksm.c                 | 32 ++++++++++++-
 3 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..3115ffa4c9fb 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -96,6 +96,7 @@
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
 #include <linux/cn_proc.h>
+#include <linux/ksm.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -3168,6 +3169,102 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
 
 	return 0;
 }
+
+static ssize_t ksm_force_read(struct file *file, char __user *buf, size_t count,
+				loff_t *ppos)
+{
+	struct task_struct *task;
+	struct mm_struct *mm;
+	char buffer[PROC_NUMBUF];
+	ssize_t len;
+	int ret;
+
+	task = get_proc_task(file_inode(file));
+	if (!task)
+		return -ESRCH;
+
+	mm = get_task_mm(task);
+	ret = 0;
+	if (mm) {
+		len = snprintf(buffer, sizeof(buffer), "%d\n", mm->ksm_force);
+		ret =  simple_read_from_buffer(buf, count, ppos, buffer, len);
+		mmput(mm);
+	}
+
+	return ret;
+}
+
+static ssize_t ksm_force_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct task_struct *task;
+	struct mm_struct *mm;
+	char buffer[PROC_NUMBUF];
+	int force;
+	int err = 0;
+
+	memset(buffer, 0, sizeof(buffer));
+	if (count > sizeof(buffer) - 1)
+		count = sizeof(buffer) - 1;
+	if (copy_from_user(buffer, buf, count)) {
+		err = -EFAULT;
+		goto out_return;
+	}
+
+	err = kstrtoint(strstrip(buffer), 0, &force);
+
+	if (err)
+		goto out_return;
+	if (force != 0 && force != 1) {
+		err = -EINVAL;
+		goto out_return;
+	}
+
+	task = get_proc_task(file_inode(file));
+	if (!task) {
+		err = -ESRCH;
+		goto out_return;
+	}
+
+	mm = get_task_mm(task);
+	if (!mm)
+		goto out_put_task;
+
+	if (mm->ksm_force != force) {
+		if (mmap_write_lock_killable(mm)) {
+			err = -EINTR;
+			goto out_mmput;
+		}
+
+		if (force == 0)
+			mm->ksm_force = force;
+		else {
+			/*
+			 * Force anonymous pages of this mm to be involved in KSM merging
+			 * without explicitly calling madvise.
+			 */
+			if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
+				err = __ksm_enter(mm);
+			if (!err)
+				mm->ksm_force = force;
+		}
+
+		mmap_write_unlock(mm);
+	}
+
+out_mmput:
+	mmput(mm);
+out_put_task:
+	put_task_struct(task);
+out_return:
+	return err < 0 ? err : count;
+}
+
+static const struct file_operations proc_pid_ksm_force_operations = {
+	.read		= ksm_force_read,
+	.write		= ksm_force_write,
+	.llseek		= generic_file_llseek,
+};
 #endif /* CONFIG_KSM */
 
 #ifdef CONFIG_STACKLEAK_METRICS
@@ -3303,6 +3400,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	REG("ksm_force", S_IRUSR|S_IWUSR, proc_pid_ksm_force_operations),
 #endif
 };
 
@@ -3639,6 +3737,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	REG("ksm_force", S_IRUSR|S_IWUSR, proc_pid_ksm_force_operations),
 #endif
 };
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b34ff2cdbc4f..1b1592c2f5cf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -661,6 +661,15 @@ struct mm_struct {
 		 * merging.
 		 */
 		unsigned long ksm_merging_pages;
+		/*
+		 * If true, force anonymous pages of this mm to be involved in KSM
+		 * merging without explicitly calling madvise. It is effctive only
+		 * when the klob of '/sys/kernel/mm/ksm/run' is set as 1. If false,
+		 * cancel the feature of ksm_force of this process and unmerge
+		 * those merged pages which is not madvised as MERGEABLE of this
+		 * process, but leave MERGEABLE areas merged.
+		 */
+		bool ksm_force;
 #endif
 	} __randomize_layout;
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 38360285497a..c9f672dcc72e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -334,6 +334,34 @@ static void __init ksm_slab_free(void)
 	mm_slot_cache = NULL;
 }
 
+/* Check if vma is qualified for ksmd scanning */
+static bool ksm_vma_check(struct vm_area_struct *vma)
+{
+	unsigned long vm_flags = vma->vm_flags;
+
+	if (!(vma->vm_flags & VM_MERGEABLE) && !(vma->vm_mm->ksm_force))
+		return false;
+
+	if (vm_flags & (VM_SHARED	| VM_MAYSHARE	|
+			VM_PFNMAP	| VM_IO | VM_DONTEXPAND |
+			VM_HUGETLB	| VM_MIXEDMAP))
+		return false;       /* just ignore this vma*/
+
+	if (vma_is_dax(vma))
+		return false;
+
+#ifdef VM_SAO
+	if (vm_flags & VM_SAO)
+		return false;
+#endif
+#ifdef VM_SPARC_ADI
+	if (vm_flags & VM_SPARC_ADI)
+		return false;
+#endif
+
+	return true;
+}
+
 static __always_inline bool is_stable_node_chain(struct stable_node *chain)
 {
 	return chain->rmap_hlist_len == STABLE_NODE_CHAIN;
@@ -523,7 +551,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	if (!vma || !ksm_vma_check(vma) || !vma->anon_vma)
 		return NULL;
 	return vma;
 }
@@ -2297,7 +2325,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 		vma = find_vma(mm, ksm_scan.address);
 
 	for (; vma; vma = vma->vm_next) {
-		if (!(vma->vm_flags & VM_MERGEABLE))
+		if (!ksm_vma_check(vma))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address = vma->vm_start;
-- 
2.25.1

