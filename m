Return-Path: <linux-fsdevel+bounces-46358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648AFA87DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619C91737AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E227D26A0CF;
	Mon, 14 Apr 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PD0ghHEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5BC1A0739
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627210; cv=none; b=j8xJRliiVdwdQlnbcgHUEtzqS7R6JFUwgPfy1ol9Q3NV7DlthRbG3BtYB08QQPZ96iaVGIQ59+BcDrBT7x2trr4AjjjgCU5rI0HtbILXnlqA6NMOlAahP6n4Iyzg4sQcja6Pg6PveXwl96O2loQ470AkVwIJopairGLe9ZS3LjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627210; c=relaxed/simple;
	bh=0deP3HoPer8dd3cyRKrVr2Mpcv8KLUCkDZnTmuTK7R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bCK8zTj9h2eQsHp8g5XeWpru9xlHAWujYQVL6tUdPUiyGcaI4P+MEnIOCL4Do34kpv5QkYuST9N9T7FnCdFxYw9mNq+APxcrEImFaFGQGXJ6VqCIyQOkEl3AzBbYrEYFAOVF3hLCCFdC8hByVfG7XgCycfyUB02FkEwyuqC85zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PD0ghHEW; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250414104000epoutp03020287edd286e06564e00089649f3c3b~2KTH59viS0252502525epoutp03H
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 10:40:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250414104000epoutp03020287edd286e06564e00089649f3c3b~2KTH59viS0252502525epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744627200;
	bh=VqdiESVHO/fRDAVcPAGIgxEXUkRIYj7eEXc2EnIWct0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PD0ghHEWT7MQ46VUBogbnrd9gYdzk1B3Ul5eLbKi5ypE+Asc78MAKgHxatNDk37/G
	 jIahIEXvuVqTcLlbg5Yn+s0j4hkrU9WU5VsRHa53s2hFDU9TQruNq9DYCYb/PQxXGZ
	 Du+8+6SHFcbRMIBkDvE4xRQchLmKGt5SKrpZlTQQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250414103959epcas5p3458451718442029fe076379d2494f90b~2KTHRCGDW2932629326epcas5p3p;
	Mon, 14 Apr 2025 10:39:59 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZbkM2142nz6B9mD; Mon, 14 Apr
	2025 10:39:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E2.1D.19608.EF5ECF76; Mon, 14 Apr 2025 19:39:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250414103658epcas5p40d83978638a756b6d15710643e99b3ac~2KQe19EzW2918229182epcas5p4k;
	Mon, 14 Apr 2025 10:36:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250414103658epsmtrp267e5c5a05ea1356b06f9ab01fceb2eb3~2KQe0_aoa2524925249epsmtrp2L;
	Mon, 14 Apr 2025 10:36:58 +0000 (GMT)
X-AuditID: b6c32a50-225fa70000004c98-57-67fce5fe076a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A1.47.08766.A45ECF76; Mon, 14 Apr 2025 19:36:58 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250414103656epsmtip2a44352b9d982d4302073cfc2b1f9133f~2KQc6BS4v0745107451epsmtip2R;
	Mon, 14 Apr 2025 10:36:56 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: linux-fsdevel@vger.kernel.org
Cc: anuj20.g@samsung.com, mcgrof@kernel.org, clm@meta.com, jack@suse.cz,
	david@fromorbit.com, amir73il@gmail.com, brauner@kernel.org,
	axboe@kernel.dk, hch@lst.de, willy@infradead.org, gost.dev@samsung.com,
	Kundan Kumar <kundan.kumar@samsung.com>
Subject: [RFC 1/1] writeback: enable parallel writeback using multiple work
 items
