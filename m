Return-Path: <linux-fsdevel+bounces-17738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246008B206B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B6C1C22FEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A1B12BF14;
	Thu, 25 Apr 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="cQcJGDBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB512AAE8;
	Thu, 25 Apr 2024 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045087; cv=none; b=iKlwQpllIw+ZNYDUXshhA1ln0YArN9L9g7fVCKc3s7PCa7Z4nAUcGxdTVpJ73PjIIqvKRkFwVMRqGflld8c+inribQkS3KW1iEkSrEZHTb1kRjN5O9F3SS4peGfQ76IZd/urQ1etqbepFSQljJIVIzF15WhsiB0OnAK6Oq2Y0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045087; c=relaxed/simple;
	bh=dAb52hpNjJqYCkHB6e1HLiI7yzESYqD4M929IAgDDoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5KmBE2T6Ph/g5o2EA3WLNbZoH1fviB9inESCB4fZNaSccaRqdFNG034aWaXFpSqNn+O2HpEdIR298WMtQrgrNop00eb6s04x3/bpms7Jt8Esjzp0twEWuBgalZZntR5ZbTQJHnk9NXyXW/bW/5jU1KQEhW6Mdn2IzOPnzV0N1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=cQcJGDBL; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VQDPJ23mVz9sPv;
	Thu, 25 Apr 2024 13:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714045076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fe/EkxT/4tbsQ0E/aktsfNPPVKoCmEm9S5NSTYBj3tk=;
	b=cQcJGDBLAl1dtJxy2kvDsF3al40H5eNmF+KJhBHUl9EJFN42VOJQ+eT0kKwRT7JcFsKb93
	X650sGma4M8zKkqAEZvRZSU/z8fEza1NcUiq8h6r+Lw2TlOS/Al7Uxk92R+ziwxPd8KTFr
	8GwuqK1plMMpyev89NoAiITarFI/PiKOaT5bsa4J8u4QrCVuK/6Db1KadTwqtE7ZGCU69j
	SEkRtAo4DoUk3WNvBQgnHOsP+o/CSH7V/HAZ1szftyz1TLk8iQuaVgBdm524Lhsrr4fBuD
	hDmfrjD8Lai7/Ufz7ZtNtkaGft4Ejr4EMY/v2vMTfonhZKN0sPYlHF5tSw8ctg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: [PATCH v4 01/11] readahead: rework loop in page_cache_ra_unbounded()
Date: Thu, 25 Apr 2024 13:37:36 +0200
Message-Id: <20240425113746.335530-2-kernel@pankajraghav.com>
In-Reply-To: <20240425113746.335530-1-kernel@pankajraghav.com>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

Rework the loop in page_cache_ra_unbounded() to advance with
the number of pages in a folio instead of just one page at a time.

Note that the index is incremented by 1 if filemap_add_folio() fails
because the size of the folio we are trying to add is 1 (order 0).

Signed-off-by: Hannes Reinecke <hare@suse.de>
Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 mm/readahead.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 130c0e7df99f..2361634a84fd 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -208,7 +208,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long i;
+	unsigned long i = 0;
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -226,7 +226,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	for (i = 0; i < nr_to_read; i++) {
+	while (i < nr_to_read) {
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 
 		if (folio && !xa_is_value(folio)) {
@@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl);
-			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			ractl->_index += folio_nr_pages(folio);
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 
@@ -252,13 +252,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			folio_put(folio);
 			read_pages(ractl);
 			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 		if (i == nr_to_read - lookahead_size)
 			folio_set_readahead(folio);
 		ractl->_workingset |= folio_test_workingset(folio);
-		ractl->_nr_pages++;
+		ractl->_nr_pages += folio_nr_pages(folio);
+		i += folio_nr_pages(folio);
 	}
 
 	/*
-- 
2.34.1


