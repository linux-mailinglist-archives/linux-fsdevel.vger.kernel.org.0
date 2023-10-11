Return-Path: <linux-fsdevel+bounces-100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C307C59FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518B7282950
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E8A22315;
	Wed, 11 Oct 2023 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwJ0O0y/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DC20321
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 17:04:42 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310E6B0;
	Wed, 11 Oct 2023 10:04:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-406619b53caso1103865e9.1;
        Wed, 11 Oct 2023 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043877; x=1697648677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbrHmb7+pjIK0hQxBBJ9IhzQZydFs2ChsPIAgakuSVk=;
        b=dwJ0O0y/fuLtdaSNpLOvLw/kIhV+UvwEEjzipILvrorW7wLqi1kjCpiShh0mDXBrZR
         W6JoI7Ssd1frNTANt57UDRnWQlmrB481sTHoAQZVzQ8NxNKnylJO6YsPTXG0yTuugYLv
         5OkV75YeDYbGXckmEnRQNRXJ3XAmGtihp5eZGebCuYnn451wc80gnSwR/FaisH7t5nh/
         keVxXPC6eoduVv+D6pPHYP6y87p4PctxNqfavEopcNjlezIeyDxEeFJ7PLuhRrph0BEd
         wKFxEkASa6k4YTdRGlLkX+rFujAT+R7ejP9x3ua9J8w6M5llnovac1A2vqtK8cUV672Z
         Kv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043877; x=1697648677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbrHmb7+pjIK0hQxBBJ9IhzQZydFs2ChsPIAgakuSVk=;
        b=R4aQgWFM0JXXww0pqxC30swmhC7G6uu8Vbeg220By3xfEoK1pzjnMnBWLSJabpziTG
         BrPr2SXvM00ZS+eKDu3HA7O/oicW5EVIQKSoldQdwH3Skre+vkvD9i5krGQYSg3ucDcH
         xnu2YBnXzdIcvR4j+2ayRLFz3mFV/AGA5B9vFyuDjktuYVY1lZUWyMB7On1HGwjRRoGQ
         P7FLjdAvb/3unCqrNfCDuqN3JGhTPvsMCdKshI1LxwFPx4ZtkLDQUM2UiHFCQLYpUcKX
         /vcmzqQ92ctZeC3c/rrmNbvxWSX2zQ9b8VQ1JHY0wG+/43aMk4igjiIqC3REzPxHEvz6
         hW9Q==
X-Gm-Message-State: AOJu0YxQAMKNAnovMi/0i2PzT/PdQGxRGVC95WTnG37y/2A1e9aQskuw
	NhlwPTDEVA9IgwG/J2AKvh8=
X-Google-Smtp-Source: AGHT+IHW7VlW4caZL7jgUx6V96QPSxLJ6wWlmykp4QL4Dwal5qZUOT9MuJyw92bo0I5OpKpEQwIIuw==
X-Received: by 2002:a7b:ce98:0:b0:401:d2cb:e6f2 with SMTP id q24-20020a7bce98000000b00401d2cbe6f2mr18195397wmj.32.1697043877497;
        Wed, 11 Oct 2023 10:04:37 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id y19-20020a05600c20d300b004075b3ce03asm3834495wmm.6.2023.10.11.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:04:36 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 2/5] mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.
Date: Wed, 11 Oct 2023 18:04:28 +0100
Message-ID: <0dfa9368f37199a423674bf0ee312e8ea0619044.1697043508.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697043508.git.lstoakes@gmail.com>
References: <cover.1697043508.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

mprotect() and other functions which change VMA parameters over a range
each employ a pattern of:-

1. Attempt to merge the range with adjacent VMAs.
2. If this fails, and the range spans a subset of the VMA, split it
   accordingly.

This is open-coded and duplicated in each case. Also in each case most of
the parameters passed to vma_merge() remain the same.

Create a new function, vma_modify(), which abstracts this operation,
accepting only those parameters which can be changed.

To avoid the mess of invoking each function call with unnecessary
parameters, create inline wrapper functions for each of the modify
operations, parameterised only by what is required to perform the action.

We can also significantly simplify the logic - by returning the VMA if we
split (or merged VMA if we do not) we no longer need specific handling for
merge/split cases in any of the call sites.

Note that the userfaultfd_release() case works even though it does not
split VMAs - since start is set to vma->vm_start and end is set to
vma->vm_end, the split logic does not trigger.

In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
- vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
instance, this invocation will remain unchanged.

