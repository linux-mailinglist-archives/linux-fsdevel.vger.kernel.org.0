Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8CA724C2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbjFFTFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbjFFTEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF5E1706
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:04:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb2a7308f21so5264235276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078260; x=1688670260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVsoBqdtoJX8/StMCoaJ2TBhLAuQb0ZIsYKuvX8foFc=;
        b=3bRhDOn2F1YoY78ybE5Buf9pXWlEWLIrZLl3zmMqCMxMWePwOymNgzPlL05No/cBty
         JhXR5aZftY97cDZvNkSb70a55Fkj8oothgT0n+qKkVwOjj7CYzQnLwO2wmEIMdOIIq24
         jiWbdBDp6sWsJWroyTU36/XenlT2tddUva4/zzFiwtqHgjy72QN5YVUYSt+vJDoI3IyN
         VcmHCICw1jUnn1dcw1Z79WvsPN60OZDQjPZspnctaG3vX9a9apYfWKKt97pGmH1ZZWZ+
         n8NTZLQKSqtuCbrmmo44T26y4ZuXSivXoMS2qmsA9OyppL+7KUrgyC0TXXVY+vLySr9n
         vPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078260; x=1688670260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVsoBqdtoJX8/StMCoaJ2TBhLAuQb0ZIsYKuvX8foFc=;
        b=FS+RMPlIjtIUVU6D8CazzYLrmEh/zabUGpOp2hW3cITfZcC/ZkU3W187ViAYQhwV0u
         nM1femaEm9hg5aOXUg6utCBfh7/kIJ60nXa04pqYFSEZpyNFRiNIpRs7mZOScOEkWSDx
         +4IVy3gfP3X+WzumGzVb/yccGScoDav04skM4ueEJGG6e/J03gBc63zPMEOZSZCDps8h
         0ZnazynuYZ7GiEKhoP9Z40MQQ+5dTca30LNElLj9nYcX99S7nVGZcbwDV4NbDQtF/jD8
         77iuGZGGfGA5spAZV5vX06mXPD6HjP8DPy/EGoLDCYFnVSjRWKWHMYArcVRJjLtDWu7h
         K8+g==
X-Gm-Message-State: AC+VfDwujW0Xu2dNYt0G4aV7SqQUNDgz+/rRJfTQrBF5lkyvie3hBvGh
        qpXCA5+NuabM66JX/wUMO36cDe3sz7TzpsrVaQ==
X-Google-Smtp-Source: ACHHUZ7pHc1WWdEMTu1ZaLAHhToRSasMGs58ikGHS3ezVoQuVBFPIMzugkY1x4qddS4xfRUOsuXb06aDGCKa9mnCdw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:124f:b0:ba8:2e68:7715 with
 SMTP id t15-20020a056902124f00b00ba82e687715mr1639977ybu.2.1686078260457;
 Tue, 06 Jun 2023 12:04:20 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:49 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <d1c8d97fbeab33b147b104ed18299b510c50ab40.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 04/19] mm: hugetlb: Decouple hstate, subpool from inode
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org
Cc:     brauner@kernel.org, chao.p.peng@linux.intel.com,
        coltonlewis@google.com, david@redhat.com, dhildenb@redhat.com,
        dmatlack@google.com, erdemaktas@google.com, hughd@google.com,
        isaku.yamahata@gmail.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hstate and subpool being retrievable from inode via hstate_inode() and
subpool_inode() respectively is a hugetlbfs concept.

hugetlb should be agnostic of hugetlbfs and hugetlb accounting
functions should accept hstate (required) and subpool (can be NULL)
independently of inode.

inode is still a parameter for these accounting functions since the
inode's block counts need to be updated during accounting.

The inode's resv_map will also still need to be updated if not NULL.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    | 59 ++++++++++++++++++++++++++++-------------
 include/linux/hugetlb.h | 32 +++++++++++++++++-----
 mm/hugetlb.c            | 49 ++++++++++++++++++++--------------
 3 files changed, 95 insertions(+), 45 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 4f25df31ae80..0fc49b6252e4 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -164,7 +164,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	file_accessed(file);
 
 	ret = -ENOMEM;
-	if (!hugetlb_reserve_pages(inode,
+	if (!hugetlb_reserve_pages(h, subpool_inode(inode), inode,
 				vma->vm_pgoff >> huge_page_order(h),
 				len >> huge_page_shift(h), vma,
 				vma->vm_flags))
@@ -550,14 +550,18 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 	}
 }
 
-/*
+/**
+ * Remove folio from page_cache and userspace mappings. Also unreserves pages,
+ * updating hstate @h, subpool @spool (if not NULL), @inode block info and
+ * @inode's resv_map (if not NULL).
+ *
  * Called with hugetlb fault mutex held.
  * Returns true if page was actually removed, false otherwise.
  */
