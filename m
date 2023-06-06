Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE687724C33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbjFFTFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbjFFTEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:32 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CA71993
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:04:28 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-653a5de0478so2662453b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078267; x=1688670267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0LlAXxza1jA09p0tGZBn0yslODgyOL+oHXEFWpIcjw=;
        b=oNCwvb9aRpGDjzemliRPAV2RbEjUkgcqMTcFw35zrX9Wk6VNZIJTDcZ8+sohLR6ypL
         FaZ8YypjTtdq4RVqmfVtwq8W8DKoRJdnwKkTjuJm/fygYago9102lZaBqLBb3VLlSbNA
         8+GKs0dCEhmYGJeMyAKWj2FCcFo2qfmKEi+Bfw7yT1VoVQRRdAWcJACFBwEDVx5EFgYY
         ssLEqzao5SUtD6qqnRzkJD0PmTNAv31SFuhQy7OBTGaI6F+cg3TLNZhoEHYY01Vr6fPj
         YBc8jpY1SOo3QPJvqg80DDEnv97O24LbqrhfCC1OmOHsPqRNG8fKpuVSD4Hro3kbXfW6
         x8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078267; x=1688670267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0LlAXxza1jA09p0tGZBn0yslODgyOL+oHXEFWpIcjw=;
        b=kgcOVICvOAoJJ1lafnqqmaN5Dng9LmkFEiBH9W77AcZLcEGl/gmvi6XaIEu0Kh0UOv
         60qcMnqRQgH3uXPnoV0ESIcoF7Lwv2daCDPxc0I84s9jJElll3ekKPeOfujSkl72OHZR
         tcwRZmPzNPgYKJ+QIDbFaBMmXUYSoqvvu5vG7WvX4Vcly4it8a5PYHWx+ZUEPXz/ieNV
         45OXvt0hyCyonrNzsg89FjvjTR5iZsPxygWALhdC0D07yPz1LRD0uAmCmklaTRouAurZ
         UftDrXkUyFl4FqnH2Gc+TNL9rjaSYUR1gf9fYxBAUGWe6jbuEusOXanTysdgxY43P1My
         X6jA==
X-Gm-Message-State: AC+VfDxIxyR4ij3sQ6qp0jfYKNWXgAy+k2qt1Z6SbxGW4SY8QrinVDY2
        n1+rlDQNKJcJ7w9a9F+ubaILWfqctYpnnfm8bg==
X-Google-Smtp-Source: ACHHUZ6/geo43pUv13kPM8dbgitYn16Pb8nr3LytYQllA2bz6ABBAmVaVTp99t2le/ojeTQ9xVl065tEgGqpA1Ormw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:188d:b0:64f:cdb0:64a8 with
 SMTP id x13-20020a056a00188d00b0064fcdb064a8mr1304775pfh.3.1686078267446;
 Tue, 06 Jun 2023 12:04:27 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:53 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <cfe974a0ca8182f40a3437e0799f82b38542a667.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 08/19] mm: hugetlb: Refactor restore_reserve_on_error
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

Refactor restore_reserve_on_error to allow resv_map to be passed
in. vma_resv_map() assumes the use of hugetlbfs in the way it
retrieves the resv_map from the vma and inode.

