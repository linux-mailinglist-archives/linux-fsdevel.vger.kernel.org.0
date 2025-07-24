Return-Path: <linux-fsdevel+bounces-55950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA37EB10E09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B2FAC2BFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF42E973D;
	Thu, 24 Jul 2025 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="fGW1OltX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776322E8DF2;
	Thu, 24 Jul 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368628; cv=none; b=AHUEdaey6AVZdkzajChvm0zDUuVgpYhyxVhySrD4jcgjDr6vqU4aCaJcNR0eDRuCk9G1giRt/e2uJMxeI6u71AvRVTeGgfmeVgzy9TF2fac6nyNRPnmPSKSPyFhh2GUEjLC/9+dbnWjbQcGlJQYUGhYJHlpdGfVXmFJZfCpttQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368628; c=relaxed/simple;
	bh=7+0BZ+Y9aBy5gxJfmvebis2hZGKosloX75tcKikiPpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxEBelaTQ+YJ9ZHYzS38+ZbONW1BnMfUNVvmaQBdGsqPYAGi+Z0ZCBUyjWmXrXbpIri/NrC3CFXl0pON+DAFuF8tg6zRxSzR/y9umg2fwVxnGTjHU9VH5cSXx6jtxk1OXYIJ8fN5dPJuFjjVZbyVlRrDbw5yw8Z44VY9a1tKAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=fGW1OltX; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bnv7L5sBNz9tV9;
	Thu, 24 Jul 2025 16:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1753368622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOp/GZbIELNxUFAy4Lvk7xSAmNGCaCvGZ6cxvtiBNgE=;
	b=fGW1OltXhLG1qiHyJSscjoHS8RAejuySa0WcLuJd2nbCWCzpDlr2zcCXbGwexZt9B5CUCI
	FgFH5JmvrYdCQZ0E3o2yfc02Ndr6hONgtkOBoKajck9dEl/yL9eewMOY7V5GWVOfneM9SM
	oapFzHxro2NG2ZomEFCXnc4Z89zLdTy51XADLaAknjCA4FDQuRmgYCn9hPv3f//+yT7UtC
	E6yhUE1mP8yKAkoT+GKp062MZXLTuHDMiA8dDKvLe2DSxSu790SXQm04rnrUbIi2yphu1i
	KmD6XqflycMsCjHi4mAPKdwuVa5SPuYW/0xXxf2wwIL3dic33soKYhgNCvmkXQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
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
	willy@infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 1/4] mm: rename huge_zero_page_shrinker to huge_zero_folio_shrinker
Date: Thu, 24 Jul 2025 16:49:58 +0200
Message-ID: <20250724145001.487878-2-kernel@pankajraghav.com>
In-Reply-To: <20250724145001.487878-1-kernel@pankajraghav.com>
References: <20250724145001.487878-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bnv7L5sBNz9tV9

From: Pankaj Raghav <p.raghav@samsung.com>

As we already moved from exposing huge_zero_page to huge_zero_folio,
change the name of the shrinker to reflect that.

No functional changes.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
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


