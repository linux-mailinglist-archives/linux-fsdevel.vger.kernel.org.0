Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4599A6A0046
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 01:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjBWA6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 19:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjBWA6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:58:08 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2972333D
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 16:58:03 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536eace862cso64290667b3.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 16:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygr5M4V1j75SuAL72SyMemUXQuqc/aAmRmEhzh1R8lU=;
        b=bLw3VgyQMUsDwrZetk7o8ZBNL/rgRYU99hY51aTWE+R65TK4hwTUcluPSh+7g2fzFU
         ivfHzctLdTh18bTHkFzSOSYf2YHPoQHp5BI8BnsGqMZgwRZXI+6Ac4YCtx/BjeI2NCwJ
         bu4UwHDP+shSWTE6hdZQkR4gxXl+SaGfsGWlbVarn+4vSKMCgKaX4TEgy+Gpq5RqcnNa
         OoJlJToqpbPZitzOaXbNYDDtZmw4QlHjI9v0cWAJDyS7/Eglu0uY5VArnaiF/X2VSt/z
         iRDclo+drFzBNr7MIBYtWPdFcoYdkFawUoPb3ZyiYnnBY1ujQRLmgEKVgwac4DW1f/AH
         Bpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygr5M4V1j75SuAL72SyMemUXQuqc/aAmRmEhzh1R8lU=;
        b=Zd7wIOYm1ctHIfhSkaaPEJZ6T3RgJzLNBfCO+hSSwHZUkC1PeVNbADMjIaP2xDR/uI
         t0Hd53g4nJacgjH057QgNLF2nSHfCZTVqffb7tlup9Jo+yCMdGCuTcv32u1+XIwgmS5t
         K86MGzc/BDZM+oIeDg6/ax65wlVTDjUM90RWtACANxY+vFWl9DdUFjaEsBnqzJ/mdGbQ
         4vlUJa1UVP9YhUVHmd1q8sMSvBIZSY/R7KOcY5WxfnQAeWNvnBaIh6LtUN2yDiONaHlX
         OzuiCdtvmpS8p5D7fD3O4tBOJ7HTJXhZMbolFITOO4SL60Ye3R86z3ZMkznMp1TUgefS
         Q2vg==
X-Gm-Message-State: AO0yUKU6IphRlyG0hnuuN8wum3pWSzR03B/QcuLx3nHUf3MrRsFMx1xC
        TR4J9a69KhEa1hUGtq/AZ9vCwu0AT4NkYqs/t5yQ
X-Google-Smtp-Source: AK7set9p4GPjKWxmyOTEbhaALL5+3hP+AWPzv95pP+ISY96cm+bDPhlogrL1nfluafdunUgcLMPuZM7fwpEsBkFL+LL3
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:3e99:dd9e:9db9:449c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:4d4:b0:855:fa17:4f66 with
 SMTP id v20-20020a05690204d400b00855fa174f66mr1414725ybs.8.1677113883232;
 Wed, 22 Feb 2023 16:58:03 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:57:50 -0800
In-Reply-To: <20230223005754.2700663-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230223005754.2700663-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230223005754.2700663-2-axelrasmussen@google.com>
Subject: [PATCH v2 1/5] mm: userfaultfd: rename functions for clarity + consistency
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The basic problem is, over time we've added new userfaultfd ioctls, and
we've refactored the code so functions which used to handle only one
case are now re-used to deal with several cases. While this happened, we
didn't bother to rename the functions.

Similarly, as we added new functions, we cargo-culted pieces of the
now-inconsistent naming scheme, so those functions too ended up with
names that don't make a lot of sense.

A key point here is, "copy" in most userfaultfd code refers specifically
to UFFDIO_COPY, where we allocate a new page and copy its contents from
userspace. There are many functions with "copy" in the name that don't
actually do this (at least in some cases).

So, rename things into a consistent scheme. The high level idea is that
the call stack for userfaultfd ioctls becomes:

userfaultfd_ioctl
  -> userfaultfd_(particular ioctl)
    -> mfill_atomic_(particular kind of fill operation)
      -> mfill_atomic    /* loops over pages in range */
        -> mfill_atomic_pte    /* deals with single pages */
          -> mfill_atomic_pte_(particular kind of fill operation)
            -> mfill_atomic_install_pte

