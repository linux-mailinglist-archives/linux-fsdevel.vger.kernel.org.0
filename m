Return-Path: <linux-fsdevel+bounces-188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D48E7C73AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 19:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06C11C20FB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989B341BE;
	Thu, 12 Oct 2023 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbOBK/93"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6AC2AB57;
	Thu, 12 Oct 2023 17:04:38 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C94C0;
	Thu, 12 Oct 2023 10:04:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so12870435e9.2;
        Thu, 12 Oct 2023 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697130274; x=1697735074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8vXm3Rb5eaL+HF5MglErGcxxNG7EAs28QhToMLXn+Y=;
        b=SbOBK/93R8uby/C8s3MGMTuyLh9015npr3m05JONHsW1aAvsHJpaFg01F3fS5lkWBV
         w1sodH1N+PIMms6l29KFNhflzLRN7NFvvDDbYT1A+CErJZ2PhvDA3V9SSTmua1azkQpg
         Z7K19KjZ2Rz00XeQ6OUPeqFLmC2ttu0XvpCv/6l/x+nd8b4BRGsXfA9/JFZwEZjzJ636
         jFGhj4uj/3KlHdZsJMDCQ8U89MbjrXMkfFVOiwcWh+Qs3oYi0CZn252rB0yf+k6xBVzK
         /yl0KXNTzRbjP/5bXNyLoKx3L7NWi7Fsy8Ea/7n4OE4LrHhcKh3qkwbovmfli0NM/k/7
         rEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697130274; x=1697735074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8vXm3Rb5eaL+HF5MglErGcxxNG7EAs28QhToMLXn+Y=;
        b=cnzvxujuFG7NDyy9tmpCxPJiCZRqRkgPM5fgicUn2D8bkNjHwdlsWSepKjyDXFo7Uz
         jDkvzslJNjX4jrh8pO6dgnc1a1j8gfx9rUHIX/Ch7Ls55z/hrU5HhOO7nsYHoXf/WRWc
         Us4g3G1MGqDY/Xh9qv+ecNjH/NQuP1RaGSUvyKgfomZ0QIyNH0xO5xl04o325VQz1Y5V
         oRfCHHrRziLTr/DfARCIinso+lbwMFNlx9sxIhuTqsLAb1YJoV3SMNbHw03NsHlOxldY
         FVfCL4ibW0aqh/yPdICgxXQ1lBELWBwi+Kyu6bZJxJgTJbGf2susQ7K7sVfM3NCVt030
         Qe2w==
X-Gm-Message-State: AOJu0Yxj4TxCMxuw0IS9c8lchR1Vwin92UwsEC3vJXMr1PVM+4Vs73md
	LJm7ARaBVOkFUSJ/FCTECzM=
X-Google-Smtp-Source: AGHT+IG1WtI4624aFb3uDRoHHKgnKF/CRfbpjPSiwsKx3X2z2FPwp37I71ARseeuIXbEk1RVZb30MA==
X-Received: by 2002:a5d:458f:0:b0:321:6ff5:9256 with SMTP id p15-20020a5d458f000000b003216ff59256mr19911164wrq.58.1697130274280;
        Thu, 12 Oct 2023 10:04:34 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id h16-20020adffd50000000b003197869bcd7sm18875418wrs.13.2023.10.12.10.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:04:33 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 1/3] mm: drop the assumption that VM_SHARED always implies writable
Date: Thu, 12 Oct 2023 18:04:28 +0100
Message-ID: <d978aefefa83ec42d18dfa964ad180dbcde34795.1697116581.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697116581.git.lstoakes@gmail.com>
References: <cover.1697116581.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a general assumption that VMAs with the VM_SHARED flag set are
writable. If the VM_MAYWRITE flag is not set, then this is simply not the
case.

Update those checks which affect the struct address_space->i_mmap_writable
field to explicitly test for this by introducing [vma_]is_shared_maywrite()
helper functions.

This remains entirely conservative, as the lack of VM_MAYWRITE guarantees
that the VMA cannot be written to.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/fs.h |  4 ++--
 include/linux/mm.h | 11 +++++++++++
 kernel/fork.c      |  2 +-
 mm/filemap.c       |  2 +-
 mm/madvise.c       |  2 +-
 mm/mmap.c          | 12 ++++++------
 6 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 92a9c6157de1..e9c03fb00d5c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -454,7 +454,7 @@ extern const struct address_space_operations empty_aops;
  *   It is also used to block modification of page cache contents through
  *   memory mappings.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
- * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
@@ -557,7 +557,7 @@ static inline int mapping_mapped(struct address_space *mapping)
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap
+ * Note that i_mmap_writable counts all VM_SHARED, VM_MAYWRITE vmas: do_mmap
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 74d7547ffb70..bae234d18d81 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -937,6 +937,17 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
+static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
+static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+{
+	return is_shared_maywrite(vma->vm_flags);
+}
+
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index e45a4457ba83..1e6c656e0857 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -733,7 +733,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 
 			get_file(file);
 			i_mmap_lock_write(mapping);
-			if (tmp->vm_flags & VM_SHARED)
+			if (vma_is_shared_maywrite(tmp))
 				mapping_allow_writable(mapping);
 			flush_dcache_mmap_lock(mapping);
 			/* insert tmp into the share list, just after mpnt */
diff --git a/mm/filemap.c b/mm/filemap.c
index 9ef49255f1a5..9710f43a89ac 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3618,7 +3618,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
  */
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+	if (vma_is_shared_maywrite(vma))
 		return -EINVAL;
 	return generic_file_mmap(file, vma);
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 70dafc99ff1e..6214a1ab5654 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -981,7 +981,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 			return -EINVAL;
 	}
 
-	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
+	if (!vma_is_shared_maywrite(vma))
 		return -EACCES;
 
 	offset = (loff_t)(start - vma->vm_start)
diff --git a/mm/mmap.c b/mm/mmap.c
index 3ea52451623b..0041e3631f6c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -107,7 +107,7 @@ void vma_set_page_prot(struct vm_area_struct *vma)
 static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 		struct file *file, struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_unmap_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -384,7 +384,7 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_allow_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -2846,7 +2846,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
-		if (vm_flags & VM_SHARED) {
+		if (is_shared_maywrite(vm_flags)) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
 				goto free_vma;
@@ -2920,7 +2920,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	mm->map_count++;
 	if (vma->vm_file) {
 		i_mmap_lock_write(vma->vm_file->f_mapping);
-		if (vma->vm_flags & VM_SHARED)
+		if (vma_is_shared_maywrite(vma))
 			mapping_allow_writable(vma->vm_file->f_mapping);
 
 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
@@ -2937,7 +2937,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
-	if (file && vm_flags & VM_SHARED)
+	if (file && is_shared_maywrite(vm_flags))
 		mapping_unmap_writable(file->f_mapping);
 	file = vma->vm_file;
 	ksm_add_vma(vma);
@@ -2985,7 +2985,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
 			     vma->vm_end, vma->vm_end, true);
 	}
-	if (file && (vm_flags & VM_SHARED))
+	if (file && is_shared_maywrite(vm_flags))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
-- 
2.42.0


