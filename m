Return-Path: <linux-fsdevel+bounces-46525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD35DA8AC3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 01:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337AC1903924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 23:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1262D92C1;
	Tue, 15 Apr 2025 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Kj0RJwy1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FFF28F532;
	Tue, 15 Apr 2025 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759978; cv=pass; b=V2pQj/niZTNgoEaBnJ+tB63SMj3P/mx5TZiYi1wF0a4NL0aIfNgHHDMJQO62bOLqa5Y/k96dnGaZYmt3GOlFfYQDDiz5g0QLZrdOC1nbRgWdj5eyue7e9SCCLRo0b/AyA+T1mmIObnkbpInIenedgW8h0JzAiaILjZY8YuOe/5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759978; c=relaxed/simple;
	bh=/3d6UuyViHZlf+yrsq8UV8yVwOKcdPWulDarLIeea54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKdQRvXGvypr5cJAjFTFHzSJt3S8iaXSqA9gPmObeRyZWBOFj152l+IdUkNwP6ChUdxVwt3ROJrb/MsjacHcT/ZPYpwvB6XPuTylwTZFy57esa9Avc1exgkWW8XShsDlcnJ9uJjarNRqkvqPGB0T/mV3256CW3timLcQ598UovQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Kj0RJwy1; arc=pass smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 291318A3920;
	Tue, 15 Apr 2025 23:16:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (trex-4.trex.outbound.svc.cluster.local [100.109.60.75])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B953C8A37B9;
	Tue, 15 Apr 2025 23:16:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744759003; a=rsa-sha256;
	cv=none;
	b=E8q9AoP16/bQrOSIysV6vFRwf2hwlPb+gpx4QjTzLDEASMsII0oXTaHaO3DqZj9mPmNMKp
	pw8gJxmwDRjpxW0q/rSo6uh6LYGcD1BRDbF68uvdpwsWiihAadWaDQpB+SyFlL7UdpwCzG
	AThbaUjVDbJSr41KXjSm29PZGy4OVin36tST+By4VoGqR+cstQXBc3fBD5Hy/Jrc/bD3h6
	3KWZ6InKARWkuAsgE0quf0vX5I/KGkbhHQk8VQSEa5GPHY7WgYEUBszjcyFszRcQkmxA9y
	h2ny6lSbxlMSAa1ao7On0tvuEVtfcv0mID/pPNRnYzEbV7OizBEGYOIZvJznkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744759003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JHAbDv9/MPvL4PxZXFpm47ZYR2SHKjfrJhea+dpq7dE=;
	b=XYGWqfuOzpmW1v3Hf4Y1goMr4pfqD+cNF0i+Fdb+jy8k1fG2je4gP7q5FP1i4DGxsmp5b4
	3gzxF4bmhrYkm8/6fKkMZzYCkFjkS4AkOe9Az649mqetAxusYJ5GYcZdubDAqAl2bEQumN
	HDeRXfD+HJrorQsEVKY+3d1sCI7igAGn5xCmrTCjhSe6xez7pCTDPDYnhWlMAJ4dQDPBJt
	x17zn4QhrME+khADI5WP11eXLx2M5DTaLcqMXosxu3SNA1mrCAhYBZwOPtPNF58mNWFGW5
	lBa69SlNKnaI9XfDGPU2zVwDl/VTsobiEWE2lTOKbkEvzx0ndC9lC3DnPlgi9A==
ARC-Authentication-Results: i=1;
	rspamd-5dd7f8b4cd-4m6r4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trade-Trouble: 70ffde75512becb1_1744759004055_3358966167
