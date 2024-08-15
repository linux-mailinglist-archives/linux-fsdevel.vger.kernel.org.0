Return-Path: <linux-fsdevel+bounces-26037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2057F952BE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28821F23712
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37101BCA0B;
	Thu, 15 Aug 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="kDAMcgZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9AB1BDA9D;
	Thu, 15 Aug 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712984; cv=none; b=Ok/lXrF4H9/3fDKS4/LLbdfb6bwCBDrkZ4I7X7L9Y75/LuCcnvhfDchFSpXWHZXBQ4UBBgSFLit5LLqfh46BphZtxFv/sJDQ9BFpKsOWuP43/z+APKPjgNLCyXX9toS971LGuk0MrESwiSo7I3yHA5rC5CdqGLK2LCsW60ls76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712984; c=relaxed/simple;
	bh=2GhI+azvlVmJ+XNkvELFCX60TvrX+df0OCxGC4NRcjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILdmG15yUfpAgz4yx5kfmEhRH5IIpm2lRlL4/bi2vqS62f/AdHZ2kpVwyiGwtfTCjjBBOT3XAJN+noe4OEHdh78wCI/LdpK+l+6eRFViOeNeD/4Gq3X+ycuYz8sGRCdteg5ofnxYHRS8Hi8o0tZ55me+u/g6OJc7ca3sWJQYUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=kDAMcgZw; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WkzpT42Qbz9sWd;
	Thu, 15 Aug 2024 11:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723712977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D613TVQCptAW9VynAGuVSOK0s4oeJXQu1SypShzHmM4=;
	b=kDAMcgZweQ0Bnu/S+QiyFuf0x+LiYm8/+zNP/SNOMkulmMCghzRCdWiM9gDS39eTc1PUdN
	ROxyw1J3DTm7hSUB7YLwZAaVcv04gs/+2quOPaXWLj4x92lH7Uhc4D1hPtUFF0t38M1F7H
	FH14Zshstp4/00yVytPxrMlgOTpBd0zrXZp/DyHSgdueQZrmiQpx3PUQbf0e1fzoxaiwY/
	B7OPvZxCGTp+GgR6YisGSCCXmnw6Qr6TWS9kI1kqouF6LSASD1/TDdYWvZJyCUZh/gA3UP
	35GHOtJbIRHxs4Jykd16PlN9CB88JThH+BepMJ8LbEwdC2phQhCsnP3xx1bV0w==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: brauner@kernel.org,
	akpm@linux-foundation.org
Cc: chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org,
	djwong@kernel.org,
	hare@suse.de,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	john.g.garry@oracle.com,
	cl@os.amperecomputing.com,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	ryan.roberts@arm.com,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v12 07/10] xfs: use kvmalloc for xattr buffers
Date: Thu, 15 Aug 2024 11:08:46 +0200
Message-ID: <20240815090849.972355-8-kernel@pankajraghav.com>
In-Reply-To: <20240815090849.972355-1-kernel@pankajraghav.com>
References: <20240815090849.972355-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WkzpT42Qbz9sWd

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
index b9e98950eb3d8..09f4cb061a6e0 100644
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


