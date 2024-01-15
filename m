Return-Path: <linux-fsdevel+bounces-7987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808E882E01C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1396B285DCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFF318EA0;
	Mon, 15 Jan 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p74byPgz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB918E1D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9c7932b3so13992979276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705343923; x=1705948723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLlMsVPwk9YFRfJ1xkZa3gURgHKOqqqaOLfJjGTa1Bw=;
        b=p74byPgz+dtfmyc2Mci897DKkR+m9CFVuXWEUMpI/9zbFHW+i3VJk1TmMonhR67NQP
         EA3jqiVrcAUnodwE/e/sqHUNWr+8WZsjqqeZOfBLV9leh4Aoh5Vp65L5mRtPZkCnd2Vr
         qQ/pRb9jy+L2tq5pwDaluDl4vsiGbEENgKDSH4n7nb4mOwgFnXU94kqMCKxOz1rZTqcI
         X6FhfuCQtAGWTby0uPZuFGwf89jUk45W7ycUVKanPQPlKF94By7TIN3VUaNqk6i02VRa
         M/kILqSzbLDbqWYkd//QJ+WFzzQzGuwqpoCQDaN/OtlvO3FaTf6sRR+8yRceHP4tEAH/
         FWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705343923; x=1705948723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLlMsVPwk9YFRfJ1xkZa3gURgHKOqqqaOLfJjGTa1Bw=;
        b=JnMu5Z+gPLXbEogwlV9M6g6OipUEeo0LGWpVko/kcbbkH1vgIMXtrn2h4lLsmOEIka
         LGluSrckIkt6jqGeRdvASgHiGo+ZPVCRHF/buUv/1waHJYNC7RSjIojvZICzWfvYm3CZ
         wbc6AVYIxKM8Q+i3Yi4hWGnrZRTNn1VysDn1mofNJJ7qAKoJwl4eCXj4m2lLaovHNKZO
         clvK0BFoEfBAd/Ed5K0kvftqJ/GjA2wXAuE8kq6vgQneaMm7zUl3ksNvX+R4a/DZFkJ1
         3LeeYHkVhOOvqQSCNKAiGy8kipH42PvCs1Vp4QmHLRytcDrRC+3cDWan6Cful/KyA8it
         WF2A==
X-Gm-Message-State: AOJu0YxjIGk/XsK6tliCfhU8hoHMn5oqY7VTL9hjQ66vq3ZQGiE0ZGHr
	dkobwQlmYMBubXyKe6SUOYdR8GAVcR4mYSRoWw==
X-Google-Smtp-Source: AGHT+IETYM+vP+GcA1bz5ffGAn7xpFLG8rQcpZyAKLVas4y2HqU4DVH4yHlOoP/EqERN0tEXwr857q4NqX0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3af2:e48e:2785:270])
 (user=surenb job=sendgmr) by 2002:a25:a292:0:b0:dc1:f71f:a0ad with SMTP id
 c18-20020a25a292000000b00dc1f71fa0admr1244231ybi.13.1705343922947; Mon, 15
 Jan 2024 10:38:42 -0800 (PST)
Date: Mon, 15 Jan 2024 10:38:34 -0800
In-Reply-To: <20240115183837.205694-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115183837.205694-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240115183837.205694-2-surenb@google.com>
Subject: [RFC 1/3] mm: make vm_area_struct anon_name field RCU-safe
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	dchinner@redhat.com, casey@schaufler-ca.com, ben.wolsieffer@hefring.com, 
	paulmck@kernel.org, david@redhat.com, avagin@google.com, 
	usama.anjum@collabora.com, peterx@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@Oracle.com, 
	yuzhao@google.com, axelrasmussen@google.com, lstoakes@gmail.com, 
	talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

