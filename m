Return-Path: <linux-fsdevel+bounces-55660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE2B0D634
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 11:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9501542D8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C62E06EA;
	Tue, 22 Jul 2025 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Y0wFAmYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421102DF3FB;
	Tue, 22 Jul 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177385; cv=none; b=mtu2OoVk68ol9S0II9TBuB+t4ruIAZL28FjqHTTC58bTjTov1h9kCP4aUvmLlxuQdP52G18BEFUpODmBabDoF8LaIO2uj6JA1MgKUmwB2rHIfuy6Gh/X/U0j3fhm0qoh3iX8ds/LVRADl9VZbSNf91Wi5ob7vnPvWgmvmv4Ks3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177385; c=relaxed/simple;
	bh=i5HFrd2FWxUjBFgFoSGQG6fmJuhhxdcl7IH/c6djXWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDeuUKMMSxFuy/Rrw66myHBRfNIgA+CMnSWztAwkYCpgnmoY/2CYrAF5k35t19MgFtATyxP4UiRnfkUxzuKd786cuL3Yp+xaU+a0VNpaoKDMc+is1hdzcFKFkeXrLXisC31l3naikZFaEK0ywtFJhZr5hYvpHSv4vUcCpSa2PRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Y0wFAmYk; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bmXPZ286Kz9t5M;
	Tue, 22 Jul 2025 11:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1753177378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYyp+w22l9XbkRdarGqCeCGaqwERoFSGzuOGfuq7M5s=;
	b=Y0wFAmYkHydK48RI/Nd8fQWSF3YLrfZXysTNb0HP46ej3v42HL7K1rEDJDXtfe5dfRIcbk
	A/rSON4SAyXNA0dp8muPL1J6PzEGBPCfOcOaO510oBuVXNfYVQlm6cYq4awQHv9s6J/twP
	RE5msPFF4rnlpEVMdPKLw6kZxv8p/3DMgzw0KAfGPzhTrH8fRUHFld8xQtNgwd3v69Z7g2
	0RYfYJuok6e4SS1R6fZbtz+HiSPJgT0o/017lUhkhWMPVAKSXGrCi4Z1gOp3IFixS28WC8
	NvH4TJJhBGLbUF8Jf/UjucWIrhfZGjDeNg6EFBV079IlPsUWHZawqH9bPpmBdQ==
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
Subject: [RFC 3/4]  mm: add largest_zero_folio() routine
Date: Tue, 22 Jul 2025 11:42:14 +0200
Message-ID: <20250722094215.448132-4-kernel@pankajraghav.com>
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

Add largest_zero_folio() routine so that huge_zero_folio can be
used directly when CONFIG_STATIC_HUGE_ZERO_FOLIO is enabled. This will
return ZERO_PAGE folio if CONFIG_STATIC_HUGE_ZERO_FOLIO is disabled or
if we failed to allocate a huge_zero_folio.

Co-Developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/huge_mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0ddd9c78f9f4..a34c5427aaf6 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -714,4 +714,12 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 	return split_folio_to_list_to_order(folio, NULL, new_order);
 }
 
+static inline struct folio *largest_zero_folio(void)
+{
+       struct folio *folio = get_static_huge_zero_folio();
+
+       if (folio)
+               return folio;
+       return page_folio(ZERO_PAGE(0));
+}
 #endif /* _LINUX_HUGE_MM_H */
-- 
2.49.0