We eliminate a VM_WARN_ON() in mprotect_fixup() as this simply asserts that
vma_merge() correctly ensures that flags remain the same, something that is
already checked in is_mergeable_vma() and elsewhere, and in any case is not
specific to mprotect().

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/userfaultfd.c   | 70 ++++++++++++----------------------------------
 include/linux/mm.h | 60 +++++++++++++++++++++++++++++++++++++++
 mm/madvise.c       | 26 +++--------------
 mm/mempolicy.c     | 26 ++---------------
 mm/mlock.c         | 25 +++--------------
 mm/mmap.c          | 48 +++++++++++++++++++++++++++++++
 mm/mprotect.c      | 29 +++----------------
 7 files changed, 141 insertions(+), 143 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index a7c6ef764e63..ac616cfbacf5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -927,20 +927,15 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			continue;
 		}
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
-				 new_flags, vma->anon_vma,
-				 vma->vm_file, vma->vm_pgoff,
-				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
-		if (prev) {
-			vma = prev;
-		} else {
-			prev = vma;
-		}
+		vma = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
+					    vma->vm_end, new_flags,
+					    NULL_VM_UFFD_CTX);
 
 		vma_start_write(vma);
 		userfaultfd_set_vm_flags(vma, new_flags);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+
+		prev = vma;
 	}
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1331,7 +1326,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	unsigned long start, end, vma_end;
 	struct vma_iterator vmi;
 	bool wp_async = userfaultfd_wp_async_ctx(ctx);
-	pgoff_t pgoff;
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1484,28 +1478,14 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma_end = min(end, vma->vm_end);
 
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, pgoff,
-				 vma_policy(vma),
-				 ((struct vm_userfaultfd_ctx){ ctx }),
-				 anon_vma_name(vma));
-		if (prev) {
-			/* vma_merge() invalidated the mas */
-			vma = prev;
-			goto next;
-		}
-		if (vma->vm_start < start) {
-			ret = split_vma(&vmi, vma, start, 1);
-			if (ret)
-				break;
-		}
-		if (vma->vm_end > end) {
-			ret = split_vma(&vmi, vma, end, 0);
-			if (ret)
-				break;
+		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
+					    new_flags,
+					    (struct vm_userfaultfd_ctx){ctx});
+		if (IS_ERR(vma)) {
+			ret = PTR_ERR(vma);
+			break;
 		}
-	next:
+
 		/*
 		 * In the vma_merge() successful mprotect-like case 8:
 		 * the next vma was merged into the current one and
@@ -1568,7 +1548,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
 	bool wp_async = userfaultfd_wp_async_ctx(ctx);
-	pgoff_t pgoff;
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1671,26 +1650,13 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			uffd_wp_range(vma, start, vma_end - start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, pgoff,
-				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
-		if (prev) {
-			vma = prev;
-			goto next;
-		}
-		if (vma->vm_start < start) {
-			ret = split_vma(&vmi, vma, start, 1);
-			if (ret)
-				break;
-		}
-		if (vma->vm_end > end) {
-			ret = split_vma(&vmi, vma, end, 0);
-			if (ret)
-				break;
+		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
+					    new_flags, NULL_VM_UFFD_CTX);
+		if (IS_ERR(vma)) {
+			ret = PTR_ERR(vma);
+			break;
 		}
-	next:
+
 		/*
 		 * In the vma_merge() successful mprotect-like case 8:
 		 * the next vma was merged into the current one and
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7b667786cde..83ee1f35febe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3253,6 +3253,66 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name);
+
+/* We are about to modify the VMA's flags. */
+static inline struct vm_area_struct
+*vma_modify_flags(struct vma_iterator *vmi,
+		  struct vm_area_struct *prev,
+		  struct vm_area_struct *vma,
+		  unsigned long start, unsigned long end,
+		  unsigned long new_flags)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx,
+			  anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or anon_name. */
+static inline struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
+}
+
+/* We are about to modify the VMA's memory policy. */
+static inline struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
+			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or uffd context. */
+static inline struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), new_ctx, anon_vma_name(vma));
+}
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/madvise.c b/mm/madvise.c
index a4a20de50494..70dafc99ff1e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -141,7 +141,6 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int error;
-	pgoff_t pgoff;
 	VMA_ITERATOR(vmi, mm, start);
 
 	if (new_flags == vma->vm_flags && anon_vma_name_eq(anon_vma_name(vma), anon_name)) {
@@ -149,30 +148,13 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 		return 0;
 	}
 
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(&vmi, mm, *prev, start, end, new_flags,
-			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, anon_name);
-	if (*prev) {
-		vma = *prev;
-		goto success;
-	}
+	vma = vma_modify_flags_name(&vmi, *prev, vma, start, end, new_flags,
+				    anon_name);
+	if (IS_ERR(vma))
+		return PTR_ERR(vma);
 
 	*prev = vma;
 
