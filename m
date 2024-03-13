Return-Path: <linux-fsdevel+bounces-14304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AEA87AF12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7D2285F45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2478E60878;
	Wed, 13 Mar 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="iLuEZtwu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C2197F12;
	Wed, 13 Mar 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349401; cv=none; b=OnBkhMRzSYFUw+q0JUdOM/L2F1mjChOnLxCP3nLdueSur2uYVAZ8YrxsNh4QwQqTYxhS96rtb6GrmtpcrFVshm7By1/x4SblZMpBL/GXOfeVUnsCjT5sz/K0yoTukuW66IrWx4xD2Ub0/A8Scw7QzntSRNs9UBlv8ZPYxoCLipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349401; c=relaxed/simple;
	bh=SVxRi94L1loycCE1JyBsDivfSbS/LPTvG3kVbz3Q9S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TA/KEVSaKjNzD05FzcyXrEIoxse+ZRnudEgq8Jqbm6B771YFvBTU3Tc7FPC7oirQ5GjRMgReTclFKfdWlFpKTu36B6Fh2x9g/RGdJ3Wb1skpqglo4zbF0h0k6/VNDKpaC4x4g55RZPjMqXI05xF7YLjoJ9xMbTzkmro1qcdfZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=iLuEZtwu; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TvxfX4xPNz9sv2;
	Wed, 13 Mar 2024 18:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710349396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlktHRrCotj7h+dmYranbD+6rKP22De/aSKpvLU15xI=;
	b=iLuEZtwukGR8j/wP2yTR5lqu8w1dn1Om8H+h1Jrn/yb2Op1vTScowf81qXdWfFwhx03M/k
	lQ/ljugRNgFKv69Zpc6GDcMiFT9VCHupZ6ValiBdiFfuWsmov6aNUmcQiDMialZfyaybui
	8T59W5m15KIJ0u/Ty4jAsUYT9GrTgDUpkTktfRWjiysbyXYSygMpuhFGLRtvAF3XUnEXNb
	PjoKw2atBz6K73ROKH0xNo9tEt25+B4heTtlXX02+5MGRYL4KHK5fIQB8ASFf3iPeRzqLB
	qWHeD/50YVeH/RmWQXjuSiVGmXs3wQCjp0KP/PxP8pUf+qiTnxODf+IHoVquZQ==
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
Subject: [PATCH v3 04/11] readahead: rework loop in page_cache_ra_unbounded()
Date: Wed, 13 Mar 2024 18:02:46 +0100
Message-ID: <20240313170253.2324812-5-kernel@pankajraghav.com>
In-Reply-To: <20240313170253.2324812-1-kernel@pankajraghav.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TvxfX4xPNz9sv2

From: Hannes Reinecke <hare@suse.de>

Rework the loop in page_cache_ra_unbounded() to advance with
the number of pages in a folio instead of just one page at a time.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 mm/readahead.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 369c70e2be42..37b938f4b54f 100644
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
2.43.0