For lockless /proc/pid/maps reading we have to ensure all the fields
used when generating the output are RCU-safe. The only pointer fields
in vm_area_struct which are used to generate that file's output are
vm_file and anon_name. vm_file is RCU-safe but anon_name is not. Make
anon_name RCU-safe as well.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_inline.h | 10 +++++++++-
 include/linux/mm_types.h  |  3 ++-
 mm/madvise.c              | 30 ++++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400..bbdb0ca857f1 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -389,7 +389,7 @@ static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
 	struct anon_vma_name *anon_name = anon_vma_name(orig_vma);
 
 	if (anon_name)
-		new_vma->anon_name = anon_vma_name_reuse(anon_name);
+		rcu_assign_pointer(new_vma->anon_name, anon_vma_name_reuse(anon_name));
 }
 
 static inline void free_anon_vma_name(struct vm_area_struct *vma)
@@ -411,6 +411,8 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 		!strcmp(anon_name1->name, anon_name2->name);
 }
 
+struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma);
+
 #else /* CONFIG_ANON_VMA_NAME */
 static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
 static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
@@ -424,6 +426,12 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 	return true;
 }
 
+static inline
+struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
 #endif  /* CONFIG_ANON_VMA_NAME */
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b2d3a88a34d1..1f0a30c00795 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -545,6 +545,7 @@ struct vm_userfaultfd_ctx {};
 
 struct anon_vma_name {
 	struct kref kref;
+	struct rcu_head rcu;
 	/* The name needs to be at the end because it is dynamically sized. */
 	char name[];
 };
@@ -699,7 +700,7 @@ struct vm_area_struct {
 	 * terminated string containing the name given to the vma, or NULL if
 	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
 	 */
-	struct anon_vma_name *anon_name;
+	struct anon_vma_name __rcu *anon_name;
 #endif
 #ifdef CONFIG_SWAP
 	atomic_long_t swap_readahead_info;
diff --git a/mm/madvise.c b/mm/madvise.c
index 912155a94ed5..0f222d464254 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -88,14 +88,15 @@ void anon_vma_name_free(struct kref *kref)
 {
 	struct anon_vma_name *anon_name =
 			container_of(kref, struct anon_vma_name, kref);
-	kfree(anon_name);
+	kfree_rcu(anon_name, rcu);
 }
 
 struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
 {
 	mmap_assert_locked(vma->vm_mm);
 
-	return vma->anon_name;
+	return rcu_dereference_protected(vma->anon_name,
+		rwsem_is_locked(&vma->vm_mm->mmap_lock));
 }
 
 /* mmap_lock should be write-locked */
@@ -105,7 +106,7 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
 	struct anon_vma_name *orig_name = anon_vma_name(vma);
 
 	if (!anon_name) {
-		vma->anon_name = NULL;
+		rcu_assign_pointer(vma->anon_name, NULL);
 		anon_vma_name_put(orig_name);
 		return 0;
 	}
@@ -113,11 +114,32 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
 	if (anon_vma_name_eq(orig_name, anon_name))
 		return 0;
 
-	vma->anon_name = anon_vma_name_reuse(anon_name);
+	rcu_assign_pointer(vma->anon_name, anon_vma_name_reuse(anon_name));
 	anon_vma_name_put(orig_name);
 
 	return 0;
 }
+
+/*
+ * Returned anon_vma_name is stable due to elevated refcount but not guaranteed
+ * to be assigned to the original VMA after the call.
+ */
+struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma)
+{
+	struct anon_vma_name __rcu *anon_name;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	anon_name = rcu_dereference(vma->anon_name);
+	if (!anon_name)
+		return NULL;
+
+	if (unlikely(!kref_get_unless_zero(&anon_name->kref)))
+		return NULL;
+
+	return anon_name;
+}
+
 #else /* CONFIG_ANON_VMA_NAME */
 static int replace_anon_vma_name(struct vm_area_struct *vma,
 				 struct anon_vma_name *anon_name)
-- 
2.43.0.381.gb435a96ce8-goog


