Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A4B724C45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbjFFTFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbjFFTEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:48 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0DB172D
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:04:33 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53fa00ed93dso5622551a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078273; x=1688670273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUcXaEC48I4Bm1WwWPPkFcaYKFbZrdo62sI7Vn9jtKM=;
        b=EsMzcu7MCofZV1M6N8qLTVGfCobRb2m9UBd1k4rqImHaaV90eE+7yVgqGJTlHLVTGg
         WYLYzf9nuh7wT2wl0ong7Pm+JdEwy0XrWnw7A67dAqqNLmKKthrxFKAZNZCPEmg+Gm9l
         1/jfZjJbtssIps71Hn10bsoNM3+P1vWpJqtgmuCPP7gyVh3snIw/tKY/Poj3vjuiFMIm
         hWDohY5CuxRIZJ1XCd6YRMkjU3OFa1a+IZrlt5R6w1j+nUqvdL8ryozxcFEC3Inu+RpX
         MrblT0sw+GiuzKbFJnN8KErIkyQh7K372xpyIXAqppgkeoG3kQADStwWWL0FGczDjczb
         yaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078273; x=1688670273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUcXaEC48I4Bm1WwWPPkFcaYKFbZrdo62sI7Vn9jtKM=;
        b=GyEH3ooRIZLuwUuh4UNGc0orOlg47rjCsyaP+shM6t41wa4OrcZffXZr/At7MhUst2
         EcO3gv10qXohw/6rjICGYFMPeiKbuDe9gromIxsAkoKa2qfEbUF9BykVMqJqX3hciZqL
         H3QhlgPH8aCQ33b7ofZW7vA/sbUWbR5s/rRlX1+IE/OZZoNyTy6Q0P2jfetJQhG6RTmy
         /f2nwqMEQHjM+Q/QLbMSfxvdPTbw+oG6t8YVe6fVfllFoQQojC19MI4HmPZY5E8bWg7G
         WZeA+H/M/DurxMv30AGHKPRB/dWWntD/FMgGw9DbfNTRwD+uzK9NekDO1nzHSAFvksUq
         athQ==
X-Gm-Message-State: AC+VfDzukEuWV2EybxE1z6EFy4lIAOHzya7Pj4bWe2kdtGWyAkOo2XKy
        r21S9LsU7HmQ4+t+7j2CyS7YSaGznezuyU/hpQ==
