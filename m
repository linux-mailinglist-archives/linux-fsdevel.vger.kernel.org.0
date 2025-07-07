Return-Path: <linux-fsdevel+bounces-54131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC91FAFB62B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACA1188A086
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B5C2D8766;
	Mon,  7 Jul 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="a4rIafs7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69542BDC2C;
	Mon,  7 Jul 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898847; cv=none; b=eRO/GltdNfK9FiAJmeVtsjWIiZfxui01qEytqkb+4NJoJWFGALBJmq5F3P9GfAWUuU7D5zLfU2mGon5KMEy9WsEiWD0+g843GaKWlwEmxk/wZyGfd9lHenGKg+ql42p3AeaHCM8oaXS567L0XzDIhUcy3E9fqCh5ct47/dXyhrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898847; c=relaxed/simple;
	bh=HfEBjhDybxA/lCndKha/gf5kwENN2tgin7s12uZ7/gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjKuGXCedRBDpTQIwxDuWG06JRtqHIry3GcxXqr6+nY5nIK9wXbWFRWRVBnc3r4jHLp37lpi7/utWogQmR3+5aod4PO82X3ZR9hIoQWdKo9a8gBFKVbqOJSM5uycB5u+l0bfCHWft3A4mUef2vJmAq70wK7o0MyUXz5QrPEy8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=a4rIafs7; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bbRLn36V0z9sqV;
	Mon,  7 Jul 2025 16:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1751898241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24KDo3KRXZxzAB+MpsSNoPOtleVCAJRJx+y6hk41NC4=;
	b=a4rIafs7ejMCL/CNvTdRuBlYOowXAqIKjXtP4LS8rmCWE0hVIYMqBPxATAFWTzPY7eKHhY
	vOZHuibUJbYTQF5RkUjg95/WDGjODG+LS2eqsuQTluKkzxuNuGgFY4JdPIusFIDrranKjQ
	+Flk3LB7JQlfmkzTS8eQkssBRm22SB28a+4UNq+HVGloMpqEQrg84FH5bJu/xRCLtcMQMQ
	EES7IR7CXKkDkdUeuygNJ7xJ/LWFp9gvhxgm9lO0YIYFIPDEqZvXY7zXpBqHVScIJMQBEK
	UKInRCqeEpexdwcfpcP1KLRuPlsBXssNB4gpHZpZRpM/92Mill8wrk8sY7dRFg==
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
Subject: [PATCH v2 5/5] block: use largest_zero_folio in __blkdev_issue_zero_pages()
Date: Mon,  7 Jul 2025 16:23:19 +0200
Message-ID: <20250707142319.319642-6-kernel@pankajraghav.com>
In-Reply-To: <20250707142319.319642-1-kernel@pankajraghav.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bbRLn36V0z9sqV

From: Pankaj Raghav <p.raghav@samsung.com>

Use largest_zero_folio() in __blkdev_issue_zero_pages().

On systems with CONFIG_STATIC_PMD_ZERO_PAGE enabled, we will end up
sending larger bvecs instead of multiple small ones.

Noticed a 4% increase in performance on a commercial NVMe SSD which does
not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
gains might be bigger if the device supports bigger MDTS.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-lib.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4c9f20a689f7..70a5700b6717 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -196,6 +196,10 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned int flags)
 {
+	struct folio *zero_folio;
+
+	zero_folio = largest_zero_folio();
+
 	while (nr_sects) {
 		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
 		struct bio *bio;
@@ -208,15 +212,14 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
 			break;
 
 		do {
-			unsigned int len, added;
+			unsigned int len;
 
-			len = min_t(sector_t,
-				PAGE_SIZE, nr_sects << SECTOR_SHIFT);
-			added = bio_add_page(bio, ZERO_PAGE(0), len, 0);
-			if (added < len)
+			len = min_t(sector_t, folio_size(zero_folio),
+				    nr_sects << SECTOR_SHIFT);
+			if (!bio_add_folio(bio, zero_folio, len, 0))
 				break;
-			nr_sects -= added >> SECTOR_SHIFT;
-			sector += added >> SECTOR_SHIFT;
+			nr_sects -= len >> SECTOR_SHIFT;
+			sector += len >> SECTOR_SHIFT;
 		} while (nr_sects);
 
 		*biop = bio_chain_and_submit(*biop, bio);
-- 
2.49.0