There are of course some special cases (shmem, hugetlb), but this is the
general structure which all function names now adhere to.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c              | 18 +++----
 include/linux/hugetlb.h       | 30 +++++------
 include/linux/userfaultfd_k.h | 18 +++----
 mm/hugetlb.c                  | 20 +++----
 mm/userfaultfd.c              | 98 +++++++++++++++++------------------
 5 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index cc694846617a..c08a26ae77d6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1752,9 +1752,9 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	if (uffdio_copy.mode & ~(UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP))
 		goto out;
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mcopy_atomic(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
-				   uffdio_copy.len, &ctx->mmap_changing,
-				   uffdio_copy.mode);
+		ret = mfill_atomic_copy(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
+					uffdio_copy.len, &ctx->mmap_changing,
+					uffdio_copy.mode);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -1804,9 +1804,9 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mfill_zeropage(ctx->mm, uffdio_zeropage.range.start,
-				     uffdio_zeropage.range.len,
-				     &ctx->mmap_changing);
+		ret = mfill_atomic_zeropage(ctx->mm, uffdio_zeropage.range.start,
+					   uffdio_zeropage.range.len,
+					   &ctx->mmap_changing);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -1914,9 +1914,9 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 		goto out;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mcopy_continue(ctx->mm, uffdio_continue.range.start,
-				     uffdio_continue.range.len,
-				     &ctx->mmap_changing);
+		ret = mfill_atomic_continue(ctx->mm, uffdio_continue.range.start,
+					    uffdio_continue.range.len,
+					    &ctx->mmap_changing);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9ab9d3105d5c..3c389b74e02d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -157,13 +157,13 @@ unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
 #ifdef CONFIG_USERFAULTFD
-int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
-				struct vm_area_struct *dst_vma,
-				unsigned long dst_addr,
-				unsigned long src_addr,
-				enum mcopy_atomic_mode mode,
-				struct page **pagep,
-				bool wp_copy);
+int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
+			     struct vm_area_struct *dst_vma,
+			     unsigned long dst_addr,
+			     unsigned long src_addr,
+			     enum mcopy_atomic_mode mode,
+			     struct page **pagep,
+			     bool wp_copy);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -355,14 +355,14 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 }
 
 #ifdef CONFIG_USERFAULTFD
-static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
-						pte_t *dst_pte,
-						struct vm_area_struct *dst_vma,
-						unsigned long dst_addr,
-						unsigned long src_addr,
-						enum mcopy_atomic_mode mode,
-						struct page **pagep,
-						bool wp_copy)
+static inline int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
+					   pte_t *dst_pte,
+					   struct vm_area_struct *dst_vma,
+					   unsigned long dst_addr,
+					   unsigned long src_addr,
+					   enum mcopy_atomic_mode mode,
+					   struct page **pagep,
+					   bool wp_copy)
 {
 	BUG();
 	return 0;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 9df0b9a762cc..6c5ad5d4aa06 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -61,15 +61,15 @@ extern int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 				    unsigned long dst_addr, struct page *page,
 				    bool newly_allocated, bool wp_copy);
 
-extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
-			    unsigned long src_start, unsigned long len,
-			    atomic_t *mmap_changing, __u64 mode);
-extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
-			      unsigned long dst_start,
-			      unsigned long len,
-			      atomic_t *mmap_changing);
-extern ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long dst_start,
-			      unsigned long len, atomic_t *mmap_changing);
+extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
+				 unsigned long src_start, unsigned long len,
+				 atomic_t *mmap_changing, __u64 mode);
+extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
+				     unsigned long dst_start,
+				     unsigned long len,
+				     atomic_t *mmap_changing);
+extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
+				     unsigned long len, atomic_t *mmap_changing);
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
 			       bool enable_wp, atomic_t *mmap_changing);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bdbfeb6fb393..915a390442e7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6159,17 +6159,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 #ifdef CONFIG_USERFAULTFD
 /*
- * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
- * modifications for huge pages.
+ * Used by userfaultfd UFFDIO_* ioctls. Based on userfaultfd's mfill_atomic_pte
+ * with modifications for hugetlb pages.
  */
-int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
-			    pte_t *dst_pte,
-			    struct vm_area_struct *dst_vma,
-			    unsigned long dst_addr,
-			    unsigned long src_addr,
-			    enum mcopy_atomic_mode mode,
-			    struct page **pagep,
-			    bool wp_copy)
+int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
+			     pte_t *dst_pte,
+			     struct vm_area_struct *dst_vma,
+			     unsigned long dst_addr,
+			     unsigned long src_addr,
+			     enum mcopy_atomic_mode mode,
+			     struct page **pagep,
+			     bool wp_copy)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct hstate *h = hstate_vma(dst_vma);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0499907b6f1a..3980e1b7b7f8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -141,13 +141,13 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	return ret;
 }
 
-static int mcopy_atomic_pte(struct mm_struct *dst_mm,
-			    pmd_t *dst_pmd,
-			    struct vm_area_struct *dst_vma,
-			    unsigned long dst_addr,
-			    unsigned long src_addr,
-			    struct page **pagep,
-			    bool wp_copy)
+static int mfill_atomic_pte_copy(struct mm_struct *dst_mm,
+				 pmd_t *dst_pmd,
+				 struct vm_area_struct *dst_vma,
+				 unsigned long dst_addr,
+				 unsigned long src_addr,
+				 struct page **pagep,
+				 bool wp_copy)
 {
 	void *page_kaddr;
 	int ret;
@@ -218,10 +218,10 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	goto out;
 }
 
