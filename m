Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690A9724C23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbjFFTEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239252AbjFFTEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:31 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB13D1733
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:04:24 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-259a77766e1so215771a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078264; x=1688670264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZNbtWHLPp5u2GywkOyP6D11aGDQiwpmebr72+3tZZw=;
        b=3nPwPewVscUDqVZMn7Uj3o98nrz5j8VLctE94SycAE0CkTh6eROV6trMOeNgO1y4jS
         yLqfAq9F5z3V/0un8MfG4HdspEU1lRRMGNzpIw+TRUDHmsZbFPuX/+Cikl64LmUYIx66
         8bq6oGIyVKNOZEdXnRQamgBHRpoKdYwSVBMUDqfzl7aIO0QNJg3Dh7nLDTiLBxl5+u8s
         7Pxbmh7gLIa94u88QAeI5yehSo2cVl1/aF9z6LyF0284EPn+EeLrVrvCYse/GQqVLuDH
         J/bFMQvA4aC2mtn4McrJir6hXAodHcAaWQLRaE/P7TGgIMKpZ2UbMXusJndkMLSh2bgC
         CYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078264; x=1688670264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZNbtWHLPp5u2GywkOyP6D11aGDQiwpmebr72+3tZZw=;
        b=h6KXQAi+ISqYOKQIah8cNN1TBnB/52hLigAi7iJwkosPz7UkLW9UFaOBXIU+z6St+U
         E5DlsEhm3gt38uerRNqg7CNpWGqkSeKx/JkAuBU3lZpjITHrkSryZojSe81MEgGRYSSX
         x311oqnv1iagKr9/NmeqVjLs4FAMgh+0mVku7A3SiUX1MAaFrj8+SuR0b8j90igYMWyw
         xub++PA0IzOybjNCfReIb0kFryzJHDtur4ov9qUOQ/SJEVEIMWxLZLovwk0BkwT2pFmC
         0s2sE9yl7f7AdXBvXM3K14ZaImtvBov0cRXgQmswpFtL5CoYslXmy+8efuDKx2UgdrNZ
         41cA==
X-Gm-Message-State: AC+VfDwjZmBkWbLx39sPL7b6AgAusf1qk5hT54SQdof4BNEBEeh/mnUK
        QIUBbXk/2hALW+LMVTSXGLKbsk/SfPORjn/tyQ==
X-Google-Smtp-Source: ACHHUZ7IGNkoxDfbAlb5rNYiUxqKSeo6I3oYpfv0H1ogSeNyAElarCOglNHY4mpG93xhDZmjnsgqFXX+BQakQxRlBw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:c092:b0:256:b3d0:f2f0 with
 SMTP id o18-20020a17090ac09200b00256b3d0f2f0mr806359pjs.2.1686078263970; Tue,
 06 Jun 2023 12:04:23 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:51 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <69ae008ec4076456078b880575ac310171136ac0.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 06/19] mm: hugetlb: Provide hugetlb_filemap_add_folio()
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

hstate_inode() is hugetlbfs-specific, limiting
hugetlb_add_to_page_cache() to hugetlbfs.

hugetlb_filemap_add_folio() allows hstate to be specified and further
separates hugetlb from hugetlbfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 14df89d1642c..7d49048c5a2a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -756,6 +756,8 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
+int hugetlb_filemap_add_folio(struct address_space *mapping, struct hstate *h,
+			      struct folio *folio, pgoff_t idx);
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 99ab4bbdb2ce..d16c6417b90f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5665,11 +5665,10 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return present;
 }
 
-int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
-			   pgoff_t idx)
+int hugetlb_filemap_add_folio(struct address_space *mapping, struct hstate *h,
+			      struct folio *folio, pgoff_t idx)
 {
 	struct inode *inode = mapping->host;
-	struct hstate *h = hstate_inode(inode);
 	int err;
 
 	__folio_set_locked(folio);
@@ -5693,6 +5692,14 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	return 0;
 }
 
+int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
+			      pgoff_t idx)
+{
+	struct hstate *h = hstate_inode(mapping->host);
+
+	return hugetlb_filemap_add_folio(mapping, h, folio, idx);
+}
+
 static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 						  struct address_space *mapping,
 						  pgoff_t idx,
-- 
2.41.0.rc0.172.g3f132b7071-goog

