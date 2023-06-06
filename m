Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C3724C14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbjFFTEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbjFFTES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2051FE70
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:04:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb1e332f648so8842929276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078257; x=1688670257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hBYwj+hDVdRsN8/1AwobMe3CTJKx3rv/kAyLXc58so=;
        b=H7E3FiMFKx8wp9Dwc4KoRhYITqBdXBFbeuSdYVU7Xl2quiLV1TI/RBj6a84p3NhH+A
         6Ot5kD4xdeERpXhx7UwpPyWytx0ckODJexzs4v23BK+jBmvA/ejV4+lVF1eJPpgHviEu
         uumCUBgaOBD3ECdp59KweUCJLiBB+HqC6NZrMNuSqXw8B1oiojQQln/v/JBqZ3dwGu23
         pfO6fIO6tANLPLyeFwUcf8Qi72Eo5MQO/Xul1ZcTopSBQKuO94fsqUr8V4qbQI+x7jBp
         uRAq7xDxsM2mm1v+/TKXiQUaFoQhkNFaDB59XiYo7wFgeMK27ohvJb62IAQGNTsPTIVZ
         PvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078257; x=1688670257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hBYwj+hDVdRsN8/1AwobMe3CTJKx3rv/kAyLXc58so=;
        b=gzU1ow3+yM2UFjlbaNDvvb3Lh5UcNO3TE5szbRWaPiGLQboX0A92koBWohD14VHEd4
         /InZU20aS9ATeZ0cNHehYq1up/wVeilEHPi39x40tbHwkUi1bw+qxN54J/bZg4dgBUPK
         33XLvsbror5SSsIWaamF+Q7ZKS4gPLOT/4VdboDzE3O+JhYcPiLuO28f3SpDgyxEANk9
         A3StTTLCPUxSumW0Z+ey82Tt+xHEcWzOdq7wp/OPAhwETAERtG8AOD5P0bCnz/uggWIz
         FzAVp7kl0BqFO3zK2lhSnGZPhCjHidFQKWcYFefFQ0+BJ6kzdrjmwrRPjFgK8HPb2q5Z
         Os9A==
X-Gm-Message-State: AC+VfDyHbvnrW9H2sXc5ykbTrOsNulG+xEEDe6eA42lN1ynzQgkSahyr
        jcQE8YjDUEPTQSQVEnNpGnIn5P1dwIJzgy+G2A==
X-Google-Smtp-Source: ACHHUZ68tuaeB7ur+Gj0U5ZR5IxxzkEh+TRxbplImu5DoiCt68fH6drAzpWUcd9Di+kjyJGUd+Eua/GN38BmucMMtA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:1882:b0:ba8:337a:d8a3 with
 SMTP id cj2-20020a056902188200b00ba8337ad8a3mr1661367ybb.11.1686078256773;
 Tue, 06 Jun 2023 12:04:16 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:47 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <97c312c8c0b56218454d546a540a3ea2e2a825e2.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 02/19] mm: hugetlb: Move and expose hugetlbfs_zero_partial_page
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

Zeroing of pages is generalizable to hugetlb and is not specific to
hugetlbfs.

Rename hugetlbfs_zero_partial_page => hugetlb_zero_partial_page, move
it to mm/hugetlb.c and expose it in linux/hugetlb.h.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    | 27 ++-------------------------
 include/linux/hugetlb.h |  6 ++++++
 mm/hugetlb.c            | 22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 406d7366cf3e..3dab50d3ed88 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -688,29 +688,6 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 }
 
-static void hugetlbfs_zero_partial_page(struct hstate *h,
-					struct address_space *mapping,
-					loff_t start,
-					loff_t end)
-{
-	pgoff_t idx = start >> huge_page_shift(h);
-	struct folio *folio;
-
-	folio = filemap_lock_folio(mapping, idx);
-	if (!folio)
-		return;
-
-	start = start & ~huge_page_mask(h);
-	end = end & ~huge_page_mask(h);
-	if (!end)
-		end = huge_page_size(h);
-
-	folio_zero_segment(folio, (size_t)start, (size_t)end);
-
-	folio_unlock(folio);
-	folio_put(folio);
-}
-
 static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
@@ -737,7 +714,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	/* If range starts before first full page, zero partial page. */
 	if (offset < hole_start)
-		hugetlbfs_zero_partial_page(h, mapping,
+		hugetlb_zero_partial_page(h, mapping,
 				offset, min(offset + len, hole_start));
 
 	/* Unmap users of full pages in the hole. */
@@ -750,7 +727,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	/* If range extends beyond last full page, zero partial page. */
 	if ((offset + len) > hole_end && (offset + len) > hole_start)
-		hugetlbfs_zero_partial_page(h, mapping,
+		hugetlb_zero_partial_page(h, mapping,
 				hole_end, offset + len);
 
 	i_mmap_unlock_write(mapping);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 37c2edf7beea..023293ceec25 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -256,6 +256,9 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 
+void hugetlb_zero_partial_page(struct hstate *h, struct address_space *mapping,
+			       loff_t start, loff_t end);
+
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
@@ -464,6 +467,9 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void hugetlb_zero_partial_page(
+	struct hstate *h, struct address_space *mapping, loff_t start, loff_t end) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 07abcb6eb203..9c9262833b4f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7407,6 +7407,28 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
 }
 
+void hugetlb_zero_partial_page(struct hstate *h,
+			       struct address_space *mapping,
+			       loff_t start, loff_t end)
+{
+	pgoff_t idx = start >> huge_page_shift(h);
+	struct folio *folio;
+
+	folio = filemap_lock_folio(mapping, idx);
+	if (!folio)
+		return;
+
+	start = start & ~huge_page_mask(h);
+	end = end & ~huge_page_mask(h);
+	if (!end)
+		end = huge_page_size(h);
+
+	folio_zero_segment(folio, (size_t)start, (size_t)end);
+
+	folio_unlock(folio);
+	folio_put(folio);
+}
+
 #ifdef CONFIG_CMA
 static bool cma_reserve_called __initdata;
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