X-Google-Smtp-Source: ACHHUZ4v54k8mWqyJRdVfnADxQ7LxuS0BkTdcogjdbP6mmP0fUtChdx6VWMt3kG2rI14jmGLU8WGRs/GoPhwfnEqcg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a65:5c8b:0:b0:53f:b396:6f32 with SMTP
 id a11-20020a655c8b000000b0053fb3966f32mr628734pgt.3.1686078273321; Tue, 06
 Jun 2023 12:04:33 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:56 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <1d0337d32f40b781f9b7509cb40448b81bde6b00.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 11/19] mm: hugetlb: Parametrize hugetlb functions by resv_map
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Parametrize remove_mapping_hugepages() and hugetlb_unreserve_pages()
by resv_map to remove the use of inode_resv_map() and decouple hugetlb
with hugetlbfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    | 16 ++++++++++------
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            |  4 ++--
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 53f6a421499d..a7791b1390a6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -560,8 +560,8 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
  */
 static bool remove_mapping_single_folio(
 	struct address_space *mapping, struct folio *folio, pgoff_t index,
-	struct hstate *h, struct hugepage_subpool *spool, struct inode *inode,
-	bool truncate_op)
+	struct hstate *h, struct hugepage_subpool *spool, struct resv_map *resv_map,
+	struct inode *inode, bool truncate_op)
 {
 	bool ret = false;
 
@@ -586,7 +586,8 @@ static bool remove_mapping_single_folio(
 	hugetlb_delete_from_page_cache(folio);
 	ret = true;
 	if (!truncate_op) {
-		if (unlikely(hugetlb_unreserve_pages(h, spool, inode, index, index + 1, 1)))
+		if (unlikely(hugetlb_unreserve_pages(h, spool, resv_map,
+						     inode, index, index + 1, 1)))
 			hugetlb_fix_reserve_counts(h, spool);
 	}
 
@@ -623,6 +624,7 @@ static bool remove_mapping_single_folio(
  */
 void remove_mapping_hugepages(struct address_space *mapping,
 			      struct hstate *h, struct hugepage_subpool *spool,
+			      struct resv_map *resv_map,
 			      struct inode *inode, loff_t lstart, loff_t lend)
 {
 	const pgoff_t start = lstart >> huge_page_shift(h);
@@ -647,7 +649,7 @@ void remove_mapping_hugepages(struct address_space *mapping,
 			 * Remove folio that was part of folio_batch.
 			 */
 			if (remove_mapping_single_folio(mapping, folio, index,
-							h, spool, inode, truncate_op))
+							h, spool, resv_map, inode, truncate_op))
 				freed++;
 
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -657,7 +659,8 @@ void remove_mapping_hugepages(struct address_space *mapping,
 	}
 
 	if (truncate_op)
-		(void)hugetlb_unreserve_pages(h, spool, inode, start, LONG_MAX, freed);
+		(void)hugetlb_unreserve_pages(h, spool, resv_map, inode,
+					      start, LONG_MAX, freed);
 }
 
 void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend)
@@ -665,8 +668,9 @@ void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend)
 	struct address_space *mapping = &inode->i_data;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
+	struct resv_map *resv_map = inode_resv_map(inode);
 
-	return remove_mapping_hugepages(mapping, h, spool, inode, lstart, lend);
+	return remove_mapping_hugepages(mapping, h, spool, resv_map, inode, lstart, lend);
 }
 
 static void hugetlbfs_evict_inode(struct inode *inode)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d564802ace4b..af04588a5afe 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -172,7 +172,8 @@ bool hugetlb_reserve_pages(struct hstate *h, struct hugepage_subpool *spool,
 			   struct vm_area_struct *vma,
 			   vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct hstate *h, struct hugepage_subpool *spool,
-			     struct inode *inode, long start, long end, long freed);
+			     struct resv_map *resv_map, struct inode *inode,
+			     long start, long end, long freed);
 bool isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
@@ -263,6 +264,7 @@ void hugetlb_zero_partial_page(struct hstate *h, struct address_space *mapping,
 
 void remove_mapping_hugepages(struct address_space *mapping,
 			      struct hstate *h, struct hugepage_subpool *spool,
+			      struct resv_map *resv_map,
 			      struct inode *inode, loff_t lstart, loff_t lend);
 void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend);
 
@@ -479,7 +481,7 @@ static inline void hugetlb_zero_partial_page(
 
 static inline void remove_mapping_hugepages(
 	struct address_space *mapping, struct hstate *h, struct hugepage_subpool *spool,
-	struct inode *inode, loff_t lstart, loff_t lend) {}
+	struct resv_map *resv_map, struct inode *inode, loff_t lstart, loff_t lend) {}
 static inline void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend) {}
 
 #endif /* !CONFIG_HUGETLB_PAGE */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aebdd8c63439..a1cbda457aa7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6954,9 +6954,9 @@ bool hugetlb_reserve_pages(struct hstate *h, struct hugepage_subpool *spool,
  * Returns 0 on success.
  */
 long hugetlb_unreserve_pages(struct hstate *h, struct hugepage_subpool *spool,
-			     struct inode *inode, long start, long end, long freed)
+			     struct resv_map *resv_map, struct inode *inode,
+			     long start, long end, long freed)
 {
-	struct resv_map *resv_map = inode_resv_map(inode);
 	long chg = 0;
 	long gbl_reserve;
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