Date: Mon, 14 Apr 2025 15:58:24 +0530
Message-Id: <20250414102824.9901-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250414102824.9901-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmlu6/p3/SDf70sVhcWLea0aJpwl9m
	i9V3+9ksXh/+xGix5ZK9xZZj9xgtbh7YyWSxcvVRJovZ05uZLLZ++cpqsWfvSRaLGxOeMlr8
	/jGHzYHX49QiCY+ds+6ye2xeoeVx+Wypx6ZVnWweu282sHmcu1jh0bdlFaPHmQVH2D0+b5IL
	4IrKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlxJ
	oSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSY
	kJ2xbeMvxoLHJhXzl59lbmDco93FyMkhIWAicaZhCmsXIxeHkMAeRome66egnE+MEmevXmQC
	qRIS+MYoceKvOExH69vPbBBFexklPv99zAThfGaUaGibDdTOwcEmoCvxoykUxBQRUJS4/N4J
	pIRZ4DejxLmNe5lA4sICwRLH/haDzGQRUJXYvqubHcTmFbCRmP5zMxPELnmJmZe+s4OUcwrY
	Stzfag1RIihxcuYTFhCbGaikeetsZpDxEgJHOCR+rzoFNl5CwEXi5mw3iDHCEq+Ob2GHsKUk
	Pr/bywZhZ0scatwAtapEYueRBqgae4nWU/3MIGOYBTQl1u/ShwjLSkw9tY4JYi2fRO/vJ1Ct
	vBI75sHYahJz3k1lgbBlJBZemgEV95BY/aodGmoTGCVu9qxhmsCoMAvJO7OQvDMLYfUCRuZV
	jFKpBcW56anJpgWGunmp5fAoTs7P3cQITslaATsYV2/4q3eIkYmD8RCjBAezkggvl/OvdCHe
	lMTKqtSi/Pii0pzU4kOMpsDwnsgsJZqcD8wKeSXxhiaWBiZmZmYmlsZmhkrivM07W9KFBNIT
	S1KzU1MLUotg+pg4OKUamCJyk3pNDibOSf2qvUp+1YJNOQqM5rbNB4S2S7Wm8l7+v+a91vz1
	0w5e/HdPcaXyg2i1xbtapolOzr+67pqJ5GS702qdx68uqXnmq7r4kXqq0dWpe96ECp/QbJf9
	qfi49dMUobcCP3o280/cnpZ4cLdHkfC0aOW7D/ifqkzkmth2XCf8ENf9ysD3Py6eYUn91lSw
	aNKP8C914hs/1/EvenvrRYWMoMAD/32KS60t60NX2LxIfCyZqVk0Q1JxUmDtgrPbS2K+is3X
	sz7tv93nf+QDlV7Gl7lis9Yrn9tksqjugr5Ljeo+hlP7Zjt0bfqa+r/Ndctui2+vfDRXPxXZ
	Z3HK5bWu+ZRD1UevOJfc7qtXYinOSDTUYi4qTgQAoivqoFIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXtfr6Z90g8sblC0urFvNaNE04S+z
	xeq7/WwWrw9/YrTYcsneYsuxe4wWNw/sZLJYufook8Xs6c1MFlu/fGW12LP3JIvFjQlPGS1+
	/5jD5sDrcWqRhMfOWXfZPTav0PK4fLbUY9OqTjaP3Tcb2DzOXazw6NuyitHjzIIj7B6fN8kF
	cEVx2aSk5mSWpRbp2yVwZWzb+Iux4LFJxfzlZ5kbGPdodzFyckgImEi0vv3M1sXIxSEksJtR
	YldvGzNEQkZi992drBC2sMTKf8/ZIYo+MkrsbprK0sXIwcEmoCvxoykUxBQRUJS4/N4JpIRZ
	oJtJ4tkxkHpODmGBQInNV48xgdgsAqoS23d1g8V5BWwkpv/czAQxX15i5qXv7CBzOAVsJe5v
	tQYJCwGVLFi6lw2iXFDi5MwnYFuZBdQl1s8TAgkzA3U2b53NPIFRcBaSqlkIVbOQVC1gZF7F
	KJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcY1qaOxi3r/qgd4iRiYPxEKMEB7OSCC+X
	8690Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJMHJxSDUy2UR21
	r8qnnBKb1SywexaPo2BA0QFNuVtXdXhkpP8+XsTZ4nKHyXHCon0xZS+0rxrXPZnydXqv5Qzt
	nPtL7qcvU7/QPOVO15T+cH7Go1/ehZrJ/Qvfs2JZd65GhIxD7bYlpRc4N8UyXZS8UWqhsvKf
	94YFxRI3gj1Dzr3cvkJw64ns3Amn+4RFRctjlZevneK0+XeHYkXf0WehxtcY7A9V1W89nMHP
	K/Dx4JM9CvPr1zn5Cr1r/eEQ7fw94NeDtdJqiflvd9yryDDR1In0SmuZbnHOMYDlhODbkrx1
	Epbde+KKzBvWnQ2/J+DKpK3uopVvcqk14MmdrqQzt/ZH3xINWX8/jLsvb23ufae1hUosxRmJ
	hlrMRcWJAC2R1GcgAwAA
