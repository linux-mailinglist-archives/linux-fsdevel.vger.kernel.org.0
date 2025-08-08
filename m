Return-Path: <linux-fsdevel+bounces-57064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D386B1E80D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D813F1C21FFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420527602B;
	Fri,  8 Aug 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="QGUnXZHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B326D4FC;
	Fri,  8 Aug 2025 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655133; cv=none; b=IXpvazLhk9MNBu9ibTCQK3M7KtgODI2qSYoy5NyydgVZuRTUYUkHEarpIOw1wfzV0o0YkZH3pVPzLNFxrldlndhv11VtgbAHRUjEz1j7AYH44MtuoCK/5M+F+lAsBMafHFjxLWNP6xY98J4Crkms6mbarqWC+MKBhsXQlrMicv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655133; c=relaxed/simple;
	bh=Lnbkr3x0JYfoWu6sKfOzg3PL074sWgz9L0+tsOihiWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKVTZdgmoMFNoUpHenst5nTt3OKzJ2WfKX5WgX8nJ5SdrvHZcol4MqEuv4V7EPAm01Cy5D5GObnAkzwijmSyIShN08m79m4S9UEsd62tvOK1U7/ri39OjU4xM2M8Fn9Utoc5BcI+i0TuRhjpxjD7RAupIfMcg4ysARipJkJYhr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=QGUnXZHl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bz2vp6Ymsz9t24;
	Fri,  8 Aug 2025 14:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754655126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/ct59qYuG3RzWBHGmFR3jjZkQ8rYUbub3Dfwy3OQL8=;
	b=QGUnXZHlRNWqOMSVO0Y5Peq+yB1a9+GxThUm3ERkXjm3E9T+3p4Fj7E2d+i4XqRZzdsC3r
	vhOn0P934owXGjzttjgAXA1XHOnEQwFFS+490iTAnHUNPOvCAVIKMWL2byS1zPSb/ruWLX
	xtE7sce+hygMs/cARuruABHNlPW2w3gHC7+tjSzqSB371JD4GJD6rmSFQtSMjhNtJvNsIj
	sbYC+J8kGKhyk9By8B+/sqbS7roIpvgMRJglVsGjkX6wNmFAFZK2jiRY3aOva/TSzVVclY
	bdodhTDFWZnJjg+aXJ4PCMN8R6cf5HJqPvG+EdIx0pc9jLtTx7TGLzZ+PhyEyg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	willy@infradead.org,
	linux-mm@kvack.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 1/5] mm: rename huge_zero_page to huge_zero_folio
Date: Fri,  8 Aug 2025 14:11:37 +0200
Message-ID: <20250808121141.624469-2-kernel@pankajraghav.com>
In-Reply-To: <20250808121141.624469-1-kernel@pankajraghav.com>
References: <20250808121141.624469-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

As the transition already happened from exposing huge_zero_page to
huge_zero_folio, change the name of the shrinker and the other helper
function to reflect that.

No functional changes.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/huge_memory.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b4ea5a2ce7d..6625514f622b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -207,7 +207,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
-static bool get_huge_zero_page(void)
+static bool get_huge_zero_folio(void)
 {
 	struct folio *zero_folio;
 retry:
@@ -237,7 +237,7 @@ static bool get_huge_zero_page(void)
 	return true;
 }
 
-static void put_huge_zero_page(void)
+static void put_huge_zero_folio(void)
 {
 	/*
 	 * Counter should never go to zero here. Only shrinker can put
@@ -251,11 +251,11 @@ struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
 	if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
 		return READ_ONCE(huge_zero_folio);
 
-	if (!get_huge_zero_page())
+	if (!get_huge_zero_folio())
 		return NULL;
 
 	if (test_and_set_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
-		put_huge_zero_page();
+		put_huge_zero_folio();
 
 	return READ_ONCE(huge_zero_folio);
 }
@@ -263,18 +263,18 @@ struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
 void mm_put_huge_zero_folio(struct mm_struct *mm)
 {
 	if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
-		put_huge_zero_page();
+		put_huge_zero_folio();
 }
 
-static unsigned long shrink_huge_zero_page_count(struct shrinker *shrink,
-					struct shrink_control *sc)
+static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
+						  struct shrink_control *sc)
 {
 	/* we can free zero page only if last reference remains */
 	return atomic_read(&huge_zero_refcount) == 1 ? HPAGE_PMD_NR : 0;
 }
 
-static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
-				       struct shrink_control *sc)
+static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
+						 struct shrink_control *sc)
 {
 	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
 		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
@@ -287,7 +287,7 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 	return 0;
 }
 
-static struct shrinker *huge_zero_page_shrinker;
+static struct shrinker *huge_zero_folio_shrinker;
 
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
@@ -849,8 +849,8 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
 
 static int __init thp_shrinker_init(void)
 {
-	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
-	if (!huge_zero_page_shrinker)
+	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
+	if (!huge_zero_folio_shrinker)
 		return -ENOMEM;
 
 	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
@@ -858,13 +858,13 @@ static int __init thp_shrinker_init(void)
 						 SHRINKER_NONSLAB,
 						 "thp-deferred_split");
 	if (!deferred_split_shrinker) {
-		shrinker_free(huge_zero_page_shrinker);
+		shrinker_free(huge_zero_folio_shrinker);
 		return -ENOMEM;
 	}
 
-	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
-	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
-	shrinker_register(huge_zero_page_shrinker);
+	huge_zero_folio_shrinker->count_objects = shrink_huge_zero_folio_count;
+	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
+	shrinker_register(huge_zero_folio_shrinker);
 
 	deferred_split_shrinker->count_objects = deferred_split_count;
 	deferred_split_shrinker->scan_objects = deferred_split_scan;
@@ -875,7 +875,7 @@ static int __init thp_shrinker_init(void)
 
 static void __init thp_shrinker_exit(void)
 {
-	shrinker_free(huge_zero_page_shrinker);
+	shrinker_free(huge_zero_folio_shrinker);
 	shrinker_free(deferred_split_shrinker);
 }
 
-- 
2.49.0


