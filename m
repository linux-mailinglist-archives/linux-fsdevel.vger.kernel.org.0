Return-Path: <linux-fsdevel+bounces-75416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFiNDTL0dmkzZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:57:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D47EF84102
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F01304C050
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 04:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BC130E0F2;
	Mon, 26 Jan 2026 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HaN/7K18"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8713AA2F;
	Mon, 26 Jan 2026 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769403215; cv=none; b=R/0nroTaGlOvp3K8lV6luJ1vBBLeqRSJaoaE4QU4W23ktFAIo3VDMwCTgyPbD62Lz5zSHyuCVbcG5r2boHAEkhSUPSvO+xXwdOof4sdnj+knc70QxrW7PHgEZVUwsKB1nMEwVUOGV/TEgHQaCyP8hsuSbpdGfUfHJNXewyvW53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769403215; c=relaxed/simple;
	bh=Ds7nQElTciKCoBuzFNRFLEVQvdWROZXdIw9DY82rvBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv1JOrimSo/zHWQ0pmkmmfbxZMIUFaEIukrVHWyMiyXH6MbNIfCM+J233iFpmBjT+ysVfQNImsEOow4tJcJJtnxVYTe883Xu7g21jKugyHnxW1BIe5bwvQqIrEITSyk8azcwmWG/KPxNctv0iMTujj67wCvLsukAhuIqA/k3IbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HaN/7K18; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Uz7fpZnjUlMd/aGr9OL/OJaWWyGR47o6Wopw3Zb7zdM=; b=HaN/7K18H5UcWW9LjTxQe7V5ZE
	L8zQ5P5ZzK50LdGM5MpuShnnX+exrcEA8UyaICyDMA4HbWj4EEVnsAPq7PH3R8vRyibNZ54jBlqFj
	9ZtNxAHNWyDZLlUsW0+SVWIQ4mHBk0ko7AIsHCsJ4M4vZbFBvxSl6dDQ9YBfmB6PUliFOvbbpF5UK
	8dpAuiXRlM4GgY+NjeXVludsvP49/Eg0bw0w8wkzxnA86h3ibKFJk8rtarZZNdV5b0EOTMK5DQQdc
	oM6iMGdNMarSGsbrOXlaYdRSgJcnZ4oK5x2bkhGVpLbdjLgdlOvjHY3TCl0sf1bHBENGqSqkV4CiU
	3Maxk5DA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEbU-0000000BuTu-0kqU;
	Mon, 26 Jan 2026 04:53:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 12/16] fs: consolidate fsverity_info lookup in buffer.c
Date: Mon, 26 Jan 2026 05:50:58 +0100
Message-ID: <20260126045212.1381843-13-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126045212.1381843-1-hch@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75416-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D47EF84102
X-Rspamd-Action: no action

Look up the fsverity_info once in end_buffer_async_read_io, and then
pass it along to the I/O completion workqueue in
struct postprocess_bh_ctx.

This amortizes the lookup better once it becomes less efficient.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 3982253b6805..f4b3297ef1b1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -302,6 +302,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 struct postprocess_bh_ctx {
 	struct work_struct work;
 	struct buffer_head *bh;
+	struct fsverity_info *vi;
 };
 
 static void verify_bh(struct work_struct *work)
@@ -309,25 +310,14 @@ static void verify_bh(struct work_struct *work)
 	struct postprocess_bh_ctx *ctx =
 		container_of(work, struct postprocess_bh_ctx, work);
 	struct buffer_head *bh = ctx->bh;
-	struct inode *inode = bh->b_folio->mapping->host;
 	bool valid;
 
-	valid = fsverity_verify_blocks(*fsverity_info_addr(inode), bh->b_folio,
-				       bh->b_size, bh_offset(bh));
+	valid = fsverity_verify_blocks(ctx->vi, bh->b_folio, bh->b_size,
+				       bh_offset(bh));
 	end_buffer_async_read(bh, valid);
 	kfree(ctx);
 }
 
-static bool need_fsverity(struct buffer_head *bh)
-{
-	struct folio *folio = bh->b_folio;
-	struct inode *inode = folio->mapping->host;
-
-	return fsverity_active(inode) &&
-		/* needed by ext4 */
-		folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
-}
-
 static void decrypt_bh(struct work_struct *work)
 {
 	struct postprocess_bh_ctx *ctx =
@@ -337,7 +327,7 @@ static void decrypt_bh(struct work_struct *work)
 
 	err = fscrypt_decrypt_pagecache_blocks(bh->b_folio, bh->b_size,
 					       bh_offset(bh));
-	if (err == 0 && need_fsverity(bh)) {
+	if (err == 0 && ctx->vi) {
 		/*
 		 * We use different work queues for decryption and for verity
 		 * because verity may require reading metadata pages that need
@@ -359,15 +349,20 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
 {
 	struct inode *inode = bh->b_folio->mapping->host;
 	bool decrypt = fscrypt_inode_uses_fs_layer_crypto(inode);
-	bool verify = need_fsverity(bh);
+	struct fsverity_info *vi = NULL;
+
+	/* needed by ext4 */
+	if (bh->b_folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
+		vi = fsverity_get_info(inode);
 
 	/* Decrypt (with fscrypt) and/or verify (with fsverity) if needed. */
-	if (uptodate && (decrypt || verify)) {
+	if (uptodate && (decrypt || vi)) {
 		struct postprocess_bh_ctx *ctx =
 			kmalloc(sizeof(*ctx), GFP_ATOMIC);
 
 		if (ctx) {
 			ctx->bh = bh;
+			ctx->vi = vi;
 			if (decrypt) {
 				INIT_WORK(&ctx->work, decrypt_bh);
 				fscrypt_enqueue_decrypt_work(&ctx->work);
-- 
2.47.3


