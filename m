Return-Path: <linux-fsdevel+bounces-46654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F91A92FB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 04:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B4A170059
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 02:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B8267398;
	Fri, 18 Apr 2025 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="p1xyuGdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958F267383;
	Fri, 18 Apr 2025 02:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942099; cv=pass; b=RCF1s6Jf4GJvxo+o9rtEv+hjaHQRSDtX2ykjnG9jAEn5f13Lhh01+icRFTr55EIbjRZCi2F0l+AYoGfu7kfhFElECVieiaxTNPfhJ30LtrO/z/7WaTLSriF+rbkLma/tA9CI4BeYYo+eSFZCIWJC2DNl6AAlrld7IZPUJLE72ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942099; c=relaxed/simple;
	bh=qFVUR1E/2/5PQt69+ghAsaDqdOPGz0m4+DMcpcnOe4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvR85Gego7mTDQpN6CopOCA2W+JCUqv6zUrFeeZI8au8duIpJy/PNexzTzGgSiIz7SWOmEFwfdN6Ogr6ShBGumJT+OKrxyQggAv7tCQolINgfx2qX0TKSgVIBpTaCCtC4FRCb4NYhTR8NKl2/ObYBs7ALVAgpKTzM12WkzNPjW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=p1xyuGdf; arc=pass smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DA7C04E3E21;
	Fri, 18 Apr 2025 01:59:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (100-107-95-229.trex-nlb.outbound.svc.cluster.local [100.107.95.229])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 76E904E3C8C;
	Fri, 18 Apr 2025 01:59:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744941574; a=rsa-sha256;
	cv=none;
	b=nTINgWWCpNRS6h4rQ+hDdWix5ieHLh2YvkU/HGmrRHhrLXnmmFZYLGoAKqREEQLf6NlqEo
	IzGtcgb2AnszYccBiRaabLwBIwo7+lMSPD3JJ5wICmwx/PiSzTOuJ+5o4y51QKPJuAJpkX
	KKIZXiOJwxomBWoCnIbE9vXkCbEElRWRtxp9iAhedw/AtxYHXrFD3P8ChDcfUVXY/gZU06
	kQj0eWMmb2Ziic72MAVTxz1tOeT6r4jhxkFEa/LNf11beexjbvymPWznMDidxHEb3vcAlm
	AQKslS6e9CGQIS2daqtl5icWh5OFYhmfhYgRXpoflG0yiZTpA/Vi35hA7hrMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744941574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=l0OkMrrCNfiNSUNqllJ63trdw8uvDJBD9sB7Chep1qQ=;
	b=4D5orQYmCxpExXLwDca3eoowuwJ5J7hePJCnS6NJ7850Xdly79QCPLRnrjnpcQo8i+RAFw
	OoMYQQUncr+AJoKJvYGbQmClNFpFF4ZRwe3qJ1GEzg7HWtFu2x133WRCWQwsgTLQ9hECGy
	3XyoweS1nFZbrx4O1vtDjBOfalspQ/FkZ6GuFv35y22WCHvmEN9m9JlQL/uX7FndLspiRO
	XjjYrgIZF9n9eq3iP3bPXe8Z1LJil829bqpCxwTrHD1vRBcibyx2Bc/PkHOH1twekBw3NF
	/6K0m97KKSmHZvSxArWSieBCHyoG2CsQlb7SaYIpJluIPoPCxSItWlFZ4meL+w==
ARC-Authentication-Results: i=1;
	rspamd-7bd9ff6c58-mj7hx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Broad-White: 7d820e6c16f23b4a_1744941574795_2082964327
X-MC-Loop-Signature: 1744941574795:136927829
X-MC-Ingress-Time: 1744941574795
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.95.229 (trex/7.0.3);
	Fri, 18 Apr 2025 01:59:34 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4Zdycj3m31zC4;
	Thu, 17 Apr 2025 18:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744941574;
	bh=l0OkMrrCNfiNSUNqllJ63trdw8uvDJBD9sB7Chep1qQ=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=p1xyuGdfjY+kIZiUDVQxbDoSeumqeD6CRGZS5xt8zFdXGLyWeymMlwNP2bcj49nSW
	 SRsKRijsknB7yuhD91VoidYVvK5Pd4U3BBlR6uxo1nLW76h+jtKoK2j9kJsZlRIqXU
	 QnjWjkTfEWWLLTIQyz9nMXvH6bDSgkKDTT85dGUeAb9SPZ3D49XBTWYQnuSWyCwr1N
	 oaUKT6pKiNEliKnxRCD2Mdc7nnhNcM/aA3L8ETWJpgAnN3cbSfNddVgxTMqPbNdOpz
	 Glib8yBke2/A1WzVVrmTlaUBvp7vEgQ5gCvGpoIy9wfqFonA3uxgDH0RfC2B1ETaKE
	 q96Ib+xiJLoHw==
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
Date: Thu, 17 Apr 2025 18:59:15 -0700
Message-Id: <20250418015921.132400-2-dave@stgolabs.net>
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

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c7abb4a029dc..f8fcffdbe5d9 100644
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


