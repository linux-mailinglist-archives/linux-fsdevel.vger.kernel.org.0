Return-Path: <linux-fsdevel+bounces-13311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF786E640
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842C61F28267
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CDE7441A;
	Fri,  1 Mar 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="OZmI+l81"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88BB3FB0C;
	Fri,  1 Mar 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311524; cv=none; b=egFT2SxJbjK/P+HiD2BkgnFC0ZHalQX/sp5S4znUSyhXBPFQ+V+qhZdAJ1yCj0t5cV4VkEouPhVjPMDGqcj0c86p4o6DZwed6hmkHpF2Bem5B80D6BAceacRxBaBjwzGDKAWt0mRu5kEJX5l3ejOSYOGRvCGsl5zCfW9wks9oFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311524; c=relaxed/simple;
	bh=RpGDv7xjt1Tn0NAFmnUJ4dRChi0PW0zUu2AGhx/ey2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhrrf4Uv+kBhwrdcH5qrfJzBhkw9wrWE2kCRz3NJe1LOtNqMK1bdmANQSCIEA7ZEHQfdWEB7yNE5XL92jSLudX5801Z0ntUKoAd4rtBpcW0bB+ceIfTeUlp2aSzUt/D0LUcMO3JA3AX7I7wMKPA9EyRxf88ezuBlhaEyNmHm3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=OZmI+l81; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TmYqM2l4gz9tW7;
	Fri,  1 Mar 2024 17:45:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709311519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3Xg5bE7lOUEiWrLgvJkawBGempm7FqinU/8gfujPB8=;
	b=OZmI+l81//odOBAskdE4zl6fx7Y7LVheQ+0p8xiXpuBz9P7DZyU0Im1meut9eKMfMmB788
	ipb6Wl0H30SzQq2hEQaq4wH35pYRxjMogRPWpnm6QhSPE9TbIn+hTafnbjpS+iJtUnffxl
	iByU4+WZ1caxuiG+BaPAA2sBfuzOzdtyly45fU418II1VmVRcZPFnjSmTSR7MBN+Bf8Rmy
	6xDC4IVUbgGFmFkd1gcKMP/OesDKMF0KZuJoxLbYn2fZzWoMyuXP5Rvy3PNFfH7pRm2kuH
	C5UnREMrQiygk+CwzFIbQGQ6JDso3LOU+7kPNg4LV/P1QBLntDzO3hfnOUyagg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: djwong@kernel.org,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	gost.dev@samsung.com,
	linux-kernel@vger.kernel.org,
	chandan.babu@oracle.com,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 09/13] mm: do not split a folio if it has minimum folio order requirement
Date: Fri,  1 Mar 2024 17:44:40 +0100
Message-ID: <20240301164444.3799288-10-kernel@pankajraghav.com>
In-Reply-To: <20240301164444.3799288-1-kernel@pankajraghav.com>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TmYqM2l4gz9tW7

From: Pankaj Raghav <p.raghav@samsung.com>

As we don't have a way to split a folio to a any given lower folio
order yet, avoid splitting the folio in split_huge_page_to_list() if it
has a minimum folio order requirement.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 mm/huge_memory.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 81fd1ba57088..6ec3417638a1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3030,6 +3030,19 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			goto out;
 		}
 
+		/*
+		 * Do not split if mapping has minimum folio order
+		 * requirement.
+		 *
+		 * XXX: Once we have support for splitting to any lower
+		 * folio order, then it could be split based on the
+		 * min_folio_order.
+		 */
+		if (mapping_min_folio_order(mapping)) {
+			ret = -EAGAIN;
+			goto out;
+		}
+
 		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
 							GFP_RECLAIM_MASK);
 
-- 
2.43.0


