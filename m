Return-Path: <linux-fsdevel+bounces-57067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D634B1E816
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C521C2266B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 12:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B8127978D;
	Fri,  8 Aug 2025 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="PJMxNKsZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9622777ED;
	Fri,  8 Aug 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655154; cv=none; b=SNkz9oDqqqBhWilK2ewEdb6PYnuj05LTi0+ENOU+K3feO/ZFd5EFTOkAZx5hR+rr6BO5HioYGUVZ0P291q3kiUBwvBb4h8PZYXmZr2uXpr2xt06sQIOtPQFnY2Ljcgfxdlt/RoMiywUNSFiLoZdWPlpjRhYnOAkIthyCnAC0l4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655154; c=relaxed/simple;
	bh=oT0FW/RunapxNmY4rFqtnAjWaffZeUhLCZi9RoREue0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui0o8EfA5teU3rfgktgYeptCqQ6GIV2Q1K9BEjj+KkWeSkPfDI03j9Z0eZYTdiVs+aPpNb6oA8rT5BV7UNiTvicLL1pbPlljv2OLVhvN8oqalanc1yFbeP47bBeso+v/mVYbcJR5E4EqQh0aJg3jZEtj1GFLlkLdbZUVwyUtTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=PJMxNKsZ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bz2wF0KySz9smd;
	Fri,  8 Aug 2025 14:12:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754655149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGL5eEa5uwcCLmAXZlfetw2P5FGhr6WsEt8mSkWOldU=;
	b=PJMxNKsZk4m/J8Lll3pMtNJbrGZzevbkVQu4ueEIF0nSztaHLC0UI4fO16+m8KraoOiWqu
	PSLidNADqIcpWREHJPzAmmB8VAoG0cHz6KRG7VTSpppdKinDUJ4mWh16hkU+bUmFweNvIk
	fqwuOxIHqyhLoCqJCesmeEG8vlun0lmzq+6Bweq654JV36rGms6WkVWVI1P+0ZoST3kwAj
	yGoiRY/KF7/9CVsv6zdi9M0yt9gd+tAM19PB8Ju/hUZq56c1Oxxelpn/yEnY9lEyy/kJpH
	q2oi9g06k70aoHZWvdJY/Zh01SAMBFhj5j99tvlAWx0yk0n2laTBhoAB2Q9PNg==
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
Subject: [PATCH v2 4/5] mm: add largest_zero_folio() routine
Date: Fri,  8 Aug 2025 14:11:40 +0200
Message-ID: <20250808121141.624469-5-kernel@pankajraghav.com>
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

The callers of mm_get_huge_zero_folio() have access to a mm struct and
the lifetime of the huge_zero_folio is tied to the lifetime of the mm
struct.

largest_zero_folio() will give access to huge_zero_folio when
PERSISTENT_HUGE_ZERO_FOLIO config option is enabled for callers that do not
want to tie the lifetime to a mm struct. This is very useful for
filesystem and block layers where the request completions can be async
and there is no guarantee on the mm struct lifetime.

This function will return a ZERO_PAGE folio if PERSISTENT_HUGE_ZERO_FOLIO
is disabled or if we failed to allocate a huge_zero_folio during early
init.

Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/huge_mm.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index bd547857c6c1..14d424830fa8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -714,4 +714,26 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 	return split_folio_to_list_to_order(folio, NULL, new_order);
 }
 
+/**
+ * largest_zero_folio - Get the largest zero size folio available
+ *
+ * This function shall be used when mm_get_huge_zero_folio() cannot be
+ * used as there is no appropriate mm lifetime to tie the huge zero folio
+ * from the caller.
+ *
+ * Deduce the size of the folio with folio_size instead of assuming the
+ * folio size.
+ *
+ * Return: pointer to PMD sized zero folio if CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
+ * is enabled or a single page sized zero folio
+ */
+static inline struct folio *largest_zero_folio(void)
+{
+	struct folio *folio = get_persistent_huge_zero_folio();
+
+	if (folio)
+		return folio;
+
+	return page_folio(ZERO_PAGE(0));
+}
 #endif /* _LINUX_HUGE_MM_H */
-- 
2.49.0


