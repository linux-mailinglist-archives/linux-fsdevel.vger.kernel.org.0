Return-Path: <linux-fsdevel+bounces-12775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8959F867032
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0871C26F5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB269D1C;
	Mon, 26 Feb 2024 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="LK4xL/zq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18069306;
	Mon, 26 Feb 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941018; cv=none; b=qzCDis6ZyBgs0pHg8Jofcehbc/V7Bs+7SMFlRILoBNFMmvZvXCQ2y6Ta55IaKnnF9mLi1fEgwXB8FQ1ASLCz8bXj8TSlcQeJtnRoztEyZ1feSNUPWf+v1U/Xdzh4n1Juz1eoRmKZglXqFhXE8bB0biPeaphXSrmaPYeulSefJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941018; c=relaxed/simple;
	bh=gvzV2WcaeiNG86dtZhRmvW0cIHxaUjujdXE11HpU8fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vApBerklmE07S+WGx0qw+nD4zeoeM/N/mNxLub0SwA/Y6FG9DxlQsWbP51OBiilU7HGZkcp37kLlQ8W60/KH2/gIR/KkDmy/PIwbGBRfi1A2H5K43u5sZWnESpm5Y2kwZk7tClaL5zmGDGyc0EoNWXwn2A4bGrNVfAkapk1ra08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=LK4xL/zq; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Tjwp748Vjz9sp7;
	Mon, 26 Feb 2024 10:50:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708941007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iWtDtcsIIVhWdsgAPg59nbWoOxmbwnUSiPp0I9sy7c=;
	b=LK4xL/zqaOcK2C5cLdqWnyrsWrnOSrjd9JTjUKcDU36GVSLc7/PAhmIrSGgJHHPVt8jyaA
	CgAzmkvPxMIBSBLcmcHaWd47UtkpWFQwiVv9/6AbPdnMxLve7raB9+Dk0fDTKnmm9LKncR
	ofaxnSbT+9OLB0DXuaRe+tj1SBO/0HueXcK5qRpFENHtJ8B/WVgvHro2xe4XGQ1OM6o+cT
	9QBmPtxoMmp7aubJY+9oya4KZl1IXYuPch7eyw8l+I6AeRy0I0d//IH87DD6EgY948jKob
	VEkkuCR9FEEG3hCVfOsWiirFMc8BLEn1q7pwYRWY0o9sYRQnlRp1e5YWUsfuDg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	ziy@nvidia.com,
	hare@suse.de,
	djwong@kernel.org,
	gost.dev@samsung.com,
	linux-mm@kvack.org,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 06/13] readahead: align index to mapping_min_order in ondemand_ra and force_ra
Date: Mon, 26 Feb 2024 10:49:29 +0100
Message-ID: <20240226094936.2677493-7-kernel@pankajraghav.com>
In-Reply-To: <20240226094936.2677493-1-kernel@pankajraghav.com>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Tjwp748Vjz9sp7

From: Luis Chamberlain <mcgrof@kernel.org>

Align the ra->start and ra->size to mapping_min_order in
ondemand_readahead(), and align the index to mapping_min_order in
force_page_cache_ra(). This will ensure that the folios allocated for
readahead that are added to the page cache are aligned to
mapping_min_order.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8a610b78d94b..325a25e4ee3a 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -313,7 +313,9 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	struct file_ra_state *ra = ractl->ra;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	unsigned long max_pages, index;
+	unsigned long max_pages;
+	pgoff_t index, new_index;
+	unsigned long min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
 		return;
@@ -323,7 +325,14 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	 * be up to the optimal hardware IO size
 	 */
 	index = readahead_index(ractl);
+	new_index = mapping_align_start_index(mapping, index);
+	if (new_index != index) {
+		nr_to_read += index - new_index;
+		index = new_index;
+	}
+
 	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
+	max_pages = max_t(unsigned long, max_pages, min_nrpages);
 	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
 	while (nr_to_read) {
 		unsigned long this_chunk = (2 * 1024 * 1024) / PAGE_SIZE;
@@ -331,6 +340,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		ractl->_index = index;
+		VM_BUG_ON(!IS_ALIGNED(index, min_nrpages));
 		do_page_cache_ra(ractl, this_chunk, 0);
 
 		index += this_chunk;
@@ -557,8 +567,11 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	unsigned long add_pages;
 	pgoff_t index = readahead_index(ractl);
 	pgoff_t expected, prev_index;
-	unsigned int order = folio ? folio_order(folio) : 0;
+	unsigned int min_order = mapping_min_folio_order(ractl->mapping);
+	unsigned int min_nrpages = mapping_min_folio_nrpages(ractl->mapping);
+	unsigned int order = folio ? folio_order(folio) : min_order;
 
+	VM_BUG_ON(!IS_ALIGNED(index, min_nrpages));
 	/*
 	 * If the request exceeds the readahead window, allow the read to
 	 * be up to the optimal hardware IO size
@@ -580,7 +593,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 			1UL << order);
 	if (index == expected || index == (ra->start + ra->size)) {
 		ra->start += ra->size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		ra->size = max(get_next_ra_size(ra, max_pages), min_nrpages);
 		ra->async_size = ra->size;
 		goto readit;
 	}
@@ -605,7 +618,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 		ra->start = start;
 		ra->size = start - index;	/* old async_size */
 		ra->size += req_size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		ra->size = max(get_next_ra_size(ra, max_pages), min_nrpages);
 		ra->async_size = ra->size;
 		goto readit;
 	}
@@ -642,7 +655,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 
 initial_readahead:
 	ra->start = index;
-	ra->size = get_init_ra_size(req_size, max_pages);
+	ra->size = max(min_nrpages, get_init_ra_size(req_size, max_pages));
 	ra->async_size = ra->size > req_size ? ra->size - req_size : ra->size;
 
 readit:
@@ -653,7 +666,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * Take care of maximum IO pages as above.
 	 */
 	if (index == ra->start && ra->size == ra->async_size) {
-		add_pages = get_next_ra_size(ra, max_pages);
+		add_pages = max(get_next_ra_size(ra, max_pages), min_nrpages);
 		if (ra->size + add_pages <= max_pages) {
 			ra->async_size = add_pages;
 			ra->size += add_pages;
@@ -663,7 +676,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 		}
 	}
 
-	ractl->_index = ra->start;
+	ractl->_index = mapping_align_start_index(ractl->mapping, ra->start);
 	page_cache_ra_order(ractl, ra, order);
 }
 
-- 
2.43.0