X-CMS-MailID: 20250414103658epcas5p40d83978638a756b6d15710643e99b3ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250414103658epcas5p40d83978638a756b6d15710643e99b3ac
References: <20250414102824.9901-1-kundan.kumar@samsung.com>
	<CGME20250414103658epcas5p40d83978638a756b6d15710643e99b3ac@epcas5p4.samsung.com>

This patch improves writeback throughput by introducing parallelism
within a bdi_writeback. Instead of a single delayed_work, we create
NUM_WB (currently 4) work items, each backed by a dedicated
'struct delayed_work' and associated backpointer to the parent
'bdi_writeback'.

All writeback wakeups—regular or delayed—are now scheduled in a
round-robin fashion across these work items. The underlying inode
lists (b_dirty, b_io, b_more_io, b_dirty_time) remain shared and
protected by existing locking, so no changes are needed there.

This approach allows multiple threads to process dirty inodes in
parallel while retaining the simplicity of a single worklist.

Performance gains:

  - On PMEM:
      Single thread: 155 MiB/s
      4 threads:     342 MiB/s  (+120%)

  - On NVMe:
      Single thread: 111 MiB/s
      4 threads:     139 MiB/s  (+25%)

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fs-writeback.c                | 49 ++++++++++++++++++++++++++------
 include/linux/backing-dev-defs.h | 10 ++++++-
 mm/backing-dev.c                 | 16 ++++++++---
 3 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cc57367fb641..761423b5cc1e 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -133,11 +133,24 @@ static bool inode_io_list_move_locked(struct inode *inode,
 	return false;
 }
 
-static void wb_wakeup(struct bdi_writeback *wb)
+static void wb_wakeup_work(struct bdi_writeback *wb,
+		struct delayed_work *dwork)
 {
 	spin_lock_irq(&wb->work_lock);
 	if (test_bit(WB_registered, &wb->state))
-		mod_delayed_work(bdi_wq, &wb->dwork, 0);
+		mod_delayed_work(bdi_wq, dwork, 0);
+	spin_unlock_irq(&wb->work_lock);
+}
+
+static void wb_wakeup(struct bdi_writeback *wb)
+{
+	spin_lock_irq(&wb->work_lock);
+	if (test_bit(WB_registered, &wb->state)) {
+		mod_delayed_work(bdi_wq,
+				 &wb->wb_dwork[wb->wb_idx].dwork,
+				 0);
+		wb->wb_idx = (wb->wb_idx + 1) % NUM_WB;
+	}
 	spin_unlock_irq(&wb->work_lock);
 }
 
@@ -159,10 +172,26 @@ static void wb_wakeup_delayed(struct bdi_writeback *wb)
 {
 	unsigned long timeout;
 
+	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
+	spin_lock_irq(&wb->work_lock);
+	if (test_bit(WB_registered, &wb->state)) {
+		queue_delayed_work(bdi_wq,
+				   &wb->wb_dwork[wb->wb_idx].dwork,
+				   timeout);
+		wb->wb_idx = (wb->wb_idx + 1) % NUM_WB;
+	}
+	spin_unlock_irq(&wb->work_lock);
+}
+
+static void wb_wakeup_delayed_work(struct bdi_writeback *wb,
+				   struct delayed_work *dwork)
+{
+	unsigned long timeout;
+
 	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
 	spin_lock_irq(&wb->work_lock);
 	if (test_bit(WB_registered, &wb->state))
-		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
+		queue_delayed_work(bdi_wq, dwork, timeout);
 	spin_unlock_irq(&wb->work_lock);
 }
 
