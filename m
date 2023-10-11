Return-Path: <linux-fsdevel+bounces-98-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BB17C59FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EBD1C2101B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C79522302;
	Wed, 11 Oct 2023 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW+uYzdq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE739923
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 17:04:39 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D2198;
	Wed, 11 Oct 2023 10:04:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32615eaa312so20855f8f.2;
        Wed, 11 Oct 2023 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043876; x=1697648676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMA7kWpWolO6o46k4syPx6Ijzen7WBJLxGU37wBIQCk=;
        b=HW+uYzdqJW575gvgSROyLKFMI4u5CVtCEE1S2MncfZkniUclsihdGcgN6tbrivusc/
         hBakNEhBgWmoxXv9VCQQjOGvrt1ymmp7QM33Y5ObvstH4kAPhV8QnOxgqdGI4zR2dbs2
         b0JAaoX4KNVB6wp7RlrAP+K3zGP8rLsSgHQVtzfFvtf5lUe+w3eGkYxb8QhQtGCAywHo
         5OdZH6uerRkBmN3nLFXlxtQPeTQsDivJRpwryHCFLCPwDxBneSIA3hT+ge5aWtZ0BmfF
         M4VbhbGczxCyqa1vHHyj6QKalMxR4NKM5tq+e/O21yrPeDmoCZbGFDsl4v/Lv2AF+zfO
         BG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043876; x=1697648676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMA7kWpWolO6o46k4syPx6Ijzen7WBJLxGU37wBIQCk=;
        b=iNYBLG1NMHq8qxuzlabyaGba4vi816y+PxD+dn6VOHyRlGqwxr7OhTfai4inXzeaLt
         pEYVRVr8BSkCv9U/ijkRY92P5kxch//e/8/ynBsLiU9aVTGGMHTOtoQb8eKnqICHgI6q
         cOCqIAoqM+G88X+23XzpVT75IYXXO7r8RpNjPw1A3Fk0ar00dWxchkrOmwfkUGKu9B7N
         /oID05EGLPdv4dDPVgWnTsAUBOYKg0L0TyP6PrN/xz6pbv7sii+F1oxE0RYEswzqDxS3
         /JtRneCiXJctCgxmGzPNf/Re6o57td9ftBzkQilMhvH6F+X15rimm59a+MballYWhAfb
         06YA==
X-Gm-Message-State: AOJu0YwJbcGd+m14JxMVRNcGKN+HUNWr9fvUM0FtkQpJ8mlynsDhUM9w
	lqxBHHMnoEndWK76fN0iLFc=
X-Google-Smtp-Source: AGHT+IErZXTtH6zFvN1YNb1XZ/7m0+WPZUjiChhxsbzC3LcbueadZBZSk23ANxe1fU5f210E6eRSvQ==
X-Received: by 2002:a5d:4fd2:0:b0:31f:f829:49aa with SMTP id h18-20020a5d4fd2000000b0031ff82949aamr17193935wrw.23.1697043876067;
        Wed, 11 Oct 2023 10:04:36 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id y19-20020a05600c20d300b004075b3ce03asm3834495wmm.6.2023.10.11.10.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:04:34 -0700 (PDT)
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
Subject: [PATCH v4 1/5] mm: move vma_policy() and anon_vma_name() decls to mm_types.h
Date: Wed, 11 Oct 2023 18:04:27 +0100
Message-ID: <24bfc6c9e382fffbcb0ea8d424392c27d56cc8ca.1697043508.git.lstoakes@gmail.com>
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

The vma_policy() define is a helper specifically for a VMA field so it
makes sense to host it in the memory management types header.

The anon_vma_name(), anon_vma_name_alloc() and anon_vma_name_free()
functions are a little out of place in mm_inline.h as they define external
functions, and so it makes sense to locate them in mm_types.h.

The purpose of these relocations is to make it possible to abstract static
inline wrappers which invoke both of these helpers.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/mempolicy.h |  4 ----
 include/linux/mm_inline.h | 20 +-------------------
 include/linux/mm_types.h  | 27 +++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 3c208d4f0ee9..2801d5b0a4e9 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -89,8 +89,6 @@ static inline struct mempolicy *mpol_dup(struct mempolicy *pol)
 	return pol;
 }
 
-#define vma_policy(vma) ((vma)->vm_policy)
-
 static inline void mpol_get(struct mempolicy *pol)
 {
 	if (pol)
@@ -222,8 +220,6 @@ static inline struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 	return NULL;
 }
 
-#define vma_policy(vma) NULL
-
 static inline int
 vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 {
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 8148b30a9df1..9ae7def16cb2 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -4,6 +4,7 @@
 
 #include <linux/atomic.h>
 #include <linux/huge_mm.h>
+#include <linux/mm_types.h>
 #include <linux/swap.h>
 #include <linux/string.h>
 #include <linux/userfaultfd_k.h>
@@ -352,15 +353,6 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 }
 
 #ifdef CONFIG_ANON_VMA_NAME
-/*
- * mmap_lock should be read-locked when calling anon_vma_name(). Caller should
- * either keep holding the lock while using the returned pointer or it should
- * raise anon_vma_name refcount before releasing the lock.
- */
-extern struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma);
-extern struct anon_vma_name *anon_vma_name_alloc(const char *name);
-extern void anon_vma_name_free(struct kref *kref);
-
 /* mmap_lock should be read-locked */
 static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
 {
@@ -415,16 +407,6 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 }
 
 #else /* CONFIG_ANON_VMA_NAME */
-static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
-{
-	return NULL;
-}
-
-static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
-{
-	return NULL;
-}
-
 static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
 static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
 static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e6..21eb56145f57 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -546,6 +546,27 @@ struct anon_vma_name {
 	char name[];
 };
 
+#ifdef CONFIG_ANON_VMA_NAME
+/*
+ * mmap_lock should be read-locked when calling anon_vma_name(). Caller should
+ * either keep holding the lock while using the returned pointer or it should
+ * raise anon_vma_name refcount before releasing the lock.
+ */
+struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma);
+struct anon_vma_name *anon_vma_name_alloc(const char *name);
+void anon_vma_name_free(struct kref *kref);
+#else /* CONFIG_ANON_VMA_NAME */
+static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
+static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
+{
+	return NULL;
+}
+#endif
+
 struct vma_lock {
 	struct rw_semaphore lock;
 };
@@ -662,6 +683,12 @@ struct vm_area_struct {
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
 
+#ifdef CONFIG_NUMA
+#define vma_policy(vma) ((vma)->vm_policy)
+#else
+#define vma_policy(vma) NULL
+#endif
+
 #ifdef CONFIG_SCHED_MM_CID
 struct mm_cid {
 	u64 time;
-- 
2.42.0


