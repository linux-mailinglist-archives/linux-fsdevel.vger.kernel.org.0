Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A9D3423B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 18:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCSRwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCSRvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:51:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF832C06174A;
        Fri, 19 Mar 2021 10:51:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so4809533pjb.4;
        Fri, 19 Mar 2021 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUG0YiSUOTPE19D4JV8qDGUQXAattgMTMVymnVqLA6s=;
        b=bR2GpVXnMjeqmMVaIhmgrqbcgqNYbuHFt1BndQ96+WWMpFi/vnZ69veZuD+/T6c1jG
         S2RlYI8E8ZzEJJDpOg3dvHNhB9Dtgy+AfDY1v8lgk5PF1O7JkGA1HYF7Q+cHKepuMBZP
         ETCPFdBQzYMLpdvwQoode6VaYIxDEv5KBBTvWnhi8So3z1xVO4QpzaXLdWtuugNzkgYl
         0v3D514iB031azsnQhis1MiOxR2Emhvn51BKO3dKmAVgQo6xzbEqBw1jMb8YTYiXDcUT
         QJjnhaN7lrZhDw+Qk903Bfv9oSFW0k4y57gUNelPeoef5APHXmIbzyG1ij/plx4wxdOf
         X28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AUG0YiSUOTPE19D4JV8qDGUQXAattgMTMVymnVqLA6s=;
        b=XkVSvYxGiKNFuafNMiJyMsWeWi+gF52zF0PonnH4ZOn3mvZGaCfhePLPYVpMiPHn+o
         XvNIPu8RJK9vSPb+LrjXDIFUMmA91wFBE8ozK9VE+787UpYY6nHvOyjE9LiH9dVy7pQy
         VGAcpw7Gp7glLjfimawdjF3c53qEFaze3uMGtpNGBlfggh5cfol1J4MCoYNlhPBgaIb8
         oHrLHXHBeC5MUMpMV7YJ9o+66pdgAe4IB5kexg4p8k7F0/50IC8C1imGpvWzy0MkES3X
         t4tFErtixUt5V291MgDfkt743schpyYBcw1fSqUqsU5ouGS2uvdJSOML0aRo4zS7eMK1
         fNuw==
X-Gm-Message-State: AOAM532Zs4irX8culNaEtjxLbBRPhOdRlNBGZT5vSLvGnWiXFyjup89A
        GzOUZybcA8vjN2SE8bmVNzA=
X-Google-Smtp-Source: ABdhPJxYxz2FHA40AdEL/r3rMHxxo8IfNmZT8tRl4SmF5qEo/I3lprQ2K3TzEvXWMNfUV6mDHhBw1A==
X-Received: by 2002:a17:902:c40a:b029:e4:99fc:c09f with SMTP id k10-20020a170902c40ab02900e499fcc09fmr15082101plk.46.1616176312322;
        Fri, 19 Mar 2021 10:51:52 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:913d:5573:c956:f033])
        by smtp.gmail.com with ESMTPSA id w8sm5498287pgk.46.2021.03.19.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:51:51 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 2/3] mm: replace migrate_[prep|finish] with lru_cache_[disable|enable]
Date:   Fri, 19 Mar 2021 10:51:26 -0700
Message-Id: <20210319175127.886124-2-minchan@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319175127.886124-1-minchan@kernel.org>
References: <20210319175127.886124-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, migrate_[prep|finish] is merely a wrapper of
lru_cache_[disable|enable]. There is not much to gain from
having additional abstraction.

Use lru_cache_[disable|enable] instead of migrate_[prep|finish],
which would be more descriptive.

note: migrate_prep_local in compaction.c changed into lru_add_drain
to avoid CPU schedule cost with involving many other CPUs to keep
keep old behavior.

Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/migrate.h |  7 -------
 mm/compaction.c         |  3 ++-
 mm/mempolicy.c          |  8 ++++----
 mm/migrate.c            | 28 ++--------------------------
 mm/page_alloc.c         |  4 ++--
 5 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 9e4a2dc8622c..6155d97ec76c 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -45,9 +45,6 @@ extern struct page *alloc_migration_target(struct page *page, unsigned long priv
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
-extern void migrate_prep(void);
-extern void migrate_finish(void);
-extern void migrate_prep_local(void);
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
 extern int migrate_huge_page_move_mapping(struct address_space *mapping,
@@ -67,10 +64,6 @@ static inline struct page *alloc_migration_target(struct page *page,
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
 
-static inline int migrate_prep(void) { return -ENOSYS; }
-static inline int migrate_finish(void) { return -ENOSYS; }
-static inline int migrate_prep_local(void) { return -ENOSYS; }
-
 static inline void migrate_page_states(struct page *newpage, struct page *page)
 {
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index e04f4476e68e..3be017ececc0 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2319,7 +2319,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	trace_mm_compaction_begin(start_pfn, cc->migrate_pfn,
 				cc->free_pfn, end_pfn, sync);
 
-	migrate_prep_local();
+	/* lru_add_drain_all could be expensive with involving other CPUs */
+	lru_add_drain();
 
 	while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
 		int err;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 495b43a4b0f8..6daf9cc4c843 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1124,7 +1124,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	int err = 0;
 	nodemask_t tmp;
 
-	migrate_prep();
+	lru_cache_disable();
 
 	mmap_read_lock(mm);
 
@@ -1209,7 +1209,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	}
 	mmap_read_unlock(mm);
 
-	migrate_finish();
+	lru_cache_enable();
 	if (err < 0)
 		return err;
 	return busy;
@@ -1325,7 +1325,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 
-		migrate_prep();
+		lru_cache_disable();
 	}
 	{
 		NODEMASK_SCRATCH(scratch);
@@ -1374,7 +1374,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 mpol_out:
 	mpol_put(new);
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-		migrate_finish();
+		lru_cache_enable();
 	return err;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 4d6c306d41c6..acc9913e4303 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -57,30 +57,6 @@
 
 #include "internal.h"
 
-/*
- * migrate_prep() needs to be called before we start compiling a list of pages
- * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
- * undesirable, use migrate_prep_local()
- */
-void migrate_prep(void)
-{
-	/*
-	 * Clear the LRU lists so pages can be isolated.
-	 */
-	lru_cache_disable();
-}
-
-void migrate_finish(void)
-{
-	lru_cache_enable();
-}
-
-/* Do the necessary work of migrate_prep but not if it involves other CPUs */
-void migrate_prep_local(void)
-{
-	lru_add_drain();
-}
-
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct address_space *mapping;
@@ -1771,7 +1747,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	int start, i;
 	int err = 0, err1;
 
-	migrate_prep();
+	lru_cache_disable();
 
 	for (i = start = 0; i < nr_pages; i++) {
 		const void __user *p;
@@ -1840,7 +1816,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	if (err >= 0)
 		err = err1;
 out:
-	migrate_finish();
+	lru_cache_enable();
 	return err;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index af5d4eeb2999..bf1606c7965a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8467,7 +8467,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
 
-	migrate_prep();
+	lru_cache_disable();
 
 	while (pfn < end || !list_empty(&cc->migratepages)) {
 		if (fatal_signal_pending(current)) {
@@ -8496,7 +8496,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
 
-	migrate_finish();
+	lru_cache_enable();
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
 		return ret;
-- 
2.31.0.rc2.261.g7f71774620-goog

