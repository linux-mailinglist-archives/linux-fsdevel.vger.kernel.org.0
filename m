Return-Path: <linux-fsdevel+bounces-13308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 335B386E635
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D894B28637
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6F871B40;
	Fri,  1 Mar 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="sy87xrj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126F3F9D3;
	Fri,  1 Mar 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311514; cv=none; b=nTLO+hkHRzi+lkZyuq46VX1fRERGelf1mq/bawYUWL2jVTY1EbvwGJDxDP/XTvBs6R4xeKupiQGfHNCH/A45ZUY2etpfnvz9YV3tgpsGJ84n0yforOUBe8T9aCLWxsBvay4LkB7hy9XJZB26m2YCqpz6yqLwxAaWe73oLNzMnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311514; c=relaxed/simple;
	bh=4QswKuIX45E3NH0Y6dDvf2DoGTpuEd8QlFE/EkV33k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGi7gwNHHNOYMyv1KEBVzGMfba8E6x5jNGNa2TE3aDD53NyAJFJu5aMrUXsKrTrwHDLRAIPIh7HBN5h2u6oX8+gVKgbjoV6YkcoA4yxJ5n6CcMTK+wh3mZ88xofQX2UWfoRoCoHqlCczZB2t/8Wud0raO8cS+KR0CReMapNnHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=sy87xrj0; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TmYq94WM6z9t2l;
	Fri,  1 Mar 2024 17:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709311509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyszdUSBCFtEWqaMFYCTrgSY4YVZLc+Vs7TuxxQjQl4=;
	b=sy87xrj0yXtold9KEo0HbYK8U8fwRqeLzMnk/2gqJnegYhfzQ3WYLFoP+gKh5jVg1lArg7
	fdvBQ/UZr6BWq1qkEe8pVninsVe5DywCu19kITPvxIcx9Vack4ssHwRyzuRaD6lB1jC7BQ
	uTbBKafIzaN4RXOHoJ1rzeP6f4AufeVRjLDYHxKwlvj43YJ6QFoKnvZ+64+iUVUOvlm/8e
	cWxdREnG6S6nfRUGvJWdO0s95pIgZWmt7I76Q/tgXIulymt3CuLsbAF7hA1QD8/PNc/0PC
	sqv72BLNDr5q3jgNBxoz2RpihfmZAFSOIg0/3k52B5oukRPUxhIRfIEheiIRow==
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
Subject: [PATCH v2 06/13] readahead: align index to mapping_min_order in ondemand_ra and force_ra
Date: Fri,  1 Mar 2024 17:44:37 +0100
Message-ID: <20240301164444.3799288-7-kernel@pankajraghav.com>
In-Reply-To: <20240301164444.3799288-1-kernel@pankajraghav.com>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TmYq94WM6z9t2l

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
index 6336c1736cc9..0197cb91cf85 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -310,7 +310,9 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	struct file_ra_state *ra = ractl->ra;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	unsigned long max_pages, index;
+	unsigned long max_pages;
+	pgoff_t index, new_index;
+	unsigned long min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
 		return;
@@ -320,7 +322,14 @@ void force_page_cache_ra(struct readahead_control *ractl,
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
@@ -328,6 +337,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		ractl->_index = index;
+		VM_BUG_ON(!IS_ALIGNED(index, min_nrpages));
 		do_page_cache_ra(ractl, this_chunk, 0);
 
 		index += this_chunk;
@@ -554,8 +564,11 @@ static void ondemand_readahead(struct readahead_control *ractl,
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
@@ -577,7 +590,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 			1UL << order);
 	if (index == expected || index == (ra->start + ra->size)) {
 		ra->start += ra->size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		ra->size = max(get_next_ra_size(ra, max_pages), min_nrpages);
 		ra->async_size = ra->size;
 		goto readit;
 	}
@@ -602,7 +615,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 		ra->start = start;
 		ra->size = start - index;	/* old async_size */
 		ra->size += req_size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		ra->size = max(get_next_ra_size(ra, max_pages), min_nrpages);
 		ra->async_size = ra->size;
 		goto readit;
 	}
@@ -639,7 +652,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 
 initial_readahead:
 	ra->start = index;
-	ra->size = get_init_ra_size(req_size, max_pages);
+	ra->size = max(min_nrpages, get_init_ra_size(req_size, max_pages));
 	ra->async_size = ra->size > req_size ? ra->size - req_size : ra->size;
 
 readit:
@@ -650,7 +663,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * Take care of maximum IO pages as above.
 	 */
 	if (index == ra->start && ra->size == ra->async_size) {
-		add_pages = get_next_ra_size(ra, max_pages);
+		add_pages = max(get_next_ra_size(ra, max_pages), min_nrpages);
 		if (ra->size + add_pages <= max_pages) {
 			ra->async_size = add_pages;
 			ra->size += add_pages;
@@ -660,7 +673,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 		}
 	}
 
-	ractl->_index = ra->start;
+	ractl->_index = mapping_align_start_index(ractl->mapping, ra->start);
 	page_cache_ra_order(ractl, ra, order);
 }
 
-- 
2.43.0


