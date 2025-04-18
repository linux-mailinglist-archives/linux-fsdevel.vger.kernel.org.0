Return-Path: <linux-fsdevel+bounces-46655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F5DA92FBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 04:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FB316C7AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 02:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E52673B2;
	Fri, 18 Apr 2025 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ojM1hAs4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D63266F1B;
	Fri, 18 Apr 2025 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942100; cv=pass; b=XNhPgVBZNN9NEhV41FVl3IdUqqOww5iSwOBd3REC+X0Q6YKHkIVxwq1/VFVMWCOIwZhzAwcKFns/rYakoyWRU781XsoGng9pvxCeBcn7/G+rmRJL+UJIruYJ521wgYi0e5V87Tq9I5nQ3Jagoz5bxXvjC5YU/dU6pw6wz5PdQHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942100; c=relaxed/simple;
	bh=vcz9OUUPWUbPr1TN5zTl4x+JXmo0eA8S4HDdoyUGBPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W8ynSVMQLScW9PmhxDhB+qvoGCNk8TKhhKKi/ExQo+7Jk6KeyvHj/YAGb4XEn6omMg/+6zv38TEXsvLtNPv3vapJg0k0ptRMKNiXe7gU5Mu1aSwzxtEM4Zdmee9NNwmeBMHRUxZKwc2pBvXBoD+3i6K4t/8PNYhLAS5Df4WQYak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ojM1hAs4; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2AA9643A62;
	Fri, 18 Apr 2025 01:59:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (100-109-225-168.trex-nlb.outbound.svc.cluster.local [100.109.225.168])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B7F6343E8E;
	Fri, 18 Apr 2025 01:59:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744941579; a=rsa-sha256;
	cv=none;
	b=ns7YySgcYYnM8Kj9r8WBG/+jq+NUBrxn19NPA+MoKeR+9VM4j49HT5uLUSQpThCedSk4DM
	bJ1z/Q2crqPYVt3ONDhMiwMkfqj1En5xCZgJ0fq//gTIzD1zvqZwJF42tKxqVtYeJb64Pl
	ZAMpNm0nMP2zMu14RkMZOXB0c94c5H4OF9q6Ke1mxnk5OpnkmCPLI1mCORUUbLmNIrSQnm
	1vU6zysbz7Q0YDi2kcecw5aeRjl/adN73hWeMk0mVhOtR05b519waAaJiKuMzt/facjYYp
	87IkdL/XtwQ4U5htLUD1LZGaCQGw2XbwBib+BnwbnKYEMgjKce3C4x6A4hG3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744941579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mLuy4zj438a+1U7en1XTc2so8/rQx/UkGlXZZ4fu/o0=;
	b=5dFXA76JGdkkLY43IAR7iR52xYZ9W/2hOmYt6L4Znss36zGhTQnn8roHAA2YKmwE6DMf89
	Fj8ocyUz+gMZGUoOUW+tw97h1V7yLjx4UM2ce3O1vXUMCrCnpYVqWbiCnGRS6Yd2x+YCBZ
	ZdBtXGv5HXEFyt/cSAR4n9WqdeAn6KdgGhCBHU7xnsbocDHPx4LjaFT+niQMvYwwALm2HK
	7uTi/ZQMunH0saXX/Qzw7D+WNLHbB/aAxM/I4epcQFXiGSDC1zVRvO77Wc0+S7VfVkOcSM
	vVjJalJevndsJakSsjU7SDGUA091uVTahWPboMYWGO+bqVoOTpP2gmloNVCNNQ==
ARC-Authentication-Results: i=1;
	rspamd-7bd9ff6c58-xxcc2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Illustrious: 0fad6dd04f8ec142_1744941580073_3053416635
X-MC-Loop-Signature: 1744941580073:4085039856
X-MC-Ingress-Time: 1744941580073
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.225.168 (trex/7.0.3);
	Fri, 18 Apr 2025 01:59:40 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4Zdycp5xX7z88;
	Thu, 17 Apr 2025 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744941579;
	bh=mLuy4zj438a+1U7en1XTc2so8/rQx/UkGlXZZ4fu/o0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=ojM1hAs4QuyGMN5IMykmxoNDnE/XSho9YWg2f3+vjt9onDipMWmdlnrV9vBWEe+9D
	 Y4rzbAtGkyIvbHF1mBxxYraGhEG88LxouC7TxUjznQySZEbzHQpgLPWYol2FiQt6Ue
	 MOr7emUEtui7A/0wQEgdKQMsciO+SK6i0V4FWcXVGSXBIlKqC24NNmp7j34BnFPlFg
	 egX7k1DS97Bm+aA/D6ErzxSfg68rfpkHnY1IMMCiCRfURy726xm+HxldOadS4JfMB2
	 SwYG5xviqBpseVjKf0jrHIuY5BVKwAXfzk3nEKlrt4j4hVSDXRYMw0H4OcIS8TeRRc
	 BMjzIsk3itaNQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	brauner@kernel.org