-static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
-					struct address_space *mapping,
-					struct folio *folio, pgoff_t index,
-					bool truncate_op)
+static bool remove_mapping_single_folio(
+	struct address_space *mapping, struct folio *folio, pgoff_t index,
+	struct hstate *h, struct hugepage_subpool *spool, struct inode *inode,
+	bool truncate_op)
 {
 	bool ret = false;
 
@@ -582,9 +586,8 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 	hugetlb_delete_from_page_cache(folio);
 	ret = true;
 	if (!truncate_op) {
-		if (unlikely(hugetlb_unreserve_pages(inode, index,
-							index + 1, 1)))
-			hugetlb_fix_reserve_counts(inode);
+		if (unlikely(hugetlb_unreserve_pages(h, spool, inode, index, index + 1, 1)))
+			hugetlb_fix_reserve_counts(h, spool);
 	}
 
 	folio_unlock(folio);
@@ -592,7 +595,14 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 }
 
 /*
- * remove_inode_hugepages handles two distinct cases: truncation and hole
+ * Remove hugetlb page mappings from @mapping between offsets [@lstart, @lend).
+ * Also updates reservations in:
+ * + hstate @h (required)
+ * + subpool @spool (can be NULL)
+ * + resv_map in @inode (can be NULL)
+ * and updates blocks in @inode (required)
+ *
+ * remove_mapping_hugepages handles two distinct cases: truncation and hole
  * punch.  There are subtle differences in operation for each case.
  *
  * truncation is indicated by end of range being LLONG_MAX
@@ -611,10 +621,10 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
  * Note: If the passed end of range value is beyond the end of file, but
  * not LLONG_MAX this routine still performs a hole punch operation.
  */
-void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend)
+void remove_mapping_hugepages(struct address_space *mapping,
+			      struct hstate *h, struct hugepage_subpool *spool,
+			      struct inode *inode, loff_t lstart, loff_t lend)
 {
-	struct hstate *h = hstate_inode(inode);
-	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> huge_page_shift(h);
 	const pgoff_t end = lend >> huge_page_shift(h);
 	struct folio_batch fbatch;
@@ -636,8 +646,8 @@ void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend)
 			/*
 			 * Remove folio that was part of folio_batch.
 			 */
-			if (remove_inode_single_folio(h, inode, mapping, folio,
-							index, truncate_op))
+			if (remove_mapping_single_folio(mapping, folio, index,
+							h, spool, inode, truncate_op))
 				freed++;
 
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -647,7 +657,16 @@ void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend)
 	}
 
 	if (truncate_op)
-		(void)hugetlb_unreserve_pages(inode, start, LONG_MAX, freed);
+		(void)hugetlb_unreserve_pages(h, spool, inode, start, LONG_MAX, freed);
+}
+
+void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend)
+{
+	struct address_space *mapping = &inode->i_data;
+	struct hstate *h = hstate_inode(inode);
+	struct hugepage_subpool *spool = subpool_inode(inode);
+
+	return remove_mapping_hugepages(mapping, h, spool, inode, lstart, lend);
 }
 
 static void hugetlbfs_evict_inode(struct inode *inode)
@@ -1548,6 +1567,7 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	struct vfsmount *mnt;
 	int hstate_idx;
 	struct file *file;
+	struct hstate *h;
 
 	hstate_idx = get_hstate_idx(page_size_log);
 	if (hstate_idx < 0)
@@ -1578,9 +1598,10 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	inode->i_size = size;
 	clear_nlink(inode);
 
-	if (!hugetlb_reserve_pages(inode, 0,
-			size >> huge_page_shift(hstate_inode(inode)), NULL,
-			acctflag))
+	h = hstate_inode(inode);
+	if (!hugetlb_reserve_pages(h, subpool_inode(inode), inode, 0,
+				   size >> huge_page_shift(h), NULL,
+				   acctflag))
 		file = ERR_PTR(-ENOMEM);
 	else
 		file = alloc_file_pseudo(inode, mnt, name, O_RDWR,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1483020b412b..2457d7a21974 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -166,11 +166,13 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct page **pagep,
 				bool wp_copy);
 #endif /* CONFIG_USERFAULTFD */
-bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
-						struct vm_area_struct *vma,
-						vm_flags_t vm_flags);
-long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
-						long freed);
+bool hugetlb_reserve_pages(struct hstate *h, struct hugepage_subpool *spool,
+			   struct inode *inode,
+			   long from, long to,
+			   struct vm_area_struct *vma,
+			   vm_flags_t vm_flags);
+long hugetlb_unreserve_pages(struct hstate *h, struct hugepage_subpool *spool,
+			     struct inode *inode, long start, long end, long freed);
 bool isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
@@ -178,7 +180,7 @@ int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 void folio_putback_active_hugetlb(struct folio *folio);
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
 void free_huge_page(struct page *page);
-void hugetlb_fix_reserve_counts(struct inode *inode);
+void hugetlb_fix_reserve_counts(struct hstate *h, struct hugepage_subpool *spool);
 extern struct mutex *hugetlb_fault_mutex_table;
 u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
