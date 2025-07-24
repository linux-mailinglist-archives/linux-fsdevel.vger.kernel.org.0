Return-Path: <linux-fsdevel+bounces-55952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BFB10E1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 16:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8E07BF5E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E812EA476;
	Thu, 24 Jul 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bmODlJne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD22E8E00;
	Thu, 24 Jul 2025 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368643; cv=none; b=Xwcpj/XamDFit4sJlyBSDVrm0FQaWDIZzmSTqrO84436gRqih4myWYvxqrl77UC87Gzdtcf0K4FSTNMi+ZmmG4mDnwf/lJrRWaBcf4fnZxE1gbQvG08VNOs+HMKka61pIhmDp0Rq6fsstjPavD6kAGJgunsVvbfDdIsvtekFy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368643; c=relaxed/simple;
	bh=3yvTRW5FhiAKs+vOBuG4HDRUaaXxURgqxp/7gqTmM9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u99tfd1Qf/aYV/qi6ZfDisaoN9/l4AwyVFOjTroTthc/B+6W4t8snS/yIjBv8Ey0kfng4jw09oPd2uI7QcdXTNqcQXRjMT+gkUnBuC+gjgWrj/PDaLwfxspXEqcbo8wn8qE7/hWtPkbRdx8M+YQxLimJ0M/YDi9oiHLmN905DuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bmODlJne; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bnv7f3dscz9stm;
	Thu, 24 Jul 2025 16:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1753368638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgGhybuB+tAZvqsghR5tZCuaExpLC7iQdGM6Ue4YApc=;
	b=bmODlJnet//564H9GeC9UKYZRU0b9X8jENtT/ImDqDE/BSUhU8rDT7sLaQXjai9cqvVPzC
	XRTh5RmBQ1OSw7iUsTEHZpj07zzID1a8hden/+Ko29ENEAmGxnE9WXBP/ZCpE6TdMcVWFY
	ziPtCk32ubRHQP9Re7bDQ5LcoGHYZ1HRESsfNTQRdlI7cFMrm5aCsx6seEQ8RRP0sUdfvl
	sEIV5w7JLjAF4BSoGp8kJuKfvhw5slZnmYfIQJcNvK1EQx3HCXMNi0n23ze48W2IQslE6a
	asi3QmBg3iL+GjW4H1HswQbOAienOX5tDKRH0fN+Qa6qnvMZ7lHZs/hA3JtlHw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
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
Subject: [RFC v2 3/4]  mm: add largest_zero_folio() routine
Date: Thu, 24 Jul 2025 16:50:00 +0200
Message-ID: <20250724145001.487878-4-kernel@pankajraghav.com>
In-Reply-To: <20250724145001.487878-1-kernel@pankajraghav.com>
References: <20250724145001.487878-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bnv7f3dscz9stm

From: Pankaj Raghav <p.raghav@samsung.com>

Add largest_zero_folio() routine so that huge_zero_folio can be
used directly when CONFIG_STATIC_HUGE_ZERO_FOLIO is enabled. This will
return ZERO_PAGE folio if CONFIG_STATIC_HUGE_ZERO_FOLIO is disabled or
if we failed to allocate a huge_zero_folio.

Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/huge_mm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 78ebceb61d0e..c44a6736704b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -716,4 +716,21 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 	return split_folio_to_list_to_order(folio, NULL, new_order);
 }
 
+/*
+ * largest_zero_folio - Get the largest zero size folio available
+ *
+ * This function will return huge_zero_folio if CONFIG_STATIC_HUGE_ZERO_FOLIO
+ * is enabled. Otherwise, a ZERO_PAGE folio is returned.
+ *
+ * Deduce the size of the folio with folio_size instead of assuming the
+ * folio size.
+ */
+static inline struct folio *largest_zero_folio(void)
+{
+	struct folio *folio = get_static_huge_zero_folio();
+
+	if (folio)
+		return folio;
+	return page_folio(ZERO_PAGE(0));
+}
 #endif /* _LINUX_HUGE_MM_H */
-- 
2.49.0


