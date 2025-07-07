Return-Path: <linux-fsdevel+bounces-54132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF449AFB62C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DD33AEAB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250942E1730;
	Mon,  7 Jul 2025 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="uredxrHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69BE2BE045;
	Mon,  7 Jul 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898848; cv=none; b=htwnbbsUCdzUfbsH5LJOoNC6sKm8C/L9Jv7YEwg5avER2rABlPGXLT3aF1BJCJVr/jbWvZfzRDseVbtlVYn6roEL9XQ4JVaQUZsZtn6xXcA9A0l6DZT9licz8F7oHvHanWJsENF1gB0N84eTDKWP6U9K58XwLp8QHAg+wWtaJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898848; c=relaxed/simple;
	bh=T9eXTp/Ms48FTz+AjZO1co1eQEeFU0O9d1T8mABx73Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNDswAvxT1QhuBvZJwyiEqjcFLN5oBwaDtggrrZkj4eO/OkQtmNRxvG98kr183J0yclqwKoqDg1S9Nh1w9DT/FwRlZwDhQ2fTeuFs2TXf9e0R2nwQU2iOlBK43uS5n7I6Wv53czB5682/quKNE4JlKTz8wlq4msNQuF7snyeh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=uredxrHk; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bbRLg16kyz9sFB;
	Mon,  7 Jul 2025 16:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1751898235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJ0ngV7aTWi6Z/gfOczCcU5cXbfqX/K4zPNArN06u9Y=;
	b=uredxrHk9oyYeoI7h+a4bxQwVTR6dF1NeERNQrzoRqcBvNsGLKUQOwjlRR4zmVu9IOK1wd
	k44Sac7kd7FQq4ehzXpFgwjiCq7QxzioqS6UPuIeW7+1kq+asKeUgXQ6aYlG+vlw6eXFaK
	vJ9ZlRYwJt6Wb1IVwumM0k57a8AE0f9Fe1FVCIpSyPG3dSGsKFnXrdne+Ox6UChfucdIgb
	Nh40REFiXGI6K0SEfMOQYlbPHr4mO6iaOXbQeT7SArQubEBC3y8Ol3a3Kt8h6O264z/3Bg
	I5+/W+wBp3RdcfHeeanWPoa22RNznXWCAtmz0SoI+UxEItMNupceL6g3LMgrzg==
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
Subject: [PATCH v2 4/5] mm: add largest_zero_folio() routine
Date: Mon,  7 Jul 2025 16:23:18 +0200
Message-ID: <20250707142319.319642-5-kernel@pankajraghav.com>
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

Add largest_zero_folio() routine so that huge_zero_folio can be
used without the need to pass any mm struct. This will return ZERO_PAGE
folio if CONFIG_STATIC_PMD_ZERO_PAGE is disabled or if we failed to
allocate a PMD page from memblock.

This routine can also be called even if THP is disabled.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/mm.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 428fe6d36b3c..d5543cf7b8e9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4018,17 +4018,41 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
+extern struct folio *huge_zero_folio;
+extern unsigned long huge_zero_pfn;
+
 #ifdef CONFIG_STATIC_PMD_ZERO_PAGE
 extern void __init static_pmd_zero_init(void);
+
+/*
+ * largest_zero_folio - Get the largest zero size folio available
+ *
+ * This function will return a PMD sized zero folio if CONFIG_STATIC_PMD_ZERO_PAGE
+ * is enabled. Otherwise, a ZERO_PAGE folio is returned.
+ *
+ * Deduce the size of the folio with folio_size instead of assuming the
+ * folio size.
+ */
+static inline struct folio *largest_zero_folio(void)
+{
+	if(!huge_zero_folio)
+		return page_folio(ZERO_PAGE(0));
+
+	return READ_ONCE(huge_zero_folio);
+}
+
 #else
 static inline void __init static_pmd_zero_init(void)
 {
 	return;
 }
+
+static inline struct folio *largest_zero_folio(void)
+{
+	return page_folio(ZERO_PAGE(0));
+}
 #endif
 
-extern struct folio *huge_zero_folio;
-extern unsigned long huge_zero_pfn;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline bool is_huge_zero_folio(const struct folio *folio)
-- 
2.49.0


