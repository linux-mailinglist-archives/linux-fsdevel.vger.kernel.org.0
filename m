Return-Path: <linux-fsdevel+bounces-12781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9009B867113
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16521B2C607
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2991E77A0F;
	Mon, 26 Feb 2024 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="r/dmaeu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B347690B;
	Mon, 26 Feb 2024 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941042; cv=none; b=NXM6GG0I8Focl6WL78ekSDS6vuGz5fwKRDTSs1vUi7hg+RLJJwT0cLxV/sVEfHbqYZSZHFMvVVAydTcJq1goAmc9a4mN8HtNIock61kbjZBk+CBF3mC6fuchRLfGEaCcLUDexqirRsCnog9+Qit57HT/qOT2HAHTMSV1FT9Aapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941042; c=relaxed/simple;
	bh=Y9b2xLAZqzX+pdH+yrlRg/WTNLCOOaokY7gPgj+Co8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afjdAfqD1s/N1d0wocJyl7sZ2jzlty8LMHd8hijW/0v+Hw/rAqcUVnQLXb4d8uaRddpV/gnR1DfAv0azdQb5lw1POD9hPTKH+o4pFg0Aw4YcRE9nCfbWieufBAKUDzflxRSWHod7T/fQwrv5XN4ZNZVFO2nzoMQ0zYOtiWmNXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=r/dmaeu8; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Tjwpj3Lszz9sd1;
	Mon, 26 Feb 2024 10:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708941037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxspCYGvd47S6sMZqiF8IxyiXSLrdsbW3Rzpn1A8oVs=;
	b=r/dmaeu8ky0Zitwk6d/p71mCATrvYsjhMj+pqGiiXKmkR/JFZzQ4UzKBr1JYGDYt7Xmey+
	4YlsyGLVY0JeTsSAfX9QD8ohDznFOefXqdL91rLdcOIA0b1DC1jKooTiTD8P0N5Otpz96p
	FcEQHn9pTyCODOwN1oCWuNkBxQtVNSDXAYq2A1Cb7+uZg+SFwRAQhVuH+UxnnR2HHXDPnr
	lu6+d5f2UIJPqHRvfkqMvtKaGXc4xWYIrcigS98zQJZKP+4F+ZO7iCuF7Us0aVsFsSJ5W/
	fzYF/GIvrVQbR8vvaMZ1Xxgb/Yz13ovRc4iCTJuTdI+c/VrA577/Qf+r01F9TQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	ziy@nvidia.com,
	hare@suse.de,
	djwong@kernel.org,
	gost.dev@samsung.com,
	linux-mm@kvack.org,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 13/13] xfs: enable block size larger than page size support
Date: Mon, 26 Feb 2024 10:49:36 +0100
Message-ID: <20240226094936.2677493-14-kernel@pankajraghav.com>
In-Reply-To: <20240226094936.2677493-1-kernel@pankajraghav.com>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Tjwpj3Lszz9sd1

From: Pankaj Raghav <p.raghav@samsung.com>

Page cache now has the ability to have a minimum order when allocating
a folio which is a prerequisite to add support for block size > page
size.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
 fs/xfs/libxfs/xfs_shared.h |  3 +++
 fs/xfs/xfs_icache.c        |  6 ++++--
 fs/xfs/xfs_mount.c         |  1 -
 fs/xfs/xfs_super.c         | 10 ++--------
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 2361a22035b0..c040bd6271fd 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -2892,6 +2892,11 @@ xfs_ialloc_setup_geometry(
 		igeo->ialloc_align = mp->m_dalign;
 	else
 		igeo->ialloc_align = 0;
+
+	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
+		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
+	else
+		igeo->min_folio_order = 0;
 }
 
 /* Compute the location of the root directory inode that is laid out by mkfs. */
diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
index 4220d3584c1b..67ed406e7a81 100644
--- a/fs/xfs/libxfs/xfs_shared.h
+++ b/fs/xfs/libxfs/xfs_shared.h
@@ -188,6 +188,9 @@ struct xfs_ino_geometry {
 	/* precomputed value for di_flags2 */
 	uint64_t	new_diflags2;
 
+	/* minimum folio order of a page cache allocation */
+	unsigned int	min_folio_order;
+
 };
 
 #endif /* __XFS_SHARED_H__ */
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index dba514a2c84d..a1857000e2cd 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -88,7 +88,8 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
-	mapping_set_large_folios(VFS_I(ip)->i_mapping);
+	mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
+				    M_IGEO(mp)->min_folio_order);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -323,7 +324,8 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	mapping_set_large_folios(inode->i_mapping);
+	mapping_set_folio_min_order(inode->i_mapping,
+				    M_IGEO(mp)->min_folio_order);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 69af3b06be99..c7df1857195c 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -131,7 +131,6 @@ xfs_sb_validate_fsb_count(
 	xfs_sb_t	*sbp,
 	uint64_t	nblocks)
 {
-	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
 	uint64_t mapping_count;
 	uint64_t bytes;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5a2512d20bd0..685ce7bf7324 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1625,16 +1625,10 @@ xfs_fs_fill_super(
 		goto out_free_sb;
 	}
 
-	/*
-	 * Until this is fixed only page-sized or smaller data blocks work.
-	 */
 	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
 		xfs_warn(mp,
-		"File system with blocksize %d bytes. "
-		"Only pagesize (%ld) or less will currently work.",
-				mp->m_sb.sb_blocksize, PAGE_SIZE);
-		error = -ENOSYS;
-		goto out_free_sb;
+"EXPERIMENTAL: Filesystem with Large Block Size (%d bytes) enabled.",
+			mp->m_sb.sb_blocksize);
 	}
 
 	/* Ensure this filesystem fits in the page cache limits */
-- 
2.43.0