-	if (start != vma->vm_start) {
-		error = split_vma(&vmi, vma, start, 1);
-		if (error)
-			return error;
-	}
-
-	if (end != vma->vm_end) {
-		error = split_vma(&vmi, vma, end, 0);
-		if (error)
-			return error;
-	}
-
-success:
 	/* vm_flags is protected by the mmap_lock held in write mode. */
 	vma_start_write(vma);
 	vm_flags_reset(vma, new_flags);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b01922e88548..898ee2e3c85b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -784,10 +784,7 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct **prev, unsigned long start,
 		unsigned long end, struct mempolicy *new_pol)
 {
-	struct vm_area_struct *merged;
 	unsigned long vmstart, vmend;
-	pgoff_t pgoff;
-	int err;
 
 	vmend = min(end, vma->vm_end);
 	if (start > vma->vm_start) {
@@ -802,26 +799,9 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		return 0;
 	}
 
-	pgoff = vma->vm_pgoff + ((vmstart - vma->vm_start) >> PAGE_SHIFT);
-	merged = vma_merge(vmi, vma->vm_mm, *prev, vmstart, vmend, vma->vm_flags,
-			 vma->anon_vma, vma->vm_file, pgoff, new_pol,
-			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-	if (merged) {
-		*prev = merged;
-		return vma_replace_policy(merged, new_pol);
-	}
-
-	if (vma->vm_start != vmstart) {
-		err = split_vma(vmi, vma, vmstart, 1);
-		if (err)
-			return err;
-	}
-
-	if (vma->vm_end != vmend) {
-		err = split_vma(vmi, vma, vmend, 0);
-		if (err)
-			return err;
-	}
+	vma =  vma_modify_policy(vmi, *prev, vma, vmstart, vmend, new_pol);
+	if (IS_ERR(vma))
+		return PTR_ERR(vma);
 
 	*prev = vma;
 	return vma_replace_policy(vma, new_pol);
diff --git a/mm/mlock.c b/mm/mlock.c
index 42b6865f8f82..aa44456200e3 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -476,7 +476,6 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long end, vm_flags_t newflags)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	pgoff_t pgoff;
 	int nr_pages;
 	int ret = 0;
 	vm_flags_t oldflags = vma->vm_flags;
@@ -487,28 +486,12 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(vmi, mm, *prev, start, end, newflags,
-			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-	if (*prev) {
-		vma = *prev;
-		goto success;
-	}
-
-	if (start != vma->vm_start) {
-		ret = split_vma(vmi, vma, start, 1);
-		if (ret)
-			goto out;
-	}
-
-	if (end != vma->vm_end) {
-		ret = split_vma(vmi, vma, end, 0);
-		if (ret)
-			goto out;
+	vma = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto out;
 	}
 
-success:
 	/*
 	 * Keep track of amount of locked VM.
 	 */
diff --git a/mm/mmap.c b/mm/mmap.c
index 673429ee8a9e..bca685820763 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2437,6 +2437,54 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
+/*
+ * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
+ * context and anonymous VMA name within the range [start, end).
+ *
+ * As a result, we might be able to merge the newly modified VMA range with an
+ * adjacent VMA with identical properties.
+ *
+ * If no merge is possible and the range does not span the entirety of the VMA,
+ * we then need to split the VMA to accommodate the change.
+ *
+ * The function returns either the merged VMA, the original VMA if a split was
+ * required instead, or an error if the split failed.
+ */
+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name)
+{
+	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+	struct vm_area_struct *merged;
+
+	merged = vma_merge(vmi, vma->vm_mm, prev, start, end, vm_flags,
+			   vma->anon_vma, vma->vm_file, pgoff, policy,
+			   uffd_ctx, anon_name);
+	if (merged)
+		return merged;
+
+	if (vma->vm_start < start) {
+		int err = split_vma(vmi, vma, start, 1);
+
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	if (vma->vm_end > end) {
+		int err = split_vma(vmi, vma, end, 0);
+
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	return vma;
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb45d5c7..f6f4a4bca059 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -581,7 +581,6 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned int mm_cp_flags = 0;
 	unsigned long charged = 0;
-	pgoff_t pgoff;
 	int error;
 
 	if (newflags == oldflags) {
@@ -625,34 +624,14 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 		}
 	}
 
-	/*
-	 * First try to merge with previous and/or next vma.
-	 */
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
-			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-	if (*pprev) {
-		vma = *pprev;
-		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
-		goto success;
+	vma = vma_modify_flags(vmi, *pprev, vma, start, end, newflags);
+	if (IS_ERR(vma)) {
+		error = PTR_ERR(vma);
+		goto fail;
 	}
 
 	*pprev = vma;
 
-	if (start != vma->vm_start) {
-		error = split_vma(vmi, vma, start, 1);
-		if (error)
-			goto fail;
-	}
-
-	if (end != vma->vm_end) {
-		error = split_vma(vmi, vma, end, 0);
-		if (error)
-			goto fail;
-	}
-
-success:
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
-- 
2.42.0


