Return-Path: <linux-fsdevel+bounces-102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391C77C59FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB101C20EFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79753992D;
	Wed, 11 Oct 2023 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boq2ktjI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893622300
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 17:04:46 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29825A9;
	Wed, 11 Oct 2023 10:04:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405497850dbso1154525e9.0;
        Wed, 11 Oct 2023 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043881; x=1697648681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvzEZsVg5isoEN6IAS+eP4mzWmRlP3jKSau9yDceX7A=;
        b=boq2ktjIQiG25FnJmJM2EdSDL4A/OOVpleUixPTgnxaneZkRXA30SIYzeFKL/rwdco
         CA+1l3HwNl/e6U+yP+rwwIaaIp4fiezM82dmDVFd5AO6ZHIgFETCHzp/+UblJ1OawyoO
         xeoZHjv/qv1alEcfGXVEMQsy3DtoOuDSJHGk6vW5ckmi3DgkCZ04BcnfZRb81MNYIoyP
         gS44nLBTT0QZkoKsXOqP3jyUeXsyG/DfYbSyBXZKyzeucOsDprq4qImGcY5EaYM9+Usj
         c/BCCUMawG2xj8/xTKy61LOhCSBz5UukZeE5gts1/jntBgGYh4FvgNnGDp6TwCez9MoP
         u8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043881; x=1697648681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvzEZsVg5isoEN6IAS+eP4mzWmRlP3jKSau9yDceX7A=;
        b=toRZr02VYrNdH+N5/dVguwSBgGTTbMO86ANs9kWVly3CtT2xO77wuFeKDMhD2UkgBk
         qrinWzTTxa4EZlN0P7WWvuh3pk2n7/f9yAA9VUo3i9ldfeCvjv3oMOeBuJlCTSlL2291
         9++7UyA0Kd41j8/1Atj+Lky7BTPN+cV4LMLLUd9+zoZZsDIzB07PmdppOpAaZIcBX+R+
         D1m/6EidM6L2Jyqra3y1fDALNLFBTF3zJbaq1fphI8oY3rf9F9e5OT1Lp0zZyNjNmgQy
         u8sCQbgY3rJo2jNOpPH6Ent3GH6Pw7oPzN2ZG/w2NWifdf/LC6iaUeciD/nysD3oyzNJ
         tNmg==
X-Gm-Message-State: AOJu0YxI5zKUM5RewfQG5sDhDBiGH8nFmP2p6UAmXgfzmDF+e13Cynmx
	WBorZt6/n/nCKufxzgtqy+aIm5gi03g=
X-Google-Smtp-Source: AGHT+IGrlRJzT4WiuJiYQVl4Nooi7hmIa8OfY69qFoOPIJKNCAos7O7P28vtT2EcH8CnCemJHwPBzQ==
X-Received: by 2002:a7b:c394:0:b0:403:31a:77b9 with SMTP id s20-20020a7bc394000000b00403031a77b9mr19163325wmj.37.1697043881511;
        Wed, 11 Oct 2023 10:04:41 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id y19-20020a05600c20d300b004075b3ce03asm3834495wmm.6.2023.10.11.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:04:40 -0700 (PDT)
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
Subject: [PATCH v4 5/5] mm: abstract VMA merge and extend into vma_merge_extend() helper
Date: Wed, 11 Oct 2023 18:04:31 +0100
Message-ID: <f16cbdc2e72d37a1a097c39dc7d1fee8919a1c93.1697043508.git.lstoakes@gmail.com>
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

mremap uses vma_merge() in the case where a VMA needs to be extended. This
can be significantly simplified and abstracted.

This makes it far easier to understand what the actual function is doing,
avoids future mistakes in use of the confusing vma_merge() function and
importantly allows us to make future changes to how vma_merge() is
implemented by knowing explicitly which merge cases each invocation uses.

Note that in the mremap() extend case, we perform this merge only when
old_len == vma->vm_end - addr. The extension_start, i.e. the start of the
extended portion of the VMA is equal to addr + old_len, i.e. vma->vm_end.