Cc: mcgrof@kernel.org,
	willy@infradead.org,
	hare@suse.de,
	djwong@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	kernel test robot <oliver.sang@intel.com>,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: [PATCH 7/7] mm/migrate: fix sleep in atomic for large folios and buffer heads
Date: Thu, 17 Apr 2025 18:59:21 -0700
Message-Id: <20250418015921.132400-8-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250418015921.132400-1-dave@stgolabs.net>
References: <20250418015921.132400-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The large folio + buffer head noref migration scenarios are
being naughty and blocking while holding a spinlock.

As a consequence of the pagecache lookup path taking the
folio lock this serializes against migration paths, so
they can wait for each other. For the private_lock
atomic case, a new BH_Migrate flag is introduced which
enables the lookup to bail.

This allows the critical region of the private_lock on
the migration path to be reduced to the way it was before
ebdf4de5642fb6 ("mm: migrate: fix reference  check race
between __find_get_block() and migration"), that is covering
the count checks.

The scope is always noref migration.

Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/oe-lkp/202503101536.27099c77-lkp@intel.com
Fixes: 3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")
Reviewed-by: Jan Kara <jack@suse.cz>
Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c                 | 12 +++++++++++-
 fs/ext4/ialloc.c            |  3 ++-
 include/linux/buffer_head.h |  1 +
 mm/migrate.c                |  8 +++++---
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f8c9e5eb4685..7be23ff20b27 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -207,6 +207,15 @@ __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
 	head = folio_buffers(folio);
 	if (!head)
 		goto out_unlock;
+	/*
+	 * Upon a noref migration, the folio lock serializes here;
+	 * otherwise bail.
+	 */
+	if (test_bit_acquire(BH_Migrate, &head->b_state)) {
+		WARN_ON(!atomic);
+		goto out_unlock;
+	}
+
 	bh = head;
 	do {
 		if (!buffer_mapped(bh))
@@ -1390,7 +1399,8 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 /*
  * Perform a pagecache lookup for the matching buffer.  If it's there, refresh
  * it in the LRU and mark it as accessed.  If it is not present then return
- * NULL
+ * NULL. Atomic context callers may also return NULL if the buffer is being
+ * migrated; similarly the page is not marked accessed either.
  */
 static struct buffer_head *
 find_get_block_common(struct block_device *bdev, sector_t block,
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 38bc8d74f4cc..e7ecc7c8a729 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -691,7 +691,8 @@ static int recently_deleted(struct super_block *sb, ext4_group_t group, int ino)
 	if (!bh || !buffer_uptodate(bh))
 		/*
 		 * If the block is not in the buffer cache, then it
-		 * must have been written out.
+		 * must have been written out, or, most unlikely, is
+		 * being migrated - false failure should be OK here.
 		 */
 		goto out;
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index c791aa9a08da..0029ff880e27 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -34,6 +34,7 @@ enum bh_state_bits {
 	BH_Meta,	/* Buffer contains metadata */
 	BH_Prio,	/* Buffer should be submitted with REQ_PRIO */
 	BH_Defer_Completion, /* Defer AIO completion to workqueue */
+	BH_Migrate,     /* Buffer is being migrated (norefs) */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
diff --git a/mm/migrate.c b/mm/migrate.c
index f3ee6d8d5e2e..676d9cfc7059 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -845,9 +845,11 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		return -EAGAIN;
 
 	if (check_refs) {
-		bool busy;
+		bool busy, migrating;
 		bool invalidated = false;
 
+		migrating = test_and_set_bit_lock(BH_Migrate, &head->b_state);
+		VM_WARN_ON_ONCE(migrating);
 recheck_buffers:
 		busy = false;
 		spin_lock(&mapping->i_private_lock);
@@ -859,12 +861,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 			}
 			bh = bh->b_this_page;
 		} while (bh != head);
+		spin_unlock(&mapping->i_private_lock);
 		if (busy) {
 			if (invalidated) {
 				rc = -EAGAIN;
 				goto unlock_buffers;
 			}
-			spin_unlock(&mapping->i_private_lock);
 			invalidate_bh_lrus();
 			invalidated = true;
 			goto recheck_buffers;
@@ -883,7 +885,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 
 unlock_buffers:
 	if (check_refs)
-		spin_unlock(&mapping->i_private_lock);
+		clear_bit_unlock(BH_Migrate, &head->b_state);
 	bh = head;
 	do {
 		unlock_buffer(bh);
-- 
2.39.5