@@ -193,7 +222,10 @@ static void wb_queue_work(struct bdi_writeback *wb,
 
 	if (test_bit(WB_registered, &wb->state)) {
 		list_add_tail(&work->list, &wb->work_list);
-		mod_delayed_work(bdi_wq, &wb->dwork, 0);
+		mod_delayed_work(bdi_wq,
+				 &wb->wb_dwork[wb->wb_idx].dwork,
+				 0);
+		wb->wb_idx = (wb->wb_idx + 1) % NUM_WB;
 	} else
 		finish_writeback_work(work);
 
@@ -2325,8 +2357,9 @@ static long wb_do_writeback(struct bdi_writeback *wb)
  */
 void wb_workfn(struct work_struct *work)
 {
-	struct bdi_writeback *wb = container_of(to_delayed_work(work),
-						struct bdi_writeback, dwork);
+	struct delayed_work *p_dwork = to_delayed_work(work);
+	struct mul_dwork *md = container_of(p_dwork, struct mul_dwork, dwork);
+	struct bdi_writeback *wb =  md->p_wb;
 	long pages_written;
 
 	set_worker_desc("flush-%s", bdi_dev_name(wb->bdi));
@@ -2355,9 +2388,9 @@ void wb_workfn(struct work_struct *work)
 	}
 
 	if (!list_empty(&wb->work_list))
-		wb_wakeup(wb);
+		wb_wakeup_work(wb, p_dwork);
 	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
-		wb_wakeup_delayed(wb);
+		wb_wakeup_delayed_work(wb, p_dwork);
 }
 
 /*
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..d099b8846c43 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -18,6 +18,8 @@ struct page;
 struct device;
 struct dentry;
 
+#define NUM_WB 4
+
 /*
  * Bits in bdi_writeback.state
  */
@@ -80,6 +82,11 @@ struct wb_completion {
 #define DEFINE_WB_COMPLETION(cmpl, bdi)	\
 	struct wb_completion cmpl = WB_COMPLETION_INIT(bdi)
 
+struct mul_dwork {
+	struct delayed_work dwork;
+	struct bdi_writeback *p_wb;
+};
+
 /*
  * Each wb (bdi_writeback) can perform writeback operations, is measured
  * and throttled, independently.  Without cgroup writeback, each bdi
@@ -138,7 +145,8 @@ struct bdi_writeback {
 
 	spinlock_t work_lock;		/* protects work_list & dwork scheduling */
 	struct list_head work_list;
-	struct delayed_work dwork;	/* work item used for writeback */
+	struct mul_dwork wb_dwork[NUM_WB];   /* multiple dworks */
+	int wb_idx;
 	struct delayed_work bw_dwork;	/* work item used for bandwidth estimate */
 
 	struct list_head bdi_node;	/* anchored at bdi->wb_list */
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e61bbb1bd622..e1b5e5ddd4eb 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -536,7 +536,11 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 
 	spin_lock_init(&wb->work_lock);
 	INIT_LIST_HEAD(&wb->work_list);
-	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
+	wb->wb_idx = 0;
+	for (int i = 0; i < NUM_WB; i++) {
+		INIT_DELAYED_WORK(&wb->wb_dwork[i].dwork, wb_workfn);
+		wb->wb_dwork[i].p_wb = wb;
+	}
 	INIT_DELAYED_WORK(&wb->bw_dwork, wb_update_bandwidth_workfn);
 
 	err = fprop_local_init_percpu(&wb->completions, gfp);
@@ -571,15 +575,19 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	 * tells wb_workfn() that @wb is dying and its work_list needs to
 	 * be drained no matter what.
 	 */
-	mod_delayed_work(bdi_wq, &wb->dwork, 0);
-	flush_delayed_work(&wb->dwork);
+	for (int i = 0; i < NUM_WB; i++) {
+		mod_delayed_work(bdi_wq, &wb->wb_dwork[i].dwork, 0);
+		flush_delayed_work(&wb->wb_dwork[i].dwork);
+	}
 	WARN_ON(!list_empty(&wb->work_list));
 	flush_delayed_work(&wb->bw_dwork);
 }
 
 static void wb_exit(struct bdi_writeback *wb)
 {
-	WARN_ON(delayed_work_pending(&wb->dwork));
+	for (int i = 0; i < NUM_WB; i++)
+		WARN_ON(delayed_work_pending(&wb->wb_dwork[i].dwork));
+
 	percpu_counter_destroy_many(wb->stat, NR_WB_STAT_ITEMS);
 	fprop_local_destroy_percpu(&wb->completions);
 }
-- 
2.25.1


