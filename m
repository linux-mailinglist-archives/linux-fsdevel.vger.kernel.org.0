Return-Path: <linux-fsdevel+bounces-73178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC2D0FDD7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 21:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 933243020746
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCC4264FBD;
	Sun, 11 Jan 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7BeWLen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AB259C80;
	Sun, 11 Jan 2026 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768165166; cv=none; b=GJqBxVpdIixeDcYDM2uP6VSaOyoYEOBES1YGZRhgADuTnb8pHwa0fB2Hv2BOb1DM9ixSKb4cNJD3BYolUS3jz+dDHbV+OZbEfajpzCmd29yB9FPgWSa80FBzmZDjSF+YhaX86nUT8VhsuyLtUeGYGiM3omFHcLxQmwS8gLawwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768165166; c=relaxed/simple;
	bh=x0o46IltvZIziPvuDUlJFM12hoQwAZmCbZJupxvwuok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SROJWUK0QDviUoVYrlGg8r/G+dw8bjgI7GzuCvVM0A5U6HSD6SUKrzAmW9oPtPRT9hzfe2gBsY8KgagywHwb+Fw74Lm+BsWHRlJio7M3mzZ1IAPd4niXiErhbfRPOQF0fT3052eXoJP8MBNrA8zl4TdFeMntguGAPOj4/9u/8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7BeWLen; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768165161; x=1799701161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0o46IltvZIziPvuDUlJFM12hoQwAZmCbZJupxvwuok=;
  b=b7BeWLenzY6xP2gNh8Xx2lDkh3NUJyo7z9OfkgUU0eW7297nJwhgwwdx
   RsK+abogvCGJVHzHS7huEMhdnaOgZ/f2t+2GdqDtSBl9jyvT7VBZLMRcX
   9rbniTfnEadFbQRG9jghH6UQ8frgfFMQLs2xKvEUJ6Gh0ZMgHDVmebyL9
   /S+NQawnPS4PLTK6vxjnRxflipk4kliQzIYu56iXuxnTpw5zrP0IiQffC
   3qSRsrwagR3j90U7nwup7I1AtktL9btQ+LL8jy3PVdVglcDp0naHx5X5Y
   o3RBSPcyTFWey1Z3kdMmcQuuGxYWwnzNQDnjcf0subrklsra3Ie2WL2NZ
   w==;
X-CSE-ConnectionGUID: X94HPAm6QBe88eUpC0reug==
X-CSE-MsgGUID: R73nTKiaQgy7oMOQquuqZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80904707"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80904707"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 12:59:21 -0800
X-CSE-ConnectionGUID: UlIOxdrHSwKszggz7EuscQ==
X-CSE-MsgGUID: /wOnx8gTQ2iwNjeNht87pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208419980"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fdugast-desk.home) ([10.245.245.11])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 12:59:15 -0800
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v4 3/7] fs/dax: Use free_zone_device_folio_prepare() helper
Date: Sun, 11 Jan 2026 21:55:42 +0100
Message-ID: <20260111205820.830410-4-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111205820.830410-1-francois.dugast@intel.com>
References: <20260111205820.830410-1-francois.dugast@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

Use free_zone_device_folio_prepare() to restore fsdax ZONE_DEVICE folios
to a sane initial state upon the final put.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Suggested-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Francois Dugast <francois.dugast@intel.com>
---
 fs/dax.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 289e6254aa30..d998f7615abb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -391,29 +391,7 @@ static inline unsigned long dax_folio_put(struct folio *folio)
 	if (ref)
 		return ref;
 
-	folio->mapping = NULL;
-	order = folio_order(folio);
-	if (!order)
-		return 0;
-	folio_reset_order(folio);
-
-	for (i = 0; i < (1UL << order); i++) {
-		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
-		struct page *page = folio_page(folio, i);
-		struct folio *new_folio = (struct folio *)page;
-
-		ClearPageHead(page);
-		clear_compound_head(page);
-
-		new_folio->mapping = NULL;
-		/*
-		 * Reset pgmap which was over-written by
-		 * prep_compound_page().
-		 */
-		new_folio->pgmap = pgmap;
-		new_folio->share = 0;
-		WARN_ON_ONCE(folio_ref_count(new_folio));
-	}
+	free_zone_device_folio_prepare(folio);
 
 	return ref;
 }
-- 
2.43.0


