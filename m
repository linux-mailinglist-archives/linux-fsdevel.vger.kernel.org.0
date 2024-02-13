Return-Path: <linux-fsdevel+bounces-11340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C45852C8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282B01C24BB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5CE4207D;
	Tue, 13 Feb 2024 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="iOQgIoOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06341C76;
	Tue, 13 Feb 2024 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817069; cv=none; b=CtXqywAjaqxo4uQIm6RWR24CC9GCIHpXA0MM1Gyd57Pj0KQ5IQc1PBJFx9bVIqq0aArLtpjeRU2yuhRRy4dLLmplaeAB8+7aNR4DH43ildLVlhzAOibZXa8S/yKaCAB//O233EJDr4ANaeMBKirya+CpRTY+AY1fsINACWtVnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817069; c=relaxed/simple;
	bh=BXOnK4nk1tFArXcX7KTp3Xu78chTRHJFIKF4HKgMReU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guPxZ7cfHr1UGUYZr34re58iptqEonS3DwLwE9wCDhGWakCKLhGAO97oXLk9CZxfFUuydf4GL6UjVay3RnZdYkoMgFzXknzLIOrbwsYLG4yRD+ichdcOLW3S/12d5gYIJ/b059rVbXn2bSER6MDEGUOwT1I95/FUwQp+O5kPyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=iOQgIoOS; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TYx7q6TR8z9sQ6;
	Tue, 13 Feb 2024 10:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mCWMwP5wq3JUiJEv3CmIbOYWUCSLRs7oy3y/VAxBqA=;
	b=iOQgIoOS6MNE5AoCAkHWB9G4sH1HUqNrseAIr0UHMHOFKgN7X/i+sSLh14ZYjJ2VfVFoVD
	xEnCZpOimSmqDL3bsXvjRAwCjcpL4t0fpM7v0+a7NpzQ42OVb5XKUPN4Pe1yuaQzlQg510
	9+GAiYGfjY4aRVJ8IhjdFc1qFraRZoin7df2vI6gb5P7s9bDaqDLapMAqTGaNHPabkP8jG
	9EDznjuSuLHv8D6U3BuOBiHgpe9P5VKhmdvy9UShqKWr+81MrlafvnKcCyxnZS7ekoFiTv
	AsIwPvDH6bnGLovC6E5hxc34cSXEfFiEBW/VvDrEK/Um/6t5hMDmGu+a5nYQnw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kbusch@kernel.org,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	p.raghav@samsung.com,
	linux-kernel@vger.kernel.org,
	hare@suse.de,
	willy@infradead.org,
	linux-mm@kvack.org,
	david@fromorbit.com
Subject: [RFC v2 07/14] readahead: allocate folios with mapping_min_order in ra_(unbounded|order)
Date: Tue, 13 Feb 2024 10:37:06 +0100
Message-ID: <20240213093713.1753368-8-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Allocate folios with at least mapping_min_order in
page_cache_ra_unbounded() and page_cache_ra_order() as we need to
guarantee a minimum order in the page cache.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/readahead.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 13b62cbd3b79..a361fba18674 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -214,6 +214,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	unsigned long i = 0;
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -235,6 +236,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 
 		if (folio && !xa_is_value(folio)) {
+			long nr_pages = folio_nr_pages(folio);
+
 			/*
 			 * Page already present?  Kick off the current batch
 			 * of contiguous pages before continuing with the
@@ -244,19 +247,31 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl);
-			ractl->_index += folio_nr_pages(folio);
+
+			/*
+			 * Move the ractl->_index by at least min_pages
+			 * if the folio got truncated to respect the
+			 * alignment constraint in the page cache.
+			 *
+			 */
+			if (mapping != folio->mapping)
+				nr_pages = min_nrpages;
+
+			VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
+			ractl->_index += nr_pages;
 			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 		if (filemap_add_folio(mapping, folio, index + i,
 					gfp_mask) < 0) {
 			folio_put(folio);
 			read_pages(ractl);
-			ractl->_index++;
+			ractl->_index += min_nrpages;
 			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
@@ -516,6 +531,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 {
 	struct address_space *mapping = ractl->mapping;
 	pgoff_t index = readahead_index(ractl);
+	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
 	int err = 0;
@@ -542,11 +558,17 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit)
+		while (order > min_order && index + (1UL << order) - 1 > limit)
 			order--;
 		/* THP machinery does not support order-1 */
 		if (order == 1)
 			order = 0;
+
+		if (order < min_order)
+			order = min_order;
+
+		VM_BUG_ON(index & ((1UL << order) - 1));
+
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
 			break;
-- 
2.43.0