-static int mfill_zeropage_pte(struct mm_struct *dst_mm,
-			      pmd_t *dst_pmd,
-			      struct vm_area_struct *dst_vma,
-			      unsigned long dst_addr)
+static int mfill_atomic_pte_zeropage(struct mm_struct *dst_mm,
+				     pmd_t *dst_pmd,
+				     struct vm_area_struct *dst_vma,
+				     unsigned long dst_addr)
 {
 	pte_t _dst_pte, *dst_pte;
 	spinlock_t *ptl;
@@ -254,11 +254,11 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 }
 
 /* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
-static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
-				pmd_t *dst_pmd,
-				struct vm_area_struct *dst_vma,
-				unsigned long dst_addr,
-				bool wp_copy)
+static int mfill_atomic_pte_continue(struct mm_struct *dst_mm,
+				     pmd_t *dst_pmd,
+				     struct vm_area_struct *dst_vma,
+				     unsigned long dst_addr,
+				     bool wp_copy)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
@@ -321,10 +321,10 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 
 #ifdef CONFIG_HUGETLB_PAGE
 /*
- * __mcopy_atomic processing for HUGETLB vmas.  Note that this routine is
+ * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
  * called with mmap_lock held, it will release mmap_lock before returning.
  */
-static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
+static __always_inline ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
 					      struct vm_area_struct *dst_vma,
 					      unsigned long dst_start,
 					      unsigned long src_start,
@@ -425,7 +425,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			goto out_unlock;
 		}
 
-		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
+		err = hugetlb_mfill_atomic_pte(dst_mm, dst_pte, dst_vma,
 					       dst_addr, src_addr, mode, &page,
 					       wp_copy);
 
@@ -477,7 +477,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 }
 #else /* !CONFIG_HUGETLB_PAGE */
 /* fail at build time if gcc attempts to use this */
-extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
+extern ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
 				      struct vm_area_struct *dst_vma,
 				      unsigned long dst_start,
 				      unsigned long src_start,
@@ -498,8 +498,8 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	ssize_t err;
 
 	if (mode == MCOPY_ATOMIC_CONTINUE) {
-		return mcontinue_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-					    wp_copy);
+		return mfill_atomic_pte_continue(dst_mm, dst_pmd, dst_vma,
+						 dst_addr, wp_copy);
 	}
 
 	/*
@@ -514,11 +514,11 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
 		if (mode == MCOPY_ATOMIC_NORMAL)
-			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
-					       dst_addr, src_addr, page,
-					       wp_copy);
+			err = mfill_atomic_pte_copy(dst_mm, dst_pmd, dst_vma,
+						    dst_addr, src_addr, page,
+						    wp_copy);
 		else
-			err = mfill_zeropage_pte(dst_mm, dst_pmd,
+			err = mfill_atomic_pte_zeropage(dst_mm, dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
 		err = shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
@@ -530,13 +530,13 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	return err;
 }
 
-static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
-					      unsigned long dst_start,
-					      unsigned long src_start,
-					      unsigned long len,
-					      enum mcopy_atomic_mode mcopy_mode,
-					      atomic_t *mmap_changing,
-					      __u64 mode)
+static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
+					    unsigned long dst_start,
+					    unsigned long src_start,
+					    unsigned long len,
+					    enum mcopy_atomic_mode mcopy_mode,
+					    atomic_t *mmap_changing,
+					    __u64 mode)
 {
 	struct vm_area_struct *dst_vma;
 	ssize_t err;
@@ -602,9 +602,9 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-					       src_start, len, mcopy_mode,
-					       wp_copy);
+		return  mfill_atomic_hugetlb(dst_mm, dst_vma, dst_start,
+					     src_start, len, mcopy_mode,
+					     wp_copy);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
@@ -702,26 +702,26 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	return copied ? copied : err;
 }
 
-ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
-		     unsigned long src_start, unsigned long len,
-		     atomic_t *mmap_changing, __u64 mode)
+ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
+			  unsigned long src_start, unsigned long len,
+			  atomic_t *mmap_changing, __u64 mode)
 {
-	return __mcopy_atomic(dst_mm, dst_start, src_start, len,
-			      MCOPY_ATOMIC_NORMAL, mmap_changing, mode);
+	return mfill_atomic(dst_mm, dst_start, src_start, len,
+			    MCOPY_ATOMIC_NORMAL, mmap_changing, mode);
 }
 
-ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
-		       unsigned long len, atomic_t *mmap_changing)
+ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm, unsigned long start,
+			      unsigned long len, atomic_t *mmap_changing)
 {
-	return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_ZEROPAGE,
-			      mmap_changing, 0);
+	return mfill_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_ZEROPAGE,
+			    mmap_changing, 0);
 }
 
-ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long start,
-		       unsigned long len, atomic_t *mmap_changing)
+ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
+			      unsigned long len, atomic_t *mmap_changing)
 {
-	return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_CONTINUE,
-			      mmap_changing, 0);
+	return mfill_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_CONTINUE,
+			    mmap_changing, 0);
 }
 
 void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
-- 
2.39.2.637.g21b0678d19-goog