@@ -259,6 +261,9 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void hugetlb_zero_partial_page(struct hstate *h, struct address_space *mapping,
 			       loff_t start, loff_t end);
 
+void remove_mapping_hugepages(struct address_space *mapping,
+			      struct hstate *h, struct hugepage_subpool *spool,
+			      struct inode *inode, loff_t lstart, loff_t lend);
 void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend);
 
 #else /* !CONFIG_HUGETLB_PAGE */
@@ -472,6 +477,9 @@ static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 static inline void hugetlb_zero_partial_page(
 	struct hstate *h, struct address_space *mapping, loff_t start, loff_t end) {}
 
+static inline void remove_mapping_hugepages(
+	struct address_space *mapping, struct hstate *h, struct hugepage_subpool *spool,
+	struct inode *inode, loff_t lstart, loff_t lend) {}
 static inline void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend) {}
 
 #endif /* !CONFIG_HUGETLB_PAGE */
@@ -554,6 +562,12 @@ static inline struct hstate *hstate_inode(struct inode *i)
 {
 	return HUGETLBFS_SB(i->i_sb)->hstate;
 }
+
+static inline struct hugepage_subpool *subpool_inode(struct inode *inode)
+{
+	return HUGETLBFS_SB(inode->i_sb)->spool;
+}
+
 #else /* !CONFIG_HUGETLBFS */
 
 #define is_file_hugepages(file)			false
@@ -568,6 +582,12 @@ static inline struct hstate *hstate_inode(struct inode *i)
 {
 	return NULL;
 }
+
+static inline struct hugepage_subpool *subpool_inode(struct inode *inode)
+{
+	return NULL;
+}
+
 #endif /* !CONFIG_HUGETLBFS */
 
 #ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9c9262833b4f..9da419b930df 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -247,11 +247,6 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
 	return ret;
 }
 
-static inline struct hugepage_subpool *subpool_inode(struct inode *inode)
-{
-	return HUGETLBFS_SB(inode->i_sb)->spool;
-}
-
 static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
 {
 	return subpool_inode(file_inode(vma->vm_file));
@@ -898,16 +893,13 @@ static long region_del(struct resv_map *resv, long f, long t)
  * appear as a "reserved" entry instead of simply dangling with incorrect
  * counts.
  */
-void hugetlb_fix_reserve_counts(struct inode *inode)
+void hugetlb_fix_reserve_counts(struct hstate *h, struct hugepage_subpool *spool)
 {
-	struct hugepage_subpool *spool = subpool_inode(inode);
 	long rsv_adjust;
 	bool reserved = false;
 
 	rsv_adjust = hugepage_subpool_get_pages(spool, 1);
 	if (rsv_adjust > 0) {
-		struct hstate *h = hstate_inode(inode);
-
 		if (!hugetlb_acct_memory(h, 1))
 			reserved = true;
 	} else if (!rsv_adjust) {
@@ -6762,15 +6754,22 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	return pages > 0 ? (pages << h->order) : pages;
 }
 
-/* Return true if reservation was successful, false otherwise.  */
-bool hugetlb_reserve_pages(struct inode *inode,
-					long from, long to,
-					struct vm_area_struct *vma,
-					vm_flags_t vm_flags)
+/**
+ * Reserves pages between vma indices @from and @to by handling accounting in:
+ * + hstate @h (required)
+ * + subpool @spool (can be NULL)
+ * + @inode (required if @vma is NULL)
+ *
+ * Will setup resv_map in @vma if necessary.
+ * Return true if reservation was successful, false otherwise.
+ */
+bool hugetlb_reserve_pages(struct hstate *h, struct hugepage_subpool *spool,
+			   struct inode *inode,
+			   long from, long to,
+			   struct vm_area_struct *vma,
+			   vm_flags_t vm_flags)
 {
 	long chg = -1, add = -1;
-	struct hstate *h = hstate_inode(inode);
-	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;
@@ -6921,13 +6920,23 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	return false;
 }
 
-long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
-								long freed)
+/**
+ * Unreserves pages between vma indices @start and @end by handling accounting
+ * in:
+ * + hstate @h (required)
+ * + subpool @spool (can be NULL)
+ * + @inode (required)
+ * + resv_map in @inode (can be NULL)
+ *
+ * @freed is the number of pages freed, for updating inode->i_blocks.
+ *
+ * Returns 0 on success.
+ */
+long hugetlb_unreserve_pages(struct hstate *h, struct hugepage_subpool *spool,
+			     struct inode *inode, long start, long end, long freed)
 {
-	struct hstate *h = hstate_inode(inode);
 	struct resv_map *resv_map = inode_resv_map(inode);
 	long chg = 0;
-	struct hugepage_subpool *spool = subpool_inode(inode);
 	long gbl_reserve;
 
 	/*
-- 
2.41.0.rc0.172.g3f132b7071-goog

