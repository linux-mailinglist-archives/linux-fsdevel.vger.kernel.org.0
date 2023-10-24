Return-Path: <linux-fsdevel+bounces-996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8B7D4A47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACCDB210E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ACE22F13;
	Tue, 24 Oct 2023 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cDbOB552"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C5224DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 08:34:18 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1657D172B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:34:16 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so4173619b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136456; x=1698741256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhuvPcTMRDCD3VOBYhVRa0kZDnR2cgXp2fXq7JVV3pE=;
        b=cDbOB552h6db4BuaCuIYz243RmuvKZ+aUfLpkVe4LVKmgFYFETTGlPNrIudPP4bmyk
         tM1Z0+r+O6TOBOTZzRqW6ltrR1KLFBeBpH95P1RcxfyZH7CNhaEMacg8J7qJY6fAGnS4
         lKV7c5ei7X9V6noPFGKsDC5Af4uJybdUrpfMdS6F8sEfeOcFJwnL9xlFjg4wEjHfP2sN
         JNQ8uaCcx2IggFkZPhw3iA4Sxvq25BF3Lvo+RFc45gMVneG/TF7vSQWrbkl6FbcMds08
         Tt7bP2JrFPC8saqs1nDuF6PVUfTgYuDedyXL45QxuUV2Y9FMjDS0BE6z8QfoZekY8Y5M
         94BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136456; x=1698741256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhuvPcTMRDCD3VOBYhVRa0kZDnR2cgXp2fXq7JVV3pE=;
        b=OED4XQlb3VZGRKKgwtPFOipahtuZM4yuM6a1v4PJk2RZrRqBSyGgHa61spMO9S0KYY
         eviKA4cvNGSZSk4/42Zxk8VDaTjiJbHbqOjTmB29vFx/ksfnEB47ygT7w0JOYJtn1aii
         97IcIBfRc8QxiLH/E/ZfEBDXTK2p7K5KhKWNOKfueYqxD+UImh1ptcO1mooAZyC3knmX
         zttcwXGWxny1RyG+8frcjczGuJUmVDSbyPXm+vXV8YSO+Ezhi4DaGFMXl5RjN0fb6KNF
         wrugcRKNQ2B3Mw2P96kVtIwa8uAic3i33vKHsAMDcZmQUOgiVa0Vgl19ee8rMBAXfZzn
         xUmA==
X-Gm-Message-State: AOJu0YzvkywzPIYAxjGranL9web1Tv1HCqEnku5vudYH7uurpsyWIdX0
	T+F1Am+GNsFomyrAF6cRUw4NCQ==
X-Google-Smtp-Source: AGHT+IE1bFuZc+mJSxD+pVgtIXeCVNo3r5g8GwiOKV1aPw1h19MOC16mxaJFq0Q2g2TOYWxaSa9TjA==
X-Received: by 2002:a05:6a00:c8b:b0:6be:5a1a:3bb8 with SMTP id a11-20020a056a000c8b00b006be5a1a3bb8mr14049796pfv.28.1698136456363;
        Tue, 24 Oct 2023 01:34:16 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.34.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:34:16 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: Liam.Howlett@oracle.com,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	willy@infradead.org,
	brauner@kernel.org,
	surenb@google.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	oliver.sang@intel.com,
	mst@redhat.com
Cc: zhangpeng.00@bytedance.com,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 10/10] fork: Use __mt_dup() to duplicate maple tree in dup_mmap()
Date: Tue, 24 Oct 2023 16:32:58 +0800
Message-Id: <20231024083258.65750-11-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
directly replacing the entries of VMAs in the new maple tree can result
in better performance. __mt_dup() uses DFS pre-order to duplicate the
maple tree, so it is efficient.

The average time complexity of __mt_dup() is O(n), where n is the number
of VMAs. The proof of the time complexity is provided in the commit log
that introduces __mt_dup(). After duplicating the maple tree, each element
is traversed and replaced (ignoring the cases of deletion, which are rare).
Since it is only a replacement operation for each element, this process is
also O(n).

Analyzing the exact time complexity of the previous algorithm is
challenging because each insertion can involve appending to a node, pushing
data to adjacent nodes, or even splitting nodes. The frequency of each
action is difficult to calculate. The worst-case scenario for a single
insertion is when the tree undergoes splitting at every level. If we
consider each insertion as the worst-case scenario, we can determine that
the upper bound of the time complexity is O(n*log(n)), although this is a
loose upper bound. However, based on the test data, it appears that the
actual time complexity is likely to be O(n).

As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
fails, there will be a portion of VMAs that have not been duplicated in
the maple tree. To handle this, we mark the failure point with
XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered, stop
releasing VMAs that have not been duplicated after this point.

There is a "spawn" in byte-unixbench[1], which can be used to test the
performance of fork(). I modified it slightly to make it work with
different number of VMAs.

Below are the test results. The first row shows the number of VMAs.
The second and third rows show the number of fork() calls per ten seconds,
corresponding to next-20231006 and the this patchset, respectively. The
test results were obtained with CPU binding to avoid scheduler load
balancing that could cause unstable results. There are still some
fluctuations in the test results, but at least they are better than the
original performance.

21     121   221    421    821    1621   3221   6421   12821  25621  51221
112100 76261 54227  34035  20195  11112  6017   3161   1606   802    393
114558 83067 65008  45824  28751  16072  8922   4747   2436   1233   599
2.19%  8.92% 19.88% 34.64% 42.37% 44.64% 48.28% 50.17% 51.68% 53.74% 52.42%

