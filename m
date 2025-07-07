Return-Path: <linux-fsdevel+bounces-54128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0B2AFB605
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B47B5602E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C155F2DECAD;
	Mon,  7 Jul 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ffR+SWki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008C2D8DA7;
	Mon,  7 Jul 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898229; cv=none; b=TZ7WKOn0RNtqPvsuMWS7CsnmqP5WNmDUyid74e7sbLzYN6SNzk9HJ4qwQCA2FPCqv+xaZVfZmMaFXGQ7ZJ0YNTsViTPiJn9vqwGAL5yl1FEsbRHBncq9tUvtFXULXECuGfKrUlTDDRbR4XInPeKPCJEC/C3DP5tno+I+riV7qmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898229; c=relaxed/simple;
	bh=Ivb4sEJ315yPpA6w6gGkLWI94DbQvOmt61KT3beBg94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpXdLlGIMGUcnOe3jl6NfSLDwgaFkMhfq0Q9wt9XIruhOCduRcZqQXVT+WRD2CYUwG8crl54Pgo5iLth7DevA/I5tQ5D0B7Z4tdygRZrzhPzU9Yd/WnbVgsRtQviGYiH6a+JYbD33RzO5iw4AxK6w3CDOeW03twUAdvWVnE7e+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ffR+SWki; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bbRLQ4bdWz9t1B;
	Mon,  7 Jul 2025 16:23:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1751898222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6e+PcGOhziaHPv2fooE3Mhq4C1IPp18icg31JFqEy0=;
	b=ffR+SWkiKB9WbWaNGhqMuxqsE52z254tpTUQZe5jFt8NBzuujnqJZw9d1+45vg6y7eMN92
	OB9P13fXqYVzkwN4t1wJF0vB4a9wJRhy7WQ0Iiava1lotvj/tQNQE/PFq3GzAxu07Ly+z3
	6nD8y9sDqHk2IeKXs8KJZUEz5/vvhQnKHAnbGgvVmZLwLaCWFsqYghnAjaf5cTKjxwSDlI
	ZQegm5oxr43vVDNZYEUtm7TZOiur6dkgIUuvQIpUhha6IrFcBbetxUWEOPY6vOHMfG4vVE
	YqL61VItf9ZnU9IXw8EcUiwV6XOEjBhjyl3ewfpjOKpQLUHJLAiLTuYmy+fHyQ==
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
Subject: [PATCH v2 2/5] huge_memory: add huge_zero_page_shrinker_(init|exit) function
Date: Mon,  7 Jul 2025 16:23:16 +0200
Message-ID: <20250707142319.319642-3-kernel@pankajraghav.com>
In-Reply-To: <20250707142319.319642-1-kernel@pankajraghav.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Add huge_zero_page_shrinker_init() and huge_zero_page_shrinker_exit().
As shrinker will not be needed when static PMD zero page is enabled,
these two functions can be a no-op.

This is a preparation patch for static PMD zero page. No functional
changes.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/huge_memory.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a..101b67ab2eb6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -289,6 +289,24 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 }
 
 static struct shrinker *huge_zero_page_shrinker;
+static int huge_zero_page_shrinker_init(void)
+{
+	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
+	if (!huge_zero_page_shrinker)
+		return -ENOMEM;
+
+	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
+	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
+	shrinker_register(huge_zero_page_shrinker);
+	return 0;
+}
+
+static void huge_zero_page_shrinker_exit(void)
+{
+	shrinker_free(huge_zero_page_shrinker);
+	return;
+}
+
 
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
@@ -850,33 +868,31 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
 
 static int __init thp_shrinker_init(void)
 {
-	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
-	if (!huge_zero_page_shrinker)
-		return -ENOMEM;
+	int ret = 0;
 
 	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
 						 SHRINKER_MEMCG_AWARE |
 						 SHRINKER_NONSLAB,
 						 "thp-deferred_split");
-	if (!deferred_split_shrinker) {
-		shrinker_free(huge_zero_page_shrinker);
+	if (!deferred_split_shrinker)
 		return -ENOMEM;
-	}
-
-	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
-	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
-	shrinker_register(huge_zero_page_shrinker);
 
 	deferred_split_shrinker->count_objects = deferred_split_count;
 	deferred_split_shrinker->scan_objects = deferred_split_scan;
 	shrinker_register(deferred_split_shrinker);
 
+	ret = huge_zero_page_shrinker_init();
+	if (ret) {
+		shrinker_free(deferred_split_shrinker);
+		return ret;
+	}
+
 	return 0;
 }
 
 static void __init thp_shrinker_exit(void)
 {
-	shrinker_free(huge_zero_page_shrinker);
+	huge_zero_page_shrinker_exit();
 	shrinker_free(deferred_split_shrinker);
 }
 
-- 
2.49.0


