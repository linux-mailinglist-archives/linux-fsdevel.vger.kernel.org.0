Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EB3724C0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbjFFTEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239201AbjFFTEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF010FF
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:04:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb3855c34deso1972004276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078255; x=1688670255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W42CnlEhHXSQD8oU0aesgTIb+2nDDRqlSHCZLxoyAZw=;
        b=SI6wxzD3jNLZvjIR3ui3oLLkrgjrOnUdyqmkDtNB4LvaXzaOxSopYwQDXGSPUwGt0b
         d1EHBVyiG4hUUHi15P58bSdZq1hiIfxHNvpvia7Cxzf6d0mYTmKP/FDWWkzVCNVJSia8
         WKQpt+ZebghqzxY/2xXY0xK+V+7VuTACGmy8UzpKH/NOajrF02Jvbazs2Qt1cP/5GZi3
         Pxw8kkdCQkLaRblrUwFR5NCQzIvEfWgJISfEM1oMrdysWZB/g9FTr60M+vCWXu+AmqCG
         W3rBiG3Eit8E92Xwv+sO+1jySrdLIuEFp3Em5lURfr02pKqbadaZwr4BvewtCxcGcLfE
         Bs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078255; x=1688670255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W42CnlEhHXSQD8oU0aesgTIb+2nDDRqlSHCZLxoyAZw=;
        b=aLU1fspruAald/p3tBKUC8ox5jlgqlJqpNsTyo5o8nTGPJGvbLjgdt1A50P+HIUeXk
         dbb58eVhWyPxZuiWyk5cojsn0p3nydWRuyPNM2I14u3b6UEnf/1QQEsQTfhHF9p3QUyL
         +vJBN8xOLJl2pDTx47DHZd9RFhCIgUKH32GDU7uLz7Gfz15FZ8gZR+YzRAkyOg2o7dwD
         YTvjmGp3xwuGYCPUedbfQYM7QmtnngBXIiY+MZEoWkizR2kUipJ/F+0hqLqpBm42NNal
         p/mWROjls1FS51yYNOum0sd8gVA9g+xLMMVwhOSrYnYl4kT24tvGIa5zuWIlepS8Nxic
         mW7A==
X-Gm-Message-State: AC+VfDww4kpA5xlmCbcInNryD2u6LBaGRk7rtJZ+feByIqdXRzU/NQNQ
        y69uBzNGk4btP9jfO+GmaKClFxRHZt/pnwtstw==
X-Google-Smtp-Source: ACHHUZ535voW+NPlWmi/k960ILK6GzLJuoo4o0Ye5mrBBjql7Wgmyk28/ve76hKFr5oQ8deqfVoTqFa20GrqC6sA9g==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:2ce:0:b0:bb3:ac6a:6d61 with SMTP
 id 197-20020a2502ce000000b00bb3ac6a6d61mr1216938ybc.3.1686078254851; Tue, 06
 Jun 2023 12:04:14 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:46 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <b3924b31a274477b623d156b456ebc8891756e10.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 01/19] mm: hugetlb: Expose get_hstate_idx()
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

Expose get_hstate_idx() so it can be used from KVM's guest_mem code

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    |  9 ---------
 include/linux/hugetlb.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9062da6da567..406d7366cf3e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1560,15 +1560,6 @@ static int can_do_hugetlb_shm(void)
 	return capable(CAP_IPC_LOCK) || in_group_p(shm_group);
 }
 
-static int get_hstate_idx(int page_size_log)
-{
-	struct hstate *h = hstate_sizelog(page_size_log);
-
-	if (!h)
-		return -1;
-	return hstate_index(h);
-}
-
 /*
  * Note that size should be aligned to proper hugepage size in caller side,
  * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7c977d234aba..37c2edf7beea 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -876,6 +876,15 @@ static inline int hstate_index(struct hstate *h)
 	return h - hstates;
 }
 
+static inline int get_hstate_idx(int page_size_log)
+{
+	struct hstate *h = hstate_sizelog(page_size_log);
+
+	if (!h)
+		return -1;
+	return hstate_index(h);
+}
+
 extern int dissolve_free_huge_page(struct page *page);
 extern int dissolve_free_huge_pages(unsigned long start_pfn,
 				    unsigned long end_pfn);
@@ -1142,6 +1151,11 @@ static inline int hstate_index(struct hstate *h)
 	return 0;
 }
 
+static inline int get_hstate_idx(int page_size_log)
+{
+	return 0;
+}
+
 static inline int dissolve_free_huge_page(struct page *page)
 {
 	return 0;
-- 
2.41.0.rc0.172.g3f132b7071-goog