[1] https://github.com/kdlucas/byte-unixbench/tree/master

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 11 +++++++++++
 kernel/fork.c      | 40 +++++++++++++++++++++++++++++-----------
 mm/internal.h      | 11 -----------
 mm/memory.c        |  7 ++++++-
 mm/mmap.c          |  9 ++++++---
 5 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 14d5aaff96d0..e9111ec5808c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -996,6 +996,17 @@ static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
 	return mas_expected_entries(&vmi->mas, count);
 }
 
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	__mas_set_range(&vmi->mas, start, end - 1);
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /* Free any unused preallocations */
 static inline void vma_iter_free(struct vma_iterator *vmi)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 1e6c656e0857..1552ee66517b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	int retval;
 	unsigned long charge = 0;
 	LIST_HEAD(uf);
-	VMA_ITERATOR(old_vmi, oldmm, 0);
 	VMA_ITERATOR(vmi, mm, 0);
 
 	uprobe_start_dup_mmap();
@@ -678,16 +677,22 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		goto out;
 	khugepaged_fork(mm, oldmm);
 
-	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
-	if (retval)
+	/* Use __mt_dup() to efficiently build an identical maple tree. */
+	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
+	if (unlikely(retval))
 		goto out;
 
 	mt_clear_in_rcu(vmi.mas.tree);
-	for_each_vma(old_vmi, mpnt) {
+	for_each_vma(vmi, mpnt) {
 		struct file *file;
 
 		vma_start_write(mpnt);
 		if (mpnt->vm_flags & VM_DONTCOPY) {
+			retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
+						    mpnt->vm_end, GFP_KERNEL);
+			if (retval)
+				goto loop_out;
+
 			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
 			continue;
 		}
@@ -749,9 +754,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (is_vm_hugetlb_page(tmp))
 			hugetlb_dup_vma_private(tmp);
 
-		/* Link the vma into the MT */
-		if (vma_iter_bulk_store(&vmi, tmp))
-			goto fail_nomem_vmi_store;
+		/*
+		 * Link the vma into the MT. After using __mt_dup(), memory
+		 * allocation is not necessary here, so it cannot fail.
+		 */
+		vma_iter_bulk_store(&vmi, tmp);
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -760,15 +767,28 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
 
-		if (retval)
+		if (retval) {
+			mpnt = vma_next(&vmi);
 			goto loop_out;
+		}
 	}
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
 loop_out:
 	vma_iter_free(&vmi);
-	if (!retval)
+	if (!retval) {
 		mt_set_in_rcu(vmi.mas.tree);
+	} else if (mpnt) {
+		/*
+		 * The entire maple tree has already been duplicated. If the
+		 * mmap duplication fails, mark the failure point with
+		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
+		 * stop releasing VMAs that have not been duplicated after this
+		 * point.
+		 */
+		mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
+		mas_store(&vmi.mas, XA_ZERO_ENTRY);
+	}
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -778,8 +798,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	uprobe_end_dup_mmap();
 	return retval;
 
-fail_nomem_vmi_store:
-	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
 fail_nomem_policy:
diff --git a/mm/internal.h b/mm/internal.h
index b52a526d239d..1825c3b2e15c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1154,17 +1154,6 @@ static inline void vma_iter_clear(struct vma_iterator *vmi)
 	mas_store_prealloc(&vmi->mas, NULL);
 }
 
-static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
-			unsigned long start, unsigned long end, gfp_t gfp)
-{
-	__mas_set_range(&vmi->mas, start, end - 1);
-	mas_store_gfp(&vmi->mas, NULL, gfp);
-	if (unlikely(mas_is_err(&vmi->mas)))
-		return -ENOMEM;
-
-	return 0;
-}
-
 static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vmi)
 {
 	return mas_walk(&vmi->mas);
diff --git a/mm/memory.c b/mm/memory.c
index 4f0dfbd5e4bf..163d8f09dafc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -374,6 +374,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		 * be 0.  This will underflow and is okay.
 		 */
 		next = mas_find(mas, ceiling - 1);
+		if (unlikely(xa_is_zero(next)))
+			next = NULL;
 
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -395,6 +397,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
 				next = mas_find(mas, ceiling - 1);
+				if (unlikely(xa_is_zero(next)))
+					next = NULL;
 				if (mm_wr_locked)
 					vma_start_write(vma);
 				unlink_anon_vmas(vma);
@@ -1743,7 +1747,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 		unmap_single_vma(tlb, vma, start, end, &details,
 				 mm_wr_locked);
 		hugetlb_zap_end(vma, &details);
-	} while ((vma = mas_find(mas, tree_end - 1)) != NULL);
+		vma = mas_find(mas, tree_end - 1);
+	} while (vma && likely(!xa_is_zero(vma)));
 	mmu_notifier_invalidate_range_end(&range);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 8b57e42fd980..9d9f124ef38b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3300,10 +3300,11 @@ void exit_mmap(struct mm_struct *mm)
 	arch_exit_mmap(mm);
 
 	vma = mas_find(&mas, ULONG_MAX);
-	if (!vma) {
+	if (!vma || unlikely(xa_is_zero(vma))) {
 		/* Can happen if dup_mmap() received an OOM */
 		mmap_read_unlock(mm);
-		return;
+		mmap_write_lock(mm);
+		goto destroy;
 	}
 
 	lru_add_drain();
@@ -3338,11 +3339,13 @@ void exit_mmap(struct mm_struct *mm)
 		remove_vma(vma, true);
 		count++;
 		cond_resched();
-	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
+		vma = mas_find(&mas, ULONG_MAX);
+	} while (vma && likely(!xa_is_zero(vma)));
 
 	BUG_ON(count != mm->map_count);
 
 	trace_exit_mmap(mm);
+destroy:
 	__mt_destroy(&mm->mm_mt);
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
-- 
2.20.1


