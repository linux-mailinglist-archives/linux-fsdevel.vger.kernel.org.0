Return-Path: <linux-fsdevel+bounces-55658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F72DB0D62F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 11:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4906C60B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615E2DFF22;
	Tue, 22 Jul 2025 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="o+kgP4wN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C5C28A40F;
	Tue, 22 Jul 2025 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177366; cv=none; b=kFEvqZhoD68oXbNJ6f8/9qvU+YYyw1fm0svN2F0o32DbcA47Z3+9k+ASP15bqdx8MOtypjqOzNw+rq641DaWX5lVO95r1+MVqQdTRRLaFkuRqWYrnMjM2/i/WHHtEfY8UnG9vZ1qQwWTpx81K1jj5jYhRdOHgDBJuWr542NkNlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177366; c=relaxed/simple;
	bh=QBw0YHOR8B42A8wv8Y/zpHFxfSNPA6RzsvuwT4gCxoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDkRpw3ZKT6g/YY/okERectHTyNMp5g3IfvXIxdSAijWwjEFv6J9gNWedDAwyYtwZ7httvJOioh//BJHbkveyC/6T2oQvYu+zBCBLR/XpKmA4EQPEdqMYTWp4KPArZgBEa6DU1+p5Cw/Iet/Q1cEdDKZd6O0Px397UujLF++E+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=o+kgP4wN; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bmXP73Zcvz9tht;
	Tue, 22 Jul 2025 11:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1753177355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkFrb5mCNuui7GC4+ZivqwyBFvkydagw0IS4O3GFosI=;
	b=o+kgP4wNhjY5eTyH7SsHPA0QXxHdjIPiezXWmhC17Cq39gi1RTU/DViRyyO4gZBs1eDlDj
	bkyxR9N6PPTIxJ35WqsTG6weGH3Cq1UMyjWi7RdYgXSOiG8jD7QttpM1zBIZDsBf63gLXc
	wbMweJJgqFDYkrqrwhJ3jDdaHtdV49VqQ9m2K+j4vBfxQy9c1dukZo43RO+EV1AkfK6wPI
	1WqlZYmcUR8TCjVDYkT0Y+oToapzDlviBNpKRRX6XmbDChlHx6Kazo8Sjpks98hEAv1BmW
	E6kXuxgNyr6hUQkxQlq6BMNBvks5SX8dfuX8zWp7h9Ao/Pof61HJwc7QPcg3mw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 1/4] mm: rename huge_zero_page_shrinker to huge_zero_folio_shrinker
Date: Tue, 22 Jul 2025 11:42:12 +0200
Message-ID: <20250722094215.448132-2-kernel@pankajraghav.com>
In-Reply-To: <20250722094215.448132-1-kernel@pankajraghav.com>
References: <20250722094215.448132-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

As we already moved from exposing huge_zero_page to huge_zero_folio,
change the name of the shrinker to reflect that.

No functional changes.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/huge_memory.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b4ea5a2ce7d..5d8365d1d3e9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -266,15 +266,15 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
 		put_huge_zero_page();
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


