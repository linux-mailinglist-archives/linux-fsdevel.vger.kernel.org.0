Return-Path: <linux-fsdevel+bounces-36326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E91D69E1AE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 12:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95868167406
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2791E3DD6;
	Tue,  3 Dec 2024 11:26:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CB2E3EE;
	Tue,  3 Dec 2024 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225208; cv=none; b=gKVJjIZUnJuLhKGb4fXR2C/2xmPSztkyTnHwi3d3q9ZyXF+K2TQAS6lv0zI48ZSWNJe+wp4x+aX9FSVusoMO9FTOxLrxSVF5TxJ/r5Uu1ywAuP9nerf126OthoAanLB5oy27oHPlMn4NV3h2LeEdd0do0+8LPcTL+MxB/qg1i/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225208; c=relaxed/simple;
	bh=v2cCA4SkHBFossPNjsuI3dIhlyDjd2P1Q/6P1WUpY1M=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=IREnG6PUEKZVF/kRnY+uIw20aNd0ANk4tx2pWh9/No4f82kUDR7VVgRc5Ri4QmRl2rXCrdx6jFCMxOnSFru6pgmeX6H9Jy3/KmagOUj2wiJM069uoUUD/qwgnE/uiTiBD7SkqNO1ysQcH3uPI17Lt+KcNeRuklMe44cSz4K2fSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Y2ddp0qMKz8R040;
	Tue,  3 Dec 2024 19:26:38 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 4B3BQUho000945;
	Tue, 3 Dec 2024 19:26:31 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Dec 2024 19:26:33 +0800 (CST)
Date: Tue, 3 Dec 2024 19:26:33 +0800 (CST)
X-Zmail-TransId: 2afb674eeae972d-c1081
X-Mailer: Zmail v1.0
Message-ID: <20241203192633836RVHhkoK1Amnqjt84D4Ryd@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <david@redhat.com>, <akpm@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, <wang.yaxin@zte.com.cn>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjRdIGtzbTogYWRkIGtzbSBpbnZvbHZlbWVudCBpbmZvcm1hdGlvbiBmb3IgZWFjaCBwcm9jZXNz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 4B3BQUho000945
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 674EEAEE.000/4Y2ddp0qMKz8R040

From: xu xin <xu.xin16@zte.com.cn>

In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
KSM_mergeable and KSM_merge_any. It helps administrators to
better know the system's KSM behavior at process level.

KSM_mergeable: yes/no
	whether any VMAs of the process'mm are currently applicable to KSM.

KSM_merge_any: yes/no
	whether the process'mm is added by prctl() into the candidate list
	of KSM or not, and fully enabled at process level.

Changelog
=========
v3 -> v4:
    1. Keep the name of ksm items consistent in /proc/pid/ksm_stat.
	   * KSM_mergeable -> ksm_mergeable
	   * KSM_merge_any -> ksm_merge_any
    2. Hold the read lock of mmap while calling ksm_process_mergeable()
    Suggested-by:
    https://lore.kernel.org/all/cec0ed06-b5d0-45aa-ad2b-eaca6dd7bacb@redhat.com/

v2 -> v3:
        Update the KSM_mergeable getting method: loop up if any vma is
        mergeable to KSM.
		https://lore.kernel.org/all/bc0e1cdd-2d9d-437c-8fc9-4df0e13c48c0@redhat.com/

v1 -> v2:
        replace the internal flag names with straightforward strings.
        * MMF_VM_MERGEABLE -> KSM_mergeable
        * MMF_VM_MERGE_ANY -> KSM_merge_any

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
---
 fs/proc/base.c      | 11 +++++++++++
 include/linux/ksm.h |  1 +
 mm/ksm.c            | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0edf14a9840e..a50b222a5917 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3269,6 +3269,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *task)
 {
 	struct mm_struct *mm;
+	int ret = 0;

 	mm = get_task_mm(task);
 	if (mm) {
@@ -3276,6 +3277,16 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
+		seq_printf(m, "ksm_merge_any: %s\n",
+				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
+		ret = mmap_read_lock_killable(mm);
+		if (ret) {
+			mmput(mm);
+			return ret;
+		}
+		seq_printf(m, "ksm_mergeable: %s\n",
+				ksm_process_mergeable(mm) ? "yes" : "no");
+		mmap_read_unlock(mm);
 		mmput(mm);
 	}

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 6a53ac4885bb..d73095b5cd96 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -93,6 +93,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
 void collect_procs_ksm(const struct folio *folio, const struct page *page,
 		struct list_head *to_kill, int force_early);
 long ksm_process_profit(struct mm_struct *);
+bool ksm_process_mergeable(struct mm_struct *mm);

 #else  /* !CONFIG_KSM */

diff --git a/mm/ksm.c b/mm/ksm.c
index 7ac59cde626c..e87af149d5ee 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3263,6 +3263,25 @@ static void wait_while_offlining(void)
 #endif /* CONFIG_MEMORY_HOTREMOVE */

 #ifdef CONFIG_PROC_FS
+/*
+ * The process is mergeable only if any VMA (and which) is currently
+ * applicable to KSM.
+ *
+ * The mmap lock must be held in read mode.
+ */
+bool ksm_process_mergeable(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+
+	mmap_assert_locked(mm);
+	VMA_ITERATOR(vmi, mm, 0);
+	for_each_vma(vmi, vma)
+		if (vma->vm_flags & VM_MERGEABLE)
+			return true;
+
+	return false;
+}
+
 long ksm_process_profit(struct mm_struct *mm)
 {
 	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
-- 
2.15.2

