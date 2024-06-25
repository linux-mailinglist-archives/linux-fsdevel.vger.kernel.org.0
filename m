Return-Path: <linux-fsdevel+bounces-22331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97611916681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BD428A341
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978511607AC;
	Tue, 25 Jun 2024 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="kipkGJg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044A15ECE5;
	Tue, 25 Jun 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315898; cv=none; b=VzgotbUO/RIwElnUreaSWWRHw+19U6qmDejUKpZeG3q3qlsH+AwE2BSgdB/RrpcblSh7x0wnzvAUAFaHpST/SL44vrqgt3k/PVsg4UT6X76k8I2y8gVmzP2pN9223pERy4Fmr1utzZpNO5Hyxx6I9qUQnDbvELTwcvGHLFPiWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315898; c=relaxed/simple;
	bh=Sv9E3U1vrEuoSMMHMwfb5YdKHNu1CJKxciCkR7PpDe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrPrdNXuEWyzZoNdVzpeCbwyk6fkh9v+IaJqXNwxGpQoMAiT9W1RdkZk8D9o4QQ93r1ufv0Zv+s9BBOzqsfaDbxtGDv6AkvUOo21vFW6J2Ma4R/K1bkjaLsqyEGYEb0z+nFsHo3YNr0257Dp+X6H+OGUqyE3hEUVOOpA8g+xj58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=kipkGJg1; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W7jg86wgjz9sss;
	Tue, 25 Jun 2024 13:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719315893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZG/lL31K25//iaIAV7jBbt1MNjj987Sk8ll7Dxjdts=;
	b=kipkGJg13H64tB3xNiHrnDUQlknoj9SB5UwPL7W747iM43EClbh9mwGs/CrYevYpL7dwy5
	yCNI2/rrK1OKsdZopIkCOHXT0eQ6Cqxr9v6msmK6G6JfpTTj1qEENLSiThEgtM/qhXGYMX
	GaWME0bvdKddSrBN8BOmm6NEQdQb4JpLcTqhPcYf2UJjmDDA2Xp3FaeTfjicWVxjfRpSkH
	nGUAu9grTCZ5xhJqILNQJrmMUyBu58f462EuVQDsqJF1tezZUcNuXmDw0tb/2iO5yXZCA3
	qC/qL2yIXVEpw0zMc8ARKspky8n5jArAa6O92MNAB1BYNhkxgeYOBO/aixYVcw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	Zi Yan <zi.yan@sent.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v8 07/10] xfs: use kvmalloc for xattr buffers
Date: Tue, 25 Jun 2024 11:44:17 +0000
Message-ID: <20240625114420.719014-8-kernel@pankajraghav.com>
In-Reply-To: <20240625114420.719014-1-kernel@pankajraghav.com>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W7jg86wgjz9sss

From: Dave Chinner <dchinner@redhat.com>

Pankaj Raghav reported that when filesystem block size is larger
than page size, the xattr code can use kmalloc() for high order
allocations. This triggers a useless warning in the allocator as it
is a __GFP_NOFAIL allocation here:

static inline
struct page *rmqueue(struct zone *preferred_zone,
                        struct zone *zone, unsigned int order,
                        gfp_t gfp_flags, unsigned int alloc_flags,
                        int migratetype)
{
        struct page *page;

        /*
         * We most definitely don't want callers attempting to
         * allocate greater than order-1 page units with __GFP_NOFAIL.
         */
>>>>    WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
...

Fix this by changing all these call sites to use kvmalloc(), which
will strip the NOFAIL from the kmalloc attempt and if that fails
will do a __GFP_NOFAIL vmalloc().

This is not an issue that productions systems will see as
filesystems with block size > page size cannot be mounted by the
kernel; Pankaj is developing this functionality right now.

Reported-by: Pankaj Raghav <kernel@pankajraghav.com>
Fixes: f078d4ea8276 ("xfs: convert kmem_alloc() to kmalloc()")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index b9e98950eb3d..09f4cb061a6e 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1138,10 +1138,7 @@ xfs_attr3_leaf_to_shortform(
 
 	trace_xfs_attr_leaf_to_sf(args);
 
-	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
-	if (!tmpbuffer)
-		return -ENOMEM;
-
+	tmpbuffer = kvmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
 	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
 
 	leaf = (xfs_attr_leafblock_t *)tmpbuffer;
@@ -1205,7 +1202,7 @@ xfs_attr3_leaf_to_shortform(
 	error = 0;
 
 out:
-	kfree(tmpbuffer);
+	kvfree(tmpbuffer);
 	return error;
 }
 
@@ -1613,7 +1610,7 @@ xfs_attr3_leaf_compact(
 
 	trace_xfs_attr_leaf_compact(args);
 
-	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
+	tmpbuffer = kvmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
 	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
 	memset(bp->b_addr, 0, args->geo->blksize);
 	leaf_src = (xfs_attr_leafblock_t *)tmpbuffer;
@@ -1651,7 +1648,7 @@ xfs_attr3_leaf_compact(
 	 */
 	xfs_trans_log_buf(trans, bp, 0, args->geo->blksize - 1);
 
-	kfree(tmpbuffer);
+	kvfree(tmpbuffer);
 }
 
 /*
@@ -2330,7 +2327,7 @@ xfs_attr3_leaf_unbalance(
 		struct xfs_attr_leafblock *tmp_leaf;
 		struct xfs_attr3_icleaf_hdr tmphdr;
 
-		tmp_leaf = kzalloc(state->args->geo->blksize,
+		tmp_leaf = kvzalloc(state->args->geo->blksize,
 				GFP_KERNEL | __GFP_NOFAIL);
 
 		/*
@@ -2371,7 +2368,7 @@ xfs_attr3_leaf_unbalance(
 		}
 		memcpy(save_leaf, tmp_leaf, state->args->geo->blksize);
 		savehdr = tmphdr; /* struct copy */
-		kfree(tmp_leaf);
+		kvfree(tmp_leaf);
 	}
 
 	xfs_attr3_leaf_hdr_to_disk(state->args->geo, save_leaf, &savehdr);
-- 
2.44.1


