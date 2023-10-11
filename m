Return-Path: <linux-fsdevel+bounces-99-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B247C59FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176E22822E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC022310;
	Wed, 11 Oct 2023 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1WhaD4s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D622301
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 17:04:42 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677B8CF;
	Wed, 11 Oct 2023 10:04:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso7771745e9.1;
        Wed, 11 Oct 2023 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043879; x=1697648679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYZtGWQnk+qTSD3PTRtexwtcvMKng8mprQW/gWAvlII=;
        b=I1WhaD4s3NJDNYSqJmiPIm+YQs67lFI6euBQl9HhI3eN0CxnWQPBNQ7TmcNMzRom2s
         CZD7uJHzFRqYoiCl1iBZncP4Fkbw9DatOa14SUGspBwHaLfuNlrluvj6qHbmXHYQSrJW
         bwo+2jR1lvcajSNX4r6VaW/ME9ykYMQvF1bT/9gWTPeukleOA/Vf7I751MUYDPDEXL+U
         EZtT8ODg7Si+X84duPZGnWr8Nl/e2ZND5zbL4s1KTZdiMpn58J1ZOutBO7A5eat7FNhp
         /UyfroZgFVUGEDuat1F7vJyc6+qDHLzVwAE7WUd9tbcSYyz3EsqpBOl23g811N+f/LNM
         sMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043879; x=1697648679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYZtGWQnk+qTSD3PTRtexwtcvMKng8mprQW/gWAvlII=;
        b=dJ0cmQEK1ynK5wuDD9P4v2omQLP2+5Ysae7nqhTuh2AFcUsKscZ6gJXQSJcpS1P71i
         0ugOhEhuTOzzyme+2HUgHAtzyaQ7hKhYW4r1joB8HhXZ9XZOu+iUErLlyaRPCxxVzEI5
         Rrw2Ce6jQ17kImm00t9PsImtYRHxUZj6rCDbGx6tx7BOB3qlh/goqdE5UXmqPV1ic/vV
         J+mf9v0Ye3SmhRqWpZfAUASgxAg16FEDOdJx5vCGGXQ+GtAYav1mCYXxAe6kapk6Y6t5
         jbVDwZM6zWHbEHOtE7BYEI+eztbDfxaAKn6bZjMQIxp5D4W4meLJteQ0f4OHdsG+yWuW
         5pRQ==
X-Gm-Message-State: AOJu0Yz7KjyfMM3ngl6OzUPWrSVgRx1oRkjgNvsOYGCz8yPAlKHDYjCa
	aB13wFH5cVre8bFFNsE9BsM=
X-Google-Smtp-Source: AGHT+IEaxDcfzdWylWTP/iaHYGj0U8wM+RJx9S2LL73muVEhfzeVRfiR500cRLgmK2tkV/LbvoV7OQ==
X-Received: by 2002:a05:600c:205a:b0:405:784a:d53e with SMTP id p26-20020a05600c205a00b00405784ad53emr14090015wmg.20.1697043878737;
        Wed, 11 Oct 2023 10:04:38 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id y19-20020a05600c20d300b004075b3ce03asm3834495wmm.6.2023.10.11.10.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:04:37 -0700 (PDT)
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
Subject: [PATCH v4 3/5] mm: make vma_merge() and split_vma() internal
Date: Wed, 11 Oct 2023 18:04:29 +0100
Message-ID: <405f2be10e20c4e9fbcc9fe6b2dfea105f6642e0.1697043508.git.lstoakes@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now the common pattern of - attempting a merge via vma_merge() and should
this fail splitting VMAs via split_vma() - has been abstracted, the former
can be placed into mm/internal.h and the latter made static.

In addition, the split_vma() nommu variant also need not be exported.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/mm.h | 9 ---------
 mm/internal.h      | 9 +++++++++
 mm/mmap.c          | 8 ++++----
 mm/nommu.c         | 4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 83ee1f35febe..74d7547ffb70 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3237,16 +3237,7 @@ extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		      struct vm_area_struct *next);
 extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end, pgoff_t pgoff);
-extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
-	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
-	unsigned long end, unsigned long vm_flags, struct anon_vma *,
-	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
-	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
-extern int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
-		       unsigned long addr, int new_below);
-extern int split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
-			 unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff --git a/mm/internal.h b/mm/internal.h
index 3a72975425bb..ddaeb9f2d9d7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1011,6 +1011,15 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmd,
 				   unsigned int flags);
 
+/*
+ * mm/mmap.c
+ */
+struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
+	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
+	unsigned long end, unsigned long vm_flags, struct anon_vma *,
+	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
+	struct anon_vma_name *);
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
diff --git a/mm/mmap.c b/mm/mmap.c
index bca685820763..a516f2412f79 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2346,8 +2346,8 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
  * has already been checked or doesn't make sense to fail.
  * VMA Iterator will point to the end VMA.
  */
-int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long addr, int new_below)
+static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		       unsigned long addr, int new_below)
 {
 	struct vma_prepare vp;
 	struct vm_area_struct *new;
@@ -2428,8 +2428,8 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	      unsigned long addr, int new_below)
+static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		     unsigned long addr, int new_below)
 {
 	if (vma->vm_mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
diff --git a/mm/nommu.c b/mm/nommu.c
index f9553579389b..fc4afe924ad5 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1305,8 +1305,8 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
  * split a vma into two pieces at address 'addr', a new vma is allocated either
  * for the first part or the tail.
  */
-int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	      unsigned long addr, int new_below)
+static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		     unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	struct vm_region *region;
-- 
2.42.0