X-MC-Loop-Signature: 1744759004055:1312116752
X-MC-Ingress-Time: 1744759004055
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.60.75 (trex/7.0.3);
	Tue, 15 Apr 2025 23:16:44 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Zcg5k6RFrz2Y;
	Tue, 15 Apr 2025 16:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744759003;
	bh=JHAbDv9/MPvL4PxZXFpm47ZYR2SHKjfrJhea+dpq7dE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Kj0RJwy1xI6A26/9JRzYZ/SPJxCVIPwxFkYWCE+3zKwbTUhV9Min7a+cJxHe3DKjm
	 VHDkCbHhsRggnKKiq6Gelr8UzT+XDZGyeCVmpH8XNH/VvYBusKTWhtaXXNqPFptjjC
	 VpCoVbMglaH7lUEJv581uzd2CIgKZvK13COe2fKcph7iw8guMayFX9i60Fcm0fw6h8
	 zxSfWdM0oD1y1T5Ia7R4ylOf6/Fh3g5uqBFgqUyUCoTX9m5irIVLo0Ma7Ty0NwBdom
	 5f+NNPwnwCRnPcTEOTi19doW605M0FLe8nwQumORVXyW/+PH4W2A7i7f7u7BukFOqJ
	 CSuzi8SNSgmIA==
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
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 1/7] fs/buffer: split locking for pagecache lookups
Date: Tue, 15 Apr 2025 16:16:29 -0700
Message-Id: <20250415231635.83960-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250415231635.83960-1-dave@stgolabs.net>
References: <20250415231635.83960-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of __find_get_block() may or may not allow for blocking
semantics, and is currently assumed that it will not. Layout
two paths based on this. The the private_lock scheme will
continued to be used for atomic contexts. Otherwise take the
folio lock instead, which protects the buffers, such as
vs migration and try_to_free_buffers().

Per the "hack idea", the latter can alleviate contention on
the private_lock for bdev mappings. For reasons of determinism
and avoid making bugs hard to reproduce, the trylocking is not
attempted.

No change in semantics. All lookup users still take the spinlock.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b99dc69dba37..c72ebff1b3f0 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -176,18 +176,8 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 }
 EXPORT_SYMBOL(end_buffer_write_sync);
 
-/*
- * Various filesystems appear to want __find_get_block to be non-blocking.
- * But it's the page lock which protects the buffers.  To get around this,
- * we get exclusion from try_to_free_buffers with the blockdev mapping's
- * i_private_lock.
- *
- * Hack idea: for the blockdev mapping, i_private_lock contention
- * may be quite high.  This code could TryLock the page, and if that
- * succeeds, there is no need to take i_private_lock.
- */
 static struct buffer_head *
-__find_get_block_slow(struct block_device *bdev, sector_t block)
+__find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
 {
 	struct address_space *bd_mapping = bdev->bd_mapping;
 	const int blkbits = bd_mapping->host->i_blkbits;
@@ -204,7 +194,16 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	if (IS_ERR(folio))
 		goto out;
 
-	spin_lock(&bd_mapping->i_private_lock);
+	/*
+	 * Folio lock protects the buffers. Callers that cannot block
+	 * will fallback to serializing vs try_to_free_buffers() via
+	 * the i_private_lock.
+	 */
+	if (atomic)
+		spin_lock(&bd_mapping->i_private_lock);
+	else
+		folio_lock(folio);
+
 	head = folio_buffers(folio);
 	if (!head)
 		goto out_unlock;
@@ -236,7 +235,10 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 		       1 << blkbits);
 	}
 out_unlock:
-	spin_unlock(&bd_mapping->i_private_lock);
+	if (atomic)
+		spin_unlock(&bd_mapping->i_private_lock);
+	else
+		folio_unlock(folio);
 	folio_put(folio);
 out:
 	return ret;
@@ -1388,14 +1390,15 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
  * it in the LRU and mark it as accessed.  If it is not present then return
  * NULL
  */
-struct buffer_head *
-__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
+static struct buffer_head *
+find_get_block_common(struct block_device *bdev, sector_t block,
+			unsigned size, bool atomic)
 {
 	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
 
 	if (bh == NULL) {
 		/* __find_get_block_slow will mark the page accessed */
-		bh = __find_get_block_slow(bdev, block);
+		bh = __find_get_block_slow(bdev, block, atomic);
 		if (bh)
 			bh_lru_install(bh);
 	} else
@@ -1403,6 +1406,12 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 
 	return bh;
 }
+
+struct buffer_head *
+__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
+{
+	return find_get_block_common(bdev, block, size, true);
+}
 EXPORT_SYMBOL(__find_get_block);
 
 /**
-- 
2.39.5


