Return-Path: <linux-fsdevel+bounces-56637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C105B1A0F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 14:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94093BE39B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E492580EE;
	Mon,  4 Aug 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="UqL2d18w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7514EC62;
	Mon,  4 Aug 2025 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309666; cv=none; b=Dkfn2FAmY+p13J6CC95/2WXnnwT+dgM1YR/mhKa5Y1tM+/NVtlGABtryjcsGMzHLrERx4oOrqWEEDjayJFT4H4eFSoKagI4vZCCqQCvJcyKpVG88ialgxZA+2lKagqTMuTSsp7gdX8Xc6BRUF5js1xdEYtjvG+6mUFvuqI5Pq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309666; c=relaxed/simple;
	bh=d5cqKEY5CbIXWeLXswhu4+/IzdeUgge67U0jVF/tfAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9gvGWsqa6r/Z248cldDNkLNqIesj+dq6DPNq7HZu4u0i0VZbqN2FVjPHH49zCB1b5sJtpQVq/K98O0ozdE+GauEvDuqQHZhNle0pAkIIhafXHxMruJdR6U2vmAymKz8v5yN98w8FtQKII7dMvCfG8FXWIPlU1mZRAIt0SgtxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=UqL2d18w; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bwb871KgPz9st4;
	Mon,  4 Aug 2025 14:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754309655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wg6vfvVQRpqn/feIP7hePbKRJwLF2oar9zj0xHqTXhU=;
	b=UqL2d18wzvHrh7tJVeJYCXjGyxAtaFcs6MKVFbkeIkqEflCP4Dx6giEliPtbcnbWHyZDu7
	P51MPKLvSqf93s2tp3y0kyjk/cFhINFXyu/CixWPgy8iugkpGbQT0MzLmFQ7SdKMIM9iW/
	VdsYUqnPg/wxAYnDxCZlRu3iBvWowKQCoZgoUBDPxUwVHsT7x3EVmgjuhFl7Liv2ggwTUm
	I9TzT4YlcLDNf0AKGYKYedOlMnS6sLOEbkRgwuGIIKUOmUNu5W7jvCSvmxd4Cw8x6NtjBJ
	tCYS6XbMdIrkmm4Kn2SgHagJ+ipJV0xdoB6ACPdJnwr43ZnClFuU72io38LD1A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
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
	linux-mm@kvack.org,
	willy@infradead.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/5] mm: rename huge_zero_page to huge_zero_folio
Date: Mon,  4 Aug 2025 14:13:52 +0200
Message-ID: <20250804121356.572917-2-kernel@pankajraghav.com>
In-Reply-To: <20250804121356.572917-1-kernel@pankajraghav.com>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bwb871KgPz9st4

From: Pankaj Raghav <p.raghav@samsung.com>

As we already moved from exposing huge_zero_page to huge_zero_folio,
change the name of the shrinker and the other helper function to reflect
that.

No functional changes.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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