Introduce restore_reserve_on_error_vma() which retains original
functionality to simplify refactoring for now.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            | 37 +++++++++++++++++++++----------------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0fc49b6252e4..44e6ee9a856d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -868,7 +868,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		__folio_mark_uptodate(folio);
 		error = hugetlb_add_to_page_cache(folio, mapping, index);
 		if (unlikely(error)) {
-			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
+			restore_reserve_on_error_vma(h, &pseudo_vma, addr, folio);
 			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7d49048c5a2a..02a2766d89a4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -760,8 +760,10 @@ int hugetlb_filemap_add_folio(struct address_space *mapping, struct hstate *h,
 			      struct folio *folio, pgoff_t idx);
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
-void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
-				unsigned long address, struct folio *folio);
+void restore_reserve_on_error(struct resv_map *resv, pgoff_t resv_index,
+			      bool may_share, struct folio *folio);
+void restore_reserve_on_error_vma(struct hstate *h, struct vm_area_struct *vma,
+				  unsigned long address, struct folio *folio);
 
 /* arch callback */
 int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d943f83d15a9..4675f9efeba4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2805,15 +2805,10 @@ static long resv_map_del_reservation(struct resv_map *resv, pgoff_t resv_index,
  *
  * In case 2, simply undo reserve map modifications done by alloc_hugetlb_folio.
  */
-void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
-			unsigned long address, struct folio *folio)
+void restore_reserve_on_error(struct resv_map *resv, pgoff_t resv_index,
+			      bool may_share, struct folio *folio)
 {
-	long rc;
-	struct resv_map *resv = vma_resv_map(vma);
-	pgoff_t resv_index = vma_hugecache_offset(h, vma, address);
-	bool may_share = vma->vm_flags & VM_MAYSHARE;
-
-	rc = resv_map_needs_reservation(resv, resv_index, may_share);
+	long rc = resv_map_needs_reservation(resv, resv_index, may_share);
 
 	if (folio_test_hugetlb_restore_reserve(folio)) {
 		if (unlikely(rc < 0))
@@ -2865,7 +2860,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			 * For shared mappings, no entry in the map indicates
 			 * no reservation.  We are done.
 			 */
-			if (!(vma->vm_flags & VM_MAYSHARE))
+			if (!may_share)
 				/*
 				 * For private mappings, no entry indicates
 				 * a reservation is present.  Since we can
@@ -2883,6 +2878,16 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 	}
 }
 
+void restore_reserve_on_error_vma(struct hstate *h, struct vm_area_struct *vma,
+				  unsigned long address, struct folio *folio)
+{
+	struct resv_map *resv = vma_resv_map(vma);
+	pgoff_t resv_index = vma_hugecache_offset(h, vma, address);
+	bool may_share = vma->vm_flags & VM_MAYSHARE;
+
+	restore_reserve_on_error(resv, resv_index, may_share, folio);
+}
+
 /*
  * alloc_and_dissolve_hugetlb_folio - Allocate a new folio and dissolve
  * the old one
@@ -5109,8 +5114,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
-					restore_reserve_on_error(h, dst_vma, addr,
-								new_folio);
+					restore_reserve_on_error_vma(h, dst_vma, addr,
+								     new_folio);
 					folio_put(new_folio);
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
@@ -5642,7 +5647,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * unshare)
 	 */
 	if (new_folio != page_folio(old_page))
-		restore_reserve_on_error(h, vma, haddr, new_folio);
+		restore_reserve_on_error_vma(h, vma, haddr, new_folio);
 	folio_put(new_folio);
 out_release_old:
 	put_page(old_page);
@@ -5860,7 +5865,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 * to the page cache. So it's safe to call
 				 * restore_reserve_on_error() here.
 				 */
-				restore_reserve_on_error(h, vma, haddr, folio);
+				restore_reserve_on_error_vma(h, vma, haddr, folio);
 				folio_put(folio);
 				goto out;
 			}
@@ -5965,7 +5970,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spin_unlock(ptl);
 backout_unlocked:
 	if (new_folio && !new_pagecache_folio)
-		restore_reserve_on_error(h, vma, haddr, folio);
+		restore_reserve_on_error_vma(h, vma, haddr, folio);
 
 	folio_unlock(folio);
 	folio_put(folio);
@@ -6232,7 +6237,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* Free the allocated folio which may have
 			 * consumed a reservation.
 			 */
-			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
+			restore_reserve_on_error_vma(h, dst_vma, dst_addr, folio);
 			folio_put(folio);
 
 			/* Allocate a temporary folio to hold the copied
@@ -6361,7 +6366,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		folio_unlock(folio);
 out_release_nounlock:
 	if (!folio_in_pagecache)
-		restore_reserve_on_error(h, dst_vma, dst_addr, folio);
+		restore_reserve_on_error_vma(h, dst_vma, dst_addr, folio);
 	folio_put(folio);
 	goto out;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

