Return-Path: <linux-fsdevel+bounces-14307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6EF87AF20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF50DB21B72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A766A199885;
	Wed, 13 Mar 2024 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="L+OtKexa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861941991AA;
	Wed, 13 Mar 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349412; cv=none; b=jZNQbjyKO6pRF57moZfmtko1tfFf/oETjMlksY5irOEsLu+bxr5fNtkTpfEC/are046OKlC7ABBdore2PQ1gNXjJjtC//ZJK9dKl6K6Y5fMnKC7HALkOOw46aVcUOO6THYT8k0Y0P9EfMYEUW6rp+WJaNyXHQQm3zJTs4sc3UAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349412; c=relaxed/simple;
	bh=RpGDv7xjt1Tn0NAFmnUJ4dRChi0PW0zUu2AGhx/ey2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzhHdJsNnl8c/nZ/MsTh7N7lX/K6Ndgf37fELRahci5woO2FL0VrRgRaKpCDAWaUFuo3V6G5UKaQHU8NCi7EwuiNDh3ECyfCsmrA54rQrNAFavMDuzhgCa7/CQxPHrl9bk0W4r4qA3sTCEaBXEZuelQX7JG3UHRcWPqSWCgt0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=L+OtKexa; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tvxfl1Ftrz9sqV;
	Wed, 13 Mar 2024 18:03:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710349407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3Xg5bE7lOUEiWrLgvJkawBGempm7FqinU/8gfujPB8=;
	b=L+OtKexa8lscvnV+tP6Qwfgscep0OokKJI+6VWJsVSvNCdYGHpjfa+oUx+M4CnU+flHItA
	Z7biTY7xoXAJWfjX8BUdzqizkXIbR083jNK0fC/LUb0rJ1ZBAH9+6gYFAQuNpHE9vI7/wL
	zbWzflaswuuxg1W3On8MRJaz9vHDwPBmneBEUngNZBU/bneNO4W9RdsLF/SuGWBcq4rFBL
	EDyHiJ9W22Go64+oMoK0yj/4z70enqNwtiC/3W/sgqAhc0pY2QxwX3uOcaTcmNTYsts4WV
	zcm5NCF1rZ91I8S3vS/p0psodGFJnSjvTeYE+LRQIBxvVmMN5SOOT2jfF38FPw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: gost.dev@samsung.com,
	chandan.babu@oracle.com,
	hare@suse.de,
	mcgrof@kernel.org,
	djwong@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 07/11] mm: do not split a folio if it has minimum folio order requirement
Date: Wed, 13 Mar 2024 18:02:49 +0100
Message-ID: <20240313170253.2324812-8-kernel@pankajraghav.com>
In-Reply-To: <20240313170253.2324812-1-kernel@pankajraghav.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Tvxfl1Ftrz9sqV

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