With this refactoring, vma_merge() is no longer required anywhere except
mm/mmap.c, so mark it static.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/internal.h |  8 +++-----
 mm/mmap.c     | 31 ++++++++++++++++++++++++-------
 mm/mremap.c   | 30 +++++++++++++-----------------
 3 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index ddaeb9f2d9d7..6fa722b07a94 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1014,11 +1014,9 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 /*
  * mm/mmap.c
  */
-struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
-	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
-	unsigned long end, unsigned long vm_flags, struct anon_vma *,
-	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
-	struct anon_vma_name *);
+struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
+					struct vm_area_struct *vma,
+					unsigned long delta);
 
 enum {
 	/* mark page accessed */
diff --git a/mm/mmap.c b/mm/mmap.c
index e5e50e547ebf..3ea52451623b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -860,13 +860,13 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  * **** is not represented - it will be merged and the vma containing the
  *      area is returned, or the function will return NULL
  */
-struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
-			struct vm_area_struct *prev, unsigned long addr,
-			unsigned long end, unsigned long vm_flags,
-			struct anon_vma *anon_vma, struct file *file,
-			pgoff_t pgoff, struct mempolicy *policy,
-			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-			struct anon_vma_name *anon_name)
+static struct vm_area_struct
+*vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
+	   struct vm_area_struct *prev, unsigned long addr, unsigned long end,
+	   unsigned long vm_flags, struct anon_vma *anon_vma, struct file *file,
+	   pgoff_t pgoff, struct mempolicy *policy,
+	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+	   struct anon_vma_name *anon_name)
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
@@ -2499,6 +2499,23 @@ static struct vm_area_struct
 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 }
 
+/*
+ * Expand vma by delta bytes, potentially merging with an immediately adjacent
+ * VMA with identical properties.
+ */
+struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
+					struct vm_area_struct *vma,
+					unsigned long delta)
+{
+	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
+
+	/* vma is specified as prev, so case 1 or 2 will apply. */
+	return vma_merge(vmi, vma->vm_mm, vma, vma->vm_end, vma->vm_end + delta,
+			 vma->vm_flags, vma->anon_vma, vma->vm_file, pgoff,
+			 vma_policy(vma), vma->vm_userfaultfd_ctx,
+			 anon_vma_name(vma));
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
diff --git a/mm/mremap.c b/mm/mremap.c
index ce8a23ef325a..38d98465f3d8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1096,14 +1096,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	/* old_len exactly to the end of the area..
 	 */
 	if (old_len == vma->vm_end - addr) {
+		unsigned long delta = new_len - old_len;
+
 		/* can we just expand the current mapping? */
-		if (vma_expandable(vma, new_len - old_len)) {
-			long pages = (new_len - old_len) >> PAGE_SHIFT;
-			unsigned long extension_start = addr + old_len;
-			unsigned long extension_end = addr + new_len;
-			pgoff_t extension_pgoff = vma->vm_pgoff +
-				((extension_start - vma->vm_start) >> PAGE_SHIFT);
-			VMA_ITERATOR(vmi, mm, extension_start);
+		if (vma_expandable(vma, delta)) {
+			long pages = delta >> PAGE_SHIFT;
+			VMA_ITERATOR(vmi, mm, vma->vm_end);
 			long charged = 0;
 
 			if (vma->vm_flags & VM_ACCOUNT) {
@@ -1115,17 +1113,15 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			}
 
 			/*
-			 * Function vma_merge() is called on the extension we
-			 * are adding to the already existing vma, vma_merge()
-			 * will merge this extension with the already existing
-			 * vma (expand operation itself) and possibly also with
-			 * the next vma if it becomes adjacent to the expanded
-			 * vma and  otherwise compatible.
+			 * Function vma_merge_extend() is called on the
+			 * extension we are adding to the already existing vma,
+			 * vma_merge_extend() will merge this extension with the
+			 * already existing vma (expand operation itself) and
+			 * possibly also with the next vma if it becomes
+			 * adjacent to the expanded vma and otherwise
+			 * compatible.
 			 */
-			vma = vma_merge(&vmi, mm, vma, extension_start,
-				extension_end, vma->vm_flags, vma->anon_vma,
-				vma->vm_file, extension_pgoff, vma_policy(vma),
-				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			vma = vma_merge_extend(&vmi, vma, delta);
 			if (!vma) {
 				vm_unacct_memory(charged);
 				ret = -ENOMEM;
-- 
2.42.0


