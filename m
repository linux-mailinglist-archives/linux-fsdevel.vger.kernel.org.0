Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF474B8E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 23:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjGGV4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 17:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjGGVzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:55:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB002210B
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 14:55:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c5d16402b4eso2606607276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688766949; x=1691358949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XpJBVMM9VGEbS89HlMJM/b+46oLjR8s/ahtpOvDxE4=;
        b=Vna1SetL1twavTmQ3g0qKEnlEJ8kJBZCi65Nnw+YcV5ZZCoEneQ4zTFVsFXUuvkRKr
         Y9wbkNV5IwnplqQXfIPLSaPB2IcZ307sSmUuIJy2rwTPrQUVsrk2CdliIB7gI42gWhdM
         6gimHkR7Zsp03wFa9g3UVN+pHLvWeuzqesEJ2UoOZley50vyuTzor2gOnslHanzRO+2V
         zz+MOmoHULIYJJA/CUzyHkrN7bP3g2kVeV9cVUxa0wQEPONQ3+8KsB0PFHA1Sp9MPuuD
         2F0o29XPzlT5FRPXTikiGPDnm68fX68i/xryJT4RapXWGGzNcDuVhIoxEk1qtV2lNW65
         X5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766949; x=1691358949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XpJBVMM9VGEbS89HlMJM/b+46oLjR8s/ahtpOvDxE4=;
        b=YAwmM0YhoFAK+/YrruJJVHKiowi1dAiVguwKHH6gJUSTstvC/goyLXgxAMhZenDjKt
         OGIjjP90UvS/uf4WaNP6KbOGSJUfqSGXolCqzBRPxZ2f/db1L9viT8f68x4o+UNSMXgZ
         FuI3767YiPNAczaiJQz2fUgpz0EQBDYuYMKBLTwWW0GLb4rzHx5ldpaHtGf6lx8AHbx/
         FF7rnDwLb0aaAE9qSZbOFsFCy+XGg2ydyxQPPc99JmcldYa25yJO9ddElgxoWn9L2mCe
         VVRnngavRmqsvrz5JOSQrCYOyCX2vttGPLKDhI7NvG1QOe/ybFtWqLBBW02IXC6ZlDZI
         o5Iw==
X-Gm-Message-State: ABy/qLbOFoomjasXvIT2dWvY/CArWvIwF18FSdGIA1+xS+yHrT5nWZsV
        nBJIdqZOHWvU79ylKDNV7STekbHZ4uOPdx9gczXO
X-Google-Smtp-Source: APBJJlHNyRYQbB7ZObZHpnn7dAmDsn5jT+2xbl5BfWLddNXyMesuVTzhCBkP1TN4IxNkWiSdwYOjtvr2Xk3oVPP6sM47
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:c201:5125:39d1:ef3f])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:350:b0:c4c:ef98:6252 with
 SMTP id e16-20020a056902035000b00c4cef986252mr34624ybs.9.1688766948974; Fri,
 07 Jul 2023 14:55:48 -0700 (PDT)
Date:   Fri,  7 Jul 2023 14:55:35 -0700
In-Reply-To: <20230707215540.2324998-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230707215540.2324998-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707215540.2324998-4-axelrasmussen@google.com>
Subject: [PATCH v4 3/8] mm: userfaultfd: extract file size check out into a helper
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
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

This code is already duplicated twice, and UFFDIO_POISON will do the
same check a third time. So, it's worth extracting into a helper to save
repetitive lines of code.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/userfaultfd.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index a2bf37ee276d..4244ca7ee903 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -45,6 +45,22 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 	return dst_vma;
 }
 
+/* Check if dst_addr is outside of file's size. Must be called with ptl held. */
+static bool mfill_file_over_size(struct vm_area_struct *dst_vma,
+				 unsigned long dst_addr)
+{
+	struct inode *inode;
+	pgoff_t offset, max_off;
+
+	if (!dst_vma->vm_file)
+		return false;
+
+	inode = dst_vma->vm_file->f_inode;
+	offset = linear_page_index(dst_vma, dst_addr);
+	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	return offset >= max_off;
+}
+
 /*
  * Install PTEs, to map dst_addr (within dst_vma) to page.
  *
@@ -64,8 +80,6 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	bool page_in_cache = page_mapping(page);
 	spinlock_t *ptl;
 	struct folio *folio;
-	struct inode *inode;
-	pgoff_t offset, max_off;
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	_dst_pte = pte_mkdirty(_dst_pte);
@@ -81,14 +95,9 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	if (!dst_pte)
 		goto out;
 
-	if (vma_is_shmem(dst_vma)) {
-		/* serialize against truncate with the page table lock */
-		inode = dst_vma->vm_file->f_inode;
-		offset = linear_page_index(dst_vma, dst_addr);
-		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (mfill_file_over_size(dst_vma, dst_addr)) {
 		ret = -EFAULT;
-		if (unlikely(offset >= max_off))
-			goto out_unlock;
+		goto out_unlock;
 	}
 
 	ret = -EEXIST;
@@ -211,8 +220,6 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 	pte_t _dst_pte, *dst_pte;
 	spinlock_t *ptl;
 	int ret;
-	pgoff_t offset, max_off;
-	struct inode *inode;
 
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
@@ -220,14 +227,9 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 	dst_pte = pte_offset_map_lock(dst_vma->vm_mm, dst_pmd, dst_addr, &ptl);
 	if (!dst_pte)
 		goto out;
-	if (dst_vma->vm_file) {
-		/* the shmem MAP_PRIVATE case requires checking the i_size */
-		inode = dst_vma->vm_file->f_inode;
-		offset = linear_page_index(dst_vma, dst_addr);
-		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (mfill_file_over_size(dst_vma, dst_addr)) {
 		ret = -EFAULT;
-		if (unlikely(offset >= max_off))
-			goto out_unlock;
+		goto out_unlock;
 	}
 	ret = -EEXIST;
 	if (!pte_none(ptep_get(dst_pte)))
-- 
2.41.0.255.g8b1d071c50-goog

